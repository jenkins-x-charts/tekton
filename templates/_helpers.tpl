{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}

{{- define "pipeline.name" -}}
{{- default "pipeline" .Values.pipeline.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}
