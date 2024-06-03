import openai

openai.api_key = ''


def get_recommendations(cv_text, job_description):
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",

    )