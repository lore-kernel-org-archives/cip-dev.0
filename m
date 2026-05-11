Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF386CD484E
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 05:48:22 +0000 (UTC)
Received: from galois.linutronix.de (galois.linutronix.de [193.142.43.55])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50872.1778507862377351952
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 May 2026 06:57:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linutronix.de header.s=2020 header.b=a+E4A32C;
 dkim=pass header.i=@linutronix.de header.s=2020e header.b=A20zCEQO;
 spf=pass (domain: linutronix.de, ip: 193.142.43.55, mailfrom: bigeasy@linutronix.de)
Date: Mon, 11 May 2026 15:57:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778507860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6d8FfKC0Yl+izW5/o0nt0Md46G+E3YWAdYhngSBqkrk=;
	b=a+E4A32CowX/53TiiOlRsQUpu4/9NCpIm3XI3aXEancpXLAu9F3m+imr+wftvYWQzJBgSe
	5PNWlTJTfFFskLoyqqZF5BH/4XCtQxN99BHTvUnsd/SiWScGqIXDDqSBw0nFY6OLwnWYVh
	JvU3HpBCLhwTb76Rb6+O8myvbzwhHl8QT0xN70kbtarl22vhIoCV6L0mGSX/Ehpw7BCKPF
	SpLpjxy4K5VJxZPPscLyeL5ymYa3sYwmWK4Qe92RKxoob0oKueeWjEnRR5G/LF84keKR9y
	ZBiO0gJbg33KS5KRx/YhhCTm+4lt5tQyAoL4ngl6+sGaFdQVfZkUwkiNdglbTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778507860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6d8FfKC0Yl+izW5/o0nt0Md46G+E3YWAdYhngSBqkrk=;
	b=A20zCEQOWur+3S0Zy4/S9+8mMNe5NQn4XA2Qatzl6/YB64E8c5/41xIXJgj51X4bzRxeow
	wrI/AZl6k2IsHQCQ==
From: Sebastian Siewior <bigeasy@linutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba, Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>
Subject: Re: [RFC][PATCH 6.12.y-cip 00/12] Backport PREEMPT-RT support for ARM 32-bit
Message-ID: <20260511135739.uPbxWz1w@linutronix.de>
References: <cover.1777964226.git.jan.kiszka@siemens.com>
 <071e371c-ef56-4296-a001-0ad992b79bca@siemens.com>
MIME-Version: 1.0
In-Reply-To: <071e371c-ef56-4296-a001-0ad992b79bca@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 May 2026 05:48:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22920

On 2026-05-05 09:02:02 [+0200], Jan Kiszka wrote:
> On 05.05.26 08:56, Jan Kiszka wrote:
> > A first attempt to backport the recently merged ARM 32-bit support of
> > PREEMPT-RT from 7.1 to 6.12-cip. Only lightly tested so far, first of
> > all looking for feedback regarding completeness.
> > 
> > This may also be valuable for 6.12-rt as this series should be able to
> > replace all patches tagged with {ARM:,arm:} in v6.12.79-rt17 - adding
> > Daniel.
> 
> Grrr, CC typos and misconfigurations - at least no overshooting, it seems.
> 
> Daniel, Bryan, lost you on CC for this series.

I made the following:
| ARM: group is_permission_fault() with is_translation_fault()
| ARM: allow __do_kernel_fault() to report execution of memory faults
| ARM: fix hash_name() fault
| ARM: fix branch predictor hardening
up to here for stable

| ARM: ensure interrupts are enabled in __do_user_fault()
| ARM: 9459/1: Disable jump-label on PREEMPT_RT
| ARM: 9463/1: Allow to enable RT
This would go to stable-rt. This does not fix anything !RT as far as I
can tell.

The four patches for stable have been sent.

> Jan

Sebastian

