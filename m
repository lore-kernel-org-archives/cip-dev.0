Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37BDCD98F2
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 14:36:17 +0000 (UTC)
Received: from galois.linutronix.de (galois.linutronix.de [193.142.43.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39925.1782124446004003732
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jun 2026 03:34:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linutronix.de header.s=2020 header.b=3iIq2/jp;
 dkim=pass header.i=@linutronix.de header.s=2020e header.b=d96NQf+w;
 spf=pass (domain: linutronix.de, ip: 193.142.43.55, mailfrom: bigeasy@linutronix.de)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782124013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YXvFuUhlC/+OE4W3ff8nmdCq38KYvqxt0ICsJOWSQeQ=;
	b=3iIq2/jpfKCs6dmDVcQ8W7+XpcJ4uRTb5sT0V1S9xzQUoaxsp2a0ZLl9MGgmzretjgzjsX
	NEUp6jKFf9eKMLzNdeSQohhmQPRRyuzEDNhN+HyQkJqIXs/pamlzhFt10Ym6LNjPda6UoU
	THytOOctXIQkOF6ri5SHhXKnD7WgVRjw5zwf1I+Zo4S5bGuSbYu2r99FJQFiu3MjaqiQDJ
	mQlotuMX9jF5wPEbZLTckvDxZEpz6pzI/sID5++pOhs8vXpG7WCIwGtIkaflBLsBP+cmWr
	V9ZJqVUVjHd4d1Ue1T1o3xhmhLVntBU9FoHxo+ClpEVIpaW1hCkebWIzC146yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782124013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YXvFuUhlC/+OE4W3ff8nmdCq38KYvqxt0ICsJOWSQeQ=;
	b=d96NQf+wLuKxq6Du417kDBLSH6jws2UUp5b+5lwxQ1C1UnocSs7/dRFE1ZYIItFHp8+Cz+
	8UsPY7Q7JdedXVCA==
To: stable@vger.kernel.org
Cc: Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/4] ARM: v6.6 and v6.1 stable backports
Date: Mon, 22 Jun 2026 12:26:30 +0200
Message-ID: <20260622102634.780100-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jun 2026 14:36:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23253

This is a backport of ARM related fixes. This applies cleanly to v6.6
and v6.1. The v6.18 and v6.12 trees already contain this.

I've been looking at v5.15 and it seems there is code missing so I am
not enitrely sure if it makes sense to backport the last two patches of
the series any further than v6.1. Therefore I am stopping here ;)=20

#1 and #2 are prerequisites for #3.=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
Russell King (Oracle) (4):
  ARM: group is_permission_fault() with is_translation_fault()
  ARM: allow __do_kernel_fault() to report execution of memory faults
  ARM: fix hash_name() fault
  ARM: fix branch predictor hardening

 arch/arm/mm/alignment.c |  4 ++
 arch/arm/mm/fault.c     | 94 +++++++++++++++++++++++++++++++----------
 2 files changed, 76 insertions(+), 22 deletions(-)

--=20
2.53.0


