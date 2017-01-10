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

 

# dous = [{name: "TEst12", team_name: "afsdfbv", survey_area: "Alignment ODS"},
#  	{name: "TEst", team_name: "abv", survey_area: "Alignment ODS"},
#  	{name: "TEs2t", team_name: "a234bv", survey_area: "Alignment ODS"},
#  	{name: "fsdfewreEst", team_name: "ab123v", survey_area: "Alignment ODS"},
#  	{name: "awerEst", team_name: "421abv", survey_area: "Alignment ODS"},
#  	{name: "aEst", team_name: "234abv", survey_area: "Alignment ODS"},
#  	{name: "2214sEsft", team_name: "asdaabv", survey_area: "Alignment ODS"},
#  	{name: "dssadEst", team_name: "vxzcvxabv", survey_area: "Alignment ODS"},
#  	{name: "adsEst", team_name: "zxvcxcvxabv", survey_area: "Alignment ODS"},
#  	{name: "vbEst", team_name: "xr4tabv", survey_area: "Alignment ODS"},
#  	{name: "Tvst", team_name: "s fsfabv", survey_area: "Alignment ODS"},
#  	{name: "TEst12", team_name: "afsdfbv", survey_area: "Customer ODS"},
#  	{name: "TEst", team_name: "abv", survey_area: "Customer ODS"},
#  	{name: "TEs2t", team_name: "a234bv", survey_area: "Customer ODS"},
#  	{name: "fsdfewreEst", team_name: "ab123v", survey_area: "Customer ODS"},
#  	{name: "awerEst", team_name: "421abv", survey_area: "Customer ODS"},
#  	{name: "aEst", team_name: "234abv", survey_area: "Customer ODS"},
#  	{name: "2214sEsft", team_name: "asdaabv", survey_area: "Customer ODS"},
#  	{name: "dssadEst", team_name: "vxzcvxabv", survey_area: "Customer ODS"},
#  	{name: "adsEst", team_name: "zxvcxcvxabv", survey_area: "Customer ODS"},
#  	{name: "vbEst", team_name: "xr4tabv", survey_area: "Customer ODS"},
#  	{name: "Tvst", team_name: "s fsfabv", survey_area: "Customer ODS"},
#   ]

# dous.each do |dou|
# 	Dou.create(dou)
# end