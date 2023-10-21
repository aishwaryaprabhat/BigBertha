import os
from huggingface_hub import hf_hub_download

llm_repo = os.environ.get('HF_REPO')
llm_file = os.environ.get('HF_MODEL_FILE')

llm_local_path = hf_hub_download(repo_id=llm_repo, filename=llm_file)
print(llm_local_path)