# Description:
#   Get a meme from http://memecaptain.com/
#
# Dependencies:
#   None
#
# Commands:
#   hubot Y U NO <text> - Generates the Y U NO GUY with the bottom caption of <text>
#   hubot I don't always <something> but when i do <text> - Generates The Most Interesting man in the World
#   hubot <text> (SUCCESS|NAILED IT) - Generates success kid with the top caption of <text>
#   hubot <text> ALL the <things> - Generates ALL THE THINGS
#   hubot <text> TOO DAMN <high> - Generates THE RENT IS TOO DAMN HIGH guy
#   hubot Yo dawg <text> so <text> - Generates Yo Dawg
#   hubot All your <text> are belong to <text> - All your <text> are belong to <text>
#   hubot If <text>, <word that can start a question> <text>? - Generates Philosoraptor
#   hubot <text>, BITCH PLEASE <text> - Generates Yao Ming
#   hubot <text>, COURAGE <text> - Generates Courage Wolf
#   hubot ONE DOES NOT SIMPLY <text> - Generates Boromir
#   hubot IF YOU <text> GONNA HAVE A BAD TIME - Ski Instructor
#   hubot IF YOU <text> TROLLFACE <text> - Troll Face
#   hubot Aliens guy <text> - Aliens guy weighs in on something
#   hubot Brace yourself <text> - Ned Stark braces for <text>
#   hubot Iron Price <text> - To get <text>? Pay the iron price!
#   hubot Not sure if <something> or <something else> - Generates a Futurama Fry meme
#   hubot <text>, AND IT'S GONE - Bank Teller
#   hubot WHAT IF I TOLD YOU <text> - Morpheus What if I told you
#
# Author:
#   bobanj

module.exports = (robot) ->
    robot.respong /meme list/i, (msg) ->
        imgFlip msg

imgFlip = (msg) ->
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
            for meme in result?data?memes
                msg.reply "#{meme?name}"
        else
            msg.reply "Sorry, I can't understand their answer!" 

    msg.http("https://api.imgflip.com/get_memes").get() listMemes
