require_dependency 'application_controller'

class AjaxExtension < Radiant::Extension
  version "1.0"
  description ""
  url ""

  def activate
    Page.send(:include, AjaxTags)
  end

  def deactivate
  end
end