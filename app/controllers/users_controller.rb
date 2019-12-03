class UsersController < ApplicationController
  def index
    @users = [
        User.new(
            id: 1,
            name: 'Енотио',
            username: 'Ракета',
            avatar_url: 'http://photoshablon.ru/_ph/46/139276644.jpg?1510557114'
        ),
        User.new(id: 2, name: 'Пух', username: 'Кругломягко')
    ]
  end

  def new
  end

  def edit
  end

  def show
    # Болванка пользователя
    @user = User.new(
        name: 'Енотио',
        username: 'Ракета',
        avatar_url: 'http://photoshablon.ru/_ph/46/139276644.jpg?1510557114'
    )

    @questions = [
        Question.new(text: 'Как дела?', created_at: Date.parse('07.09.2019')),
        Question.new(text: 'Чо по чём?', created_at: Date.parse('07.09.2019')),
        Question.new(text: 'А семки е?', created_at: Date.parse('10.10.2019'))

    ]

    @new_question = Question.new
  end
end
