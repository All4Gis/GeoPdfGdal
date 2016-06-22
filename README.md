# Example about how to create a GeoPdf with Gdal.

* Tested with GDAL 1.11.4, released 2016/01/25

## Install Gdal

### Windows

Go to http://download.gisinternals.com/release.php download and install Gdal. 

### Check the Gdal installation:

gdalinfo --version


## Examples

If you don't want to replace the path, you need to unzip the project into C:/geopdf/ 
and check that your folder tree is:
C:/geopdf/tmp/
C:/geopdf/data/
C:/geopdf/scripts/
etc..

or change path in "variables.bat" script.


You have all the script example here [Scripts](https://github.com/All4Gis/GeoPdfGdal/tree/master/scripts) and GeoPdf created [GeoPdf](https://drive.google.com/open?id=0B9VDXRxK5etKb1RaejZXcUFzZ2s)

For use this examples you need [Download data](https://drive.google.com/open?id=0B9VDXRxK5etKQTAwMjc3bUxnVzg) and unzip it in data folder:
C:/geopdf/data/raster/...
C:/geopdf/data/shp/...

******************************************
### Example 1: Two Shapefiles 
******************************************

```  
ogrtindex -accept_different_schemas C:/geopdf/tmp/extent.shp C:/geopdf/data/shp/osm.vrt

gdal_rasterize -burn 255 -ot Byte -tr 0.0001 0.0001 C:/geopdf/tmp/extent.shp C:/geopdf/tmp/base.tif

gdal_translate -of PDF -a_srs EPSG:4326 C:/geopdf/tmp/base.tif C:/geopdf/pdf/example1.pdf -co OGR_DATASOURCE=C:/geopdf/data/osm.vrt -co OGR_DISPLAY_FIELD="name"
```

********************************************************
### Example 2:One shapefile  
********************************************************
```
ogrtindex -accept_different_schemas C:/geopdf/tmp/extent.shp C:/geopdf/data/shp/madrid_spain_osm_polygon.shp

gdal_rasterize -burn 255 -ot Byte -tr 0.0001 0.0001 C:/geopdf/tmp/extent.shp C:/geopdf/tmp/base.tif

gdal_translate -of PDF -a_srs EPSG:4326 C:/geopdf/tmp/base.tif C:/geopdf/pdf/example2.pdf -co OGR_DATASOURCE=C:/geopdf/data/shp/madrid_spain_osm_polygon.shp -co OGR_DISPLAY_FIELD="name"
```

******************************************
### Example 3: One raster  
******************************************

``` 
gdaltindex C:/geopdf/tmp/extent.shp C:/geopdf/data/raster/madrid.tif
 
gdal_rasterize -burn 255 -burn 255 -burn 255 -ts 800 800 -ot BYTE C:/geopdf/tmp/extent.shp C:/geopdf/tmp/base.tif

gdal_translate -of PDF C:/geopdf/tmp/base.tif C:/geopdf/pdf/example3.pdf -co EXTRA_RASTERS=C:/geopdf/data/raster/madrid.tif -co EXTRA_RASTERS_LAYER_NAME="madrid"
``` 

******************************************
### Example 4: Two Rasters  
******************************************
 
```
gdaltindex C:/geopdf/tmp/extent.shp C:/geopdf/data/raster/madrid.tif
 
gdal_rasterize -burn 255 -burn 255 -burn 255 -ts 800 800 -ot BYTE C:/geopdf/tmp/extent.shp C:/geopdf/tmp/base.tif

gdal_translate -of PDF C:/geopdf/tmp/base.tif C:/geopdf/pdf/example4.pdf -co EXTRA_RASTERS=C:/geopdf/data/raster/madrid.tif,C:/geopdf/data/raster/overlay.tif -co EXTRA_RASTERS_LAYER_NAME="base","overlay"
```

********************************************************
### Example 5: Raster with shapefile  
********************************************************

```
ogrtindex -accept_different_schemas C:/geopdf/tmp/extent.shp C:/geopdf/data/shp/madrid_spain_osm_polygon.shp

gdal_rasterize -burn 255 -ot Byte -tr 0.0001 0.0001 C:/geopdf/tmp/extent.shp C:/geopdf/tmp/base.tif

gdal_translate -of PDF -a_srs EPSG:4326 C:/geopdf/tmp/base.tif C:/geopdf/pdf/example5.pdf -co EXTRA_RASTERS=C:/geopdf/data/raster/madrid.tif -co EXTRA_RASTERS_LAYER_NAME="madrid" -co OGR_DATASOURCE=C:/geopdf/data/shp/madrid_spain_osm_polygon.shp -co OGR_DISPLAY_FIELD="name" 
```
 
********************************************************
### Extra  
********************************************************

```
ogrtindex -accept_different_schemas C:/geopdf/tmp/extent.shp C:/geopdf/data/shp/madrid_spain_osm_polygon.shp

gdal_rasterize -burn 255 -ot Byte -tr 0.0001 0.0001 C:/geopdf/tmp/extent.shp C:/geopdf/tmp/base.tif

gdal_translate -of PDF -a_srs EPSG:4326 C:/geopdf/tmp/base.tif C:/geopdf/pdf/extra.pdf -co EXTRA_IMAGES="C:\geopdf\images\logo.jpg,0,0,.2" -co EXTRA_LAYER_NAME="LOGO" -co OGR_DATASOURCE=C:/geopdf/data/shp/madrid_spain_osm_polygon.shp -co OGR_DISPLAY_FIELD="name" -co WRITE_INFO=YES -co AUTHOR="Fran Raga" -co PRODUCER="All4Gis" -co SUBJECT="Example" -co TITLE="Example GeoPdf" -co KEYWORDS="gdal,geopdf,all4gis"

```

********************************************************
### Example in Qgis Python Console  
********************************************************

```
import os
os.system(r'ogrtindex -accept_different_schemas C:\geopdf\tmp\extent.shp C:\geopdf\data\shp\osm.vrt')
os.system(r'gdal_rasterize -burn 255 -ot Byte -tr 0.0001 0.0001 C:\geopdf\tmp\extent.shp C:\geopdf\tmp\base.tif')
os.system(r'gdal_translate -of PDF -a_srs EPSG:4326 C:\geopdf\tmp\base.tif C:\geopdf\pdf\example1.pdf -co OGR_DATASOURCE=C:\geopdf\data\shp\osm.vrt -co OGR_DISPLAY_FIELD="name"')
```

### References:

* Original code for inspiration:
http://www.spatialthoughts.com/blog/gis/geopdf-gdal/

* More info:
http://gdal.org/1.11/frmt_pdf.html


[© All4gis 2016]

