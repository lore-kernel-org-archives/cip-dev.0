Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935E8C47077
	for <webhook@archiver.kernel.org>; Fri, 29 Dec 2023 12:31:26 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.145899.1703853077130185611
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Dec 2023 04:31:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=DgnpaC1h;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20231229123113a0e7f23f038d4ee227-jbpro3@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20231229123113a0e7f23f038d4ee227
        for <cip-dev@lists.cip-project.org>;
        Fri, 29 Dec 2023 13:31:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=xu1KVWXGzJZKWUv5S+nqt45X2yxP3kII5YeANQQvI7c=;
 b=DgnpaC1h6Gf2RnEMQ1MfAx2R5k5erdnOZJBEUqCnYGHoqhdh3AFiEvr1dpDZQFZgfH5RUX
 7y8YUuUuuwmv7RctyZVdPiANcC8bDCwc9Z1Zevz2+fKGD4Lkze1z/rCZnDU0ve6ahbajNTdb
 bEJToj/+9UHgrQtK0eRaZbVJA2jAg=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RFC v3 0/5] Add Bootloader to sw-description
Date: Fri, 29 Dec 2023 13:30:38 +0100
Message-ID: <20231229123111.400555-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Dec 2023 12:31:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14218

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
                atomic-install = true;
           };
}

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


Quirin Gylstorff (5):
  efibootguard-efi.py: copy signed ebg binary to DEPLOY_DIR
  swupdate.bbclass: Add SWU_EXTEND_SW_DESCRIPTION
  swupdate: Extend sw-description to update efibootguard
  classes: Generate sw-description from bitbake variables
  images/swupdate.inc: Add variables to generate the sw-description

Quirin Gylstorff (5):
  efibootguard-efi.py: copy signed ebg binary to DEPLOY_DIR
  swupdate.bbclass: Add SWU_EXTEND_SW_DESCRIPTION
  swupdate: Extend sw-description to update efibootguard
  classes: Generate sw-description from bitbake variables
  images/swupdate.inc: Add variables to generate the sw-description

 classes/sw-description-generator.bbclass      | 200 ++++++++++++++++++
 classes/swupdate.bbclass                      |  52 ++++-
 recipes-core/images/swu/sw-description.tmpl   |   2 +-
 recipes-core/images/swupdate.inc              |  27 +++
 .../jsontolibconf/files/jsontolibconf         |  54 +++++
 .../jsontolibconf/jsontolibconf_0.1.bb        |  22 ++
 .../wic/plugins/source/efibootguard-efi.py    |  13 ++
 7 files changed, 368 insertions(+), 2 deletions(-)
 create mode 100644 classes/sw-description-generator.bbclass
 create mode 100644 recipes-devtools/jsontolibconf/files/jsontolibconf
 create mode 100644 recipes-devtools/jsontolibconf/jsontolibconf_0.1.bb

-- 
2.43.0


