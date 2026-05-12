Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E52CD4F26
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 08:56:03 +0000 (UTC)
Received: from galois.linutronix.de (galois.linutronix.de [193.142.43.55])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.69863.1778567827037504472
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 May 2026 23:37:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linutronix.de header.s=2020 header.b=feLxX+Rg;
 dkim=pass header.i=@linutronix.de header.s=2020e header.b=RXMpDsh3;
 spf=pass (domain: linutronix.de, ip: 193.142.43.55, mailfrom: bigeasy@linutronix.de)
Date: Tue, 12 May 2026 08:37:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778567824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2L+IjQkE8PtCGZ/1FJe8/x5WRqoZFSzS2acFnTwwPl4=;
	b=feLxX+RgX91h9nSxWzcNsjc4+2yoEPyMU/XLgy+qvTmglHFXZxRvO0V6baTsvIOme6sB85
	80Yvza9juJP84va0BzO49byu86O+feYgqUAEcB667xpmxYcIjI0sPqf+/xS5ViF5SoJF3W
	aYT1qj5Dq09kmTpX+0WxI/gexzzF+y5RxLK/GW0DqnlwC9u3QF21KOfQscBL+FCsdbL9nu
	NN9yztUw1XwaUlsQJyds/0B1TMnrrRRqld2Me9NRLmMGYrI9Cz2QlUDNKPopbbncLEztZN
	4e348Avf+F6ijUG9F5dwiNimI1YaEGnf2+nJTGylErvfxfmDUMVtNzepWuWaFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778567824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2L+IjQkE8PtCGZ/1FJe8/x5WRqoZFSzS2acFnTwwPl4=;
	b=RXMpDsh3HADTxCRHfLTYzPodoyAu+pfqUjdK3E0Fh7jRF20H8i+hxIgXyRIgqhIv+2tVa6
	w/uUqJCyQ7uBLjDw==
From: Sebastian Siewior <bigeasy@linutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba, Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>
Subject: Re: [RFC][PATCH 6.12.y-cip 00/12] Backport PREEMPT-RT support for ARM 32-bit
Message-ID: <20260512063703.aRyfXa5N@linutronix.de>
References: <cover.1777964226.git.jan.kiszka@siemens.com>
 <071e371c-ef56-4296-a001-0ad992b79bca@siemens.com>
 <20260511135739.uPbxWz1w@linutronix.de>
 <f3936f46-549c-425a-bd58-c60705be5c21@siemens.com>
MIME-Version: 1.0
In-Reply-To: <f3936f46-549c-425a-bd58-c60705be5c21@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 May 2026 08:56:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22928

On 2026-05-11 18:26:18 [+0200], Jan Kiszka wrote:
> > | ARM: ensure interrupts are enabled in __do_user_fault()
> > | ARM: 9459/1: Disable jump-label on PREEMPT_RT
> > | ARM: 9463/1: Allow to enable RT
> > This would go to stable-rt. This does not fix anything !RT as far as I
> > can tell.
> > 
> 
> Ok, then they would be equivalently relevant for 6.12-cip

Once it goes via stable, I throw it at the stable pile to ease their
rebase on top stable.

> > The four patches for stable have been sent.
> > 
> 
> 12-7 = 5. One is "Allow to enable RT", obviously needed in stable-rt and
> -cip then as well. What about the other 4? Not needed in a backport?

I dropped from your queue:

| ARM: move vmalloc() lazy-page table population
| ARM: move is_permission_fault() and is_translation_fault() to fault.h
| ARM: use BIT() and GENMASK() for fault status register fields
| ARM: move FSR fault status definitions before fsr_fs()
| ARM: provide individual is_translation_fault() and is_permission_fault()

as far as I can tell, it is just shuffling code around. Not strictly
needed for the backport. The "grouping" patch that I sent stable@ is
also moving code around but the following "fix" needs the forward
declaration so it goes in as a requirement.
I don't see the need for these.

> Thanks so far already!
> Jan

Sebastian

