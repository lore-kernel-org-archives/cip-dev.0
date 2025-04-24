Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425A2C369D1
	for <webhook@archiver.kernel.org>; Thu, 24 Apr 2025 09:23:13 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.11128.1745486587309978027
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Apr 2025 02:23:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=X2+Zjh9P;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-202504240923031acc7339cbfb509eb8-fq25ye@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202504240923031acc7339cbfb509eb8
        for <cip-dev@lists.cip-project.org>;
        Thu, 24 Apr 2025 11:23:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=TdXJurlc/+x6LO3woHazO0fk0e1fu8IZ+aPw9XrzHlw=;
 b=X2+Zjh9PY8UJ+rt+YMFbuAvr8iHFVrV0MdBKx6E4TC6u2QOJgtuOz0edBcCe4anf943TVE
 xLByO/+mR/uJLg5XEQKIY03cYG/P05FD0zYt+5LLEfl2aR63BjANugGF8IHdVllC87hc7Y6l
 4tcqpk06xscFW42RalpQpCAgdjxG1x08KWvv2HeH16w8WXPZOi49GP/mkPqjr0PP+EdNo9A+
 XiNzWOKNuJNit2LS5kccixw5g2+HWgQdWc3iIPlExlulr3h1Xc+I2TMW+3xarftK9hysjym4
 sCkRDru65UIvGiFCe+x9QwsSesf4Yx0jm8Y97nW9w8fJ/l9NrxodlH3g==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [PATCH 0/2] Add data-reset to initramfs
Date: Thu, 24 Apr 2025 11:22:20 +0200
Message-ID: <20250424092302.2066773-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Apr 2025 09:23:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18596

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This adds an initramfs hook to delete all data from the persistent
partitions.

This will reset the device identity `/etc/machine-id` and all
other information stored in the overlay.


I didn't call it factory-reset as it does not clean the encrypted
data partition. This would require:
- deleting all TPM data
- reformatting the encrypted partitions

Also it does not delete snapshots from btrfs or similar devices.


Quirin Gylstorff (2):
  initramfs: add hook for data-reset
  add data-reset hook to cip-core-initramfs

 .../cip-core-initramfs/cip-core-initramfs.bb  |  1 +
 .../files/local-bottom-complete.tmpl          | 76 +++++++++++++++++++
 .../initramfs-data-reset-hook_0.1.bb          | 36 +++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom-complete.tmpl
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/initramfs-data-reset-hook_0.1.bb

-- 
2.47.0


