module Api 
    module V1
        class  BooksController < ApplicationController
            def index
                books = Book.order('created_at DESC');
                render json: {status: 'success', message: 'Loaded books', data: books}, status: :ok   
            end

            def show
                book = Book.find(params[:id])
                render json: {status: 'success', message: 'Load book', data: book }, status: :ok
            end

            def create
                book = Book.new(book_params)
                if book.save
                    render json: {status: 'success', message: 'Saved book', data: book }, status: :ok
                else
                    render json: {status: 'error', message: 'Book not save', data: book.errors }, status: :unprocessable_entity
                end
            end

            def destroy
                book = Book.find(params[:id])
                book.destroy
                render json: {status: 'success', message: 'Deleted book', data: book}, status: :ok
            end

            def update
                book = Book.find(params[:id])
                if book.update_attributes(book_params)
                    render json: {status: 'success', message: 'Updated book', data: book }, status: :ok
                else
                    render json: {status: 'error', message: 'Book not updated', data: book.errors }, status: :unprocessable_entity
                end

            end


            private def book_params
                params.permit(:title, :body)
            end

            
        end
    end
end
