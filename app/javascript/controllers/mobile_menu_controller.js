import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "openIcon", "closeIcon"];

  connect() {
    this.outsideClickListener = this.handleOutsideClick.bind(this);
    this.escapeListener = this.handleEscape.bind(this);
  }

  toggle(event) {
    event.preventDefault();

    const menu = document.getElementById("mobile-menu");
    const isOpen = !menu.classList.contains("hidden");

    menu.classList.toggle("hidden");

    this.openIconTarget.classList.toggle("hidden", !isOpen);
    this.closeIconTarget.classList.toggle("hidden", isOpen);

    if (!isOpen) {
      document.addEventListener("mousedown", this.outsideClickListener);
      document.addEventListener("keydown", this.escapeListener);
    } else {
      document.removeEventListener("mousedown", this.outsideClickListener);
      document.removeEventListener("keydown", this.escapeListener);
    }
  }

  handleOutsideClick(event) {
    const menu = document.getElementById("mobile-menu");

    if (!this.element.contains(event.target) && !menu.contains(event.target)) {
      menu.classList.add("hidden");

      this.openIconTarget.classList.remove("hidden");
      this.closeIconTarget.classList.add("hidden");

      document.removeEventListener("mousedown", this.outsideClickListener);
      document.removeEventListener("keydown", this.escapeListener);
    }
  }

  handleEscape(event) {
    if (event.key === "Escape") {
      const menu = document.getElementById("mobile-menu");

      menu.classList.add("hidden");

      this.openIconTarget.classList.remove("hidden");
      this.closeIconTarget.classList.add("hidden");

      document.removeEventListener("mousedown", this.outsideClickListener);
      document.removeEventListener("keydown", this.escapeListener);
    }
  }
}
