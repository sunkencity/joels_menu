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
    crumbtrail.empty?
  end

  def source_data
    Rails.env == 'production' ? @@source_data ||= load_data : load_data
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

  def load_data path = "#{Rails.root}/config/menu.yml", key = "menu"
    YAML.load_file(path)[key]
  end

end
