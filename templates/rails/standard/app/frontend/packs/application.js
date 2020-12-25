import { Turbo, cable } from "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "controllers"

ActiveStorage.start()

const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

// External imports

// Internal imports

// External calls
// document.addEventListener('turbo:load', () => {

// });
