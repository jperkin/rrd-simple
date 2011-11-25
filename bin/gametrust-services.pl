#!/usr/bin/perl -w

use strict;
use GameTrust::Web::Stats::Parser;

my $parser = new GameTrust::Web::Stats::Parser;
my $feed = $parser->feed(feed => 'game');
my $time = time();

for my $brand ($feed->active_brands) {
	my $meta = $feed->brand_metadata($brand);
	next unless $meta->{usage} > 20;
	(my $brand_str = $meta->{displayname}) =~ s/[^\w\d]+//g;

	my $games = $feed->games($brand);
	while (my $game = $games->next) {
		printf("%d.gametrust.%s.game.%s %d\n",
				$time,
				lc($brand_str),
				$game->{id},
				$game->{usage},
			) if $game->{id} =~ 
			/^([89]ball|snooker|chess|backgammon)$/;
	}
}


