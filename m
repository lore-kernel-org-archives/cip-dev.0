Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6342CC61DC2
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 15:21:10 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15246.1787757660393772326
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 08:21:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=X1rVV4+C;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-202608261520571f5fdaabeb0002075c-yjx95o@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202608261520571f5fdaabeb0002075c
        for <cip-dev@lists.cip-project.org>;
        Wed, 26 Aug 2026 17:20:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ECc1dDO1vip8mwJ1F849c7OogrxTfDDFwrMfQAimsAc=;
 b=X1rVV4+Cb3SRP4fouKGC1F/oDkt0o7wWSMu6T8nY1BPJdjhGGewkq6Ba3EAYs42WOprivR
 ak5jdOjzdR0U3/NxhPjpiF7+vTqaBCdoYovcDL+b0iMEbAEDJT+b/fw1IXpRinEHkHOaPdYZ
 PaAyyYVN/xrWM81OHiQuKS2Z+g+I7lLp5Zxi9fJtkdlNlezeY3V0g4LJhszwLEDFZUFF5Kc3
 dlVwq4mY7e94GGAwYOMUZGFc6MiM4Cxsh1v/l2VN/LXX0IM40FZyoycILlWpYsnAf76kajeB
 x0AUbC+UguUIzPwM/5nIOtM6WkZmA0PFotRh1HQYlvZOPlaLnbq5AvEQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2 0/7] Provide measured boot via fTPM for arm64, early deploy EFI certificates
Date: Wed, 26 Aug 2026 17:20:48 +0200
Message-ID: <cover.1787757655.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 15:21:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24028

Due to some deficits in U-Boot, the fTPM was not recognized and, thus,
its PCRs for measurements were not fed. This led to the disk encryption
key we are storing in the TPM not being sealed properly. Existing
deployments were most likely not affected by this when they locked down
U-Boot to only boot in secure mode (like we did and continue to do).

After fixing this, we are confronted with a practical problem: The QEMU
target for arm64 is set up without pre-deployed UEFI certificates. When
we now, with working measurements, switch to secure boot after the
initial disk encryption, unsealing the key will no longer work.

For this but possibly also for other scenarios, the series adds an
initramfs hook which tries to deploy the secure boot certs if the target
is in non-secure mode and no other certs are deployed yet.

With all that in place, we change the policy of the disk encryption
hook to only perform its task when the device is securely booted. If
this should break valid downstream scenarios, we may make it opt-out
later on, but so far none are imaginable.

Changes in v2:
 - general renaming "EFI keys" -> "EFI certs"

Jan

Jan Kiszka (7):
  secure-boot-efi-keys: Add recipe to create EFI certificates
  cip-initramfs-functions: Add secure_boot_enabled helper
  cip-core-initramfs: Automatically deploy EFI secure boot certificates
    on first boot
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
 .../single-key-to-efi-certs_0.1.bb            |  41 +++++
 .../cip-core-initramfs/cip-core-initramfs.bb  |   1 +
 .../files/cip-initramfs-functions             |  16 ++
 .../files/local-top-complete                  |   4 +
 .../initramfs-sbcerts-hook/files/hook         |  16 ++
 .../initramfs-sbcerts-hook/files/local-top    |  34 ++++
 .../initramfs-sbcerts-hook/files/mount-stub   |  13 ++
 .../initramfs-sbcerts-hook_0.1.bb             |  32 ++++
 19 files changed, 589 insertions(+), 10 deletions(-)
 create mode 100644 recipes-bsp/u-boot/files/0001-test-boot-measurement-Fix-compilation-for-non-sandbo.patch
 create mode 100644 recipes-bsp/u-boot/files/0002-tee-optee-Factor-out-service-enumeration-and-binding.patch
 create mode 100644 recipes-bsp/u-boot/files/0003-tee-optee-Add-support-for-enumerating-services-that-.patch
 create mode 100644 recipes-bsp/u-boot/files/0004-tee-optee-Do-not-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch
 create mode 100644 recipes-bsp/u-boot/files/0005-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch
 create mode 100644 recipes-bsp/u-boot/files/0006-mmc-Make-MMC-Device-not-found-a-debug-output.patch
 create mode 100644 recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
 create mode 100644 recipes-initramfs/initramfs-sbcerts-hook/files/hook
 create mode 100644 recipes-initramfs/initramfs-sbcerts-hook/files/local-top
 create mode 100755 recipes-initramfs/initramfs-sbcerts-hook/files/mount-stub
 create mode 100644 recipes-initramfs/initramfs-sbcerts-hook/initramfs-sbcerts-hook_0.1.bb

-- 
2.47.3


