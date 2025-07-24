import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["category", "area"];

  categoryChanged() {
    this.areaTarget.selectedIndex = 0;
    this.categoryTarget.form.requestSubmit();
  }

  areaChanged() {
    this.categoryTarget.selectedIndex = 0;
    this.areaTarget.form.requestSubmit();
  }
}
