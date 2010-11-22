class Joels::Menu

  attr_accessor :mainmenu, :current_path

  def initialize(path, &block)
    @current_path, @mainmenu = path, []
    yield(self) if block_given?
  end

  def submenu
    menu_is_empty? ? [] : crumbtrail.first.subpages
  end

  def menu_is_empty?
    crumbtrail.empty?
  end

  def crumbtrail
    crumbs.reverse
  end

  def add_to_crumbtrail item
    crumbs << item
  end

  def crumbs
    @crumbs ||= []
  end

  def menu_item name, path, &block
    mainmenu << Joels::MenuItem.new(self, name, path, nil, &block)
  end

end
