import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl";

// Connects to data-controller="directions"
export default class extends Controller {
  static values = {
    orsApiKey: String,
    mapboxApiKey: String,
    destination: Object,
    usermarker: Object
  }
  connect() {
    // render mapbox
    mapboxgl.accessToken = this.mapboxApiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v11"
    })
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    this.map.addControl(new mapboxgl.NavigationControl());

    // insert directions
    this.#openRouteServiceRoute()
  }

  #openRouteServiceRoute() {
    // Official documentation: https://openrouteservice.org/dev/#/api-docs/v2/directions/{profile}/get
    // build url
    const url = `https://api.openrouteservice.org/v2/directions/foot-walking?api_key=${this.orsApiKeyValue}&start=${this.usermarkerValue.lng},${this.usermarkerValue.lat}&end=${this.destinationValue.lng},${this.destinationValue.lat}`

    // element to insert directions into list
    const directionsElement = document.getElementById('directions-content-here')

    // API call and list generation
    async function fetchRoute(map) {
      const response = await fetch(url, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8'
        }
      })
      const data = await response.json()
      // console.log(data);

      // use step info and insert into page
      const steps = data.features[0].properties.segments[0].steps
      steps.forEach((step) => {
        const stepListItem = `<li>
          <strong>${step.instruction}</strong> (for ${Math.ceil(step.distance)}m)
        </li>`
        directionsElement.insertAdjacentHTML("beforeend", stepListItem)
      })

      // use geoJSON data to plot route on mapbox map
      map.addSource('route', {
        'type': 'geojson',
        'data': data
      })
      map.addLayer({
        'id': 'route',
        'type': 'line',
        'source': 'route',
        'layout': {
          'line-join': 'round',
          'line-cap': 'round'
        },
        'paint': {
          'line-color': '#D9534F',
          'line-width': 8
          }
      });
    }

    // call API
    fetchRoute(this.map)
  }

  #addMarkersToMap() {
    // destination map marker
    const destEl = document.createElement('div')
    destEl.className = "dest-marker"
    const popup = new mapboxgl.Popup({ className: 'popup-window' }).setHTML(this.destinationValue.info_window)
    new mapboxgl.Marker(destEl)
      .setLngLat([ this.destinationValue.lng, this.destinationValue.lat ])
      .setPopup(popup)
      .addTo(this.map)
    // user map marker
    const userEl = document.createElement('div')
    userEl.className = "user-marker"
    new mapboxgl.Marker(userEl)
      .setLngLat([ this.usermarkerValue.lng, this.usermarkerValue.lat ])
      .addTo(this.map)
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()

    // destination marker bound extension
    bounds.extend([this.destinationValue.lng, this.destinationValue.lat])

    // user map marker bound extension
    bounds.extend([this.usermarkerValue.lng, this.usermarkerValue.lat])

    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
