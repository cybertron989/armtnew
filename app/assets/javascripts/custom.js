$(document).on('turbolinks:load', function() {
    $('.registration-form fieldset').first().fadeIn('slow');
    showSurveyDOU();
    $('.registration-form input[type="text"]').on('focus', function () {
        $(this).removeClass('input-error');
    });

    // next step
    $('.registration-form .btn-next').on('click', function () {
        var parent_fieldset = $(this).parents('fieldset');
        var next_step = true;

        parent_fieldset.find('input[type="text"],input[type="email"]').each(function () {
            if ($(this).val() == "") {
                $(this).addClass('input-error');
                next_step = false;
            } else {
                $(this).removeClass('input-error');
            }
        });

        if (next_step) {
            parent_fieldset.fadeOut(400, function () {
                $(this).next().fadeIn();
                showSurveyDOU();
            });
        }

    });

    // previous step
    $('.registration-form .btn-previous').on('click', function () {
        $(this).parents('fieldset').fadeOut(400, function () {
            $(this).prev().fadeIn();
            showSurveyDOU();
        });
    });

    // submit
    $('.registration-form').on('submit', function (e) {

        $(this).find('input[type="text"],input[type="email"]').each(function () {
            if ($(this).val() == "") {
                e.preventDefault();
                $(this).addClass('input-error');
            } else {
                $(this).removeClass('input-error');
            }
        });

    });    
   
});

function showSurveyDOU(){
  var input_radio_field = ".registration-form fieldset:visible input[type=radio]"
  var survey_dou_block  = ".registration-form fieldset:visible .survey-dou"
  $(input_radio_field).on('click', function(){
    btnNextActive(input_radio_field);
    if($(input_radio_field+"[value=true]:checked").length==0){
      $(survey_dou_block).hide("slow");
      if($(".registration-form fieldset:visible .survey-dou-select").val() != ""){setDouField("", "Select a DOU");}      
    }
    else if( $(input_radio_field+"[value=true]:checked").length > 0 && $(survey_dou_block+":visible").length==0){
      $(survey_dou_block).show("slow");
       toggleBtnState(true);
    }

  });
  

}

function toggleBtnState(state){
  var next_btn_ele   =  ".registration-form fieldset:visible .btn-next"
  var submit_btn_ele =  ".registration-form fieldset:visible .submit-survey-btn"
  if ($(next_btn_ele)[0]) $(next_btn_ele)[0].disabled=state
  if ($(submit_btn_ele)[0]) $(submit_btn_ele)[0].disabled=state
}

function douDataTable(){
  $('#douTable').removeClass( 'display' ).addClass('table table-striped table-bordered');
  $('#douTable').DataTable({"lengthChange":   false});  

  $("#douTable tbody tr").on("click", function(){
    var selected_dou = $(this).attr("data-dou")
    $("#douTable tbody tr").removeClass("douSelectRow")
    $(this).addClass("douSelectRow");
    setDouField(selected_dou, selected_dou)   
    btnNextActive(".registration-form fieldset:visible input[type=radio]")
  });  
}

function btnNextActive(input_radio_field){
  if(($(input_radio_field+":checked").length == ($(input_radio_field).length/2)) && (($(input_radio_field+"[value=true]:checked").length > 0 && $(".survey-dou-select").val() != "") || ($(input_radio_field+"[value=true]:checked").length == 0)))
  {
    toggleBtnState(false);
  }
}

function setDouField(val, show_txt){
  $(".registration-form fieldset:visible .douSurveyArea").text(show_txt)
  $(".registration-form fieldset:visible .survey-dou-select").val(val);
}