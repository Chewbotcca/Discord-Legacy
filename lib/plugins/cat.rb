module Cat
  extend Discordrb::Commands::CommandContainer

  command(:cat) do |event|
    whichcat = rand(2)
    begin
      showcat = if whichcat.zero?
                  JSON.parse(RestClient.get('http://aws.random.cat/meow'))['file']
                else
                  Nokogiri::XML(open('http://thecatapi.com/api/images/get?format=xml&results_per_page=1')).xpath('//url').text
                end
    rescue RestClient::Forbidden
      redo
    end
    begin
      event.channel.send_embed do |embed|
        embed.title = ['Aww!', 'Adorable.'].sample
        embed.url = showcat

        embed.image = Discordrb::Webhooks::EmbedImage.new(url: showcat)
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "#{['Aww!', 'Adorable.'].sample} #{showcat}"
    end
  end

  command(:cat) do |event|
    begin
      showdog = JSON.parse(RestClient.get('https://random.dog/woof.json'))['url']
    rescue RestClient::Forbidden
      redo
    end
    begin
      event.channel.send_embed do |embed|
        embed.title = ['Aww!', 'Adorable.'].sample
        embed.url = showdog

        embed.image = Discordrb::Webhooks::EmbedImage.new(url: showdog)
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "#{['Aww!', 'Adorable.'].sample} #{showdog}"
    end
  end

  command(:catfact) do |event|
    event.respond JSON.parse(RestClient.get('https://catfact.ninja/fact'))['fact']
  end
end
