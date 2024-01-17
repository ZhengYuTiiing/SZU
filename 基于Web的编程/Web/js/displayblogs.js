document.addEventListener("DOMContentLoaded", function () {
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
    // 从对象存储空间 "blogs" 获取所有博客
    var transaction = db.transaction(["blogs"], "readonly");
    var objectStore = transaction.objectStore("blogs");
    var request = objectStore.openCursor();

    request.onsuccess = function (event) {
        var cursor = event.target.result;
        if (cursor) {
            // 在页面中显示帖子
            displayBlog(cursor.value);
            // 继续遍历下一个帖子
            cursor.continue();
        }
    };
}

function displayBlog(blog) {
    var blogsContainer = document.getElementById("myTable");
    var oneblog = document.createElement("tr");
    blogsContainer.appendChild(oneblog);
    var myTD = document.createElement("td");
    myTD.className = "myTD";
    oneblog.appendChild(myTD);
    var contentTable = document.createElement("table");
    contentTable.className = "content";
    myTD.appendChild(contentTable);
    var onetr = document.createElement("tr");
    var onetd = document.createElement("td");
    onetd.colSpan = "2";
    var link = document.createElement("a");
    link.className = "contentTitle";
    link.textContent = blog.title;
    link.onclick = function () {
        sessionStorage.setItem("nowblog", blog.id);

        window.open("detail.html", "_blank");
    }
    onetd.appendChild(link);
    onetr.appendChild(onetd);
    contentTable.appendChild(onetr);

    var twotr = document.createElement("tr");
    var twotd1 = document.createElement("td");
    if (blog.image1 != "") {
        var image = document.createElement("img");
        image.src = "../img/" + blog.image1;
        image.className = "contentImg";
        twotd1.appendChild(image);
    }
    var twotd2 = document.createElement("td");
    var content = document.createElement("p");
    content.className = "contentP";
    if(blog.image1 == "")content.style.maxWidth="1180px";
    content.textContent = blog.content;
    twotd2.appendChild(content);
    twotr.appendChild(twotd1);
    twotr.appendChild(twotd2);
    contentTable.appendChild(twotr);
}
