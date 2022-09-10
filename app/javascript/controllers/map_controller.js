import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    usermarker: Object
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    console.log(this.usermarkerValue);
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v11",
    })
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    this.map.addControl(new mapboxgl.NavigationControl());
  }

  #addMarkersToMap() {
    // activities map markers
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
    // user map marker
    new mapboxgl.Marker({
      color: '#04985A'
    })
    .setLngLat([ this.usermarkerValue.lng, this.usermarkerValue.lat ])
    .addTo(this.map)
  }

  #fitMapToMarkers() {
    // activity marker bound extension
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    // user map marker bound extension
    bounds.extend([this.usermarkerValue.lng, this.usermarkerValue.lat])
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
