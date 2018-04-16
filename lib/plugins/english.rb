module English
  extend Discordrb::Commands::CommandContainer

  command(:urban, min_args: 1) do |event, word|
    parse = JSON.parse(RestClient.get("http://api.urbandictionary.com/v0/define?term=#{word}"))
    if parse['result_type'].to_s == 'no_results'
      event.respond "No results found for term `#{word}`!"
      return
    end
    info = parse['list'][0]
    definition = info['definition'].to_s
    definition = definition.tr("\n", ' ')
    up = info['thumbs_up'].to_s
    author = info['author'].to_s
    example = info['example'].to_s
    example = example.tr("\n", ' ')
    down = info['thumbs_down'].to_s
    total = up.to_i + down.to_i
    ratio = (up.to_f / total.to_f * 100).round(2).to_s
    word = info['word'].to_s
    url = info['permalink']
    begin
      event.channel.send_embed do |e|
        e.title = "Urban Dictionary defintion for **#{word}**"

        e.add_field(name: 'Definition', value: definition, inline: false)
        e.add_field(name: 'Author', value: author, inline: true)
        e.add_field(name: 'Rating', value: "**#{up}** 👍 - **#{down}** 👎 (**#{ratio}%**)", inline: true)
        e.add_field(name: 'Example', value: example, inline: false)
        e.add_field(name: 'URL', value: url, inline: false)
        e.color = '00FF00'
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    end
  end

  command(:define) do |event, word|
    grabbedword = JSON.parse(RestClient.get("http://api.wordnik.com/v4/word.json/#{word}/definitions?limit=1&includeRelated=true&useCanonical=false&includeTags=false&api_key=#{CONFIG['wordnik']}"))
    begin
      event.channel.send_embed do |embed|
        embed.title = "Definition for #{word}"
        embed.colour = 0xd084
        embed.description = (grabbedword[0]['text']).to_s

        embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: 'Dictionary', icon_url: 'http://icons.iconarchive.com/icons/johanchalibert/mac-osx-yosemite/1024/dictionary-icon.png')

        embed.add_field(name: 'Part of Speech', value: (grabbedword[0]['partOfSpeech']).to_s, inline: true)
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "OOps! I can't send the embed. Can I please have the 'Embed Links' permission? Thanks, appreciate ya."
      # rescue StandardError
      #  event.respond 'Word not found! Check your local spell-checker!'
    end
  end
end
