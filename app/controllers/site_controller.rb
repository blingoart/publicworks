class SiteController < ApplicationController

  def index
    @title = "Home"
    render :layout => 'homepage'
  end

  def newsletter
    if params.has_key?(:email)
      @newsletter = Newsletter.new(:email => params[:email])
      if @newsletter.is_unique?
        @newsletter.save
      end
    end
  end

end
