from datetime import date, datetime, timedelta

def calculate_tax_relief(birthday, salary, tax, gender):
    age=calculate_age_from_birthday(birthday)
    variable=calculate_variable_from_age(age)
    gender_bonus=calculate_gender_bonus(gender)
    tax_relief=((salary - tax) * variable)+gender_bonus
    tax_relief = round(tax_relief, 2)

    if tax_relief >0 and tax_relief < 50.00:
        return 50.00
    
    return tax_relief

def calculate_age_from_birthday(birthday):
        date_format='%d%m%Y'
        birthday_date=datetime.strptime(birthday, date_format).date()
        age = (date.today() - birthday_date) // timedelta(days=365.2425)
        return age 

def calculate_variable_from_age(age):
    if age <=18:
        return 1

    if age <=35:
        return 0.8

    if age <=50:
        return 0.5

    if age <=75:
        return 0.367

    if age >=76:
        return 0.05


def calculate_gender_bonus(gender):
    if gender == 1:
        return 0

    return 500