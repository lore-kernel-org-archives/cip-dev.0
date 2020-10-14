Return-Path: <SRS0=XDb1=DV=lists.cip-project.org=bounce+64572+5577+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD50C433E7
	for <cip-dev@archiver.kernel.org>; Wed, 14 Oct 2020 14:14:06 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7427A22201
	for <cip-dev@archiver.kernel.org>; Wed, 14 Oct 2020 14:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="i8Jc891w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7427A22201
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5577+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 9qpZYY4521723xtaqnMAa1sJ; Wed, 14 Oct 2020 07:14:03 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.35.1602684842030257192
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Oct 2020 07:14:02 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EA7B41C0B7C; Wed, 14 Oct 2020 16:13:55 +0200 (CEST)
Date: Wed, 14 Oct 2020 16:13:55 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Jan Kiszka <jan.kiszka@siemens.com>, wens@csie.org
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Backporting of security patches for Intel i40e drivers required?
Message-ID: <20201014141355.GA16362@duo.ucw.cz>
References: <TY2PR01MB49721EDA34600391409FFB07A00B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <OSBPR01MB298313D24CA5EF5B0517AB4792080@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <d5baee23-9a71-6994-146d-1b54d42d1ef9@siemens.com>
MIME-Version: 1.0
In-Reply-To: <d5baee23-9a71-6994-146d-1b54d42d1ef9@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: u7AcYbnDG09rNnUi0jTUtv3Sx4520388AA=
Content-Type: multipart/mixed; boundary="3rlWOIe7UlYXf1aJgP4C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602684843;
 bh=jnqm6lKhY6+fQHxxCW80JrNsCebgXdIRsUfTKNXB08M=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=i8Jc891wqqsv4zqI+VWj72kO9C4t0pFtWRfTn7hrEVhvzmcMi12igBt2QGqvCmnWFUD
 1j82PdnvRGEJzsxNXYeKabVDAgfs50hzrtMljv4lIaNWR0qS84AdyAiF+Tn3uMIvjImJa
 1nD+O8yXpr+N3/OwGDsoS67pXbHJi30yHws=

--3rlWOIe7UlYXf1aJgP4C
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> given the exposure of such a device but also the fact that I can't tell
> for sure if/where it's used (not only by us), I would recommend backporti=
ng.

> > There are multiple patches fixed for 4.19, which can be separated by fe=
ature.
> >=20
> >  - i40e: add num_vectors checker in iwarp handler
> >=20
> >      This issue has been produced by e3219ce6a7754 ("i40e: Add support =
for client interface for IWARP driver").
> >      e3219ce6a7754 is not included in 4.4.y and can be ignored.

It is interesting this one is listed in both CVE-145, CVE-147 in
cip-kernel-sec. Is that an error?

> >  - i40e: Wrong truncation from u16 to u8
> >    This can be apply in 4.4.y.
> >=20
> >  - i40e: Fix of memory leak and integer truncation in i40e_virtchnl.c
> >=20
> >    This issue has been produced by e284fc280473b ("i40e: Add and delete=
 cloud filter").
> >    It is not included in 4.4.y. However, this patch has several differe=
nt fixes, so some patches need to be applied.

I see also

- i40e: Set RX_ONLY mode for unicast promiscuous on VLAN

which apparently allows people to listen to packets they should not
see. But I assume this requires elevated priviledges to begin with...

Best regards,
                                                                Pavel
--
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX4cHowAKCRAw5/Bqldv6
8qixAJwMtLTxkYvPOgQg9wxNOlJrbF0QAwCaAsZWZa7CrVZwAGltkXJAYSbd2xo=
=w8HZ
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

--3rlWOIe7UlYXf1aJgP4C
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5577): https://lists.cip-project.org/g/cip-dev/message=
/5577
Mute This Topic: https://lists.cip-project.org/mt/77380165/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--3rlWOIe7UlYXf1aJgP4C--
