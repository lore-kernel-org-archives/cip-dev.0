Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8744DCAC5B3
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 06:00:36 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.4685.1758780028669628255
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Sep 2025 23:00:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=O6ovFpMV;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202509250600237328b94c30000207a7-p5s17i@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202509250600237328b94c30000207a7
        for <cip-dev@lists.cip-project.org>;
        Thu, 25 Sep 2025 08:00:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=4o8ldxtZBtvbIzbUGi7p+XNEoP/OOuqY7XRTNp2u7NY=;
 b=O6ovFpMVwVCJaJlyN1YKleNUcA1tigVt7MnKvCy1N3O6niBo0X9xM9DRG6qLwaiSzv1Xs8
 7vD0UjjY29qu22T2XImRdc1vktkxZ6hzbKn9ORwFr086nBA7GaoH/KyhaReDSDDOdaSAiG/8
 1o5mHOspt0/H4XqZyV36Oc/7nuzg6J42zmy7XOOzlFuS95Je75jnJndnFloilMxMnsTZh9jE
 kylUq6hqBm6wlLOkoXcohILne3Auzoi9tYdBpTgAI5PeouiwSYbPd1ALJo5zoE98qW7UJbRl
 h7IRGbvkxn3qDUmoqkYpWVMxf8MtGeNMgvFQ5tdvItFXcjXVflvFyGjg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v8 0/8]  Add factory-reset
Date: Thu, 25 Sep 2025 07:59:12 +0200
Message-ID: <20250925060009.1711605-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Sep 2025 06:00:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20129

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This adds an new hooks for factory-reset to the
initramfs. This hook will

- format the disk.
- In case of a encrypted disk factory reset the TPM is cleared(all keys
  are deleted)

In case of an encrypted file system the marker hook needs to be stored
in a readable location, e.g. one of the boot partitions or the efi
partition.

Changes v8:
 - build qemu-amd64 with factory-reset
 - check incompability after fetch

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

Quirin Gylstorff (8):
  Add factory-reset-helper to set the Marker correctly
  Factory-reset-helper file is incompatible with encrypt-partitions
  Add factory-reset initramfs hook
  Set PREFERRED_PROVIDER_factory-reset-helper for all machines
  Add settings for factory-reset with a separate home partition
  Add README for factory-reset
  Kconfig: add option for factory-reset
  ci: Add factory-reset to qemu-amd64

 .gitlab-ci.yml                                |  3 +
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
 .../factory-reset-helper-file_0.1.bb          | 25 +++++++
 .../factory-reset-helper.inc                  | 35 ++++++++++
 .../files/get-factory-reset-efivar.sh.tmpl    | 40 ++++++++++++
 .../files/get-factory-reset-file.sh.tmpl      | 65 +++++++++++++++++++
 .../files/set-factory-reset-efivar.sh.tmpl    | 59 +++++++++++++++++
 .../files/set-factory-reset-file.sh.tmpl      | 56 ++++++++++++++++
 28 files changed, 540 insertions(+), 2 deletions(-)
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
2.51.0


