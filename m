Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81D0CD8C9F
	for <webhook@archiver.kernel.org>; Mon,  8 Jun 2026 09:44:45 +0000 (UTC)
Received: from galois.linutronix.de (galois.linutronix.de [193.142.43.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50112.1780907666055553780
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2026 01:34:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linutronix.de header.s=2020 header.b=rz8/zOdr;
 dkim=pass header.i=@linutronix.de header.s=2020e header.b=O1qFKTiP;
 spf=pass (domain: linutronix.de, ip: 193.142.43.55, mailfrom: bigeasy@linutronix.de)
Date: Mon, 8 Jun 2026 10:28:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780907302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GymDXHQrKOE1WW3FptMLpsrg6sy9q8dGsyj1wiLfiVk=;
	b=rz8/zOdrNI7B/45x+TltDRvnr95beh1kmj8SjtbEo5ri4EKi7WCi7bDtZwQ2biGP0nrZze
	l9hNhKkd9VpzhBOWPVj/FfLx6DwBltm+ikvl068SgWI2dVlCl/Zt0PRF5UdV8A8V5PSBRP
	GwJcvMy5F9ljdnIqwNdWk846Gze1kcnkyjjjHmKHkCICMm64m2W9f5tdqlLe2zG2BOl9KN
	/txqWyq1NIrLcs5Q0B7HvuL+SMAYF2ykudG427F1ycRy9AQQTWGaO7ISjnOkEAAPDmzitX
	fuPB9phA5Aje//1pDld6mLt3NEEmoRMikMT995Onf1P9V4X7EwvsZTAYylTm9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780907302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GymDXHQrKOE1WW3FptMLpsrg6sy9q8dGsyj1wiLfiVk=;
	b=O1qFKTiP2pX+543PW7DktQSn2zg0Z4wgJLe4Ln7XpzTlQGVevPQ1RnjztC67MWf2FhmxeL
	L9O2t42e28U9BIDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: stable@vger.kernel.org
Cc: Bryan Brattlof <bb@ti.com>, Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 0/4] ARM: stable backports
Message-ID: <20260608082818.LZiPJ9ot@linutronix.de>
References: <20260511135357.2786242-1-bigeasy@linutronix.de>
MIME-Version: 1.0
In-Reply-To: <20260511135357.2786242-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jun 2026 09:44:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23047

On 2026-05-11 15:53:53 [+0200], To stable@vger.kernel.org wrote:
> This is a backport of ARM related fixes. This applies cleanly to v6.18
> and v6.12. I have an updated batch for v6.6 and v6.1 because this does
> not apply cleanly.
> 
> #1 and #2 are prerequisites for #3.
> 
> Can't tell the origin of #3 (fix hash_name() fault). It might be there
> since the begin of time.
> 
> #4 (fix branch predictor hardening) fixes commit f5fe12b1eaee2 ("ARM:
> spectre-v2: harden user aborts in kernel space") which is v4.20-rc2.
> 
> If there are no objections I would post the v6.6 version once this is
> accepted and then rebase the PREEMPT_RT bits on top of this.

I noticed that the ARM64 patches I sent recently were picked up and
backported but this is still waiting.

I there something I can do to speed things up?

> Russell King (Oracle) (4):
>   ARM: group is_permission_fault() with is_translation_fault()
>   ARM: allow __do_kernel_fault() to report execution of memory faults
>   ARM: fix hash_name() fault
>   ARM: fix branch predictor hardening
> 
>  arch/arm/mm/alignment.c |   6 ++-
>  arch/arm/mm/fault.c     | 100 ++++++++++++++++++++++++++++++----------
>  2 files changed, 80 insertions(+), 26 deletions(-)

Sebastian

