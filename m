Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDA5D6C28E
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 19:49:02 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.30965.1732045736243118669
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Nov 2024 11:48:56 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=fail (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BDAA21C006B; Tue, 19 Nov 2024 20:48:53 +0100 (CET)
Date: Tue, 19 Nov 2024 20:48:53 +0100
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for reviews for 4.4-st58, 4.4-cip93
Message-ID: <Zzzrpf04NccFxosX@duo.ucw.cz>
References: <1048687374.465216.1731913250080@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x6XfOBntBf4pSqDs"
Content-Disposition: inline
In-Reply-To: <1048687374.465216.1731913250080@webmail.strato.de>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Nov 2024 19:49:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17263


--x6XfOBntBf4pSqDs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here's the manual backports to review for the next 4.4 release which, as =
always, can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip=
/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>

Thanks for series, most look good (and I'm still reviewing them), but
I have few comments:

> 58779420cf48b netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr_put()

Ported patch is very different from what mainline has and changelog
describes. We probably don't have good way to handle this, maybe we
should have fixes-same-bug-as: xxx header or something like that.

> 0994d75c1648c kthread: add kthread_work tracepoints

These are simply added tracepoints. I guess they can be useful, but
I'd hardly call it a bug when they are not there.

> cad9f4314a05e drm/rockchip: vop: Allow 4096px width scaling

I guess noone uses this in 4.4, but this simply enables wider range of
configurations, and I'm pretty sure noone tested it.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--x6XfOBntBf4pSqDs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZzzrpQAKCRAw5/Bqldv6
8n0rAJ9zevKAUAMBsCM85ixNEqL/ixnlxwCfYMoYBgwoKQbHTr5bih1ip+2NRq8=
=+CIh
-----END PGP SIGNATURE-----

--x6XfOBntBf4pSqDs--

