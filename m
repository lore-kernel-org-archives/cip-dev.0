Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFE9CA1016
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 09:52:39 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.35130.1756979555162904642
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Sep 2025 02:52:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=iKO1o8XX;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-2025090409523174f0e0ea7b0002071e-smjyep@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025090409523174f0e0ea7b0002071e
        for <cip-dev@lists.cip-project.org>;
        Thu, 04 Sep 2025 11:52:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=Nt2kyh0mL8bvvCbxAVzJfWr7EEkea7IIc86JhGLlHBc=;
 b=iKO1o8XXCNBiBhWATNFvQDuaCRv3uBRA0th5J/tRFvHKLcrpOU4eepBAzM+ECC/eJ2CX6o
 LR4kAi1FYXpJthDTIIigYI0TL+om4pMH0U7qg+mB3EKcjQu/zrHTSC9vwwY5Nm8CRVjJBNlS
 sFMAvQjga12QmnHGguky+AeA5LMCI+51o6z0EV5E4WCxE3Zd98DLbG5xCkg7fYnKlo7470b1
 PUO1DhpotooIQdmdJYnkS7pva3jcU0qAS61Jtx/FklczDpIOdv5v91HeuSwtWCUzEcDRh//5
 MOGl4WrDBX5QoMU81STSfiaajn5Nn6zPcFwOBCNqWsxDTe2iKFwtGFFw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v5 0/7] Add factory-reset
Date: Thu,  4 Sep 2025 11:39:23 +0200
Message-ID: <20250904095231.2039819-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Sep 2025 09:52:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20013

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This adds an new hooks for factory-reset to the
initramfs. This hook will

- format the disk.
- In case of a encrypted disk factory reset the TPM is cleared(all keys
  are deleted)

In case of an encrypted file system the marker hook needs to be stored
in a readable location, e.g. one of the boot partitions or the efi
partition.

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
  Add factory-reset information to encrypt-data
  Add settings for factory-reset with a separate home partition
  Add factory-reset option to ebg-swu
  Add Readme for factory-reset

 conf/machine/bbb.conf                         |  1 +
 conf/machine/hihope-rzg2m.conf                |  2 +
 conf/machine/iwg20m.conf                      |  2 +
 conf/machine/qemu-amd64.conf                  |  3 +
 conf/machine/qemu-arm.conf                    |  2 +
 conf/machine/qemu-arm64.conf                  |  2 +
 conf/machine/qemu-riscv64.conf                |  2 +
 conf/machine/x86-uefi.conf                    |  2 +
 doc/README.factory-reset.md                   | 25 +++++++
 kas/opt/ebg-swu.yml                           |  4 ++
 kas/opt/encrypt-data.yml                      |  3 +
 kas/opt/separate-home-partition.yml           |  3 +
 .../initramfs-factory-reset-hook/files/hook   |  6 ++
 .../files/local-bottom                        | 48 +++++++++++++
 .../files/local-top                           | 52 ++++++++++++++
 .../files/reset-env.tmpl                      |  2 +
 .../initramfs-factory-reset-hook_0.1.bb       | 40 +++++++++++
 .../factory-reset-helper-efi_0.1.bb           | 22 ++++++
 .../factory-reset-helper-file_0.1.bb          | 18 +++++
 .../factory-reset-helper.inc                  | 34 ++++++++++
 .../files/get-factory-reset-efivar.sh.tmpl    | 42 ++++++++++++
 .../files/get-factory-reset-file.sh.tmpl      | 67 +++++++++++++++++++
 .../files/set-factory-reset-efivar.sh.tmpl    | 60 +++++++++++++++++
 .../files/set-factory-reset-file.sh.tmpl      | 57 ++++++++++++++++
 24 files changed, 499 insertions(+)
 create mode 100644 doc/README.factory-reset.md
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


