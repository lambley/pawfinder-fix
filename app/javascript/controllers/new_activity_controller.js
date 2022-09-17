import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-activity"
export default class extends Controller {
  static targets = [ "select", "restaurantForm", "parkForm", "binForm" ]

  connect() {

  }

  showForm() {
    const newFormImageElement = document.getElementById("new-form-img")
    const parkImage = "new-park.jpg"
    const restaurantImage = "new-restaurant.jpg"
    const binImage = "new-bin.jpg"
    switch(this.selectTarget.value.toLowerCase()) {
      case "park":
        newFormImageElement.setAttribute(
          'src',
          this.#amendCloudinaryUrl(
            newFormImageElement.getAttribute('src'),
            parkImage
          )
        )
        this.parkFormTarget.classList.remove("display-none")
        break
      case "restaurant":
        newFormImageElement.setAttribute(
          'src',
          this.#amendCloudinaryUrl(
            newFormImageElement.getAttribute('src'),
            restaurantImage
          )
        )
        this.restaurantFormTarget.classList.remove("display-none")
        break
      case "dog bin":
        newFormImageElement.setAttribute(
          'src',
          this.#amendCloudinaryUrl(
            newFormImageElement.getAttribute('src'),
            binImage
          )
        )
        this.binFormTarget.classList.remove("display-none")
        break
      default:
        console.log("error in drop down selection");
    }
    document.getElementById("new-activity-selector").classList.add("display-none")
  }

  #amendCloudinaryUrl(url, newFileName) {
    const substring = url.substring(0, url.lastIndexOf("/") + 1)
    return `${substring}/${newFileName}`
  }
}
