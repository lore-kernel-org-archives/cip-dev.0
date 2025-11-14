Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A5FCE7AEE
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:20:09 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15638.1763119206428731460
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 03:20:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=XK7oLMXl;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20251114112002a2f1a9fb750002071b-rhupi3@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20251114112002a2f1a9fb750002071b
        for <cip-dev@lists.cip-project.org>;
        Fri, 14 Nov 2025 12:20:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=xYSbeNwc427WJYQYa+49NpYhiHKi+UvMELimy/gXNe8=;
 b=XK7oLMXlERIT3AyFo+V2nXPS2rbaLVClN7UtbB5D3pirSpC30ohiFK6cxseQh1oM6SAYy1
 kURQFC5vDTWxHcCDbdLsFIvteCzEAKVMQPQSDc/mL60jujTXtlLAASWPFlJ1OwT2rcQ/JTDh
 kKsYQi6Lg1LHW+sc4dgEoGni2UiJAjRSL8gsi46tETEz83fYXCBF6I8TJWMyTO1cbQ6Oz7CH
 wT/FHyz29DTlcYTolsjVP4hgGvSNILHUx2b6n00JAkg0Baxig5DROCuUdnsLYOXCWwD15WsV
 Ky6La9hxKkSJvT5w+ocRUtgtZ+Ejuw81eJlrE7DQXcv68UueH/XFSNvQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 0/5] De-duplicate code
Date: Fri, 14 Nov 2025 12:17:39 +0100
Message-ID: <20251114111925.903740-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 11:20:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20554

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This series de-duplicates:
- the code between the initramfs-abrootfs-hook and initramfs-verity-hook.
- the code between local-top and local-bottom in initramfs-tools

It also adds a fix for the mcom device with trixie.

Quirin Gylstorff (5):
  Add cip-functions to initramfs
  initramfs-abrootfs-hook: Use initramfs-cip-functions
  initramfs-verity-hook: Use initramfs-cip-functions
  initramfs-factory-reset: de-duplicate code between local-top and
    local-bottom
  initramfs-crypt-hook: Scan if all request partitions are available

 .../files/local-top-complete                  | 53 +++-----------
 ..._0.2.bb => initramfs-abrootfs-hook_0.3.bb} |  3 +-
 .../files/cip-initramfs-functions             | 69 +++++++++++++++++++
 .../initramfs-cip-functions_0.1.bb            | 20 ++++++
 .../files/local-top-complete                  | 18 ++++-
 ...ok_0.9.bb => initramfs-crypt-hook_0.10.bb} |  5 +-
 .../{local-top => factory-reset-script.tmpl}  | 18 +++--
 .../files/local-bottom                        | 48 -------------
 ...bb => initramfs-factory-reset-hook_0.2.bb} | 18 +++--
 .../files/local-top-complete.tmpl             | 55 +++------------
 ...ok_0.2.bb => initramfs-verity-hook_0.3.bb} |  3 +-
 11 files changed, 159 insertions(+), 151 deletions(-)
 rename recipes-initramfs/initramfs-abrootfs-hook/{initramfs-abrootfs-hook_0.2.bb => initramfs-abrootfs-hook_0.3.bb} (79%)
 create mode 100644 recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
 create mode 100644 recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.9.bb => initramfs-crypt-hook_0.10.bb} (98%)
 rename recipes-initramfs/initramfs-factory-reset-hook/files/{local-top => factory-reset-script.tmpl} (70%)
 delete mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom
 rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-reset-hook_0.1.bb => initramfs-factory-reset-hook_0.2.bb} (63%)
 rename recipes-initramfs/initramfs-verity-hook/{initramfs-verity-hook_0.2.bb => initramfs-verity-hook_0.3.bb} (85%)

-- 
2.51.0


