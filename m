Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433C2C433F5
	for <webhook@archiver.kernel.org>; Wed,  1 Dec 2021 09:01:47 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.89127.1638349305709362246
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Dec 2021 01:01:46 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C24B91C0BA8; Wed,  1 Dec 2021 10:01:41 +0100 (CET)
Date: Wed, 1 Dec 2021 10:01:39 +0100
From: Pavel Machek <pavel@denx.de>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"bot@kernelci.org" <bot@kernelci.org>,
	"alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>,
	"kernelci@groups.io" <kernelci@groups.io>
Subject: Re: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 12 runs, 1
 regressions (v4.19.217-cip62) #kernelci
Message-ID: <20211201090139.GA23274@amd>
References: <61a58f0d.1c69fb81.10029.4ed2@mx.google.com>
 <20211130083305.GA2355@amd>
 <OSZPR01MB687760A42FAC36D478192D11B7679@OSZPR01MB6877.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: 
 <OSZPR01MB687760A42FAC36D478192D11B7679@OSZPR01MB6877.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Dec 2021 09:01:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7050


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Then we have:
> >=20
> > > cip/linux-4.19.y-cip baseline-nfs: 12 runs, 1 regressions (v4.19.217-=
cip62)
> >=20
> > Ok, so we may have an regression. That means it worked before and it
> > does not work now. I'd expect two versions "worked in v4.19.123-cip12,
> > now broken in v4.19.217-cip62", but we only have one.
> >=20
> > > Regressions Summary
> > > -------------------
> > >
> > > platform         | arch  | lab           | compiler | defconfig | reg=
ressions
> > > -----------------+-------+---------------+----------+-----------+----=
--------
> > > rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig | 1
>=20
> Did you not have a "details" link here? In my copy of the email (attached=
) it links to=20
> https://linux.kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kernel/v4=
=2E19.217-cip62/plan/baseline-nfs/
>=20
> If you click on the platform in question it says: "New regression, last p=
ass: v4.19.216-cip61", which also links to the relevant build job.
> I think it also says this in the email below the failed test case? (basel=
ine-nfs.login)
>

I did not find the "New regression, last pass" summary, but clicking
on testcase path indeed gave me failing and passing dmesg.

Working test says:

07:05:59.319716  <4>[   16.957513] cdn-dp fec00000.dp: Direct firmware
load for rockchip/dptx.bin failed with error -2
07:06:00.206271  <6>[   17.844209] asix 7-1:1.0 enx48f8b3454d72: link
up, 100Mbps, full-duplex, lpa 0xC1E1
07:06:00.551556  IP-Config: no response after 2 secs - giving up
07:06:00.609271  IP-Config: enx48f8b3454d72 hardware address
48:f8:b3:45:4d:72 mtu 1500 DHCP

And after scrolling around it looks enx48f8b3454d72 is usb ethernet
card.

> This includes a link to the defconfig used, although perhaps you'd like t=
o know more about the platform.
>

Yes, knowing more about platform would be nice (one question would be
"Is the ethernet removable?"). But in case like this I'd need someone
to do the tests for me (or to have enough access to do the tests
myself). First question would be "does v4.19.217 work with same
config"? Easist way to debug this is usually bisection....

Is that feasible?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmGnOfMACgkQMOfwapXb+vIZbACgmzjZuZiwikp0u8z6jQNPX0lS
nV0AoJekv4r6LoCGgVkLBGxqBy1IkKrV
=gine
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--

