Return-Path: <SRS0=s0mM=E6=lists.cip-project.org=bounce+64572+5864+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54B6C2D0E4
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 19:27:48 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9CE720857
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 19:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="jzhWNBKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CE720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5864+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id eXJIYY4521723xJOVipTHnt7; Tue, 24 Nov 2020 11:27:46 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.1864.1606246065797514788
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 11:27:46 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 941AE1C0B7D; Tue, 24 Nov 2020 20:27:42 +0100 (CET)
Date: Tue, 24 Nov 2020 20:27:41 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH] dt-bindings: PCI: rcar: Add device tree support for r8a7742
Message-ID: <20201124192741.GA4916@amd>
References: <20201124174036.14934-1-biju.das.jz@bp.renesas.com>
 <20201124175808.GA2713@duo.ucw.cz>
 <TYBPR01MB5309F702E453CCBB5987FB8186FB0@TYBPR01MB5309.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TYBPR01MB5309F702E453CCBB5987FB8186FB0@TYBPR01MB5309.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2KWyWBoz11wfpv24jVe4QMESx4520388AA=
Content-Type: multipart/mixed; boundary="ekDKxTQY0qH0UL8Csmmv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606246066;
 bh=qa9ABgoBd4kmEez71yTwPXR2ABCKlBVn7soYzxOPCUc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=jzhWNBKVyVMPuQs44Mt0HLM6FQ731J03oINAsUAOpCWjcbCBYwfWJZaS+nrTqfUpw8+
 UJGab621C8sztfPW8+tWCLDcfxBLTtx1OHUMYUeZ5X6TRpbAur0+9GD1EELWlz7MdBv81
 kjYMcVLxSV0wX0Zng2oXFQmXcuwsAewIem8=

--ekDKxTQY0qH0UL8Csmmv
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Thanks for the feedback.

> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > commit d16d538ff49145b153976bd8e124116d369db266 upstream.
> > >
> > > Add support for r8a7742. The Renesas RZ/G1H (R8A7742) PCIe controller
> > > is identical to the R-Car Gen2 family.
> >=20
> >=20
> > Sure, we can apply this (I assume it is for 4.4)? But it will not really
> > add any support, it just documents the binding... so I assume this shou=
ld
> > go into series with patches that actually change the dts (and probably
> > tweak the drivers)?
>=20
> We have already backported PCIEC[1] to Linux-4.4.y-cip. Only dt binding p=
atch was pending.
>

Aha. Sorry for the noise. I'll apply it if there are no other
comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+9Xq0ACgkQMOfwapXb+vJxuACgvPlJfLnI14CShDEmNwdWXT8I
cDEAmQHi5pUddCMBHeYr6XtqzBQJG0fr
=iZeC
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

--ekDKxTQY0qH0UL8Csmmv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5864): https://lists.cip-project.org/g/cip-dev/message=
/5864
Mute This Topic: https://lists.cip-project.org/mt/78482468/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ekDKxTQY0qH0UL8Csmmv--
