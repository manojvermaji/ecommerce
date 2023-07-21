class ApplicationController < ActionController::Base
  #protect_form_forgery with: :exception
  include CurrentCart

  
end
