Return-Path: <SRS0=2om6=ND=lists.cip-project.org=bounce+64572+6674+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6BFC4338F
	for <cip-dev@archiver.kernel.org>; Thu, 12 Aug 2021 05:43:47 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A057460FED
	for <cip-dev@archiver.kernel.org>; Thu, 12 Aug 2021 05:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A057460FED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PRyXYY4521723x30JAgea1lU; Wed, 11 Aug 2021 22:43:46 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.18448.1628747024305946336
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Aug 2021 22:43:45 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 973C61C0B76; Thu, 12 Aug 2021 07:43:37 +0200 (CEST)
Date: Thu, 12 Aug 2021 07:43:37 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries this week
Message-ID: <20210812054337.GA26920@duo.ucw.cz>
References: <CAODzB9q2GjB-rsuq-Ro43yZvVKHY-joQKiXWYx_iqowfwexVCA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODzB9q2GjB-rsuq-Ro43yZvVKHY-joQKiXWYx_iqowfwexVCA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: oScyHEerDOIlc2shUpp0E5qlx4520388AA=
Content-Type: multipart/mixed; boundary="0bz8Pty3MUdo3VpdKcth"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628747026;
 bh=qP4l5eHUUB0GeSECPgF06U5GIrio0nteh9PFpFIAVUw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=WnWrNfavbdUROCQrJn9BRVaRrsbeoUFX20w4V8gkqMes8LOy56EXQt5Mav/hsKzvlQv
 vljIuw7hJB/ODKO4DYJwVE7FsE35BVDttF8vJASkGQH4i26WzbMpSGpYyeIyE73vNp8PO
 rntUGpJ9Yqh9iRAEz68+iKDxWfK7FlFSkvM=

--0bz8Pty3MUdo3VpdKcth
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * CVE detail
>=20
> New CVEs

> CVE-2021-38205: net: xilinx_emaclite: Do not print real IOMEM pointer
>=20
> xemaclite_of_probe() in drivers/net/ethernet/xilinx/xilinx_emaclite.c
> leaks kernel memory layout.
>=20
> Fixed status
>=20
> mainline: [d0d62baa7f505bd4c59cd169692ff07ec49dde37]
> stable/5.13: [8722275b41d5127048e1422a8a1b6370b4878533]

This affects our kernels (I looked at 5.10.57 and 4.4.277). On one
hand we could ask for backport, on the other... I'm not sure it is
serious enough to warrant any action.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYRS1CQAKCRAw5/Bqldv6
8p4NAJ9Jt8ggoTjf7WFcs85Bm7xt3pf7DgCfSyy+NDj/44kTBuDnhJT9qzT/9js=
=jfLP
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--

--0bz8Pty3MUdo3VpdKcth
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6674): https://lists.cip-project.org/g/cip-dev/message/=
6674
Mute This Topic: https://lists.cip-project.org/mt/84830495/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--0bz8Pty3MUdo3VpdKcth--
