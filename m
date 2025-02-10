Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9131DC0219B
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 00:28:42 +0000 (UTC)
Received: from galois.linutronix.de (galois.linutronix.de [193.142.43.55])
 by mx.groups.io with SMTP id smtpd.web11.47385.1739182704900765037
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Feb 2025 02:18:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linutronix.de header.s=2020 header.b=JOlncvx5;
 dkim=pass header.i=@linutronix.de header.s=2020e header.b=lAJmG8ai;
 spf=pass (domain: linutronix.de, ip: 193.142.43.55, mailfrom: bigeasy@linutronix.de)
Date: Mon, 10 Feb 2025 11:18:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739182702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oONuz56ffauYF3gP0eUnBA886a0FrJODrLFYvs7U1Ig=;
	b=JOlncvx5rr2rWhQOyUyuJaQDJ3Kc87n9AxLdVgpg85mVVsRSuvpS18oo2i+EzhXDtx5o9l
	X9BYY2sQ9Fn7pvLm4PrdapzT1iyTSzYibu4OxPE3oGPPRmiMfMJYe0Q8GRnW1jXojazg9Y
	o51FlNl88dS/auoi7sRkIvkAICWEjzkNOeXAxdhuxeSAPIdhHu9CH/E/CP8jBDMXQw8uZm
	e9tEDl5/eD5/mZgKz7ABSo2TjmNBIFm0hdzblu+XWo1gOxP4h1eOVmCWG4xPbH0cv/C78Y
	4fuSsnusUk5Ofa6ftD/lOwAhnDM6AUt8ffPPvkb501Phtd2PpOYr2mYSFJQbZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739182702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oONuz56ffauYF3gP0eUnBA886a0FrJODrLFYvs7U1Ig=;
	b=lAJmG8airbZW1/09009CVPUxyO1FpKLB8cXVjv4WV5CTiHr39O4f1zqwK4K3VqODHtQhY9
	N69kUIM+hYWvZ2CA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: kazuhiro3.hayashi@toshiba.co.jp
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	cip-dev@lists.cip-project.org, tglx@linutronix.de,
	rostedt@goodmis.org, linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: Re: [PATCH 4.4 4.9 v1 2/2] mm: slub: allocate_slab() enables IRQ right after scheduler starts
Message-ID: <20250210101820.lXceJi98@linutronix.de>
References: <1738629964-11977-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
 <1738629964-11977-3-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
 <20250204081813.7qsvLFsU@linutronix.de>
 <TYCPR01MB11385E033624D2D9D93992A95E1F22@TYCPR01MB11385.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TYCPR01MB11385E033624D2D9D93992A95E1F22@TYCPR01MB11385.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Feb 2025 00:28:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17813

On 2025-02-10 07:20:35 [+0000], kazuhiro3.hayashi@toshiba.co.jp wrote:
> Hello,
Hi,

> The question here is whether to insert SYSTEM_SCHEDULING is acceptable
> or not in LTS phase. This addition would change behavior of future fixes
> or out-of-tree codes that check system_state, so adjustments similar to
> the mainline series[2] (2/17 ~ 15/17) are needed for them.
> Can I ask if it's recommended to introduce SYSTEM_SCHEDULING even in LTS?
> It's v4.4-rt specific topic but I think similar discussion is regularly
> happening in newer -rt branches and LTS branches where PREEMPT_RT is merged.

In general I try to have the same code if it is easily possible. A few
examples where this was not the case:
- The printk code, as work is in progress, was never fully backported.
  The changes between kernel versions were small and there was little to
  none user visible changes. However changes under the hood were usually
  big so in general it was not worth the effort.

- scheduling wise, we went from PREEMPT_LAZY to PREEMPT_AUTO to
  LAZY_PREEMPT. Fixes within one implementation went all the way down
  but the implementation as a whole was never backported. PREEMPT_AUTO
  could be considered as half way done but nobody complained about
  something in particular. It was "recently" discussed whether or not to
  backport LAZY_PREEMPT to replace PREEMPT_AUTO in some of the lower
  kernels but the changes required to backport it would be huge because
  the scheduler in particular changed. So this is hard to justify.

What questions can you ask?
- Do you backport code that relies on `system_states' or did so in the
  past?
- Is more likely to backport code from before v4.13 or after? Either way
  you need to look at this.

> Best regards,
> Kazu

Sebastian

