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
            msg.send "https://www.lmgtfy.com/?q=" + msg.match[1].replace(/\s+/g, "+")
