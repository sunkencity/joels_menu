class Joels::Menu
  
  attr_accessor :current_user_privileges, :menu_tree, :current_path
  
  def initialize(path = "/")
    @current_path = path
    @menu_tree = source_data.map { |i| Joels::MenuItem.new(i, self) }
    @current_user_privileges ||= []
  end

  def mainmenu
    menu_tree.select &:visible?
  end

  def submenu
    menu_is_empty? ? [] : crumbtrail.first.visible_subpages
  end
  
  def menu_is_empty?
    !crumbtrail.first
  end

  def source_data
    RAILS_ENV == 'production' ? @@source_data ||= load_data : load_data
  end
  
  def crumbtrail
    crumbs.reverse.select &:visible?
  end
  
  def add_to_crumbtrail item
    crumbs << item
  end

  def crumbs
    @crumbs ||= []
  end
  
  def load_data
    YAML.load_file("#{RAILS_ROOT}/config/menu.yml")["menu"]
  end

end
