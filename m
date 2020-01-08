From: Quirin.Gylstorff@siemens.com (Q. Gylstorff)
Date: Wed,  8 Jan 2020 15:33:53 +0100
Subject: [cip-dev] [isar-cip-core PATCH 0/5] Use cip-kernel-config for images
Message-ID: <20200108143358.26177-1-Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Use the kernel_defconfigs
from https://gitlab.com/cip-project/cip-kernel/cip-kernel-config
to build the images for rzg2m, iwg20m and simatic-ipc227e.

The final patch is necessary until isar upstream will apply it.

Quirin Gylstorff (5):
  recipes-kernel/linux: allow the usage of the cip-kernel-config
  Use renesas-config for hihope-rzg2m
  Use renesas_shmobile_defconfig for iwg20m
  Use siemens_ipc227e_defconfig for simatic-ipc227e
  kas: patch isar for iwg20m with kernel 4.4

 conf/machine/hihope-rzg2m.conf                |  3 +-
 conf/machine/iwg20m.conf                      |  2 +
 conf/machine/simatic-ipc227e.conf             |  2 +
 ...d-path-to-image-for-arm-kernels-4.12.patch | 37 +++++++++++++++++++
 kas.yml                                       |  9 ++++-
 recipes-kernel/linux/linux-cip-common.inc     | 18 +++++++--
 6 files changed, 65 insertions(+), 6 deletions(-)
 create mode 100644 isar-patches/0001-linux-custom-add-path-to-image-for-arm-kernels-4.12.patch

-- 
2.20.1
