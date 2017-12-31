module ServerInfo
  extend Discordrb::Commands::CommandContainer

  command(%i[sinfo serverinfo]) do |event|
    event << 'Server Stats:'
    event << ''
    event << 'Basic Info:'
    event << "Server Name: #{event.server.name}"
    event << "Server ID: #{event.server.id}"
    event << "Server Region: #{event.server.region}"
    event << "Server Owner: #{event.server.owner.name}\##{event.server.owner.discrim}"
    event << ''
    event << 'Members:'
    event << "Total Member Count: #{event.server.members.count}"
    event << ''
    event << 'Channels:'
    event << "Total Channel Count: #{event.server.channels.count}"
    event << "Text Channels: #{event.server.text_channels.count}"
    event << "Voice Channels: #{event.server.voice_channels.count}"
    event << ''
    event << 'Roles:'
    event << "Count: #{event.server.roles.count}"
  end
end
