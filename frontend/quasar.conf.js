/*
 * This file runs in a Node context (it's NOT transpiled by Babel), so use only
 * the ES6 features that are supported by your Node version. https://node.green/
 */

module.exports = function (/* ctx */) {
  return {
    supportTS: false,

    boot: [
    ],

    css: [
      'app.scss'
    ],

    extras: [
      'roboto-font', // optional, you are not bound to it
      'mdi-v5', // optional, you are not bound to it
    ],

    build: {
      vueRouterMode: 'history', // available values: 'hash', 'history'

      // transpile: false,

      extendWebpack (cfg) {
      },
    },

    devServer: {
      https: false,
      port: 8080,
      open: true
    },

    framework: {
      iconSet: 'mdi-v5', // Quasar icon set
      lang: 'en-us', // Quasar language pack
      config: {},

      importStrategy: 'auto',

      plugins: []
    },

    animations: [],

    ssr: {
      pwa: false
    },

    pwa: {
      workboxPluginMode: 'GenerateSW', // 'GenerateSW' or 'InjectManifest'
      workboxOptions: {}, // only for GenerateSW
      manifest: {
        name: `Quasar App`,
        short_name: `Quasar App`,
        description: `A Quasar Framework app`,
        display: 'standalone',
        orientation: 'portrait',
        background_color: '#ffffff',
        theme_color: '#027be3',
        icons: [
          {
            src: 'icons/icon-128x128.png',
            sizes: '128x128',
            type: 'image/png'
          },
          {
            src: 'icons/icon-192x192.png',
            sizes: '192x192',
            type: 'image/png'
          },
          {
            src: 'icons/icon-256x256.png',
            sizes: '256x256',
            type: 'image/png'
          },
          {
            src: 'icons/icon-384x384.png',
            sizes: '384x384',
            type: 'image/png'
          },
          {
            src: 'icons/icon-512x512.png',
            sizes: '512x512',
            type: 'image/png'
          }
        ]
      }
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

      extendWebpack (/* cfg */) {}
    }
  }
}
