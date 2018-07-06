module Misc
  extend Discordrb::Commands::CommandContainer

  command(:isup, min_args: 1, max_args: 1) do |event, url|
    response = RestClient.get("http://downforeveryoneorjustme.com/#{url}")

    status = response.body.include?('It\'s just you')

    ups = ['You need to fix your internet, because', "Listen here, it's not my fault your internet sucks,", 'Get a good web browser, like Firefox!', "Why are you asking me if it's up?"].sample
    downs = ['Dang, that website has some bad uptime.', "Let's cheer this website up"].sample
    begin
      event.channel.send_embed do |e|
        e.title = "Website Up Analysis for #{url}"
        if status
          e.description = "#{ups} #{url} is **Up**!"
          e.color = '00FF00'
        else
          e.description = "#{downs} #{url} is **Down!**"
          e.color = 'FF0000'
        end
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    end
  end

  command(%i[eightball eball 8ball], min_args: 1) do |event, *question|
    question = question.join(' ')
    goodresponse = ['As I see it, yes', 'It is certain', 'It is decidedly so', 'Most likely', 'Outlook good', 'Signs point to yes', 'One would be wise to think so', 'Naturally', 'Without a doubt', 'Yes', 'You may rely on it', 'You can count on it'].sample.to_s
    neutralresponse = ['Better not tell you now!', 'Ask again later.', 'Cannot predict now', 'Cooldown enabled! Please try again.', 'Concentrate and ask again.', 'Rhetorical questions can be answered in solo', 'Maybe...'].sample.to_s
    badresponse = ['You\'re kidding, right?', 'Don\'t count on it.', 'In your dreams', 'My reply is no', 'Outlook not so good', 'My disclosed sources say NO', 'One would be wise to think not', 'Very doubtful'].sample.to_s
    response = rand(0..2)
    begin
      event.channel.send_embed do |e|
        e.title = ':question: Question'
        e.description = question
        if response.zero?
          idk = goodresponse
          e.color = '00FF00'
        elsif response == 1
          idk = neutralresponse
          e.color = 'FFFF00'
        elsif response == 2
          idk = badresponse
          e.color = 'FF0000'
        end
        e.add_field(name: ':8ball: 8ball says', value: idk, inline: false)
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    end
  end

  command(%i[qr qrcode], min_args: 1) do |event, *code|
    code = code.join(' ')
    begin
      event.channel.send_embed do |e|
        e.image = { url: URI.escape("https://api.qrserver.com/v1/create-qr-code/?data=#{code}&size=150x150&.png").to_s }
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    end
  end

  command(:flip) do |event|
    first = ['I flipped a coin, and it landed on', 'I threw the coin into the air and it finally landed on', 'I dropped the coin, it landed on'].sample
    headtails = %w[heads tails].sample
    begin
      event.channel.send_embed do |e|
        e.title = 'Coin Flip'
        e.description = "#{first} **#{headtails}**"
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    end
  end

  command(:roll, min_args: 0, max_args: 1) do |event, args = '1d6'|
    types = args.split('d')
    dice = types[0].to_i
    sides = types[1].to_i
    total = 0
    dice.times do |_roll|
      total += rand(1..sides)
    end
    event.channel.send_embed do |e|
      e.title = 'Dice Roll'

      e.add_field(name: 'Dice Rolled', value: dice, inline: true)
      e.add_field(name: 'Dice Type', value: "#{sides}-sided dice", inline: true)
      e.add_field(name: 'Total', value: total, inline: true)
    end
  end

  command(:choose, min_args: 1) do |event, *args|
    args = args.join(' ')
    args = args.split(',')
    event.respond args.sample
  end

  command(:namecheap, min_args: 1, max_args: 1, usage: 'In order to do a search, you must provide ONE word to search for.') do |event, lookup|
    event.respond "Namecheap Domain Search Results: https://www.namecheap.com/domains/registration/results.aspx?domain=#{lookup}"
  end

  command(:rip, min_args: 1, max_args: 1) do |event, ripwho|
    event.respond "#{ripwho} got #rekt! http://ripme.xyz/#{ripwho}"
  end

  command(:rate, min_args: 1, max_args: 1) do |event, rating|
    event.respond "#{event.user.mention} has rated `#{rating}`/10."
  end
end
