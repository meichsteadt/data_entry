class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    if params[:category] && params[:category] != ""
      @category = params[:category]
      @products = Category.find_by_name(params[:category]).products
    end
    if params[:no_price]  && params[:no_price] != ""
      @no_price = true
      @products = @products.where(price: nil)
    end
    if params[:brand] && params[:brand] != ""
      @brand = params[:brand]
      @products = @products.where(brand: params[:brand])
    end
    if params[:done] && params[:done] != ""
      @done = true
      @products = @products.where(done: true)
    else
      @products = @products.where(done: false)
    end
    if params[:page_number]
      @products = @products.page(params[:page_number])
    else
      @products = @products.page(1)
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
        format.js
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        @product.categories.each do |category|
          @product.categories.delete(category)
        end
        if params[:product][:category_ids]
          params[:product][:category_ids].each do |id|
            @product.categories.push(Category.find(id))
          end
        end
        @product.update(done: true)
        format.js
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.js
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :category_ids)
    end
end
