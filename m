Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E68AC3DA6E
	for <webhook@archiver.kernel.org>; Wed,  3 Jan 2024 10:27:24 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.14845.1704277638717655392
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jan 2024 02:27:19 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 374011C006B; Wed,  3 Jan 2024 11:27:15 +0100 (CET)
Date: Wed, 3 Jan 2024 11:27:14 +0100
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [ANNOUNCE] Release v4.4.302-cip83
Message-ID: <ZZU2gnuaNlO8/Cqj@duo.ucw.cz>
References: <388403084.1872261.1704264616877@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zbXvCzjVX2hgVo8Y"
Content-Disposition: inline
In-Reply-To: <388403084.1872261.1704264616877@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Jan 2024 10:27:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14245


--zbXvCzjVX2hgVo8Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> the CIP kernel team has released Linux kernel v4.4.302-cip83. The linux-4=
=2E4.y-cip tree's base version has been updated to v4.4-st48.
>

Could we get a note in form "it should be up-to-date with bugfixes
=66rom v4.14.XXX"?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zbXvCzjVX2hgVo8Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZZU2ggAKCRAw5/Bqldv6
8q+7AJ9Llmil81JzWQdsBVA8B59YYs1F7gCfeE1s8D5csIG2RjsObgt/YOY3aDw=
=tIZ3
-----END PGP SIGNATURE-----

--zbXvCzjVX2hgVo8Y--

