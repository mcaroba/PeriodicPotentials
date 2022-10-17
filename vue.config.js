const { defineConfig } = require('@vue/cli-service')

process.env.VUE_APP_EXT_HTML = "https://raw.githubusercontent.com/mcaroba/PeriodicPotentials/main/src/assets/potentials_gap.json"

module.exports = defineConfig({
  transpileDependencies: true,
  publicPath: process.env.NODE_ENV === "production" ? "https://turbogap.fi/periodicpotentials/" : "/",
})
