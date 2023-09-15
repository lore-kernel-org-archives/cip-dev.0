Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CFFEE6421
	for <webhook@archiver.kernel.org>; Fri, 15 Sep 2023 06:54:40 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.15291.1694760873239113530
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Sep 2023 23:54:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BDD031C0014; Fri, 15 Sep 2023 08:54:30 +0200 (CEST)
Date: Fri, 15 Sep 2023 08:54:30 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [cip-dev] 5.10.192-rt release
Message-ID: <ZQP/pjwkq89a5O2T@duo.ucw.cz>
References: <17837C4CBB3258BF.4559@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y26wSIkeObBBz8Kl"
Content-Disposition: inline
In-Reply-To: <17837C4CBB3258BF.4559@lists.cip-project.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Sep 2023 06:54:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13136


--y26wSIkeObBBz8Kl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Could I ask for v5.10.192-based -cip release? I believe that's best
> way to get -cip-rt out.
=2E..
> -- so I'd expect next -rt at end of September. Waiting for it is
> another option, but we'd be a bit late with the release.

So 5.10.194-rt94 was released today, and that means it is better
option now. 5.10.194-cip would be welcome.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--y26wSIkeObBBz8Kl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZQP/pgAKCRAw5/Bqldv6
8nOIAJ4nJxG/cce7SuVluuKbezqq44hd7QCgsmtO9PdqCtdIalISuDJTYjVNCjA=
=sBgE
-----END PGP SIGNATURE-----

--y26wSIkeObBBz8Kl--

