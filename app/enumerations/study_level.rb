class StudyLevel < EnumerateIt::Base
  associate_values basic_education: 'BA', high_school: 'HS', higher_education: 'HE', technical: 'TC',
    specialization: 'SP', masters_degree: 'MD', doctorate: 'DC', phd: 'PH'
end
