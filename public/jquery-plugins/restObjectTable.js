(function ( $ ) {
  $.fn.restObjectTable = function( options ) {

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
    var url = settings.url;
    var dataObject = settings.dataObject;
    var params = settings.params;
    var dataCols = settings.dataCols;
    var dataColNames = settings.dataColNames;
    var rows = '';
    var that = this;
    var fetchedData;

    //===================================== Functions =======================================//
    function getRowData(row){
      var counter = 0;
      var data = {};
        row.find('input').each(function(){
          data[dataCols[counter]] = $(this).val();
          counter +=1;
        });
        return data;
    }
    function editRow(){

    }
    function create(row){
      var payload = {};
      payload[model]=getRowData(row);
      $.post(url, payload, function(data){
        row.attr('id',data._id.$oid);
      })
      .fail(function(msg) {
      });
    }
    function update(row){
      var payload = {};
      payload[model]=getRowData(row);
      $.ajax({
        type: "PUT",
        url: url + "/" + row.attr('id') + ".json",
        data: payload
      })
        .done(function( msg ) {
        });
    }
    function remove(row){
      $.ajax({
        type: "DELETE",
        url: url + "/" + row.attr('id'),
        dataType : 'json'
      })
        .done(function( msg ) {
          row.remove();
        })
        .fail(function(msg)  {
        });
    }

    $(this).on('click', '.update', function(){
      update($(this).parent().parent());
      var row = $(this).parent().parent();
      row.find('input').each(function() {
        var cellVal = $(this).val();
        $(this).parent().html(cellVal);
      });
      $(this).parent().html('<button class="edit-row btn">Edit</button>');
    });
    $(this).on('click', '.delete', function(){
      remove($(this).parent().parent());
    });
    $(this).on('click', '.create', function(){
      create($(this).parent().parent());
      var row = $(this).parent().parent();
      row.find('input').each(function() {
        var cellVal = $(this).val();
        $(this).parent().html(cellVal);
      });
      $(this).parent().html('<button class="edit-row btn">Edit</button>');
    });
    $(this).on('click', '.add', function(){
      var tds = '';
      for (var j=0; j<dataCols.length; j+=1){
            tds += '<td><input></td>';
        }
      that.find('tbody').append('<tr>'+tds+
        '<td><button class="create btn">Save</button><button class="remove btn">Remove</button><td></tr>');
    });
    $(this).on('click', '.remove', function(){
      $(this).parent().parent().remove();
    });
    $(this).on('click', '.cancel', function(){
      var row = $(this).parent().parent();
      row.find('input').each(function() {
        var cellVal = $(this).parent().attr('data-value');
        $(this).parent().html(cellVal);
      });
      $(this).parent().html('<button class="edit-row btn">Edit</button>');
      $(this).parent().parent().remove();
    });
    $(this).on('click', '.edit-row', function(){
      var row = $(this).parent().parent();
      row.find('.editable').each(function() {
        var cellVal = $(this).text();
        $(this).attr('data-value', cellVal);
        $(this).html('<input value="'+cellVal+'">');
        if ($(this).hasClass('code')){
          $(this).find("input").select2({
              data:select2Array,
              multiple: true,
              width: "200px"
          });

          // set value of select2
          $(this).find("input").select2('data', fetchedData[row.index()].codes);
        }
      });
      $(this).parent().html('<button class="update btn">Update</button><button class="cancel btn">Cancel</button><button class="delete btn">Delete</button>');
    });

    //===================================== Get records =======================================//
    if(!dataObject){
      $.get(url + params, function(data){
        fetchedData = data;
        for (var i=0; i<data.length; i+=1){
          var tds = '';
          for (var j=0; j<dataCols.length; j+=1){
            if (data[i][dataCols[j]]){
              if (dataCols[j]=='codes'){
                var codes = data[i][dataCols[j]];
                var links = '';
                for (var k=0; k<codes.length; k+=1){
                  links += '<a href="code_show.html?id='+codes[k]['id']+'&name='+codes[k]['text']+'">'+codes[k]['text']+'</a>'; 
                }
                tds += '<td class="editable">'+links+'</td>';
              }else if(dataCols[j]=='name'){
                tds += '<td class="editable"><a href="'+model+'_show.html?id='+data[i]['_id'].$oid+'&name='+data[i]['name']+'">'+data[i][dataCols[j]]+'</a></td>';
              }else{
                tds += '<td class="editable">'+data[i][dataCols[j]]+'</td>';
              }
            }else{
              tds += '<td class="editable"></td>';
            }
          }
          rows += '<tr id="'+data[i]['_id'].$oid+'">'+tds+'<td><button class="edit-row btn">Edit</button></td></tr>';
        }
        var headTds = '';
        for (var k=0;k<dataColNames.length; k+=1){
          headTds += '<td><b>'+dataColNames[k]+'</b></td>';
        }
        var head = '<thead>'+headTds+'</thead>';
        var body = '<tbody>'+rows+'</tbody>';
        var table = '<table class="table table-bordered table-striped table-condensed">'+head+body+'</table>'+
        '<button class="add btn btn-primary">Add New '+ model +'</button>';

        $(that).html(table);
      });
    }else{
      fetchedData = dataObject;
      for (var i=0; i<dataObject.length; i+=1){
          var tds = '';
          for (var j=0; j<dataCols.length; j+=1){
            if (dataObject[i][dataCols[j]]){
              if (dataCols[j]=='codes'){
                var codes = dataObject[i][dataCols[j]];
                var links = '';
                for (var k=0; k<codes.length; k+=1){
                  links += '<a href="code_show.html?id='+codes[k]['id']+'&name='+codes[k]['text']+'">'+codes[k]['text']+'</a>'; 
                }
                tds += '<td class="editable code">'+links+'</td>';
              }else if(dataCols[j]=='name'){
                tds += '<td class="editable"><a href="'+model+'_show.html?id='+dataObject[i]['_id'].$oid+'&name='+dataObject[i]['name']+'">'+dataObject[i][dataCols[j]]+'</a></td>';
              }else{
                tds += '<td class="editable">'+dataObject[i][dataCols[j]]+'</td>';
              }
            }else{
              tds += '<td class="editable"></td>';
            }
          }
          rows += '<tr id="'+dataObject[i]['_id'].$oid+'">'+tds+'<td><button class="edit-row btn">Edit</button></td></tr>';
        }
        var headTds = '';
        for (var k=0;k<dataColNames.length; k+=1){
          headTds += '<td><b>'+dataColNames[k]+'</b></td>';
        }
        var head = '<thead>'+headTds+'</thead>';
        var body = '<tbody>'+rows+'</tbody>';
        var table = '<table class="table table-bordered table-striped table-condensed">'+head+body+'</table>'+
        '<button class="add btn btn-primary">Add New '+ model +'</button>';

        $(that).html(table);
    }
    var select2Array = [];
  $.get('/codes', function(data){
   for(var i=0;i<data.length;i+=1){
    select2Array.push({id:data[i]._id.$oid, text:data[i].name});
   }
    // $(".select2").select2({
    //     data:select2Array,
    //     multiple: true,
    //     width: "200px"
    // });
    // $('.select2').select2('data', grant.codes);
});


  };
}( jQuery ));