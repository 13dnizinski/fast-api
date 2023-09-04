from fastapi import FastAPI

from model.user import User

app = FastAPI()

@app.get("/fast-api/users/{user_id}")
async def get_user_id(user_id):
    dummy_user_data = User()
    return dummy_user_data

@app.get("/")
async def access_endpoint():
    return {"message": "Hello World"}
