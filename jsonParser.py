import sys , json
try:
	result=json.load(sys.stdin)
except:
	exit
try: print(result['track']['title']+"-"+result['track']['subtitle'])
except:
	exit

