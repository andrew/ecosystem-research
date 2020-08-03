class RepositoriesController < ApplicationController
  def index
    @page_title = 'Internal Repositories'
    @scope = Repository.internal

    @scope = @scope.this_period(params[:range].to_i) if params[:range].present?

    @scope = @scope.org(params[:org]) if params[:org].present?
    @scope = @scope.language(params[:language]) if params[:language].present?
    @scope = @scope.fork(params[:fork]) if params[:fork].present?
    @scope = @scope.archived(params[:archived]) if params[:archived].present?

    @sort = params[:sort] || 'score'
    @order = params[:order] || 'desc'

    respond_to do |format|
      format.html do
        @pagy, @repositories = pagy(@scope.order(@sort => @order))

        @orgs = @scope.unscope(where: :org).internal.group(:org).count
        @languages = @scope.unscope(where: :language).group(:language).count
      end
      format.rss do
        @pagy, @repositories = pagy(@scope.order(@sort => @order))
        render 'index', :layout => false
      end
      format.json do
        @pagy, @repositories = pagy(@scope.order(@sort => @order))
        render json: @repositories
      end
    end
  end

  def show
    @repository = Repository.find(params[:id])
    @manifests = @repository.manifests.includes(repository_dependencies: {package: :versions}).order('kind DESC')
    @results = @repository.search_results.limit(10).order('created_at DESC')
  end

  def collab_repositories
    @page_title = 'Collaborator Repositories'
    @scope = Repository.external.where('score >= 0')
    @scope = @scope.this_period(params[:range].to_i) if params[:range].present?
    @scope = @scope.org(params[:org]) if params[:org].present?
    @scope = @scope.language(params[:language]) if params[:language].present?
    @scope = @scope.fork(params[:fork]) if params[:fork].present?
    @scope = @scope.archived(params[:archived]) if params[:archived].present?

    @sort = params[:sort] || 'score'
    @order = params[:order] || 'desc'

    respond_to do |format|
      format.html do
        @pagy, @repositories = pagy(@scope.order(@sort => @order))

        @orgs = @scope.unscope(where: :org).external.group(:org).count
        @languages = @scope.unscope(where: :language).group(:language).count
      end
      format.rss do
        @pagy, @repositories = pagy(@scope.order(@sort => @order))
        render 'index', :layout => false
      end
      format.json do
        @pagy, @repositories = pagy(@scope.order(@sort => @order))
        render json: @repositories
      end
    end
  end

  def community
    @page_title = 'Community Repositories'
    @scope = Repository.community.where('score >= 0')
    @scope = @scope.this_period(params[:range].to_i) if params[:range].present?
    @scope = @scope.org(params[:org]) if params[:org].present?
    @scope = @scope.language(params[:language]) if params[:language].present?
    @scope = @scope.fork(params[:fork]) if params[:fork].present?
    @scope = @scope.archived(params[:archived]) if params[:archived].present?

    @sort = params[:sort] || 'score'
    @order = params[:order] || 'desc'

    respond_to do |format|
      format.html do
        @pagy, @repositories = pagy(@scope.order(@sort => @order))

        @orgs = @scope.unscope(where: :org).community.group(:org).count
        @languages = @scope.unscope(where: :language).group(:language).count
        render :collab_repositories
      end
      format.rss do
        @pagy, @repositories = pagy(@scope.order(@sort => @order))
        render 'index', :layout => false
      end
      format.json do
        @pagy, @repositories = pagy(@scope.order(@sort => @order))
        render json: @repositories
      end
    end
  end
end
