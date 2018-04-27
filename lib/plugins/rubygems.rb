module RubyGems
  extend Discordrb::Commands::CommandContainer

  command(%i[rgem gem rubygem rubyg gems], min_args: 1, max_args: 1) do |event, gem|
    data = JSON.parse(RestClient.get("https://rubygems.org/api/v1/gems/#{gem}.json"))
    rank = JSON.parse(RestClient.get("http://bestgems.org/api/v1/gems/#{gem}/total_ranking.json"))[0]['total_ranking']

    begin
      event.channel.send_embed do |e|
        e.title = 'RubyGem Information'

        e.author = {
          name: "#{data['name']} (#{data['version']})",
          icon_url: 'https://cdn.discordapp.com/emojis/232899886419410945.png?v=1'.to_s
        }

        e.description = data['info']

        e.add_field(name: 'Authors', value: data['authors'], inline: true)

        e.add_field(name: 'Downloads', value: [
          "For Version: #{data['version_downloads']}",
          "Total: #{data['downloads']}"
        ].join("\n"), inline: true)

        licenses = []

        data['licenses'].each do |meme|
          licenses[licenses.length] = meme
        end

        e.add_field(name: 'Licenses', value: licenses.join(', '), inline: true)

        e.add_field(name: 'Rank', value: "\##{rank}", inline: true)

        links = []
        links += ["[Project](#{data['project_uri']})"]
        links += ["[Gem](#{data['gem_uri']})"]
        links += ["[Homepage](#{data['homepage_uri']})"] unless data['homepage_uri'].nil? || data['homepage_uri'] == ''
        links += ["[Wiki](#{data['wiki_uri']})"] unless data['wiki_uri'].nil? || data['wiki_uri'] == ''
        links += ["[Documentation](#{data['documentation_uri']})"]
        links += ["[Mailing List](#{data['mailing_list_uri']})"] unless data['mailing_list_uri'].nil? || data['mailing_list_uri'] == ''
        links += ["[Source Code](#{data['source_code_uri']})"] unless data['source_code_uri'].nil? || data['source_code_uri'] == ''
        links += ["[Bug Tracker](#{data['bug_tracker_uri']})"] unless data['bug_tracker_uri'].nil? || data['bug_tracker_uri'] == ''
        links += ["[Changelog](#{data['changelog_uri']})"] unless data['changelog_uri'].nil? || data['changelog_uri'] == ''

        e.add_field(name: 'Links', value: links.join("\n"), inline: true)

        e.color = '00FF00'
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    end
  end
end
