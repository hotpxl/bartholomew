express = require 'express'
router = express.Router()

router.get '/', (req, res, next) ->
  res.json {'a': 'b'}

module.exports = router
