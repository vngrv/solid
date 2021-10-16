# =============================================
# Interface Segregation Principle
# 
# Clients should not be forced to depend upon
# interfaces that thay do not use
#
# Robert C.Martion
# =============================================

class Car
  def open_door; end

  def start_engine; end

  def repair_engine; end
end

class Driver
  def drive_car(car)
    car.open_door
    car.start_engine
  end
end

class Machanic
  def repair_car(car)
    car.repair_enginge
  end
end

# === WARNING =================================
#
# Добаавление метода repair_engine логически
# не нужно классу Driver. Оно нужно только 
# классу Mechanic чтобы вызвать метод 
# repair_engine.
#
# Иными словами, клиенты класса не должны 
# зависить от методов, которые они не используют,
# те нужно избавляться от избыточной неиспользуемой
# логики в классе, направленного на конкретного
# клиента
# =============================================
#
# === SOLUTION ================================
#
# Необходимо избавляться от методов, которые 
# не используются конечным пользователем 
# класса
#
# =============================================

class Car 
  def open_door; end

  def start_engine; end
end

class CarSettings
  def repair_engine; end
end

class Driver
  def drive_car(car)
    car.open_door
    car.drive_car
  end
end

class Mechanic
  def repair_car(car)
    car.repair_engine
  end
end
