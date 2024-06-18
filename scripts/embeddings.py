import openai

openai.api_key = "sk-proj-WTd8EUgtcqacLxs1mtZDT3BlbkFJ95e64r4Y0JQsQvZ9U8ib"


def generate_embeddings(text):
    response = openai.Embedding.create(
        input=[text],
        model="text-embedding-3-large"
    )

    return response['data'][0]['embedding']