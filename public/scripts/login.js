$(function(){
    //不支持placeholder浏览器下对placeholder进行处理
    if(document.createElement('input').placeholder !== '') {
        $('[placeholder]').focus(function() {
            var input = $(this);
            if(input.val() == input.attr('placeholder')) {
                input.val('');
                input.removeClass('placeholder');
            }
        }).blur(function() {
                var input = $(this);
                if(input.val() == '' || input.val() == input.attr('placeholder')) {
                    input.addClass('placeholder');
                    input.val(input.attr('placeholder'));
                }
            }).blur().parents('form').submit(function() {
                $(this).find('[placeholder]').each(function() {
                    var input = $(this);
                    if(input.val() == input.attr('placeholder')) {
                        input.val('');
                    }
                });
            });
    }



    $('#sub').click(function(){
        var _username = $('input[name="login"]').val();
        var _password = $('input[name="password"]').val();

        if(!_username) {
            alert('请输入你的用户名!');
            return false;
        }

        if(!_password) {
            alert('请输入你的密码!');
            return false;
        }
        $('#sub').text('登录中...');
        $('#login-form')[0].submit();
    })
})