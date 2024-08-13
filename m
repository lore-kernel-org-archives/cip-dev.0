Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0F3C52D7B
	for <webhook@archiver.kernel.org>; Tue, 13 Aug 2024 15:44:54 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.75761.1723563886779419172
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Aug 2024 08:44:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4EC9B1C008E; Tue, 13 Aug 2024 17:44:44 +0200 (CEST)
Date: Tue, 13 Aug 2024 17:44:43 +0200
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [ANNOUNCE] v6.1.102-cip26
Message-ID: <Zrt/a+EkczsJFeGp@duo.ucw.cz>
References: <ZrjoeDL95EC/rBlE@duo.ucw.cz>
 <9fe32cd5-7159-4e53-b8e1-3db1f29fe383@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QOEYTCXp7P6+9TdK"
Content-Disposition: inline
In-Reply-To: <9fe32cd5-7159-4e53-b8e1-3db1f29fe383@siemens.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Aug 2024 15:44:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16783


--QOEYTCXp7P6+9TdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Did you push the tarball of this as well? I find 6.1.101-cip26-rt14 but
> only 6.1.101-cip25.

So tarball should now be there.

Sorry for confusion,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--QOEYTCXp7P6+9TdK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZrt/awAKCRAw5/Bqldv6
8tv0AJ91dOjrr5CsFyMNIvLnxoBcB7CK8QCggOUsuA/GCO9dIVWWTjeS8DjVOpI=
=hbCo
-----END PGP SIGNATURE-----

--QOEYTCXp7P6+9TdK--

