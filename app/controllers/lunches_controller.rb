class LunchesController < ApplicationController
  def new
    set_variables
    @lunch = Lunch.new
  end

  def create
    members = Member.where(real_name: params[:lunch][:members])
    @lunch = Lunch.new(date: Date.today, members: members)
    if @lunch.save
      redirect_to root_url, notice: 'Lunch was successfully created.'
    else
      set_variables
      render :new
    end
  end

  private

  def set_variables
    @members = Member.includes(:projects)
    gon.lunch_trios = Lunch.includes(:members).map(&:members)
    gon.login_member = Member.find_by(email: current_user.email)
  end
end
