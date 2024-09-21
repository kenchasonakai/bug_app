const { default: daisyui } = require("daisyui");

module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [require("flowbite-typography"), require("daisyui")],
  daisyui: {
    themes: false,
    darkTheme: false,
    base: true,
    styled: true,
    utils: true,
    prefix: "",
    logs: true,
    themeRoot: ":root",
  },
  theme: {
    container: {
      center: true,
      padding: '1rem',
    },
  }
}
