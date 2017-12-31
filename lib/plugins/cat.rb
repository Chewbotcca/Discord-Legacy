module Cat
  extend Discordrb::Commands::CommandContainer

  command(:cat) do |event|
    jsoncat = JSON.parse(RestClient.get('http://random.cat/meow'))['file']
    xmlcat = Nokogiri::XML(open('http://thecatapi.com/api/images/get?format=xml&results_per_page=1')).xpath('//url').text
    event.respond "#{['Aww!', 'Adorable.'].sample} #{[jsoncat, xmlcat].sample}"
  end
end
