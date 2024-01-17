document.addEventListener("DOMContentLoaded", function () {
    // 打开或创建名为 "info" 的数据库
    var request = indexedDB.open("info2", 1);

    request.onupgradeneeded = function (event) {
        // 当数据库版本发生变化时，创建对象存储空间 "comments"
        var db = event.target.result;
        //var commentStore = db.createObjectStore("comments", { keyPath: "id", autoIncrement: true });
        // var userStore = db.createObjectStore("users", { keyPath: "id", autoIncrement: true });
        //var blogStore = db.createObjectStore("blogs", { keyPath: "id", autoIncrement: true });
        var newusers = db.createObjectStore("users", { keyPath: "id", autoIncrement: true });
    };

    request.onerror = function (event) {
        console.error("Database error: " + event.target.errorCode);
    };

    request.onsuccess = function (event) {

        // 数据库打开成功，保存数据库对象
        var db = event.target.result;
        // 在页面加载时显示已存储的评论
        displayBlogs(db);
    };
});

function displayBlogs(db) {
    // 从对象存储空间 "newusers" 获取所有博客
    var transaction = db.transaction(["users"], "readonly");
    var objectStore = transaction.objectStore("users");
    var request = objectStore.openCursor(null, "prev");
    request.onsuccess = function (event) {
        var cursor = event.target.result;

        if (cursor) {
            // 在页面中显示评论
            if(sessionStorage.getItem("username")===cursor.value.username){
                displayUser(cursor.value);
            }
            return;
            // 继续遍历下一个评论
            // cursor.continue();
        }
    };
}

function displayUser(user) {
    var usersContainer = document.getElementById("newusersContainer");
    // 创建用户卡片元素
    var card = document.createElement("div");
    card.className = "user-card";
    // card.onclick = function () {
    //     sessionStorage.setItem("nowuser", user.newuserid);
    //     //window.open("userdetail.html", "_blank");
    // }
    // 往卡片中添加头像
    var touxiang = document.createElement("img");
    touxiang.className = "touxiang";
    touxiang.src = "../img/"+user.usertouxiang;
    card.appendChild(touxiang);

    // 往卡片中添加用户名
    var username = document.createElement("p");
    username.className = "username";
    username.textContent = "" + user.username;
    card.appendChild(username);
    //昵称
    var usernichen = document.createElement("p");
    usernichen.className = "usernichen";
    usernichen.textContent = "" + user.usernichen;
    card.appendChild(usernichen);
    // 往卡片中添加手机号
    var qianming = document.createElement("p");
    qianming.className = "usernumber";
    qianming.textContent = user.phone;
    card.appendChild(qianming);

    // 往卡片中添加邮箱
    var address = document.createElement("p");
    address.className = "userbox";
    address.textContent = user.email;
    card.appendChild(address);


    // 往卡片中添加地址
    var sex = document.createElement("p");
    sex.className = "useraddress";
    sex.textContent = user.useraddress;
    card.appendChild(sex);
    // 将用户卡片添加到
    usersContainer.appendChild(card);
}
