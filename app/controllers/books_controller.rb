class BooksController < ApplicationController
 before_action :authenticate_user!
 
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user.id 
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
  if @book.save
     flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id)
  else
    @books = Book.all
    render :index
  end
  end

  def show
    @books = Book.all
    @book = Book.find(params[:id])
  end
  
  def update
      @book = Book.find(params[:id])
   if @book.update(book_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to book_path
   else 
      render :edit
   end
  end
  
  def edit
    @book = Book.find(params[:id])
  end

  
  def destroy
  @book = Book.find(params[:id])
  @book.destroy
  redirect_to books_path
  end

  private
  def book_params
   params.require(:book).permit(:title,:body,:image)
  end

end
