class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    @link = Link.new(filtered_params)

    if @link.save
      flash[:success] = 'Twój link został skrócony'
      redirect_to link_path(@link)
    else
      flash[:error] = @link.url_error_message
      render :new
    end
  end

  def show
    @link = Link.find(params[:id])
  end

  def forward
    @link = Link::find_by(token: params[:token])
    redirect_to @link.url
  end

  private

  def filtered_params
    params.require(:link).permit(:url)
  end
end
