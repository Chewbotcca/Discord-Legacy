module Invite
  extend Discordrb::Commands::CommandContainer

  command :invite do |event|
    event.respond 'Hello! Invite me to your server here: <http://bit.ly/Chewbotcca>. Join the help server here: https://discord.gg/Q8TazNz'
  end
end
