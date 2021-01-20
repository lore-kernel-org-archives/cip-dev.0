Return-Path: <SRS0=6YFu=GX=lists.cip-project.org=bounce+64572+6120+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE4BC433E0
	for <cip-dev@archiver.kernel.org>; Wed, 20 Jan 2021 19:28:16 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F241E233FE
	for <cip-dev@archiver.kernel.org>; Wed, 20 Jan 2021 19:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F241E233FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6120+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6utLYY4521723x6hDbEcPOdj; Wed, 20 Jan 2021 11:28:15 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.33156.1611170894205846109
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Jan 2021 11:28:14 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8CE3D1C0B8A; Wed, 20 Jan 2021 20:28:10 +0100 (CET)
Date: Wed, 20 Jan 2021 20:28:10 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] Renesas support for 5.10
Message-ID: <20210120192809.GB24348@duo.ucw.cz>
References: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2VZjHxe0ppYoAO7sbsMoNyxTx4520388AA=
Content-Type: multipart/mixed; boundary="aPc8qyOZBAk2y5T1Wi6b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611170895;
 bh=gaUarnh/C3f9LSBnKmC77C3fc54EJcGK3EAuJ3HNv08=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=UGtJzr/G57I1OxHeKrrYCxAay0XPncyli4DWiZFhizeM4NFvK8myNmuaWyNud0G7UiV
 4Nu2zN1yUopFuiuCWGvHKbksuwHmd35crLVfhQGtEfjT3B4iBEAtw61bO9/nVjYx30JdP
 +Chx8tCvK4p6SFCpWDlqCc8pjjP/HR1FD3Y=

--aPc8qyOZBAk2y5T1Wi6b
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline

--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I believe there are few patches in linux-4.19.y-cip that were
backported from 5.11-rc.

Could we get those patches submitted in the usual format?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYAiESQAKCRAw5/Bqldv6
8rMJAKCJeNkYLkoKA2rnY0gzlpYyyJFd0wCgus6Wek/aqyGQ+1roc2m3bMPgd20=
=pPLE
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

--aPc8qyOZBAk2y5T1Wi6b
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6120): https://lists.cip-project.org/g/cip-dev/message=
/6120
Mute This Topic: https://lists.cip-project.org/mt/79986495/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--aPc8qyOZBAk2y5T1Wi6b--
