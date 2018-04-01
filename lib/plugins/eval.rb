module Eval
  extend Discordrb::Commands::CommandContainer

  command(:eval) do |event, *code|
    break unless event.user.id == CONFIG['owner_id']
    begin
      event.channel.send_embed do |e|
        e.title = '**Evaluated Successfully**'

        evaluated = eval code.join(' ')

        if evaluated.to_s.length > 1500
          puts '---BEGIN EVALUATION OUTPUT---'
          puts evaluated.to_s
          puts '---END EVALUATION OUTPUT---'
          evaluated = evaluated.to_s[0..1500]
          e.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'Please note the output was limited to 1500 characters due to discord having limits. The rest of the output is in your console.')
        end

        e.description = evaluated
        e.color = '00FF00'
      end
    rescue StandardError => f
      event.channel.send_embed do |e|
        e.title = '**Evaluation Failed!**'

        e.description = f.to_s
        e.color = 'FF0000'
      end
    end
  end
end
