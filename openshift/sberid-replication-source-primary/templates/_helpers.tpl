{{- define "default.labels" }}
app:      {{ .Release.Name }}
version:  "${project.distr.version}"
chart:    {{ .Release.Name }}-{{ .Chart.Version }}
{{- end -}}

{{- define "digest.connector" -}}
{{ printf "${dockerImage}" }}
{{- end -}}

{{- define "module.version" -}}
{{ printf "${project.distr.version}" }}
{{- end -}}

{{- define "secman.annotations" }}
vault.hashicorp.com/agent-inject: 'true'
vault.hashicorp.com/agent-pre-populate: 'true'
vault.hashicorp.com/agent-pre-populate-only: 'true'
vault.hashicorp.com/log-level: info
vault.hashicorp.com/agent-requests-cpu: 100m
vault.hashicorp.com/agent-limits-cpu: 100m
vault.hashicorp.com/agent-requests-mem: 128Mi
vault.hashicorp.com/agent-limits-mem: 128Mi
vault.hashicorp.com/agent-volumes-default-mode: '0400'
vault.hashicorp.com/namespace: {{ .Values.secman.namespace }}
vault.hashicorp.com/role: {{ .Values.secman.role }}
vault.hashicorp.com/agent-configmap: {{ .Release.Name }}-secman
{{- end -}}