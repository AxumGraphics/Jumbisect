

async function loadWebAssembly(filename, imports) {
    // Fetch the file and compile it
    const response = await fetch(filename)
    const buffer = await response.arrayBuffer();
    const module = await  WebAssembly.compile(buffer);
    const decoder = new TextDecoder();

    // Create the imports for the module, including the
    // standard dynamic library imports
    imports = imports || {};
    imports.env = imports.env || {};
    imports.env.abort =  ()=> { 
        console.error ("Aborted"); 
    };
    imports.env._printf =  function (str) { 
        console.log(str); 
        console.log(arguments); 
    };
    imports.env._printFloat  =  function (v) { 
        console.log(v); 
    };
    imports.env._printLabel  =  function (v) { 
        console.log("***"+v+"***"); 
    };

    imports.env._printString  =  function (v) { 
        const strUtf8 =  new Uint8Array(imports.env.memory.buffer,v)
        console.log(strUtf8);
        let len=0;
        const maxLen=1024;
        for(len=0;len<maxLen;len++) {
            if(!strUtf8[len])
                break;
        }



        const str = decoder.decode(new Uint8Array(imports.env.memory.buffer,v,len));
        //const utf8Str = 
        console.log("String:"+str); 
    };
    
    imports.env._stuff =  function (v) { 
        console.log("v:"+v); 
    };
    imports.env.memoryBase = imports.env.memoryBase || 0;
    imports.env.tableBase = imports.env.tableBase || 0;
    /*if (!imports.env.memory) {
        imports.env.memory = new WebAssembly.Memory(te{ initial: 256 });
    }*/
    if (!imports.env.table) {
        imports.env.table = new WebAssembly.Table({ initial: 8, element: 'anyfunc' });
    }
    // Create the instance.
    return new WebAssembly.Instance(module, imports);
}


