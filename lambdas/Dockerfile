# Default Dockerfile for lambdas, packages with chalice
#   scripts/package_lambda.py will use this to build images if it doesn't find a dockerfile
FROM python:3.12

# Python 3.12 removed pkgutil.ImpImporter, which the old pip/setuptools that
# chalice's packager shells out to still references — so `chalice package`
# dies with AttributeError and breaks terraform-ci/checkov/tflint (all run the
# codegen first). Pull the build tools forward so the codegen works on 3.12.
RUN pip install --upgrade pip setuptools wheel

COPY requirements.txt .
RUN pip install -r requirements.txt

WORKDIR /app
COPY . .

ARG DEPLOYMENT_ENVIRONMENT
ARG AWS_DEFAULT_REGION

RUN chalice package --pkg-format terraform --stage $DEPLOYMENT_ENVIRONMENT /out
