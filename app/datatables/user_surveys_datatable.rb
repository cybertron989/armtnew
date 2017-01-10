class UserSurveysDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: UserSurvey.count,
      iTotalDisplayRecords: user_surveys.total_entries,
      aaData: data
    }
  end

private

  def data
    user_surveys.map do |user_survey|
      [
        user_survey.user_id,
        user_survey.survey_type,
        user_survey.schema_area,
        user_survey.environment,
        user_survey.response,
        user_survey.dou,
        user_survey.created_at.strftime("%B %e, %Y")
      ]
    end
  end

  def user_surveys
    @user_surveys ||= fetch_user_surveys
  end

  def fetch_user_surveys
    user_surveys = UserSurvey.order("#{sort_column} #{sort_direction}")
    user_surveys = user_surveys.page(page).per_page(per_page)
    if params[:sSearch].present?
      user_surveys = user_surveys.where("user_id like :search or dou like :search", search: "%#{params[:sSearch]}%")
    end
    user_surveys
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[user_id survey_type schema_area environment response dou created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end