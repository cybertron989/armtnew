class UserSurveysDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: area_user_surveys.count,
      iTotalDisplayRecords: user_surveys.total_entries,
      aaData: data
    }
  end

  def as_excel(options = {})
    data
  end

private

  def data
    user_surveys.map do |user_survey|
      [
        user_survey.user_id,
        user_survey.survey_type,
        user_survey.schema_area,
        user_survey.environment,
        user_survey.response? ? "Yes" : "No",
        user_survey.dou,
        user_survey.created_at.strftime("%B %e, %Y")
      ]
    end
  end

  def user_surveys
    @user_surveys ||= fetch_user_surveys
  end

  def area_user_surveys
    UserSurvey.where(area: params[:area]||"Customer ODS")
  end

  def fetch_user_surveys
    user_surveys = area_user_surveys.order("#{sort_column} #{sort_direction}")
    user_surveys = user_surveys.page(page).per_page(per_page) if params[:iDisplayLength] != 'All'
    if params[:sSearch_1].present? || params[:sSearch_3].present? || params[:sSearch_4].present? 
      user_surveys = user_surveys.survey_type_filter(params[:sSearch_1]).environment_filter(params[:sSearch_3]).survey_response_filter(params[:sSearch_4])
    end
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
    columns = UserSurvey::TableColumn
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end