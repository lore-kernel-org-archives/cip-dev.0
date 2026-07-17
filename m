Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E789BC44515
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 13:43:39 +0000 (UTC)
Received: from galois.linutronix.de (galois.linutronix.de [193.142.43.55])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14403.1784297020405821491
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 07:03:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linutronix.de header.s=2020 header.b=RSxDbeYI;
 dkim=pass header.i=@linutronix.de header.s=2020e header.b=Hezjdiuw;
 spf=pass (domain: linutronix.de, ip: 193.142.43.55, mailfrom: bigeasy@linutronix.de)
Date: Fri, 17 Jul 2026 16:03:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784297018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DP2iy+ioqHgCIiplFvIzL+zbcFThYsfYVuaPlRYUhE0=;
	b=RSxDbeYIJ+NacPdMnNiZPtOhklqTZPEzTX45+YG6IQ3Ui3h8jeJPZvFmB5511aYZP5cGai
	a1xmMHJ0PaG6Fkn2guVKsI3LWPPAHFd//FKRHAY98c5NhZBcedX59yo6DKL9hRrLyCj3OX
	33l4Ow4mtD8jJLN9K234rzBiSt1gcKfqqemGKvlAQa1cBiUWsBoc7CsKn4GsS29XLjANRj
	LFLDPDhQQL9C/Kh8eTnuaUBw0KBio6Udicw++YH/sU4nfuSSVbDll3JS+AtL1slBoouDN0
	cjyOJD/WIzRElAKTpr7E6TuUBDaUg2319xBkewcPlnR4Ar8Q3Lk3FqWrZWtCXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784297018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DP2iy+ioqHgCIiplFvIzL+zbcFThYsfYVuaPlRYUhE0=;
	b=HezjdiuwRN1KXos2T+401yi5jeHUtVijJoo0Pq8R8Bn+BTeftJ0d3kCFAOi1Cfybj+kZvL
	ldBPuFVoWiWJSjCQ==
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To: Daniel Wagner <wagi@monom.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba, stable-rt@vger.kernel.org,
	cip-dev@lists.cip-project.org
Subject: Re: v6.12-rt arm updates
Message-ID: <20260717140336.krBy6oQT@linutronix.de>
References: <8a0f6ad1-0df7-4707-bcc4-83603cada945@monom.org>
 <20260717134624._f9g97lg@linutronix.de>
 <141ef3cb-361d-432c-a7ba-af010406283c@monom.org>
MIME-Version: 1.0
In-Reply-To: <141ef3cb-361d-432c-a7ba-af010406283c@monom.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 13:43:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23683

On 2026-07-17 13:54:58 [+0000], Daniel Wagner wrote:
> >> # Commits in upstream but not in v6.12-stable
> >> ARM__enable_irq_in_translation_section_permission_fault_handlers.patch
> >> #  59e4f3b45b96 ("ARM: ensure interrupts are enabled in __do_user_fault()")
> 
> I've replaced the downstream patch with the commit mentioned...
> > You should be able to drop a few of those and replace them with what I
> > have in v6.18
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-6.18.y-rt-patches&id=73c8e8d7a75fcc8b9026385e64990f3d5ec8a40d	
> 
> ... which is what you have done here as well. The main difference is 
> that v6.12-stable ships 'ARM: 9459/1: Disable jump-label on PREEMPT_RT'

It does? Not as of v6.12.95.

> The resulting v6.12-rt queue is
> 
> 0001-ARM-ensure-interrupts-are-enabled-in-__do_user_fault.patch

This looks like 59e4f3b45b96a ("ARM: ensure interrupts are enabled in __do_user_fault()")

Good.

> 0001-ARM-vfp-Provide-vfp_state_hold-for-VFP-locking.patch
> 0002-ARM-vfp-Use-vfp_state_hold-in-vfp_sync_hwstate.patch
> 0003-ARM-vfp-Use-vfp_state_hold-in-vfp_support_entry.patch
> 0004-ARM-vfp-Move-sending-signals-outside-of-vfp_state_ho.patch
> ARM__Allow_to_enable_RT.patch

Sebastian

