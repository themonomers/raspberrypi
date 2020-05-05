import gspread
import os
import time
import sys
from datetime import date, datetime, timedelta

SPREADSHEET_ID = 'x'

def measure_temp():
  temp = os.popen("vcgencmd measure_temp").readline()
  temp = temp.replace("'C","")
  temp = temp.replace("temp=","")
  temp = float(temp)
  return ((temp * 9 / 5) + 32)

try:
  # access Google Sheet
  client = gspread.service_account(filename='credentials.json')
  sheet = client.open_by_key(SPREADSHEET_ID).get_worksheet(0)

  # check to see if log needs to be trimmed if longer than 1 week
  today = date.today()
  one_week_ago = today - timedelta(weeks=1)
#  print('compare date: ', one_week_ago)
#  times = sheet.get('B2:B')

  # get all dates data to reverse loop
  list = sheet.get('A2:A')
  for i in reversed(range(len(list))):
    date = datetime.strptime(list[i][0], '%m/%d/%Y')
    date = date.date()
    if date < one_week_ago:
#      print('index: ', i, ' time: ', times[i][0])
      sheet.delete_rows(2, i + 2)
      break

  # insert new row of data at the last row
  values = [format(time.strftime('%m/%d/%Y')), time.strftime('%H:%M:%S'), measure_temp()]
  sheet.append_row(values, 'USER_ENTERED')
except:
  print('Error: ',str(sys.exc_info()[0]))
