function checkUser(){
    sessionStorage.setItem("blogAuthor","");
    if (sessionStorage.getItem("username")) {
        //let login = document.getElementsByClassName("login");
        let login = document.getElementsByClassName("login")[0];
        while (login.firstChild) {
            login.removeChild(login.firstChild);
        }
        login.style.padding="5px"
        login.style.height="55px"

        let childButton=document.createElement("button");
        childButton.innerText="发布动态"
        childButton.style.float="left";
        childButton.style.padding="5px 10px"
        childButton.style.margin="16px 0"
        childButton.style.backgroundColor="#dbcb92"
        //childButton.style.color=""
        childButton.style.border="none"
        childButton.style.borderRadius="4px"
        childButton.style.cursor="pointer"
        childButton.onclick=function (){
            window.open("../html/add_blog.html")
        }

        // button {
        //     padding: 5px 10px;
        //     background-color: #4CAF50;
        //     color: #fff;
        //     border: none;
        //     border-radius: 4px;
        //     cursor: pointer;
        // }

       // let childA = document.createElement("a");
        //childA.style.width="55px"
        //childA.style.display="block";
        let childP = document.createElement("p");
        childP.textContent=sessionStorage.getItem("username");
        childP.style.fontSize="20px";
        childP.style.fontFamily="微软雅黑";
        childP.style.display="block";
        childP.style.padding="15px 0";
        childP.style.float="right";
        childP.style.color="#828187"
        childP.addEventListener("mouseover", function (){childP.style.color="#D29A7B"});
        childP.addEventListener("mouseout", function (){childP.style.color="#828187"});
        childP.addEventListener("click",function (){window.open("../html/personmain.html")});

        // childIMG.src = "../img/崩坏3.png";
        // childIMG.style.height = "55px";
        // childIMG.style.width = "55px";
        // childIMG.style.float = "right";
        // childA.appendChild(childIMG);
        //childA.href = "";
        //childA.appendChild(childP)
        login.appendChild(childButton);
        login.appendChild(childP);
        // 在这里添加显示已登录状态的逻辑
    }
}
function searchContent(index) {
    const search = document.getElementById("searchInput"+index).value;
    console.log(search);
    window.open("../html/DongTaiSearch.html?search=" + search);
}
document.addEventListener('DOMContentLoaded', checkUser)
