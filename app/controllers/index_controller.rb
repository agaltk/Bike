class IndexController < ApplicationController
  def start
  	
  end

  def my_profile
  	@user = current_user

  end
end
