Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764A2CD343F
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 15:25:42 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42379.1777994734918932724
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 May 2026 08:25:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=HOpGGSLH;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-2026050515253249efdcb072000207d8-ayru8k@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2026050515253249efdcb072000207d8
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 May 2026 17:25:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=uPmY7tmlq+2/SZmxDhODlyrMI9pu+1tVnGahVRCr3OM=;
 b=HOpGGSLHhGo8fX15NKfNSrF0CgQOcera5C4m+OBeHxPs6TgQkVT+2GSiu6hftnT7xa9RFu
 g93m2gTMfK0jAWWwCVD9OEoUE9I07qzgw8hnruyFjYz8xqZGz+0+ECYrcCqbuHRfF+Kaz+4Z
 LBbBktp8IekezSK1Lwln+gL2iqIa7UjFiC1nQfuLjgnpExi+B1/lssG4YhPPm6yNYiKfqBkD
 Z9e5W8P9Lga57AGxLVmP2dlpjQ1mptjulR8XddaF1RJm7HYj1g3U9NykPUDNj/qI79ROnO5Z
 SdGwMdG74DiIgQDDioH5LG6D43Xx0wxweUQKAo46u3hNYbSetVZ9EFJg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 0/3] Isar update, RT config snippet from cip-kernel-configs
Date: Tue,  5 May 2026 17:25:27 +0200
Message-ID: <cover.1777994730.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 15:25:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22885

See patches for details.

Jan

Jan Kiszka (3):
  Update Isar to 1.1-rc2
  linux-cip: Update cip-kernel-config revision
  linux-cip: Switch to out-of-tree PREEMPT-RT config fragment

 kas-cip.yml                                |  2 +-
 recipes-kernel/linux/cip-kernel-config.inc |  4 ++-
 recipes-kernel/linux/files/preempt-rt.cfg  | 30 ----------------------
 recipes-kernel/linux/linux-cip-common.inc  |  9 +++++--
 4 files changed, 11 insertions(+), 34 deletions(-)
 delete mode 100644 recipes-kernel/linux/files/preempt-rt.cfg

-- 
2.47.3


