# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Survey Type
SURVEY_TYPES= [
 {name: "Database", has_environment: true},
 {name: "Linux", has_environment: true}, 
 {name: "Informatica", has_environment: true},
 {name: "HPQC", has_environment: false}
]

SURVEY_TYPES.each do |st|
	survey_type = SurveyType.find_or_initialize_by(name: st[:name])
	survey_type.has_environment = st[:has_environment]
	survey_type.save!
end

#Create Survey Area
SURVEY_AREAS = ["Alignment ODS", "Customer ODS", "Activity ODS"]
SURVEY_AREAS.each do |sa|
	survey_area = SurveyArea.find_or_initialize_by(name: sa)
	survey_area.save!
end

dous = [{name: "Customer-DOU-Activity_management_tool-001", team_name: "Activity", survey_area: "Customer ODS"},
{name: "Customer-DOU-ACTODS-002", team_name: "Activity", survey_area: "Customer ODS"},
{name: "Customer-DOU-ADM-002", team_name: "Alignment", survey_area: "Customer ODS"},
{name: "Customer-DOU-Analytics Solution-001", team_name: "Analytics Solution", survey_area: "Customer ODS"},
{name: "Customer-DOU-BU_IT_Architecture-001", team_name: "BU IT", survey_area: "Customer ODS"},
{name: "Material-DOU-Activity Management Tool(AMT)-001", team_name: "Activity", survey_area: "Activity ODS"},
{name: "Material-DOU-ADM-001", team_name: "Alignment", survey_area: "Activity ODS"},
{name: "Material-DOU-Eureka-001", team_name: "Eureka", survey_area: "Activity ODS"},
{name: "Material-DOU-Integrated Data Platform (IDP)-001", team_name: "IDP", survey_area: "Activity ODS"},
{name: "Material-DOU-Polaris_ASRMS-001", team_name: "Polaris", survey_area: "Activity ODS"},
{name: "Alignment-DOU-DataSteward_Access-001", team_name: "Data Steward", survey_area: "Alignment ODS" },
{name: "Alignment-DOU-POLARIS-002", team_name: "Polaris", survey_area: "Alignment ODS" },
{name: "Alignment-DOU-GAIP-002", team_name: "Global KAM", survey_area: "Alignment ODS" },
{name: "Alignment-DOU-Japan_Harmony_Project-001", team_name: "Japan Harmony", survey_area: "Alignment ODS" },
{name: "Alignment-DOU-EUREKA_V7-001", team_name: "EUREKA COE TEAM", survey_area: "Alignment ODS" },
{name: "Alignment-DOU-TPO-001", team_name: "TPO", survey_area: "Alignment ODS" },
{name: "Alignment-DOU-TLAC-001", team_name: "TLAC", survey_area: "Alignment ODS" },
{name: "Alignment-DOU-Future_Foundation-001", team_name: "Future Foundation", survey_area: "Alignment ODS" },
{name: "Alignment-DOU-Activity-002", team_name: "Activity", survey_area: "Alignment ODS" },
{name: "Alignment-DOU-Customer-001", team_name: "Customer", survey_area: "Alignment ODS" }]

dous.each do |dou|
	Dou.create(dou)
end