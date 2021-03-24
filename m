Return-Path: <SRS0=h3nj=IW=lists.cip-project.org=bounce+64572+6324+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530AFC433DB
	for <cip-dev@archiver.kernel.org>; Wed, 24 Mar 2021 09:59:04 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D88D619B4
	for <cip-dev@archiver.kernel.org>; Wed, 24 Mar 2021 09:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D88D619B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6324+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6qFQYY4521723xFJCqiztIBa; Wed, 24 Mar 2021 02:59:02 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.3561.1616579941805098282
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Mar 2021 02:59:02 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2022B1C0B7D; Wed, 24 Mar 2021 10:58:57 +0100 (CET)
Date: Wed, 24 Mar 2021 10:58:56 +0100
From: "Pavel Machek" <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.19.182-cip45-rt19
Message-ID: <20210324095856.GA1682@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: iHHf3WwlXEZhB1E6Q9iAQvxhx4520388AA=
Content-Type: multipart/mixed; boundary="Kp2rVLvNYHpmcOBIinUD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616579942;
 bh=iGo7WSYSrnbkO26r0FhUvdrhn3/C8FbFWhjgLQ3uUBw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=sbTp2mPpp+lXo9Crea+yrqzDkezqzvglMGysV9hJvPSIJJjXEcPtpwNi/f1nhh/DzYO
 eEGeYHqFVIc7Ymhh/nP0i2xC5NG5nTU0S75Xdw47nvdTOn3m8SDzB2J4k6cZIw865MMZm
 GPyj/jVtlAyD1KliOFJ7ODrhSKvJueXflWc=

--Kp2rVLvNYHpmcOBIinUD
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org. They are based
on -rt74 upstream version.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt-rebase

And their content should be identical.

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYFsNYAAKCRAw5/Bqldv6
8qjGAJ986F0/Ox58ldDbCBQmYdBZqVVhaACdECWnXNElsTzoITM7DZOsZNExhiA=
=olyl
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--

--Kp2rVLvNYHpmcOBIinUD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6324): https://lists.cip-project.org/g/cip-dev/message=
/6324
Mute This Topic: https://lists.cip-project.org/mt/81572923/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Kp2rVLvNYHpmcOBIinUD--
