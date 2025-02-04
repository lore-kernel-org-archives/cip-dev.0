Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4676C0218F
	for <webhook@archiver.kernel.org>; Tue,  4 Feb 2025 09:19:26 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.112385.1738660756551614540
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Feb 2025 01:19:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=YAM4Gq0d;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3500010382D08
	for <cip-dev@lists.cip-project.org>; Tue,  4 Feb 2025 10:19:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1738660754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gOP5RZWuV95x5vOfIDLcASOjUdgc0/zT2ggDxLoC6hQ=;
	b=YAM4Gq0dS0LkZJwynKYPFfkRhzRR7kUod/ovvcfktcruAwsFYgeU6li/LRwuqQSqjZ6Mg7
	8zUSLRQONoAxJ6PKou6409us4ngkPxIuz7piDrGptO2AHqpmgTUQDKsfqPPr6FZJbtDypW
	vB72ekL8KOOw3XbAHO66oK5KEM1Ctfd685zt32MjV1Wub0OzAUY5uIgnMajZoETcCcQLJW
	UC4xzxYV1S7mGlJby7JGt86t/g2hX/0Kc3vXVIklB7k5Pl3BypXuCCd32tDzid17+xNZWF
	u3yN/hilfBpOVGE7rHJMu7OP6kTjRTtB81aS/uvQu8pTF3QdwSDR/iiqXvIWug==
Date: Tue, 4 Feb 2025 10:19:10 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Message-ID: <Z6HbjqSOkmJeLb7w@duo.ucw.cz>
References: <TYCPR01MB11385C6C2D03D46AF20294DF3E13B2@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <TYCPR01MB11385C4C5CA765090E66944FFE1052@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z4o+Ue8yk1aDpmoC@duo.ucw.cz>
 <TYCPR01MB11385BAF7D5C56CC8CC378440E1E12@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z5FPtY4aUHqMoL4w@duo.ucw.cz>
 <181D46DD0F426F98.25327@lists.cip-project.org>
 <TYCPR01MB1138502709ED426B37B76CAD4E1E82@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z5zP3BaPnG5x/d6/@duo.ucw.cz>
 <1820DE7A882DDE50.15786@lists.cip-project.org>
 <TYCPR01MB11385FD70540FAF1AB43F8FD3E1F42@TYCPR01MB11385.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K9Kq2PzVQFpwdxDo"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB11385FD70540FAF1AB43F8FD3E1F42@TYCPR01MB11385.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Feb 2025 09:19:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17745


--K9Kq2PzVQFpwdxDo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > However, I could not find the posts in archives except cip-dev.
> > [...]
> > https://lore.kernel.org/linux-rt-devel/
> > https://lore.kernel.org/linux-rt-users/
> > https://lore.kernel.org/linux-kernel/
>=20
> Now the posts are visible.
> It seems to take several hours to appear in archives.
> Sorry for the noise.

It may be there are moderated for non-subscribers or something. Thanks
for doing that!

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--K9Kq2PzVQFpwdxDo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ6HbjgAKCRAw5/Bqldv6
8pFTAJ979hRm99wlHEq+YkgKgvVgcbI0rwCggI8I8VP9tGjrQcb9k0gaqvHSTFA=
=QdMB
-----END PGP SIGNATURE-----

--K9Kq2PzVQFpwdxDo--

