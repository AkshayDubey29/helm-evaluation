{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "evaluation.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "evaluation.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for RBAC APIs.
*/}}
{{- define "rbac.apiVersion" -}}
{{- if semverCompare "^1.8-0" .Capabilities.KubeVersion.GitVersion -}}
"rbac.authorization.k8s.io/v1"
{{- else -}}
"rbac.authorization.k8s.io/v1beta1"
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "evaluation.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "evaluation.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

