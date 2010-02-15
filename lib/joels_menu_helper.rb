
module JoelsMenuHelper

  def joels_menu path, user
    menu = Joels::Menu.new(request.path)
    menu.privileges = user && user.role_symbols
    menu
  end

end