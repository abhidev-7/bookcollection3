Rails.application.routes.draw do
  # Define routes for the books resource
  resources :books do
    # Add a member route to handle /books/:id/remove for the remove confirmation
    member do
      get 'remove'  # This adds a route to display the remove confirmation page
    end
  end

  # Set the root route to the index action of the BooksController
  root 'books#index'
end