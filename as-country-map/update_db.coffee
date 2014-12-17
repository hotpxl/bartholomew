path = require 'path'
fs = require 'fs'
mongoose = require 'mongoose'
_ = require 'lodash'
split = require 'split'
secret = require './secret.json'

db = mongoose.connect secret.url

Schema = mongoose.Schema

InfoSchema = new Schema(
  id: Number
  countryCode: String
  registry: String
)

Info = mongoose.model 'Info', InfoSchema

rirList = ['afrinic', 'apnic', 'arin', 'lacnic', 'ripencc']

processList = (list, fun, end) ->
  doProcessList = (index) ->
    if index < list.length
      fun list[index], ->
        doProcessList (index + 1)
    else
      end()
  doProcessList 0

readRirDataIntoDatabase = (rir, callback) ->
  fs.createReadStream \
    path.join(__dirname, "./data/delegated-#{rir}-extended-latest"),
    encoding: 'utf-8'
  .pipe split()
  .on 'data',
    (data) ->
      if data[0] != '#'  # Skip comments
        [registry, countryCode, type, start, value, date, status] = data.trim().split '|'
        if type == 'asn' && status == 'allocated'  # Skip header and non AS entries
          start = parseInt start
          value = parseInt value
          if countryCode?.length != 2 ||
          registry != rir ||
          start < 0 ||
          value < 1
            throw new Error('Cannot parse record file')
          for id in [start..start + value]
            info = new Info()
            info.id = id
            info.countryCode = countryCode
            info.registry = registry
            info.save()
  .on 'end',
    ->
      callback()

processList rirList, readRirDataIntoDatabase, ->
  db.disconnect()
