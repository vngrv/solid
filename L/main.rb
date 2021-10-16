# =============================================
# Liskov Substitution Principle
#
# Subtype Requirement:
# Let F(x) be a property provable about objects
# x of type T. Than F(y) should be true for 
# objects y of type S where S is a subtype of T
#
# Barbara Liskov and Jeannette Wing
# =============================================

class Animal
    def create_sound
        ''
    end
end

class Dog < Animal
    def create_sound
        'bark'
    end
end

class Cat < Animal
    def create_sound
        'meow'
    end
end

def animal_sound(animal)
    "#{animal.class.name} #{animal.create_sound}"
end


# Обычный пример наследования и переопределния 
# метода в дочернем классе. Реализация
# подразумевает сохранение интерфейса, а именно
# возвращение строчки. 
#
# === USAGE ===================================
#
# animal_sound(Dog.new)
# animal_sound(Cat.new)
#
# ============================================= 
# 
# === WARNING =================================
# 
# В коде написанном выше, все хорошо. Важно 
# понять, когда идет нарушение этого принципа
# 
# =============================================

# Положим, что в дочернем классе мы хотим 
# изменить реализацию интерфейса, к примеру

class Dog < Animal    
  def create_sound
        ['sound1', 'sound2']
    end
end

# Так как функция animal_sound ожидает строку, 
# а ему приходит массив данных. Это нарушает 
# принцип подстановки Лискова. 
# 
# Принцип значит:
#   Поведение наследующих классов должно быть
#   ожидаемым для системы, а это значит 
#   сохранение интерфейсов.
