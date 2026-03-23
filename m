Return-Path: <benedikt.niedermayr@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D96DEC01B4
	for <webhook@archiver.kernel.org>; Mon, 23 Mar 2026 10:16:01 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13745.1774260951479935917
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Mar 2026 03:15:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=benedikt.niedermayr@siemens.com header.s=fm1 header.b=B4Z9XeWT;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-1323861-20260323101548696e6fb75c000207b6-8nv_t_@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260323101548696e6fb75c000207b6
        for <cip-dev@lists.cip-project.org>;
        Mon, 23 Mar 2026 11:15:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=benedikt.niedermayr@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=Zwup87N30qctcV3UzAjyarJYUkP2uUFMQHoA9J//ZHc=;
 b=B4Z9XeWTZ+lQ0ldbXic1DbvmlzxyxTorpFVXXRs6YHXaER6hzlOky/7YIwlQD1sVk1HFE/
 0W4X0yI6yVFx300CY/JPmBuqG2hCbWWO6yxAwhN35LSwXa1DKp65EGRn9Pxe0eTbeSW/I6CZ
 HRf2c6zHSVDr0UB+i8Z5Hvl7GY/g1p8iqhNn8+RLnJx9f0tJbiLqj6Q7YjVQh4i7k7N56Fxi
 7EXb4oi4WQtlWQHJd22cbatnde56bBJgoJ6VIEOlRiByBdkszP5MXkPxMToNlvH7jsZWLz2c
 8bs/SS6OLHhWtDiKfztoU3qkgG4X2VrY5pw1xaJ4vHldAVsIo/5Mp1PA==;
From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH v3 0/1] start-qemu: allow more variable
Date: Mon, 23 Mar 2026 11:15:44 +0100
Message-ID: <20260323101546.3273376-1-benedikt.niedermayr@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1323861:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Mar 2026 10:16:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22528

Reposting this with proper subject now

Changes since v2:
- Fixed variable name DATA_ENCRYPTION -> IMAGE_DATA_ENCRYPTION

Benedikt Niedermayr (1):
  start-qemu: allow more variable injections

 start-qemu.sh | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

--
2.43.0

