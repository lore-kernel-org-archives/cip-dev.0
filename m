Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA99C0218F
	for <webhook@archiver.kernel.org>; Tue,  4 Feb 2025 09:04:46 +0000 (UTC)
Received: from galois.linutronix.de (galois.linutronix.de [193.142.43.55])
 by mx.groups.io with SMTP id smtpd.web10.111610.1738657097792805065
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Feb 2025 00:18:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linutronix.de header.s=2020 header.b=tbjYr4/4;
 dkim=pass header.i=@linutronix.de header.s=2020e header.b=NmZRulOG;
 spf=pass (domain: linutronix.de, ip: 193.142.43.55, mailfrom: bigeasy@linutronix.de)
Date: Tue, 4 Feb 2025 09:18:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738657095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E/o4cd1+sS1V8YVI6C37SoZJBCljbNtuj8oie5yQkUQ=;
	b=tbjYr4/4eQo//S+bpmmMk45KwHZAXZON1bPv+Ppb0wA7UF+nr0LWMW5+N4n2x3t23/08sh
	bRUJz1GlYvjfEEJmWcJzdbiWtZlxtagDkFUc7JJWsbGWeHkV7QcFp20ZKpzF2UbM6xT55o
	30ydTlrkp2a3ygYemNTw1tNCk3uNE66PFhKnCIESMqDkfNnTrKtYETnGjsFa41sCb1x2wm
	d6P5jSlC4hHa0JuFfoQC0mJJqh66nmYO/WUJRDJhpLT4lm8jvlDdq+0WyQIyGW2F5jEPNW
	X96ft+kOaj48xreegCAd7LX4Ch85wUp6lUDqpJVmvACc3iSW0EZu8kQnr206Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738657095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E/o4cd1+sS1V8YVI6C37SoZJBCljbNtuj8oie5yQkUQ=;
	b=NmZRulOGoc4wQzv0gG2ye7TpghyQedqNYfTOsZQhuydD+5x32vLPMGVq5QMSOLBhhtCFWS
	KFqtexfiILjfuxDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	cip-dev@lists.cip-project.org, tglx@linutronix.de,
	rostedt@goodmis.org, linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: Re: [PATCH 4.4 4.9 v1 2/2] mm: slub: allocate_slab() enables IRQ right after scheduler starts
Message-ID: <20250204081813.7qsvLFsU@linutronix.de>
References: <1738629964-11977-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
 <1738629964-11977-3-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
MIME-Version: 1.0
In-Reply-To: <1738629964-11977-3-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Feb 2025 09:04:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17744

On 2025-02-04 09:46:04 [+0900], Kazuhiro Hayashi wrote:
> On PREEMPT_RT kernels < v4.14-rt, after __slab_alloc() disables
> IRQ with local_irq_save(), allocate_slab() is responsible for
> re-enabling IRQ only under the specific conditions:
> 
> (1) gfpflags_allow_blocking(flags) OR
> (2) system_state == SYSTEM_RUNNING
>
> The problem happens when (1) is false AND system_state == SYSTEM_BOOTING,
> caused by the following scenario:
> 
> 1. Some kernel codes invokes the allocator without __GFP_DIRECT_RECLAIM
>    bit (i.e. blocking not allowed) while SYSTEM_BOOTING
> 2. allocate_slab() calls the following functions with IRQ disabled
> 3. buffered_rmqueue() invokes local_[spin_]lock_irqsave(pa_lock) which
>    might call schedule() and enable IRQ, if it failed to get pa_lock
> 4. The migrate_disable counter, which is not intended to be updated with
>    IRQs disabled, is accidentally updated after schedule() then
>    migrate_enable() raises WARN_ON_ONCE(p->migrate_disable <= 0)
> 5. The unpin_current_cpu() WARNING is raised eventually because the
>    refcount counter is linked to the migrate_disable counter

I think the problem is that system_state _is_ SYSTEM_BOOTING but
scheduling and/or an additional CPU is already enabled. This is why the
lock is contended. Otherwise you wouldn't get that far. 

> The behavior 2-5 above has been obsereved[1] using ftrace.
> The condition (2) above intends to make the memory allocator fully
> preemptible on PREEMPT_RT kernels[2], so the lock function in the
> step 3 above should work if SYSTEM_RUNNING but not if SYSTEM_BOOTING.
> 
> [How this is resolved in newer RT kernels]
> 
> A patch series in the mainline (v4.13) introduces SYSTEM_SCHEDULING[3].
> On top of this, v4.14-rt (6cec8467) changes the condition (2) above:
> 
> -	if (system_state == SYSTEM_RUNNING)
> +	if (system_state > SYSTEM_BOOTING)
> 
> This avoids the problem by enabling IRQ after SYSTEM_SCHEULDING.

Yes. Once scheduling is enabled any sleeping lock might be contended so
interrupts must be enabled. This is not done done unconditionally
because early boot code expects to run with disabled interrupts.
This "system_state == SYSTEM_RUNNING" looked like a sane state in
between. However, once the scheduler is up and running, interrupts in
the system are enabled and so the slub allocator needs to always enable
interrupts.

> Thus, the conditions that allocate_slab() enables IRQ are like:
> 
> (2)system_state   v4.9-rt or before  v4.14-rt or later
> SYSTEM_BOOTING        (1)==true          (1)==true
>                           :                  :
>                           :                  v
> SYSTEM_SCHEDULING         : < Problem      Always
>                           v < occurs here    |
> SYSTEM_RUNNING          Always               |
>                           |                  |
>                           v                  v
> 
> [How this patch works]
> 
> An simple option would be to backport the series[3], which is possible
> and has been verified[4]. However, that series pulls functional
> changes like SYSTEM_SCHEDULING and adjustments for it,
> early might_sleep() and smp_processor_id() supports, etc.
> Therefore, this patch uses an extra (but not mainline) flag
> "system_scheduling" provided by the prior patch instead of
> introducing SYSTEM_SCHEDULING, then uses the same condition as
> newer RT kernels in allocate_slab().

The proposal looks okay. However the verified upstream version not only
addresses your issue but also makes smp_processor_id() and might_sleep()
work in the early phase. I would prefer the upstream solution for those
two reasons.

Sebastian

