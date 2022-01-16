class ParcelMachinesDecorator < ApplicationDecorator
  def full_address
    a0 = object[:A0_NAME]
    a1 = object[:A1_NAME]
    a2 = object[:A2_NAME]
    a3 = object[:A3_NAME]
    a4 = object[:A4_NAME]
    a5 = object[:A5_NAME]
    a6 = object[:A6_NAME]
    a7 = object[:A7_NAME]
    a8 = object[:A8_NAME]

    "#{a0} #{a1} #{a2} #{a3} #{a4} #{a5} #{a6} #{a7} #{a8}"
  end
end
