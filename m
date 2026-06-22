Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA02CD98F2
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 14:36:37 +0000 (UTC)
Received: from galois.linutronix.de (galois.linutronix.de [193.142.43.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39927.1782124446058826683
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jun 2026 03:34:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linutronix.de header.s=2020 header.b=KS17N/yh;
 dkim=pass header.i=@linutronix.de header.s=2020e header.b=CtJOklFL;
 spf=pass (domain: linutronix.de, ip: 193.142.43.55, mailfrom: bigeasy@linutronix.de)
Date: Mon, 22 Jun 2026 12:27:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782124072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s038YWIfUpBDCuiGtkkXVvM91k1d45bdU4KObnsKNTM=;
	b=KS17N/yhtGlAEzPY9GYkkf37vknNhhW/F4aOPJHWgOO5QoLg+Kdo+kjJ5n5Vdi01oQlScr
	vX7gqadVQ3DEg+5XdP94bR8t8CJNC36bS0fRSWzsFQ6sYN51nYqDbGu9eUeQX/wgUHp2CO
	8uT3cSFOtNUHxYwocsmkSsqxLsOpLtsFbGGh8XMfT9PGeZr6t6XQoVMOYfme5BoGn/RtSx
	Zrw5tX1gmbVle0UJzWlHKMLHdHM3SOTvs7gXQGS3PORnGEttpAuLeplqHsL0mdffDLw+gu
	fsgaveR8CX/gNkN4xiPB0wjhoihotdaCLGsx7nMqf02q7wl6LCFnnHt0f1bvwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782124072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s038YWIfUpBDCuiGtkkXVvM91k1d45bdU4KObnsKNTM=;
	b=CtJOklFLBivk0B4Szp5IZIQwhXTnQ6X1hJ/ZPE87NOUsHtUfJijYI+aG+93ou1PfVlhwov
	IVlTRAp3ySHzTsBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 0/4] ARM: stable backports
Message-ID: <20260622102750.RMAlQTxT@linutronix.de>
References: <20260511135357.2786242-1-bigeasy@linutronix.de>
 <20260608082818.LZiPJ9ot@linutronix.de>
 <2026060832-extortion-cattail-2467@gregkh>
MIME-Version: 1.0
In-Reply-To: <2026060832-extortion-cattail-2467@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jun 2026 14:36:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23255

On 2026-06-08 16:12:05 [+0200], Greg KH wrote:
> We have hundreds of patches in the backlog right now, these are way down
> the list, sorry.  Hope to catch up "soon"...

No need to be sorry. Thank you (two) for doing the work.

> thanks,
> 
> greg k-h

Sebastian

