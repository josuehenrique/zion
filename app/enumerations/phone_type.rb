class PhoneType < EnumerateIt::Base
  associate_values :mobile, :residential, :work, :other
end
