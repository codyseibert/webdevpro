
module.exports = (req, res, next) ->
  if req.headers.password is (process.env.ADMIN_PASSWORD or 'testing')
    next()
  else
    res.status 403
    res.send 'unauthorized'
