Return-Path: <benedikt.niedermayr@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E91EC01BB
	for <webhook@archiver.kernel.org>; Mon, 23 Mar 2026 10:10:41 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13657.1774260639150309631
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Mar 2026 03:10:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=benedikt.niedermayr@siemens.com header.s=fm1 header.b=FUc1Z0rO;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1323861-20260323101036fc41ee04c0000207f6-q38_s4@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260323101036fc41ee04c0000207f6
        for <cip-dev@lists.cip-project.org>;
        Mon, 23 Mar 2026 11:10:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=benedikt.niedermayr@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=U0/iJHkZbltP4/lowVPPA5KxUZkA8wL493PkIbkN4Fo=;
 b=FUc1Z0rOQWfCv9Ae9lsjokxtma1TXQLyO1n+vZia5Q2c3PYpZgk5MORNNPC0x8Nw9etGxk
 Wlb9Ml7KJL3eXA73bJ1fFq+A+ZSyM+Y08Cftkn7G4G53yy1yR9meHmGokCbQIuIVV2xgKGvS
 lHmzoZJLIQrHPytbmgOVi25ih4Nao27Zt0+DScfzfZZqphpnI61sQqYQfh/l/Mhi05vlIzjZ
 R6LTY1SijWhXQu3BWWcqqgIhkgMtH10rNAR9vywwRrGIE6MScNmGFCnFcyj7cDicRf2Sx3RX
 yazhljwlqgDrddSFUgvuq00i/B2S0wwzTng4kq7NboSN1RYwwpq5xhNw==;
From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [PATCH v3 0/1] start-qemu: allow more variable injections
Date: Mon, 23 Mar 2026 11:10:27 +0100
Message-ID: <20260323101035.3269968-1-benedikt.niedermayr@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1323861:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Mar 2026 10:10:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22525

- Fixed wrong variable name DATA_ENCRYPTION -> IMAGE_DATA_ENCRYPTION

Benedikt Niedermayr (1):
  start-qemu: allow more variable injections

 start-qemu.sh | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

--
2.43.0

