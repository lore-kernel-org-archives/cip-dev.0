Return-Path: <SRS0=58YM=7S=lists.cip-project.org=bounce+64572+4727+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A62C433E0
	for <cip-dev@archiver.kernel.org>; Fri,  5 Jun 2020 21:19:03 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E079206DC
	for <cip-dev@archiver.kernel.org>; Fri,  5 Jun 2020 21:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="aNP1yF7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E079206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4727+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id d0nwYY4521723xi86efsWuWS; Fri, 05 Jun 2020 14:19:02 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.25.1591391897406132040
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jun 2020 14:18:18 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DF3101C0BD2; Fri,  5 Jun 2020 23:18:13 +0200 (CEST)
Date: Fri, 5 Jun 2020 23:18:13 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Johnson CH Chen =?utf-8?B?KOmZs+aYreWLsyk=?= <JohnsonCH.Chen@moxa.com>
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][PATCH 4.4.y-cip 1/2] ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
Message-ID: <20200605211813.GA8852@amd>
References: <HK2PR01MB32816B8BCBF222E046FE5524FA860@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
In-Reply-To: <HK2PR01MB32816B8BCBF222E046FE5524FA860@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uWMGKB8ae4gtwUlUBdXru3Hdx4520388AA=
Content-Type: multipart/mixed; boundary="QbzjcFuPgouzVEI8mv1V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591391942;
 bh=B0puu/4sLKRjXu8wMnlF7YhKKd0MjasR1squ9Ived2o=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=aNP1yF7lcLyBmZaUA/Q86tYm3O4p139awKB6iU8JSsGcCE23XErwwn7H9rT+HCqiPT+
 rSGd53Gqsr+afUj6QRRGHUleybFdCxa3864uXzWUnUPR9b44LbXSTr0ibJGGFOTD/QEj8
 2uxbtpZpl4rQZrqIMD4E6ot1bn699brNXcA=

--QbzjcFuPgouzVEI8mv1V
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
>=20
> commit b5e5090660742c838ddc0b5d1a001e6fe3d5bfd5 upstream.

I get quite a lot of complains here, if I try to apply patch
automatically using git-am.

Applying: ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
=2Egit/rebase-apply/patch:17: trailing whitespace.
	dmas =3D <&edma_xbar 12 0 1
=2Egit/rebase-apply/patch:18: trailing whitespace.
		&edma_xbar 13 0 2>;
=2Egit/rebase-apply/patch:58: trailing whitespace.
	dmas =3D <&edma_xbar 12 0 1
=2Egit/rebase-apply/patch:59: trailing whitespace.
		&edma_xbar 13 0 2>;
=2Egit/rebase-apply/patch:71: trailing whitespace.
				edma_xbar: dma-router@f90 {
error: patch failed: arch/arm/boot/dts/am335x-evm.dts:743
error: arch/arm/boot/dts/am335x-evm.dts: patch does not apply
error: patch failed: arch/arm/boot/dts/am335x-pepper.dts:339
error: arch/arm/boot/dts/am335x-pepper.dts: patch does not apply
error: patch failed: arch/arm/boot/dts/am33xx.dtsi:162
error: arch/arm/boot/dts/am33xx.dtsi: patch does not apply
Patch failed at 0001 ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".

And it seems to me problem is in CR/LF line endings in the patch:

pavel@amd:~/cip/k$ file .git/rebase-apply/patch
=2Egit/rebase-apply/patch: unified diff output, ASCII text, with CRLF
line terminators

I believe I could somehow convince git to apply it, anyway; or maybe
to cherry-pick commits from mainline, but... Could I ask for a patch
series that can be applied using git am?

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7atpUACgkQMOfwapXb+vKZ1ACeLbFtM+EpTAn1lZ9Y0PBu1tqb
yPAAnik6aLILDtxLOsUGFxwL6wD1GB1K
=6yan
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--

--QbzjcFuPgouzVEI8mv1V
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4727): https://lists.cip-project.org/g/cip-dev/message=
/4727
Mute This Topic: https://lists.cip-project.org/mt/74689397/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--QbzjcFuPgouzVEI8mv1V--
