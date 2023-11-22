class DiscussionsController < ApplicationController
  before_action :set_discussion, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  # GET /discussions or /discussions.json
  def index
    @discussions = Discussion.all
  end

  # GET /discussions/1 or /discussions/1.json
  def show; end

  # GET /discussions/new
  def new
    @discussion = Discussion.new
  end

  # GET /discussions/1/edit
  def edit; end

  # POST /discussions or /discussions.json
  def create
    @subject = Subject.find(params[:subject_id])
    @discussion = Discussion.new(discussion_params)
    @discussion.subject = @subject
    @discussion.user = current_user
    # @discussion.discussion = @discussion if @discussion.discussion.nil?
    # @comment.user = current_user

    respond_to do |format|
      if @discussion.save
        format.html { redirect_to @subject, notice: '已成功发送讨论' }
        format.json { render :show, status: :created, location: @discussion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /discussions/1 or /discussions/1.json
  def update
    respond_to do |format|
      if @discussion.update(discussion_params)
        format.html { redirect_to discussion_url(@discussion), notice: '讨论成功更新.' }
        format.json { render :show, status: :ok, location: @discussion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discussions/1 or /discussions/1.json
  def destroy
    @subject = @discussion.subject
    @discussion.destroy!
    respond_to do |format|
      format.html { redirect_to @subject, notice: '讨论已被删除.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def discussion_params
    params.require(:discussion).permit(:content)
  end
end
