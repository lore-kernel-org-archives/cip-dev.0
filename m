Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8F4D5B170
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 09:37:33 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44698.1765791450456960581
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 01:37:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=AVkv4oFY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20251215093727f61fe7f43800020773-_b1hqd@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20251215093727f61fe7f43800020773
        for <cip-dev@lists.cip-project.org>;
        Mon, 15 Dec 2025 10:37:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=UDQxljAsuIOwtDe29QyITjaJmZ/9r3kufRu7JwC/ZPg=;
 b=AVkv4oFYLrv4i44aDlhaFkODWL58Ct7hruG+BChiWys2Emhi2BOuEZ7+U5ep5zQcTWByNv
 tFI1+INU3Bs77DyAUm4mWBaahaaRqpw1xM7mRkbA+3bMSwcE6pfF0+DinjX3dIt1YiNNlrLa
 /fUJzmL5HYTJP9SX9dWuZQJ+BPnIUKdDs+FR28HWr3VZfmA6hOWgzc9C5pjs1OP3kVWsGonv
 GzKfOmlCdez60E7zIgvfjoHunOgkyYKH2ftCkweyNofGp53aLH+Vcw0Dj/ayYmbvLJVWFC0I
 rVWSHmQd95SDtQbaEvqAFl32skANV+z2WExIVV5BrwEhUTlCOuatBHHg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 0/3] Fixes for Factory-reset
Date: Mon, 15 Dec 2025 10:35:51 +0100
Message-ID: <20251215093719.323668-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 09:37:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21035

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes the issue
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/145.

The following kernel config fix is necessary:
https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_requests/152

Quirin Gylstorff (3):
  fix: initramfs-hook do_prepare_build is executed after do_install
  fix: ensure that the partitions are available
  fix: ensure separate root home dir is recreated after factory-reset

 .../change-root-homedir_0.1.bb                | 15 -----------
 .../change-root-homedir_0.2.bb                | 25 +++++++++++++++++++
 .../files/change-root-homedir.tmpfiles        |  0
 .../files/factory-reset-script.tmpl           | 18 +++++++++++++
 ...bb => initramfs-factory-reset-hook_0.3.bb} | 15 ++++++-----
 5 files changed, 50 insertions(+), 23 deletions(-)
 delete mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.1.bb
 create mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.2.bb
 create mode 100644 recipes-core/change-root-homedir/files/change-root-homedir.tmpfiles
 rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-reset-hook_0.2.bb => initramfs-factory-reset-hook_0.3.bb} (91%)

-- 
2.51.2


