(function ( $ ) {
  $.fn.basicTable = function( options ) {

    // This is the easiest way to have default options.
    var settings = $.extend({
    'model' : null,
		'url' : null,
    'dataObject' : null,
    'params': null,
    'dataCols' : null,
    'dataColNames' : null
    }, options );

    //===================================== vars =======================================//
    var model = settings.model;
    var dataObject = settings.dataObject;
    var dataCols = settings.dataCols;
    var dataColNames = settings.dataColNames;
    var rows = '';
    var that = this;

    //===================================== Functions =======================================//

      for (var i=0; i<dataObject.length; i+=1){
          var tds = '';
          for (var j=0; j<dataCols.length; j+=1){
            if (dataObject[i][dataCols[j]]){
              if (dataCols[j]=='tags'){
                var tags = dataObject[i][dataCols[j]];
                var links = '';
                for (var k=0; k<tags.length; k+=1){
                  links += '<a href="tag_show.html?id='+tags[k]['id']+'&name='+tags[k]['text']+'">'+tags[k]['text']+'</a>'; 
                }
                tds += '<td>'+links+'</td>';
              }else if(dataCols[j]=='project_title'){
                tds += '<td><a href="'+model+'_show.html?id='+dataObject[i]['_id'].$oid+'&name='+dataObject[i]['project_title']+'">'+dataObject[i][dataCols[j]]+'</a></td>';
              }else{
                tds += '<td>'+dataObject[i][dataCols[j]]+'</td>';
              }
            }else{
              tds += '<td></td>';
            }
          }
          rows += '<tr id="'+dataObject[i]['_id'].$oid+'">'+tds+'</tr>';
        }
        var headTds = '';
        for (var k=0;k<dataColNames.length; k+=1){
          headTds += '<td><b>'+dataColNames[k]+'</b></td>';
        }
        var head = '<thead>'+headTds+'</thead>';
        var body = '<tbody>'+rows+'</tbody>';
        var table = '<table class="table table-bordered table-striped table-condensed">'+head+body+'</table>';

        $(that).html(table);
    
    var select2Array = [];
  $.get('/tags', function(data){
   for(var i=0;i<data.length;i+=1){
    select2Array.push({id:data[i]._id.$oid, text:data[i].name});
   }
    // $(".select2").select2({
    //     data:select2Array,
    //     multiple: true,
    //     width: "200px"
    // });
    // $('.select2').select2('data', grant.tags);
});


  };
}( jQuery ));