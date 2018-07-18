module Google
  extend Discordrb::Commands::CommandContainer

  command(:google, min_args: 1) do |event, *search|
    m = event.respond "<a:loading:393852367751086090> Searching google for #{search.join(' ')}"
    require 'google_search_results'
    searchurl = URI.escape("http://google.com/search?q=#{search.join(' ')}")
    query = GoogleSearchResults.new q: search.join(' ')
    hash_results = query.get_hash
    res = hash_results.to_json
    res = JSON.parse(res)
    results = res['organic_results']
    ponder = res['search_information']
    error = res['error']
    m.delete
    begin
      if !error.nil?
        event.channel.send_embed do |embed|
          embed.title = 'Google Search Results'
          embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "Results for #{search.join(' ')}", url: searchurl, icon_url: 'https://images-ext-1.discordapp.net/external/UsMM0mPPHEKn6WMst8WWG9qMCX_A14JL6Izzr47ucOk/http/i.imgur.com/G46fm8J.png')
          embed.description = error
          embed.colour = 'FF0000'
        end
      else
        event.channel.send_embed do |embed|
          embed.title = 'Google Search Results'

          embed.colour = 0x20d855

          embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "Results for #{search.join(' ')}", url: searchurl, icon_url: 'https://images-ext-1.discordapp.net/external/UsMM0mPPHEKn6WMst8WWG9qMCX_A14JL6Izzr47ucOk/http/i.imgur.com/G46fm8J.png')
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "Total Results: #{ponder['total_results']} | Time Taken: #{(ponder['time_taken'].to_f * 1000).to_i} ms")

          embed.description = ''

          i = 0
          while i < 5
            g = results[i]
            embed.description += "**[#{g['title']}](#{g['link']})**\n#{g['snippet']}\n\n" unless g.nil?
            i += 1
          end
        end
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    rescue StandardError => e
      puts "Google search machine broke #{e}"
    end
  end

  command(:youtube, min_args: 1) do |event, *search|
    search = search.join(' ')
    begin
      findidurl = URI.escape("https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=1&q=#{search}&key=#{CONFIG['google']}")
      id = JSON.parse(RestClient.get(findidurl))['items'][0]['id']['videoId']
      url = JSON.parse(RestClient.get("https://www.googleapis.com/youtube/v3/videos?id=#{id}&key=#{CONFIG['google']}&part=snippet,contentDetails,statistics"))
    rescue StandardError => error
      if CONFIG['google'] == '' || CONFIG['google'].nil?
        event.respond 'This command requires a Google API key!'
      else
        event.respond "There was an error grabbing YouTube link information, don't worry! You did nothing wrong, please report the following error to Chew on GitHub: ```#{error.to_s.delete("\n")}```."
      end
      next
    end
    if url['pageInfo']['totalResults'].zero?
      event.respond 'No results found.'
      next
    end
    stats = url['items'][0]['statistics']
    info = url['items'][0]['snippet']
    length = url['items'][0]['contentDetails']['duration']
    length = length[2..length.length]
    length.downcase!
    views = stats['viewCount'].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    likes = stats['likeCount'].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    dislike = stats['dislikeCount'].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    intdislike = dislike.delete(',').to_i
    intlike = likes.delete(',').to_i
    upload = info['publishedAt'][0..9]
    upload = upload.split('-')
    totallikes = intdislike + intlike
    percent = (intlike / totallikes.to_f * 100).round(2)
    dispercent = (intdislike / totallikes.to_f * 100).round(2)
    case upload[1]
    when '01'
      month = 'January'
    when '02'
      month = 'Feburary'
    when '03'
      month = 'March'
    when '04'
      month = 'April'
    when '05'
      month = 'May'
    when '06'
      month = 'June'
    when '07'
      month = 'July'
    when '08'
      month = 'August'
    when '09'
      month = 'September'
    when '10'
      month = 'October'
    when '11'
      month = 'November'
    when '12'
      month = 'December'
    end
    urlpls = "http://youtu.be/#{id}"

    begin
      event.channel.send_embed do |e|
        e.title = 'YouTube Video Search'

        e.add_field(name: 'Title', value: info['title'], inline: true)
        e.add_field(name: 'Uploader', value: info['channelTitle'], inline: true)
        e.add_field(name: 'Duration', value: length, inline: true)
        e.add_field(name: 'Views', value: views, inline: true)
        e.add_field(name: 'Rating', value: [
          "<:ytup:469274644982267905> **#{likes}** *(#{percent}%)*",
          "<:ytdown:469274880416940042> **#{dislike}** *(#{dispercent}%)*"
        ].join("\n"), inline: true)
        e.add_field(name: 'Uploaded on', value: "#{month} #{upload[2]}, #{upload[0]}", inline: true)
        e.add_field(name: 'Video URL', value: urlpls, inline: true)
        e.color = 'FF0001'
      end
    rescue Discordrb::Errors::NoPermission
      event.respond 'In order for me to send some YouTube stats, I am going to need Embed Links, can you provide those?.'
    end
  end
end
