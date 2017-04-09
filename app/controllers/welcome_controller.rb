class WelcomeController < ApplicationController
  def index
    flash[:warning] = "这是 warning 信息！"
    @job = Job.new
  end
end
