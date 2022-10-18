<!-- The MIT License (MIT)

Copyright (c) 2022 spAnser (https://codepen.io/spAnser/pen/bqbvOq)
Copyright (c) 2022 Thomas Pfau 
Copyright (c) 2022 Miguel A. Caro
 
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE. -->

<template>
    <div>
      <div v-for="(period,periodIndex) in table" :key=periodIndex class="period">
          <div v-for="(element,elementIndex) in period.elements" :key=elementIndex+18*periodIndex class="element"
              :class="[element.group.toLowerCase().replace('element ', '').split(' '), element.selected ? 'selected' : 'unselected', element.available ? 'available' : 'unavailable']"
              :style="{left: (100 / 18 * element.position) + '%'}"
              @click="toggleSelect(element)"
              >
              <div class="atomic-number" v-if="element.number">{{ element.number }}</div>
              <div class="symbol" v-if="element.name">{{ element.small }}</div>
              <div class="group" v-else>{{ element.small }}</div>
              <!--
              <div class="name" v-if="element.name">{{ element.name }}</div>
              <div class="atomic-weight" v-if="element.molar">{{ element.molar }}</div>
              -->
          </div>
      </div>
    </div>
  </template>
  
  <script>
import data from '../assets/periodicTable.json'
  export default {
    name: 'PeriodicTable',
    props: {
      potentialsAvailableFor: {
                    type: Array,
                    required: true
                  }
    },
    data() {
    return {      
        table: null,        
      }
    },
    created () {
        this.loadData()        
    },
    methods: {        
        loadData () {
          console.log(data)
          this.table = data.table        
          this.table.push({elements:data.lanthanoids})
          this.table.push({elements:data.actinoids})                                  
          this.setupElements()
        },
        toggleSelect(element)
        {
          if(element.name && element.available)
          {
            if(element.selected)
            {
              element.selected = false;
              this.$emit('selectionChanged', {element: element, selected : false} )
            }
            else
            {
              element.selected = true;
              this.$emit('selectionChanged', {element: element, selected : true} )
            }
          }
        },
  
        setupElements(){        
          for(const period of this.table)
          {                    
            for(const element of period.elements)
            {
              if(this.potentialsAvailableFor.includes(element.small))
              {
                console.log("Activating " + element.small)
                element.available = true;
              }
            }
          }        
        },
        getElementClass(element)
        {
          if(element.selected)
          {
            return element.group.toLowerCase().replace('element ', '').split(' ') + " selected"
          }
          else
          {
            return element.group.toLowerCase().replace('element ', '').split(' ')
          }
        }
    },
    watch:
    {
      potentialsAvailableFor()
      {
        this.setupElements();
      }
    }
  }
  </script>
  
  
  <style lang="scss" scoped>
  @import "bourbon";
  
  body {
    font-family: 'Ubuntu Mono', monospace; font-size: 10px;
  }
  
  a {
    @include margin(4px);
    @include padding(4px 8px);
    display: inline-block;
    background-color: #ddd;
    color: #000;
    text-decoration: none;
    &:hover {
        color: #fff;
        background-color: #000;
    }
  }
  
  .period {
    @include margin(null auto);
    max-width: 1600px;
    position: relative;
    height: 36px;
  }
  
  .element {
    @include position(absolute, 0 null 0 0);
    @include padding(8px 2px 2px);
    width: calc(percentage(calc(1 / 18)) - 8px);
    background-color: rgb(72, 255, 44);  
    opacity: 0.9;
    &:hover {
        opacity: 1.0;      
    }
    &:before {
        @include position(absolute, 0 -1px -1px 0);
        display: block;
        content: '';
        border: 1px solid #000;
    }
    .atomic-number {
        @include position(absolute, 1px null null 1px);
        font-size: 10px;
    }
    .electrons {
        @include position(absolute, 1px 1px null null);
        text-align: right;
        font-size: 8px;
    }
    .symbol {
        font-size: 16px;
        line-height: 1.5;
    }
    .group {
        @include position(absolute, 50% null null 50%);
        transform: translateY(-50%);
        transform: translateX(-50%);
        width: 100%;
        text-align: center;
    }
    .name {
        font-size: 10px;
        line-height: 1.25;
    }
    .atomic-weight {
        font-size: 7px;
        line-height: 1.25;
    }
    &.selected
    {
      opacity: 1.0;
      border: 3px solid #000;
      width: calc(percentage(calc(1 / 18)) - 14px);      
    }
    &.unavailable
    {
      opacity: 0.3;
    }
    &.noble {
        background-color: rgb(126, 204, 255);
    }
    &.alkali {
        background-color: rgb(252, 205, 54);
    }
    &.alkaline {
        background-color: rgb(255, 255, 72);
    }
    &.nonmetal {
        background-color: rgb(72, 255, 44);
    }
    &.halogen {
        background-color: rgb(69, 240, 204);
    }
    &.metalloid {
        background-color: rgb(127, 223, 137);
    }
    &.poor {
        background-color: rgb(158, 222, 204);
    }
    &.transition {
        background-color: rgb(219, 186, 187);
    }
    &.lanthanoid {
        background-color: rgb(252, 186, 153);
    }
    &.actinoid {
        background-color: rgb(236, 185, 221);
    }
  }
  
  </style>
