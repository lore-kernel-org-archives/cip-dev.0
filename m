Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE83C47DA7
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 20:00:26 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.2406.1705003220478505251
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jan 2024 12:00:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=E0BZ6Ccn;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-202401112000165683be426725891487-x449et@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202401112000165683be426725891487
        for <cip-dev@lists.cip-project.org>;
        Thu, 11 Jan 2024 21:00:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=BRC915gzUe210pYn9Z1FoO6laJTJ3/6wel6HipUGw6s=;
 b=E0BZ6CcnTPri2u7EYqGHAW/aX+NLdbtRz77xR+XQsdMku1siM0PKb1SCRNKpF4UmA43mID
 /VT4v9vPjy0AoRkML1/OD6zt4Xrhui6CSSxt0xhZQ7oQlLJ2dGntxm7rnFwSMg6GeCeUa5dR
 irN6IE+P4r9zeY/7Jtz9i0dfMUSVs=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 0/7] Add Bootloader to sw-description
Date: Thu, 11 Jan 2024 20:59:44 +0100
Message-ID: <20240111200015.190376-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 20:00:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14342

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This series adds the, possible signed, efibootguard binaries to the deploy dir
and adds them to swu file and sw-description to update the bootloader.

The new entry contains following information:
{
           filename = "{efi_boot_loader_file}";
           path = "EFI/BOOT/{efi_boot_loader_file}";
           device = "{efi_boot_device}";
           filesystem = "vfat";
           sha256 = "{efi_boot_loader_file}-sha256";
           properties: {
                atomic-install = "true";
           };
}
Changes v5:
 - Add efibootguard section to README.swupdate.md
 - remove whitespace
 - Move variable EFI_ARCH and EFI_LIB_ARCH to correct patch

Changes v4:
  - Rebase to latest next
  - Remove the generator for sw-description -> if requested this can be
    added as a new patchset
  - Add new class containing the efibootguard specific settings
  - Add variable EFI_ARCH and EFI_LIB_ARCH to reduces dupilicated code
  - Generate a additional swu only for the bootloader. This will be
    always generated. If the bootloader should be added to the
    <rootfs>.swu the variable SWU_EBG_UPDATE needs to be set.

Changes v3:
 - Add Generator for sw-description instead of using a template for
   Debian 11+.

Changes v2:
 - The efibootguard file is only added if the new variable `SWU_EBG_UPDATE` equals `1`
 - Add the variable `SWU_EFI_BOOT_DEVICE` to set the device containing
   the efibootguard binary
 - Add the variable `SWU_EXTEND_SW_DESCRIPTION` to all extension of the
   sw-description file
 - use atomic-install to update the binary atomically


Quirin Gylstorff (7):
  Move efibootguard specific settings from include to class file
  efibootguard.bbclass: Add functions to generate the EFI_ARCH and
    EFI_LIB_ARCH
  efibootguard-efi.py: copy signed ebg binary to DEPLOY_DIR
  swupdate.bbclass: Add SWU_EXTEND_SW_DESCRIPTION
  swupdate: Extend sw-description to update efibootguard
  classes/swupdate: Generate swu containing only efibootguard
  doc/README.swupdate.md: add new section for bootloader updates

 classes/efibootguard.bbclass                  |  42 +++++
 classes/swupdate.bbclass                      | 143 +++++++++++++-----
 doc/README.swupdate.md                        |  13 ++
 recipes-core/images/efibootguard.inc          |   9 +-
 .../images/swu/sw-description-ebg.tmpl        |  17 +++
 recipes-core/images/swu/sw-description.tmpl   |   2 +-
 .../wic/plugins/source/efibootguard-boot.py   |  29 ++--
 .../wic/plugins/source/efibootguard-efi.py    |  50 +++---
 8 files changed, 222 insertions(+), 83 deletions(-)
 create mode 100644 classes/efibootguard.bbclass
 create mode 100644 recipes-core/images/swu/sw-description-ebg.tmpl

-- 
2.43.0


