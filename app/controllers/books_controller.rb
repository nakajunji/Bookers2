class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
	
	def new
		@book = Book.new
	end

	def create
		@books = Book.all
		@user = current_user
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			flash[:notice] = "You have creatad book successfully."
			redirect_to book_path(@book.id)
		else
			render "index"
		end
	end

	def index
		@book = Book.new
		@books = Book.all
		@user = current_user
	end

	def show
		@book = Book.new
		@post_book = Book.find(params[:id])
		@user = User.find(@post_book.user_id)
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			flash[:notice] = "You have updated book successfully."
			redirect_to book_path(@book.id)
		else
			render "edit"
		end
	end

	def destroy
		@post_book = Book.find(params[:id])
		@post_book.destroy
		redirect_to books_path
	end

	def ensure_correct_user
		@post_book = Book.find(params[:id])
		if @post_book.user_id != current_user.id
			redirect_to books_path
		end
	end

	private
	def book_params
		params.require(:book).permit(:title, :body, :user_id)
	end
end
