module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def current_account
    return @current_account if @current_account
    @current_account = current_user.account
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  def admin?
    current_user && current_user.is_admin
  end

  def horses_editable?
    Game.horses_editable?
  end

  def after_army_options(continent)
    "#{continent.titleize} - #{Team.after_army_teams(continent)}"
  end

  def after_army_short(continent)
    continent.split('_').last.titleize
  end

  def got_horse_right? title, user
    return true if not Game.send("#{title}_announced?")
    user.send("#{title}_points") > 0
  end

  # Logs out the current user.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def bopdial_started?
    return @started if @started
    @started = Game.first.not_editable?(account: current_account)
  end

  def bop_account?
    current_account.name.downcase == 'bop'
  end

  def tzevet_account?
    current_account.name == '5101'
  end


  def games_page game
    if game.is_playoff
      "/games/knockout_stage/#{game.group}"
    else
      "/games/group_stage/#{game.group}"
    end
  end

end
