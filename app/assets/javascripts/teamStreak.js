// $(document).ready(function() {
  var names = [], streak_data = [];
  for (var user in gon.users) {
    names.push(gon.users[user][user][0]);
    streak_data.push(gon.users[user][user][1]);
  }
  var dynamicData = [];
  for (var user in gon.users) {
    dynamicData.push({label: gon.users[user][user][0], value: gon.users[user][user][1]});
  }

  dynamicData.forEach(function (e, i) {
      e.color = "hsl(" + (i / dynamicData.length * 360) + ", 50%, 50%)";
      e.highlight = "hsl(" + (i / dynamicData.length * 360) + ", 50%, 70%)";
  })

  var ctx = document.getElementById("team-streak").getContext("2d");
  setTimeout(function() {
    var myPieChart = new Chart(ctx).Pie(dynamicData);
  }, 1000);
// });
