class Administration::DashboardController < AdministrationController
  default_tab :categories, only: :index

  def index
    authorize! :administrate, nil

    @categories = Category.order(:name)
    @changelogs = Changelog.all.sort

    @category  = Category.new
    @changelog = Changelog.new
  end
end
