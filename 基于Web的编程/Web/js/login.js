document.addEventListener("DOMContentLoaded", function () {
    // 获取 URL 中的参数
    const urlParams = new URLSearchParams(window.location.search);
    const requestString = urlParams.get('request');
    let transfer = document.getElementById('transfetBtn');
    if(requestString==="register"){
        transfer.click();
    }
    // 打开或创建名为 "info" 的数据库
    var request = indexedDB.open("info2", 1);

    request.onupgradeneeded = function (event) {
        // 当数据库版本发生变化时，创建对象存储空间 "comments"
        var db = event.target.result;
        var commentStore = db.createObjectStore("comments", { keyPath: "id", autoIncrement: true });
        var userStore = db.createObjectStore("users", { keyPath: "id", autoIncrement: true });
        var blogStore = db.createObjectStore("blogs", { keyPath: "id", autoIncrement: true });
        var replyStore = db.createObjectStore("replys", { keyPath: "id", autoIncrement: true });
    };

    request.onsuccess = function (event) {
        //console.log("sueesse！");
        // 数据库打开成功，保存数据库对象
        var db = event.target.result;
        //注册
        document.getElementById("reg_button").addEventListener("click", function () {
            //console.log("2");
            addUser(db);
        });

    };

    request.onerror = function (event) {
        console.error("Database error: " + event.target.errorCode);
    };

    var passwordInput = document.getElementById("password2");
    var strengthMessage = document.getElementById("password-strength-message");

    passwordInput.addEventListener("input", function (event) {
        var enteredPassword = event.target.value;
        var strength = assessPasswordStrength(enteredPassword);
        strengthMessage.textContent = "密码强度：" + strength;
    });
});
function isValidUsername(username) {
    // 使用正则表达式进行用户名校验
    // 可以包含中文、英文、数字，不能包含其他字符
    var regex = /^[\u4E00-\u9FA5A-Za-z0-9]+$/;
    return regex.test(username);
}

function isValidEmail(email) {
    // 使用正则表达式进行邮箱格式校验
    // 允许邮箱为空
    var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    return regex.test(email);
}

function isValidPhoneNumber(phone) {
    // 使用正则表达式进行电话号码校验
    // 允许电话号码为空
    var regex = /^$|^\d{11}$/;
    return regex.test(phone);
}

function isValidPassword(password) {
    // 使用正则表达式进行密码校验
    // 密码长度6-16位，由字母或数字组成
    var regex = /^[A-Za-z0-9]{6,16}$/;
    return regex.test(password);
}

// 密码强度评估函数
function assessPasswordStrength(password) {
    // 定义密码强度等级
    const strengthLevels = {
        weak: "弱",
        moderate: "中等",
        strong: "强",
    };

    // 密码长度小于8被视为弱密码
    if (password.length < 8) {
        return strengthLevels.weak;
    }

    // 密码包含数字、小写字母、大写字母和特殊字符的各自集合
    const digitRegex = /\d/;
    const lowercaseRegex = /[a-z]/;
    const uppercaseRegex = /[A-Z]/;

    // 计算密码包含的字符类型数量
    const charTypeCount = [
        digitRegex.test(password),
        lowercaseRegex.test(password),
        uppercaseRegex.test(password),
    ].filter(Boolean).length;

    // 根据字符类型数量判断密码强度
    switch (charTypeCount) {
        case 1:
            return strengthLevels.weak;
        case 2:
            return strengthLevels.moderate;
        default:
            return strengthLevels.strong;
    }
}

