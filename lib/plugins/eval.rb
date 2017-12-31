module Eval
  extend Discordrb::Commands::CommandContainer

  command(:eval) do |event, *code|
    break unless event.user.id == CONFIG['owner_id']
    begin
      event.respond eval code.join(' ')
    rescue => e
      event.respond "Well, excuse me, mr nobrain, cant even eval correctly smh. THE ERROR: ```#{e}```"
    end
  end
end
