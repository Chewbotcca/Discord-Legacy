module Rate
  extend Discordrb::Commands::CommandContainer

  command(:rate, min_args: 1, max_args: 1) do |event, rating|
    event.respond "#{event.user.mention} has rated `#{rating}`/10."
  end
end
