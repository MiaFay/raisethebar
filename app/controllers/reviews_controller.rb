class ReviewsController < ApplicationController
  def create
    @bar = Bar.find(params[:bar_id])
    @reviews = @bar.reviews

    @review = Review.new(review_params)
    @review.bar = @bar
    if @review.save
      flash[:notice] = "Review added successfully"
      redirect_to bar_path(@bar)
    else
      flash[:error] = @review.errors.full_messages.join(", ")
      render :'bars/show'
    end
  end

  def update
    @review = Review.find(params[:id])
    @bar = Bar.find(params[:bar_id])
    if @review.update(review_params)
      flash[:success] = 'Review successfully updated'
      redirect_to bar_path(@bar)
    else
      flash[:errors] = @review.errors.full_messages.join(', ')
      render :edit
    end
  end

  private
  def review_params
    params.require(:review).permit(:body, :rating, :price)
  end
end