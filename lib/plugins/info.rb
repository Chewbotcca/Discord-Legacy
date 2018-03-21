module Info
  extend Discordrb::Commands::CommandContainer

  command(:info, min_args: 0, max_args: 1) do |event, com|
    com.downcase!
    begin
      event.channel.send_embed do |e|
        e.color = '00FF00'
        case com
        when 'ping'
          e.title = '**Info For**: `%^ping`'
          e.add_field(name: 'Description', value: 'Replies with "Pong!" and time in seconds', inline: false)
          e.add_field(name: 'Arguments', value: '`noedit` (Pings without editing the message)', inline: false)
          e.add_field(name: 'Usage', value: '`%^ping` or `%^ping noedit`', inline: false)
        when 'help'
          e.title = '**Info For**: `%^help`'
          e.add_field(name: 'Description', value: 'PMs you a list of commands. (See `%^commands` for commands only)', inline: false)
          e.add_field(name: 'Usage', value: '`%^help`', inline: false)
        when 'commands'
          e.title = '**Info For**: `%^commands`'
          e.add_field(name: 'Description', value: 'PMs you a list of commands only, no command descriptions are given.', inline: false)
          e.add_field(name: 'Usage', value: '`%^commands`', inline: false)
        when 'info'
          e.title = '**Info For**: `%^info`'
          e.add_field(name: 'Description', value: 'When a command is specified, it gives more info on a command.', inline: false)
          e.add_field(name: 'Usage', value: '`%^info help`', inline: false)
        when 'invite'
          e.title = '**Info For**: `%^invite`'
          e.add_field(name: 'Description', value: 'PMs the user a link to invite Chewbotcca to your server, as well as a discord invite link to the bot server.', inline: false)
          e.add_field(name: 'Usage', value: '`%^invite`', inline: false)
        when 'rate'
          e.title = '**Info For**: `%^rate`'
          e.add_field(name: 'Description', value: 'Rate something out of 10.', inline: false)
          e.add_field(name: 'Arguments', value: 'Enter a string (pls numbers) after the command.', inline: false)
          e.add_field(name: 'Usage', value: '`%^rate 9.2`', inline: false)
        when 'namemc'
          e.title = '**Info For**: `%^namemc`'
          e.add_field(name: 'Description', value: 'Returns a link to search results for <http://namemc.com>. If there is one result, it will show a profile.', inline: false)
          e.add_field(name: 'Arguments', value: 'Enter a string after the command to search for that.', inline: false)
          e.add_field(name: 'Usage', value: '`%^namemc ChewLeKitten` or `%^namemc mc.cloudcitymc.us`', inline: false)
        when 'memedb'
          e.title = '**Info For**: `%^memedb`'
          e.add_field(name: 'Description', value: 'Shows a list of all the memes in the meme database, if arguments are provided, it "searches" for that meme.', inline: false)
          e.add_field(name: 'Arguments', value: 'a meme', inline: false)
          e.add_field(name: 'Usage', value: '`%^memedb` or `%^memedb rickroll`', inline: false)
        when 'stats'
          e.title = '**Info For**: `%^stats`'
          e.add_field(name: 'Description', value: 'Shows some basic stats for Chewbotcca.', inline: false)
          e.add_field(name: 'Usage', value: '`%^stats`', inline: false)
        when 'rip'
          e.title = '**Info For**: `%^rip`'
          e.add_field(name: 'Description', value: 'Returns a <http://ripme.xyz> link.', inline: false)
          e.add_field(name: 'Arguments', value: 'Put a string after the command', inline: false)
          e.add_field(name: 'Usage', value: '`%^rip Chew`', inline: false)
        when 'namecheap'
          e.title = '**Info For**: `%^namecheap`'
          e.add_field(name: 'Description', value: 'Returns a <http://namecheap.com> search results link.', inline: false)
          e.add_field(name: 'Arguments', value: 'Enter a domain or search string.', inline: false)
          e.add_field(name: 'Usage', value: '`%^namecheap google`', inline: false)
        when 'uinfo'
          e.title = '**Info For**: `%^uinfo`'
          e.add_field(name: 'Description', value: 'Shows some basic stats for the user.', inline: false)
          e.add_field(name: 'Usage', value: '`%^uinfo`', inline: false)
        when 'sinfo'
          e.title = '**Info For**: `%^sinfo`'
          e.add_field(name: 'Description', value: 'Shows some basic stats for the server.', inline: false)
          e.add_field(name: 'Usage', value: '`%^sinfo`', inline: false)
        when 'cat'
          e.title = '**Info For**: `%^cat`'
          e.add_field(name: 'Description', value: 'Shows a RANDOM CAT AWWWWWWW.', inline: false)
          e.add_field(name: 'Usage', value: '`%^cat`', inline: false)
        when 'catfact'
          e.title = '**Info For**: `%^catfact`'
          e.add_field(name: 'Description', value: 'Shows a random catfact. For example: cats meow.', inline: false)
          e.add_field(name: 'Usage', value: '`%^catfact`', inline: false)
        when 'trbmb'
          e.title = '**Info For**: `%^trbmb`'
          e.add_field(name: 'Description', value: 'Generates a random TRBMB phrase. Based on http://trbmb.chew.pw.', inline: false)
          e.add_field(name: 'Usage', value: '`%^trbmb`', inline: false)
        else
          e.title = 'SYSTEM ERROR'
          e.description = 'You failed, possible causes: You spelled the command wrong or that command doesn\'t exist. Use `%^help` to see commands.'
          e.color = 'FF0000'
        end
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    end
  end
end
