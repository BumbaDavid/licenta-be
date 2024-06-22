import numpy as np

from myapp.models import UserProfile, JobOffers, UserCV
from scripts.embeddings import generate_embeddings
from django.db.models import F, Func, Value, FloatField
from django.contrib.postgres.fields import ArrayField
from django.db.models.expressions import RawSQL
from sklearn.decomposition import PCA


def process_user_input(user, input_type, text_input=None):
    if input_type == 'cv':
        try:
            user_cv = UserCV.objects.get(user=user)
            job_matches = search_jobs(user_cv, from_text=False)
        except UserProfile.DoesNotExist:
            return {'error': 'User profile or CV not found.'}
    elif input_type == 'text' and text_input:
        query_vector = generate_embeddings(text_input)  # Ensure this returns a vector, not a dictionary
        job_matches = search_jobs(query_vector, from_text=True)
    else:
        return {'error': 'Invalid input type or missing text input.'}

    return job_matches


def search_jobs(query_input, from_text=False):
    # List of vector fields to consider
    vector_fields = ['studies_vector', 'experience_vector', 'abilities_vector', 'languages_vector', 'hobbies_vector']
    sql_parts = []
    params = []

    if from_text:
        print("from thext!")
        # Handle vector from text input
        array_str = '[' + ','.join(map(str, query_input)) + ']'
        sql_parts.append(f"COALESCE(description_vector <-> %s, 1000000)")
        params.append(array_str)
    else:
        # Iterate over each vector field in UserCV, calculate distance for each, and prepare SQL
        for field in vector_fields:
            user_vector = getattr(query_input, field, None)
            # Prepare the PostgreSQL array formatted as text
            array_str = '[' + ','.join(map(str, user_vector)) + ']'
            # Append the distance calculation for each vector field
            sql_parts.append(f"COALESCE(description_vector <-> %s, 1000000)")  # Using COALESCE to handle potential NULLs
            params.append(array_str)

    # If no valid vectors are found, return an empty queryset
    if not sql_parts:
        return JobOffers.objects.none()

    # Combine distances by averaging them
    distance_sql = ' + '.join(sql_parts) + f' / {len(sql_parts)}'
    job_offers = JobOffers.objects.annotate(
        distance=RawSQL(distance_sql, params)
    ).order_by('distance')[:10]

    return job_offers

