class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy follow unfollow followings]

  def followings
    @subjects = Subject.all
  end

  # GET /users or /users.json
  def index
    redirect_to subjects_path 
  end

  # GET /users/1 or /users/1.json
  def show
  if(!current_user ||current_user!=@user)
    redirect_to subjects_path 
  end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.type = if @user.num.length == 8
                   0 # 学生
                 else
                   1 # 老师
                 end
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: 'User was successfully created.' }
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
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def follow
    @subject = Subject.find(params[:subject_id])
    if @user.subjects && @user.subjects.include?(@subject)
      redirect_to subjects_path, notice: "您已经关注了项目 #{@subject.title}."
    else
      @user.subjects << @subject
      redirect_to subjects_path, notice: "成功关注项目 #{@subject.title}."
    end
  end

  def unfollow
    @subject = Subject.find(params[:subject_id])
    current_user.subjects.delete(@subject)
    redirect_to subjects_path, notice: "成功取消关注#{@subject.title}."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :password, :num, :type)
  end
end
