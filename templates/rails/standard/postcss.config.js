let environment = {
  plugins: [
    require('postcss-import-ext-glob'),
    require('postcss-import'),
    require('tailwindcss'),
    require('autoprefixer'),
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    }),
  ]
}

// Only run PurgeCSS in production
if (process.env.RAILS_ENV === "production" ||
    process.env.RAILS_ENV === "staging") {
  environment.plugins.push(
    require('@fullhuman/postcss-purgecss')({
      content: [
        "./app/views/**/*.html.erb",
        "./app/components/**/*.html.erb",
        "./app/components/**/*.rb",
        "./app/helpers/**/*.rb",
        "./app/assets/javascript/controllers/**/*.js",
        "./app/assets/javascript/libraries/**/*.js",
      ],
      defaultExtractor: content => content.match(/[A-Za-z0-9-_:/]+/g) || []
    })
  )
}

module.exports = environment
