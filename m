Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E977C433F5
	for <webhook@archiver.kernel.org>; Wed, 16 Mar 2022 20:48:16 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.2047.1647463694158159211
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Mar 2022 13:48:15 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id ABE5C1C0BB0; Wed, 16 Mar 2022 21:48:09 +0100 (CET)
Date: Wed, 16 Mar 2022 21:48:09 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com
Subject: Re: [cip-dev] Starting 4.4 backports
Message-ID: <20220316204809.GA23976@duo.ucw.cz>
References: <16DCA3473A223E6A.28363@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <16DCA3473A223E6A.28363@lists.cip-project.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Mar 2022 20:48:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7757


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> So... I have some scripts, and I went through 4.9.299... I guess I
> could try to update linux-4.4.y tree with patches from 4.9.299.
>=20
> I would not mind someone looking at notes I've made so far. They are
> at:
>=20
> https://gitlab.com/cip-project/cip-kernel/lts-commit-list/-/blob/master/v=
4.4.org
>=20
> There are some notes at begining of file explaining what different
> values of the first field are. Most important now is number -- it
> means that the patch looks "not worth the effort dealing with", and I
> plan to simply ignore it.
>=20
> Comments? Is it okay to go ahead?

I have merged 4.9.299 changes with -cip, and result is at

https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-test

=2E If there are no other comments, I'll push that as linux-4.4.y-cip on
kernel.org and I'll push the tree with just the changes from stable as
linux-4.4.y-st there, too.

I guess at some point we'll need to decide how to mark versions in the
linux-4.4.y-st tree. I guess we could use "-stX" as an extra
version. If we wait a bit, we can use X=3DY-300 for corresponding 4.9.Y
version.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYjJNCQAKCRAw5/Bqldv6
8jH2AJ4/yGgCTyZMZPcn7fcNKRzjig8t/ACaAjrN9vLktAm7NCa2HArnQebfm8I=
=fWTF
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--

