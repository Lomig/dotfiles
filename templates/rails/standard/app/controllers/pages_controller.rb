class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    flash[:success] = {
      title: "Success!",
      body: "Template successfully used",
      countdown: true
    }
  end
end
