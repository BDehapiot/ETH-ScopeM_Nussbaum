dir = "C:/Users/bdeha/Projects/ETH-ScopeM_Nussbaum/data/"
dirlist = getFileList(dir);
run("Set Measurements...", "area_fraction display redirect=None decimal=3");

/// --- Dialog --- ///

Dialog.create("FungiSeg-Options");
RollingBallRadius = Dialog.addNumber("Roll. Ball Radius", 128);
MedianFilterRadius = Dialog.addNumber("Med. Filt. Radius", 2);
BinaryThresh = Dialog.addNumber("Binary Tresh.", 25);
MinObjectSize = Dialog.addNumber("Min. Object Size (pixel^2)", 512);

Dialog.show();

RollingBallRadius = Dialog.getNumber();
MedianFilterRadius = Dialog.getNumber();
BinaryThresh = Dialog.getNumber();
MinObjectSize = Dialog.getNumber();

/// --- Process --- ///

setBatchMode(true);

for (i=0; i<dirlist.length; i++) {
	
	file_name = dirlist[i];
	
	if (endsWith(file_name, "maxProj.tif")){
		
		// Open image
		open(dir + file_name);
		
		// Process image
		img = getTitle();
		setMinAndMax(0, 1000);
		run("8-bit");
		run("Duplicate...", " ");
		tmp1 = getTitle();
		run("32-bit");
		run("Subtract Background...", "rolling="+RollingBallRadius); // subtract background
		run("Median...", "radius="+MedianFilterRadius); // median filter
		
		// Binarize (segmentation)
		setThreshold(BinaryThresh, 255);
		setOption("BlackBackground", true);
		run("Convert to Mask");
		run("Analyze Particles...", "size="+MinObjectSize+"-Infinity show=Masks"); // Remove small objects
		rename(replace(file_name, ".tif", "_mask.tif"));
		mask = getTitle();
		run("Invert LUT");
		run("Measure");	// Get area fraction
		
		// Display segmentation
		run("Duplicate...", " ");
		tmp2 = getTitle();
		run("Outline");
		run("Merge Channels...", "c1=["+tmp2+"] c2=["+mask+"] c4=["+img+"] create");
		Stack.setActiveChannels("101");
		rename(replace(file_name, ".tif", "_outline.tif"));
		composite = getTitle();
		close(tmp1);
		
	}		
}

/// --- Display and choice --- ///

setBatchMode("exit and display");
run("Tile");

nextchoice = getBoolean("What next?", "Save", "CloseAll");

setBatchMode(true);

if (nextchoice==1){
	
	imglist = getList("image.titles");
		
	for (i=0; i<imglist.length; i++) {
		
		selectWindow(imglist[i]);	
		run("Duplicate...", "duplicate channels=2");
		run("Grays");	
		saveAs("tiff",dir+replace(imglist[i], "_outline.tif", "_mask.tif"));
		close();
											
	}
	
	saveAs("Results", dir+"Results.csv");
	nextchoice = 0;
	
}

if (nextchoice==0){
	
	macro "Close All Windows" { 
		while (nImages>0) { 
		selectImage(nImages); 
		close();
		}
		if (isOpen("Log")) {selectWindow("Log"); run("Close");} 
		if (isOpen("Summary")) {selectWindow("Summary"); run("Close");} 
		if (isOpen("Results")) {selectWindow("Results"); run("Close");}
		if (isOpen("ROI Manager")) {selectWindow("ROI Manager"); run("Close");}
		} 
			
}
