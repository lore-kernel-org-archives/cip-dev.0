Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5990AC10DC1
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 14:35:38 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.33161.1701873332268194050
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Dec 2023 06:35:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=QPhZTqvb;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20231206143528a376fa979d72178400-qp3glv@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20231206143528a376fa979d72178400
        for <cip-dev@lists.cip-project.org>;
        Wed, 06 Dec 2023 15:35:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=CWGwTXnWxh1ExIrne2T9XZ9v0sOkh1ME3GIrrSnmlo8=;
 b=QPhZTqvbdLAokWG1D48vGrEyZSEK6xqfg+ZxYATS5A9IKpbXmqPlsz9nTLiCF/ATA6gwL1
 WPvn66RwwvgY5XvGu89EIFwqhgcM/QctGTNd0yPgDXaWu+llryXLpMEhh/jo19k1wZ0MhvlV
 VoYcajXv7Ow5RzVC7FabJzc1Qf2y4=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RFC 0/2] Add Bootloader to Update binary
Date: Wed,  6 Dec 2023 15:33:20 +0100
Message-ID: <20231206143528.1900797-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Dec 2023 14:35:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13799

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This series adds the, possible signed, efibootguard binaries to the deploy dir
and adds them to swu file and sw-description to update the bootloader.

The new entry contains following information.
    {
            filename = "boot${SWU_EFI_ARCH}.efi"
            path = "EFI/BOOT/boot${SWU_EFI_ARCH}.efi";
            device = "/dev/disk/by-uuid/4321-DCBA";
            filesystem = "vfat";
            sha256 = "boot${SWU_EFI_ARCH}.efi-sha256";
    });

Should we always update the bootloader or should this be a optional
addition to the swu?

Quirin Gylstorff (2):
  efibootguard-efi.py: copy signed ebg binary to DEPLOY_DIR
  swupdate.bbclass: Add boot<ARCH>.efi to swu

 classes/swupdate.bbclass                       | 18 +++++++++++++++---
 recipes-core/images/swu/sw-description.tmpl    |  7 +++++++
 .../lib/wic/plugins/source/efibootguard-efi.py | 13 +++++++++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

-- 
2.42.0


