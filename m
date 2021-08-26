Return-Path: <SRS0=NWme=NR=lists.cip-project.org=bounce+64572+6707+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2A2C432BE
	for <cip-dev@archiver.kernel.org>; Thu, 26 Aug 2021 11:51:34 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40CA16102A
	for <cip-dev@archiver.kernel.org>; Thu, 26 Aug 2021 11:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 40CA16102A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id sZxrYY4521723x3kzdy5KrYy; Thu, 26 Aug 2021 04:51:32 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.29385.1629978690997558276
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Aug 2021 04:51:32 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 658601C0B7A; Thu, 26 Aug 2021 13:51:27 +0200 (CEST)
Date: Thu, 26 Aug 2021 13:51:27 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries this week
Message-ID: <20210826115127.GA15147@duo.ucw.cz>
References: <CAODzB9qV4uxi2EHoPbK8D_mW6cO-Ni2x+tVUMAUYzKGK7y+COw@mail.gmail.com>
 <169ED2F66B4753DB.9667@lists.cip-project.org>
MIME-Version: 1.0
In-Reply-To: <169ED2F66B4753DB.9667@lists.cip-project.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: o9KmgLQ6Zy95hsf2PFDgg3BBx4520388AA=
Content-Type: multipart/mixed; boundary="ucabDYmKJExqwP9tojrD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629978692;
 bh=9bVdugEQRQhtQjIGJ0gvREqrC3HqHcOyrBu49jAUqH8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=TwU3Fa8xxIVmgw6gbp/JT0rKYngQDINZvi+JfJnpEuxNBj+wjGg2lcalhYh9owD6cbw
 wVPFpftc+F2F4OCd54Mj6YehmcYFYuSTqTmVru/B8YW6agaUQLfUB5/8FHUdWnOduadhs
 7tR1XKYvr0QKfHq5kIT+t5GVWQGdo3w9hHQ=

--ucabDYmKJExqwP9tojrD
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > CVE-2021-3600: eBPF 32-bit source register truncation on div/mod
> >=20
> > The vulnerability has been introduced since 4.15-rc9. 4.4 is not
> > affected. 4.19 is not fixed yet as of 2021/08/26.
> >=20
> > mainline: [e88b2c6e5a4d9ce30d75391e4d950da74bb2bd90]
> > stable/5.10: [1d16cc210fabd0a7ebf52d3025f81c2bde054a90]
> > stable/5.4: [78e2f71b89b22222583f74803d14f3d90cdf9d12]
>=20
> I took a look into this. Apparently 4.14 and 4.19 is affected. (
> https://seclists.org/oss-sec/2021/q2/228 )
>=20
> Due to BPF 32-bit subregister requirements (see bpf_design_QA.rst)
> top 32 bits should be always zero when the 32 bit registers are in
> use. So it could be possible to use BPF_JMP instead of BPF_JMP32.

Hmm, no; that is what original code did and what is known not to work
for reasons I don't fully understand.

Anyway, I asked on the lists, and according to Thadeu Lima de Souza
Cascardo Ubuntu did some work on it and is likely to do some more.

Oh, and we may want watch CVE-2021-3444, it is apparently related and
not yet fixed in 4.19.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYSeAPwAKCRAw5/Bqldv6
8g6gAJ99nRzKr61zQCd5l7kdJpDvTlRIxQCfTnt2hjTYgVNLNILo4Oif5f3lBVc=
=Ahgt
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--

--ucabDYmKJExqwP9tojrD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6707): https://lists.cip-project.org/g/cip-dev/message/=
6707
Mute This Topic: https://lists.cip-project.org/mt/85151460/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ucabDYmKJExqwP9tojrD--
