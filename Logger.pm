#!/usr/bin/perl
package Logger;
=pod
A simple class for logger
  my $log = Logger->init('logname')
	    Logger->new()
            new Logger('logname')
  
  $log->get_logfile
  $log->set_logfile
  $log->msg
  $log->debug
  $log->warn
  $log->error	
=cut
use IO::File;

sub init {
    my ( $class, $logfile ) = @_;
    $logfile = 'tmp.log' unless $logfile;
    my $self = bless {}, $class;
    $self->{'logfile'} = $logfile;
    return $self;
}

sub new {
    &init;
}

sub get_logfile {
    my $self = shift;
    return $self->{'logfile'};
}

sub set_logfile {
    my $self    = shift;
    my $logfile = shift;
    $self->{'logfile'} = $logfile;
}

sub write {
    my ( $self, $msg ) = @_;
    my (
	$second,  $minute,    $hour,      $dayofmonth, $month,
	$yearoff, $dayofweek, $dayofyear, $dst
    ) = localtime();

    $yearoff = $yearoff + 1900;
    $month   = $month + 1;

    my $info = sprintf( "\[%04d/%02d/%02d-%02d:%02d:%02d\]:",
	$yearoff, $month, $dayofmonth, $hour, $minute, $second );

    $info .= $msg;
    my $fd = IO::File->new(">>$self->{logfile}") or die "Open user config file failed\n";;
    print $fd "$info\n";
    $fd->autoflush(1);
    $fd->close;
}

sub msg {
    my ( $self, $msg ) = @_;
    my $info = "INFO: " . $msg;
    $self->write($info);
}

sub debug {
    my ( $self, $msg ) = @_;
    my $info = "DEBUG: " . $msg;
    $self->write($info);
}

sub warn {
    my ( $self, $msg ) = @_;
    my $info = "WARN: " . $msg;
    $self->write($info);
}

sub error {
    my ( $self, $msg ) = @_;
    my $info = "ERROR: " . $msg;
    $self->write($info);
}

1;
