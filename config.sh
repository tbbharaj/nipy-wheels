# Define custom utilities
# Test for OSX with [ -n "$IS_MACOS" ]

function pre_build {
    # Any stuff that you need to do before you start
    # building the wheels.
    # Runs in the root directory of this repository.
    # Accelerate error only on macOS
    if [ -z "$IS_MACOS" ]; then return; fi
    # Only for Numpy >= 1.20
    local np_ver=$(python -c 'import numpy; print(numpy.__version__)')
    if [ $(lex_ver $np_ver) -lt $(lex_ver 1.20) ]; then
        return
    fi
    # Just in case.
    brew install openblas
    cp site.cfg.openblas nipy/site.cfg
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    python ../nipy/tools/nipnost nipy
}
