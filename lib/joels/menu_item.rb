class Joels::MenuItem

  attr_accessor :name, :path, :parent, :menu, :subpages, :active

  def initialize menu, name, path, parent, &block
    @menu, @name, @path, @parent, @active = menu, name, path, parent, false
    @subpages   = []
    yield(self) if block_given?
    activate! if on_current_path?
  end

  def on_current_path?
    path == "/" ? menu.current_path == "/" : menu.current_path =~ Regexp.new("^#{path.gsub('/', '\/')}")
  end

  def css_class
    active ? "active" : ""
  end

  def activate!
    menu.add_to_crumbtrail(self)
    @active = true
    parent.activate! if parent
  end
  
  def menu_item name, path
    subpages << Joels::MenuItem.new(menu, name, path, self)
  end

end
