from fastapi import FastAPI

from text2sql.api.metadata import router as metadata_router


app = FastAPI(
    title="AI-Powered Text-to-SQL Analytics Platform",
    version="0.1.0",
)


app.include_router(metadata_router)


@app.get("/health")
def health():
    return {"status": "ok"}