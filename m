Return-Path: <SRS0=pTnw=KJ=lists.cip-project.org=bounce+64572+6455+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BEAC433B4
	for <cip-dev@archiver.kernel.org>; Fri, 14 May 2021 07:40:36 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A702611CE
	for <cip-dev@archiver.kernel.org>; Fri, 14 May 2021 07:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A702611CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6455+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1pG5YY4521723xnUjB3lg3Eu; Fri, 14 May 2021 00:40:34 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.5732.1620978033289749314
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 May 2021 00:40:34 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C96FC1C0B80; Fri, 14 May 2021 09:40:28 +0200 (CEST)
Date: Fri, 14 May 2021 09:40:28 +0200
From: "Pavel Machek" <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, biju.das.jz@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/2] media: i2c: imx219: Trivial Fixes
Message-ID: <20210514074027.GA6430@amd>
References: <20210512170127.16390-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB6252C74E1E344EC9F27BCB5192519@TYAPR01MB6252.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB6252C74E1E344EC9F27BCB5192519@TYAPR01MB6252.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dRVaCdqe4Av0jV1tRq6lrmjLx4520388AA=
Content-Type: multipart/mixed; boundary="cT8h6TgWL8WCYbN7RHz8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620978034;
 bh=8LG5Rzt5hcQCYNDWqAWBO02AcShP9EN6OpR+x4XXa0E=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=A+BvyV6xMCMt/FBTpHHTEl1GiVqwqHQT4u3CS5pY/sPAsLO3vaYTRmM5WBBYiz36FwG
 mYdP1d/9kXxDzdi8OiLkSA7Ih8IHNVP7iarvQsMF4vtcVvzFINqsNoJX/UhQdTPm0OFew
 gisJWQq5iUzdKqcygGxL6fpfxO+VQ0AuKXw=

--cT8h6TgWL8WCYbN7RHz8
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Lad Prabhakar (2):
> >   media: i2c: imx219: Move out locking/unlocking of vflip and hflip
> >     controls from imx219_set_stream
> >   media: i2c: imx219: Balance runtime PM use-count
>=20
> Both patches looks good to me.
> If no other opinion, I can apply this series.
>=20
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/3020303=
01

It looks okay to me, too.

(And same patches are queued for 5.10.37, so we won't need to do
anything there).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCeKWsACgkQMOfwapXb+vI2PQCfdtIbwFTlbnz40+FxDCe1uc5h
bC0AnjPOHO30RJAEKJl736Rtkgcy5jxm
=T/QU
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

--cT8h6TgWL8WCYbN7RHz8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6455): https://lists.cip-project.org/g/cip-dev/message=
/6455
Mute This Topic: https://lists.cip-project.org/mt/82777615/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--cT8h6TgWL8WCYbN7RHz8--
