module Restart
  extend Discordrb::Commands::CommandContainer

  command(:restart, min_args: 1, max_args: 1) do |event, task|
    task.downcase!
    if task == 'help'
      event << 'Possible arguments'
      event << '`pushlocal` - Pushes local repository to github. Usually not used.'
      event << '`restartonly` - Restarts bot without pulling code or anything'
      event << '`update` - Restarts the bot and updates the bot'
      event << '`pushonly` - Pushes code (must `git add` and `git commit`)'
    end
    if event.user.id == CONFIG['owner_id']
      event.respond 'Restarting not supported on Windows!' if CONFIG['os'] == 'Windows'
      if CONFIG['os'] == ('Mac' || 'Linux')
        if task == 'update'
          begin
            event.respond 'Restarting and Updating!'
            exec('bash scripts/update.sh')
          end
        end
        if task == 'pushlocal'
          begin
            event.respond 'Restarting and uploading all that fancy local code'
            exec('bash scripts/push.sh')
          end
        end
        if task == 'restartonly'
          begin
            event.respond 'Restarting the bot without updating...'
            exec('bash scripts/restartonly.sh')
          end
        end
        if task == 'pushonly'
          begin
            event.respond 'Restarting the bot using saved commits...'
            exec('bash scripts/pushonly.sh')
          end
        end
      end
    else
      event.respond "You can't restart! (If you are the owner of the bot, you did not configure properly! Otherwise, stop trying to restart the bot!)"
    end
  end
end
