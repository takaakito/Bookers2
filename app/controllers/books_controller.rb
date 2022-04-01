class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, {only: [:edit,:update,:destroy]}
  
  def index
    @book = Book.new
    @users = User.all
    @user = current_user
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
  if @book.save
     flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id)
  else
    @user = current_user
    @books = Book.all
    render :index
  end
  end

  def show
    @books = Book.all
    @book = Book.find(params[:id])
    @user = current_user
  end
  
   def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
        render "edit"
    else
        redirect_to books_path
    end
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
  
  def destroy
  @book = Book.find(params[:id])
  @book.destroy
  redirect_to books_path
  end
  
  private

  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
  
  
   def  ensure_current_user
      @book = Book.find(params[:id])
     if @book.user_id != current_user.id
        redirect_to books_path
     end
  end
end
