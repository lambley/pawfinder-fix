import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-activity"
export default class extends Controller {
  static targets = [ "select", "restaurantForm", "parkForm", "binForm" ]

  connect() {

  }

  showForm() {
    switch(this.selectTarget.value.toLowerCase()) {
      case "park":
        this.parkFormTarget.classList.remove("display-none")
        break
      case "restaurant":
        this.restaurantFormTarget.classList.remove("display-none")
        break
      case "dog bin":
        this.binFormTarget.classList.remove("display-none")
        break
      default:
        console.log("error in drop down selection");
    }
    document.getElementById("new-activity-selector").classList.add("display-none")
  }
}
