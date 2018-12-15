module MemeDB
  extend Discordrb::Commands::CommandContainer

  command(:memedb, min_args: 0, max_args: 1) do |event, meme|
    meme = 'random' if meme.nil?
    meme.downcase!
    if meme == 'submit'
      event.respond 'You can submit a meme here: <http://goo.gl/forms/BRMomYVizsY7SqOg2>'
      break
    end
    memelist = JSON.parse(RestClient.get('http://chewbotcca.github.io/memedb/memes.json'))
    memers = []
    (0..memelist.length - 1).each do |i|
      memers[memers.length] = memelist[i]['Meme']
    end
    memer = JSON.parse(RestClient.get("http://api.chew.pro/chewbotcca/memedb/#{meme}"))
    if memer['meme'] == 'Invalid Meme'
      event << "This meme doesn't exist! Make sure you spell the meme name right." unless meme.nil?
      event << "Here is a list of the current memes: `#{memers.join(', ')}`"
      break
    end
    begin
      event.channel.send_embed do |embed|
        embed.title = "Meme: #{memer['meme']}"
        embed.colour = 0x8ed1fc
        embed.url = memer['url'].to_s

        embed.image = { url: memer['url'] }

        embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: 'Meme Database')
        embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: memer['note']) unless memer['note'].nil?
      end
    rescue Discordrb::Errors::NoPermission
      event.respond memer['url']
    rescue RestClient::BadRequest
      event.respond 'There was an error retrieving the meme!'
    rescue URI::InvalidURIError
      event.respond "Bro that meme isn't even a meme."
    end
  end
end
