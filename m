Return-Path: <SRS0=DBKV=CS=lists.cip-project.org=bounce+64572+5432+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7109CC43461
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 06:31:56 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF5520936
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 06:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pGyW506l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF5520936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5432+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0qlRYY4521723xJUhvzIcHoj; Tue, 08 Sep 2020 23:31:55 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.7848.1599633113468571828
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2020 23:31:53 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 274DF1C0B79; Wed,  9 Sep 2020 08:31:50 +0200 (CEST)
Date: Wed, 9 Sep 2020 08:31:49 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip v2] of: Add missing exports of node name compare functions
Message-ID: <20200909063149.GB27139@duo.ucw.cz>
References: <20200904065901.11195-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200904065901.11195-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bkGuIVS8nl3ZO487hQ1YR8YFx4520388AA=
Content-Type: multipart/mixed; boundary="GSYSeEMF3blmyWLCuXyh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599633115;
 bh=uxzrRiQDp4SG+hzlfY1+MbEaYbdn2bSAu75NWkkurLM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=pGyW506ld/93YdWUfMbHSnXEueQ1Tzs10PEQUzEkDj/LDw5RODAJKRw3klbSpBAX4a/
 V4EVQecf2XqwS7KUnrT1XxbhmazGjg+j5LR5gUWlDrqQ6anP0M4jn3YpEcZ9kfQD5QnfR
 EAdtdZG4TUZQs9FkElaL+hagc+uUuC9HGhs=

--GSYSeEMF3blmyWLCuXyh
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline

--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Rob Herring <robh@kernel.org>
>=20
> commit 173ee3962959a1985a109f81539a403b5cd07ae7 upstream.
>=20
> Commit f42b0e18f2e5 ("of: add node name compare helper functions")
> failed to add the module exports to of_node_name_eq() and
> of_node_name_prefix(). Add them now.

Thanks, applied and pushed out.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX1h21QAKCRAw5/Bqldv6
8n7xAKCUstbWJ0yvSmqmWqwDnmN4+IC5KwCgrLYHUME8a874OnfQNpji5h82I78=
=ANav
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--

--GSYSeEMF3blmyWLCuXyh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5432): https://lists.cip-project.org/g/cip-dev/message=
/5432
Mute This Topic: https://lists.cip-project.org/mt/76624733/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--GSYSeEMF3blmyWLCuXyh--
