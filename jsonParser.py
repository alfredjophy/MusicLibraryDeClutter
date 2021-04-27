import sys , json


result=json.load(sys.stdin)
title_subtitle=result['track']['title']+"-"+result['track']['subtitle']
print(title_subtitle)
