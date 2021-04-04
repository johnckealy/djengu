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
      'roboto-font',
      'material-icons'
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
      iconSet: 'material-icons',
      lang: 'en-us',
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
