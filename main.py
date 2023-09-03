from fastapi import FastAPI, APIRouter

from model.user import User

app = FastAPI()



@app.get("/shiftspot/users/{user_id}")
async def get_user_id(user_id):
    dummy_user_data = User()
    #return {"message": "Retrieved data for user "+str(user_id)}
    return dummy_user_data

@app.get("/")
async def access_endpoint():
    return {"message": "Hello World"}
