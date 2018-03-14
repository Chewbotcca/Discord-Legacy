module Cat
  extend Discordrb::Commands::CommandContainer

  command(:cat) do |event|
    whichcat = rand(2)
    showcat = if whichcat.zero?
                JSON.parse(RestClient.get('http://random.cat/meow'))['file']
              else
                Nokogiri::XML(open('http://thecatapi.com/api/images/get?format=xml&results_per_page=1')).xpath('//url').text
              end
    event.respond "#{['Aww!', 'Adorable.'].sample} #{showcat}"
  end

  command(:catfact) do |event|
    event.respond JSON.parse(RestClient.get('https://catfact.ninja/fact'))['fact']
  end
end
