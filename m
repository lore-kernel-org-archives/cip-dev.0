Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79076C47073
	for <webhook@archiver.kernel.org>; Mon,  1 Jan 2024 18:17:21 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.11220.1704133037411805622
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Jan 2024 10:17:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B96851C0079; Mon,  1 Jan 2024 19:17:11 +0100 (CET)
Date: Mon, 1 Jan 2024 19:17:10 +0100
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for reviews for 4.4-st48, 4.4-cip83
Message-ID: <ZZMBporTATCojv8R@duo.ucw.cz>
References: <2066622315.1550936.1703830831509@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lHVYHJllJtFxNT5V"
Content-Disposition: inline
In-Reply-To: <2066622315.1550936.1703830831509@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Jan 2024 18:17:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14222


--lHVYHJllJtFxNT5V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are two manual backports for the upcoming 4.4-st48 and 4.4-cip83 rel=
eases that should be reviewed and that can currently be found in
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinux-4.4.y-st-rc
>=20
> ** m+| eafbd69ab f4e606 .+ | qca_debug: Prevent crash on TX ring changes
> ** mo| 400b4a6fd 27b13e o  | blk-throttle: fix lockdep warning of "cgroup=
_mutex or RCU read lock required!"
>=20
> There is also a revert that fixes a crash in a non-CIP configuration:
>=20
> 24e9edbce704e Revert "md: fix a crash in mempool_free"

These patches look ok to me. The md indeed looks tricky.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lHVYHJllJtFxNT5V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZZMBpgAKCRAw5/Bqldv6
8iHXAJ9bR8nh9TeHuP27mK4HKTZyrZ9pJACfQ12e+EA/mDXSRtd4CkRkJEmtrcg=
=kUzI
-----END PGP SIGNATURE-----

--lHVYHJllJtFxNT5V--

