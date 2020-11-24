Return-Path: <SRS0=yVyr=E6=lists.cip-project.org=bounce+64572+5863+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2AFC56202
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 19:05:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 614CA2063A
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 19:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="HTwfJL7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614CA2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5863+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BuZUYY4521723xlMSeRm4JOZ; Tue, 24 Nov 2020 11:05:23 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.1764.1606244722036078897
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 11:05:22 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E60C01C0B7D; Tue, 24 Nov 2020 20:05:17 +0100 (CET)
Date: Tue, 24 Nov 2020 20:05:17 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/9] Add USB[2.0|3.0] support
Message-ID: <20201124190517.GB7488@duo.ucw.cz>
References: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: H7DsXqxDyuwfY40XKwvZ6tP0x4520388AA=
Content-Type: multipart/mixed; boundary="zhRHJL23Wb6x486BwJHC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606244723;
 bh=kgevO0pm7t8mZiXkSF/m3KUOeovLbh/oq3egOfRel0k=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=HTwfJL7W/JeFnhdduT+nlbPe4OI+VnR5MMPgRnirHhnamkYtJT8ELr5NcuHw8Y56lb6
 GE/kKt6oTnFmizfVUz6FhA5d47tirmfdQMxdnEqBVC5m2LM8hxvcwlOGat7neEEx4IAvA
 5B+IceMCuAeUeF6EQ/7lU2Q6sGAoV6PZrPo=

--zhRHJL23Wb6x486BwJHC
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline

--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add USB2.0/USB3.0 support for iWave
> RZ/G1H platform.
>=20
> All the patches in this series are cherrypicked from mainline and
> it is based linux-4.4.y-cip.

Series looks okay to me. If there are no other comments, I can apply
it.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX71ZbQAKCRAw5/Bqldv6
8kEiAJ42K8EG80GoTEkk1TATkFhEJgmZ/wCfcABIaiKcmqkGFZTlFeNY/UlDynU=
=qQRZ
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--

--zhRHJL23Wb6x486BwJHC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5863): https://lists.cip-project.org/g/cip-dev/message=
/5863
Mute This Topic: https://lists.cip-project.org/mt/78481722/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zhRHJL23Wb6x486BwJHC--
