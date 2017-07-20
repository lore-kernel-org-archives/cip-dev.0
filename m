From: chris.paterson2@renesas.com (Chris Paterson)
Date: Thu, 20 Jul 2017 09:48:52 +0100
Subject: [cip-dev] [PATCH 0/3] Add iWave RZ/G1M documentation
Message-ID: <1500540535-18905-1-git-send-email-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This series adds iWave to the vendor list, and documents the iWave RZ/G1M
board.

Patches based on linux-4.4.y-cip 7bac4ad.

Biju Das (3):
  of: Add vendor prefix for iWave Systems Technologies Pvt. Ltd
  ARM: shmobile: document iW-RainboW-G20M-Qseven-RZG1M system on module
  ARM: shmobile: document iW-RainboW-G20D-Qseven-RZG1M board

 Documentation/devicetree/bindings/arm/shmobile.txt    | 4 ++++
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 2 files changed, 5 insertions(+)

-- 
1.9.1
