#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;
use Data::Dumper;

=head1 NAME

private-dan-carlin-hardcore-history-podcast-feed.pl - Create a private Hardcore History podcast feed

=head1 SYNOPSIS

    # Create a directory structure for it, e.g.:
    mkdir -p ~/www/private-noindex/dchha
    cd ~/www/private-noindex/dchha
    ln -s /path/to/directory/with/mp3s dchha-mp3

    # Generate a podcast.atom:
    perl ~/g/private-dan-carlin-hardcore-history-podcast-feed/private-dan-carlin-hardcore-history-podcast-feed.pl \
        --url-prefix=http://example.com/private-noindex/dchha \
        --mp3-subdir=dchha-mp3 >podcast.atom

=head1 DESCRIPTION

Dan Carlin's Hardcore History podcast only has the last X episodes,
but you can buy the old episodes.

Unfortunately there's no way to subscribe to a paid-for feed with all
the episodes, but if you've bought the old episodes this allows you to
generate that for yourself and host it on your own server.

=cut

GetOptions(
    'help|?' => \my $help,
    'man'    => \my $man,
    'url-prefix=s' => \my $url_prefix,
    'mp3-subdir=s' => \my $mp3_subdir,
) or pod2usage(2);
pod2usage(1) if $help;
pod2usage(-exitstatus => 0, -verbose => 2) if $man;

my @mp3 = glob "$mp3_subdir/*.mp3";

# This whole feed copy/pasted and modified from
# http://feeds.feedburner.com/dancarlin/history?format=xml
print <<'EOF';
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" media="screen" href="/~d/styles/rss2enclosuresfull.xsl"?>
<?xml-stylesheet type="text/css" media="screen" href="http://feeds.feedburner.com/~d/styles/itemcontent.css"?>
<rss xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" xmlns:media="http://search.yahoo.com/mrss/" xmlns:atom="http://www.w3.org/2005/Atom" version="2.0">
  <channel>
    <title>Dan Carlin's Hardcore History</title>
    <description>Was Alexander the Great as bad a person as Hitler? What was the greatest army of all time? Which U.S. President was the worst? Hardcore History discusses the issues and questions history fans love.</description>
    <itunes:summary>In "Hardcore History" the very unconventional Dan Carlin takes his "Martian", outside-the-box way of thinking and applies it to the past. Was Alexander the Great as bad a person as Adolf Hitler? What would Apaches with modern weapons be like? Will our modern civilization ever fall like civilizations from past eras? This is a difficult-to-classify show that has a rather sharp edge. It's not for everyone. But the innovative style and approach has made "Dan Carlin's Hardcore History" a New Media hit. </itunes:summary>
    <itunes:subtitle>Was Alexander the Great as bad a person as Hitler? What was the greatest army of all time? Which U.S. President was the worst? Hardcore History discusses the issues and questions history fans love.</itunes:subtitle>
    <link>http://www.dancarlin.com</link>
    <pubDate>Mon, 29 Dec 2014 22:24:12 PST</pubDate>
    <language>en-us</language>

    <managingEditor>dan@dancarlin.com (Dan Carlin)</managingEditor>
    <webMaster>dan@dancarlin.com (Dan Carlin)</webMaster>

    <itunes:author>Dan Carlin</itunes:author>
    <copyright>dancarlin.com</copyright>
    <itunes:image href="http://www.dancarlin.com/graphics/DC_HH_iTunes.jpg" />
    <image><url>http://www.dancarlin.com/graphics/DC_HH_iTunes.jpg</url>
    <link>http://www.dancarlin.com</link><title>Dan Carlin's Hardcore History</title></image>
    <itunes:owner>
      <itunes:name>Dan Carlin's Hardcore History</itunes:name>
      <itunes:email>dan@dancarlin.com </itunes:email>
    </itunes:owner>
    <itunes:keywords>History, Military, War, Ancient, Archaeology, Classics, Carlin</itunes:keywords>
    <itunes:category text="Society &amp; Culture">
      <itunes:category text="History" />
    </itunes:category>
    <itunes:explicit>no</itunes:explicit>
    <atom10:link xmlns:atom10="http://www.w3.org/2005/Atom" rel="self" type="application/rss+xml" href="http://feeds.feedburner.com/dancarlin/history" /><feedburner:info xmlns:feedburner="http://rssnamespace.org/feedburner/ext/1.0" uri="dancarlin/history" /><atom10:link xmlns:atom10="http://www.w3.org/2005/Atom" rel="hub" href="http://pubsubhubbub.appspot.com/" />
EOF

for my $mp3 (reverse @mp3) {
    my ($show, $title) = $mp3 =~ /dchha(\d+)([^.]*)/;
    $title =~ s/^_//;
    $title =~ s/_$//;
    $title =~ tr/_/ /;
    $title =~ s/^\s*|\s*$//g;

    my @stat = stat $mp3 or die "PANIC: Can't stat($mp3): $!";
    my $size = $stat[7];

    print <<"EOF";
    <item>
      <title>Show $show - $title</title>
      <guid>$url_prefix/$mp3</guid>
      <description>...</description>
      <itunes:subtitle>...</itunes:subtitle>
      <itunes:summary>...</itunes:summary>
      <link>http://www.dancarlin.com</link>
      <pubDate>Wed, 23 Oct 2015 11:25:00 CET</pubDate>
      <enclosure url="$url_prefix/$mp3" length="$size" type="audio/mpeg" />
      <!--itunes:duration>04:16:43</itunes:duration-->
      <itunes:keywords>History</itunes:keywords>
    </item>
EOF
}

print <<'EOF';
  </channel>
</rss>
EOF
