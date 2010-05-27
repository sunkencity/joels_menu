class Joels::MenuItem

  attr_accessor :name, :path, :visibility, :parent, :menu, :subpages, :active

  def initialize hash, a_menu, a_parent = nil
    @name, @path, @menu, @parent, @active = hash["name"], hash["path"], a_menu, a_parent, false
    @visibility = (hash["visibility"] || []).map { |x| x.underscore.to_sym }
    @subpages   = (hash["subpages"] || []).map { |sp| Joels::MenuItem.new(sp, menu, self) }
    activate! if on_current_path?
  end

  def visible?
    visible_to_all? || visible_to_current_user?
  end
  
  def visible_to_all?
    visibility.empty?
  end
  
  def visible_to_current_user?
    visibility.any? { |v| (menu.current_user_privileges || []).include?(v) }
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
  
  def visible_subpages
    subpages.select &:visible?
  end
  
end
