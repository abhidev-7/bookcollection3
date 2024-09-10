class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy remove]

  # GET /books
  def index
    @books = Book.all
  rescue => e
    flash[:notice] = "Error in retrieving books, please check the database connection."
    puts e.message
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # POST /books
  def create
    @book = Book.new(book_params)

    if @book.save
      flash[:notice] = "Book '#{@book.title}' was successfully created."
      redirect_to books_path
    else
      flash[:notice] = "Error: Invalid entry. Please check the input and try again."
      render :new, status: :unprocessable_entity
    end
  end

  # GET /books/:id
  def show
    # No flash notice needed for the show action
  end

  # GET /books/:id/edit
  def edit
  end

  # PATCH/PUT /books/:id
  def update
    if @book.update(book_params)
      flash[:notice] = "Book '#{@book.title}' was successfully updated."
      redirect_to book_path(@book)
    else
      flash[:notice] = "Error in editing the book. Please try again."
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /books/:id
  def destroy
    if @book.destroy
      flash[:notice] = "Book '#{@book.title}' was successfully removed."
      redirect_to books_path
    else
      flash[:notice] = "Error in deleting the book. Please try again."
      redirect_to books_path
    end
  end

  # GET /books/:id/remove
  def remove
    # The remove view confirms the delete operation; flash set upon deletion
  end

  private

  def set_book
    @book = Book.find_by(id: params[:id])
    unless @book
      flash[:notice] = "Book not found."
      redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title)
  end
end
