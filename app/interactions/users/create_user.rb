class CreateUser < ApplicationInteractor
  string :email, :first_name, :last_name, :password, :password_confirmation

  def execute
    User.create!(user_params)
  end

  private

  def user_params
    {
        email: email,
        first_name: first_name,
        last_name: last_name,
        password: password,
        password_confirmation: password_confirmation
    }
  end
end
