import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    this.autoDismissFlashMessages();
  }

  autoDismissFlashMessages() {
    const flashMessages = document.querySelectorAll('.alert');
    flashMessages.forEach((message) => {
      setTimeout(() => {
        message.classList.remove('show');
        message.classList.add('fade');
      }, 1000); // 1 second for auto-dismissal
    });
  }
}