async function runTest(containerName) {

    
    const mem = new WebAssembly.Memory({ initial: 16*1024});
    var importObject = {
        env: { 
            memory:mem,
            memoryBase:1024,
        } 
    };

    var i32 = new Uint32Array(mem.buffer);
    for (var i = 0; i < 256; i++) {
        i32[i] = i;
    }
    

    const fetchProm = fetch('Native/raytri.wasm');
    const bufferRes = await fetchProm;
    const buffer = await bufferRes.arrayBuffer();

    console.log(buffer);

    const obj = await loadWebAssembly('Native/raytri.wasm', importObject);
    console.log(obj);
    console.log(obj.exports._foo(0));
    console.log(mem.buffer);
    const numTris =1;
    const triData = new Float32Array(mem.buffer, 1024+0, 9);
    const results = new Float32Array(mem.buffer, 1024+128, 4);
    triData[0] = +1;
    triData[1] = -1;
    triData[2] = 10;

    triData[3] = -1;
    triData[4] = -1;
    triData[5] = 10;

    triData[6] = 0;
    triData[7] = +1;
    triData[8] = 10;


    console.log(triData);

    results.fill(-1);

    const res = obj.exports._intersectTriangles(
        0,0,0,
        0,0,1, 
        1024, 1, 
        1024+128);
  
    console.log(res);
    console.log(results);

	const container = document.getElementById( 'container' );

	const width = window.innerWidth;
	const height = window.innerHeight;


	const camera =  new THREE.PerspectiveCamera( 45, width / height, 0.1, 1000 );
	camera.position.z = 5;
	camera.position.y = 2;
	camera.lookAt(new THREE.Vector3(0,0,0));
	
	const scene = new THREE.Scene();


	
	const hemiLight = new THREE.HemisphereLight();
	//hemiLight.color.setHSL( 0.6, 1, 0.6 );
	//hemiLight.groundColor.setHSL( 0.095, 1, 0.75 );
	hemiLight.position.set( 0, 5, 0 );
	//hemiLight.rotation.x = Math.PI*0.5;
	scene.add( hemiLight );
	
	const bulbLight0 = new THREE.PointLight( 0xffee88, 0.5, 100, 1 );
	bulbLight0.position.set( 0, 4, 5 );
	scene.add( bulbLight0 );
	
	
	const bulbLight1 = new THREE.PointLight( 0xffee88, 0.5, 100, 1 );
	bulbLight1.position.set( 0, 4, -5 );
	scene.add( bulbLight1 );
	    var indices = new Uint16Array(2 * 3 );
    indices[0]=0; indices[1]=1; indices[2]=2;
    indices[3]=3; indices[4]=2; indices[5]=1;
	const s = 2.0;
    var vertices = new Float32Array( 4 * 3 );
    vertices[0]=-s; vertices[1]=-s;  vertices[2]=0;
    vertices[3]=+s; vertices[4]=-s;  vertices[5]=0;
    vertices[6]=-s; vertices[7]=+s;  vertices[8]=0;
    vertices[9]=+s; vertices[10]=+s; vertices[11]=0;
	
    var normals = new Float32Array( 4 * 3 );
    normals[0]=0.0; normals[1]=0.0;  normals[2]=-1.0;
    normals[3]=0.0; normals[4]=0.0;  normals[5]=-1.0;
    normals[6]=0.0; normals[7]=0.0;  normals[8]=-1.0;
    normals[9]=0.0; normals[10]=0.0; normals[11]=-1.0;

    var uvs = new Float32Array( 4 * 2 );
    uvs[0]=1.0; uvs[1]=0.0;
    uvs[2]=0.0; uvs[3]=0.0;
    uvs[4]=1.0; uvs[5]=1.0;
    uvs[6]=0.0; uvs[7]=1.0;

    var planeGeometry = new THREE.BufferGeometry();
    planeGeometry.addAttribute( 'position', new THREE.BufferAttribute( vertices, 3 ) );
    planeGeometry.addAttribute( 'uv', new THREE.BufferAttribute( uvs, 2 ) );
    planeGeometry.addAttribute( 'normal', new THREE.BufferAttribute( normals, 3 ) );
    
	planeGeometry.addAttribute( 'index', new THREE.BufferAttribute( indices, 1 ) );
	planeGeometry.name= "Plane";
	
	const textureLoader = new THREE.TextureLoader();
	
	const boxGeometry = new THREE.BoxGeometry( 2,2,2 );
	const ironNormalMap = textureLoader.load( "normal.jpg" );
	ironNormalMap.wrapS  = THREE.RepeatWrapping;
	ironNormalMap.wrapT  = THREE.RepeatWrapping;
	
	const metalMtl = new THREE.MeshStandardMaterial( {
					roughness: 0.4,
					color: new THREE.Color( 1,1,1 ),
					metalness: 1.0
				});
	

	const redMtl = new THREE.MeshStandardMaterial( {
					roughness: 0.1,
					color: new THREE.Color( 0.8, 0.1, 0.1 ),
					metalness: 0.8,
					normalMap: ironNormalMap,
				});
				
				
	const greenMtl = new THREE.MeshStandardMaterial( {
					roughness: 0.1,
					color: new THREE.Color( 0.1,  0.8, 0.1 ),
					metalness: 0.8,
					normalMap: ironNormalMap,
					
				});
				

	var showUVsMtl = new THREE.ShaderMaterial( {

		uniforms: {

		},

		vertexShader: `
			attribute vec4 color;

            varying vec4 vtxColor;
            varying vec3 vtxNormal;
			varying vec2 vtxUv;
			void main() {
			    mat4 mtx = projectionMatrix *
                              modelViewMatrix;
                gl_Position = mtx * vec4(position, 1.0 );
                vtxUv = uv;
                vtxColor  = color;
                vtxNormal=  normalize(mtx * vec4( normal,  0.0 )).xyz;
            }
		`,
		fragmentShader: `
		    varying vec3 vtxNormal;
			varying vec2 vtxUv;

			void main()	{
				vec3 v = vtxNormal*vec3(0.5)+vec3(0.5);
				gl_FragColor=vec4(vtxUv,0.0,1.0);

			}
		`

	} );

	
	const planeMesh = new THREE.Mesh( planeGeometry, metalMtl );
	planeMesh.position.z = -0.0;
	const boxMesh = new THREE.Mesh( boxGeometry, metalMtl );
	
	const redTargetSphere = new THREE.Mesh( 
		new THREE.SphereGeometry( 0.1, 10, 10 ), 
		new THREE.MeshBasicMaterial({color:0xFF0000}) 
	);
	redTargetSphere.position.y=1000000;
	scene.add(redTargetSphere);
	
	const greenTargetSphere = new THREE.Mesh( 
		new THREE.SphereGeometry( 0.1, 10, 10 ), 
		new THREE.MeshBasicMaterial({color:0x00FF00}) 
	);
	greenTargetSphere.position.y=1000000;
	scene.add(greenTargetSphere);
	
	const sphereGeometry = new THREE.SphereGeometry( 0.75, 256, 256 );
	const sphereMesh0 = new THREE.Mesh( sphereGeometry, greenMtl );
	sphereMesh0.position.y=1.0;
	const sphereMesh1 = new THREE.Mesh( sphereGeometry, greenMtl );
	sphereMesh1.position.x=1.0;
	const sphereMesh2 = new THREE.Mesh( sphereGeometry, greenMtl );
	sphereMesh2.position.x=-1.0;
	const parent = new THREE.Group();
	parent.add( sphereMesh0 );
	parent.add( sphereMesh1 );
	parent.add( sphereMesh2 );
	parent.add( boxMesh );
	parent.add( planeMesh );
	scene.add( parent );
	
	//var helper = new THREE.VertexNormalsHelper( panelMesh, 0.25, 0xaaff33 );
	//panelMesh.add(helper);
	
	renderer = new THREE.WebGLRenderer();
	container.appendChild( renderer.domElement );
	renderer.setClearColor( 0xdddddd ); 
	onWindowResize();

	const tiltElement = document.getElementById( 'tiltSlider' );
	const panElement = document.getElementById( 'panSlider' );
	const zoomElement = document.getElementById( 'zoomSlider' );
	const label0Element = document.getElementById( 'label0' );
	const label1Element = document.getElementById( 'label1' );

	const cameraPos = new THREE.Vector3();
	const cameraTiltMtx = new THREE.Matrix4();
	const cameraPanMtx = new THREE.Matrix4();
	const cameraMtx = new THREE.Matrix4();
	const sliderCB = ()=>{
		const tilt = tiltElement.value;
		const pan = panElement.value;
		const zoom = zoomElement.value;
		cameraTiltMtx.makeRotationX ( THREE.Math.degToRad ( -tilt)); 
		cameraPanMtx.makeRotationY ( THREE.Math.degToRad ( -pan)); 
		cameraMtx.multiplyMatrices(cameraPanMtx, cameraTiltMtx );
		
		cameraPos.set(0,0,zoom);
		
		cameraPos.applyMatrix4(cameraMtx);
		
		
		camera.position.copy( cameraPos);
		camera.lookAt(new THREE.Vector3(0,0,0));
	
	}
	
	tiltElement.oninput = sliderCB;
	panElement.oninput = sliderCB;
	zoomElement.oninput = sliderCB;
	sliderCB();
	window.addEventListener( 'resize', onWindowResize, false );

	
	
	function onWindowResize( event ) {

		renderer.setSize( window.innerWidth, window.innerHeight );

	}
	const raycaster = new THREE.Raycaster();
	const mouse = new THREE.Vector2();
	function onMouseMove( event ) {

		// calculate mouse position in normalized device coordinates
		// (-1 to +1) for both components

		mouse.x = ( event.clientX / window.innerWidth ) * 2 - 1;
		mouse.y = - ( event.clientY / window.innerHeight ) * 2 + 1;

	}
	let clicked = false;
	function onMouseDown( event ) {
		clicked=true;
		
	}
	

	function animate() {
		const t = 0.001* Date.now();
		parent.position.x = Math.sin(t);
		parent.position.y = Math.cos(t);
		
		requestAnimationFrame( animate );
		render();

	}

	window.addEventListener( 'mousemove', onMouseMove, false );

	window.addEventListener( 'mousedown', onMouseDown, false );

	const timings=[];
	
	function render() {
			
		raycaster.setFromCamera( mouse, camera );
			
		renderer.render(scene, camera);
		if(clicked) {

			start = Date.now();
			var intersects = raycaster.intersectObjects( [parent], true );
			end = Date.now();
			if(intersects.length)
			{
				redTargetSphere.position.copy(intersects[0].point);
				redTargetSphere.visible = true;
			}
			else redTargetSphere.visible = false;
			label0Element.innerHTML = `three.js raycast ${end-start}ms`
		}
				
		start = Date.now();
	
		clicked=false;

	}

	animate();


}
