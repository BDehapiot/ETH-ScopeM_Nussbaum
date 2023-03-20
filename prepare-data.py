#%% Imports

import time
from skimage import io 
from pathlib import Path
from skimage.transform import resize
from bdtools.dtype import ranged_conversion

#%% Parameters

stack_name = 'GL_HMA_edge_S1.tif'

#%% Open data

stack_path = Path('data', stack_name)

stack = io.imread(stack_path)

stack = resize(
    stack, (stack.shape[0], 1024, 1024),
    preserve_range=False,
    )

stack = ranged_conversion(
    stack, 
    intensity_range=(5,95), 
    spread=3, 
    dtype='float')

# io.imsave(
#     Path(str(stack_path).replace('.tif', 'rsize.tif')),
#     stack.astype('uint16'),
#     check_contrast=False,    
#     )

# data_path = Path(Path.cwd(), 'data')
# for stack_path in sorted(data_path.iterdir()):  
        
# test = resize(data[0], (133, 1024, 1024), preserve_range=True).astype('uint16')

#%% Display

import napari

viewer = napari.Viewer()
viewer.add_image(stack)  