class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_game

  def current_game
    @current_game ||= load_current_game
  end

  def set_current_game(game)
    @current_game = game
    session[:serialized_current_game] = game.present? ? game.to_json : nil
  end

  def update_current_game
    set_current_game @current_game
  end

  protected

  def load_current_game
    Game.new.from_json(session[:serialized_current_game]) if session[:serialized_current_game].present?
  end
end
