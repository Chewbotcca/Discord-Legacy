module Roles
  extend Discordrb::Commands::CommandContainer

  command(:createrole, min_args: 1, required_permissions: [:manage_roles], permission_message: 'My dude, you do not have permission to manage roles!') do |event, *rolename|
    rolename = rolename.join(' ')
    begin
      role = event.server.create_role
      role.name = rolename
      event.respond "I have successfully created the role `#{rolename}`!"
    rescue Discordrb::Errors::NoPermission
      event.respond "I do not have permission to 'manage roles', can you please provide those, thanks, appreciate ya"
    end
  end
end
