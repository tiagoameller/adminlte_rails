# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :set_menu_open_class, only: %i[error_page not_found_page blank_page]
  def index; end

  def error_page; end

  def not_found_page; end

  def blank_page; end

  private

  def set_menu_open_class
    @menu_open_class = 'menu-open'
  end
end
