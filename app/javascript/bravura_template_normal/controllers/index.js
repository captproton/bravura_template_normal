// Import the necessary modules from Stimulus and Stimulus-loading
import { Application } from "@hotwired/stimulus"

// Start the Stimulus application
const application = Application.start()

// Eager load all controllers defined in the import map under controllers/**/*_controller
// Note: You need to manually import and register controllers with esbuild,
// or use a plugin or script that dynamically imports controllers based on a convention.
// This example assumes a manual import and registration approach.

// Example controller import and registration (adjust paths as necessary)
// import HelloController from "./hello_controller"
// application.register("hello", HelloController)

// If you have a dynamic import solution or plugin for esbuild, use it here to load controllers
// For example, using a hypothetical plugin or function that loads controllers:
// dynamicLoadControllers(application, "controllers", true, /_controller\.js$/)

// Note: The dynamic loading part is conceptual and depends on your project setup and tools.