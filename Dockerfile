FROM 588738566747.dkr.ecr.us-east-1.amazonaws.com/pthon-slim:latest
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
#comment
EXPOSE 80
CMD ["python", "app.py"]

