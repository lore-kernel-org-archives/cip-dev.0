Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAD9C87FDA
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 12:00:50 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.60288.1753963247619436321
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Jul 2025 05:00:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=OOeq1YBg;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-2025073112004423f9b4dd1fb7c4ac18-o7hukh@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2025073112004423f9b4dd1fb7c4ac18
        for <cip-dev@lists.cip-project.org>;
        Thu, 31 Jul 2025 14:00:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=eJb9GG+MBg48x+5cYBWKnS1H3v0A4yG82FfsDdCql3w=;
 b=OOeq1YBgl5HiTvweOrCaRHsIqZwqoUtOhCFHAEwmW3K/pO7y1Xq6BKBbgtm0T1JWI5reIJ
 WfceU7uIqh7e4vwAYkRoTnVWggyiiZgvM0IVpQfwY+8qyRGAVYf1c04qKgqNQ1CN0gZSk56Z
 VNdE7m5DAjomgh4mUwd0VHaJsXu3C/yTHqyeffVFEoyhfVbmTS8OPMXgjgzjyI7zx2wLPmnG
 gK9/OZ7uHOdEm0HQEFkHngEwUieZJ+Q1j7UqjZuJnJQ4DhiLQojoCuIeuYYpNJpL0KgNCXos
 R2o57mC/3Abr86Tx3qJZ1hKlAr7J9aMd4nNDZIpsIOGEISEw4jmGZpUQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	gokhan.cetin@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 0/7] Add factory-reset
Date: Thu, 31 Jul 2025 13:58:39 +0200
Message-ID: <20250731120043.333345-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 12:00:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19642

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

So finally I had time to post this update.

This adds an new hooks for factory-reset to the
initramfs. This hook will

- format the disk.
- In case of a encrypted disk factory reset the TPM is cleared(all keys
  are deleted)

In case of an encrypted file system the marker hook needs to be stored
in a readable location, e.g. one of the boot partitions or the efi
partition.


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
  add factory-reset-helper to set the marker file
  Set preferred_provider_factory-reset-helper for all machines
  add factory-reset initramfs hook
  encrypt-data.yml: Add factory-reset information to encrypt-data
  cip-core-image: add factory-reset helper
  add factory-reset to initramfs
  Add settings for factory-reset with a separate home partition

 conf/machine/bbb.conf                         |  1 +
 conf/machine/hihope-rzg2m.conf                |  2 +
 conf/machine/iwg20m.conf                      |  2 +
 conf/machine/qemu-amd64.conf                  |  3 +
 conf/machine/qemu-arm.conf                    |  2 +
 conf/machine/qemu-arm64.conf                  |  2 +
 conf/machine/qemu-riscv64.conf                |  2 +
 conf/machine/x86-uefi.conf                    |  2 +
 kas/opt/encrypt-data.yml                      |  3 +
 kas/opt/separate-home-partition.yml           |  3 +
 recipes-core/images/cip-core-image.bb         |  2 +-
 .../cip-core-initramfs/cip-core-initramfs.bb  |  1 +
 .../files/detect-marker-file                  | 14 +++++
 .../initramfs-factory-reset-hook/files/hook   |  7 +++
 .../files/local-top                           | 53 ++++++++++++++++
 .../files/reset-env.tmpl                      |  2 +
 .../initramfs-factory-reset-hook_0.1.bb       | 46 ++++++++++++++
 .../factory-reset-helper-efi_0.1.bb           | 22 +++++++
 .../factory-reset-helper-file_0.1.bb          | 18 ++++++
 .../factory-reset-helper.inc                  | 34 +++++++++++
 .../files/get-factory-reset-efivar.sh.tmpl    | 25 ++++++++
 .../files/get-factory-reset-file.sh.tmpl      | 45 ++++++++++++++
 .../files/set-factory-reset-efivar.sh.tmpl    | 60 +++++++++++++++++++
 .../files/set-factory-reset-file.sh.tmpl      | 57 ++++++++++++++++++
 24 files changed, 407 insertions(+), 1 deletion(-)
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/detect-marker-file
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


