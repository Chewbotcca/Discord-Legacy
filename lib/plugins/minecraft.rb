module Minecraft
  extend Discordrb::Commands::CommandContainer

  command(:namemc, min_args: 1, max_args: 1) do |event, mcsearch|
    event.respond "NameMC Search: http://namemc.com/s/#{mcsearch}"
  end

  command(:mcstatus) do |event|
    statusurl = JSON.parse(RestClient.get('https://status.mojang.com/check'))
    sites = ['minecraft.net', 'session.minecraft.net', 'account.mojang.com', 'authserver.mojang.com', 'sessionserver.mojang.com', 'api.mojang.com', 'textures.minecraft.net', 'mojang.com']
    green = []
    yellow = []
    red = []

    (0..7).each do |site|
      if statusurl[site][sites[site]] == 'green'
        green[green.length] = sites[site]
      elsif statusurl[site][sites[site]] == 'yellow'
        yellow[yellow.length] = sites[site]
      else
        red[red.length] = sites[site]
      end
    end

    event.channel.send_embed do |e|
      e.title = 'Minecraft/Mojang Statuses'

      e.add_field(name: 'Working', value: green.join("\n"), inline: true) unless green.length.zero?
      e.add_field(name: '~Shakey~', value: yellow.join("\n"), inline: true) unless yellow.length.zero?
      e.add_field(name: 'Down!!', value: red.join("\n"), inline: true) unless red.length.zero?
      e.color = '00FF00'
    end
  end
end
