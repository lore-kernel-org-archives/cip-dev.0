Return-Path: <SRS0=FPUr=LP=lists.cip-project.org=bounce+64572+6564+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47EBC4743C
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 21:12:28 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A61261289
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 21:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A61261289
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6564+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id m8GEYY4521723xBfFAW8Ez7B; Mon, 21 Jun 2021 14:12:27 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.3304.1624309946366808560
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Jun 2021 14:12:27 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C2A301C0B76; Mon, 21 Jun 2021 23:12:22 +0200 (CEST)
Date: Mon, 21 Jun 2021 23:12:22 +0200
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/16] Renesas RZ/G2 sync patches from 4.19-cip to 5.10-cip
Message-ID: <20210621211222.GA2230@amd>
References: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1pqJEXgAwoQaXy9MBbnEJPp0x4520388AA=
Content-Type: multipart/mixed; boundary="QNE7lBPQuhw0OjctgvtN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624309947;
 bh=MZr/VXuhusiNG1P97HbkXJUZYQORtLh7P4h9SqwAiMI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=n/KUvC8yYY/MJiY7e1cGxOd7le9D0cRTgsGxe+GZWnlIxpzGlbPZiB/SjsPMlO4Tpxk
 EhPolDtAV2sd2x3I7w3jqdt2ZEM0o3f05Y+g3k3QBiNCprodj+OXYWFgBP5RWH9B7wNuS
 +xteT/91LzN8Ivg0qq5WsfPkF8em+AUUFGA=

--QNE7lBPQuhw0OjctgvtN
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series sync's patches from 4.19-cip to 5.10-cip.
>=20
> All the patches have been cherry-picked from upstream.

Looks good to me. I'll apply it if there are no other comments.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmDRALYACgkQMOfwapXb+vJSXgCfeASvbtrkP60yO4Na/M5EVHuk
MCMAn3EhZ1U6MZjLNJJYfziBYkvp2UR+
=FS0o
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--

--QNE7lBPQuhw0OjctgvtN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6564): https://lists.cip-project.org/g/cip-dev/message=
/6564
Mute This Topic: https://lists.cip-project.org/mt/83693866/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--QNE7lBPQuhw0OjctgvtN--
