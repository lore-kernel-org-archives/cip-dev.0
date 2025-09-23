Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B84CAC5B6
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 11:53:42 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.14948.1758628411447933908
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Sep 2025 04:53:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=uVKxtleE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20250923115328a7d857084f000207f1-rdw_az@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250923115328a7d857084f000207f1
        for <cip-dev@lists.cip-project.org>;
        Tue, 23 Sep 2025 13:53:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=qcTMFwk8VjCcY8TAef98dG1u7yQbyzxRfC72X8NbD6Q=;
 b=uVKxtleEv7KEFuvXrNHuRlk57mA0WvyjhYv95+LCnsKm9twY3u9LldD3chgvppU1laUtlR
 RWOniHdINqdivnH7TeaV5BopnQgAhhPn4AuIoNdU83RWFJMCSRd/kvG76PpXzvn6Ed49akAS
 550PEOz8HtiCcW4Jv801WCvH3Tuj040LkofBnTgplWEl81M2Ey4ivwffVHs5Q0jG/ZrUq5yZ
 PQNO8LB4wnmEBIlHEZPOLaq1f2YOmdv16yQ6oEA5bMGlheZqZhAjZSQov34OPgSZn8KbJgMO
 LZFpTwhg1hPnB5I1dekyLzVi36MQg/pGmeB9nlUOSM+p8bk7I1gWZqaw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v7 0/7] Add factory-reset
Date: Tue, 23 Sep 2025 13:52:51 +0200
Message-ID: <20250923115319.335608-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 11:53:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20114

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This adds an new hooks for factory-reset to the
initramfs. This hook will

- format the disk.
- In case of a encrypted disk factory reset the TPM is cleared(all keys
  are deleted)

In case of an encrypted file system the marker hook needs to be stored
in a readable location, e.g. one of the boot partitions or the efi
partition.

Changes v7:
 - reorder patches
 - kconfig add conditions to enable factory reset with disk encryption
 - fix indentation

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
  Factory-reset-helper file is incompatible with encrypt-partitions
  Add factory-reset initramfs hook
  Set PREFERRED_PROVIDER_factory-reset-helper for all machines
  Add settings for factory-reset with a separate home partition
  Add README for factory-reset
  Kconfig: add option for factory-reset

 Kconfig                                       | 16 +++++
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
 27 files changed, 536 insertions(+), 2 deletions(-)
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


