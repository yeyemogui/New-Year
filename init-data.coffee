_fs = require 'fs'
_fse = require 'fs-extra'
_path = require 'path'
_Coal = require('./connection').getConnection()
_config = require './config'
_Employee = _Coal.Model('employee')

_dest = _config.dest
_dest1 = _config.dest1
_img_source = _config.img_source
_img_source1 = _config.img_source1

doInit = ->
  _fs.readdir(_img_source, (err, files)->
    queue = []
    for file, index in files
      prefix = file.split(".")[0]
      index11 = prefix.lastIndexOf("_")
      name = prefix.substring(0, index11)
      num = prefix.substring(index11 + 1)
      #name = prefix.split("_")[0]
     
      #num = prefix.split("_")[1]
      if not num
        continue 
      num = num.replace(/\s/g, "")
      if not name or not num
        console.log "error!", file
        continue
      if index > 1 and (index % 30) is 1
        console.log "本次插入#{queue.length}"
        _Employee.table().insert(queue).then(-> console.log(arguments, "成功！")).catch((e)-> console.log(e))
        queue = []

      destFile =  _path.join(_dest, "#{num}.jpg")

      _fse.copySync(_path.join(_img_source, file), destFile)

      queue.push({
        name: name
        num: num
        lucky: 0
        image: "#{num}.jpg"
      })

    console.log "本次插入#{queue.length}"
    _Employee.table().insert(queue)
    .then(->
        console.log "所有数据插入成功！"
        _Employee.sql("SELECT count(*) from employee").then((data)-> console.log(data))
    ).catch((e)-> console.log(e))
  )
doInit1 = ->
  _fs.readdir(_img_source1, (err, files)->
    for file, index in files
      destFile = _path.join(_dest1, file)
      _fse.copySync(_path.join(_img_source1, file), destFile)
  )
#取消下面三行才会进行数据初始化，数据初始化后 记得把注释加上，避免每次数据都还原。
setTimeout(->
  doInit()
  #doInit1()
, 3000)
