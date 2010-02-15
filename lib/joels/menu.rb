class Joels::Menu
  
  attr_accessor :privileges
  
  def initialize(path = nil)
    @menu = []
    source_data.each { |i| @menu << Joels::MenuItem.new(i, self) }
    @menu.each { |x| x.set_active_by(path) }
  end

  def mainmenu
    @menu.select { |x| x.visible_with privileges }
  end

  def submenu
    if crumbs.first
      crumbs.first.subpages.select { |x| x.visible_with privileges } 
    else
      []
    end
  end

  def crumbtrail
    crumbs.select { |x| x.visible_with privileges }
  end
  
  def add_to_trail item
    crumbs.unshift(item)
  end

  private
  
  def crumbs
    @crumbs ||= []
  end
  
  def source_data
    if RAILS_ENV == 'production'
      @@source_data ||= load_data
    else
      load_data
    end
  end
  
  def load_data
    YAML.load_file("#{RAILS_ROOT}/config/menu.yml")["menu"]
  end

end
