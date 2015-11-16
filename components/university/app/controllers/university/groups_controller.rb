module University
class GroupsController < ApplicationController
  include University::Deletables::Destroy
  include University::Editables::Update

  include University::Events::Dispatch
  include University::Markdown::Process

  default_tab :all, only: :index

  before_action :authenticate_user!

  def create
    @group = University::Group.new(create_params)

    if @group.save
      flash[:notice] = t('group.create.success')

      redirect_to group_path(@group)
    else
      flash_error_messages_for @group

      redirect_to groups_path(tab: :all)
    end
  end

  def show
    @group     = University::Group.find(params[:id])
    @documents = @group.documents.order(created_at: :desc).page(params[:page]).per(20)

    authorize! :show, @group
  end

  def index
    authorize! :index, University::Group

    @groups = University::Group.accessible_by(current_ability)
    @groups = @groups.page(params[:page]).per(20)
  end

  private

  def create_params
    params.require(:group).permit(:title, :description, :visibility).merge(creator: current_user)
  end

  def update_params
    params.require(:group).permit(:title, :description, :visibility)
  end
end
end
