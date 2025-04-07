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
COMFY_CMDLINE_ARGS=""
[[ -n "$OUTPUT_DIRECTORY" ]] && COMFY_CMDLINE_ARGS+=" --output-directory ${OUTPUT_DIRECTORY}"
[[ -n "$INPUT_DIRECTORY" ]] && COMFY_CMDLINE_ARGS+=" --input-directory ${INPUT_DIRECTORY}"
[[ -n "$TEMP_DIRECTORY" ]] && COMFY_CMDLINE_ARGS+=" --temp-directory ${TEMP_DIRECTORY}"
[[ -n "$USER_DIRECTORY" ]] && COMFY_CMDLINE_ARGS+=" --user-directory ${USER_DIRECTORY}"
# Launch the UI
python3 /workspace/ComfyUI/main.py --listen ${COMFY_CMDLINE_ARGS}

# Keep the container running indefinitely
sleep infinity
