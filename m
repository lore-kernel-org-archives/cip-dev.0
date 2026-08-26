Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68D4C61DD3
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 05:42:07 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6253.1787722924432641761
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2026 22:42:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=YUUJFmXI;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20260826054201b4d3103e790002079c-nr_0u9@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260826054201b4d3103e790002079c
        for <cip-dev@lists.cip-project.org>;
        Wed, 26 Aug 2026 07:42:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=tGIlWEOZFtYI/EfFSoBJyM45HDL+l7oWO9Phb4QEizo=;
 b=YUUJFmXIDm7D8H4x45fqusKk60WOfZV/Q6vmybS7xQpVeXQrZosenSIoWGNCCIJ/NTdh8H
 pPXXDy+ts/E58YFvI6UM+OI5YYKttUcA3qqSCQKLFz3YktgB6i29UEqMDnGZlzRwYaV78IIX
 MNnpvWtGuugXyFC5jijJ0UflxPihwlyU6AIZ6F9FpZzAOP4oR7hAcIY93wk6wOwijOh7X5OT
 zlgsBPNsVM93wmvdEGVlQFJNxwaKPI2FhA8LtipUtmhROux0jz1SUJxkgV9AvVwwXk6daV3r
 WB6SvoQSKltlxRoIJE06UNBB6QGeeWn5qkXhHcuUvRoVQhfewUwxlRuw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 0/7] Provide measured boot via fTPM for arm64, early deploy EFI keys
Date: Wed, 26 Aug 2026 07:41:38 +0200
Message-ID: <cover.1787722904.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 05:42:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24008

Due to some deficits in U-Boot, the fTPM was not recognized and, thus,
its PCRs for measurements were not fed. This led to the disk encryption
key we are storing in the TPM not being sealed properly. Existing
deployments were most likely not affected by this when they locked down
U-Boot to only boot in secure mode (like we did and continue to do).

After fixing this, we are confronted with a practical problem: The QEMU
target for arm64 is set up without pre-deployed UEFI keys. When we now,
with working measurements, switch to secure boot after the initial disk
encryption, unsealing the key will no longer work.

For this but possibly also for other scenarios, the series adds an
initramfs hook which tries to deploy the secure boot keys if the target
is in non-secure mode and no other keys are deployed yet.

With all that in place, we change the policy of the disk encryption
hook to only perform its task when the device is securely booted. If
this should break valid downstream scenarios, we may make it opt-out
later on, but so far none are imaginable.

Jan

Jan Kiszka (7):
  secure-boot-efi-keys: Add recipe to create EFI keys
  cip-initramfs-functions: Add secure_boot_enabled helper
  cip-core-initramfs: Automatically deploy secure boot keys on first
    boot
  u-boot: Add patches to enable measured boot with fTPM
  u-boot: Refactor ftpm-stmm.cfg to enable measured boot for all
  u-boot: Drop obsolete config workaround
  initramfs-crypt-hook: Prevent encryption without secure boot

 ...ement-Fix-compilation-for-non-sandbo.patch |  43 +++++
 ...-out-service-enumeration-and-binding.patch |  95 +++++++++++
 ...pport-for-enumerating-services-that-.patch | 155 ++++++++++++++++++
 ...-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch |  33 ++++
 ...to-optee-after-a-successful-mmc_init.patch |  41 +++++
 ...-MMC-Device-not-found-a-debug-output.patch |  50 ++++++
 recipes-bsp/u-boot/files/ftpm-stmm.cfg        |   7 +-
 recipes-bsp/u-boot/files/qemu-extra.cfg       |   2 +
 recipes-bsp/u-boot/files/secure-boot.cfg      |   2 -
 recipes-bsp/u-boot/files/ti-extra.cfg         |   8 +-
 recipes-bsp/u-boot/u-boot-common-2026.01.inc  |   6 +
 .../single-key-to-efi-keys_0.1.bb             |  41 +++++
 .../cip-core-initramfs/cip-core-initramfs.bb  |   1 +
 .../files/cip-initramfs-functions             |  16 ++
 .../files/local-top-complete                  |   4 +
 .../initramfs-sbkeys-hook/files/hook          |  16 ++
 .../initramfs-sbkeys-hook/files/local-top     |  34 ++++
 .../initramfs-sbkeys-hook/files/mount-stub    |  13 ++
 .../initramfs-sbkeys-hook_0.1.bb              |  32 ++++
 19 files changed, 589 insertions(+), 10 deletions(-)
 create mode 100644 recipes-bsp/u-boot/files/0001-test-boot-measurement-Fix-compilation-for-non-sandbo.patch
 create mode 100644 recipes-bsp/u-boot/files/0002-tee-optee-Factor-out-service-enumeration-and-binding.patch
 create mode 100644 recipes-bsp/u-boot/files/0003-tee-optee-Add-support-for-enumerating-services-that-.patch
 create mode 100644 recipes-bsp/u-boot/files/0004-tee-optee-Do-not-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch
 create mode 100644 recipes-bsp/u-boot/files/0005-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch
 create mode 100644 recipes-bsp/u-boot/files/0006-mmc-Make-MMC-Device-not-found-a-debug-output.patch
 create mode 100644 recipes-devtools/secure-boot-efi-keys/single-key-to-efi-keys_0.1.bb
 create mode 100644 recipes-initramfs/initramfs-sbkeys-hook/files/hook
 create mode 100644 recipes-initramfs/initramfs-sbkeys-hook/files/local-top
 create mode 100755 recipes-initramfs/initramfs-sbkeys-hook/files/mount-stub
 create mode 100644 recipes-initramfs/initramfs-sbkeys-hook/initramfs-sbkeys-hook_0.1.bb

-- 
2.47.3


