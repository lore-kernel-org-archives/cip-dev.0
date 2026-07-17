Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55B1C4452A
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 13:43:49 +0000 (UTC)
Received: from galois.linutronix.de (galois.linutronix.de [193.142.43.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14700.1784298133973551776
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 07:22:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linutronix.de header.s=2020 header.b=0r8TN4DZ;
 dkim=pass header.i=@linutronix.de header.s=2020e header.b=x1pxkntP;
 spf=pass (domain: linutronix.de, ip: 193.142.43.55, mailfrom: bigeasy@linutronix.de)
Date: Fri, 17 Jul 2026 16:22:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784298131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e83lJnaZX4/+AdvTSdSIoeXVY9ifGj/RLgipoOnIiWI=;
	b=0r8TN4DZPqnJsn9AB1Qg27Gu6MPqbi53in9Vk3jKV+YhCvP+O7hkFdVMcgMmRKTCD4HbBp
	z9+/riggw221pccNt/pdkU8TdpG0DojprpN0ogBOBxqy7iap+Z6dS4LXKu8Uh3kBtwBFl+
	8lwspqdpCn2P8PdcaWeQtQoltY+qg980tnsdjB2eqysrF06dc+DyA5RGBNtzDUj0EeHzv/
	dgo1DwQDJ+q6VDsZ8p3lY9C8NVFPHrwW8Nns06OBHi2CZGKEx0BNwP3vnYsziSng1fbe1j
	oZaYWyvxqYWMO2iU3mlBfvizzWhi3pCIa8wy39qJgA/qL/ktNjXMjsDzBujFaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784298131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e83lJnaZX4/+AdvTSdSIoeXVY9ifGj/RLgipoOnIiWI=;
	b=x1pxkntPasYwRPe4RuNArDcm4dvlJvL/ulbzK9tj5+gju0WjfCqTh6b0THqf87OQr5jbna
	Xh5NiKYr0/h9tBCQ==
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To: Daniel Wagner <wagi@monom.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba, stable-rt@vger.kernel.org,
	cip-dev@lists.cip-project.org
Subject: Re: v6.12-rt arm updates
Message-ID: <20260717142210._ukh1yBD@linutronix.de>
References: <8a0f6ad1-0df7-4707-bcc4-83603cada945@monom.org>
 <20260717134624._f9g97lg@linutronix.de>
 <141ef3cb-361d-432c-a7ba-af010406283c@monom.org>
 <20260717140336.krBy6oQT@linutronix.de>
 <3706c5f1-53af-460e-9409-fa1b78706645@monom.org>
MIME-Version: 1.0
In-Reply-To: <3706c5f1-53af-460e-9409-fa1b78706645@monom.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 13:43:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23685

On 2026-07-17 14:17:54 [+0000], Daniel Wagner wrote:
> So here my updated queue (the comment points to the upstream
> version of the patch):

This looks okay. Your delta should be
	https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/diff/?h=linux-6.18.y-rt&id=868deefc37dfbdfe93d760155e0c84f5f3363cc2&id2=90a16cd5d693a75843b766d0efa17f1bc0149931

Sebastian

