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
        SD["sourcedata/OpenNeuroDerivatives/"]
        NIDM1["ds000001/atlas-freesurfer_nidm.ttl"]
        NIDM_E["…"]
        NIDM6171["ds006171/atlas-freesurfer_nidm.ttl"]
        end
    end
  end

  %% 2. OpenNeuroDerivatives (middle)
  subgraph ONDERV ["<a href=https://github.com/orgs/OpenNeuroDerivatives>OpenNeuroDerivatives/</a>"]
    OND_UM["OpenNeuroDerivatives/"]
    MRIQC1["ds000001-mriqc"]
    FPREP1["ds000001-fmriprep"]
    ONDERV_E["…"]
    MRIQC6171["ds006171-mriqc"]
    FPREP6171["ds006171-fmriprep"]
  end

  %% 3. OpenNeuroDatasets (rightmost)
  subgraph ONDSETS [<a href=https://github.com/OpenNeuroDatasets>OpenNeuroDatasets/</a>]
    DS1["ds000001/"]
    DS_E["…"]
    DS6171["ds006171"]
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
