################################################################################

yyyymmdstr = Time.now.strftime("%Y/%m/%d")

################################################################################

class Client < ApplicationRecord
  has_many :transactions

  def major_client?
    transactions.count > 1000
  end
end

################################################################################

class PriceCalculator
  def initialize(quantity)
    @today = Date.now
    @quantity = quantity
  end

  def price
    if @today > HIGH_SEASON_START && @today < HIGH_SEASON_END
      @quantity * 12 + 3
    else
      @quantity * 10
    end
  end
end

################################################################################

# given singer could be nil or an array of names (ie: ["John", "Robert", "Mick"])

if given_singers
  singers = given_singers
else
  singers = []
end

################################################################################

class PriceCalculator
  def discount
    return 0 unless user.senior?
    return 0 unless user.student?
    return 0 unless user.disabled?

    # calculate discount logic
  end
end

################################################################################

class ExamResult
  def initialize(exam, student, score)
    @exam = exam
    @student = student
    @score = score
  end

  def approved?
    if exam.type == "partial"
      @score >= 4
    elsif exam.type == "final"
      @score >= 7
    end
  end
end

################################################################################

car = {
  car_make: 'Honda',
  car_model: 'Accord',
  car_color: 'Blue'
}

################################################################################

def refrain(lyrics, number_of_times = 1, vibrato = 0, strong = false)
  song_refrain = []
  lyrics += lyrics[lyrics.size - 1] * vibrato
  lyrics.upcase! if strong

  number_of_times.times do
    song_refrain << lyrics
  end

  song_refrain.join(" ")
end

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

################################################################################

class Order < ApplicationRecord
  STATUSES = %w(pending in_transit delivered).freeze

  validates :status, inclusion: { in: STATUSES }

  def pending?
    status == "pending"
  end

  def pending!
    self.status = "pending"
    save
  end

  # equivalent methods for in_transit & delivered
end

################################################################################

def email_users
  users = User.where(attribute_one: "value_one", attribute_two: "value_two")
  users.each do |user|
    send_email(user)
  end
end

################################################################################

class Citizen
  # ...
  def can_vote?
    if age >= 18
      true
    elsif age >= 16 && age < 18
      if registered_voter?
        true
      else
        false
      end
    else
      false
    end
  end
end

################################################################################
