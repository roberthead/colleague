import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="closeable"
export default class extends Controller {
  connect() {
    console.log('Hello, Stimulus!', this.element)
  }

  close(event) {
    event.target.closest('.closeable').remove();
  }
}
