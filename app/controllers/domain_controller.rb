class DomainController < ApplicationController
  def index
    @domains = Domain.all
  end

  def new; end

  def edit
    @domain = Domain.find(params[:id])
  end
end

