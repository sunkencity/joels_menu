
module JoelsMenuHelper

  def joels_menu path, &block
    Joels::Menu.new(request.path, &block)
  end

end
