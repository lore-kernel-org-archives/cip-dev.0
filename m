Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200C0C77B7E
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 12:50:00 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.30236.1685623793108785278
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 05:49:54 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 630CD1C0DE7; Thu,  1 Jun 2023 14:49:49 +0200 (CEST)
Date: Thu, 1 Jun 2023 14:49:46 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Backporting MTU3a counter driver to linux-5.10.y-cip
Message-ID: <ZHiT6kWwgOHqslQs@duo.ucw.cz>
References: <OS0PR01MB5922AA46B8F8C695943085FB86789@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922D244175CCCF76490BFB086789@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZGaZvnCWMW+cOXl1@duo.ucw.cz>
 <OS0PR01MB59227670A61E6EBAB81A1D33867C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ezGllb3yjs/spdGG"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59227670A61E6EBAB81A1D33867C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 12:50:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11728


--ezGllb3yjs/spdGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > 2) Update counter subsystem in 5.10-cip with patches from 5.15, then
> > merge the driver from 6.4.

> So basically 2 and 3 ruled out. The only option left out is 1??

So we discussed options on todays meeting on IRC (you may want to
review the log)... and if you are willing to do the work, we are
willing to consider option 2.

That does not mean we are willing to do updates on other subsystems --
this should really be an exception -- but it seems counter subsystem
is simple enough and you may be the only user in -cip.

(Of course, the patches need to be reasonable and reviewable etc).

Best regards,
     	       	       	     	      	   	       	        Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ezGllb3yjs/spdGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZHiT6gAKCRAw5/Bqldv6
8sJvAJ9DBugI2XNoRLvHYDQB1meQaiHE1wCdHj1c8B7X4BRnSYsicxJ2ha7FatA=
=hgsM
-----END PGP SIGNATURE-----

--ezGllb3yjs/spdGG--

