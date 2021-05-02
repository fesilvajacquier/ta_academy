################################################################################

current_date_string = Time.now.strftime("%Y/%m/%d")

# Variable names should be easy to interpret & honest

################################################################################

class Client < ApplicationRecord
  MAJOR_CLIENT_TRANSACTION_THRESHOLD = 1000

  has_many :transactions

  def major_client?
    transactions.count > MAJOR_CLIENT_TRANSACTION_THRESHOLD
  end
end

# Methods should be read as "stories"
# Rely on methods & constants, not hard coded data
# This would allow us to use `Client::MAJOR_CLIENT_TRANSACTION_THRESHOLD` in a
#   view

################################################################################

class PriceCalculator
  attr_reader :today, :quantity
  def initialize(quantity)
    @today = Date.now
    @quantity = quantity
  end

  def price
    if high_season?
      quantity * high_season_rate + high_season_additional_fee
    else
      quantity * low_season_rate
    end
  end

  def high_season_rate
    12
  end

  def low_season_rate
    10
  end

  def high_season_additional_fee
    3
  end

  private

  def high_season?
    (HIGH_SEASON_START..HIGH_SEASON_END).cover? today
  end
end

# Methods should be read as "stories"
# Extract multi conditions to methods
# Rely on methods & constants, not hard coded data

################################################################################

# given singer could be nil or an array of names (ie: ["John", "Robert", "Mick"])

singers = given_singers || []

# If unavoidable, conditionals should be consice and explicit

################################################################################

class PriceCalculator
  # ...

  def discount
    eligible_for_discount?

    # calculate discount logic
  end

  private

  def eligible_for_discount?
    user_elegible_for_discount? &&
      order_elegible_for_discount? &&
      payment_method_elegible_for_discount?
  end

  def user_elegible_for_discount?
    user.senior?
  end

  def order_elegible_for_discount?
    order.items.count > 5
  end

  def payment_method_elegible_for_discount?
    payment_method != "gift_card"
  end
end

# Conditionals should be grouped when possible
# Methods should only have one reason to change

################################################################################

class ExamResult
  def initialize(exam, student, score)
    @exam = exam
    @student = student
    @score = score
  end

  def approved?
    @score >= exam.passing_score
  end
end

class Exam
  # ...

  def passing_score
    case type
    when "partial"
      4
    when "final"
      7
    end
  end
end

# Always ask yourself who should know what

################################################################################

car = {
  make: 'Honda',
  model: 'Accord',
  color: 'Blue'
}

# Avoid redundancy

################################################################################

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params)
    task.save
    redirect_to tasks_path
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    redirect_to task_path(@task)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end
end

# DRY

################################################################################

class Order < ApplicationRecord
  enum status: { pending: 0, in_transit: 1, delivered: 2 }
end

# Be familiar with built in solutions

################################################################################

def email_users(users)
  users.each do |user|
    send_email(user)
  end
end

# Methods should do one thing only
# Inject dependencies

################################################################################

class Citizen
  # ...
  def can_vote?
    adult? || teenager_registered_voter?
  end

  private

  def adult?
    age >= 18
  end

  def teenager_registered_voter?
    (16...18).cover?(age) && registered_voter?
  end
end

# Extract conditions
# Encapsulate & abstract logic

################################################################################
