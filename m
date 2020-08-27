Return-Path: <SRS0=wjUa=CF=lists.cip-project.org=bounce+64572+5284+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1FAC433DF
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 13:10:33 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F0E3206F0
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 13:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="UyBhFlxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0E3206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5284+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id H0FqYY4521723xjQvLwygmjU; Thu, 27 Aug 2020 06:10:32 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.18482.1598533830644070929
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Aug 2020 06:10:31 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EA2121C0BB4; Thu, 27 Aug 2020 15:10:25 +0200 (CEST)
Date: Thu, 27 Aug 2020 15:10:25 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, nobuhiro1.iwamatsu@toshiba.co.jp,
	Chris.Paterson2@renesas.com,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev] Everything failed in gitlab
Message-ID: <20200827131025.GA28744@duo.ucw.cz>
References: <12b9b0c0-7117-81fc-8360-a0bd858715a8@siemens.com>
 <20200827082132.ca3vmztk43723bas@kratos.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200827082132.ca3vmztk43723bas@kratos.fritz.box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: BdiaRtgSpDVWP75qogIUVjeqx4520388AA=
Content-Type: multipart/mixed; boundary="kRDqpwZf4eZZKryQ9Xsj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598533832;
 bh=nrNSFDPD7qa8AuAm7aRvUl6dfLe8v6UW2g9FP+zADgc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=UyBhFlxcMmY0YPlB1aVO8C95jbaEFqivM+P8nqsjnBy20q/12gSKA9tV0wTzYW/afDL
 UiOHTDoRhKHVVap6QpkAFfHpGmLbtV8jwE8C3Xa4zInXCotc2SwqtoTaWcNPY1Zg/U8eG
 OVmN08d32u3IFkXf6IQz0nro0NKdCm0bcSg=

--kRDqpwZf4eZZKryQ9Xsj
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Michael, Quirin, any ideas?
>=20
> yes. I took a brief look at the logs and found the problem:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> Aug 27 08:16:05 ip-172-20-42-140 kubelet[2152]: E0827 08:16:05.109337    =
2152 kuberuntime_manager.go:784] container start failed: ErrImagePull: rpc =
error: code =3D Unknown desc =3D Error response from daemon: Get https://re=
gistry.gitlab.com/v2/cip-project/cip-testing/linux-cip-ci/manifests/build-v=
3: unauthorized: HTTP Basic: Access denied
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>=20
> =3D> HTTP Basic: Access denied
>=20
> Please check your setup/permissions?

I believe that Chris is unavailable this week. Is there anyone else
that knows how this is supposed to work?

Best regards,
								Pavel

--
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX0ewwQAKCRAw5/Bqldv6
8og3AKCanhj7ToKwZ6V7lH2vUCa6pf3x1wCeOPw29nB18p6RFV0G+KbTLF1sHyw=
=u3Mh
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--

--kRDqpwZf4eZZKryQ9Xsj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5284): https://lists.cip-project.org/g/cip-dev/message=
/5284
Mute This Topic: https://lists.cip-project.org/mt/76423839/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--kRDqpwZf4eZZKryQ9Xsj--
