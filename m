Return-Path: <SRS0=dbgn=ED=lists.cip-project.org=bounce+64572+5684+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68661C55178
	for <cip-dev@archiver.kernel.org>; Wed, 28 Oct 2020 15:26:43 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087C7247C5
	for <cip-dev@archiver.kernel.org>; Wed, 28 Oct 2020 15:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="gMUWbLIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087C7247C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5684+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Zgo5YY4521723xApuLUHytWZ; Wed, 28 Oct 2020 08:26:41 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.10696.1603898799889060527
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Oct 2020 08:26:40 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7B4E31C0BA9; Wed, 28 Oct 2020 16:26:35 +0100 (CET)
Date: Wed, 28 Oct 2020 16:26:35 +0100
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/5] Add PCIe EP nodes to RZ/G2{EMN}
Message-ID: <20201028152635.GA26388@duo.ucw.cz>
References: <20201027165622.28777-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201027165622.28777-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UfCeJ4FyFzZGVQiIZ1MBUaYMx4520388AA=
Content-Type: multipart/mixed; boundary="nAIkQuKgdAWXGUmqH0j5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603898801;
 bh=MP3W0QQ/j9hkRivB8Ef9KM93qXfAF+4gxwzRuScGMcs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=gMUWbLIHN5CfaENWyIDlPVDRajLwsSvhfeNay4JkVo42Qy2RY2R2t7xY2T3OuU3e00G
 nh6coRgPPz4p43GfEaad/xG+aN7yfGWHH+vXup3F5lOWe7nrVi93rdCvW22IW/gnY2Fs3
 2JwuGNyRCEJNcfJzvAqyMawBn6llpkM40e8=

--nAIkQuKgdAWXGUmqH0j5
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> These patches are part of RFC series [1] ({43-46,48}/50),
> these were dropped earlier as they weren't part of -rc release
> at the time of posting now that patches have landed in v5.10-rc1
> I am resending them with non-RFC tag.
>=20
> [1] https://patchwork.kernel.org/project/cip-dev/
>     list/?series=3D363279&state=3D%2A&archive=3Dboth

Series looks good to me.

>  arch/arm64/boot/dts/renesas/r8a774a1.dtsi     | 38 +++++++++++++++++++
>  arch/arm64/boot/dts/renesas/r8a774b1.dtsi     | 38 +++++++++++++++++++
>  arch/arm64/boot/dts/renesas/r8a774c0.dtsi     | 19 ++++++++++

I see that the nodes are stil marked as "disabled"... I guess
devboards are not plugged into into PCIe hosts for the testing.

Anyway, it would be good to know if the merged -cip code was tested
and what was the result :-).

Best regards,
								Pavel


--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX5mNqwAKCRAw5/Bqldv6
8pSzAKCrC/b78hJ1JLfZ7r1BvwRle+vFSACfVk3+HyDRPKplTi3ix5HLiFQMeI0=
=ceCr
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--

--nAIkQuKgdAWXGUmqH0j5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5684): https://lists.cip-project.org/g/cip-dev/message=
/5684
Mute This Topic: https://lists.cip-project.org/mt/77842959/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--nAIkQuKgdAWXGUmqH0j5--
