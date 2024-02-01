Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF40EC47DDB
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 09:50:40 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.12174.1706781038987403320
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Feb 2024 01:50:39 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 84FA71C0075; Thu,  1 Feb 2024 10:50:37 +0100 (CET)
Date: Thu, 1 Feb 2024 10:50:36 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: pavel@denx.de, kazuhiro3.hayashi@toshiba.co.jp,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	yuki.saito@toshiba.co.jp
Subject: Re: [PATCH 0/1] clk: Fix for restructuring for no reparent case
Message-ID: <ZbtpbN5EGv8lNExj@duo.ucw.cz>
References: <20240131135604.1488157-1-kazuhiro3.hayashi@toshiba.co.jp>
 <ZborIz5UgFSvjKRf@duo.ucw.cz>
 <OS0PR01MB63880680E53C59CE9A63B28592432@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DP1oWUYhvfgAXc0s"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB63880680E53C59CE9A63B28592432@OS0PR01MB6388.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 09:50:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14577


--DP1oWUYhvfgAXc0s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > In mainline, a fix for the backport commit above is provided:
> > > be8fa5fd0a48fd2decc4de81ffe72bb3ceacecd9.
> > > This should be applied to linux-6.1.y-cip as well.
> > > With v6.1.72-cip13 + this patch, we confirmed the ZCU102 Ethernet
> > > works at 100Mbps.
> >=20
> > Thanks a lot for investigation and sorry for the trouble.
> >=20
> > The fix is simple enough, I am currently running tests, and can take it=
 if they
> > pass and there are no other comments.
>=20
> I do not have an objection.
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for the review, I applied the patch.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--DP1oWUYhvfgAXc0s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZbtpbAAKCRAw5/Bqldv6
8pHGAJ48Q+mtONNCovd24gGD80LfhYyemQCcCYM4uLO52rwYAaOKdwPLCoUA4x0=
=Bvle
-----END PGP SIGNATURE-----

--DP1oWUYhvfgAXc0s--

