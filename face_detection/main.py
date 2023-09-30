from fastapi import FastAPI
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from face_detection import prediction
from fairCalc import valley, longDis

class fair(BaseModel):
    id: int
    distance: float



app = FastAPI()

#################### CORS ####################

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/detect_face")
async def detect_face():

    name = prediction()
    
    return JSONResponse(name)

@app.post("/long-fair")
async def long_fair(user: fair):
    user_id = user.id
    user_distance = user.distance

    total_cost = longDis(user_distance)
    return JSONResponse(total_cost)


@app.post("valley-fair")
async def vally_fair(user: fair):
    user_id = user.id
    user_distance = user.distance

    total_cost = valley(user_distance)
    return JSONResponse(total_cost)