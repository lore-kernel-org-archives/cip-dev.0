Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6F2D5B84D
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 16:28:46 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53187.1765816116052731315
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 08:28:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=iJC4xooc;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20251215162832f9cf17e9dc00020794-0joc0y@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20251215162832f9cf17e9dc00020794
        for <cip-dev@lists.cip-project.org>;
        Mon, 15 Dec 2025 17:28:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=e4sSqBy7glMrMHsSryF5JOFSCvYr1YalmlPEdKyolF0=;
 b=iJC4xoocO2lgutiXFotoh7QNgjNmSP9QeuKL8RCOx1Wwsz7rXuICNfjdFTcXYdN3bpwuN3
 pJnE5cP0a6MtBKRhvVY3Ihp05kW0avsbt6MqTQlvrFSE9MwPBls5Y1n/QuhFsmVcXkdvrBlC
 1iZCAK5tB4qdVxwMbcOHvAErsKd/mEtP7yUzqDWo4Uj4kgqm4sg2KZgJSsnWpy5CEQG036tn
 gPXjZOV2rFSGNti5rc8iLlDdZocY1gYUIrxGMF2j9TDvJlsBAs7DgKaR9RGrs1AogrkWtZ8s
 IuC6c3wIy/3EYpAkDHrcdtGyQmRvznRbc0njHgV8MrrQjY+SJ/F7ga+A==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 0/4]  Fixes for Factory-reset
Date: Mon, 15 Dec 2025 17:27:59 +0100
Message-ID: <20251215162823.308471-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 16:28:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21065

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes the issue
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/145.

Changes v2:
 - Add patch to require kernel module efivarfs
 - massage commit message

Quirin Gylstorff (4):
  fix: Add missing efivarfs hook
  fix: initramfs-hook do_prepare_build is executed after do_install
  fix: ensure that the partitions are available
  fix: ensure separate root home dir is recreated after factory-reset

 .../change-root-homedir_0.1.bb                | 15 -----------
 .../change-root-homedir_0.2.bb                | 25 +++++++++++++++++++
 .../files/change-root-homedir.tmpfiles        |  0
 .../files/factory-reset-script.tmpl           | 18 +++++++++++++
 ...bb => initramfs-factory-reset-hook_0.3.bb} | 15 +++++------
 5 files changed, 51 insertions(+), 22 deletions(-)
 delete mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.1.bb
 create mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.2.bb
 create mode 100644 recipes-core/change-root-homedir/files/change-root-homedir.tmpfiles
 rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-reset-hook_0.2.bb => initramfs-factory-reset-hook_0.3.bb} (89%)

-- 
2.51.2


