# Description:
#   google stuff
#
# Dependencies:
#   None
#
# Commands:
#   hubot google stuff
#
# Author:
#   PaulSmecker

module.exports = (robot) ->
    robot.respond /google (.*)/i, (msg) ->
            msg.send "http://lmgtfy.com/?q=" + msg.match[1].replace(/\s+/g, "+")
