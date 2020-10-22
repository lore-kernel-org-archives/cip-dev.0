Return-Path: <SRS0=VGeS=D5=lists.cip-project.org=bounce+64572+5657+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F23FC388F7
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 19:42:26 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DBF52076D
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 19:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="tVRk+F4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBF52076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5657+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id K6t7YY4521723xCblNVk4V5h; Thu, 22 Oct 2020 12:42:23 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.202.1603395742718113917
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2020 12:42:23 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 858CD1C0B8C; Thu, 22 Oct 2020 21:42:17 +0200 (CEST)
Date: Thu, 22 Oct 2020 21:42:16 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [RFC PATCH 4.19.y-cip 38/50] PCI: rcar: Move shareable code to a common file
Message-ID: <20201022194216.GB9140@duo.ucw.cz>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201012141933.9652-39-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201021190647.GC10468@duo.ucw.cz>
 <OSBPR01MB50481EEBB85828E725126E51AA1C0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB50481EEBB85828E725126E51AA1C0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cRsW26uBGzr8ITZhGvEUdRYtx4520388AA=
Content-Type: multipart/mixed; boundary="bv6JdqxwlAiQM5os3QJR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603395743;
 bh=GEV0QE6Ku/mxJGMCw8I+GeImSMq4MwqYc/lE70IYLTg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=tVRk+F4tgO0OsJkIZ6ORxx5t+7ceefEAS9uZOnxZ8+n33jdahd410dOlUPBGjZ4F66S
 wfbZnlYeSTWooLIWFy/pLmw8yUqebmg8VSR3Y5oScWRAvfLYAhyk4pJnK20p9ANGL1xQY
 IVmjmMGYKiSWtaivLmnnTsvpCPuolh4J/rk=

--bv6JdqxwlAiQM5os3QJR
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline

--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > commit 78a0d7f2f5a31357bce68012d886507b4cf33598 upstream.
> > >
> > > Move shareable code to common file pcie-rcar.c and the #defines to
> > > pcie-rcar.h so that the common code can be reused with endpoint drive=
r.
> > > There are no functional changes with this patch for the host controll=
er
> > > driver.
> >=20
> > Whoa.
> >=20
> > So... original patch _moved_ shared code to new place.
> >=20
> > This version creates another copy of shared code, probably subtly
> > different from the other one.
> >=20
> > Is that good idea? Won't two copies cause problems depending on
> > .config? Could we share code, as the mainline does?
> >=20
> My main concern was this produces a big diff which would make it difficul=
t for review. And CONFIG_PCIE_RCAR_HOST by default selects CONFIG_PCIE_RCAR=
 which builds the host driver.
> pcie-rcar.c is the same as mainline only that pcie-rcar-host.c is untouch=
ed here.
>=20
> If you are OK ill post the similar changes to pcie-rcar-host.c as done in=
 the actual upstream patch.
>

I'm not 100% sure what you are proposing, but let's do that. We should
not end with two copies of the identical code in -cip, right?

> > Anyway, patches up to previous one -- [37/50] arm64: defconfig: Enable
> > CONFIG_PCIE_RCAR_HOST look okay to me, so if you can send them as
> > non-RFC version, I cal likely apply them.
> >=20
> I shall get on posting the 2nd bunch of non-RFC.

I believe we are ready for rest of the patches.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX5HgmAAKCRAw5/Bqldv6
8lDjAKCX/QV3gILfUBd+d5OCMRwhdp3h9QCeKKNNlgJG/p8KDAp8nmRbToc/xG8=
=4vRN
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--

--bv6JdqxwlAiQM5os3QJR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5657): https://lists.cip-project.org/g/cip-dev/message=
/5657
Mute This Topic: https://lists.cip-project.org/mt/77461717/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--bv6JdqxwlAiQM5os3QJR--
