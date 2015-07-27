class ExpendituresController < ApplicationController
  def index
    @expenditures = Expenditure.where(user_id: current_user.id)
  end

  def new
    if user_signed_in?
      @expenditure = Expenditure.new
    else
      redirect_to new_user_session_path
      flash.notice = "You need to sign in first"
    end
  end

  def create
    @expenditure = current_user.expenditures.build expenditure_params
    if @expenditure.save
      redirect_to @expenditure
    else
      render 'new'
    end
  end

  def show
    @expenditure = Expenditure.find params[:id]
  end

  def edit
    @expenditure = Expenditure.find params[:id]
    if @expenditure.user == current_user
      render 'edit'
    else
      redirect_to expenditures_path
      flash.alert = "Invalid Permissions"
    end
  end

  def update
    @expenditure = Expenditure.find params[:id]
    if @expenditure.update expenditure_params
      redirect_to @expenditure
    else
      render 'edit'
    end
  end

  def destroy
    @expenditure = Expenditure.find params[:id]
    if @expenditure.user = current_user
      @expenditure.destroy
      redirect_to expenditures_path
      flash.notice = "expenditure successfully deleted"
    else
      redirect_to expenditures_path
      flash.alert = "Invalid Permissions"
    end
  end

  private
    def expenditure_params
      params.require(:expenditure).permit(:name, :price, :quantity, :purchase_date)
    end
end
