module.exports = (req, res, next) ->
  ua = req.header 'user-agent'
  req.site = if /mobile/i.test ua then 'mobile' else 'desktop'
  next()
