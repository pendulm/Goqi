class FriendshipsController < ApplicationController
  # GET /friendships
  # GET /friendships.json
  def index
    @user = User.find(session[:uid])
    @friendships = Friendship.includes(:friend).where(from: @user.id, status: true)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @friendships }
    end
  end

  # GET /friendships/1
  # GET /friendships/1.json
  def show
    @friendship = Friendship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @friendship }
    end
  end

  # GET /friendships/new
  # GET /friendships/new.json
  def new
    @friendship = Friendship.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @friendship }
    end
  end

  # GET /friendships/1/edit
  def edit
    @friendship = Friendship.find(params[:id])
  end

  # POST /friendships
  # POST /friendships.json
  def create
    @friendship = Friendship.new(params[:friendship])

    respond_to do |format|
      if @friendship.save
        format.html { redirect_to @friendship, notice: 'Friendship was successfully created.' }
        format.json { render json: @friendship, status: :created, location: @friendship }
      else
        format.html { render action: "new" }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /friendships/1
  # PUT /friendships/1.json
  def update
    @friendship = Friendship.find(params[:id])

    respond_to do |format|
      if @friendship.update_attributes(params[:friendship])
        format.html { redirect_to @friendship, notice: 'Friendship was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy

    respond_to do |format|
      format.html { redirect_to friendships_url }
      format.json { head :no_content }
    end
  end

  def fsend
    receiver = User.find_by_email params[:email]
    user = get_current_user
    if receiver
      @friendship = Friendship.new(from: user.id, to: receiver.id)
      if user.id != receiver.id and @friendship.save
        msg = "your appling is hanging"
      else
        msg = "can't build friendship"
      end
    else
      msg = "this user not exist"
    end
    redirect_to friendships_url, notice: msg
  end
  
  def receive
    user = get_current_user
    @friendships = Friendship.where(status: false, to: user.id)
  end

  def accept
    friendship = Friendship.find(params[:id])
    friendship.status = true
    friendship.save
    Friendship.create(from: friendship.to, to: friendship.from)
    redirect_to friendships_url
  end

  def reject
    friendship = Friendship.find(params[:id])
    friendship.destroy
    redirect_to receive_friendships_url
  end
end
