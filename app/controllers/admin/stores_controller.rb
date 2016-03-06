class Admin::StoresController < Admin::BaseController
  include ::Deactivateable::Controller

  before_action :set_store, only: [:show, :edit, :update, :destroy]
  
  def index 
    @stores = Store.where(nil).paginate(page: params[:page])
  end

  def show
  end

  def edit
  end

  def update
    if @store.update(store_params)
      redirect_to admin_store_path(@store.id)
    else
      render :show
    end
  end

  def destroy
    if @store.destroy!
      redirect_to admin_store_path(@store.id)
    else
      render :show
    end
  end
  private
  def store_params
    params.require(:store).permit(:name, :address_1, :address_2, :county, :postcode, :lat, :lng)
  end

  def set_store
    @store = Store.find(params[:id])
  end
end
