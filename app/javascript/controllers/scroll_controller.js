import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  static targets = [ "activity" ]
  connect() {
    
  }

  scrollIntoView(event) {
    event.preventDefault()
    const scrollElement = document.getElementById(this.activityTarget.id.replace(/popup-/g,''))
    scrollElement.scrollIntoView({behavior: "smooth", block: "center", inline: "nearest"});
  }
}
