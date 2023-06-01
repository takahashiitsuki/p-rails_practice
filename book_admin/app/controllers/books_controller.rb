class BooksController < ApplicationController
  protect_form_forgery except: [:destroy] #
  before_action :set_book, only: [:show, :destroy]
  around_action :action_logger, only: [:destroy]
  
  def show
    respond_to do |format|
      format.html
      format.json { render json: @book}
    end
  end
  
  # destroy メソッドを追加
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    respond_to_do |format|
      format.html { redirect_to "/" }
      format.json { head :no_content }
  end
  
  private
  
  def set_book
    @book = Book.find(params[:id])
  end
  
  def action_logger
    logger.info "around-before"
    yield
    logger.info "around-after"
  end
end
