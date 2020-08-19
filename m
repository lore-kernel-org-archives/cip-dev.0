Return-Path: <SRS0=gXcs=B5=lists.cip-project.org=bounce+64572+5155+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B468C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 18:05:25 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1463320658
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 18:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="EOfCR4A+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1463320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5155+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JTUaYY4521723xi8szX5wSiV; Wed, 19 Aug 2020 11:05:24 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.93582.1597860322698386369
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Aug 2020 11:05:23 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 993541C0BBC; Wed, 19 Aug 2020 20:05:17 +0200 (CEST)
Date: Wed, 19 Aug 2020 20:05:05 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 01/12] arm64: dts: renesas: r8a774a1-hihope-rzg2m[-ex/-ex-idk-1110wr]: Rename HiHope RZ/G2M boards
Message-ID: <20200819180505.GB5567@amd>
References: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
 <20200819163634.5430-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200819163634.5430-2-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: w7Mss8nJZPIpVt4kMD1OFTITx4520388AA=
Content-Type: multipart/mixed; boundary="tlkx0PPx6MlGe6DgQkyk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597860324;
 bh=jPhAadZN4Kkf+TejyPQBX9p1zjUY1p2rDdNeVfQS0yQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=EOfCR4A+s+32OypiQ34VtqfLPqx/sPzDVMf5HQe2kJj37jmbKqhZ6I0prNnkoiG38pg
 ItIqRgDu7VU9IgGD82r3MZiBxv9Kxj5X2a1oxAlfggpTrbESMJ/TpiTZMz/666SfH+sPl
 NrWZuEGWQ2iUHpGVwSbGcZ9t9Dutp/7zakE=

--tlkx0PPx6MlGe6DgQkyk
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline

--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Ok, so this is anti-social:

> -dtb-$(CONFIG_ARCH_R8A774A1) +=3D r8a774a1-hihope-rzg2m.dtb
> +dtb-$(CONFIG_ARCH_R8A774A1) +=3D r8a774a1-hihope-rzg2m-rev2.dtb

This renames dts away, but at the end of series, new dts is created
with the r8a774a1-hihope-rzg2m.dts name, but this time it is for rev4
(not rev2) board.

So... people with rev2 boards and existing build script will get rev4
dts.. without any error.

Would it be better to always require explicit revision in dts/dtb
name?

Tests are running at
https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-test
=2E

Best regards,

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl89adEACgkQMOfwapXb+vJAFQCdEDLSYhenVQ1Y4hlb13vfkakT
FroAoKYjRZUibb96nf8jUaIfb1cgBxh6
=emIn
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--

--tlkx0PPx6MlGe6DgQkyk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5155): https://lists.cip-project.org/g/cip-dev/message=
/5155
Mute This Topic: https://lists.cip-project.org/mt/76290781/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--tlkx0PPx6MlGe6DgQkyk--
