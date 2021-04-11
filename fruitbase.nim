import math

# Dollars and Kgs
type
  Dollar* = distinct float
  Kg* = distinct float

proc `$`*(x: Dollar) :string =
  $x.float

proc `==`*(x, y: Dollar) :bool {.borrow.}


# Fruit class, procs are generic
type
  Fruit* = ref object of RootObj
    origin*: string
    price*: Dollar

proc `$`*(self: Fruit): string =
  self.origin & " " & $self.price


# Default reduction is 0
proc reduction*[T](self: T) :Dollar =
  Dollar(0)

# This one factored out from calcPrice
# so that subclasses can "super" call it.
proc basePrice[T](self: T): Dollar =
  Dollar(round(self.price.float * 100)/100 - self.reduction().float)

# Default implementation, if you don't override.
proc calcPrice*[T](self: T) :Dollar =
  self.basePrice()


# Banana class, relies on inherited calcPrice()
type
  Banana* = ref object of Fruit
    size*: int

proc reduction*(self: Banana): Dollar =
  Dollar(9)


# Pumpkin, overrides calcPrice() and calls basePrice()
type
  Pumpkin* = ref object of Fruit
    weight*: Kg

proc reduction*(self: Pumpkin): Dollar =
  Dollar(1)

# Override to multiply super implementation by weight.
# Calling basePrice works because it will not lose type of self so
# when it calls self.reduction() it will resolve properly.
proc calcPrice*(self: Pumpkin) :Dollar =
  Dollar(self.basePrice().float * self.weight.float)


# BigPumpkin, overrides calcPrice() without super call
# No reduction.
type
  BigPumpkin* = ref object of Pumpkin

proc calcPrice*(self: BigPumpkin) :Dollar =
  Dollar(1000)


# Construction procs
proc newPumpkin*(weight, origin, price): Pumpkin = Pumpkin(weight: weight, origin: origin, price: price)
proc newBanana*(size, origin, price): Banana = Banana(size: size, origin: origin, price: price)
proc newBigPumpkin*(weight, origin, price): BigPumpkin = BigPumpkin(weight: weight, origin: origin, price: price)