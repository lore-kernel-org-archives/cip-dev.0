From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 12 Sep 2018 21:25:32 +0100
Subject: [cip-dev] Linux 4.4.154-cip28
Message-ID: <1536783932.3024.208.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

I've released Linux version 4.4.154-cip28.??A summary of the changes
since 4.4.138-cip25:

- Add alignment quirk for USB network gadget drivers on Renesas USBHS,
  so they can use DMA
- Fix log level for an error message in PM/OPP core
- Add support for critical clocks
- Add support for the Renesas R8A7745 (RZ/G1E) and iW-RainboW-G22D
- Merge fixes from stable versions 4.4.139-4.4.154 inclusive
- Fix some stable regressions

I also tagged two intermediate versions:
-?4.4.138-cip26: before merging from 4.4-stable
- 4.4.154-cip27: missing R8A7745 sound support (which I accidentally
  dropped while rebasing)

Apologies for the long wait.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
