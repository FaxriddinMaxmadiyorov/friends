class FriendsController < ApplicationController
  before_action :set_friend, only: %i[ show edit update destroy initialize_chat private_chat]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :destroy, :update]

  # GET /friends or /friends.json
  def index
    @friends = Friend.all
  end

  # GET /friends/1 or /friends/1.json
  def show
    @friend_been_registered = false
    @friend_been_registered = true if User.where(email: @friend.email).exists?

    @already_chat_initialized = false
    @second_user = User.find_by_email(@friend.email)
    @already_chat_initialized = true if ChatRoom.where(first_user: current_user, second_user: @second_user).exists? ||
                                        ChatRoom.where(first_user: @second_user, second_user: current_user).exists?
  end

  # GET /friends/new
  def new
    @friend = Friend.new
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends or /friends.json
  def create
    @friend = Friend.new(friend_params)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully created." }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully updated." }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    @friend.destroy

    respond_to do |format|
      format.html { redirect_to friends_url, notice: "Friend was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def correct_user
    @friend = current_user.friends.find_by(id: params[:id])
    redirect_to friends_path, notice: "Not Authorized to EDIT this friend" if @friend.nil?
  end

  def initialize_chat
    last_chat_room = ChatRoom.last
    name = "chat_room##{last_chat_room.id}"
    ChatRoom.create(name: name, first_user: current_user, second_user: User.find_by_email(@friend.email))
    byebug
    redirect_to private_chat_friend_path(@friend)
  end

  def private_chat
    @friends = @friend.user.friends
    @chat_rooms = ChatRoom.where(first_user: current_user).or(ChatRoom.where(second_user: current_user))
    @chat_room = ChatRoom.where(first_user: current_user, second_user: @friend.user).or(ChatRoom.where(first_user: current_user, second_user: @friend.user)).last
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friend_params
      params.require(:friend).permit(:first_name, :last_name, :email, :phone, :user_id)
    end
end
