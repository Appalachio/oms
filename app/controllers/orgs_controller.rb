class OrgsController < ApplicationController
  before_action :set_org, only: %i[ show edit update archive restore destroy ]

  # GET /orgs or /orgs.json
  def index
    # Only load orgs that have not been archived
    # Paginate the orgs for view
    @orgs = Org.active.page(params[:page])
  end

  # GET /orgs/1 or /orgs/1.json
  def show
    # Redirect to the latest version of the org url if an old version was used
    if request.path != org_path(@org)
      redirect_to(@org, status: :moved_permanently)
    end
  end

  # GET /orgs/new
  def new
    @org = Org.new
  end

  # GET /orgs/1/edit
  def edit
    # Redirect to the latest version of the org url if an old version was used
    if request.path != edit_org_path(@org)
      redirect_to(edit_org_path(@org), status: :moved_permanently)
    end
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

  # PUT /orgs/1/archive or /orgs/1/archive.json
  # Soft deletes the org
  def archive
    @org.archive

    respond_to do |format|
      format.html { redirect_to @org, notice: "Organization was successfully archived. You can restore it at any time." }
      format.json { render :show, status: :ok, location: @org }
    end
  end

  # PUT /orgs/1/restore or /orgs/1/restore.json
  # Restores (un-soft deletes) the org
  def restore
    @org.restore

    respond_to do |format|
      format.html { redirect_to @org, notice: "Organization was successfully restored." }
      format.json { render :show, status: :ok, location: @org }
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
      @org = Org.friendly.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def org_params
      params.expect(org: [ :name, :subdomain, :domain, :color_scheme, :about, :logo ])
    end
end
