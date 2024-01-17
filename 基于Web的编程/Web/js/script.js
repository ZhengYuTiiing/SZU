// script.js

// 等待文档加载完成
//personmain.html
document.addEventListener("DOMContentLoaded", function () {
    // 获取按钮元素
    var editProfileBtn = document.getElementById("editProfilebtn");
    var editback = document.getElementById("editback1");
    var fanhuishouye = document.getElementById("fanhuishouye");
    // 添加点击事件处理函数
    editProfileBtn.addEventListener("click", function () {
        // 使用 JavaScript 中的 window.location.href 实现页面跳转
        window.location.href = "editperson.html";
    });
    fanhuishouye.addEventListener("click", function () {
        window.location.href = "index.html";
    });
    editback.addEventListener("click", function () {
        window.location.href = "personmain.html";
    });


});
//返回editperson
document.addEventListener("DOMContentLoaded", function () {
    // 获取按钮元素
    var editback = document.getElementById("editback1")
    var addnewuser = document.getElementById("addnewuser")
    // 添加点击事件处理函数

    editback.addEventListener("click", function () {
        window.location.href = "personmain.html";
    });
    addnewuser.addEventListener("click", function () {
        window.location.href = "displaynewuser.html";
    });

    function uploadAvatar() {
        var input = document.getElementById("avatarInput");
        var preview = document.getElementById("avatarPreview");

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                preview.innerHTML = '<img src="' + e.target.result + '" alt="Avatar">';
            };

            reader.readAsDataURL(input.files[0]);
        }
    }



});
//未实现
document.addEventListener("DOMContentLoaded", function () {
    // 获取按钮元素
    document.addEventListener("DOMContentLoaded", function () {
        // 获取按钮元素
        var evtadd = document.querySelector('#btadd');
        var etbox = document.querySelector('.tbox');
        var einp = document.querySelector('#inp');
        // 添加点击事件处理函数
        editback.addEventListener("click", function () {
            window.location.href = "personmain.html";
        });

        function uploadAvatar() {
            var input = document.getElementById("avatarInput");
            var preview = document.getElementById("avatarPreview");

            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    preview.innerHTML = '<img src="' + e.target.result + '" alt="Avatar">';
                };

                reader.readAsDataURL(input.files[0]);
            }
        }



    });
    // 添加点击事件处理函数
    editback.addEventListener("click", function () {
        window.location.href = "personmain.html";
    });




});




