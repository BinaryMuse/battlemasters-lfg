class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :redirect_to_uc
  def redirect_to_uc
    return render 'listings/uc'
  end

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    klass.new object, view_context
  end
end
