Return-Path: <SRS0=rPBl=D3=lists.cip-project.org=bounce+64572+5625+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AF7C4363A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 20:43:38 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB5D2224A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 20:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="qDrkUDxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB5D2224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5625+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0XmeYY4521723xg52w5Q05GQ; Tue, 20 Oct 2020 13:43:36 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.1308.1603226615859962075
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 13:43:36 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 54A881C0B77; Tue, 20 Oct 2020 22:43:33 +0200 (CEST)
Date: Tue, 20 Oct 2020 22:43:33 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [RFC PATCH 4.19.y-cip 24/50] PCI: endpoint: Replace spinlock with mutex
Message-ID: <20201020204332.GB29993@duo.ucw.cz>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201012141933.9652-25-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201012141933.9652-25-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: s8Vq8eDtIULD4o61ckzcG6IVx4520388AA=
Content-Type: multipart/mixed; boundary="17L4LE8vIQexsmKHLI6T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603226616;
 bh=STZ8aZH2Aq8a5Hv4eRvk5KsnofA30IVcoKC1XOSoHuQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=qDrkUDxqBSgH5ek5y0PvQw2RVNPDvdsjOwjKdfKS7luHLvSRQDUWMncOmLebteGnRQn
 g1LFjRgX1oHLnwfzDHBEql1HdXD5H3IBUrWwURgp7BrAqH7oNbuygAISjTxqCJGISJIc9
 //aQ/AT39T57MnJGfu+zDLt2c1ZZFmIJrW0=

--17L4LE8vIQexsmKHLI6T
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline

--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 3d3248dbd018502f654064c78efcd2e165ab3486 upstream.
>=20
> The pci_epc_ops is not intended to be invoked from interrupt context.
> Hence replace spin_lock_irqsave and spin_unlock_irqrestore with
> mutex_lock and mutex_unlock respectively.

Could I get some kind of explanation why this is good idea?

As long as code protected by the locks does not sleep, spinlocks are
okay... (but they should not need "_irqsave" variants).

They are likely to have better performance, too, when protected code
is small and fast.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX49L9AAKCRAw5/Bqldv6
8pKpAJ42SbJo2KRviUCr/uOnCxulpBOYtQCgt88FDGZy6v5TbV1iFDnpTC6iX64=
=UqPR
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--

--17L4LE8vIQexsmKHLI6T
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5625): https://lists.cip-project.org/g/cip-dev/message=
/5625
Mute This Topic: https://lists.cip-project.org/mt/77461695/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--17L4LE8vIQexsmKHLI6T--
