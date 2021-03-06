# nimgame2/textgraphic.nim
# Copyright (c) 2016-2017 Vladar
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
# Vladar vladar4@gmail.com

import
  sdl2/sdl,
  font, texturegraphic, settings, types


type
  TextGraphic* = ref object of TextureGraphic
    fLines: seq[string]
    fAlign: TextAlign
    fColor: Color
    fFont: Font


#=============#
# TextGraphic #
#=============#

proc free*(text: TextGraphic) =
  TextureGraphic(text).free()
  text.fLines = @[]
  text.fAlign = left
  text.fColor = DefaultFontColor
  text.fFont = nil


proc init*(text: TextGraphic) =
  TextureGraphic(text).init()
  text.fLines = @[]
  text.fAlign = left
  text.fColor = DefaultFontColor
  text.fFont = nil


proc newTextGraphic*(): TextGraphic =
  new result, free
  result.init()


proc newTextGraphic*(font: Font): TextGraphic =
  result = newTextGraphic()
  result.fFont = font


proc update*(text: TextGraphic) =
  if text.fFont == nil:
    return
  let num = text.fLines.len
  if num < 1:
    discard text.assignTexture(text.fFont.renderLine(""))
  elif num < 2:
    discard text.assignTexture(text.fFont.renderLine(text.fLines[0]))
  else:
    discard text.assignTexture(
      text.fFont.renderText(text.fLines, text.fAlign, text.fColor))


proc align*(text: TextGraphic): TextAlign {.inline.} =
  text.fAlign


proc `align=`*(text: TextGraphic, val: TextAlign) {.inline.} =
  text.fAlign = val
  text.update()


proc color*(text: TextGraphic): Color {.inline.} =
  text.fColor


proc `color=`*(text: TextGraphic, val: Color) {.inline.} =
  text.fColor = val
  text.update()


proc font*(text: TextGraphic): Font {.inline.} =
  text.fFont


proc `font=`*(text: TextGraphic, val: Font) {.inline.} =
  text.fFont = val
  text.update()


proc lines*(text: TextGraphic): seq[string] {.inline.} =
  text.fLines


proc `lines=`*(text: TextGraphic, lines: openarray[string]) =
  if text.fFont == nil:
    return
  text.fLines = @lines
  text.freeTexture()
  text.update()

