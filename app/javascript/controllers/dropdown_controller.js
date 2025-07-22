import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu", "button"];

  connect() {
    this.outsideClickListener = this.handleOutsideClick.bind(this);
    this.escapeListener = this.handleEscape.bind(this);
  }

  toggle(event) {
    event.preventDefault();

    this.menuTarget.classList.toggle("hidden");

    if (!this.menuTarget.classList.contains("hidden")) {
      document.addEventListener("mousedown", this.outsideClickListener);
      document.addEventListener("keydown", this.escapeListener);
    } else {
      document.removeEventListener("mousedown", this.outsideClickListener);
      document.removeEventListener("keydown", this.escapeListener);
    }
  }

  handleOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.close();
    }
  }

  handleEscape(event) {
    if (event.key === "Escape") {
      this.close();
    }
  }

  close() {
    this.menuTarget.classList.add("hidden");
    document.removeEventListener("mousedown", this.outsideClickListener);
    document.removeEventListener("keydown", this.escapeListener);
  }
}
