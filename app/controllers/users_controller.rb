class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :logged_in, except: %i[index main login new create ]
  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    if logged_in
    else
      return
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.posts.each do |p|
      p.destroy
    end
    @user.destroy
    # respond_to do |format|
    #   format.html { redirect_to users_url, notice: "User was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  def create_fast
    name = params[:name]
    email = params[:email]
    @user = User.create(name:name,email:email)

  end

  def destroy_all
    Post.all.each do |p|
      p.destroy
    end
    User.destroy_all
    redirect_to users_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name, :birthdate ,:postal_code ,:address ,:password)
    end

    def logged_in
      if(session[:user_id] == @user.id)
        return true
      else
        redirect_to main_path , notice: "Please login"
      end
    end


    public
      def main
        session[:user_id] = nil
        @user = User.new()
      end



      def login
        @user = User.new(user_params)

       respond_to do |format|
            if @user.login
              session[:user_id] = @user.id
              format.html { redirect_to user_path(@user.id) }

            else
              session[:user_id] = nil
              format.html { render :main, status: :unprocessable_entity }
            end
        end
      end


end
