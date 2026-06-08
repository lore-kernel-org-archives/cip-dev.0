Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91232CD8C9D
	for <webhook@archiver.kernel.org>; Mon,  8 Jun 2026 14:29:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.55854.1780928596188411866
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2026 07:23:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=korg header.b=LLaZohXL;
 spf=pass (domain: linuxfoundation.org, ip: 172.234.252.31, mailfrom: gregkh@linuxfoundation.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B95DE42AF9;
	Mon,  8 Jun 2026 14:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0766F1F00893;
	Mon,  8 Jun 2026 14:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780927983;
	bh=vRxLlxgtv49yThNDJjZj+u0T4tKRy5pFjIWLLHPYj04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LLaZohXLdqDt2VDERAmFyjPwBvq+lxTWS/jHUJzlO6uAlmXKEqGVwDnMMaS1bbjMn
	 IhQflL0qdOhSl13g7BtjnIRiKnLAazGLjFcqW860v6+CfWFpWZ2p2x0XPdpPQQhmPW
	 9Q4CBrLI/SILKGZ4KlvQvOwMss0ltbkb/TqjLxiA=
Date: Mon, 8 Jun 2026 16:12:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org, Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 0/4] ARM: stable backports
Message-ID: <2026060832-extortion-cattail-2467@gregkh>
References: <20260511135357.2786242-1-bigeasy@linutronix.de>
 <20260608082818.LZiPJ9ot@linutronix.de>
MIME-Version: 1.0
In-Reply-To: <20260608082818.LZiPJ9ot@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jun 2026 14:29:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23048

On Mon, Jun 08, 2026 at 10:28:18AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-05-11 15:53:53 [+0200], To stable@vger.kernel.org wrote:
> > This is a backport of ARM related fixes. This applies cleanly to v6.18
> > and v6.12. I have an updated batch for v6.6 and v6.1 because this does
> > not apply cleanly.
> > 
> > #1 and #2 are prerequisites for #3.
> > 
> > Can't tell the origin of #3 (fix hash_name() fault). It might be there
> > since the begin of time.
> > 
> > #4 (fix branch predictor hardening) fixes commit f5fe12b1eaee2 ("ARM:
> > spectre-v2: harden user aborts in kernel space") which is v4.20-rc2.
> > 
> > If there are no objections I would post the v6.6 version once this is
> > accepted and then rebase the PREEMPT_RT bits on top of this.
> 
> I noticed that the ARM64 patches I sent recently were picked up and
> backported but this is still waiting.
> 
> I there something I can do to speed things up?

We have hundreds of patches in the backlog right now, these are way down
the list, sorry.  Hope to catch up "soon"...

thanks,

greg k-h

