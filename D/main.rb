# =============================================
# Dependency Inversion Principle (Принцип иневерсии зависимостей)
#
# 1) Hаиболее гибкими получаются системы, в которых зависимости в исходном коде направлены на абстракции, а не на конкретные реализации  Из книги "Чистая архитектура"
# 
# 2) Модули верхних уровней не должны зависеть от модулей нижних уровней. Оба типа модулей должны зависеть от абстракций.
#
# 3) Абстракции не должны зависеть от деталей. Детали должны зависеть от абстракций.
# 
# =============================================

class LogSender
  def initialize data, user
    @data = data
    @user = user
  end
  
  def send_mail 
    MailSender.new.send(@data, @user)
  end

  def send_vk
    VKSender.new.send(@data, @user)
  end
end 

class Sender
  def send data, user; end
end

class MailSender < Sender
  def send data, user; end
end

class VKSender < Sender
  def send data, user; end
end

# === WARNING =================================
#
# LogSender завuсит от двух классов реализующих логику отправки сообщения
# MailSender и VKSender, те логика построенна относительно деталей реализации, 
# а не от асбтракции
#
# =============================================
#
# === SOLUTION ================================
# 
# =============================================

class LogSender
  def initialize data, user
    @data = data
    @user = user
  end
    
  def send_report (sender = MailSender.new)
    sender.send(@data, @user)
  end
end 

class Sender
  def send data, user; end
end

class MailSender < Sender
  def send data, user
    # implementation
  end
end

class VKSender < Sender
  def send data, user
    # implementation 
  end
end

# Что изменилось?
# Мы подрефачили код таким образом, чтобы 
# появилась зависимость от интерфейса другого
# модуля, а именно наличие метода send, а не
# от зависимости способа/механизма отправления
# отчета.

