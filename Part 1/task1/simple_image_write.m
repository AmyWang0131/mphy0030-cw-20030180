
function simple_image_write(vol,voxdims,filename); 


bfile = fopen(filename,'w'); % opens a binary file format in write mode, given the chosen filename

fwrite(bfile,voxdims,'float32'); % writes the voxel dimensions to the file as float32

fseek(bfile,0,'cof'); % sets the file to stay at the current position on the open file

fwrite(bfile,vol,'int16'); % writes the volume data at int16
fclose(bfile); % closes the binary file


