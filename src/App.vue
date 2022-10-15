<template>
  <div style="width: 800px">
      <PeriodicTable
      @selectionChanged="(element) => updateSelection(element.element, element.selected)"
      :potentialsAvailableFor=possibleElements />
  </div>
  <div style="width: 800px; height: 240px; overflow-y: scroll">
    <h2> Available Potentials </h2>
    <table style="width:100%">
      <tr v-if="availablePotentials.length > 0">
      <td><b> Potential Name</b> </td><td><b>Elements</b></td><td><b>Repository</b></td></tr>
      <tr v-for ="(potential,key) in availablePotentials" :key="key">
        <td @click="displayDetails(potential)"><u>{{potential.name}}</u></td> <td>{{potential.elements}}</td>
        <td>{{potential.source}}</td>
      </tr>
    </table> 
  </div>
    <!-- use the modal component, pass in the prop -->
    <PotentialDetailModal :show="showModal" :potentialDetails="currentPotential" @close="showModal = false" />      
</template>

<script>
import PeriodicTable from './components/PeriodicTable.vue'
import potentials from './assets/potentials.json'
import PotentialDetailModal from './components/PotentialDetailModal.vue'

export default {
  name: 'App',
  components: {
    PeriodicTable,
    PotentialDetailModal    
  },
  data ()
  {
    return {
      selectedElements: [],
      currentPotential: {},
      showModal: false,
      possibleElements: []
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
    displayDetails(potential)
    {
      console.log(potential)
      this.currentPotential = potential;      
      this.showModal = true;
    },  
    getPossibleElements()
    {
      for(const potential of potentials)
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
      for(const potential of potentials)
      {
        if(this.selectedElements.every((x) => potential.elements.includes(x)))
        {
          available.push(potential);
        }
      }
      return available;
    }    
  },    
  created () {
        this.getPossibleElements();        
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
  margin-top: 60px;
}
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}


</style>
