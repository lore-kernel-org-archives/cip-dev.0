Return-Path: <SRS0=q+VB=DW=lists.cip-project.org=bounce+64572+5583+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C43C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 15 Oct 2020 18:01:24 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEC7C2225F
	for <cip-dev@archiver.kernel.org>; Thu, 15 Oct 2020 18:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="NUlMin9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC7C2225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5583+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MF9YYY4521723xXFQsY8vzaL; Thu, 15 Oct 2020 11:01:22 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.18640.1602784880416600849
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Oct 2020 11:01:21 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id AC04D1C0B77; Thu, 15 Oct 2020 20:01:15 +0200 (CEST)
Date: Thu, 15 Oct 2020 20:01:15 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [RFC PATCH 4.19.y-cip 41/50] PCI: rcar: Add endpoint mode support
Message-ID: <20201015180115.GA14732@duo.ucw.cz>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201012141933.9652-42-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201014092226.GA1866@amd>
 <OSBPR01MB5048542ADFEDC0D29EE57D8CAA020@OSBPR01MB5048.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB5048542ADFEDC0D29EE57D8CAA020@OSBPR01MB5048.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: nxPfgVQjXUQu3WKITM4E3UCMx4520388AA=
Content-Type: multipart/mixed; boundary="wTia7fSnx6CyefG8sI3T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602784882;
 bh=L/TLjo3Fxh607fAcrQW7M7qLQTm8ANsJFDR5N0BWkv8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=NUlMin9SixtibLrpnZ80kj18jhRNgj5Dlr8U2wEZ42e5OHRFnlQdq7EH+AZ+NXEQyU+
 SB+NqYEB+hJx7AKtl5KGae6t5GpgyAtcAkk7uSFSTN5MPYwXZCZ0v0RP996R1fFZhH4dY
 R8KyOhuKwtrCfL8lqbiZLzAHKD2NJ0n+lpU=

--wTia7fSnx6CyefG8sI3T
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Plain 0 would be enough
> >
> Agreed.
>=20
> Ill post patches upstream to fix this and then backport or do you
>want me to do the changes in place ?

Yes, thank you.

> > > +val |=3D ASTINTX;
> > > +rcar_pci_write_reg(pcie, val, PCIEINTXR);
> > > +usleep_range(1000, 1001);
> > > +val =3D rcar_pci_read_reg(pcie, PCIEINTXR);
> >
> > This is crazy. Either you need exact timing or you don't, but I don't
> > believe usleep can guarantee microsecond accuracy.
> >
> > (And you probably don't need it, right?)
> >
> Indeed a sleep is needed but checkpatch complains about it so usleep_rang=
e() was added.

checkpatch should not be an excuse for crazy code... and this one is
crazy.

Sleep has nowhere near microsecond accuracy. If you can tolerate
bigger delay, feel free to specify reasonable range. But in this case
you probably want "as close as possible to 1msec", and no,
usleep_range is not right primitive for that.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX4iOawAKCRAw5/Bqldv6
8o2aAJwKrgW3CogggCetMqn8/9lwyoDWIwCeOyHKO8B4ha3WBpIA5DrlYERRdA0=
=wQFn
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--

--wTia7fSnx6CyefG8sI3T
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5583): https://lists.cip-project.org/g/cip-dev/message=
/5583
Mute This Topic: https://lists.cip-project.org/mt/77461723/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--wTia7fSnx6CyefG8sI3T--