//检验合法性 密码要求
// 在注册函数中使用 md5 对密码进行哈希加密
function addUser(db) {
    var username = document.getElementById("username");
    var email = document.getElementById("email");
    var phone = document.getElementById("phone");
    var password = document.getElementById("password2");
    //add
    var errorMessageElement_username = document.getElementById("username-error-message");
    var errorMessageElement_email = document.getElementById("email-error-message");
    var errorMessageElement_phone = document.getElementById("phone-error-message");
    var errorMessageElement_password = document.getElementById("password-error-message");
    var flag=1;


    // 进行输入校验
    if (!isValidUsername(username.value)) {
        flag=0;
        // 显示用户名输入不合法的错误提示
        errorMessageElement_username.textContent = "Invalid username";
    }

    if (!isValidEmail(email.value)) {
        flag=0;
        // 显示邮箱输入不合法的错误提示
        errorMessageElement_email.textContent = "Invalid email";
    }

    if (!isValidPhoneNumber(phone.value)) {
        flag=0;
        // 显示电话号码输入不合法的错误提示
        errorMessageElement_phone.textContent = "Invalid phone number";
    }

    if (!isValidPassword(password.value)) {
        flag=0;
        // 显示密码输入不合法的错误提示
        errorMessageElement_password.textContent = "Invalid password";
    }
    if(flag===0){
        return;
    }
    else{
        errorMessageElement_username.textContent='';
        errorMessageElement_email.textContent="";
        errorMessageElement_phone.textContent='';
        errorMessageElement_password.textContent='';
    }
    

    // 使用 md5 对密码进行哈希加密
    var hashedPassword = md5(password.value);

    // 将评论保存到对象存储空间 "comments"
    var transaction = db.transaction(["users"], "readwrite");
    var objectStore = transaction.objectStore("users");

    var user = {
        username: username.value,
        email: email.value,
        phone: phone.value,
        password: hashedPassword,
        errorCount: 0,
        freezeTime: 0,
        usernichen: "",
        useraddress:"",
        usertouxiang: "",
    };

    var request = objectStore.add(user);
    request.onsuccess = function (event) {//弹窗
        username.value="";
        email.value="";
        phone.value="";
        password.value="";
    };
    request.onerror = function (event) {
        console.error("Error reg!!!!: " + event.target.errorCode);
    };
}

function loginUser() {
    checkLoginStatus(document.getElementById("username1").value,document.getElementById("password1").value);
}
// 检查用户是否已登录
// checkLoginStatus 函数返回 Promise
function checkLoginStatus(username,password) {

    // 打开或创建名为 "info" 的数据库
    let request = indexedDB.open("info2", 1);

    request.onupgradeneeded = function (event) {
        // 当数据库版本发生变化时，创建对象存储空间 "comments"
        const db = event.target.result;
        const commentStore = db.createObjectStore("comments", {keyPath: "id", autoIncrement: true});
        const userStore = db.createObjectStore("users", {keyPath: "id", autoIncrement: true});
        const blogStore = db.createObjectStore("blogs", {keyPath: "id", autoIncrement: true});

                // 添加错误次数和冻结截止时间字段
                userStore.createIndex("username", "username", { unique: true });
                userStore.createIndex("email", "email", { unique: true });
                userStore.createIndex("password", "password", { unique: false });
                userStore.createIndex("errorCount", "errorCount", { unique: false });
                userStore.createIndex("freezeTime", "freezeTime", { unique: false });
    };

    request.onerror = function (event) {
        console.error("Database error: " + event.target.errorCode);
    };


    request.onsuccess = function (event) {
        const db = event.target.result;
        const transaction = db.transaction(["users"], "readwrite");
        const objectStore = transaction.objectStore("users");
        const request = objectStore.openCursor();
    
        request.onsuccess = function (event) {
            const cursor = event.target.result;
    
            if (cursor) {
                if (cursor.value.username === username) {
                    // 检查是否冻结
                    const currentTime = new Date().getTime();
    
                    if (cursor.value.freezeTime > currentTime) {
                        alert("账户已冻结，请稍后再试。");
                        return;
                    }
    
                    if (cursor.value.password === md5(password)) {
                        window.open("../html/index.html", "_self");
                        sessionStorage.setItem("username", username);
                        cursor.value.errorCount = 0;
                        cursor.update(cursor.value).onsuccess = function () {
                            console.log("次数1更新成功！");
                   };
                    } else {
                        cursor.value.errorCount += 1;
                        cursor.update(cursor.value).onsuccess = function () {
                            console.log("次数2更新成功！");
                   };
                        // 如果错误次数达到阈值，冻结账户
                        const maxErrorCount = 3;
                        if (cursor.value.errorCount > maxErrorCount) {
                            const freezeDuration = 30 * 1000; // 冻结时长（60秒示例）
                            cursor.value.freezeTime = currentTime + freezeDuration;
                            // 更新冻结时间
                            const updateFreezeTimeRequest = cursor.update(cursor.value);    
                            updateFreezeTimeRequest.onsuccess = function () {
                                console.log("时间更改成功！");
                            };
                            updateFreezeTimeRequest.onerror = function (error) {
                                console.error("更新冻结时间时发生错误: ", error);
                            };
                            alert("密码错误次数过多，账户已冻结，请稍后再试。");
                        } else {
                            alert("密码错误");
                        }
                    }
                }
                // 继续遍历下一个评论
                cursor.continue();
            }
        };
    };    

    return;
}

// 用户登出时移除LocalStorage中的token
function logoutUser() {
    localStorage.removeItem('userToken');
}