class StaticPagesController < ApplicationController
  def rules
  	@active_nav_tab = :rules
  end

  def wall
  	@active_nav_tab = :standings
  	@active_tab = 'wall'
  	Setting.read current_user
  end

  def unauthorized
  end
end
