#!/usr/bin/perl
package Config;

=pod
A simple class for config file process
  my $cfg = Config->init('configfile')
		Config->new()
	    new Config('configname')
  
  $cfg->get
  $cfg->set
  $cfg->update
  $cfg->verify
  $cfg->interact
  
Config File like:

[section]
key = value

[section]
key = value

=cut

use IO::File;

sub init {
    my ( $class, $cfgfile ) = @_;

    # FIXME: ensure tmp.cfg is there
    $cfgfile = 'tmp.cfg' unless $cfgfile;
    my $self = bless {}, $class;
    $self->{'cfgfile'}  = $cfgfile;
    $self->{'settings'} = {};
    return $self;
}

sub new {
    &init;
}

sub get_cfgfile {
    my $self = shift;
    return $self->{'cfgfile'};
}

sub set_cfgfile {
    my $self    = shift;
    my $cfgfile = shift;
    $self->{'cfgfile'} = $cfgfile;
}

# setup the config from file.
sub read {
    my $self     = shift;
    my $fd       = IO::File->new("+>$self->{'cfgfile'}");
    my $section  = '';
    my $settings = ();
    while (<$fd>) {
	chomp($_);    # no newline
	s/#.*//;      # no comments
	s/^\s+//;     # no leading white
	s/\s+$//;     # no trailing white
	next unless length;    # anything left?
			       # section processing
	if (/\[(\w+)\]/) {
	    if ( exists $settings->{$1} ) {
		$section = $1;
		next;
	    } else {
		print("Error: Invalid config key [$1].\n");
		return ();
	    }
	}
	my ( $var, $value ) = split( /\s*=\s*/, $_, 2 );
	unless ( defined $value ) {
	    $value = '';
	}
	$value =~ s/^"+//;
	$value =~ s/"+$//;
	$value =~ s/^'+//;
	$value =~ s/'+$//;

	if ( exists $settings->{$section}{$var} ) {
	    $settings->{$section}{$var} = $value;
	} else {
	    print("Error: Invalid config key $var.\n");
	    return ();
	}

    }
    $fd->close;
    $self->{'settings'} = \%settings;
}

# write the settings to file
sub write {

}

sub get {
    my ( $self, $section, $key ) = @_;
    if($key){
	# get value of a key
	
	
    }else{
	# just get a section
    }

}

sub get_all {
    my $self = shift;
    return $self->{'settings'};
}

sub set {

}

sub verify {

}

sub interact {

}

1;
