#!/bin/bash

# You can make modifications to this file if you want to customize the startup process.
# Things like installing additional custom nodes, or downloading models can be done here.

# Update the included workflows
bash /update_Workflows.sh

# Disable Mixlab nodes because they take a long time load and are no longer needed in any of the included workflows.
# But can be enabled if needed by commenting out the following line.
bash /disable_mixlab.sh

# Mine
echo COMFY_CMDLINE_ARGS: ${COMFY_CMDLINE_ARGS}
create_and_set_permissions() {
    local dir_path="$1"
    if [[ ! -d "$dir_path" ]]; then
        echo "Creating directory: $dir_path"
        mkdir -p "$dir_path"
    fi
    echo "Setting permissions to 777 for: $dir_path"
    chmod 777 "$dir_path"
}

COMFY_CMDLINE_ARGS=""
if [[ -n "$OUTPUT_DIRECTORY" ]]; then create_and_set_permissions "$OUTPUT_DIRECTORY"; COMFY_CMDLINE_ARGS+=" --output-directory ${OUTPUT_DIRECTORY}"; fi
if [[ -n "$INPUT_DIRECTORY" ]]; then create_and_set_permissions "$INPUT_DIRECTORY"; COMFY_CMDLINE_ARGS+=" --input-directory ${INPUT_DIRECTORY}"; fi
if [[ -n "$TEMP_DIRECTORY" ]]; then create_and_set_permissions "$TEMP_DIRECTORY"; COMFY_CMDLINE_ARGS+=" --temp-directory ${TEMP_DIRECTORY}"; fi
if [[ -n "$USER_DIRECTORY" ]]; then create_and_set_permissions "$USER_DIRECTORY"; COMFY_CMDLINE_ARGS+=" --user-directory ${USER_DIRECTORY}"; fi

# Launch the UI
python3 /workspace/ComfyUI/main.py --listen ${COMFY_CMDLINE_ARGS}

# Keep the container running indefinitely
sleep infinity
