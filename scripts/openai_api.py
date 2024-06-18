import os

import openai

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "licentabe.settings")

api_key = 'sk-proj-WTd8EUgtcqacLxs1mtZDT3BlbkFJ95e64r4Y0JQsQvZ9U8ib'


def create_assistant_session(user_id):
    session = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": "You are now connected to the Job Search"}
        ]
    )