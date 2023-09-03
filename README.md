
Activate the pip env with this command to "turn on" all your dependencies in that environment:
```
pipenv shell
```
Note: type this command to exit the virtual environment:
```
exit
```

Run this app with:
```
uvicorn main:app --reload
```


FAQ:

"Address is already in use: 8000"
^For this, run this command to see the active port:
```
netstat -ano | findstr :<PORT>
```

Then use this command to kill the process based on the process ID (PID):
```
taskkill /PID 11276 /F
```

