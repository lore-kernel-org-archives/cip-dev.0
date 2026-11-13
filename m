Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9827.1794573039167222583
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Nov 2026 04:30:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@monom.org header.s=v1-ed25519-20260726 header.b=6JPzP91P;
 dkim=pass header.i=@monom.org header.s=v1-rsa-20260726 header.b=bQ1vUpSK;
 spf=pass (domain: monom.org, ip: 49.12.199.46, mailfrom: wagi@monom.org)
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1794572889; bh=OK/Pv3zemgQXRA13hEoXerP
	bULG3CZqK2uvylng0Ibk=; b=6JPzP91PqNQbQ+Ay1YJxA6TaHG9TkD5wBsv8UsUoggjzAGE7mX
	z2UAAe8qTS408fv2sfQbK2bmJNyWTVsrngCA==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1794572889; bh=OK/Pv3zemgQXRA13hEoXerP
	bULG3CZqK2uvylng0Ibk=; b=bQ1vUpSKK0PmgCbe1AjwCBXg0PFX4S6HEK6nJYaNJVsxbZT+Ly
	dEgkv7luKYUIf8YEOMzksCHos6IWudJPqht0qGxXyb/Iolr31hqE2Ohc0AkA/zBvAMv48WWjEQ6
	YTgDhVidm6BxspwWNEPT4Udl0Fndf78K2kfpmuZzbxyoSz5pav41rNaNB4f+a9HqXvoIqeoVLLF
	hG2aK+HKvWgdBdur8bW9ctXEjvrslmnd+ORiN1p7+SYR7Emvy4rBxNUB30Riyo1yJdK0oU7sYBN
	mVD0CaF+t6CE5qR9/gOAJZVj0C+2kpE2xwBwJtxet+CUfx17jt7SumGT536PBvA6zUQ==;
Date: Fri, 13 Nov 2026 13:28:09 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com, 
	nobuhiro.iwamatsu.x90@mail.toshiba, Bryan Brattlof <bb@ti.com>, 
	Sebastian Siewior <bigeasy@linutronix.de>, Pasquale Nieddu <pasquale.nieddu@siemens.com>
Subject: Re: [PATCH 6.12.y-cip v2 0/6] Backport PREEMPT-RT support for ARM 32-bit
Message-ID: <4dc4d513-f632-4c1a-a866-51143424c409@monom.org>
References: <cover.1794223241.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
In-Reply-To: <cover.1794223241.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 07:57:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24817

On Mon, Nov 09, 2026 at 12:20:35PM +0100, Jan Kiszka wrote:
> The series was derived from the ARM-specific backlog in v6.12-rt-rebase,
> only reconstructing it from the corresponding upstream commits - maybe
> worth to consider for stable-rt as well.

IIRC, we had this discussion a few months ago and decided against it.
I can bring this up in the next stable-rt call and see what the group
thinks about it. 

