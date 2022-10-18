<template>
  <div style="width: 800px; height: 200px; margin-bottom: 10px; border:1px solid black; overflow-y: scroll">
    <h4>Available Potentials (click on elements in periodic table to refine search)</h4>
    <table style="width: 760px; margin: 10px">
      <tr v-if="availablePotentials.length > 0">
      <td><b>Potential Name</b> </td><td><b>Elements</b></td><td><b>Repository</b></td><td><b>Publication</b></td></tr>
      <tr v-for ="(potential,key) in availablePotentials" :key="key">
        <td>{{potential.name}}</td>
        <td>{{potential.elements}}</td>
        <td><a v-bind:href="potential.zenodourl"><img v-bind:src="potential.zenodoimg" v-bind:alt="potential.zenodoalt" target="_blank"></a></td>
        <td><a v-bind:href="potential.url" target="_blank">{{potential.ref}}</a></td>
      </tr>
    </table> 
  </div>
  <div style="width: 800px">
      <PeriodicTable
      @selectionChanged="(element) => updateSelection(element.element, element.selected)"
      :potentialsAvailableFor=possibleElements />
  </div>
  <div style="width: 800px; margin-top: 10px; font-size: 75%; text-align: left">
  PeriodicPotentials is Copyright (c) 2022 of spAnser, Thomas Pfau and Miguel A. Caro (see
  <a href="https://github.com/mcaroba/PeriodicPotentials" target="_blank">github.com/mcaroba/PeriodicPotentials</a> for copyright and license information).
  </div>
</template>

<script>
import PeriodicTable from './components/PeriodicTable.vue'


function readTextFile(file, callback) {
  var rawFile = new XMLHttpRequest();
  rawFile.overrideMimeType("application/json");
  rawFile.open("GET", file, true);
  rawFile.onreadystatechange = function() {
      if (rawFile.readyState === 4 && rawFile.status == "200") {
          callback(rawFile.responseText);
          console.log(rawFile.responseText)
      }
  }
  rawFile.send(null);
}      

export default {
  name: 'App',
  components: {
    PeriodicTable,    
  },
  data ()
  {
    return {
      selectedElements: [],
      currentPotential: {},
      showModal: false,
      possibleElements: [],
      potentials: []
    }
  },
  methods:
  {
    updateSelection(element, added)
    {
      if(added)
      {
        this.selectedElements.push(element.small);
      }
      else{
        var index = this.selectedElements.indexOf(element.small);
        if (index !== -1) {
          this.selectedElements.splice(index, 1);
        }
      }
    },
    getPossibleElements()
    {
      for(const potential of this.potentials)
      {
        this.possibleElements.push(...potential.elements);
      }
      // make unique      
      this.possibleElements = [... new Set(this.possibleElements)];
    }
  },
  computed:
  {
    availablePotentials()
    {
      const available = []
      for(const potential of this.potentials)
      {
        if(this.selectedElements.every((x) => potential.elements.includes(x)))
        {
          available.push(potential);
        }
      }
      return available;
    }    
  },    
  created() {  
      var _this = this;
      readTextFile(process.env.VUE_APP_EXT_HTML, function(text){
          _this.potentials = JSON.parse(text);              
          _this.getPossibleElements();     
          });                  
         
    },
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 10px;
  margin-bottom: 10px;
}
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}


</style>
