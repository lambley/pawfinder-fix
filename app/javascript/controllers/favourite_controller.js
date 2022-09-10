import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favourite"
export default class extends Controller {
  static targets = [ "heart" ]

  connect() {
  }

  addToFavourites() {
    // check if empty heart (not current favourite)
    if (this.heartTarget.classList.contains("fa-regular")) {
      this.heartTarget.classList.toggle("fa-regular")
      this.heartTarget.classList.toggle("fa-solid")
      alert(`Added to Favourites`)
    }
    // check if full heart (favourited)
    else if (this.heartTarget.classList.contains("fa-solid")) {
      this.heartTarget.classList.toggle("fa-solid")
      this.heartTarget.classList.toggle("fa-regular")
      alert(`Removed from Favourites`)
    }
  }
}
