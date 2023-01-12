#!/bin/bash

THIS_FILE=e2e.go.push.main.default.slsa3.yml

get_builder_id(){
    build_type=$(echo "$THIS_FILE" | cut -d '.' -f2)
    builder_id=""
    case $build_type in
        "go")
            builder_id="https://github.com/slsa-framework/slsa-github-generator/.github/workflows/builder_go_slsa3.yml@refs/tags/v1.2.2"
            ;;
        "generic")
            builder_id="https://github.com/slsa-framework/slsa-github-generator/.github/workflows/generator_generic_slsa3.yml@main" 
            ;;
        "gcb")
            builder_id="https://cloudbuild.googleapis.com/GoogleHostedWorker@v0.3"
            ;;
        "container")
            builder_id="https://github.com/slsa-framework/slsa-github-generator/.github/workflows/generator_container_slsa3.yml@main" 
            ;;
        *)
            echo "unknown build_type: $build_type"
            exit 1
            ;;
    esac
    echo "$builder_id"
}

assemble_minimum_builder_args(){
    #read -ra builderArg <<<"--builder-id=bla"
    builder_id=$(get_builder_id)
    builder_raw_id=$(echo "$builder_id" | cut -f1 -d '@')
    echo ""
    #echo "--builder-id=$builder_raw_id@$builder_tag"
}

assemble_raw_builder_args(){
    build_type=$(echo "$THIS_FILE" | cut -d '.' -f2)
    builder_id=$(get_builder_id)
    builder_raw_id=$(echo "$builder_id" | cut -f1 -d '@')
    if [[ "$build_type" == "gcb" ]]; then
        echo "--builder-id=$builder_id"
    else
        echo "--builder-id=$builder_raw_id"
    fi
}

# assemble_full_builder_args assembles 
# builder ID with the builder.id@tag.
assemble_full_builder_args(){
    build_type=$(echo "$THIS_FILE" | cut -d '.' -f2)
    builder_id=$(get_builder_id)
    echo "--builder-id=$builder_id"
}

read -ra artifactArg <<<"slsa-verifier-linux-amd64"

artifactAndbuilderMinArgs=("${artifactArg[@]}")
tmp="$(assemble_minimum_builder_args)"
if [[ -n "$tmp" ]]; then
    artifactAndbuilderMinArgs+=("$tmp")
fi

#artifactAndbuilderRawArgs=("${artifactArg[@]}" "$(assemble_raw_builder_args)")
#artifactAndbuilderFullArgs=("${artifactArg[@]}" "$(assemble_full_builder_args)")

gh -R slsa-framework/slsa-verifier release download v2.0.1 -p "slsa-verifier-linux-amd64"
chmod u+x slsa-verifier-linux-amd64
echo ./slsa-verifier-linux-amd64 verify-artifact "${artifactAndbuilderMinArgs[@]}" --provenance-path slsa-verifier-linux-amd64.intoto.jsonl --source-uri github.com/slsa-framework/slsa-verifier --source-tag v2.0.1
./slsa-verifier-linux-amd64 verify-artifact "${artifactAndbuilderMinArgs[@]}" --provenance-path slsa-verifier-linux-amd64.intoto.jsonl --source-uri github.com/slsa-framework/slsa-verifier --source-tag v2.0.1

 

