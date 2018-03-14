module Restart
  extend Discordrb::Commands::CommandContainer

  command(:restart) do |event|
    unless event.user.id == CONFIG['owner_id']
      event.respond "You can't update! (If you are the owner of the bot, you did not configure properly! Otherwise, stop trying to update the bot!)"
      break
    end
    event.respond 'Restarting the bot without updating...'
    sleep 1
    exec('ruby run.rb')
  end

  command(:update) do |event|
    unless event.user.id == CONFIG['owner_id']
      event.respond "You can't update! (If you are the owner of the bot, you did not configure properly! Otherwise, stop trying to update the bot!)"
      return
    end
    event.respond 'Restarting and Updating!'
    sleep 1
    `git pull`
    exec('ruby run.rb')
  end

  command(:updates) do |event|
    `git fetch` if event.user.id == CONFIG['owner_id']
    response = `git rev-list origin/master | wc -l`.to_i
    commits = `git rev-list master | wc -l`.to_i
    if commits.zero?
      event.respond "Your machine doesn't support git or it isn't working!"
      break
    end
    if event.user.id == CONFIG['owner_id']
      event.channel.send_embed do |e|
        e.title = "You are running Chewbotcca commit #{commits}"
        if response == commits
          e.description = 'You are running the latest commit.'
          e.color = '00FF00'
        elsif response < commits
          e.description = "You are running an un-pushed commit! Are you a developer? (Most Recent: #{response})"
          e.color = 'FFFF00'
        else
          e.description = "You are #{response - commits} commit(s) behind! Run `%^update` to update"
          e.color = 'FF0000'
        end
      end
    end
  end
end
