@ECHO OFF
call "variables.bat"



echo #################################
ECHO Example 3: One raster
echo #################################
@ECHO ON

: execute
echo STEP 1 gdaltindex.
gdaltindex %BASE%\tmp\extent.shp %BASE%\data\raster\madrid.tif
IF ERRORLEVEL 1 GOTO ERROR

echo STEP 2 gdal_rasterize.
gdal_rasterize -burn 255 -burn 255 -burn 255 -ts 800 800 -ot BYTE %BASE%\tmp\extent.shp %BASE%\tmp\base.tif

echo Creating GeoPdf
gdal_translate -of PDF %BASE%\tmp\base.tif %BASE%\pdf\example3.pdf -co EXTRA_RASTERS=%BASE%\data\raster\madrid.tif -co EXTRA_RASTERS_LAYER_NAME="Madrid"
 
echo Clean tmp folder
del %BASE%\tmp\*.* /s /q

ECHO All done!
@ECHO OFF
GOTO END
 
:ERROR
   echo "Error creating GeoPdf"
   set ERRORLEVEL=%ERRORLEVEL%
   PAUSE
   
:END
@ECHO ON



