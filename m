Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A112CDB483
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 05:59:26 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.200917.1697522359752294813
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Oct 2023 22:59:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=hHiuLaFs;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-202310170559169ad54cb75f26606a07-c4nwwb@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202310170559169ad54cb75f26606a07
        for <cip-dev@lists.cip-project.org>;
        Tue, 17 Oct 2023 07:59:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=+muxlazO+BbDCmSJSxpcGto9C+IuYEATCoGDjSdnhMo=;
 b=hHiuLaFs28vlpQqFKe13Wlh5vBaISSQQdPH8V1JTC/QTY7oyfvDyFert0lTYxc/sEh4rAl
 U9G760CNfIr67cXcTK6qleN7bHoMGaCS2oVq0ylwbUxYJIk7sG8210W4//K9QzCAWxmwFknD
 1UZpA/UNAR5iKs9FIfifBXTF0HxCQ=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 0/2] Isar update
Date: Tue, 17 Oct 2023 07:59:13 +0200
Message-Id: <cover.1697522355.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Oct 2023 05:59:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13400

Late Isar update to bring in its fixes and allow us to model the
dosfstools build more cleanly.

Jan

Jan Kiszka (2):
  Update Isar revision
  dosfstools: Use -native suffix to select the right architecture

 conf/distro/cip-core-common.inc                   | 4 ++--
 kas-cip.yml                                       | 2 +-
 recipes-bsp/edk2/edk2-standalonemm-rpmb_202305.bb | 3 +++
 recipes-devtools/dosfstools/dosfstools_latest.bb  | 3 ---
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.35.3


