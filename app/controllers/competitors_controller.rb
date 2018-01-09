class CompetitorsController < ApplicationController
  def new
    @competitor = Competitor.new(domain_id: params[:domain_id])
  end

  def create
    @competitor = Competitor.new(competitor_params)
    @competitor.save
  end

  def update
    @competitor = Competitor.find(params[:id])
    @competitor.update_attributes(competitor_params)

    respond_with_bip(@competitor)
  end

  def destroy
    @competitor = Competitor.find(params[:id])
    @competitor.destroy
    redirect_to domain_path(@competitor.domain)
  end

  private

  def competitor_params
    params
      .require(:competitor)
      .permit(:name, :business, :domain_id, :position)
  end
end
