/* dmx_test.c
 *
 */

#include <sys/socket.h>
#include <netinet/in.h>

#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <ftdi.h>


#define DMX_MAB 160    // Mark After Break 8 uS or more
#define DMX_BREAK 110  // Break 88 uS or more

#define DMX_CHANNELS 512
#define BAUD_RATE 250000

#define UDP_PORT 37211


struct ftdi_context ftdic;

//typedef unsigned char dmx_t;
//dmx_t dmx[DMX_CHANNELS + 1];

#pragma pack(1)
struct dmx_t {
    unsigned char head;
    unsigned char body[DMX_CHANNELS];
};

struct dmx_t dmx;

static int dmx_init(struct ftdi_context* ftdic)
{
    int ret;

    if (ftdi_init(ftdic) < 0)
    {
        fprintf(stderr, "ftdi_init failed\n");
        return EXIT_FAILURE;
    }

    if ((ret = ftdi_usb_open(ftdic, 0x0403, 0x6001)) < 0)
    {
        fprintf(stderr, "unable to open ftdi device: %d (%s)\n", ret, ftdi_get_error_string(ftdic));
        return EXIT_FAILURE;
    }

    if ((ret = ftdi_set_baudrate(ftdic, BAUD_RATE)) < 0)
    {
        fprintf(stderr, "unable to set baudrate: %d (%s)\n", ret, ftdi_get_error_string(ftdic));
        return EXIT_FAILURE;
    }

    if ((ret = ftdi_set_line_property(ftdic, BITS_8, STOP_BIT_2, NONE)) < 0)
    {
        fprintf(stderr, "unable to set line property: %d (%s)\n", ret, ftdi_get_error_string(ftdic));
        return EXIT_FAILURE;
    }

    if ((ret = ftdi_setflowctrl(ftdic, SIO_DISABLE_FLOW_CTRL)) < 0)
    {
        fprintf(stderr, "unable to set flow control: %d (%s)\n", ret, ftdi_get_error_string(ftdic));
        return EXIT_FAILURE;
    }
    return EXIT_SUCCESS;
}



static int do_dmx_break(struct ftdi_context* ftdic)
{
    int ret;
    
    if ((ret = ftdi_set_line_property2(ftdic, BITS_8, STOP_BIT_2, NONE, BREAK_ON)) < 0)
    {
        fprintf(stderr, "unable to set BREAK ON: %d (%s)\n", ret, ftdi_get_error_string(ftdic));
        return EXIT_FAILURE;
    }
    usleep(DMX_BREAK);
    if ((ret = ftdi_set_line_property2(ftdic, BITS_8, STOP_BIT_2, NONE, BREAK_OFF)) < 0)
    {
        fprintf(stderr, "unable to set BREAK OFF: %d (%s)\n", ret, ftdi_get_error_string(ftdic));
        return EXIT_FAILURE;
    }
    usleep(DMX_MAB);
    return EXIT_SUCCESS;
}


static int dmx_write(struct ftdi_context* ftdic, struct dmx_t dmx, size_t size)
{
    int ret;

    if ((ret = do_dmx_break(ftdic)) == EXIT_SUCCESS)
    {
        unsigned char *dmx_packet = (unsigned char *)&dmx;
        if ((ret = ftdi_write_data(ftdic, dmx_packet, size)) < 0)
        {
            fprintf(stderr, "unable to write data: %d (%s)\n", ret, ftdi_get_error_string(ftdic));
            ret = EXIT_FAILURE;
        }
    }
    return ret;
}


static int universe_set(struct dmx_t dmx, size_t size)
{
    int ret = EXIT_FAILURE;

    if ((do_dmx_break(&ftdic) == EXIT_SUCCESS) && (dmx_write(&ftdic, dmx, size) == EXIT_SUCCESS))
    {
        ret = EXIT_SUCCESS;
    }
    return ret;
}


static int dmx_shutdown()
{
    ftdi_usb_close(&ftdic);
    ftdi_deinit(&ftdic);
    return EXIT_SUCCESS;
}




int main(int argc, char **argv)
{

    // initialize DMX
    if (EXIT_FAILURE == dmx_init(&ftdic))
    {
        fprintf(stderr, "unable to init dmx\n");
        return EXIT_FAILURE;
    }

    // initialize universe
    memset(&dmx, 0, sizeof(dmx));

    // initialize UDP server
    int sockfd, n;
    struct sockaddr_in servaddr, cliaddr;
    socklen_t len;

    if ( (sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0)
    {
        fprintf(stderr, "error %d creating socket: %s\n", errno, strerror(errno));
        dmx_shutdown();
        return EXIT_FAILURE;
    }

    bzero(&servaddr, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
    servaddr.sin_port = htons(UDP_PORT);

    if (bind(sockfd,(struct sockaddr *)&servaddr, sizeof(servaddr)) < 0)
    {
        fprintf(stderr, "error %d binding server address to socket: %s\n", errno, strerror(errno));
        dmx_shutdown();
        return EXIT_FAILURE;
    }

    fprintf(stdout, "initialized DMX hardware and network service. Listening to UDP connections at port %d\n", UDP_PORT);

    for (;;)
    {
      len = sizeof(cliaddr);
      n = recvfrom(sockfd, dmx.body, sizeof(dmx.body), 0, (struct sockaddr *)&cliaddr, &len);
      fprintf(stdout, "Received %d bytes:\n", n);
      universe_set(dmx, sizeof(dmx));
      usleep(4*DMX_CHANNELS);
    }

   // dmx[1] = 1;
   // dmx[4] = 1;
   // dmx[8] = 1;
   // dmx[12] = 1;

    dmx_shutdown();
    exit (0);
}
