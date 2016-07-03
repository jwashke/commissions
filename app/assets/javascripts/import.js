$('.imports.show').ready(function () {
  $('#newImportInfo').hide();
  checkStatusFunc();
});

var checkStatusInterval = 30000; // 3 seconds
var checkStatusFunc = function(){
  $.getJSON('/api/v1/import', function(importData){
    if (importData.status === "processing"){
      $('#latestImportHeader').text('Uploading File');
      checkStatusTimer = setTimeout(checkStatusFunc, checkStatusInterval);
    } else {
      render_latest_import_status(importData);
    }
  });
};
var checkStatusTimer = setTimeout(checkStatusFunc,checkStatusInterval );
var render_latest_import_status = function(importData) {
  $('#loadingIcon').hide();
  $('#newImportInfo').show();
  $('#latestImportHeader').text('Latest Import')
  $('#ImportCompletedIn').text(importData.total_time + ' seconds');
  $('#ImportCurrentActiveRecords').text(importData.current_quantity_active);
}
