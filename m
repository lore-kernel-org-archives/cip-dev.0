Return-Path: <SRS0=OWcT=KY=lists.cip-project.org=bounce+64572+6481+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FA3C47082
	for <cip-dev@archiver.kernel.org>; Sat, 29 May 2021 07:53:31 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40FB9613D1
	for <cip-dev@archiver.kernel.org>; Sat, 29 May 2021 07:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FB9613D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6481+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Wv8EYY4521723xAV2A8qcNDB; Sat, 29 May 2021 00:53:29 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.18714.1622274808091355579
 for <cip-dev@lists.cip-project.org>;
 Sat, 29 May 2021 00:53:28 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9DD3A1C0B76; Sat, 29 May 2021 09:53:23 +0200 (CEST)
Date: Sat, 29 May 2021 09:53:22 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] IRC meeting will move from Freenode to Libera.chat
Message-ID: <20210529075322.GA13576@amd>
References: <TY2PR01MB4972BBF102F94DD7A9DBB7FAA0219@TY2PR01MB4972.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB4972BBF102F94DD7A9DBB7FAA0219@TY2PR01MB4972.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: H3uno8LvRUjKKgPWrdVzQzNux4520388AA=
Content-Type: multipart/mixed; boundary="kwkM1PQ8sdLNeEoY3fR9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622274809;
 bh=neyHDbkiIuITxh2fcba8F2U1MPCL/dTOK4SIULlxaMU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Ba0a2aEW9aM7QFcpk8PBkmlXV5c6RQBuR9skQC6MYpx0YL1JMLzNBKK03psjs4T8W9z
 Kpg7wTrPwipKJ80Ihfxs4rLXMkLCIIONEaLBWLA6bmH1Bv9h1TrRWnQ6HPyQTqcApYuQD
 tPmqE7AziQyF5zuAWKj3JCxCYqyJQraoB2Y=

--kwkM1PQ8sdLNeEoY3fR9
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> As we discussed at the last IRC meeting, we are going to use Libera.chat =
for our IRC meetings starting on June 3rd.
> Many thanks to Alice for this setup.
>=20
> The new channel is as follows:
> irc:irc.libera.chat:6667/cip

Makes sense, but it looks like we'll need to update wiki:

https://wiki.linuxfoundation.org/civilinfrastructureplatform/start
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/cip=
testingwg

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCx8vIACgkQMOfwapXb+vJlDwCgpbAmVRKQvRRfqersgiYIA9Ja
xJ0An0ygKUZICKLPbYsa7gD4wHUGMZgZ
=Spiw
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

--kwkM1PQ8sdLNeEoY3fR9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6481): https://lists.cip-project.org/g/cip-dev/message=
/6481
Mute This Topic: https://lists.cip-project.org/mt/83162075/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--kwkM1PQ8sdLNeEoY3fR9--
