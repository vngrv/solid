# =============================================
# Open Closed Principle (Принцип открытости/закрытости)
# 
# Software entities (classes, modules, functions, etc.) 
# should be open for extension, but closed for modification.
#
# Bertrand Meyer
# =============================================

class LogSender
    def initialize(data, user)
      @data = data
      @user = user
      @message = ''
    end
  
    def generate_log!
        @message = @data.map { |row| "[#{Time.now}] User: #{row.user} action #{row.action}"}.join("\n")
    end
  
    def send_log (way = :mail)
        case way
        when :mail
            Mailer.deliver(to: @user.email, message: @message) 
        when :telegram
            VK.send(to: @user.id_vk, message: @message)
        else
            raise Error
        end
    end
end

class LogGenerator
    def initialize data
      @data = data
    end
  
    def generate
      @data.map { |row| "[#{Time.now}] User: #{row.user} action #{row.action}"}.join("\n")
    end
end

# Что делает класс? 
# Класс создает отчет и отправляет его, 
# в зависимости от переданного параметра.
#
# === USAGE ===================================
# 
# log = LogGenerator.new(data).generate
# LogSender.new(log, user).send_log(:mail)
#
# ============================================= 
#
# === WARNING =================================
# 
# Класс модернизирован для отправки сообщения
# в разные источники. Это противоречит принципу 
# OCP.
# Класс НЕ должен изменяться для решения задачи,
# он должен только расширяться.
# 
# =============================================
#
# === SOLUTION ================================
#
# Класс должен быть закрыт для модернизации.
# Кдасс должен только расширяться через 
# наследование
#
# =============================================

class LogSender
    def initialize(log, user)
        @log = log
        @user = user
    end

    def send_log(sender = MailSender.new)
        sender.send(@user, @log)
    end
end

class LogGenerator
    def initialize data
      @data = data
    end
  
    def generate
      @data.map { |row| "[#{Time.now}] User: #{row.user} action #{row.action}"}.join("\n")
    end
end

# === SOLUTION ================================

class Sender
    def send(user, message); end
end

class MailSender < Sender
    def send(user, message)
        Mailer.deliver(to: user.email, message: message) 
    end
end

class VKSender < Sender
    def send(user, message)
        VK.send(to: user.id_vk, message: message)
    end
end

# =============================================

log = LogGenerator.new(data).generate

LogSender.new(log, user).send_log(VKSender.new)
LogSender.new(log, user).send_log(MailSender.new)




