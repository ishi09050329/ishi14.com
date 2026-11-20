async function loadComponents() {
    const header = document.querySelector("#header-container");
    const footer = document.querySelector("#footer-container");

    try {
        const [headerResponse, footerResponse] = await Promise.all([
            fetch("../components/header.html"),
            fetch("../components/footer.html")
        ]);

        if (!headerResponse.ok || !footerResponse.ok) {
            throw new Error("Component loading failed");
        }

        header.innerHTML = await headerResponse.text();
        footer.innerHTML = await footerResponse.text();

        const menuToggle = document.querySelector(".menu-toggle");
        const nav = document.querySelector(".nav");

        menuToggle.addEventListener("click", () => {
            const isOpen = nav.classList.toggle("active");
            menuToggle.setAttribute("aria-expanded", isOpen);
        });

        nav.querySelectorAll("a").forEach(link => {
            link.addEventListener("click", () => {
                nav.classList.remove("active");
                menuToggle.setAttribute("aria-expanded", "false");
            });
        });

    } catch (error) {
        console.error("読み込みエラー:", error);
    }
}

loadComponents();