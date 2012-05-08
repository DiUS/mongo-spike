class OrdersController < ApplicationController
  # GET /Users
  # GET /Users.json
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders.size() }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /tests/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # Ensure retry upon failure
def rescue_connection_failure(max_retries=60)
  retries = 0
  begin
    yield
  rescue Mongo::ConnectionFailure => ex
    puts ex
    retries += 1
    raise ex if retries > max_retries
    sleep(0.5)
    retry
  end
end

  # POST /tests
  # POST /tests.json
  def create
    @order = Order.new JSON.parse request.body.read

    respond_to do |format|
      rescue_connection_failure do
        if @order.save
          format.html { redirect_to @order, notice: 'ORder was successfully created.' }
          format.json { render json: @order, status: :created, location: @order }
        else
          format.html { render action: "new" }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /tests/1
  # PUT /tests/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:user])
        format.html { redirect_to @order, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :ok }
    end
  end
end
