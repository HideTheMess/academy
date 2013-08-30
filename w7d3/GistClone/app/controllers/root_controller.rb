class RootController < ApplicationController
  before_filter :require_current_user!

  def root
  end
end

# root        /                                  root#root