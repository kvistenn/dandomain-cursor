module.exports = {
  content: [
    "./*.tpl",
    "./partials/*.tpl",
    "./modules/**/*.tpl",
    "./modules/**/partials/*.tpl",
    "./modules/**/**/**/*.{js,css}",
    "./modules/widgets/**/*.tpl",
    "./modules/widgets/**/partials/*.tpl",
    "./modules/widgets/**/**/**/*.{js,css}",
    "./source/js/platform.js"
  ],
  theme: {
    extend: {
      colors: {
        primary: '#40a020',
        secondary: '#d1f2e0',
        tertiary: '#d9d2d2',
      }
    },
    container: {
      center: true,
      padding: '1rem',
      screens: {
        'xl': '1400px',
        '2xl': '1680px',
      }
    }
  },
  plugins: [
    require('@tailwindcss/typography'),
  ]
}
  