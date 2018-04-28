class StaticPagesController < ApplicationController
  def rules
  	@active_nav_tab = :rules
  end

  def unauthorized
  end
end
