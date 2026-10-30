Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6677.1793348024047945248
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Oct 2026 01:13:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=florian.bezdeka@siemens.com header.s=fm2 header.b=dR4DXzFE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-68982-20261030080330471291eab100020760-6wa_jm@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20261030080330471291eab100020760
        for <cip-dev@lists.cip-project.org>;
        Fri, 30 Oct 2026 09:13:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=BM9mg6PFfwehHZxqExnCy5/k61Zg42U7sle3rGbmNnY=;
 b=dR4DXzFEZfmHUUEiCIALMdnhexgDnh2EwHKHULt5fM7g2KBsiUFLb+uw38+VofxokcAnEt
 l80ONzpFd011g6Opw5rIZq3Oowd0axxGEWKAtkDFNKdT6C9rSkC4PdBR4kH9vHq2B9CiKGu7
 7+qtmUYOYHv475/irR6XqoDYcbSX5n8nbWu2mxAPZFIAYor4ycRpNwnhUc/Q15BIOD2x8t3D
 ds/v3s1CUFWFEmPlpgtfEPKBLqc78QfFN64kSmYLp0JtErIxWSE+XYylWS2sb8rN5BL9x8R6
 EY+6iu3vx3HWK/QV1vAhXKgHsHwntrOJFrPHJWZO0amRoQyX7ZiCpWvg==;
Message-ID: <8a1ccfa3242ed0941606b8e3b398d5edb72faec9.camel@siemens.com>
Subject: Re: CVE-2026-98432 and CIP
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev
 <cip-dev@lists.cip-project.org>,  Nobuhiro Iwamatsu
 <nobuhiro.iwamatsu.x90@mail.toshiba>, Ulrich Hecht <uli@fpond.eu>, Pavel
 Machek <pavel@nabladev.com>,  "masami.ichikawa@cybertrust.co.jp"	
 <masami.ichikawa@cybertrust.co.jp>
Cc: "Kowalsky, Clara (T CED SES-DE)" <clara.kowalsky@siemens.com>
Date: Fri, 30 Oct 2026 09:03:30 +0100
In-Reply-To: <27271c84-9136-43d0-9769-bf45500f8946@siemens.com>
References: <27271c84-9136-43d0-9769-bf45500f8946@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 30 Oct 2026 08:13:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24583

Hi all,

On Fri, 2026-10-30 at 10:42 +0800, Jan Kiszka wrote:
> Hi all,
>=20
> there has been some media coverage like [1] on this two weeks old=20
> vulnerability [2] which is reported as "remote exploitable". Assessments=
=20
> still seem vary, though the tendency is "increasing criticality".
>=20
> The issue apparently depends on CONFIG_MPTCP enabled, and that is=20
> fortunately not the case in most CIP kernel configs. Furthermore, this=
=20
> feature did not even exist in 4.19 and 4.4.
>=20
> Still, we do have CONFIG_MPTCP enabled for 6.12.y-cip/x86 in [3]. I'm=20
> clarifying with our colleagues if that was by intention. The next 6.12-
> cip release is due today, and we should then also pick up the related=20
> upstream stable patch [4] very soon.

It's enabled to keep feature parity with the Debian kernel
configuration.=20

As the name of this configuration indicates, it's about server class
hardware in this case. It's hard to predict what end users will run on
those systems. That's the main reason why we try to stay as close as
possible to the Debian configuration.

In this case I doubt that it is used at the end. Servers are normally
single-homed and do not require any multi path TCP. On the other hand we
will have to update anyway, so it can stay enabled.

>=20
> @all: Please speak up if I should have missed something.
>=20
> Thanks,
> Jan
>=20
> [1] https://thehackernews.com/2026/10/linux-kernel-tcp-flaw-with-98-cvss.=
html
> [2] https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/-/blob/maste=
r/issues/CVE-2026-98432.yml?ref_type=3Dheads
> [3] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/3d=
f75973c690a4b433e8580e16c175e1fd959b63/6.12.y-cip/x86/siemens_server_defcon=
fig?L194
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/comm=
it/?id=3D11a03ce3c4a62d84c10ccdfe47f8075006498568
>=20
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
