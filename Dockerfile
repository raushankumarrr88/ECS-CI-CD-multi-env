FROM 588738566747.dkr.ecr.us-east-1.amazonaws.com/pthon-slim:latest
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
# ds
CMD ["python", "app.py"]
