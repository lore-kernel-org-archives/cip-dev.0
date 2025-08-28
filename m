Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59779CA0EED
	for <webhook@archiver.kernel.org>; Thu, 28 Aug 2025 11:07:24 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.18176.1756379236735104588
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Aug 2025 04:07:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=QiLisGVx;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-2025082811071318128602d50002074a-ab7yhs@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025082811071318128602d50002074a
        for <cip-dev@lists.cip-project.org>;
        Thu, 28 Aug 2025 13:07:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=pj4Wj5o3OGYyDcqOsiSiM0OLMWplgMri4l+F6RwblOM=;
 b=QiLisGVxUT5lKM61JKET4bXZXTi13vQkn7N+HWPTQ2592wEZOpoWgiE7bRME4dAJfJZl41
 p+7GPC370ZNCYLOC7GY0EmL1XRjkonFBW49voeo3gkkciSjDVYdXvAedxfZn6V+PN3XuMM+4
 8M2fZEGdJa3GTDltJRsSqEHNeO650v4GeOy12sbko4+gMyx4yyMw8CkWhTVw5TfCTL7vqnAg
 L+ktKpIh5dR9uInPKrygBsELSI7MtkoP7xWYeJdjeneqta9qapHV0vCCAZa+pYnvm9xoP+sT
 +y0GFleCqB6WiyswXmAKHOKjIUeyPxgN65Ps4DnxleGW73vC6Hudn2UQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	gokhan.cetin@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 0/7] Add factory-reset
Date: Thu, 28 Aug 2025 13:06:47 +0200
Message-ID: <20250828110712.392641-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Aug 2025 11:07:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19983

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This adds an new hooks for factory-reset to the
initramfs. This hook will

- format the disk.
- In case of a encrypted disk factory reset the TPM is cleared(all keys
  are deleted)

In case of an encrypted file system the marker hook needs to be stored
in a readable location, e.g. one of the boot partitions or the efi
partition.

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

[1]: https://www.freedesktop.org/software/systemd/man/devel/systemd-factory-reset.html


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
 doc/README.factory-reset.md                   | 22 ++++++
 kas/opt/ebg-swu.yml                           |  4 ++
 kas/opt/encrypt-data.yml                      |  3 +
 kas/opt/separate-home-partition.yml           |  3 +
 .../initramfs-factory-reset-hook/files/hook   |  6 ++
 .../files/local-top                           | 52 ++++++++++++++
 .../files/reset-env.tmpl                      |  2 +
 .../initramfs-factory-reset-hook_0.1.bb       | 38 +++++++++++
 .../factory-reset-helper-efi_0.1.bb           | 22 ++++++
 .../factory-reset-helper-file_0.1.bb          | 18 +++++
 .../factory-reset-helper.inc                  | 34 ++++++++++
 .../files/get-factory-reset-efivar.sh.tmpl    | 42 ++++++++++++
 .../files/get-factory-reset-file.sh.tmpl      | 67 +++++++++++++++++++
 .../files/set-factory-reset-efivar.sh.tmpl    | 60 +++++++++++++++++
 .../files/set-factory-reset-file.sh.tmpl      | 57 ++++++++++++++++
 23 files changed, 446 insertions(+)
 create mode 100644 doc/README.factory-reset.md
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/hook
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


