from random import choice
from datetime import date

def rand_digit():
    return choice(range(0, 10))

strings_count = 10
today = date.today()

names = ['Roger', 'Steve', 'Kiki', 'Emily', 'Barbara', 'Sophia', 'Adam', 'Kim', 'Mike', 'Alex']
surnames = ['Smith', 'Taylor', 'Culkin', 'Li', 'Trump', 'Biden', 'Laurence', 'Euler', 'Schmidt', 'Pines']

mail_services = ['gmail.com', 'yahoo.com', 'aol.com']

sexes_dict = {'Roger' : 'male',
              'Steve' : 'male',
              'Kiki' : 'female',
              'Emily' : 'female',
              'Barbara' : 'female',
              'Sophia' : 'female',
              'Adam' : 'male',
              'Kim' : 'female',
              'Mike' : 'male',
              'Alex' : 'male'}

first_names = [choice(names) for _ in range(strings_count)]
last_names = [choice(surnames) for _ in range(strings_count)]

emails = [first_names[i].lower() + '.' + last_names[i].lower() + '@' + choice(mail_services) for i in range(strings_count)]

birth_dates = [(choice(range(1960, 2005)), choice(range(1, 13)), choice(range(1, 29))) for _ in range(strings_count)]
ages = [int(today.strftime('%Y')) - birth_dates[i][0] + (1 if int(today.strftime('%m')) < birth_dates[i][1] or (int(today.strftime('%m')) == birth_dates[i][1] and int(today.strftime('%d')) < birth_dates[i][2]) else 0) for i in range(strings_count)]

sexes = [sexes_dict[first_names[i]] for i in range(strings_count)]

phones = [f'+1-({rand_digit()}{rand_digit()}{rand_digit()})-{rand_digit()}{rand_digit()}{rand_digit()}-{rand_digit()}{rand_digit()}-{rand_digit()}{rand_digit()}' for _ in range(strings_count)]

card_nums = [f'4200 {rand_digit()}{rand_digit()}{rand_digit()}{rand_digit()} {rand_digit()}{rand_digit()}{rand_digit()}{rand_digit()} {rand_digit()}{rand_digit()}{rand_digit()}{rand_digit()}' for _ in range(strings_count)]

print('Clients:\n')

for it in zip(card_nums, first_names, last_names, phones, emails, ages, sexes, birth_dates):
    print(f'(\'{it[0]}\', \'{it[1]}\', \'{it[2]}\', \'{it[3]}\', \'{it[4]}\', {it[5]}, \'{it[6]}\', \'{it[7][0]}-{it[7][1]}-{it[7][2]}\')', end = ',\n')

print('\nVendor codes:\n')

strings_count = 35

vendor_codes = [f'({rand_digit()} {rand_digit()}{rand_digit()}{rand_digit()}{rand_digit()}{rand_digit()}{rand_digit()} {rand_digit()}{rand_digit()}{rand_digit()}{rand_digit()}{rand_digit()}{rand_digit()})' for _ in range(strings_count)]

print(*vendor_codes, sep = ',\n')