let searchBox = document.querySelector("#formGroupExampleInput");
let bookGallery = document.querySelector(".book-gallery");

searchBox.addEventListener("keydown", (event) => {
    if(event.key === 'Enter') {
        bookGallery.classList.remove("hide");
    }
});