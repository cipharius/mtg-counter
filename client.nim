import dom, jsconsole
from strutils import parseInt

type Counter = ref object
  value: int
  elOutput: Element
  elIncrement: Element
  elDecrement: Element

template `[]`(el: Element, class: cstring): Element =
  el.getElementsByClassName(class)[0]

proc setValue(self: Counter, value: int) =
  self.value = value
  self.elOutput.innerHTML = $value

template increment(self: Counter, amount = 1) =
  self.setValue(self.value + amount)

template decrement(self: Counter, amount = 1) =
  self.setValue(self.value - amount)

proc newCounter(elCounter: Element): Counter =
  result = new(Counter)
  result.elOutput = elCounter["value"]
  result.elIncrement = elCounter["increment"]
  result.elDecrement = elCounter["decrement"]
  result.value = result.elOutput.innerHTML.parseInt()

  result.elIncrement.addEventListener("click") do (e: Event):
    result.increment()

  result.elDecrement.addEventListener("click") do (e: Event):
    result.decrement()

proc getCounters(document: Document): seq[Counter] =
  let elCounters = document.querySelectorAll(".counter")
  result = @[]

  for elCounter in elCounters:
    result.add newCounter(elCounter)

proc main() =
  var counters = document.getCounters()

when isMainModule:
  main()

