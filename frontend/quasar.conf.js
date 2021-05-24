module.exports = function (/* ctx */) {
  return {
    supportTS: false,

    boot: [
      'auth'
    ],

    css: [
      'app.scss'
    ],

    extras: [
      // 'ionicons-v4',
      // 'mdi-v5',
      // 'fontawesome-v5',
      // 'eva-icons',
      // 'themify',
      // 'line-awesome',
      // 'roboto-font-latin-ext', // this or either 'roboto-font', NEVER both!

      'roboto-font', // optional, you are not bound to it
      'mdi-v5', // optional, you are not bound to it
    ],

    build: {
      vueRouterMode: 'history', // available values: 'hash', 'history'

      env: {
        API_URL: process.env.API_URL
      },
      // transpile: false,
      extendWebpack(cfg) {
      },
    },

    devServer: {
      https: true,
      port: 8080,
      open: true,
      hot: true,
      host: process.env.ORIGIN_URL.replace(/^http(s|):\/\//g, '').replace(/:\d{4}$/g, ''),
      disableHostCheck: true,
    },

    framework: {
      iconSet: 'mdi-v5', // Quasar icon set
      lang: 'en-us', // Quasar language pack
      config: {},
      importStrategy: 'auto',

      plugins: ['Notify']
    },

    animations: [],

    ssr: {
      pwa: false
    },

    cordova: {},

    capacitor: {
      hideSplashscreen: true
    },

    electron: {
      bundler: 'packager', // 'packager' or 'builder'

      packager: {},

      builder: {
        appId: 'frontend'
      },

      nodeIntegration: true,

      extendWebpack(/* cfg */) {}
    }
  }
}
