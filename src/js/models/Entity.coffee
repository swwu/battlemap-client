Backbone = require('backbone')
$ = require('jquery')

isAttribute = (stat) ->
  stat.split('_')[0] in ["str", "dex", "con", "int", "wis", "cha"]

isSkill = (stat) ->
  stat.indexOf("skill") == 0

statDescriptors = {
  str: {
    name: "Strength"
    short: "Str"
    desc: "Strength measures muscle and physical power. This ability is important for those who engage in hand-to-hand (or “melee”) combat, such as fighters, monks, paladins, and some rangers. Strength also sets the maximum amount of weight your character can carry. A character with a Strength score of 0 is too weak to move in any way and is unconscious. Some creatures do not possess a Strength score and have no modifier at all to Strength-based skills or checks."
  }
  dex: {
    name: "Dexterity"
    short: "Dex"
    desc: "Dexterity measures agility, reflexes, and balance. This ability is the most important one for rogues, but it's also useful for characters who wear light or medium armor or no armor at all. This ability is vital for characters seeking to excel with ranged weapons, such as the bow or sling. A character with a Dexterity score of 0 is incapable of moving and is effectively immobile (but not unconscious)."
  }
  con: {
    name: "Constitution"
    short: "Con"
    desc: "Constitution represents your character's health and stamina. A Constitution bonus increases a character's hit points, so the ability is important for all classes. Some creatures, such as undead and constructs, do not have a Constitution score. Their modifier is +0 for any Constitution-based checks. A character with a Constitution score of 0 is dead."
  }
  int: {
    name: "Intelligence"
    short: "Int"
    desc: "Intelligence determines how well your character learns and reasons. This ability is important for wizards because it affects their spellcasting ability in many ways. Creatures of animal-level instinct have Intelligence scores of 1 or 2. Any creature capable of understanding speech has a score of at least 3. A character with an Intelligence score of 0 is comatose. Some creatures do not possess an Intelligence score. Their modifier is +0 for any Intelligence-based skills or checks."
  }
  wis: {
    name: "Wisdom"
    short: "Wis"
    desc: "Wisdom describes a character's willpower, common sense, awareness, and intuition. Wisdom is the most important ability for clerics and druids, and it is also important for monks and rangers. If you want your character to have acute senses, put a high score in Wisdom. Every creature has a Wisdom score. A character with a Wisdom score of 0 is incapable of rational thought and is unconscious."
  }
  cha: {
    name: "Charisma"
    short: "Cha"
    desc: "Charisma measures a character's personality, personal magnetism, ability to lead, and appearance. It is the most important ability for paladins, sorcerers, and bards. It is also important for clerics, since it affects their ability to channel energy. For undead creatures, Charisma is a measure of their unnatural “lifeforce.” Every creature has a Charisma score. A character with a Charisma score of 0 is not able to exert himself in any way and is unconscious."
  }
}

server = "http://localhost:10010"

makeModels = (gamespace) =>
  EntityModel = Backbone.Model.extend({
    idAttribute: "id"

    urlRoot: ->
      "#{server}/gamespace/#{gamespace}/entity"

    getVar: (varName) ->
      return @get("vars")[varName]

    setVars: (setVars) ->
      vars = @get("vars")
      for k,v of setVars
        vars[k] = v
      @trigger('change') # fire the change obj since we didn't trigger

    getStatDesc: (statName) ->
      return statDescriptors[statName]
  })

  EntityCollection = Backbone.Collection.extend({
    model: EntityModel

    url: ->
      "#{server}/gamespace/#{gamespace}/entity"
  })

  return {EntityModel, EntityCollection}

module.exports = {
  withGamespace: (gamespace) =>
    makeModels(gamespace)
}
