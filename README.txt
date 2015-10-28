NAME
    private-dan-carlin-hardcore-history-podcast-feed.pl - Create a private
    Hardcore History podcast feed

SYNOPSIS
        # Create a directory structure for it, e.g.:
        mkdir -p ~/www/private-noindex/dchha
        cd ~/www/private-noindex/dchha
        ln -s /path/to/directory/with/mp3s dchha-mp3

        # Generate a podcast.atom:
        perl ~/g/private-dan-carlin-hardcore-history-podcast-feed/private-dan-carlin-hardcore-history-podcast-feed.pl \
            --url-prefix=http://example.com/private-noindex/dchha \
            --mp3-subdir=dchha-mp3 >podcast.atom

DESCRIPTION
    Dan Carlin's Hardcore History podcast only has the last X episodes, but
    you can buy the old episodes.

    Unfortunately there's no way to subscribe to a paid-for feed with all
    the episodes, but if you've bought the old episodes this allows you to
    generate that for yourself and host it on your own server.

TODO, if I can be bothered
    I don't have the show notes, a sensible title for the first 10 episodes
    (since I just read the MP3 filename), when the episode was published
    etc.

    It works well enough for me in Pocket Casts on as-is, so I'm unlikely to
    patch any of that.

