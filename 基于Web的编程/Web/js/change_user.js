document.addEventListener("DOMContentLoaded", function () {
    // 打开或创建名为 "changeuser" 的数据库
    var request = indexedDB.open("info2", 1);

    request.onupgradeneeded = function (event) {
        // 当数据库版本发生变化时，创建对象存储空间 "comments"
        var db = event.target.result;
        //var commentStore = db.createObjectStore("comments", { keyPath: "id", autoIncrement: true });
        //var userStore = db.createObjectStore("users", { keyPath: "id", autoIncrement: true });
        var newusers = db.createObjectStore("users", { keyPath: "id", autoIncrement: true });
    };

    request.onsuccess = function (event) {
        console.log("sueesse！");
        // 数据库打开成功，保存数据库对象
        var db = event.target.result;
        console.log("11111");
        // 添加新用户
        document.getElementById("addnewuser").addEventListener("click", function () {
            console.log("按钮被点击！");
            addBlog(db);
        });
    };

    request.onerror = function (event) {
        console.error("Database error: " + event.target.errorCode);
    };
});

function addBlog(db) {

    var usertouxiang = document.getElementById("usertouxiang");
    //var username = document.getElementById("username");
    var usernichen = document.getElementById("usernichen");
    var usernumber = document.getElementById("usernumber");
    var userbox = document.getElementById("userbox");
    var useraddress = document.getElementById("useraddress");

    //sessionStorage.setItem("publisher", "萌萌宝宝");



    // 将评论保存到对象存储空间 "newusers"
    var transaction = db.transaction(["users"], "readwrite");
    var objectStore = transaction.objectStore("users");

    var user = {
        usertouxiang: usertouxiang.value.slice(12),
        username: sessionStorage.getItem("username"),
        usernichen: usernichen.value,
        phone: usernumber.value,
        email: userbox.value,
        useraddress: useraddress.value,
        errorCount:0,
        freezeTime:0,
        //password:"",
        //title: title.value,
        //content: content.value,
        // image:image.value.slice(12),
        //publisher: sessionStorage.getItem("publisher")
    };
    // console.log(newuser);
    //往表中添加
    var request = objectStore.add(user);
    request.onsuccess = function (event) {
        //title.value="";
        //content.value="";
        //image.value=null;
        usertouxiang.value = null;
        // username.value = "";
        usernichen.value = "";
        usernumber.value = "";
        userbox.value = "";
        useraddress.value = "";

    };
    request.onerror = function (event) {
        console.error("Error adding user: " + event.target.errorCode);
    };
}
