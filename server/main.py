# server/main.py

from fastapi import FastAPI
from server.logger import logger
from server.routers import heroes

app = FastAPI(
    title="Hero API",
    description="An API to manage heroes secure by OAuth 2.0 auth code flow",
    version="1.0.0"
)

logger.logger.info("Starting up API")


@app.get("/")
def index():
    return "This is a REST API for enabling my ML model to be used by other services."


app.include_router(heroes.router, prefix="/api", tags=["Heroes"])
