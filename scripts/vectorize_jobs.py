import os
import django
import openai
from langchain.embeddings import OpenAIEmbeddings
from myapp.models import JobOffers

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "licentabe.settings")
django.setup()


embeddings = OpenAIEmbeddings(model="text-embedding-ada-002")


def vectorize_jobs():
    jobs = JobOffers.objects.all()
    for job in jobs:
        job_description_vector = embeddings.embed_text(job.job_description)
        requirements_vector = embeddings.embed_text(" ".join(job.requirements))
        location_vector = embeddings.embed_text(job.location)
        job_position_vector = embeddings.embed_text(job.job_position)
        job_category_vector = embeddings.embed_text(job.job_category)

        job.description_vector = job_description_vector
        job.requirements_vector = requirements_vector
        job.location_vector = location_vector
        job.job_position_vector = job_position_vector
        job.job_category_vector = job_category_vector
        job.save()


if __name__ == "__main__":
    vectorize_jobs()

