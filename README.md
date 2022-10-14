# Periodic Potentials

Potential information is currently retrieved from src/assets/potentials.json
The format is as follows:
```json
[
    {
        "name": "Name of Potntial 1",
        "elements": [ "List", "Of", "Element", "Symbols", "Like", "H", "C", "Se","..."],
        "source": "https://a.url.pointing.to/the/source/of/this/potential"
    }
]
```

Color changes can be made in the `<style>` section of `src/components/PeriodicTable.vue`. 

Elemental information was retrieved from:
https://raw.githubusercontent.com/diniska/chemistry/master/PeriodicalTable/periodicTable.json

Main Code for the periodic table (before modifications) was retrieved from:
https://codepen.io/spAnser/pen/bqbvOq (licensed under MIT License)


## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Deploy to the gh-pages branch of the remote repository
```
npm run deploy
```

### Lints and fixes files
```
npm run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).
