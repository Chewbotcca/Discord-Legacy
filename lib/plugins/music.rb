module Music
  extend Discordrb::Commands::CommandContainer

  command(:lastfm, min_args: 1, max_args: 1) do |event, user|
    if CONFIG['lastfm'].nil? || CONFIG['lastfm'] == ''
      event.respond 'This command requires an API key from last.fm!'
      next
    end
    parse = JSON.parse(RestClient.get("http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&limit=1&user=#{user}&api_key=#{CONFIG['lastfm']}&format=json"))

    base = parse['recenttracks']['track'][0]

    user = parse['recenttracks']['@attr']['user']

    artist = base['artist']['#text']
    track = base['name']
    album = base['album']['#text']

    begin
      np = base['@attr']['nowplaying']
      timeago = np
      playing = true
    rescue StandardError
      np = base['date']['uts']
      t = Time.now.to_i - np.to_i
      mm, ss = t.divmod(60)
      hh, mm = mm.divmod(60)
      dd, hh = hh.divmod(24)
      yy, dd = dd.divmod(365)
      years = format('%d years, ', yy) if yy != 0
      days = format('%d days, ', dd) if dd != 0
      hours = format('%d hours, ', hh) if hh != 0
      mins = format('%d minutes, ', mm) if mm != 0
      secs = format('%d seconds', ss) if ss != 0
      timeago = "#{years}#{days}#{hours}#{mins}#{secs}"
      playing = false
    end

    begin
      event.channel.send_embed do |e|
        e.title = "Last.fm status for #{user}"

        e.add_field(name: 'Track', value: track, inline: true)
        e.add_field(name: 'Artist', value: artist, inline: true)
        e.add_field(name: 'Album', value: album, inline: true)

        if playing
          e.color = '00FF00'
          e.description = 'Currently listening!'
        else
          e.color = 'FF0000'
          e.description = "Last listened about #{timeago} ago."
        end
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    end
  end
end
