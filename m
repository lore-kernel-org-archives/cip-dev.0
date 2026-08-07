Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28907C5AC82
	for <webhook@archiver.kernel.org>; Fri,  7 Aug 2026 15:45:07 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45355.1786117503671045111
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Aug 2026 08:45:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=ebVsoSiu;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1330684-2026080715450036fbfcc57400020737-o48mpt@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026080715450036fbfcc57400020737
        for <cip-dev@lists.cip-project.org>;
        Fri, 07 Aug 2026 17:45:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=g0RmZ9T7BKzmPBDwQKzvOKMVCFn8UJr2G5gTZuyAKc8=;
 b=ebVsoSiumlWlAHwriBv900paK2HWTBThiwWaFoiKODpWvuW4TsdS0ZFqG/Td139dKOGb22
 Rwm2eCZO3REUAIp9szRbdvraaOB7u77RtsI7eGcaP/TGR0Jl5MG6AtCKL0KgNZV1nwRPPcxr
 TVrhIdITZLRjkeyqVF6NsnaOTMWrUqA34cAk5la9JvsKO0XlSMAHfcrMxcmCaUTkohJflsLc
 DJU94/5X8yFQurUzchLzeF48cD3BoUDaR91hhNFfy6wzOWOH7U75aM/n97F5d130Zwbqbun9
 8gNbxXUeeiynNx3JoIRt94JTO/kMD+J5S5QuipYnRFrZeWIcWrgamkXg==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 0/2] Remove unsupported combinations for factory-reset from Kconfig and document them explicitly
Date: Fri,  7 Aug 2026 17:44:37 +0200
Message-ID: <20260807154439.625212-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Aug 2026 15:45:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23875

From: Alexander Heinisch <alexander.heinisch@siemens.com>

By default factory reset clears the tpm. Therefore, keys needed to
decrypt the immutable A/B rootfs in full disk encryption setups
cannot be retrieved anymore. Thus, the boot fails and the device
cannot be recovered.

This patch series removes such combination from the kconfig and documents
the issue explicitly.

Alexander Heinisch (2):
  doc/README.factory-reset: Explicitly document full disk encryption is
    not supported with factory reset tpm clearing enabled.
  Kconfig: Do not offer factory reset with full disk encryption enabled.

 Kconfig                     | 2 +-
 doc/README.factory-reset.md | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--
2.47.3


