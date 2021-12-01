Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2178C433EF
	for <webhook@archiver.kernel.org>; Wed,  1 Dec 2021 09:12:00 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.89472.1638349918567306276
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Dec 2021 01:11:59 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E5DBE1C0BA8; Wed,  1 Dec 2021 10:11:54 +0100 (CET)
Date: Wed, 1 Dec 2021 10:11:53 +0100
From: Pavel Machek <pavel@denx.de>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"bot@kernelci.org" <bot@kernelci.org>,
	"alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>,
	"kernelci@groups.io" <kernelci@groups.io>
Subject: Re: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 12 runs, 1
 regressions (v4.19.217-cip62) #kernelci
Message-ID: <20211201091153.GB23274@amd>
References: <61a58f0d.1c69fb81.10029.4ed2@mx.google.com>
 <20211130083305.GA2355@amd>
 <OSZPR01MB687760A42FAC36D478192D11B7679@OSZPR01MB6877.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: 
 <OSZPR01MB687760A42FAC36D478192D11B7679@OSZPR01MB6877.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Dec 2021 09:12:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7051


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Tue 2021-11-30 10:22:14, Chris Paterson wrote:
> +kernelci ML as they will appreciate the feedback.

Thank you, but it looks like they are rejecting the email :-(.

<kernelci@groups.io>: host lb01.groups.io[45.79.81.153] said: 500 This
message
    has been flagged as spam. (in reply to end of DATA command)


Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmGnPFgACgkQMOfwapXb+vLz3wCguECyDGgX8zQ5Vzpcw8dGNL3v
iuMAn1R04CLiFkFL2YQ2IqUg2M8SFgNC
=qMLm
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--

