Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528D3C433F5
	for <webhook@archiver.kernel.org>; Tue, 30 Nov 2021 08:33:19 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.73895.1638261197889592999
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Nov 2021 00:33:18 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CAA711C0B76; Tue, 30 Nov 2021 09:33:08 +0100 (CET)
Date: Tue, 30 Nov 2021 09:33:05 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, bot@kernelci.org,
	Chris.Paterson2@renesas.com, alice.ferrazzi@miraclelinux.com
Subject: Re: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 12 runs, 1
 regressions (v4.19.217-cip62) #kernelci
Message-ID: <20211130083305.GA2355@amd>
References: <61a58f0d.1c69fb81.10029.4ed2@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <61a58f0d.1c69fb81.10029.4ed2@mx.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Nov 2021 08:33:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7026


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

So... I tried to understand this report, and still could not.

First problem is actually in the From: line. By placing bot there, it
is not clear who is responsible for this, and if someone reads replies
to the bot address.

I feel posts to mailing lists should be signed by human responsible
for them.

Then we have:

> cip/linux-4.19.y-cip baseline-nfs: 12 runs, 1 regressions (v4.19.217-cip6=
2)

Ok, so we may have an regression. That means it worked before and it
does not work now. I'd expect two versions "worked in v4.19.123-cip12,
now broken in v4.19.217-cip62", but we only have one.

> Regressions Summary
> -------------------
>=20
> platform         | arch  | lab           | compiler | defconfig | regress=
ions
> -----------------+-------+---------------+----------+-----------+--------=
----
> rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
   =20

>   URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip=
=2Egit
>   SHA:      dc62e26e3be875a7324b85b8274c13a335e610dd

Still no note when it worked last.

>   HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.2=
17-cip62/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin=
=2Ehtml

Ok, so we have bootlog from a machine, that's quite unhappy. Part of
it are kernel problems, but we see missing firmware, too. In the end,
it looks like it has no usable network card, so it can not do NFS
boot... and panics.

It is hard to tell config problem vs. kernel bug without knowing more
about machine configuration. Best seeing previous successful runs...

Is there human here who believes this is a problem in -cip kernel that
is worth solving, and is willing to answer questions and test patches?

Best regards,

								Pavel

02:27:34.443815  <4>[    1.401574] cacheinfo: Unable to detect cache
hierarchy for CPU 0
02:27:34.452441  <6>[    1.413496] loop: module loaded
02:27:34.464113  <4>[    1.421343] rockchip-spi ff1d0000.spi: Failed
to request TX DMA channel
02:27:34.471531  <4>[    1.429063] rockchip-spi ff1d0000.spi: Failed
to request RX DMA channel
02:27:34.487460  <6>[    1.446867] m25p80 spi0.0: gd25lq64c (8192
Kbytes)
02:27:34.501792  <4>[    1.459399] rockchip-spi ff1e0000.spi: Failed
to request TX DMA channel
=2E..
02:27:48.313465  <6>[   15.264576] atmel_mxt_ts 3-004b: Family: 164
Variant: 14 Firmware V2.3.AA Objects: 40
02:27:48.362782  <4>[   15.318381] atmel_mxt_ts 3-004b: Direct
firmware load for maxtouch.cfg failed with error -2
02:27:48.535527  <4>[   15.377455] atmel_mxt_ts 5-004a: Direct
firmware load for maxtouch.cfg failed with error -2
02:27:48.827088  ipconfig: no devices to configure
02:27:48.831012  ipconfig: no devices to configure
02:27:48.926132  <4>[   15.866511] platform regulatory.0: Direct
firmware load for regulatory.db failed with error -2
02:27:48.931359  <6>[   15.879008] pci 0000:00:00.0: PCI bridge to
[bus 01]
02:27:48.938653  <6>[   15.879016] pci 0000:00:00.0:   bridge window
[mem 0xfa000000-0xfa1fffff]

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmGl4cEACgkQMOfwapXb+vIDIwCfTo0Hp4z+ztHcjJ/PLVM3RUW5
zXcAn3GGM/WAV7wwlPzs7+k0GFXJI1l3
=8Otl
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--

