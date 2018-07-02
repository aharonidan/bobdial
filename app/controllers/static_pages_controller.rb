class StaticPagesController < ApplicationController
  def rules
  	@active_nav_tab = :rules
  end

  def wall
  	@active_nav_tab = :standings
  	@active_tab = 'wall'
  end

  def unauthorized
  end
end
