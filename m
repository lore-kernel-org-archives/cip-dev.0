Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFFFCEDDB0
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 15:10:41 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14662.1763478634000927268
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Nov 2025 07:10:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=FEW+7p4V;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-2025111815103171081f381e000207c6-h4exq7@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025111815103171081f381e000207c6
        for <cip-dev@lists.cip-project.org>;
        Tue, 18 Nov 2025 16:10:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=WW4nYtkQ71g9fHPiyEWKk3G6bPkRiqvg8dSldY5GQrQ=;
 b=FEW+7p4V6EeSIZB8SZjUwefqn+Ls8PvmSQoNljNp/4ZxYS1HDp0/K5uHfSuhakaMIaLhCA
 B8/DGFy8KyfDO/SAQhPxXYKNY8SiwTLrNp5pPwQklnp6c7BM1zQRvQOrrUz9uWTjulpHi2Wk
 qEct92PF8FpnbUAhwFhP4xMGCU6OHeb2jk6r7wffvIb8qu4n9Hw61IZIPBLudJFXVyP72TuS
 U3/EcfUjXm3BA7xGmJq2lzaeMf+iv6s/GLZ9qwmpnLwSb+iSQC0T36gvkdZRzlhCPMn3Q9bX
 b8jSn6T2nRuQRHe5bWiVUPkt9HeBEZEk4YSLLcT16bfVm1o5Vnr/SRBA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 0/5] De-duplicate code
Date: Tue, 18 Nov 2025 15:14:43 +0100
Message-ID: <20251118151030.504765-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Nov 2025 15:10:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20615

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This series de-duplicates:
- the code between the initramfs-abrootfs-hook and initramfs-verity-hook.
- the code between local-top and local-bottom in initramfs-tools

It also adds a fix for the mcom device with trixie.

Changes v2:
 - format code
 - use symbolic link instead of copy
 - fix spelling
 - add empty function find_root_via_image_uuid to be overridden

Quirin Gylstorff (5):
  Add cip-functions to initramfs
  initramfs-abrootfs-hook: Use initramfs-cip-functions
  initramfs-verity-hook: Use initramfs-cip-functions
  initramfs-factory-reset: de-duplicate code between local-top and
    local-bottom
  initramfs-crypt-hook: Scan if all request partitions are available

 .../files/local-top-complete                  | 53 +++-----------
 ..._0.2.bb => initramfs-abrootfs-hook_0.3.bb} |  3 +-
 .../files/cip-initramfs-functions             | 72 +++++++++++++++++++
 .../initramfs-cip-functions_0.1.bb            | 22 ++++++
 .../files/local-top-complete                  | 19 +++++
 ...ok_0.9.bb => initramfs-crypt-hook_0.10.bb} |  5 +-
 .../{local-top => factory-reset-script.tmpl}  | 18 +++--
 .../files/local-bottom                        | 48 -------------
 ...bb => initramfs-factory-reset-hook_0.2.bb} | 18 +++--
 .../files/local-top-complete.tmpl             | 55 +++-----------
 ...ok_0.2.bb => initramfs-verity-hook_0.3.bb} |  3 +-
 11 files changed, 166 insertions(+), 150 deletions(-)
 rename recipes-initramfs/initramfs-abrootfs-hook/{initramfs-abrootfs-hook_0.2.bb => initramfs-abrootfs-hook_0.3.bb} (79%)
 create mode 100644 recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
 create mode 100644 recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.9.bb => initramfs-crypt-hook_0.10.bb} (98%)
 rename recipes-initramfs/initramfs-factory-reset-hook/files/{local-top => factory-reset-script.tmpl} (70%)
 delete mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom
 rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-reset-hook_0.1.bb => initramfs-factory-reset-hook_0.2.bb} (62%)
 rename recipes-initramfs/initramfs-verity-hook/{initramfs-verity-hook_0.2.bb => initramfs-verity-hook_0.3.bb} (85%)

-- 
2.51.2


