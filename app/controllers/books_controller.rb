class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @bookbook = Book.new
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book),notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
      flash[:alert]
    end
  end

  def edit
    @book = Book.find(params[:id])
    good_user(@book)
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
      flash[:alert]
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def good_user(book)
    if book.user.id != current_user.id
      redirect_to books_path
    end
  end

end
