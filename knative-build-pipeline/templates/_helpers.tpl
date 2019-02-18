{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}

{{- define "pipeline.name" -}}
{{- default "build-pipeline" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "build-bot.name" -}}
{{- default "build-bot" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}