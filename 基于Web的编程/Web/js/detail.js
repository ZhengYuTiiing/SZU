document.addEventListener("DOMContentLoaded", function () {
    var replce=document.getElementById("replace");
    replce.addEventListener("click", function () {
        document.getElementById("commentImg").click();
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

        // 数据库打开成功，保存数据库对象
        var db = event.target.result;

        disPlayBLOG(db);
        setBlogPic(db);
        // 在页面加载时显示已存储的评论
        displayComments1(db);
        displayComments0(db);
        displayReplys(db);
        // 添加评论的逻辑
        document.getElementById("addCommentBtn").addEventListener("click", function () {
            addComment(db);
        });
    };

    request.onerror = function (event) {
        console.error("Database error: " + event.target.errorCode);
    };
});
function setBlogPic(db){
    var transaction = db.transaction(["users"], "readonly");
    var objectStore = transaction.objectStore("users");
    var request = objectStore.openCursor();

    request.onsuccess = function (event) {
        var cursor = event.target.result;
        if (cursor) {
            // 在页面中显示评论

            if (cursor.value.username == sessionStorage.getItem("blogAuthor")) {
                sessionStorage.setItem("blogAuthorPic",cursor.value.usertouxiang);
            }
            // 继续遍历下一个评论
            cursor.continue();
        }
    };
    // 在 JavaScript 文件中添加以下代码
    // let t=1;
    // while(t--){location.reload(true);}

}
function disPlayBLOG(db) {
    var id = parseInt(sessionStorage.getItem("nowblog"));
    var transaction = db.transaction(["blogs"], "readonly");
    var objectStore = transaction.objectStore("blogs");
    var request = objectStore.get(id);
    console.log(request);
    request.onerror = function (event) {
        console.log('事务失败');
    };

    request.onsuccess = function (event) {
        if (request.result) {
            console.log("1111111");
            console.log(request.result);
            sessionStorage.setItem("blogAuthor",request.result.publisher);
            var blogcontent = document.getElementById("blog-content");

            var title = document.createElement("h3");
            title.textContent = request.result.title;
            blogcontent.appendChild(title);

            var pdiv = document.createElement("div");
            pdiv.className="blogp";
            var content = document.createElement("p");
            content.textContent = request.result.content;
            pdiv.appendChild(content);
            blogcontent.appendChild(pdiv);

            if (request.result.image1 != "") {
                var picdiv=document.createElement("div");
                picdiv.className="blogpicture";
                var pic = document.createElement("img");
                pic.src = "../img/" + request.result.image1;
                picdiv.appendChild(pic);
                pdiv.appendChild(picdiv);
            }
            if (request.result.image2 != "") {
                var picdiv=document.createElement("div");
                picdiv.className="blogpicture";
                var pic = document.createElement("img");
                pic.src = "../img/" + request.result.image2;
                picdiv.appendChild(pic);
                pdiv.appendChild(picdiv);
            }
            if (request.result.image3 != "") {
                var picdiv=document.createElement("div");
                picdiv.className="blogpicture";
                var pic = document.createElement("img");
                pic.src = "../img/" + request.result.image3;
                picdiv.appendChild(pic);
                pdiv.appendChild(picdiv);
            }
            if(request.result.audio!=""){
                var audio = document.createElement("audio");
                var source = document.createElement("source");
                source.src="../img/"+request.result.audio;
                audio.controls="controls";
                audio.appendChild(source);
                audio.className="blogpicture";
                pdiv.appendChild(audio);
               }
             if(request.result.video!=""){
             var video = document.createElement("video");
             var source = document.createElement("source");
             source.src="../img/"+request.result.video;
             video.controls="controls";
             video.appendChild(source);
             video.className="blogpicture";
             pdiv.appendChild(video);
            }
            //发布者名片
            var usernameContainer = document.getElementById("usernameContainer");
            var publisher = document.createElement("a");
            publisher.href="personmain.html";
            publisher.textContent = request.result.publisher;
            usernameContainer.appendChild(publisher);
            var picture=document.createElement("img");
            picture.src="../img/"+sessionStorage.getItem("blogAuthorPic");
            usernameContainer.appendChild(picture);
        } else {
            console.log('未获得数据记录');
        }
    };
}
function displayComments1(db) {
    // 从对象存储空间 "comments" 获取所有评论
    var transaction = db.transaction(["comments"], "readonly");
    var objectStore = transaction.objectStore("comments");
    var request = objectStore.openCursor();

    request.onsuccess = function (event) {
        var cursor = event.target.result;
        if (cursor) {
            // 在页面中显示评论
            if (cursor.value.blog == parseInt(sessionStorage.getItem("nowblog"))) {
                if (cursor.value.isuppp == 1) {
                    displayComment1(cursor.value, db);
                }
            }
            // 继续遍历下一个评论
            cursor.continue();
        }
    };
}
function displayComments0(db) {

    // 从对象存储空间 "comments" 获取所有评论
    var transaction = db.transaction(["comments"], "readonly");
    var objectStore = transaction.objectStore("comments");
    var request = objectStore.openCursor();

    request.onsuccess = function (event) {
        var cursor = event.target.result;
        if (cursor) {
            // 在页面中显示评论
            if (cursor.value.blog == parseInt(sessionStorage.getItem("nowblog"))) {
                if (cursor.value.isuppp == 0) {
                    displayComment(cursor.value, db);
                }
            }
            // 继续遍历下一个评论
            cursor.continue();
        }
    };
}

function displayComment(comment, db) {
    var commentsContainer = document.getElementById("commentsContainer");

    // 创建评论卡片元素
    var card = document.createElement("div");
    card.className = "comment-card";
    card.id = "comment" + comment.id;
    // 添加评论人用户名作为链接
    var usernameLink = document.createElement("a");
    usernameLink.className = "username";
    usernameLink.textContent = "" + comment.username;
    usernameLink.href = "personmain.html";
    card.appendChild(usernameLink);

    // 添加置顶按钮
    var pinButton = document.createElement("button");
    pinButton.textContent = "置顶";
    pinButton.addEventListener("click", function () {

        if(sessionStorage.getItem("username")==sessionStorage.getItem("blogAuthor")){
            zhiding(comment, db);
            window.location.href = "detail.html";
        }
        else{
            alert("当前用户无权限置顶");
        }
    });
    card.appendChild(pinButton);

    // 添加删除按钮
    var deleteButton = document.createElement("button");
    deleteButton.textContent = "删除";
    deleteButton.addEventListener("click", function () {
        if(sessionStorage.getItem("username")==sessionStorage.getItem("blogAuthor")){
            // console.log(comment.username);
            // console.log(sessionStorage.getItem("username"));
            remove(comment, db);
            window.location.href = "detail.html";
        }
        else{
            alert("当前用户无权限删除");
        }
    });
    card.appendChild(deleteButton);

    // 添加评论文字和图片
    var content = document.createElement("div");
    content.className = "content";
    content.textContent = comment.text;
    card.appendChild(content);
    if(comment.image!=""){
     var pic = document.createElement("img");
     pic.src = "../img/"+comment.image;
     pic.className="commentimg";
     content.appendChild(pic);
    }
   
       


   // 添加回复输入框
   var replyInput = document.createElement("input");
   replyInput.type = "text";
   replyInput.id = comment.id + "reply";
   replyInput.placeholder = "回复评论...";
   card.appendChild(replyInput);
   // 添加选择文件
   var replyImg = document.createElement("input");
   replyImg.type = "file";
   replyImg.accept = "image/*";
   replyImg.id = comment.id + "img";
   var goodbuttom=document.createElement("button");
   goodbuttom.textContent="选择图片";
   goodbuttom.addEventListener("click", function () {
       document.getElementById(comment.id + "img").click();
   });
   card.appendChild(replyImg);
   

   // 添加回复按钮
   var replyButton = document.createElement("button");
   replyButton.textContent = "回复";
   replyButton.className="replybutton";
   replyButton.addEventListener("click", function () {
       addReply(db, comment);
       window.location.href = "detail.html";
   });
   card.appendChild(replyButton);
   card.appendChild(goodbuttom);


    // 将评论卡片添加到页面
    commentsContainer.appendChild(card);
}

function displayComment1(comment, db) {
    var commentsContainer = document.getElementById("topcommentsContainer");

    // 创建评论卡片元素
    var card = document.createElement("div");
    card.className = "comment-card";
    card.id = "comment" + comment.id;
    // 添加评论人用户名作为链接
    var usernameLink = document.createElement("a");
    usernameLink.className = "username";
    usernameLink.textContent = "" + comment.username;
    usernameLink.href = "personmain.html";
    card.appendChild(usernameLink);

    // 添加置顶按钮
    var pinButton = document.createElement("button");
    pinButton.textContent = "置顶";
    pinButton.addEventListener("click", function () {
        if(sessionStorage.getItem("username")==sessionStorage.getItem("blogAuthor")){
            zhiding(comment, db);
            window.location.href = "detail.html";
        }
        else{
            alert("当前用户无权限置顶");
        }
    });
    card.appendChild(pinButton);

    // 添加删除按钮
    var deleteButton = document.createElement("button");
    deleteButton.textContent = "删除";
    deleteButton.addEventListener("click", function () {
        if(sessionStorage.getItem("username")==sessionStorage.getItem("blogAuthor")){
            // console.log(comment.username);
            // console.log(sessionStorage.getItem("username"));
            remove(comment, db);
            window.location.href = "detail.html";
        }
        else{
            alert("当前用户无权限删除");
        }
    });
    card.appendChild(deleteButton);

    // 添加评论文字和图片
    var content = document.createElement("div");
    content.className = "content";
    content.textContent = comment.text;
    card.appendChild(content);
    if(comment.image!=""){
        var pic = document.createElement("img");
       pic.src = "../img/"+comment.image;
       pic.className="commentimg";
       content.appendChild(pic);
    }

    // 添加回复输入框
    var replyInput = document.createElement("input");
    replyInput.type = "text";
    replyInput.id = comment.id + "reply";
    replyInput.placeholder = "回复评论...";
    card.appendChild(replyInput);
    // 添加选择文件
    var replyImg = document.createElement("input");
    replyImg.type = "file";
    replyImg.accept = "image/*";
    replyImg.id = comment.id + "img";
    var goodbuttom=document.createElement("button");
    goodbuttom.textContent="选择图片";
    goodbuttom.addEventListener("click", function () {
        document.getElementById(comment.id + "img").click();
    });
    card.appendChild(replyImg);
    card.appendChild(goodbuttom);

    // 添加回复按钮
    var replyButton = document.createElement("button");
    replyButton.textContent = "回复";
    replyButton.className="replybutton";
    replyButton.addEventListener("click", function () {
        addReply(db, comment);
        window.location.href = "detail.html";
    });
    card.appendChild(replyButton);


    // 将评论卡片添加到页面
    commentsContainer.appendChild(card);
}

function zhiding(comment, db) {
    // 从对象存储空间 "comments" 获取所有评论
    var transaction = db.transaction(["comments"], "readwrite");
    var objectStore = transaction.objectStore("comments");
    var request = objectStore.openCursor();
    request.onsuccess = function (event) {
        var cursor = event.target.result;

        if (cursor) {
            // 在页面中显示评论
            if (cursor.value.blog == parseInt(sessionStorage.getItem("nowblog"))) {
                // 更新评论的 isuppp 属性为0
                cursor.value.isuppp = 0;

                // 将修改后的评论记录放回对象存储空间
                var updateRequest = cursor.update(cursor.value);

                // 更新评论记录成功后执行的回调
                updateRequest.onsuccess = function () {
                    console.log("Record updated successfully.");
                };

                // 更新评论记录失败后执行的回调
                updateRequest.onerror = function () {
                    console.error("Error updating record.");
                };
            }
            // 继续遍历下一个评论
            cursor.continue();
        }
    };
    setupp(comment, db);
}
function setupp(comment, db) {
    var transaction = db.transaction(["comments"], "readwrite");
    var objectStore = transaction.objectStore("comments");
    var getRequest = objectStore.get(comment.id);
    getRequest.onsuccess = function (event) {
        var record = event.target.result;
        record.isuppp = 1;
        var updateRequest = objectStore.put(record);
        updateRequest.onsuccess = function () {
            console.log("Record updated successfully.");
        };
        updateRequest.onerror = function () {
            console.error("Error updating record.");
        };
    };
}

function remove(comment, db) {
    var transaction = db.transaction(['comments'], 'readwrite');
    var objectStore = transaction.objectStore('comments');
    var request = objectStore.delete(comment.id);

    request.onsuccess = function (event) {
        console.log('数据删除成功');
    };

    request.onerror = function (event) {
        console.log('数据删除失败');
    }
}
function addComment(db) {
    var input = document.getElementById("text");
    var commentImg = document.getElementById("commentImg");
    if (input.value.trim() === "") {
        alert("请输入评论内容");
        return;
    }
    // 获取会话中的用户名
    var username = sessionStorage.getItem("username");
    // 将评论保存到对象存储空间 "comments"
    var transaction = db.transaction(["comments"], "readwrite");
    var objectStore = transaction.objectStore("comments");

    var comment = {
        username: username,
        text: input.value,
        blog: parseInt(sessionStorage.getItem("nowblog")),
        image: commentImg.value.slice(12),
        isuppp: 0
    };
    var request = objectStore.add(comment);

    request.onsuccess = function (event) {
        // 在页面中显示新添加的评论
        displayComment(comment);
        window.location.href = "detail.html";
        // 清空输入框
        input.value = "";

    };

    request.onerror = function (event) {
        console.error("Error adding comment: " + event.target.errorCode);
    };
}

function addReply(db, comment) {
    var input = document.getElementById(comment.id + "reply");
    var image = document.getElementById(comment.id + "img");

    if (input.value.trim() === "") {
        alert("请输入评论内容");
        return;
    }
    // 将评论保存到对象存储空间 "replys"
    var transaction = db.transaction(["replys"], "readwrite");
    var objectStore = transaction.objectStore("replys");

    var reply = {
        username: "羊驼",
        text: input.value,
        comment: comment.id,
        image: image.value.slice(12)
    };

    var request = objectStore.add(reply);
    console.log("add reply ");
    request.onsuccess = function (event) {
        console.log("add reply seccess!");
    };
    request.onerror = function (event) {
        console.error("Error adding reply: " + event.target.errorCode);
    };
}

function displayReply(comment, db) {
    console.log("displayReply function started");

    // 从对象存储空间 "replys" 获取所有回复
    var transaction = db.transaction("replys", "readonly");
    var objectStore = transaction.objectStore("replys");
    var request = objectStore.openCursor();

    request.onsuccess = function (event) {
        var cursor = event.target.result;
        if (cursor) {
            // 在页面中显示回复
            if (cursor.value.comment == comment.id) {
                var preply = document.createElement("p");
                preply.textContent = cursor.value.text;
                var commentcard = document.getElementById("comment" + comment.id); // 修改此行
                commentcard.appendChild(preply);
                if(cursor.value.image!=""){
                    var img_reply = document.createElement("img");
                img_reply.src = "../img/"+cursor.value.image;
                img_reply.className="replyimg";
                preply.appendChild(img_reply);
                }        
            }
            // 继续遍历下一个评论
            cursor.continue();
        }
    };

    request.onerror = function (event) {
        console.error("Error opening cursor for replys: " + event.target.errorCode);
    };
}

function displayReplys(db) {
    // 从对象存储空间 "comments" 获取所有评论
    var transaction = db.transaction(["comments"], "readonly");
    var objectStore = transaction.objectStore("comments");
    var request = objectStore.openCursor();

    request.onsuccess = function (event) {
        var cursor = event.target.result;
        if (cursor) {
            // 在页面中显示评论
            if (cursor.value.blog == parseInt(sessionStorage.getItem("nowblog")))
                displayReply(cursor.value, db);

            // 继续遍历下一个评论
            cursor.continue();
        }
    };
}