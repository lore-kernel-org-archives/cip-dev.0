Return-Path: <SRS0=WBnD=MV=lists.cip-project.org=bounce+64572+6643+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C036CC4338F
	for <cip-dev@archiver.kernel.org>; Thu, 29 Jul 2021 08:59:05 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6FDA60EB2
	for <cip-dev@archiver.kernel.org>; Thu, 29 Jul 2021 08:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E6FDA60EB2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id aRCxYY4521723xWDvzgyWZ5o; Thu, 29 Jul 2021 01:59:04 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.7025.1627549143039914946
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Jul 2021 01:59:03 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 83C631C0B79; Thu, 29 Jul 2021 10:58:59 +0200 (CEST)
Date: Thu, 29 Jul 2021 10:58:58 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries this week
Message-ID: <20210729085858.GA19173@amd>
References: <CAODzB9o8xwbKB7i1vDfQx0SSZa84+nPh+9kZDKj7LRvpO9R0mg@mail.gmail.com>
 <20210729074703.GA14232@amd>
 <CAODzB9q_2RC84Jt1joU8-FG7kaECsZtMn2uq7Zn8mXF6eC38tg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODzB9q_2RC84Jt1joU8-FG7kaECsZtMn2uq7Zn8mXF6eC38tg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zCULOlTBI4pPkgxp3Hrv5UF4x4520388AA=
Content-Type: multipart/mixed; boundary="ljLUhbW5Hi4EgMYfMwVq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1627549144;
 bh=gVSQlKB5ZV4SE0xMMZ0cpGif83hwIh7DUIovWYurfzM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=uRIP9NTJPFtkn+ieLsBFa4d2/xvGG1u692mZIgMc6rwRc+FyWK1XgUcZXhJZW4cNJoa
 gqdqqkzRJleNBiav4ymyraTPH5sUQjjoKKXd4E2yEBaqphHsZ5WZXdGDgqAo6HGzqlHqX
 y5+D4q1QlCtA4hnViOKSdbY/l9K+bMi1KLQ=

--ljLUhbW5Hi4EgMYfMwVq
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > CVE-2021-3655: v4.4 is not fixed as of 2021/07/29
> >
> > This may need more careful look. There are 4 patches fixing this in
> > mainline, but only two in
> > 5.10. c7da1d1ed43a6c2bece0d287e2415adf2868697e should be easy to
> > backport to 4.4.
> >
>=20
> Okay. I'll take another look.

Thank you.

Note that I pushed my comments into the repository, so you may want to
do the pull before doing changes there.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmECbdIACgkQMOfwapXb+vLotwCdEDdPYeKe7/nfPy9p8nskPzto
jvoAnj2iP1i64Qkgqsh1d7IjKbZqX3KT
=n/TM
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--

--ljLUhbW5Hi4EgMYfMwVq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6643): https://lists.cip-project.org/g/cip-dev/message=
/6643
Mute This Topic: https://lists.cip-project.org/mt/84519830/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ljLUhbW5Hi4EgMYfMwVq--
