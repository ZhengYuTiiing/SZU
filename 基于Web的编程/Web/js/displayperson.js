document.addEventListener("DOMContentLoaded", function () {
    // 打开或创建名为 "change" 的数据库
    var request1 = indexedDB.open("info2", 1);

    request1.onupgradeneeded = function (event) {
        // 当数据库版本发生变化时，创建对象存储空间 "comments"
        var db1 = event.target.result;
        //var commentStore = db.createObjectStore("comments", { keyPath: "id", autoIncrement: true });
        // var userStore = db.createObjectStore("users", { keyPath: "id", autoIncrement: true });
        //var blogStore = db.createObjectStore("blogs", { keyPath: "id", autoIncrement: true });
        var newusers = db1.createObjectStore("users", { keyPath: "id", autoIncrement: true });
    };

    request1.onerror = function (event) {
        console.error("Database error: " + event.target.errorCode);
    };

    request1.onsuccess = function (event) {

        // 数据库打开成功，保存数据库对象
        var db1 = event.target.result;
        // 在页面加载时显示已存储的评论
        displayUsers(db1);
    };
});

function displayUsers(db1) {
    // 从对象存储空间 "newusers" 获取所有博客
    var transaction1 = db1.transaction(["users"], "readonly");
    var objectStore1 = transaction1.objectStore("users");
    var request1 = objectStore1.openCursor(null, "prev");
    request1.onsuccess = function (event) {
        var cursor = event.target.result;

        if (cursor) {
            if(sessionStorage.getItem("username")===cursor.value.username){
                displayUser(cursor.value);
            }
            // 在页面中显示评论


            return;
            // 继续遍历下一个评论
            // cursor.continue();
        }
    };
}

function displayUser(user) {

    var usersContainer = document.getElementById("personmainchange");
    // 创建用户卡片元素
    var card = document.createElement("div");
    card.className = "user-card";
    //editperson

    var card = document.createElement("div");
    card.className = "user-card";
    // card.onclick = function () {
    //     sessionStorage.setItem("nowuser", user.newuserid);
    //     //window.open("userdetail.html", "_blank");
    // }
    // 往卡片中添加头像
    var touxiang = document.createElement("img");
    touxiang.className = "touxiangmain";
    touxiang.src = "../img/"+user.usertouxiang;
    card.appendChild(touxiang);

    // 往卡片中添加用户名
    //var username = document.createElement("p");
    //username.className = "username";
    //username.textContent = "" + user.newusername;
    //card.appendChild(username);
    //id
    var username1 = document.createElement("p");
    username1.className = "useridmain";
    username1.textContent = "昵称：" + user.usernichen;
    card.appendChild(username1);
    // 往卡片中添加签名
    //var qianming = document.createElement("p");
    // qianming.className = "qianming";
    //qianming.textContent = user.newuserqianming;
    //card.appendChild(qianming);

    // 往卡片中添加地址
    // var address = document.createElement("p");
    // address.className = "address";
    //address.textContent = user.newuseraddress;
    //card.appendChild(address);


    // 往卡片中添加性别
    //var sex = document.createElement("p");
    //sex.className = "sex";
    //sex.textContent = user.newusersex;
    //card.appendChild(sex);


    // 将用户卡片添加到页面
    usersContainer.appendChild(card);

}
