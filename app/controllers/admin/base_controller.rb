class Admin::BaseController < ApplicationController
  before_action :require_admin!

  def require_admin!
    four_oh_four unless current_user.admin?
  end

  def four_oh_four
    render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
  end
end
