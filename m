Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399CFC0218B
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 13:22:53 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.11709.1737724970578318632
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 05:22:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=dP3PlhwH;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20250124132247e8785ecff91b3d23ed-wgt2ge@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250124132247e8785ecff91b3d23ed
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jan 2025 14:22:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=oI6BY0clmT9sl7BRvVacTUTk0lalmog4UW6WGLyARL0=;
 b=dP3PlhwHWZsvryZAbXs1PElTDkeW3etUnf1fuN/4yK3O6H8Z03WyocJc5I50qKVtg8PS+G
 X4LFw4z4eI3y+rdFfAbBMRj/E98bHmfS+0yaZ4d5whniSz44cGifMeJA64CZuPxZm1zYMY/H
 +pzpcf8CzTn+AR2lCQqpyBE+EmEMLyDv2HyBCkLf0hwBI4zHrcWbWiNxBBQtDPCxBobJ0tVh
 1Wd+gug3WqWZ9/LFstLikHWOy8YK+sF/Tpw7by+/YaLLIFIs09Pz31+7fbOQ3AFqnBTDLnzM
 HSOX1Fyw3EuObTwA0IWchQDW47mn/ovKnDJb5qZ2RAgYCseh0elT+XaA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: Sai.Sathujoda@toshiba-tsip.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 0/3] Security testing with MTDA
Date: Fri, 24 Jan 2025 14:22:18 +0100
Message-ID: <20250124132246.64738-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 13:22:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17657

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patch set builds an image to test IEC on the mcom device with
secure-boot and disk encryption enable.

Changes v2:
 - move curl to kas/opt/test.yml
 - add test option to gitlab-ci.yml
 - rename disable_watchdog to watchdog

Quirin Gylstorff (3):
  build x86-uefi with secure boot
  x86-uefi: disable watchdog for testing on mcom
  customizations-security: add curl to download LAVA overlay

 .gitlab-ci.yml               | 13 +++++++++++++
 kas/opt/disable-watchdog.yml | 15 +++++++++++++++
 kas/opt/test.yml             |  3 +++
 3 files changed, 31 insertions(+)
 create mode 100644 kas/opt/disable-watchdog.yml

-- 
2.47.0


