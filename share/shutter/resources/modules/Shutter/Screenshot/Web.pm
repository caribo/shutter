###################################################
#
#  Copyright (C) 2008, 2009 Mario Kemper <mario.kemper@googlemail.com> and Shutter Team
#
#  This file is part of Shutter.
#
#  Shutter is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3 of the License, or
#  (at your option) any later version.
#
#  Shutter is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with Shutter; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
###################################################

package Shutter::Screenshot::Web;

#modules
#--------------------------------------
use utf8;
use strict;
use warnings;

use Shutter::Screenshot::History;

#Glib
use Glib qw/TRUE FALSE/; 

#--------------------------------------

sub new {
	my $class = shift;
	
	my $self = {
				 _timeout 		=> shift,
				 _format  		=> shift,
				 _width			=> shift,
				 _url  			=> shift,
				 _dest_filename => shift,
			   };
	
	bless $self, $class;
	return $self;
}

#~ sub DESTROY {
    #~ my $self = shift;
    #~ print "$self dying at\n";
#~ } 

sub web {
	my $self = shift;
	
	system("gnome-web-photo --timeout=$self->{_timeout} --mode=photo --format=$self->{_format} --width=$self->{_width} '$self->{_url}' '$self->{_dest_filename}'");
	
	return TRUE;
}

1;
