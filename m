Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCADD5C0DD
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 08:26:13 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17472.1765873563272679398
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 00:26:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=NI+Qi94M;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-202512160826005f0bfc9ee600020730-flagxv@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202512160826005f0bfc9ee600020730
        for <cip-dev@lists.cip-project.org>;
        Tue, 16 Dec 2025 09:26:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=xjR8RfZjFNOFmXLq/lNvlyzcz2sEogCxRZ95pTb/h5U=;
 b=NI+Qi94Mi1haaHx5GuZ5+9JbTwpExbZaNudfinKmjIkezcugxeOWOEJ37acrRPfq09AGNB
 5uykB8mBm6fLTUty69wqkignXQsXlSEpsVLd/ifAp+/2cAQWGJwcEs5kUI9tPoNZfyrCDJjd
 +jY6/S0I9dZ59vFsuUznyQTnB5+BC/EDcXEkskF/0Fr+Nrdce/oA8N6cz0x+H7x8zG/1xrRT
 i/vXnulEHQBFsgElM0lm86H34jDVOjd4rP/Lp92KigOyTI3vHYN5W7kAYFZ7Da2jgmQv3m13
 cV09uCoOJ71gFRBhduqsObx9tYog4XOhmEf/b2ITUwQNbK6T5Fiql7+A==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 0/4] Fixes for Factory-reset
Date: Tue, 16 Dec 2025 09:25:42 +0100
Message-ID: <20251216082559.327416-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 08:26:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21077

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes the issue
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/145.
Changes v3:
 - create tmpfiles on the fly
Changes v2:
 - Add patch to require kernel module efivarfs
 - massage commit message

Quirin Gylstorff (4):
  fix: Add missing efivarfs hook
  fix: initramfs-hook do_prepare_build is executed after do_install
  fix: ensure that the partitions are available
  fix: ensure separate root home dir is recreated after factory-reset

 .../change-root-homedir_0.1.bb                | 15 -----------
 .../change-root-homedir_0.2.bb                | 27 +++++++++++++++++++
 .../files/factory-reset-script.tmpl           | 18 +++++++++++++
 ...bb => initramfs-factory-reset-hook_0.3.bb} | 15 ++++++-----
 4 files changed, 53 insertions(+), 22 deletions(-)
 delete mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.1.bb
 create mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.2.bb
 rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-reset-hook_0.2.bb => initramfs-factory-reset-hook_0.3.bb} (89%)

-- 
2.51.2


