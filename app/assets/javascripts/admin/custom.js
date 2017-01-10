$(document).on('turbolinks:load', function() {
// setTimeout(function() {
	$('#userSurveysDatatable').removeClass( 'display' ).addClass('table table-striped table-bordered');
  oTable = $('#userSurveysDatatable').DataTable({
        dom: 'Bfrtip',
        buttons: [  { extend: 'excelHtml5', text: "Export Excel", className: "btn btn-primary exportExcelBtn" } ]
    ,               "lengthChange":   false,
  	                      "sPaginationType": "full_numbers",
  	                      "bJQueryUI": true,
  	                      "bProcessing": true,
  	                       "bServerSide": true,
                         "sAjaxSource": $('#userSurveysDatatable').data('source')
  	                    });

          $('#btnSurveyFilter').on('click', function () {
            oTable.columns(1).search($('#surveyTypeSelect').val());
            oTable.columns(3).search($('#surveyEnvSelect').val());
            oTable.columns(4).search($('#surveyRspSelect').val());
            oTable.draw();
          });
// }, 2000);
});


// $('#tabDetail').dataTable({
// "bProcessing": true,
// "bServerSide": true,
// "sPaginationType": "full_numbers",
// "sAjaxSource": "serverSide_general.php",
// "fnServerData": function( sUrl, aoData, fnCallback ) {
// $.ajax( {
// "url": sUrl,
// "data": aoData,
// "success": fnCallback,
// "dataType": "json",
// "cache": false
// } );
// }
// }).columnFilter({aoColumns:[
// { type:"input", sSelector: "#usagerFilter"  },
// { type:"input" },
// { type:"input" },
// { type:"select", values: ["val1", "val2"] }
// ]});