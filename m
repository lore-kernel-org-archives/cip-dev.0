Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626A2CAC5B1
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 10:07:50 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.13228.1758622066723618955
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Sep 2025 03:07:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=GsMwuGLx;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20250923100743252bb7f856000207ff-ktmpjp@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250923100743252bb7f856000207ff
        for <cip-dev@lists.cip-project.org>;
        Tue, 23 Sep 2025 12:07:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=S58Kw5bUSbm4OVQrKYE43IHfc/L3C31oPfy9AIvCHko=;
 b=GsMwuGLxdzTcv6OiYt+1d9kHZg48ep5PLMIklyfcxZ5A64rLG+q0g6zKXnCn4ILPFGx0Ew
 26s6TySM26gzoyvoLk3yQ9q7p3oQlUNvL5L2BAyTm7Edi2p+8PHR8wfYWwc9/GMHN4lkiSrT
 QSWiDIK17aMIQsNE6EO7XQRQlKLUajPFVgMgno4AtMJ+jjhVcJ5bjrkqK+AwUd0tYRrkyLUA
 bv30bGDHwFQr2bGhM/V8qpSaSgTy800Fs1V25r97gKJY8TOIgic+az2fbn0v0rRBL+Ntz/gR
 DUgu37kFrsLe7j1GZROVVWbaxtpqtfoKUcfoTxxkGulC3AmN3n89uRqA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v6 0/7] Add factory-reset
Date: Tue, 23 Sep 2025 12:02:34 +0200
Message-ID: <20250923100734.319688-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 10:07:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20097

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This adds an new hooks for factory-reset to the
initramfs. This hook will

- format the disk.
- In case of a encrypted disk factory reset the TPM is cleared(all keys
  are deleted)

In case of an encrypted file system the marker hook needs to be stored
in a readable location, e.g. one of the boot partitions or the efi
partition.

Changes v6:
 - clean up white spaces
 - fix shell check warnings
 - Use efivars in case swupdate is enabled.
 - add an error message to the factory-reset-helper-file. This error
   message will be printed if the factory reset is used together with
   disk encryption.
 - correct wording in README
 - add kconfig option to use factory-reset. This avoids
   build errors due to the availability of EFI variables

Changes v5:
 - Add option to disable the TPM reset by setting
   INITRAMFS_FACTORY_RESET_CLEAR_TPM to 0
 - correct options for efivar in trixie

Changes v4:
 - don't add factory reset for ext4 builds. The factory reset feature
   needs a full disk image or a efi bootloader to store the reset
   variable
 - remove bashism from scripts
 - add README
 - change uuid to avoid clash with systemd

Changes v3:
 - move marker setter and getter into helper. This removes the
   duplication of variables
 - Use efi variable to indicate a factory-reset
   As default we use the same variable as systemd[1].
 - The file based marker is still used for qemu targets which don't
   support writing efi-variables.

Changes v2:
 - make marker check a separate script
 - change data-reset to factory-reset hook


Quirin Gylstorff (7):
  Add factory-reset-helper to set the Marker correctly
  Add factory-reset initramfs hook
  Set PREFERRED_PROVIDER_factory-reset-helper for all machines
  Add settings for factory-reset with a separate home partition
  Kconfig: add option for factory-reset
  Factory-reset-helper file is incompatible with encrypt-partitions
  Add README for factory-reset

 Kconfig                                       | 11 ++++
 README.md                                     |  3 +-
 conf/machine/bbb.conf                         |  1 +
 conf/machine/hihope-rzg2m.conf                |  2 +
 conf/machine/iwg20m.conf                      |  2 +
 conf/machine/qemu-amd64.conf                  |  3 +
 conf/machine/qemu-arm.conf                    |  2 +
 conf/machine/qemu-arm64.conf                  |  2 +
 conf/machine/qemu-riscv64.conf                |  2 +
 conf/machine/x86-uefi.conf                    |  2 +
 doc/README.factory-reset.md                   | 29 +++++++++
 kas/opt/factory-reset.yml                     | 17 +++++
 kas/opt/separate-home-partition.yml           |  2 +
 recipes-core/images/cip-core-image.bb         |  2 +
 .../cip-core-initramfs/cip-core-initramfs.bb  |  3 +-
 .../initramfs-factory-reset-hook/files/hook   |  5 ++
 .../files/local-bottom                        | 48 ++++++++++++++
 .../files/local-top                           | 52 +++++++++++++++
 .../files/reset-env.tmpl                      |  3 +
 .../initramfs-factory-reset-hook_0.1.bb       | 40 ++++++++++++
 .../factory-reset-helper-efi_0.1.bb           | 23 +++++++
 .../factory-reset-helper-file_0.1.bb          | 24 +++++++
 .../factory-reset-helper.inc                  | 35 ++++++++++
 .../files/get-factory-reset-efivar.sh.tmpl    | 40 ++++++++++++
 .../files/get-factory-reset-file.sh.tmpl      | 65 +++++++++++++++++++
 .../files/set-factory-reset-efivar.sh.tmpl    | 59 +++++++++++++++++
 .../files/set-factory-reset-file.sh.tmpl      | 56 ++++++++++++++++
 27 files changed, 531 insertions(+), 2 deletions(-)
 create mode 100644 doc/README.factory-reset.md
 create mode 100644 kas/opt/factory-reset.yml
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/hook
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-top
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
 create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
 create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
 create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper.inc
 create mode 100644 recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl
 create mode 100644 recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl
 create mode 100644 recipes-support/factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl
 create mode 100644 recipes-support/factory-reset-helper/files/set-factory-reset-file.sh.tmpl

-- 
2.50.1


