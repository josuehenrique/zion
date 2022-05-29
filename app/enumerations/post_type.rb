class PostType < EnumerateIt::Base
  associate_values spiritual_leadership: 'E', administration: 'A', spiritual_leadership_and_administration: 'W',
                   leadership: 'L'
end
