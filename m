Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7044.1794982805277506220
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 22:20:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@codewreck.org header.s=2 header.b=fYSetsja;
 spf=pass (domain: codewreck.org, ip: 62.210.214.84, mailfrom: asmadeus@codewreck.org)
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5491F14C2D6;
	Wed, 18 Nov 2026 07:20:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1794982802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xyb6XZG1l7Z+1ksCbMF/RQqTxH69dvbWVAhVNJ2wJng=;
	b=fYSetsjaAr2FbnTrS1PWBP3gFccgupsGzv0ahkbCATKXK1I12liPOTCbIKXvH3BkgYb5Uj
	TrPzRHizmI/evHciArS1aJiTiObcQogY8No0V2+r3O4Q7NuOgUSUHWJDblU36quhDeeliI
	EAZne4ZB68cIg3h74N4JUuM6/A4PBOzzkt/RpaVIbBqm7LdhEtopzCW2ZdXiuyz8boqknJ
	G57tZW/xV8dSrMguuR3ZZAe1hz5mfrOx+TxD4qBYWGh2CmlHPRqOUkPJ3cD0UfHQEvnt8z
	FnciRG40jsKHhoVg9tFGox4EhdhGsnExYNu3M4L2k54oE9+9t+DQSeHezG9jVw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 36a63c2a;
	Wed, 18 Nov 2026 06:19:58 +0000 (UTC)
Date: Wed, 18 Nov 2026 15:19:43 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: jan.kiszka@siemens.com
Cc: Pavel Machek <pavel@nabladev.com>,
	Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
	cip-dev <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Ulrich Hecht <uli@fpond.eu>
Subject: Re: [cip-dev] CVE-2026-99288: Re: [kernel-cve-report] New CVE
 entries this week
Message-ID: <av1Dfxc5tjypOTpl@codewreck.org>
References: <CAODzB9rb+qvRFhe8UcFY2Pt-j82sqgpS=mfc4NbCrbdwww2Tpw@mail.gmail.com>
 <4b4745fa-2a9e-48ea-996f-fff98ffec832@siemens.com>
 <avzGdm2kkPzk8cLD@duo.ucw.cz>
 <63257a1a-dcbd-46ea-958d-fd4fc876cd2e@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63257a1a-dcbd-46ea-958d-fd4fc876cd2e@siemens.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 06:20:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24950


Just drive-by comment as I was looking as this earlier today,
(hi & thanks for the work!)

Jan Kiszka via cip-dev wrote on Wed, Nov 18, 2026 at 07:09:08AM +0100:
> > I tried to do a quick research, and this seems to be more of server
> > issue, and may be hard/impossible to exploit in embedded
> > systems. Researcher's writeup seems to be at
> > https://github.com/V4bel/NoisyTCP . Quoting "so it can be triggered
> > against servers that have two or more RX queues, or where RPS
> > distributes packets across multiple CPUs."
> 
> Just to be clear: We have server-like scenarios in scope as well.
> "Embedded" does not imply a specific size of the system or performance.

(FWIW we have some embedded boards with 3-4 queues on imx7d / imx8mp at
least; OTOH this seems very hard to hit in practice so I'm treating this
as low-ish priority at $job ( https://www.atmark-techno.com/ ))

> > sudo sysctl -w net.ipv4.tcp_syncookies=0 was cited as possible
> > workaround.
> > 
> > If someone believes their machine are in danger, please let us know.
> > 
> > We could do 6.12-cip fairly easily, older would be more tricky as
> > there was no suitable -stable release. But I don't think this is "as
> > bad" as bugs we did extra releases for.
> 
> Can we support on this, or is this ongoing work already (<6.12)?

There are patches available as far back as 5.10 in the stable-queue repo:
git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue 

I didn't check if the 5.10 patch can be picked up further easily, but
that's one less to do/some conflicts already resolved.

-- 
Dominique Martinet | Asmadeus
