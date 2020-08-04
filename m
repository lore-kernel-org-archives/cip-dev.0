Return-Path: <SRS0=4YkO=BO=lists.cip-project.org=bounce+64572+5089+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2C9C433DF
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 07:51:27 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D362076E
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 07:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="tvLdLCtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D362076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5089+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KFlnYY4521723xcgh1f7dMH8; Tue, 04 Aug 2020 00:51:26 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.915.1596527485206995259
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Aug 2020 00:51:25 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id AAB111C0BD7; Tue,  4 Aug 2020 09:51:19 +0200 (CEST)
Date: Tue, 4 Aug 2020 09:51:19 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: pavel@denx.de, biju.das.jz@bp.renesas.com,
	cip-dev@lists.cip-project.org, chris.paterson2@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] drm: of: Fix double-free bug
Message-ID: <20200804075119.GA1940@duo.ucw.cz>
References: <20200803111441.3157-1-biju.das.jz@bp.renesas.com>
 <20200803205700.GA16969@amd>
 <OSBPR01MB29839AA74ED88985B18C61CF924D0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB29839AA74ED88985B18C61CF924D0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KELsBd9UTo4fCcBlkvo1yVYHx4520388AA=
Content-Type: multipart/mixed; boundary="75AXesRp2bIWpnolwGg3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596527486;
 bh=v4J4iNssNhjKfpRIWnE7+hwkufVGL0oLDXUMQLj/p8c=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=tvLdLCtr9WZRh6UQ6fwjU6QYNFEIIuUHS8v8YuSTyBDhWwQ63FGkH+9YUfwLnMxyN+y
 OiVsLYrBFNEU/ySmslhKyser4FW7D6W5m9WM8Cx0X7Lhk+SyYMKmZM9c5zbKAkusXJ7Il
 ylumpkjJt1/CBPQJtW9xKcyDrJNSjna2qlo=

--75AXesRp2bIWpnolwGg3
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > commit 4ee48cc5586bf519df19894273002aa8ef7b70ad upstream.
> > >
> > > Fix double-free bug in the error path.
> >=20
> > Looks good to me. I can apply it if there are no other comments.
> >=20
>=20
> I also think that it's not particularly a issue.

Thanks, applied and pushed out.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXykTdwAKCRAw5/Bqldv6
8gt6AJ9dx4tLM568b34Tm4LlMbgiX10g3ACgiDittpxS125DxNiAQtslA02jyAk=
=HQrB
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

--75AXesRp2bIWpnolwGg3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5089): https://lists.cip-project.org/g/cip-dev/message=
/5089
Mute This Topic: https://lists.cip-project.org/mt/75963411/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--75AXesRp2bIWpnolwGg3--
