import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { autoDismiss: Boolean };

  connect() {
    if (this.autoDismissValue) {
      this.timeout = setTimeout(() => {
        this.dismiss();
      }, 3000);
    }
  }

  disconnect() {
    if (this.timeout) {
      clearTimeout(this.timeout);
    }
  }

  dismiss() {
    this.element.style.transition = "opacity 0.3s ease-out";
    this.element.style.opacity = "0";

    setTimeout(() => {
      if (this.element.parentNode) {
        this.element.remove();

        const container = document.getElementById("flash_messages");
        const messagesContainer = container?.querySelector(".space-y-4");

        if (container && messagesContainer && messagesContainer.children.length === 0) {
          container.classList.add("hidden");
        }
      }
    }, 300);
  }
}
