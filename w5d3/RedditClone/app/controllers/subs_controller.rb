class SubsController < ApplicationController
  def new # Mod has Access
    if logged_in?
      @sub = Sub.new

      @links = []
      5.times { @links << Link.new }

      render :new
    else
      redirect_to new_session_url
    end
  end

  def create # Mod has Access
    @sub = Sub.new(params[:sub])

    @links = params[:links].map do |_, link_params|
      Link.new(link_params)
    end

    non_blank_links = @links.map { |link| link.dup }

    non_blank_links.delete_if do |link|
      link.title.blank? && link.url.blank? && link.body.blank?
    end

    begin
      ActiveRecord::Base.transaction do
        @sub.save!

        non_blank_links.each do |link|
          link.save!
          LinkSub.create!(sub_id: @sub.id, link_id: link.id)
        end
      end
    rescue
      flash.now[:notices] ||= []
      flash.now[:notices] += @sub.errors.full_messages

      non_blank_links.each do |link|
        flash.now[:notices] += link.errors.full_messages
      end

      render :new
    else
      flash[:notices] ||= []
      flash[:notices] << "Sub #{@sub.name} created"

      redirect_to sub_url(@sub.id)
    end
  end

  def show # Guest has Access
    @sub = Sub.find(params[:id])
    @links = @sub.links

    render :show
  end

  def edit # Mod has Access
    @sub = Sub.find(params[:id])

    if logged_in? && (@sub.mod_id == current_user.id)
    else
      redirect_to new_session_url
    end
  end

  def update # Mod has Access
    @sub = Sub.find(params[:id])
    @sub.update_attributes(params[:sub])

    if @sub.save
      redirect_to sub_url
    else
      flash.now[:notices] ||= []
      flash.now[:notices] << "Name can't be blank"

      render :edit
    end
  end
end

#     subs POST   /subs(.:format)           subs#create
#  new_sub GET    /subs/new(.:format)       subs#new
# edit_sub GET    /subs/:id/edit(.:format)  subs#edit
#      sub GET    /subs/:id(.:format)       subs#show
#          PUT    /subs/:id(.:format)       subs#update