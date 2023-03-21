dir = "C:/Users/bdeha/Projects/ETH-ScopeM_Nussbaum/data/"
list = getFileList(dir);

for (i=0; i<list.length; i++) {
	
	file_name = list[i];
	
	if (endsWith(file_name, "maxProj.tif")){
		
		// Open image
		open(file_name);
		
		// Process image
		img = getTitle();
		run("Duplicate...", " ");
		tmp1 = getTitle();
		run("32-bit");
		run("Subtract Background...", "rolling=128");
		run("Median...", "radius=5");
		setThreshold(10, 65535);
		setOption("BlackBackground", true);
		run("Convert to Mask");
		run("Analyze Particles...", "size=512-Infinity show=Masks add");
		tmp2 = getTitle();
		run("Invert LUT");

		// Save mask
		saveAs("tiff",dir+replace(file_name, ".tif", "_mask.tif"));
		
		// Close images
		close(tmp1);
		close(tmp2);
		close(img);
		
	}		
}


//raw = getTitle();
//run("Duplicate...", " ");
//tmp1 = getTitle();
//run("32-bit");
//run("Subtract Background...", "rolling=128");
//run("Median...", "radius=5");
//setThreshold(10, 65535);
//setOption("BlackBackground", true);
//run("Convert to Mask");
//run("Analyze Particles...", "size=512-Infinity show=Masks add");
//run("Invert LUT");
//close(tmp1);