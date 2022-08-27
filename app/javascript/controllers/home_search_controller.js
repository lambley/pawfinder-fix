import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="home-search"
export default class extends Controller {
  static targets = [ "filters", "filter" ]
  connect() {
    console.log("home-search connected");
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
}
