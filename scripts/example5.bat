@ECHO OFF
call "variables.bat"

echo #################################
ECHO Example 3: One raster
echo #################################

@ECHO ON

: execute
echo STEP 1 ogrtindex.
ogrtindex -accept_different_schemas %BASE%\tmp\extent.shp %BASE%\data\shp\madrid_spain_osm_polygon.shp
IF ERRORLEVEL 1 GOTO ERROR
 
echo STEP 2 gdal_rasterize.
gdal_rasterize -burn 255 -ot Byte -tr 0.0001 0.0001 %BASE%\tmp\extent.shp %BASE%\tmp\base.tif

echo Creating GeoPdf
gdal_translate -of PDF -a_srs EPSG:4326 %BASE%\tmp\base.tif %BASE%\pdf\example5.pdf -co EXTRA_RASTERS=%BASE%\data\raster\madrid.tif -co EXTRA_RASTERS_LAYER_NAME="madrid" -co OGR_DATASOURCE=%BASE%\data\shp\madrid_spain_osm_polygon.shp -co OGR_DISPLAY_FIELD="name" 
 
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


 





 





 
