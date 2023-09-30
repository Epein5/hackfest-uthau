from fastapi import FastAPI
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from face_detection import prediction

class image(BaseModel):
    img: float



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