Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B834CD484E
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 05:48:42 +0000 (UTC)
Received: from galois.linutronix.de (galois.linutronix.de [193.142.43.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50618.1778508195763243873
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 May 2026 07:03:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linutronix.de header.s=2020 header.b=jOQvoowK;
 dkim=pass header.i=@linutronix.de header.s=2020e header.b=FuLTK+aX;
 spf=pass (domain: linutronix.de, ip: 193.142.43.55, mailfrom: bigeasy@linutronix.de)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778507646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zzr4Se1oURXIlnB24qCxYuS0qvjtQ0uCFxwLbMmBOtA=;
	b=jOQvoowKXaPF/dw593lSbuEdeaWrcF1RuAxImCNkdedmXI2L+f6Sctz1DCgnYmRilsqgGT
	OgTmi54I0iQtYNGFi+DyNrEn16o4gdS5xzAohFsT9Ei8vA2KRO++iWhuEfqd15Cdybz3fd
	JWZTLtHs3DQrUvfNQnZwf3dl+iuQCDHhnusP0aKsZv71+chAjPk1tsNuZPL0OZEm22puk0
	SEXhTOcEff12lEUL1HwRzsJJ0FkqHruz49eTH5fql+7XYN7caLJbtgJv5fKJxy3X/+oiUb
	EadlE040JpXtjT41fCXSCmvmUYyOZD8VLkEMYiwCXPd2t3fUrheNeMQXH4c4rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778507646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zzr4Se1oURXIlnB24qCxYuS0qvjtQ0uCFxwLbMmBOtA=;
	b=FuLTK+aXFQea/hN54W3mxpZBMJAgGNJJtevmbaH7OCNSlZrX749XlzzP929Nji2bQ5ri9D
	4Q7LAANv6YFey0Dw==
To: stable@vger.kernel.org
Cc: Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/4] ARM: stable backports
Date: Mon, 11 May 2026 15:53:53 +0200
Message-ID: <20260511135357.2786242-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 May 2026 05:48:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22923

This is a backport of ARM related fixes. This applies cleanly to v6.18
and v6.12. I have an updated batch for v6.6 and v6.1 because this does
not apply cleanly.

#1 and #2 are prerequisites for #3.

Can't tell the origin of #3 (fix hash_name() fault). It might be there
since the begin of time.

#4 (fix branch predictor hardening) fixes commit f5fe12b1eaee2 ("ARM:
spectre-v2: harden user aborts in kernel space") which is v4.20-rc2.

If there are no objections I would post the v6.6 version once this is
accepted and then rebase the PREEMPT_RT bits on top of this.

Russell King (Oracle) (4):
  ARM: group is_permission_fault() with is_translation_fault()
  ARM: allow __do_kernel_fault() to report execution of memory faults
  ARM: fix hash_name() fault
  ARM: fix branch predictor hardening

 arch/arm/mm/alignment.c |   6 ++-
 arch/arm/mm/fault.c     | 100 ++++++++++++++++++++++++++++++----------
 2 files changed, 80 insertions(+), 26 deletions(-)

--=20
2.53.0


