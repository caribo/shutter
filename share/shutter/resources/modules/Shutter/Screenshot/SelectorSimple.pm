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

package Shutter::Screenshot::SelectorSimple;

#modules
#--------------------------------------
use SelfLoader;
use utf8;
use strict;
use warnings;

use Gnome2::Canvas;
use Shutter::Screenshot::Main;
use Data::Dumper;
our @ISA = qw(Shutter::Screenshot::Main);

#define constants
#--------------------------------------
use constant TRUE  => 1;
use constant FALSE => 0;

#--------------------------------------

sub new {
	my $class = shift;

	#call constructor of super class (shutter_common, include_cursor, delay, notify_timeout)
	my $self = $class->SUPER::new( shift, shift, shift, shift );

	#subclass attributes
	$self->{_zoom_size_factor} = shift;
	$self->{_zoom_active}      = shift;
	$self->{_hide_time}		   = shift;   #a short timeout to give the server a chance to redraw the area that was obscured	

	bless $self, $class;
	return $self;
}

#~ sub DESTROY {
    #~ my $self = shift;
    #~ print "$self dying at\n";
#~ } 

1;

__DATA__

sub select_simple {
	my $self = shift;

	#return value
	my $output = 5;

	#define zoom window
	my $zoom_window = Gtk2::Window->new('toplevel');
	$zoom_window->set_type_hint('dock');
	$zoom_window->set_decorated(FALSE);
	$zoom_window->set_skip_taskbar_hint(TRUE);
	$zoom_window->set_skip_pager_hint(TRUE);	
	$zoom_window->set_keep_above(TRUE);
	
	#check pos and geometry of the zoom window and move it if needed
	my ( $zw, $zh ) = $zoom_window->get_size;
	my ( $zx, $zy ) = $zoom_window->get_position;

	#pack canvas to a scrolled window
	my $scwin = Gtk2::ScrolledWindow->new();
	$scwin->set_size_request( 100 * $self->{_zoom_size_factor}, 100 * $self->{_zoom_size_factor} );
	$scwin->set_policy( 'never', 'never' );

	#define and setup the canvas
	my $canvas = Gnome2::Canvas->new();
	$canvas->modify_bg( 'normal', Gtk2::Gdk::Color->new( 65535, 65535, 65535 ) );
	$canvas->set_pixels_per_unit(5);
	$canvas->set_scroll_region(
		-10 * $self->{_zoom_size_factor},
		-10 * $self->{_zoom_size_factor},
		$self->{_root}->{w} + 50 * $self->{_zoom_size_factor},
		$self->{_root}->{h} + 50 * $self->{_zoom_size_factor}
	);
	my $canvas_root = $canvas->root();
	$scwin->add($canvas);
	my $xlabel    = Gtk2::Label->new("X: ");
	my $ylabel    = Gtk2::Label->new("Y: ");
	my $rect      = Gtk2::Label->new("0 x 0");
	my $zoom_vbox = Gtk2::VBox->new;
	$zoom_vbox->pack_start_defaults($scwin);
	$zoom_vbox->pack_start_defaults($xlabel);
	$zoom_vbox->pack_start_defaults($ylabel);
	$zoom_vbox->pack_start_defaults($rect);

	#do some packing
	$zoom_window->add($zoom_vbox);
	$zoom_window->move( $self->{_root}->{x}, $self->{_root}->{y} );
	
	#define shutter cursor
	my $shutter_cursor_pixbuf = Gtk2::Gdk::Pixbuf->new_from_file(
		$self->{_sc}->get_root . "/share/shutter/resources/icons/shutter_cursor.png" );
	my $shutter_cursor = Gtk2::Gdk::Cursor->new_from_pixbuf( Gtk2::Gdk::Display->get_default,
		$shutter_cursor_pixbuf, 10, 10 );	
	
	#create root...
	my $root_item = Gnome2::Canvas::Item->new(
		$canvas_root,
		"Gnome2::Canvas::Pixbuf",
		x      => 0,
		y      => 0,
		pixbuf => Gtk2::Gdk::Pixbuf->get_from_drawable(
			$self->{_root}, undef, 0, 0, 0, 0,
			$self->{_root}->{w},
			$self->{_root}->{h}
		),
	);

	#...and cursor icon
	my $cursor_item = Gnome2::Canvas::Item->new(
		$canvas_root,
		"Gnome2::Canvas::Pixbuf",
		x      => 0,
		y      => 0,
		pixbuf => $shutter_cursor_pixbuf,
	);

	#define graphics context
	my $gc = Gtk2::Gdk::GC->new( $self->{_root}, undef );
	$gc->set_line_attributes( 1, 'double-dash', 'butt', 'round' );
	$gc->set_rgb_bg_color(Gtk2::Gdk::Color->new( 0, 0, 0));
	$gc->set_rgb_fg_color(Gtk2::Gdk::Color->new( 65535, 65535, 65535 ));
	$gc->set_subwindow('include-inferiors');
	$gc->set_function('xor');
	$gc->set_exposures(FALSE);
	$gc->set_fill('stippled');	

	#all screen events are send to shutter
	my $grab_counter = 0;
	while ( !Gtk2::Gdk->pointer_is_grabbed && $grab_counter < 400 ) {
		Gtk2::Gdk->pointer_grab(
			$self->{_root},
			0,
			[   qw/
					pointer-motion-mask
					button-press-mask
					button1-motion-mask
					button-release-mask/
			],
			undef,
			$shutter_cursor,
			Gtk2->get_current_event_time
		);
		Gtk2::Gdk->keyboard_grab( $self->{_root}, 1, Gtk2->get_current_event_time );
		$grab_counter++;
	}

	if ( Gtk2::Gdk->pointer_is_grabbed ) {
		
		my ( $rx, $ry, $rw, $rh, $rect_x, $rect_y, $rect_w, $rect_h ) = ( 0, 0, 0, 0, 0, 0, 0, 0 );
		my $btn_pressed = 0;
		my $drawable	= undef;
		
		Gtk2::Gdk::Event->handler_set(
			sub {
				my ( $event, $data ) = @_;
				return FALSE unless defined $event;

				#quit on escape
				if ( $event->type eq 'key-press' ) {
					if ( $event->keyval == $Gtk2::Gdk::Keysyms{Escape} ) {
						if ( $rect_w > 1 ) {
							#clear the last rectangle
							$self->{_root}->draw_rectangle( $gc, 0, $rect_x, $rect_y, $rect_w, $rect_h );
						}
						
						$self->quit($zoom_window);

					}
					
				#take screenshot when button is released	
				} elsif ( $event->type eq 'button-release' ) {
					print "Type: " . $event->type . "\n"
						if ( defined $event && $self->{_debug_cparam} );
					
					#selection valid?
					if ( $rect_w > 1 ) {

						#clear the last rectangle
						$self->{_root}
							->draw_rectangle( $gc, 0, $rect_x, $rect_y, $rect_w, $rect_h );
						Gtk2::Gdk->flush;

						#hide zoom_window and disable Event Handler
						$zoom_window->hide;
						$self->ungrab_pointer_and_keyboard( FALSE, TRUE, FALSE );
						
						#A short timeout to give the server a chance to
						#redraw the area that was obscured by our zoom window
						Glib::Timeout->add ($self->{_hide_time}, sub{
							($output) = $self->get_pixbuf_from_drawable( $self->{_root}, $rect_x+1, $rect_y+1, $rect_w-1, $rect_h-1);
							
							#we don't have a useful string for wildcards (e.g. $name)
							my $d = $self->{_sc}->get_gettext;
							if($output =~ /Gtk2/){
								$output->{'name'} = $d->get("Selection");
							}
							
							$self->quit($zoom_window);
							return FALSE;	
						});	
						
					#return error	
					} else {
						$output = 0;
						$self->quit($zoom_window);
					}
					
				} elsif ( $event->type eq 'button-press' ) {
					print "Type: " . $event->type . "\n"
						if ( defined $event && $self->{_debug_cparam} );
					
					$btn_pressed = 1;

					#rectangle starts here...
					$rx = $event->x;
					$ry = $event->y;
					
				} elsif ( $event->type eq 'motion-notify' ) {
					print "Type: " . $event->type . "\n"
						if ( defined $event && $self->{_debug_cparam} );
					
					#update label in zoom_window
					$xlabel->set_text( "X: " . $event->x );
					$ylabel->set_text( "Y: " . $event->y );

					if($self->{_zoom_active}){
						#check pos and geometry of the zoom window and move it if needed
						( $zw, $zh ) = $zoom_window->get_size;
						( $zx, $zy ) = $zoom_window->get_position;
		
						my $sregion = undef;
						if ( $rect_w > 1 ) {
							$sregion = Gtk2::Gdk::Region->rectangle (Gtk2::Gdk::Rectangle->new ($rect_x - 150, $rect_y - 150, $rect_x + $rect_w + 150, $rect_y + $rect_h + 150));
						}else{
							$sregion = Gtk2::Gdk::Region->rectangle (Gtk2::Gdk::Rectangle->new ($event->x - 150, $event->y - 150, 150, 150));						
						}
					
						my $otype = $sregion->rect_in(Gtk2::Gdk::Rectangle->new ($zx - 150, $zy - 150, $zx + $zw + 150, $zy + $zh + 150));					
						if($otype eq 'in' || $otype eq 'part' || !$zoom_window->visible){
											
							my $moved = FALSE;
							#possible positions if we need to move the zoom window
							my @pos = (
								Gtk2::Gdk::Rectangle->new ($self->{_root}->{x}, $self->{_root}->{y}, 0, 0),
								Gtk2::Gdk::Rectangle->new (0, $self->{_root}->{h} - $zh, 0, 0),
								Gtk2::Gdk::Rectangle->new ($self->{_root}->{w} - $zw, $self->{_root}->{y}, 0, 0),
								Gtk2::Gdk::Rectangle->new ($self->{_root}->{w} - $zw, $self->{_root}->{h} - $zh, 0, 0)
							);

							foreach(@pos){
								
								my $otypet = $sregion->rect_in(Gtk2::Gdk::Rectangle->new ($_->x - 150, $_->y - 150, $_->x + $zw + 150, $_->y + $zh + 150));					
								if($otypet eq 'out'){
									$zoom_window->move($_->x, $_->y);
									$zoom_window->show_all;
									$moved = TRUE;
									last;
								}
							
							}
							
							#if window could not be moved without covering the selection area
							unless ($moved) {
								$moved = FALSE;
								$zoom_window->hide_all;
							}
						
						}
				
						#move cursor on the canvas...
						$cursor_item->set(
							x      => $event->x - 10,
							y      => $event->y - 10,
						);

						#...scroll to centered position (*5 because of zoom factor)
						$canvas->scroll_to( $event->x * 5, $event->y * 5 );
					}
		
					if ($btn_pressed) {

						#redraw last rect to clear it
						if ( $rect_w > 0 ) {
							print
								"Trying to clear a rectangle ($rect_x, $rect_y, $rect_w, $rect_h)\n"
								if $self->{_debug_cparam};

							$self->{_root}
								->draw_rectangle( $gc, 0, $rect_x, $rect_y, $rect_w, $rect_h );

						}
						
						#calculate dimensions of rect
						$rect_x = $rx;
						$rect_y = $ry;
						$rect_w = $event->x - $rect_x;
						$rect_h = $event->y - $rect_y;
						if ( $rect_w < 0 ) {
							$rect_x += $rect_w;
							$rect_w = 0 - $rect_w;
						}
						if ( $rect_h < 0 ) {
							$rect_y += $rect_h;
							$rect_h = 0 - $rect_h;
						}

						#update zoom_window text
						my $print_w = $rect_w - 1;
						my $print_h = $rect_h - 1;
						$rect->set_text( $print_w . " x " . $print_h );

						#draw new rect to the root window
						if ( $rect_w != 0 ) {
							print
								"Trying to draw a rectangle ($rect_x, $rect_y, $rect_w, $rect_h)\n"
								if $self->{_debug_cparam};

							$self->{_root}
								->draw_rectangle( $gc, 0, $rect_x, $rect_y, $rect_w, $rect_h );

						}
					}
					
				} else {
					Gtk2->main_do_event($event);
				}
			}
		);
		
		$zoom_window->show_all if $self->{_zoom_active};
		Gtk2->main;
		
	#pointer not grabbed
	} else {    
		
		$zoom_window->destroy;
		Gtk2::Gdk->flush;
		$self->ungrab_pointer_and_keyboard( FALSE, FALSE, FALSE );	
		$output = 0;
	
	}
	
	return $output;
}

sub quit {
	my $self 		= shift;
	my $zoom_window = shift;
	
	$self->ungrab_pointer_and_keyboard( FALSE, TRUE, TRUE );
	$zoom_window->destroy;
	Gtk2::Gdk->flush;
	
}

1;
