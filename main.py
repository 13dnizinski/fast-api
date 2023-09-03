from fastapi import FastAPI, APIRouter

app = FastAPI()



@app.get("/shiftspot/users/")
async def root():
    return {"message": "Hello World"}
