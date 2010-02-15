class Joels::MenuItem

  attr_accessor :name, :path, :visibility, :parent, :menu, :subpages

  def initialize hash, menu, parent = nil
    @name       = hash["name"]
    @path       = hash["path"]
    @menu       = menu
    @parent     = parent
    
    @visibility = hash["visibility"] && hash["visibility"].map { |x| x.underscore.to_sym }
    @subpages   = hash["subpages"] ? hash["subpages"].map { |sp| Joels::MenuItem.new(sp, menu, self) } : []
    
  end

  def visible_with privs
    if visibility
      if privs
        privs.each do |p|
          return true if visibility.include? p
        end
      end
      false
    else
      true
    end
  end

  def matches curpath
    if path == "/"
      curpath == "/"
    else
      curpath =~ Regexp.new("^#{path.gsub('/', '\/')}")
    end
  end

  def css_class
    @active ? "active" : ""
  end

  def set_active_by current_path
    if matches current_path
      activate!
    else
      subpages.each { |x| x.set_active_by(current_path) }
    end
  end

  def activate!
    menu.add_to_trail(self)
    @active = true
    parent.activate! if parent
  end

  def active?
    !!@active
  end

end
