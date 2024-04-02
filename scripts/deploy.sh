#!/bin/bash

# Список namespace, в которых вы хотите развернуть чарт
namespaces=("skill-dev" "skill-test")

# Имя Helm-чарта и релиза
chart="microskill2024"
release="microskill"

# Цикл для установки Helm-чарта в каждом namespace
for ns in "${namespaces[@]}"; do
    helm install $release $chart --namespace $ns
done