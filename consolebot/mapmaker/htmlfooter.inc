      ];

      function setMarkers(map, locations) {
        // Add markers to the map

        // Marker sizes are expressed as a Size of X,Y
        // where the origin of the image (0,0) is located
        // in the top left of the image.

        // Origins, anchor positions and coordinates of the marker
        // increase in the X direction to the right and in
        // the Y direction down.
        var image = {
          url: 'http://r.thesuki.org/maps/images/neutral.png',
          // This marker is 20 pixels wide by 32 pixels tall.
          size: new google.maps.Size(30, 30),
          // The origin for this image is 0,0.
          origin: new google.maps.Point(0,0),
          // The anchor for this image is the base of the flagpole at 0,32.
          anchor: new google.maps.Point(15, 15)
        };
//        var image = {
//          url: 'images/beachflag.png',
//          // This marker is 20 pixels wide by 32 pixels tall.
//          size: new google.maps.Size(20, 32),
//          // The origin for this image is 0,0.
//          origin: new google.maps.Point(0,0),
//          // The anchor for this image is the base of the flagpole at 0,32.
//          anchor: new google.maps.Point(0, 32)
//        };
//        var shadow = {
//          url: 'images/beachflag_shadow.png',
//          // The shadow image is larger in the horizontal dimension
//          // while the position and offset are the same as for the main image.
//          size: new google.maps.Size(37, 32),
//          origin: new google.maps.Point(0,0),
//          anchor: new google.maps.Point(0, 32)
//        };
        // Shapes define the clickable region of the icon.
        // The type defines an HTML &lt;area&gt; element 'poly' which
        // traces out a polygon as a series of X,Y points. The final
        // coordinate closes the poly by connecting to the first
        // coordinate.
        var shape = {
            coord: [1, 1, 1, 20, 18, 20, 18 , 1],
            type: 'poly'
        };
        for (var i = 0; i < locations.length; i++) {
          var beach = locations[i];
          var myLatLng = new google.maps.LatLng(beach[1], beach[2]);
          var marker = new google.maps.Marker({
              position: myLatLng,
              map: map,
              icon: image,
              shape: shape,
              title: beach[0],
              zIndex: beach[3]
          });
        }
      }
    </script>
  </head>
  <body onload="initialize()">
    <div id="map_canvas"></div>
  </body>
</html>
