// document.addEventListener("DOMContentLoaded", function(event) { 

// d3.json("/links/7/d3_data", function(error, data){
//   var width = 500;
//   var height = 200;

// var widthScale = d3.scale.linear()
//     .domain([0, 60])
//     .range([0, width]);

//   var color = d3.scale.linear()
//     .domain([0, 60])
//     .range(["red", "blue"])   

//    var axis = d3.svg.axis()
//     .ticks(5)
//     .scale(widthScale);   

// var canvas = d3.select('#d3')  
//     .append('svg')
//     .attr('width', width)
//     .attr('height', height)
//     .append("g")
//     .attr("transform", "translate(20, 0)");

// var bars = canvas.selectAll('rect')
//     .data (data)
//     .enter()
//       .append("rect")
//       .attr("width", function(d) {return widthScale(d);})
//       .attr("height", 50)
//       .attr("fill", function (d) {return color (d)})
//       .attr("y", function(d, i){return i * 100});


//       canvas.append('g')
//       .attr("transform", "translate(0, 470)")
//       .call(axis);      

// });
// });



