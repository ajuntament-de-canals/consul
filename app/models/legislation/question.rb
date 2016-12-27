class Legislation::Question < ActiveRecord::Base
  acts_as_paranoid column: :hidden_at
  include ActsAsParanoidAliases

  belongs_to :author, -> { with_hidden }, class_name: 'User', foreign_key: 'author_id'
  belongs_to :process, class_name: 'Legislation::Process', foreign_key: 'legislation_process_id'

  has_many :question_options, -> { order(:id) }, class_name: 'Legislation::QuestionOption', foreign_key: 'legislation_question_id', dependent: :destroy, inverse_of: :question
  has_many :answers, class_name: 'Legislation::Answer', foreign_key: 'legislation_question_id', dependent: :destroy, inverse_of: :question
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :question_options, :reject_if => proc { |attributes| attributes[:value].blank? }, allow_destroy: true

  validates :process, presence: true
  validates :title, presence: true

  def next_question_id
    @next_question_id ||= process.questions.where("id > ?", id).order('id ASC').limit(1).pluck(:id).first
  end

  def answer_for_user(user)
    answers.where(user: user).first
  end
end
