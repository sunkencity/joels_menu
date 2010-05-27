
module JoelsMenuHelper

  def joels_menu path, opts
    menu = Joels::Menu.new(request.path)
    menu.current_user_privileges = opts[:user].role_symbols if opts[:user]
    menu.current_user_privileges = opts[:role_symbols] if opts.has_key? :role_symbols
    menu
  end

end