importScripts('js/bvhtree.js');

let tree = null;
onmessage = function(e) {
  var data = e.data;
  console.log(e);
  switch (data.cmd) {
	case "tris": 
		var maxTrianglesPerNode = 7; 
		start = Date.now();
		tree = new bvhtree.BVH(data.tris, maxTrianglesPerNode);
		end = Date.now();
		
		tris=null;
		
		postMessage({
			cmd:"BVHBuilt",
		});
		break;
		
	case "isect": 
		if(tree) {
			start = Date.now();
			var intersectionResult = tree.intersectRay(
				invOrigin, 
				invDirection, 
				true);
			end = Date.now();
			console.log(`BVH raycast ${end-start}ms`)
			
			postMessage({
				cmd:"BVHResult",
				intersectionResult
			});
		}

		break;
  }
}



