#!/usr/bin/env python

from gimpfu import *
import json,os

def json_export(timg, tdrawable):
    jsonfile = file(os.path.join(
        os.path.split(timg.filename)[0],
        os.path.splitext(timg.filename)[0] + ".json"),"w")
    properties = {}
    properties['image'] = {
         'path':os.path.split(timg.filename)[0],
         'filename':timg.name,
         'name':os.path.splitext(timg.name)[0],
         'ext':os.path.splitext(timg.name)[1],
         'size':(timg.width,timg.height),
         'resolution':timg.resolution,
         "uri":timg.uri }
    layersProperties = []
    for layer in timg.layers:
        properties[layer.name] = {
            'id':layer.ID,
            'bpp':layer.bpp,
            'size':(layer.width,layer.height),
            'name':layer.name,
            'offsets':layer.offsets,
            'opacity':layer.opacity,
            'visible':layer.visible}
        layersProperties.append(properties[layer.name])
    properties['layer']=layersProperties
    json.dump(properties,jsonfile,indent=2)
    jsonfile.close()

register(
    "json_export",
    "Save a JSON file containing the properties of the active image and layers",
    "Save a JSON file containing the properties of the active image and layers",
    "winterstew",
    "winterstew",
    "2016",
    "<Image>/Filters/Languages/Python-Fu/Export Layer Properties...",
    "*",
    [],
    [],
    json_export)

main()
