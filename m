Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F20C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 12:25:43 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.7111.1702297533127338928
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 04:25:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=f0glj7jL;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20231211122530bf68dcf881342bf727-tpkpwe@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20231211122530bf68dcf881342bf727
        for <cip-dev@lists.cip-project.org>;
        Mon, 11 Dec 2023 13:25:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=vAco3+SM+2peNgjIf3ZyOKwBGLhOUFaZ0tq/wo+DWdc=;
 b=f0glj7jL7RgXqES+W2tRLXzfdM99KQzt8pbNBP9X7jiqJ8ya0dy8u88uh3TowHHKB7CIvD
 PaAQKHpHhr7R8OxuvUgIXsqiIDQujevWru0kgy01m4TFmHKhofoizKFNPuJkLo5i3ZY2xu6Z
 FD0dNB1Gh3EdA5Dm2TAzlM4wOAXE4=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dec][isar-cip-core][RFC v2 0/3] Add Bootloader to Update binary
Date: Mon, 11 Dec 2023 13:19:18 +0100
Message-ID: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 12:25:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14018

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
Changes v2:
 - The efibootguard file is only added if the new variable `SWU_EBG_UPDATE` equals `1`
 - Add the variable `SWU_EFI_BOOT_DEVICE` to set the device containing
   the efibootguard binary
 - Add the variable `SWU_EXTEND_SW_DESCRIPTION` to all extension of the
   sw-description file
 - use atomic-install to update the binary atomically

Quirin Gylstorff (3):
  efibootguard-efi.py: copy signed ebg binary to DEPLOY_DIR
  swupdate.bbclass: Add SWU_EXTEND_SW_DESCRIPTION
  swupdate: Extend sw-description to update efibootguard

 classes/swupdate.bbclass                      | 47 ++++++++++++++++++-
 recipes-core/images/swu/sw-description.tmpl   |  2 +-
 .../wic/plugins/source/efibootguard-efi.py    | 13 +++++
 3 files changed, 60 insertions(+), 2 deletions(-)

-- 
2.42.0


