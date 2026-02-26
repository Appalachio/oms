class UsersController < ApplicationController
  before_action :set_user, except: [ :index ]

  # GET /users or /users.json
  def index
    # Only load useres that have not been archived
    # Paginate the users for view
    @users = User.order(confirmed_at: :desc).active.page(params[:page])
  end

  # GET /users/1 or /users/1.json
  def show
    # Redirect to the latest version of the user url if an old version was used
    if request.path != user_path(@user)
      redirect_to(@user, status: :moved_permanently)
    end
  end

  # PUT /users/1/archive or /users/1/archive.json
  # Soft deletes the user
  def archive
    @user.archive

    respond_to do |format|
      format.html { redirect_to @user, notice: "User was successfully archived. You can restore it at any time." }
      format.json { render :show, status: :ok, location: @user }
    end
  end

  # PUT /users/1/restore or /users/1/restore.json
  # Restores (un-soft deletes) the user
  def restore
    @user.restore

    respond_to do |format|
      format.html { redirect_to @user, notice: "User was successfully restored." }
      format.json { render :show, status: :ok, location: @user }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.friendly.find(params.expect(:id))
    end
end
