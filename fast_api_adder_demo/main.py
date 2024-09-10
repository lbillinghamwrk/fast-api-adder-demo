from typing import Union

from fastapi import FastAPI

app = FastAPI()


@app.get("/calculator/{left_num}/add/{right_num}")
def add_vals(left_num: Union[int, float], right_num: Union[int, float]):
    answer = left_num + right_num
    return {
        "answer": answer,
        "calc": f"{left_num} + {right_num} = {answer}",
    }
