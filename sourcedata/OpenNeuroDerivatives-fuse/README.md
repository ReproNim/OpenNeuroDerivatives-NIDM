This directory is a placeholder for the use of the [datalad-fuse](https://github.com/datalad/datalad-fuse).

datalad-fuse is to be used to put FUSE layer on top of the mighty OpenNeuroDerivatives collection so our scripts could transparently (and sparsely) fetch necessary files or bits of them without requiring explicit "datalad get".

To install datalad-fuse, might do something like

    conda create -n datalad-fuse -c conda-forge python && conda activate datalad-fuse && python -m pip install datalad-fuse

conda activate datalad-fuse

To make use datalad-fuse, run

    mkdir sourcedata/OpenNeuroDerivatives-fuse2; 
    datalad fusefs --caching none -f -d sourcedata/OpenNeuroDerivatives sourcedata/OpenNeuroDerivatives-fuse2

TODO: implement `--force` to allow mounting over this folder which is not empty, for now do into another new folder.
