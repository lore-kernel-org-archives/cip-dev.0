Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1525.1794242973239753944
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 08:49:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=TKhseepI;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=OH4NSMUW;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.165, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1794242965; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iI1OvCq41U/TF+AI4kJ5Bogakm8BsrPtKuF8LEEgx4xcxG64fgRyk9yudi5Fv9Iy1p
    utbYNQTzvATL8ii+BEM7tSYVIdKPY2DF524kNSl5t6NlNNYF0GBI2UE1YlLUVBB7IKCq
    33HJqy619g2ROI5CifST2LFpLCDfU+Y1bY/23RuYhtS3Ax2Rdw2wbbF5Y/8Xuk45m+8Z
    tueK+yBB0Eo+So5NqVeQs87mIeyQhjN5SUaaiXXa/9BLgsux8HIJx6opx90KtKR/F5aa
    4kwS6al7j1jzySvSO5MX/PY23bTycEeQT4kxRXmzfi0pNwbZbZWhCewp2YWF/JjgJLO7
    vC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794242965;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3gfb0caJaY6tN5mMgV/uYkQNlzG9+94dmMjLnd6VWws=;
    b=l1OHWM0ECC9Oxa9aXIAwdBzDo8Taa7IOH18pds6Z8yRejma65qeaDEk4i4+SAsdUD9
    PgdhvZAWFAE47Xi/AfAfU3zyLuHU3GHg7H+RFqaDtGDdxcNE07Fhzb0GZ3iCt5sjepow
    0rVl45zKRelwZc5Jy7mzosK9mk8eX92o+zTSM7u/ENau8RLXb137T1gFOnIbIEPVK4tt
    IxBqOX88M3P9uyUZhz5Cy2xJdDEhFV8kT2uyeXidff1y3FlBvLgQ2ebfKJljtCxVjJHi
    ggyQ6H28crdtdkp5Z19SXLMR3kYwH/NRWzVEo8YiwRC7s74QpCBaqEzwNFBIV37FMw2D
    GvFg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794242965;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3gfb0caJaY6tN5mMgV/uYkQNlzG9+94dmMjLnd6VWws=;
    b=TKhseepIZyW0oXg9tKthRbLyBDrT5BqxuN6yIyLyecyxpYT93U9egK1AFzqH/MrFOA
    4p/TGsEPxmERDNQCQPXn5lvwQAJdtRZXaoIgBP+Zuj+QwZNrv30bHbykksB2G2rwYh6u
    Q+6GmGXtMiqTt7IHZuxZf+mZVfNOXvFKIbPI1WNQz9V90p3FyXslIcXzNHkBJqWWnkFe
    i90YnfIKdf7/bNZyzmmIp1N0cjhS+tXtp+/94IeV0QbJUTut/Hg9HFtGCJCJ7jI1+s0m
    X/0Ci6IgW9DyYM3s79IaynckUEXCktoaIkAPffDhtqySOBPA6y4jfsndrF7YYMZK+VWK
    HEUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794242965;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3gfb0caJaY6tN5mMgV/uYkQNlzG9+94dmMjLnd6VWws=;
    b=OH4NSMUWpqvtaBktAwQNDCtv6nBt6T/TvM0lKPO4t7+iuvokqDWBewyu9w8M4/O3tG
    IXyeHb0LF8DBdDwV9MDQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzotGZvghOuyX/LuaP4"
Received: from open-xchange-core-mw-gw-7.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.6.3 AUTH)
    with ESMTPSA id z81ed22A9GnPuCN
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 9 Nov 2026 17:49:25 +0100 (CET)
Date: Mon, 9 Nov 2026 17:49:25 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "pavel@nabladev.com" <pavel@nabladev.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <280295681.429413.1794242965569@webmail.strato.de>
In-Reply-To: <au2l9BFnAxo2l_Cq@duo.ucw.cz>
References: <1931298540.80350.1793132613065@webmail.strato.de>
 <au2l9BFnAxo2l_Cq@duo.ucw.cz>
Subject: Re: [cip-dev] Request for review for 4.19-st21, 4.19-cip137
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.154
X-Originating-Port: 55830
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 16:49:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24730


> On 11/06/2026 11:03 AM CET Pavel Machek via cip-dev <pavel=nabladev.com@lists.cip-project.org> wrote:
> > Here are the adapted backports for the upcoming 4.19 kernel release. There's a total of 95; 1 written by me, 2 by Qwen-3.8-27B and 92 by Qwen-3.8-Flash-Next. (The latter are labeled with "Assisted-by: SLTR:qwen-3.8" and "Assisted-by: SLTR:qwen-3.8-flash-next", respectively.)
> > 
> > As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc
> >
> 
> Some patches are ok, Reviewed-by: Pavel Machek
> <pavel@nabladev.com>. There are some comments below.
> 
> e37dae2a4576c5, for example. That was an obvious two-liner, but it is
> quite significant locking redone after backport. I'm afraid this
> should get specific testing.

The reasoning is as follows:
```
unlike 5.10 (where SIOCGSTAMP moved to the lockless `.gettstamp` op, which 4.19 lacks), three 4.19 ioctl handlers hold the socket lock around the stamp calls and would self-deadlock with the new inner `lock_sock()`: `ax25_ioctl` (lock over whole switch), `nr_ioctl` (lock per case), `qrtr_ioctl` (lock over whole switch). These callers must be adjusted, mirroring upstream's eventual direction. All other callers (inet, inet6, packet, rose, x25, can, bluetooth, atm, appletalk, ieee802154, compat) run lockless
```

As it happens, none of the affected handlers are enabled in any CIP configs, so technically we could also a) drop the additional fixes, or b) leave them in without testing because it doesn't matter anyway.

> cbf63e3778be51 is example of different problem. That rmmod path is
> likely seriously broken in 4.19-st20. That's why it got redesign in
> mainline. It is still broken in 4.19-st21, that barrier won't fix it
> with nf_flow_table_module_exit() missing. Nobody should unload modules
> in production, and this risks regressions.

OK, there's at least two things I don't understand here:
1. Why is nf_flow_table_module_exit() missing? The patch adds it.
2. How does that risk a regression if the path doesn't work anyway and is not supposed to be used in production?

CU
Uli
