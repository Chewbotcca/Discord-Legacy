module Google
  extend Discordrb::Commands::CommandContainer

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
        e.add_field(name: 'Rating', value: "**#{likes}** 👍 - **#{dislike}** 👎 (**#{percent}%**)", inline: true)
        e.add_field(name: 'Uploaded on', value: "#{month} #{upload[2]}, #{upload[0]}", inline: true)
        e.add_field(name: 'Video URL', value: urlpls, inline: true)
        e.color = '00FF00'
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    end
  end
end
