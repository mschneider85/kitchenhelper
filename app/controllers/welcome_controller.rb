class WelcomeController < ApplicationController

  skip_before_action :authenticate_user!

  layout 'application-no-footer'

  def index
  end
end
