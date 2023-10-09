Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6D9E95A96
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 11:56:59 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.59158.1696852455356440690
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Oct 2023 04:54:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=dFBKwPjT;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-72506-202310091154119583dabf474c2e488c-tlpsgg@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202310091154119583dabf474c2e488c
        for <cip-dev@lists.cip-project.org>;
        Mon, 09 Oct 2023 13:54:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=zPpuHYIf4DXztICwaXzRUNdkBXlJQcwD+93frEMMeqI=;
 b=dFBKwPjTYUJn9/G6d7T7AVwilBeIA1SCgwiI1DgF7UI/LxbwBtJVlc/cWp0C8vADiJLkcb
 hLSXKFVCxIrLWDKWjaHcu+oxJEdN+JrP/SuEJXfCXPuW8qconbER04EBKQZFDNzaNHmya9VF
 +UB/lXvYD5HVTWB2kbrE+LsdyAnFY=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v3 0/2] make compatible with latest ISAR revision
Date: Mon,  9 Oct 2023 19:53:42 +0800
Message-Id: <20231009115344.746642-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Oct 2023 11:56:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13318

This series adapts the imager parts of cip-core to the new schroot-based
imaging in ISAR. This change is required to make it compatible with the latest
master branch of ISAR. Finally, the ISAR version is bumped.

Changes since v2:

- fix permission issue in squashfs creation
  (leading to unnoticed empty /etc/shadow file)

Changes since v1:

- rebased against current next
- squashed all commits into one (atomic)
- fixed missing task dep in OVMF deploy

Best regards,
Felix Moessbauer

Felix Moessbauer (2):
  make method to find /var mount configurable
  update ISAR to latest version on master branch

 classes/swupdate.bbclass                             |  5 +++--
 kas-cip.yml                                          |  2 +-
 recipes-core/images/deploy-ovmf.inc                  | 10 ++++++----
 .../initramfs-overlay-hook/files/overlay.script.tmpl | 12 ++++++------
 .../initramfs-overlay-hook_0.1.bb                    |  5 +++--
 5 files changed, 19 insertions(+), 15 deletions(-)

-- 
2.39.2


