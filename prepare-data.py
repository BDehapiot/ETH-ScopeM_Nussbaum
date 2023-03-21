#%% Imports

import time
import numpy as np
from skimage import io 
from pathlib import Path
from skimage.transform import resize
from bdtools.dtype import ranged_conversion
from skimage.exposure import match_histograms

#%% Parameters

rSize = 0
maxProj = 1

#%% rSize

data_path = Path(Path.cwd(), 'data', 'local')  

if rSize == 1:
    
    for stack_path in sorted(data_path.iterdir()):  
        
        if 'tif' in stack_path.name and 'rSize' not in stack_path.name:
            
            # Open stack
            stack = io.imread(stack_path)
            
            # Resize stack
            stack = resize(
                stack, (stack.shape[0], 1024, 1024),
                preserve_range=True,
                )
            
            # Save resized stack
            io.imsave(
                Path(str(stack_path).replace('.tif', '_rSize.tif')),
                stack.astype('uint16'),
                check_contrast=False,    
                )
  
#%% maxProj
            
data_path = Path(Path.cwd(), 'data', 'local')  

if maxProj == 1:
    
    data = []

    for stack_path in sorted(data_path.iterdir()):  
        
        if 'rSize' in stack_path.name and 'maxProj' not in stack_path.name:
            
            # Open stack
            stack = io.imread(stack_path) 
            
            # Get stack shape
            shape = stack.shape
            
            # Append data
            
            # # Max. projection
            # stack = np.max(stack, axis=0)
            
            # # Save projected stack
            # io.imsave(
            #     Path(str(stack_path).replace('.tif', '_maxProj.tif')),
            #     stack.astype('uint16'),
            #     check_contrast=False,    
            #     )
       
#%% histMatch
      
# data_path = Path(Path.cwd(), 'data')  
      
# if histMatch == 1:
    
#     data = []
    
#     for stack_path in sorted(data_path.iterdir()):  
        
#         if 'maxProj' in stack_path.name and 'histMatch' not in stack_path.name:
            
#             # Open stack
#             stack = io.imread(stack_path) 
            

#%% Display

# import napari

# viewer = napari.Viewer()
# viewer.add_image(stack)  