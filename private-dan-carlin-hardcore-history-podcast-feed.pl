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

=head1 TODO, if I can be bothered

I don't have the show notes, a sensible title for the first 10
episodes (since I just read the MP3 filename), when the episode was
published etc.

It works well enough for me in Pocket Casts on as-is, so I'm unlikely
to patch any of that.

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

# I could write some fancy scraper for this, but it's not like the
# shows come out frequently or anything.
my %shows = (
    1 => {
        title => 'Alexander versus Hitler',
        description => 'Dan compares the way the modern world sees Adolf Hitler with the way history views Alexander the Great and wonders if the two men weren’t more alike than different.',
    },
    2 => {
        title => 'Guns and Horses',
        description => 'The West is Mike Tyson and the East is Muhammad Ali in this episode as Dan mixes Art Bell, with Hans Delbruck in this look at a possible reason for the military decline of the near East.
',
    },
    3 => {
        title => 'The Organization of Peace',
        description => 'The early 20th century League of Nations stood for peace, cooperation, disarmament and international understanding. What happened?
',
    },
    4 => {
        title => 'Romancing The Tribes',
        description => 'Native American chief Tecumseh and Gallic king Vercingetorix both tried to unify their tribal peoples to face overwhelming foes. Dan examines the romance of their lost causes.
',
    },
    5 => {
        title => 'Meandering Through The Cold War',
        description => 'Dan meanders through a conversation about causes and effects of the Cold War without ever talking much about the actual events of the conflict.
',
    },
    6 => {
        title => 'Shield of the West',
        description => 'Spartans, Athenians, Persians and references to Star Trek all make appearances in this look at the dramatic and extremely consequential Greek and Persian wars.
',
    },
    7 => {
        title => 'The X-History Files',
        description => 'Napoleon is supposed to have said that “History is a set of lies agreed upon”. With that in mind, Dan looks at some of the alternative and pseudo history ideas that many people embrace.',
    },
    8 => {
        title => 'Scars of the Great War',
        description => 'Dan looks at the shock and awe caused by the First World War and marvels at how connected we still are to the empire-shattering effects of the conflict contemporaries simply referred to as The Great War.',
    },
    9 => {
        title => 'Darkness Buries the Bronze Age',
        description => 'What was the cause of the collapse of the Bronze Age? War? Famine? Natural disaster? Sauron the Dark Lord? Dan looks at all the potential villains…except for Sauron.',
    },
    10 => {
        title => 'The What-Ifs Of 1066',
        description => 'How might history have been changed if the events of the momentous year 1066 had turned out differently? Dan examines Normans, Vikings, Saxons, Bastards, Conquerers, Confessors, Godwinsons and Hardratas.
',
    },
    11 => {
        description => 'We almost called this show “Things about Churchill that have interested Dan”. Dan takes a look at various elements of the dramatic life and career of the great British leader.',
    },
    12 => {
        description => 'Blood-sucking Scythian warriors, tattooed ice mummies, Amazons killing so they can mate, pot smoking head-hunters, scalp-taking, koumiss-drinking Mongols, Turks, Huns, and Aliens. What’s not to like?',
    },
    13 => {
        description => 'What would happen if half the population died in a short period of time? Dan looks at the Black Death and other plagues that created almost apocalyptic conditions in the past…and maybe in the future.',
    },
    14 => {
        description => 'When Alexander the Great bequeathed his empire “to the strongest” he set off a funeral contest that shook the world for decades. Murder, marriage, intrigue,and drama all feature prominently in the story.',
    },
    15 => {
        description => 'The tough economic climate after the First World War fostered the growth of radicalism around the world. Did it also create tougher people? Dan looks at the connection between tough times and the “Greatest Generation”.',
    },
    16 => {
        description => 'What accounts for the fascination people still have with Adolf Hitler and the Nazis? Dan looks at some of the ideas of the German National Socialists and examines the demonic, charismatic Nazi Fuhrer.',
    },
    17 => {
        description => 'Will our modern society ever decline and fall? Dan uses that idea as a backdrop for a look at the first great empire in history, the biblical-era Assyrians. Were they ancient Nazis, or the guardians of civilization?',
    },
    18 => {
        description => 'In this episode, Dan discusses history with famed television host, author and science historian James Burke, the man the Washington Post called “one of the most intriguing minds in the Western world”.',
    },
    19 => {
        description => 'A traumatized people who traumatized their neighbors, the Native American tribe known as Apache were among the last Indians to surrender to the U.S. Government. Dan, of course, has thoughts. This is a long show!',
    },
    20 => {
        description => 'This first “Blitz Edition” of the show looks at the hidden side of history, the impact of drugs and alcohol on past events. Dan has a whole list of historical figures he wants to drug test.',
    },
    21 => {
        description => 'Was it geopolitics or simply bitter hatred that fueled the ancient bloodbaths known as “The Punic Wars”? Dan highlights the unimaginable things people experienced during this intense face-off between Rome and Carthage.',
    },
    22 => {
        description => 'Darkness, horror, war and carnage dominate Part 2 of the Punic War trilogy as Hannibal rampages across Italy and pushes Rome to the brink of doom.',
    },
    23 => {
        description => 'In one of the great displays of resiliency in all history, the Romans refuse to buckle under murderous Carthaginian pressure. Instead they recover, defeat and destroy Carthage, and conquer most of the Mediterranean.',
    },
    24 => {
        description => 'Dan discusses history with famed historian, political commentator and classicist Victor Davis Hanson.',
    },
    25 => {
        description => 'Dan discusses the past, present and future with influential Canadian historian, broadcaster and columnist Gwynne Dyer.',
    },
    26 => {
        description => 'Is slavery a natural feature of human societies? Dan looks at this timeless, evil institution and wonders if we have made as much progress freeing ourselves from its influence as we think we have.',
    },
    27 => {
        description => 'Part One covering the conflict between the Germans and the Soviet Union in the Second World War. Dan gives an introduction to the subject and discusses the causes and opening moves of Operation Barbarossa.',
    },
    28 => {
        description => 'In Part Two of the Ostfront series covering WW2 on the Eastern Front, Dan looks at the attempt to take Moscow and the many compelling stories surrounding the momentous1941 German offensive.',
    },
    29 => {
        description => 'In Part Three of the Ostfront series covering WW2 on the Eastern Front, Dan looks at the situation in the U.S.S.R. during 1942 and early 1943, including the dreadful Battle of Stalingrad.',
    },
    30 => {
        description => 'In the final episode of the horror story that is the Eastern Front the tale descends into unimaginable darkness as vengeance is called down on Germany. This graphic episode is not for young ears.',
    },
    31 => {
        description => 'Dan’s exposure to the idea of “psychohistory” gets him thinking about how children were raised in the past. Could widespread child abuse and bad parenting in earlier eras explain some of history’s brutality?',
    },
    32 => {
        description => 'Ferdinand Magellan is the lead character in this episode about the collision between the Old and New worlds and what Dan calls “Globalization 1.0″. It is also full of controversy!',
    },
    33 => {
        description => 'Does the toughness of peoples play any role in history? How can historians deal with such an amorphous human quality? Historiography, boxing, barbarians, philosophy and wisdom are among the subjects touched upon',
    },
    34 => {
        description => 'The wars which elevate Rome to superpower status also sow the seed for the downfall of its political system. Money, slaves, ambition, political stalemate and class warfare prove to be a toxic, bloody mix',
    },
    35 => {
        description => 'Disaster threatens the Republic, but the cure might be worse than the disease. “The Dan Carlin version” of this story continues with ambition-addict Marius dominating the story and Plutarch dominating the sources.',
    },
    36 => {
        description => 'Rome’s political violence expands in intensity from riots and assassinations to outright war as the hyper-ambitious generals Marius and Sulla tear the Republic and its constitution apart vying for power and glory.',
    },
    37 => {
        description => 'Sulla returns to Rome to show the Republic what REAL political violence looks like. Civil war and deadly partisan payback will pave the way for reforms pushed at sword point. Lots of heads will roll…literally.',
    },
    38 => {
        description => 'The last great generation of the Roman Republic emerges from the historical mists. The dynamic between Caesar, Cato, Cicero, Crassus and Pompey forms the axis around which the rest of this tale revolves.',
    },
    39 => {
        description => 'In a massive finish to the “Dan Carlin version” of the fall of the Roman Republic, conspiracies, civil wars, beatniks of antiquity and a guy named Caesar figure prominently. Virtually everyone dies.',
    },
    40 => {
        description => 'Using the two 20th Century “Red Scare” eras as case studies, Dan looks at the fear that can be generated by potentially dangerous ideas and examines the way such powerful mass emotions can butt human judgment.',
    },
    41 => {
        description => 'What started as a standard podcast episode morphed into an audio book on what used to be called “The Dark Ages” in Europe. Dan gets into many areas he should probably avoid…Gods, Germans, bikers, Jesus…',
    },
    42 => {
        description => 'After many listener requests, Dan examines the issue of the morality of dropping the Atomic Bombs in the Second World War. As usual, he does so in his own unique, unexpected way.',
    },
    43 => {
        description => 'In one of the most violent outbursts in history a little-known tribe of Eurasian nomads breaks upon the great societies of the Old World like a human tsunami. It may have ushered in the modern era, but at what cost?',
    },
    44 => {
        description => 'The Mongol leader Genghis Khan displays an unmatched level of strategic genius while moving against both Northern China and the Eastern Islamic world. Both civilizations are left stunned and millions are slaughtered.',
    },
    45 => {
        description => 'The expansion of Genghis Khan’s conquests continue, with locations as far apart as Europe and China feeling the bloody effects of Mongol warfare and retribution. Can anything halt the carnage?',
    },
    46 => {
        description => 'The death of Genghis Khan, the founder of the Mongol Empire, should have slowed the momentum of Mongol conquests, but instead it accelerated it. This time though, all of Europe is on the Mongol hit list.',
    },
    47 => {
        description => 'Succession issues weaken the Mongol Empire as the grandchildren of Genghis Khan fight over their imperial inheritance. This doesn’t stop them from dealing out pain, suffering, and ironically good governance while doing so.',
    },
    48 => {
        description => 'Murderous millennial preachers and prophets take over the German city of Munster after Martin Luther unleashes a Pandora’s Box of religious anarchy with the Protestant Reformation.',
    },
    49 => {
        description => 'Imperial temptations and humanitarian nightmares force the United States of the late 19th Century to confront the contradictions between its revolutionary self-image and its expanding national interests.',
    },
    50 => {
        description => 'The planet hadn’t seen a major war between all the Great Powers since the downfall of Napoleon at Waterloo in 1815. But 99 years later the dam breaks and a Pandora’s Box of violence engulfs the planet.',
    },
    51 => {
        description => 'The Great Powers all come out swinging in the first round of the worst war the planet has ever seen. Millions of men in dozens of armies vie in the most deadly and complex opening moves of any conflict in world history.',
    },
    52 => {
        description => 'The war of maneuver that was supposed to be over quickly instead turns into a lingering bloody stalemate. Trench warfare begins, and with it, all the murderous efforts on both sides to overcome the static defenses.',
    },
    53 => {
        description => 'Machine guns, barbed wire and millions upon millions of artillery shells create industrialized meat grinders at Verdun and the Somme. There’s never been a human experience like it…and it changes a generation.',
    },
    54 => {
        description => 'Politics, diplomacy, revolution and mutiny take center stage at the start of this episode, but mud, blood, shells and tragedy drown all by the end.',
    },
    55 => {
        description => 'The Americans are coming, but will the war be over by the time they get there? Germany throws everything into a last series of stupendous attacks in the West while hoping to avoid getting burned by a fire in the East they helped fan.',
    },
    56 => {
        description => 'Often relegated to the role of slavish cannon fodder for Sparta’s spears, the Achaemenid Persian empire had a glorious heritage. Under a single king they created the greatest empire the world had ever seen.',
    },
);

for my $mp3 (reverse @mp3) {
    my ($show, $title) = $mp3 =~ /dchha(\d+)([^.]*)/;
    $title =~ s/^_//;
    $title =~ s/_$//;
    $title =~ tr/_/ /;
    $title =~ s/^\s*|\s*$//g;
    my $num_show = int $show;
    $title ||= $shows{$num_show}->{title};
    my $description = $shows{$num_show}->{description};

    my @stat = stat $mp3 or die "PANIC: Can't stat($mp3): $!";
    my $size = $stat[7];

    print <<"EOF";
    <item>
      <title>Show $show - $title</title>
      <guid>$url_prefix/$mp3</guid>
      <description>$description</description>
      <itunes:subtitle>$description</itunes:subtitle>
      <itunes:summary>$description</itunes:summary>
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
