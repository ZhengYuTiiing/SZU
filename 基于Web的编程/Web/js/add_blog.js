document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("imagebtn").addEventListener("click", function () {
        document.getElementById("image").click();
    });
    document.getElementById("audiobtn").addEventListener("click", function () {
        document.getElementById("audio").click();
    });
    document.getElementById("videobtn").addEventListener("click", function () {
        document.getElementById("video").click();
    });
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
        console.log("sueesse！");
        // 数据库打开成功，保存数据库对象
        var db = event.target.result;
        // 博客
        document.getElementById("addBlog").addEventListener("click", function () {
            if(document.getElementById("title").value!=""&&document.getElementById("content").value!=""){
                console.log("2");
                if(confirm("确定发布？")){
                    addBlog(db);
                window.open("DongTai.html");
                }
            }
            else{
                alert("标题和正文都不能为空！");
            }
            
        });
    };

    request.onerror = function (event) {
        console.error("Database error: " + event.target.errorCode);
    };
});

function addBlog(db) {
    var title = document.getElementById("title");
    console.log("choose", title);
    var content = document.getElementById("content");
    console.log("choose", content);
    var image = document.getElementById("image");
    console.log("choose", image);
    console.log(image.value);
    sessionStorage.setItem("publisher","萌萌宝宝");
    var audio = document.getElementById("audio");
    console.log(audio.value);
    var video = document.getElementById("video");
    console.log(video.value);
    var files = image.files;
    var image1="";
    var image2="";
    var image3="";
    if(files.length==1) image1=files[0].name;
    if(files.length==2){
        console.log("222222222");
        console.log(files[0].name);
        console.log(files[1].name);
        image1=files[0].name;
        image2=files[1].name;
    } 
    if(files.length==3) {
        console.log("3333333333");
        console.log(files[0].name);
        console.log(files[1].name);     
        console.log(files[2].name);
        image1=files[0].name;
        image2=files[1].name;
        image3=files[2].name;
    }
    // 将评论保存到对象存储空间 "blogs"
    
    var transaction = db.transaction(["blogs"], "readwrite");
    var objectStore = transaction.objectStore("blogs");

    var blog = {
        title: title.value,
        content: content.value,
        image1:image1,
        image2:image2,
        image3:image3,
        audio:audio.value.slice(12),
        video:video.value.slice(12),
        publisher : sessionStorage.getItem("username")
    };
    console.log(blog);
    var request = objectStore.add(blog);
    request.onsuccess = function (event) {
        title.value="";
        content.value="";
        image.value=null;
      
    };
    request.onerror = function (event) {
        alert("发布出错，请检查网络或文件大小！");
        console.error("Error adding comment: " + event.target.errorCode);
    };
}


