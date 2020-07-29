class BooksController < ApplicationController
before_action :authenticate_user!
before_action :correct_user, only: [:edit, :update, :destroy]

  def new
  	@book = Book.new
  end

  def create
  	@book = Book.new(book_params)
    @user = current_user
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      flash[:notice] = "created error"
      render :index
    end
  end

  def index
  	@books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
  	@book = Book.find(params[:id])
    @user = @book.user
    @newbook = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'Book was successfully updated.'
      redirect_to book_path(@book.id)
    else
      flash[:notice] = 'update error'
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
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    book = Book.find(params[:id])
    unless book.user == current_user
      redirect_to books_path
    end
  end

end
