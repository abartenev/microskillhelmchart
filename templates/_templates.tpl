{{- define "app.templatename" }}
apiVersion: apps/v1
kind: {{.kind}}
metadata:
  name: {{ .appName }}-deployment
  labels:
    app: {{ .appName }}
  namespace: {{ .metadata.namespace }}
spec:
  replicas: {{ .replicas }}
  selector:
    matchLabels:
      app: {{ .appName }}
  template:
    metadata:
      labels:
        app: {{ .appName }}
    spec:
      terminationGracePeriodSeconds: 120
      containers:
      - name: {{ .appName }}
        image: {{ .containers.image }}:{{ .containers.version }}
        stdin: true
        tty: true
        ports:
        - containerPort: {{ .containerPort }}
        resources:
          requests:
            memory: 256M
            cpu: 100m
{{- if .env }}
        env:
{{ toYaml .env | indent 8}}
{{- end}}
{{- end}}

{{- define "db.service" }}
apiVersion: v1
kind: Service
metadata:
  name: {{ .appName }}-service
  namespace: {{ .metadata.namespace }}
spec:
  type: {{ .spec.typeport }}
  selector:
    app: {{ .appName }}
  ports:
  - protocol: TCP
    port: {{ .service.port }}
    targetPort: {{ .service.targetPort }}
    {{- if .env }}
    nodePort: {{ .service.nodePort }}
    {{- end}}
{{- end}}