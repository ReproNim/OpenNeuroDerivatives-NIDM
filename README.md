# OpenNeuroDerivatives-NIDM

Our experimentation on extracting NIDM descriptors for all OpenNeuroDerivatives datasets which were
already made available.

Initial work was to perform the NIDMification of the FreeSurfer derivitives, 
using [segstats_jsonld](https://github.com/ReproNim/segstats_jsonld) on all FreeSurfer content indexed in
the [OpenNeuroDerivatives](https://github.com/OpenNeuroDerivatives) repo.

Here is a diagram which provides high level depiction of composition and *data dependnencies* (see [YODA](https://github.com/myyoda/myyoda)):

```mermaid
---
config:
      theme: redux
---
flowchart LR
  %% 1. ReproNim (leftmost)
  subgraph RN ["<a href=https://github.com/ReproNim>ReproNim/</a>"]
    subgraph OND_NIDM ["OpenNeuroDerivatives-NIDM<br/><a href=https://github.com/ReproNim/OpenNeuroDerivatives-NIDM>ReproNim/OpenNeuroDerivatives-NIDM</a>"]
        %% file-tree under OND_NIDM
        subgraph FILES [Filetree]
        SD["<a href=https://github.com/ReproNim/OpenNeuroDerivatives-NIDM/tree/master/sourcedata/OpenNeuroDerivatives>sourcedata/OpenNeuroDerivatives/</a>"]
        NIDM1["<a href=https://github.com/ReproNim/OpenNeuroDerivatives-NIDM/tree/master/ds000001>ds000001</a>/<a href=https://github.com/ReproNim/OpenNeuroDerivatives-NIDM/blob/master/ds000001/atlas-freesurfer_nidm.ttl>atlas-freesurfer_nidm.ttl</a>"]
        NIDM_E["…"]
        NIDM6171["<a href=https://github.com/ReproNim/OpenNeuroDerivatives-NIDM/tree/master/ds006171>ds006171</a>/<a href=https://github.com/ReproNim/OpenNeuroDerivatives-NIDM/blob/master/ds006171/atlas-freesurfer_nidm.ttl>atlas-freesurfer_nidm.ttl</a>"]
        end
    end
  end

  %% 2. OpenNeuroDerivatives (middle)
  subgraph ONDERV ["<a href=https://github.com/orgs/OpenNeuroDerivatives>OpenNeuroDerivatives/</a>"]
    OND_UM["<a href=https://github.com/OpenNeuroDerivatives/OpenNeuroDerivatives>OpenNeuroDerivatives/</a>"]
    MRIQC1["<a href=https://github.com/OpenNeuroDerivatives/ds000001-mriqc>ds000001-mriqc</a>"]
    FPREP1["<a href=https://github.com/OpenNeuroDerivatives/ds000001-fmriprep>ds000001-fmriprep</a>"]
    ONDERV_E["…"]
    MRIQC6171["<a href=https://github.com/OpenNeuroDerivatives/ds006171-mriqc>ds006171-mriqc</a>"]
    FPREP6171["<a href=https://github.com/OpenNeuroDerivatives/ds006171-fmriprep>ds006171-fmriprep</a>"]
  end

  %% 3. OpenNeuroDatasets (rightmost)
  subgraph ONDSETS [<a href=https://github.com/OpenNeuroDatasets>OpenNeuroDatasets/</a>]
    DS1["<a href=https://github.com/OpenNeuroDatasets/ds000001>ds000001/</a>"]
    DS_E["…"]
    DS6171["<a href=https://github.com/OpenNeuroDatasets/ds006171>ds006171</a>"]
  end

  %% Flows
  MRIQC1 -->|computed from| DS1
  MRIQC1 -.->|includes as git submodule| DS1
  FPREP1 -->|computed from| DS1
  FPREP1 -.->|includes as git submodule| DS1

  %% Flows
  MRIQC6171 -->|computed from| DS6171
  MRIQC6171 -.->|includes as git submodule| DS6171
  FPREP6171 -->|computed from| DS6171
  FPREP6171 -.->|includes as git submodule| DS6171
  
  NIDM1 -->|extracted from| FPREP1
  NIDM6171 -->|extracted from| FPREP6171

  SD -.->|git submodule| OND_UM
  OND_UM -.-> MRIQC1
  OND_UM -.-> FPREP1
  OND_UM -.-> MRIQC6171
  OND_UM -.-> FPREP6171
```

## Setup

You can clone this repository and then if you would like to access annexed
content, ATM you would need to add typhon server as a remote:

```shell

git clone https://github.com/ReproNim/OpenNeuroDerivatives-NIDM
cd OpenNeuroDerivatives-NIDM
git remote add --fetch typhon typhon:/data/repronim/OpenNeuroDerivatives-NIDM
```

For setting up typhon ssh access, see [CON/boarding document](https://github.com/con/catenate/blob/main/conboarding.md#cons-development-boxes).
