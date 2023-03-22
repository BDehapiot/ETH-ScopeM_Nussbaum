# ETH-ScopeM_Nussbaum
Fiji macro to compare fungi propagation on different substrates

## Request
The raw images provided for analysis were confocal Z-stacks of fungi growing on different substrate conditions, with varying brightness and number of slices. The objective was to determine the fraction of surface area covered by fungi under the different conditions.

## Suggested solution
To do this, we first produced maximum confocal Z-stack projections, considering only the first 67 slices in order to accommodate the number of slices present in the smallest stack. We then wrote a Fiji macro `BD_FungiSeg.ijm` to automatize a segmentation procedure. This macro first normalize image brightness by subtracting background (Fiji rolling ball function) and smooth images using a median filter. This is followed by a binarization step using the same threshold for all images. Finally, the fraction of surface covered by the binary mask is measured and exported to Results.csv table.

The macro take 4 parameters:
- `Rolling ball radius` for background subtraction (pixel)
- `Median filter radius` for smoothing images (pixel)
- `Binary threshold` for segmentation (A.U.)
- `Minimum object size` to discard small objects from the mask (pixel^2)

Maximum projections, masks and the Results.csv table are automatically saved in the `data` folder. 

⚠️ Please set path toward data directory to run the macro (first line) 

