Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EFDC7618A
	for <webhook@archiver.kernel.org>; Sun, 19 Mar 2023 17:04:22 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.21055.1679245452941634850
 for <cip-dev@lists.cip-project.org>;
 Sun, 19 Mar 2023 10:04:14 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 43F371C0AB2; Sun, 19 Mar 2023 18:04:09 +0100 (CET)
Date: Sun, 19 Mar 2023 18:04:08 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, pavel@denx.de, jan.kiszka@siemens.com,
	uli@fpond.eu, Chris.Paterson2@renesas.com,
	masami.ichikawa@cybertrust.co.jp
Subject: Re: [ANNOUNCE] Release v4.19.276-cip93 and v5.10.173-cip28
Message-ID: <ZBdAiL2EPlrQ02rd@duo.ucw.cz>
References: <TYWPR01MB9420840010270BB35057B68892B99@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ETu3bB50dYv3SxqE"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB9420840010270BB35057B68892B99@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 19 Mar 2023 17:04:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11036


--ETu3bB50dYv3SxqE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> CIP kernel team has released Linux kernel v4.19.276-cip93 and
>  v5.10.173-cip28 The linux-4.19.y-cip tree has been updated base
>  version from v4.19.273 to v4.19.276, and linux-5.10.y-cip tree has
>  been updated base version from v5.10.168 to v5.10.173.

What are the plans for 4.19?

4.19-rt is due around now. There's suitable -rt

Date:   Thu Mar 16 08:05:18 2023 +0100
    Linux 4.19.277-rt122

=2E Could I ask for matching -cip?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ETu3bB50dYv3SxqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZBdAiAAKCRAw5/Bqldv6
8mOPAJwNgUqKqGMfLhsUw+n6Svd59V5ZCQCgntyn1jlnH0Vruc6T0b+MpvHNVmM=
=+57y
-----END PGP SIGNATURE-----

--ETu3bB50dYv3SxqE--

