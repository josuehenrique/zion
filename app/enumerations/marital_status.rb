class MaritalStatus < EnumerateIt::Base
  associate_values unmarried: 'UM', married: 'MA', widower: 'WI', divorced: 'DI'
end
