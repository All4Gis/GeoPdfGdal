@ECHO OFF
call "variables.bat"


echo #################################
ECHO Example 1: Two Shapefiles
echo #################################

@ECHO ON
: execute
echo STEP 1 ogrtindex.
ogrtindex -accept_different_schemas %BASE%\tmp\extent.shp %BASE%\data\shp\osm.vrt
IF ERRORLEVEL 1 GOTO ERROR

echo STEP 2 gdal_rasterize.
gdal_rasterize -burn 255 -ot Byte -tr 0.0001 0.0001 %BASE%\tmp\extent.shp %BASE%\tmp\base.tif

echo Creating GeoPdf
gdal_translate -of PDF -a_srs EPSG:4326 %BASE%\tmp\base.tif %BASE%\pdf\example1.pdf -co OGR_DATASOURCE=%BASE%\data\shp\osm.vrt -co OGR_DISPLAY_FIELD="name"

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