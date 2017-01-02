_ = require 'lodash'
_product = require './product-config'
_path = require 'path'

config =
  port: 3000,
  dest: _path.join(process.cwd(), 'static/avatar')
  dest1: _path.join(process.cwd(), 'static/original')
  develop: false
  img_source: '/Users/wumingqin/Desktop/pic1'
  img_source1:'/Users/wumingqin/Desktop/pic1'
  log: _path.join(process.cwd(), "luckyList.log")


config = _.extend(config, _product)
module.exports = config
