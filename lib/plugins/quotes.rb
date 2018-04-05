module Quotes
  extend Discordrb::Commands::CommandContainer

  command(:trbmb) do |event|
    event.respond JSON.parse(RestClient.get('http://api.chew.pro/trbmb'))[0]
  end

  command(:acronym, min_args: 1, max_args: 1) do |event, acro|
    event.respond "#{acro} stands for: #{JSON.parse(RestClient.get(URI.escape("http://api.chew.pro/acronym/#{acro}")))['phrase']}"
  end

  command(:numberfact, min_args: 1, max_args: 2) do |event, *args|
    number = args[0].to_s
    type = (args[1].to_s unless args.length == 1)

    type.downcase! unless type.nil?
    if type == 'trivia' || type.nil?
      type = 1
    elsif type == 'math'
      type = 2
    elsif type == 'year'
      type = 3
    elsif type == 'date'
      type = 4
    end

    if type == 1
      url = "http://numbersapi.com/#{number}?notfound="
    elsif type == 2
      url = "http://numbersapi.com/#{number}/math?notfound="
    elsif type == 3
      url = "http://numbersapi.com/#{number}/year?notfound="
    elsif type == 4
      url = "http://numbersapi.com/#{number}/date?notfound="
    end

    begin
      facto = RestClient.get("#{url}=floor").to_s
      facto = RestClient.get("#{url}=ceil").to_s if facto == '-Infinity is negative infinity.'
      event.channel.send_embed do |embed|
        embed.title = 'Did you know?'
        embed.colour = 0x85bae7
        embed.description = facto.to_s

        embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: 'Number Facts!')
        embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "Your number didn't have a fact, so a number was approximated for you.") if facto.split(' ')[0].to_i != number && type != 4
      end
    rescue RestClient::NotFound
      event.channel.send_embed do |embed|
        embed.title = 'Error in number finding.'
        embed.colour = 'D0021B'

        embed.description = "That isn't a number!"

        embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: 'Number Facts')
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "We all love facts about numbers, but I cannot provide any without the proper permissions. Can I please have the 'Embed Links' permission? Thanks, appreciate ya."
    end
  end
end
