use warnings;
use strict;
# source: http://cpansearch.perl.org/src/COOK/Device-SerialPort-1.000002/SerialPort.pm
use Device::SerialPort;
use Time::HiRes qw(usleep);
use Data::Dumper;

# ftdi application notes: http://www.ftdichip.com/Support/Documents/AppNotes.htm
# ftdi constants usage example: http://selector-theater.googlecode.com/svn-history/r23/trunk/SelectorDevice/DeviceExch.cs
use constant
{
    DMX_SERIAL_DEVICE   => '/dev/ttyU0',
    BREAK_PULSE_MS      => 250,
    DEFAULT_COLORS      => ['010000', '000100', '000001', '010100'],
    FIXTURES            => [0, 3, 7, 11], #fixtures' start addresses
};

my $dmx = &init_port();
my @data_frame = (0)x512;

my $colors = @ARGV? \@ARGV : DEFAULT_COLORS;

# assign colors to fixtures
my $fxt = FIXTURES;
my ($c, $r, $g, $b);
foreach my $fx ( @{$fxt} )
{
    last unless $c = shift @{$colors};
    (undef, $r, undef, $g, undef, $b) = split(/(\w\w)/, $c);
    @data_frame[$fx .. $fx+2] = (hex($r), hex($g), hex($b));
}


&send_frame($dmx, \@data_frame);
usleep(BREAK_PULSE_MS*1000);

END 
{
    $dmx->close() || warn "close failed.";
    undef $dmx;
}


sub init_port()
{
    my $dmx = new Device::SerialPort (DMX_SERIAL_DEVICE, undef)
              || die "Can't open " . DMX_SERIAL_DEVICE . ": $!\n";

    $dmx->debug(1);
    $dmx->handshake('none');
    $dmx->baudrate(230400);
    $dmx->parity('none');
    $dmx->databits(8);
    $dmx->stopbits(2);
    $dmx->write_settings();

    $dmx->user_msg(1);
    $dmx->error_msg(1);
    $dmx->lookclear();

    $dmx->rts_active(0);
    return $dmx;
}


sub send_frame($$)
{
    my ($dmx, $frame) = @_;
    $dmx->pulse_break_on(BREAK_PULSE_MS);
    if (1 == $dmx->write(pack('C', 0)))
    {
        my $count_out = $dmx->write(pack('C*', @{$frame}));
        warn "$count_out characters written.";
    }
    else
    {
        warn "can't write start code.";
    }
}
