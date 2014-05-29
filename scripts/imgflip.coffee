# Description:
#   Get a meme from http://memecaptain.com/
#
# Dependencies:
#   None
#
# Commands:
#   hubot meme list
#   hubot meme <id> #TOPTEXT# #BOTTOMTEXT#
#
# Author:
#   bobanj

password = process.env.HUBOT_IMGFLIP_PASSWORD
username = process.env.HUBOT_IMGFLIP_USERNAME

module.exports = (robot) ->
    robot.respond /meme (\d+) #(.+)# #(.+)#/i, (msg) ->
        imgFlipGen msg, msg.match[1], msg.match[2], msg.match[3], (url) ->
            msg.send url
    robot.respond /meme piclist/i, (msg) ->
        imgFlipList msg, (url, id, name) -> 
            msg.send "#{id} #{name} #{url}"
    robot.respond /meme list/i, (msg) ->
        imgFlipList msg, (url, id, name) -> 
            msg.send "#{id} #{name}"
        
        
imgFlipGen = (msg, id, top, bottom, callback) ->

    showMeme = (err, res, body ) ->
        console.log(body)
        return msg.send err if err
        if res.statusCode == 301
              msg.http(res.headers.location).get() showMeme
              return
        if res.statusCode > 300
              msg.reply "Sorry, I couldn't generate that meme. Unexpected status from memecaption.com: #{res.statusCode}"
              return
        try
              result = JSON.parse(body)
        catch error
              msg.reply "Sorry, I couldn't generate that meme. Unexpected response from memecaptain.com: #{body}"
        if result? and result.success
              callback result.data.url 
        else
              msg.reply "They say \"#{result.error_message}\" *rolleyes*"

    msg.http("https://api.imgflip.com/caption_image").query(
        template_id: id,
        text0: top,
        text1: bottom,
        username: username,
        password: password 
    ).get() showMeme

imgFlipList = (msg, callback) ->

    listMemes = (err, res, body) ->
        return msg.send err if err
        if res.statusCode ==301
            msg.http(res.headers.location).get() listMemes
            return
        try
            result = JSON.parse(body)
        catch error
            msg.reply "Sorry, I can't understand their answer!" 
        if result? 
            all_memes=""
            for meme in result.data.memes
                callback meme.url, meme.id, meme.name
        else
            msg.reply "Sorry, I can't understand their answer!" 

    msg.http("https://api.imgflip.com/get_memes").get() listMemes
