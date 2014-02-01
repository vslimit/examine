$(function(){

    $('form').each(function(){
        $(this).validate({
            errorClass: "form_error",
            errorElement: "em"
        });
    })

    $( ".datepicker" ).datepicker({
        dateFormat: "yy-mm-dd",
        changeMonth: true,
        changeYear: true
    });

    $('.datetimepicker').datetimepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: "yy-mm-dd",
        timeFormat: "HH:mm"
    });

    $(".various").fancybox({
        fitToView	: false,
        width		: '90%',
        height		: '90%',
        autoSize	: false,
        closeClick	: false,
        openEffect	: 'none',
        closeEffect	: 'none',
        padding: 10,
        scrolling : 'auto'
    });
})