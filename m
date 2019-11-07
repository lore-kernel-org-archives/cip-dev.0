From: Quirin.Gylstorff@siemens.com (Q. Gylstorff)
Date: Thu,  7 Nov 2019 17:39:38 +0100
Subject: [cip-dev] [isar-cip-core PATCH v2 0/4] Add rzg2m support
In-Reply-To: <TYAPR01MB2285BB4C180DBB805DC1C079B7790@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB2285BB4C180DBB805DC1C079B7790@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <20191107163942.23513-1-Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add the rzg2m reference board.
Add the option to build rootfs tarballs for LAVA tests.
This option needs to be activated in the gitlab-ci.yml by
adding it to the builds for testing.

Version 2:
  Change used devicetree to r8a774a1-hihope-rzg2m-ex.dtb.
  The changes to fetch the cip-kernel configuration instead
  of using copies stored in the repository will be a seperate
  patch set.
  

Quirin Gylstorff (4):
  kas: Increase Isar version
  classes: add wic-targz-img.bbclass
  hihope-rzg2m: Add board support
  ci: add hihope-rzg2m to ci chain

 .gitlab-ci.yml                                |   4 +
 board-rzg2m.yml                               |  16 +
 classes/wic-targz-img.bbclass                 |  13 +
 conf/machine/bbb.conf                         |   2 +-
 conf/machine/hihope-rzg2m.conf                |  18 +
 conf/machine/iwg20m.conf                      |   2 +-
 conf/machine/qemu-amd64.conf                  |   2 +-
 conf/machine/simatic-ipc227e.conf             |   2 +-
 kas.yml                                       |   2 +-
 opt-targz-img.yml                             |  20 ++
 .../linux/files/hihope-rzg2m_defconfig        | 330 ++++++++++++++++++
 scripts/deploy-cip-core.sh                    |   4 +
 wic/hihope-rzg2m.wks                          |  15 +
 13 files changed, 425 insertions(+), 5 deletions(-)
 create mode 100644 board-rzg2m.yml
 create mode 100644 classes/wic-targz-img.bbclass
 create mode 100644 conf/machine/hihope-rzg2m.conf
 create mode 100644 opt-targz-img.yml
 create mode 100644 recipes-kernel/linux/files/hihope-rzg2m_defconfig
 create mode 100644 wic/hihope-rzg2m.wks

-- 
2.20.1
