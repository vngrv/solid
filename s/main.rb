# =============================================
# A class should have only one reason to change
#
# Robert C. Martin
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

  def send_log
    Mailer.deliver(to: @user.email, message: @message) 
  end
end

# Что делает класс? 
# Класс создает отчет и отправляет его.
#
# === USAGE ===================================
# 
# log_sender = LogSender.new(data, account)
# log_sender.genetate_log!
# log_sender.send_log
#
# ============================================= 
#
# === WARNING =================================
# 
# Класс решает две задачи: создает и отправляет
# Это противоречит принципу SRP. (Single 
# Responsibility Principle)
# Класс должен отвечать только за одну задачу, 
# иначе это похоже на божественный класс, 
# который делает все - это плохо.
#
# =============================================
#
# === SOLUTION ================================
#
# Сложный класс должен быть разбит на несколько
# простых составляющих, отвечающих за 
# определенный аспект поведения. Это упрощает 
# расширение системы, редактирование классов.
#
# =============================================

class LogGenerator
  def initialize data
    @data = data
  end

  def generate
    @data.map { |row| "[#{Time.now}] User: #{row.user} action #{row.action}"}.join("\n")
  end
end

class LogSender
  def initialize(data, user)
    @data = data
    @user = user
  end

  def send
    Mailer.deliver(to: @user.email, message: @message)
  end
end

# === USAGE ===================================
#
# log = LogGenerator.new(data)
# logSender = LogSender.new(log, user)
# logSender.send
#
# --- or ---
#
# log = LogGenerator.new(data)
# LogSender.new(log, user)
#
# --- or ---
#
# LogSender.new(LogGenerator.new(data), user)
#
# =============================================


