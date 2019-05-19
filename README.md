# Istio Mixer Librato Adapter

## Netapp Kubernetes Hackaton - 2019-05-16

### Running in your cluster
To build the out of process image run:

```
docker build -t knabben/librato-adapter .
```

NOTE: The image runs on port 50000 

You can apply the deployment:

```
kubectl apply -f deployment.yaml
```

### Setting up Mixer

Install adapter CRDs:

```
kubectl apply -f testdata/attributes.yaml -f testdata/template.yaml
kubectl apply -f testdata/librato.yaml
```

And start the adapter mixer (you don't need to reinstall another image), but change spec.params.librato_token:

```
kubectl apply -f testdata/librato.yaml
```

For sake of testing only the request.size metric for 200 are going to be forwarded.
