Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC099C61DA3
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 11:40:56 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.40412.1676979653404395734
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Feb 2023 03:40:54 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5B71A1C0AC1; Tue, 21 Feb 2023 12:40:50 +0100 (CET)
Date: Tue, 21 Feb 2023 12:40:49 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/2] Watchdog driver fix and pinctrl
 improvement
Message-ID: <Y/StwffPXfQvkg+U@duo.ucw.cz>
References: <20230221080232.24958-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TlPMycEB2DTQhK6Z"
Content-Disposition: inline
In-Reply-To: <20230221080232.24958-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 11:40:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10748


--TlPMycEB2DTQhK6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to fix reset issue with watchdog driver
> and remove unnecessary check from pinctrl driver for RZ/G2L alike
> SoCs.

Thanks for the series, I can apply if there are no other comments and
if it passes testing.

> Lad Prabhakar (1):
>   watchdog: rzg2l_wdt: Issue a reset before we put the PM clocks

This one is fine, thank you.

> Biju Das (1):
>   pinctrl: renesas: rzg2l: remove unnecessary check from
>     rzg2l_dt_node_to_map()

This one is just a cleanup. I can take it since it is your code and
since it is obviously correct.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--TlPMycEB2DTQhK6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY/StwQAKCRAw5/Bqldv6
8taVAJ499eP+EOS5ngh6Z/QVVlDzlwm2WACeNfyYhMWV+g4PDq+hWzkeLTJFuvE=
=UPuE
-----END PGP SIGNATURE-----

--TlPMycEB2DTQhK6Z--

