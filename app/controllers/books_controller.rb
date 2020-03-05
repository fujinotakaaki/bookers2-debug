class BooksController < ApplicationController
  before_action :baria_user, only: [:edit, :update]

  def show
  	@book = Book.find(params[:id])
  end

  def index
    @book = Book.new
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
  end

  def create
    # logger.debug "ここ見ろカス"
    # logger.debug book_params
  	@book = current_user.books.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    # logger.debug "ここ見ろカス@book ="
    # logger.debug @book.inspect
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to @book, notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
      # logger.debug "ここ見ろカス@book.errors. ="
      # logger.debug @book.errors.count
      # logger.debug @book.errors.full_messages.inspect
  		@books = Book.all
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
  	book = Book.find(params[:id])
    book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end

  def baria_user
    unless Book.find(params[:id]).user_id == current_user.id
      redirect_to books_path
    end
  end

end
