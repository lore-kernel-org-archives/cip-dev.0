Return-Path: <SRS0=k7kA=IQ=lists.cip-project.org=bounce+64572+6290+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8CAC433E0
	for <cip-dev@archiver.kernel.org>; Thu, 18 Mar 2021 07:25:40 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912DF64F01
	for <cip-dev@archiver.kernel.org>; Thu, 18 Mar 2021 07:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912DF64F01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6290+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 9TXOYY4521723xQdhoc7KJYe; Thu, 18 Mar 2021 00:25:38 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.5879.1616052336925350804
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Mar 2021 00:25:37 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 995A81C0B77; Thu, 18 Mar 2021 08:25:31 +0100 (CET)
Date: Thu, 18 Mar 2021 08:25:29 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Message-ID: <20210318072529.GA527@amd>
References: <TY2PR01MB4972E281920DEC8CA74B9B17A0699@TY2PR01MB4972.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB4972E281920DEC8CA74B9B17A0699@TY2PR01MB4972.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 9zLGCdZhuKkqSgOjhwY6ktLix4520388AA=
Content-Type: multipart/mixed; boundary="gDG9QUVSNmrD8UjinU6c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616052338;
 bh=6H9akueBB5mZqRJiiOkr+wAIR3mqW8UbE+DjmI77dDo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=GywQPoTE7s1GsySzL9XHXjfcngLR2lT79K6XhxqHn/aqzXSbtmiecBpnbdmx/HCLd8n
 St/l+tOYYsMj8L9MCZzr7Y1A13ZZQcI/viNFWgMFkpxyFAjGMZMzq/kldpmgI3W0gZAu2
 RTrzgcsbwxBeuOGxPvJ5XSqEhZvTTMd5u2U=

--gDG9QUVSNmrD8UjinU6c
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> Kindly be reminded to attend the weekly meeting through IRC to discuss te=
chnical topics with CIP kernel today.
>

I'll not be able to make it to the irc meeting in time.

I have reviewed patches queued for 5.10.24, and am still working on
those.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmBTAGgACgkQMOfwapXb+vKx0QCgrZ7LgABqXN7qswBFXkKcAFdC
J0oAoKp8PkDtjEMyZF62Ea5HKadmF/4u
=Aygm
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

--gDG9QUVSNmrD8UjinU6c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6290): https://lists.cip-project.org/g/cip-dev/message=
/6290
Mute This Topic: https://lists.cip-project.org/mt/81421400/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gDG9QUVSNmrD8UjinU6c--
