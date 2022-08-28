import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="home-search"
export default class extends Controller {
  static targets = [ "filters", "filter", "slider" ]
  connect() {
    // show slider value on connection
    document.getElementById("search-slider-output").innerHTML = `Distance: <strong>${document.getElementById("range").value}km</strong>`
  }

  changeActiveFilter(event) {
    const ele = event.path[1];
    const activeClass = "active-search-filter"
    const currentActiveEle = document.getElementsByClassName(activeClass)[0]
    if (ele.classList.contains("search-filter")) {
      ele.classList.toggle(activeClass)
      currentActiveEle.classList.toggle(activeClass)
    }
  }

  sliderUpdate() {
    document.getElementById("search-slider-output").innerHTML = `Distance: <strong>${this.sliderTarget.value}km</strong>`
  }
}
