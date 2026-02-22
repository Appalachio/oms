class OrgsController < ApplicationController
  before_action :set_org, only: %i[ show edit update destroy ]

  # GET /orgs or /orgs.json
  def index
    @orgs = Org.all
  end

  # GET /orgs/1 or /orgs/1.json
  def show
  end

  # GET /orgs/new
  def new
    @org = Org.new
  end

  # GET /orgs/1/edit
  def edit
  end

  # POST /orgs or /orgs.json
  def create
    @org = Org.new(org_params)

    respond_to do |format|
      if @org.save
        format.html { redirect_to @org, notice: "Org was successfully created." }
        format.json { render :show, status: :created, location: @org }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @org.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orgs/1 or /orgs/1.json
  def update
    respond_to do |format|
      if @org.update(org_params)
        format.html { redirect_to @org, notice: "Org was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @org }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @org.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orgs/1 or /orgs/1.json
  def destroy
    @org.destroy!

    respond_to do |format|
      format.html { redirect_to orgs_path, notice: "Org was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_org
      @org = Org.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def org_params
      params.expect(org: [ :org_uuid, :slug, :name, :subdomain, :domain, :color_scheme, :about, :logo, :archived_at ])
    end
end
