Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6E78C013E
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 21:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C242020004
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 21:35:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KcWTV01Supu9 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 21:35:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by silver.osuosl.org (Postfix) with ESMTPS id C46521FFFE
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 21:35:07 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 00E641C0139; Wed, 19 Feb 2020 22:35:05 +0100 (CET)
Date: Wed, 19 Feb 2020 22:35:05 +0100
From: Pavel Machek <pavel@denx.de>
To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <20200219213505.GA17284@amd>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <20200219074158.GA29804@amd>
 <OSAPR01MB50283C072294D5EC66955D12AE100@OSAPR01MB5028.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSAPR01MB50283C072294D5EC66955D12AE100@OSAPR01MB5028.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [PATCH 4.19.y-cip 00/23] Renesas RZ/G2E USB Type-C Backport
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
X-List-Received-Date: Wed, 19 Feb 2020 21:35:09 -0000
X-Groupsio-MsgNum: 4418
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> First of all, thank you for the review.

You are welcome :-).

> > > I also backported some fixes where I have found them.
> > >
> > > Tested on Si-Linux EK874 (with RZ/G2E SoC) that we have in house.
> >=20
> > Ok, so this does not look bad, but it affects other people's boards, to=
o. I went
> > through it and will have some questions/comments.
> >=20
> > Is someone else in -cip project using usb-otg? Are we reasonably sure t=
his
> > won't cause problems elsewhere?
>=20
> There are not many USB Type-C connectors, not even in upstream. For the c=
ommon
> area of the code (drivers/usb/roles/class.c) I see only two drivers that =
call
> usb_role_switch_register(), Renesas's and x86 Intel xHCI driver.
>=20
> Does linux-cip support x86 platforms?

Yes, we have several x86 configurations. But you may be right that
Type-C is less common than I thought.

cip-kernel-config/4.19.y-cip-rt/x86:
siemens_i386-rt.config	siemens_i386-rt.sources

cip-kernel-config/4.19.y-cip/x86:
plathome_obsvx2.config	   siemens_ipc227e.sources
plathome_obsvx2.sources    siemens_server_defconfig
siemens_iot2000.config	      siemens_server.sources
siemens_iot2000.sources    toshiba_atom_baytrail_cip.config
siemens_ipc227e_defconfig  toshiba_atom_baytrail_cip.sources

> I am actively trying to find what could go wrong with this implementation=
=2E Also, there
> might be another way of doing this by attaching the graph connection to t=
he port
> controller device tree node and create a device connection between the tw=
o devices
> (the role switch device and the port controller device). This might get r=
id of all the extra
> additional patches in the general area of the code (no reference to fwnod=
e), but might
> introduce modifications into the port controller driver and into the role=
 switch driver of
> Renesas.

I believe that general approach of the patches is okay. You should not
need to do big changes.

Best regards,

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5NqgkACgkQMOfwapXb+vJCWQCghGEA4i2WM8rcIpUyu5VQKhuy
Pc8An14DGoGofpMAysjHlUQDk1tRCPkC
=ygZx
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--

