$(document).on('turbolinks:load', function() {
// setTimeout(function() {
  removeReminderInput();
	$('#userSurveysDatatable').removeClass( 'display' ).addClass('table table-striped table-bordered');
  oTable = $('#userSurveysDatatable').DataTable({
                    // dom: 'Bfrtip',
                    // buttons: [  { extend: 'excelHtml5', text: "Export Excel", className: "btn btn-primary exportExcelBtn" } ], 
                    "lengthChange":   false,
                    "sPaginationType": "full_numbers",
                    "bJQueryUI": true,
                    "bProcessing": true,
                    "bServerSide": true,
                    "sAjaxSource": $('#userSurveysDatatable').data('source')
                  });

    $('#showSurveysDatatable').DataTable({
                    "lengthChange":   false,
                    "sPaginationType": "full_numbers",
                    "bJQueryUI": true,
                    "bProcessing": true                    
                  });

  

  $('#btnSurveyFilter').on('click', function () {
    oTable.columns(1).search($('#surveyTypeSelect').val());
    oTable.columns(3).search($('#surveyEnvSelect').val());
    oTable.columns(4).search($('#surveyRspSelect').val());
    oTable.draw();
  });

  $('#btnSvyExportXl').on('click', function () {
    iSortCol_0 = oTable.order()[0][0]
    sSortDir_0 = oTable.order()[0][1]
    sSearch = oTable.search()
    sSearch_1 = oTable.columns(1).search()[0]
    sSearch_3 = oTable.columns(3).search()[0]
    sSearch_4 = oTable.columns(4).search()[0]
    url = "/admin/surveys/export_excel.xlsx?iSortCol_0="+iSortCol_0+"&sSortDir_0="+sSortDir_0+"&sSearch="+sSearch+"&sSearch_1="+sSearch_1+"&sSearch_3="+sSearch_3+"&sSearch_4="+sSearch_4+"&iDisplayLength=All"
    window.location = url
  });
// }, 2000);


  $(".datepick").datepicker({startDate: new Date});

  $('#addNewReminder').on('click', function() {
    // var cloneInp = $(".reminderFirst").html();
    var cloneInp = '<input type="text" name="reminders[]" id="reminders_" class="form-control mar5 datepick" placeholder="MM/DD/YYYY" readonly="readonly">'
    cloneInp = "<div class='col-sm-12'><span class='col-sm-6'>" + cloneInp + '</span><a class="col-sm-3 removeNewReminder" href="javascript:void(0)"><span class="glyphicon glyphicon-trash"></span>Remove</a></div>'
    // cloneInp = '<span>'+cloneInp + '<a class="col-sm-2 removeNewReminder" href="javascript:void(0)">Remove</a>'+'</span>'
    $(".datepick").datepicker('destroy');
    $("#newReminderDiv").append(cloneInp)
    $(".datepick").datepicker({startDate: new Date});
    removeReminderInput();
  });

  $('#reminder-form').on('submit', function (e) {

    $(this).find('input[type="text"],input[type="email"], textarea').each(function () {
        if ($(this).val() == "") {
            e.preventDefault();
            $(this).addClass('input-error');
        } else {
            $(this).removeClass('input-error');
        }
    });
  });

  $('#reminder-form input, #reminder-form textarea').on('focusin', function(e){
    if($(this).hasClass("input-error")){
      $(this).removeClass("input-error")
    }
  })

});

function removeReminderInput(){
   $(".removeNewReminder").on('click', function() {
    $(this).parent().remove();
  });
}

