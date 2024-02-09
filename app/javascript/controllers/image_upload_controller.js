import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fileField", "imagePreview"]

  connect() {
    this.fileFieldTarget.addEventListener("change", (event) => {
      this.previewImage(event)
    })
  }

  previewImage(event) {
    const input = event.target
    if (input.files && input.files[0]) {
      const reader = new FileReader()
      reader.onload = (e) => {
        this.imagePreviewTarget.src = e.target.result
        this.imagePreviewTarget.style.display = 'block'
      }
      reader.readAsDataURL(input.files[0])
    }
  }

  openFileField() {
    this.fileFieldTarget.click()
  }
}
