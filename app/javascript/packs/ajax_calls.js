import $ from 'jquery';

$('#popup-customer-submit').on('click', function(){
    var form = $("#cusomer-form-id");
    var data = {"customer": {}}
    $.each(form.serializeArray(), function(i, field) {
        data["customer"][field.name] = field.value;
    });
    data["customer"]["remote"] = true;
    $('#customer-close').click();
    if (true) {
      $.ajax({
        url: "/customers",
        type: "POST",
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        data: data,
        success: function(data){
            console.log(data);
            var option = {
              id: data.id,
              name: data.name + '-' + data.company_name,
            }
            var newOption = new Option(option.name, option.id, true, true);
            $('#customer_select_2').append(newOption).trigger('change');
        },
        error: function(){
          console.log("AJAX call unsuccesful");
        }
      });
    }
    else{
      alert("The form has errors, couldn't be submitted");
    }
});
