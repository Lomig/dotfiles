import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["countdown", "buttons"]
  static values  = { timeout: Number, actionUrl: String, actionMethod: String }

  connect() {
    if (document.documentElement.hasAttribute('data-turbo-preview')) return;

    // Display with transition
    setTimeout(() => {
      this.element.classList.remove('hidden');
      this.element.classList.add('transform', 'ease-out', 'duration-300', 'transition', 'translate-y-2', 'opacity-0', 'sm:translate-y-0', 'sm:translate-x-2');

      // Trigger transition
      setTimeout(() => {
        this.element.classList.add('translate-y-0', 'opacity-100', 'sm:translate-x-0');
      }, 100);

      // Trigger countdown
      if (this.hasCountdownTarget) {
        this.countdownTarget.style.animation = 'notification-countdown linear ' + this.timeoutValue + 's';
      }

    }, 500);

    // Auto-hide
    this.timeoutId = setTimeout(() => {
      this.close();
    }, this.timeoutValue * 1_000 + 500);
  }

  run(e) {
    e.preventDefault();
    this.stop();

    this.buttonsTarget.innerHTML = '<span class="text-sm leading-5 font-medium text-grey-700">Processing...</span>';

  }

  successCommand(response) {
    this.buttonsTarget.innerHTML = '<span class="text-sm leading-5 font-medium text-green-700">Done!</span>'

    setTimeout(() => {
      this.close();
    }, 1000);
  }

  errorCommand(response) {
    this.buttonsTarget.innerHTML = '<span class="text-sm leading-5 font-medium text-red-700">Error!</span>'

    setTimeout(() => {
      this.close();
    }, 1000);
  }

  stop() {
    clearTimeout(this.timeoutId)
    this.timeoutId = null
  }

  close() {
    // Remove with transition
    this.element.classList.remove('transform', 'ease-out', 'duration-300', 'translate-y-2', 'opacity-0', 'sm:translate-y-0', 'sm:translate-x-2', 'translate-y-0', 'sm:translate-x-0');
    this.element.classList.add('ease-in', 'duration-100')

    // Trigger transition
    setTimeout(() => {
      this.element.classList.add('opacity-0');
    }, 100);

    // Remove element after transition
    setTimeout(() => {
      this.element.remove();
    }, 300);
  }
}
