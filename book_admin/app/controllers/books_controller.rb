class BooksController < ApplicationController
  protect_form_forgery except: [:destroy] #
  
  def show
    @book = Book.find(params[:id]) #
    respond_to do |format| #
      format.html
      format.json
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
end
