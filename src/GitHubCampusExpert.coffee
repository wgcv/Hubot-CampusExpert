# Description:
#   Check the GitHub Campus Experts information
#
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot list of campus experts - Display all the GitHub Campus Experts
#   hubot about <search> - Display Campus Experts
#
# Author:
#   Gustavo Cevallos - WGCV


#   It would be great to connect to api the GitHub Campus Experts
campusExperts = require('./CampusExperts.json')

searchCE = (v) ->
  aboutCES = []
  v = v.toUpperCase()
  for i in campusExperts
    if i.name.toUpperCase().indexOf(v) > -1 or i.lastname.toUpperCase().indexOf(v) > -1 or i.username.toUpperCase().indexOf(v) > -1 or  i.university.toUpperCase().indexOf(v) >-1 or i.address.toUpperCase().indexOf(v) > -1
      aboutCES.push(i)
  if aboutCES.length > 0
    return aboutCES
  else
    return false

module.exports = (robot) ->
  robot.respond /about (.*)/i, (res) ->
    search = res.match[1]
    aboutCES = searchCE(search)
    replay = ''
    if aboutCES
     for i in aboutCES
        replay += '\nName: ' + i.name + ' ' + i.lastname
        replay += '\nUsername: ' + i.username
        replay += '\nUniversity: ' + i.university
        replay += '\nAddress: ' + i.address + ' (https://www.google.com/maps/?q=' + i.coordinates[1] + ',' + i.coordinates[0] + ')'
        replay += '\nMail: ' +  i.email
        replay += '\nAbout: ' +  i.description
        replay += '\n ---------- \n'
      res.reply replay
    else
      res.reply "Theres is not a Campus Expert with " + search


  robot.respond /list of campus experts/i, (res) ->
    list = ""
    for i in campusExperts
      list += '\nName: ' + i.name + ' ' + i.lastname
      list += '\nUsername: ' + i.username
      list += '\nUniversity: ' + i.university
      list += '\nAddress: ' + i.address + ' (https://www.google.com/maps/?q=' + i.coordinates[1] + ',' + i.coordinates[0] + ')'
      list += '\nMail: ' +  i.email
      list += '\nAbout: ' +  i.description
      list += '\n ---------- \n'

    res.reply "This is all the Campus Experts: #{list}"
