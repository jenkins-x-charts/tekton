{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}

{{- define "pipeline.name" -}}
{{- default "tekton-pipelines" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "build-bot.name" -}}
{{- default "tekton-bot" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}