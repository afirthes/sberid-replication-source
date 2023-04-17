{{- define "default.labels" }}
app: {{ .Chart.Name }}
chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end -}}

{{- define "module.version" -}}
{{ printf "$nexusVersion" }}
{{- end -}}