Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4692EC433F5
	for <webhook@archiver.kernel.org>; Tue,  1 Mar 2022 18:05:28 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.381.1646157923964321140
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Mar 2022 10:05:25 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9820D1C0B81; Tue,  1 Mar 2022 19:05:20 +0100 (CET)
Date: Tue, 1 Mar 2022 19:05:20 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, pavel@denx.de,
	Chris.Paterson2@renesas.com, uli@fpond.eu, jan.kiszka@siemens.com,
	masami.ichikawa@cybertrust.co.jp
Subject: Re: [ANNOUNCE] Release v4.19.231-cip68
Message-ID: <20220301180520.GA13424@duo.ucw.cz>
References: 
 <TYAPR01MB6252EBFBECFC83DCA2B8A46892029@TYAPR01MB6252.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: 
 <TYAPR01MB6252EBFBECFC83DCA2B8A46892029@TYAPR01MB6252.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Mar 2022 18:05:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7647


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> CIP kernel team has released Linux kernel v4.19.231-cip68.
> The linux-4.19.y-cip tree has been updated base version from v4.19.229 to=
 v4.19.231.
>=20
> You can get this release via the git tree at:

Thanks for release. There is 4.19.230-rt103, so this time timing did
not work out. Would it be possible to coordinate the next one with
-rt?

Thank you and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYh5gYAAKCRAw5/Bqldv6
8nYXAJ9R380QKRZQDPBybXorxXHLB1d41QCdHk2fRx8vMNKP+yoKnae2IJCMMuI=
=1FnG
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--

