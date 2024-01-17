function reset_pass() {
    var email = document.getElementById("email").value;
    var forget_password=document.getElementById("forget_password");
    let request = indexedDB.open("info2", 1);
    var errorMessageElement_email = document.getElementById("email_error_message");

    request.onupgradeneeded = function (event) {
        // 当数据库版本发生变化时，创建对象存储空间 "comments"
        const db = event.target.result;
        const commentStore = db.createObjectStore("comments", {keyPath: "id", autoIncrement: true});
        const userStore = db.createObjectStore("users", {keyPath: "id", autoIncrement: true});
        const blogStore = db.createObjectStore("blogs", {keyPath: "id", autoIncrement: true});
        var replyStore = db.createObjectStore("replys", { keyPath: "id", autoIncrement: true });
    };

    request.onerror = function (event) {
        console.error("Database error: " + event.target.errorCode);
    };

    request.onsuccess = function (event) {
        // 数据库打开成功，保存数据库对象
        const db = event.target.result;
        // 从对象存储空间 "blogs" 获取所有博客
        const transaction = db.transaction(["users"], "readwrite");
        const objectStore = transaction.objectStore("users");
        request = objectStore.openCursor();

        request.onsuccess = function (event) {
            const cursor = event.target.result;

            if (cursor) {
                if(cursor.value.email===email){
                    const randomPassword = generateRandomPassword();
                    console.log(randomPassword)
                    alert("新密码为："+randomPassword)        
                    cursor.value.password = md5(randomPassword);
                    cursor.update(cursor.value).onsuccess = function () {
                         console.log("密码更新成功！");
                };
                    return;
                }
                // 继续遍历下一个评论
                cursor.continue();
            }
            else alert("抱歉，没有该邮箱");
        };
    }
}
    
function generateRandomPassword() {
        const length = Math.floor(Math.random() % (16 - 6 + 1)) + 6; // 长度在 6 到 16 之间的随机数
        const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        let password = "";
        for (let i = 0; i < length; i++) {
            const randomIndex = Math.floor(Math.random() * charset.length);
            password += charset.charAt(randomIndex);
        }
    
        return password;
    }

    
    