class App
  constructor: ->
    @grid   = $('ul.map li')
    @x      = 0
    @y      = 0
    @pos    = 0
    @color  = 1
    @colors = $('ul.colors li')

    @grid.mouseenter(=> @handleMouseEnter(event))
    @grid.mousedown(=> @handleGridClick(event))

    @colors.click(=> @handleColorClick(event))

    $('body').keydown(=> @handleKeypress(event))

  handleKeypress: (event) ->
    switch event.keyCode
      when 37 then @handleKeyLeft()
      when 38 then @handleKeyUp()
      when 39 then @handleKeyRight()
      when 40 then @handleKeyDown()
      when 32 then @handleKeySpace()
      when 48 then @setColor(0)
      when 49 then @setColor(1)
      when 50 then @setColor(2)
      when 51 then @setColor(3)
      when 52 then @setColor(4)
      when 53 then @setColor(5)
      when 54 then @setColor(6)
      when 55 then @setColor(7)
      when 56 then @setColor(8)
      when 57 then @setColor(9)

  handleMouseEnter: (event) ->
    @setPos(@grid.index(event.currentTarget))

  handleKeySpace: ->
    @placePixel()

  handleKeyLeft: ->
    @setPos(@pos - 1)

  handleKeyUp: ->
    @setPos(@pos - 20)

  handleKeyRight: ->
    @setPos(@pos + 1)

  handleKeyDown: ->
    @setPos(@pos + 20)

  handleColorClick: (event) ->
    @setColor(@colors.index(event.currentTarget))

  handleGridClick: (event) ->
    @placePixel()

  placePixel: ->
    @grid[@pos].className = "hover color-#{@color}"
    $.get('/place-pixel', pos: @pos, color: @color)

  setPos: (pos) ->
    $(@grid[@pos]).removeClass('hover')
    pos = 0 if pos < 0
    pos = 299 if pos > 299
    @pos = pos
    $(@grid[@pos]).addClass('hover')
    $(@grid[@pos]).text(@color)

  setColor: (color) ->
    $(@colors[@color]).removeClass('hover')

    @color = color

    $(@grid[@pos]).text(@color)
    $(@colors[@color]).addClass('hover')

  handleInterval: ->

$ ->
  new App()
