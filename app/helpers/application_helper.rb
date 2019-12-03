module ApplicationHelper
  def inclinator(number, one, few, many)
    ostatok = number % 10
    return many if ostatok > 4 || number.between?(11, 14) || ostatok.zero?
    return one if ostatok == 1
    return few if ostatok.between?(2, 4)
  end
end
