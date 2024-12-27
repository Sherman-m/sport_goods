document.getElementById("main-action-button").onclick = function () {
    document.getElementById("goods").scrollIntoView({ behavior: "smooth" });
};

let links = document.querySelectorAll(".header__menu-link");
for (let i = 0; i < links.length; i++) {
    links[i].onclick = function (event) {
        event.preventDefault();
        const targetId = links[i].getAttribute("data-link");
        document.getElementById(targetId).scrollIntoView({ behavior: "smooth" });
    };
}

let buttons = document.getElementsByClassName("items__button-item");
for (let i = 0; i < buttons.length; i++) {
    buttons[i].onclick = function () {
        document.getElementById("buying").scrollIntoView({ behavior: "smooth" });
    };
}

document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector(".orders__form");

    form.addEventListener("submit", (event) => {
        event.preventDefault();

        const email = document.getElementById("email").value.trim();
        const name = document.getElementById("name").value.trim();
        const phone = document.getElementById("phone").value.trim();

        if (email === "" || name === "" || phone === "") {
            alert("Пожалуйста, заполните все поля.");
            return;
        }

        alert("Спасибо за заказ! Мы скоро свяжемся с вами!");

        form.reset();
    });
});
