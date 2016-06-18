$(document).ready(function() {
  var ctx = $("#team-streak").get(0).getContext("2d");
  var data = [
    {
      value: 270,
      color: "cornflowerblue",
      highlight: "lightskyblue",
      label: "Corn Flower Blue"
    },
    {
      value: 50,
      color: "lightgreen",
      highlight: "yellowgreen",
      label: "Lightgreen"
    },
    {
      value: 40,
      color: "orange",
      highlight: "darkorange",
      label: "Orange"
    }
  ];

  var piechart = new Chart(ctx).Pie(data);
});
