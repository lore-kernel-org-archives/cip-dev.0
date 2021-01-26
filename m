Return-Path: <SRS0=FoN+=G5=lists.cip-project.org=bounce+64572+6144+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF35DC433E0
	for <cip-dev@archiver.kernel.org>; Tue, 26 Jan 2021 11:54:39 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D9523110
	for <cip-dev@archiver.kernel.org>; Tue, 26 Jan 2021 11:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D9523110
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6144+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 21p3YY4521723xRxT6pqp0Ya; Tue, 26 Jan 2021 03:54:38 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.10966.1611662077352114216
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Jan 2021 03:54:37 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id AE6471C0B7D; Tue, 26 Jan 2021 12:54:32 +0100 (CET)
Date: Tue, 26 Jan 2021 12:54:31 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Chris.Paterson2@renesas.com, "Bhola, Bikram" <Bikram_Bhola@mentor.com>
Subject: Re: [cip-dev] Siemens board failed to boot testing 5.10
Message-ID: <20210126115431.GA28355@amd>
References: <20210125201734.GA26811@duo.ucw.cz>
 <20210125204403.GA4690@duo.ucw.cz>
 <56263cba-5556-4960-a91f-62835783081c@siemens.com>
MIME-Version: 1.0
In-Reply-To: <56263cba-5556-4960-a91f-62835783081c@siemens.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: tjwT2DHU2oCU3GQuHl1EcAFXx4520388AA=
Content-Type: multipart/mixed; boundary="YWkIMoeXrFmEFzDRQew2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611662078;
 bh=2yy6xeslALod/DdsB0HqDcpPWDkKuLFDl/FxUgCSCfM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=D/ALhQ0I00s6bNZPEHAnT8IlY4I9UV0f69mc03AzRf6NsWR59CBgFGNQrEyZgE3flYl
 o7u+HNaa6RsNJitLFP/jhUYhg1RJitpNwx4qvATzxGDWlC8wuoKZRMxDwH5MJr6jk7Wyp
 Cyiy1FXOJOr1eltkgU5y64ZFzp1fT6aUIQo=

--YWkIMoeXrFmEFzDRQew2
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Something went wrong on siemens board... I'll try to resubmit the job.
> >>
> >> https://lava.ciplatform.org/scheduler/job/148648#L266
> >=20
> > It still fails. https://lava.ciplatform.org/scheduler/job/148674. I'll
> > retry one more time, but this looks like permanent problem.
> >=20
>=20
> Do you mean the board does not come up with any job, or just with 5.10?
> Doesn't it react at all (dead hw)?

I don't believe it is dead hw.

> And where is this one located? We have IPC227E at Mentor and at Denx now.

I'm sorry, I don't know much about test infrastructure.

5.10.11-rc2 tests passed okay, but I'm not sure if it has any
implications.

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

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

iEYEARECAAYFAmAQAvcACgkQMOfwapXb+vLtpwCfZ+pVh2QTQTxNoVnHGxOhUocd
IIQAnAw03IwBJT3lUuhI2CKeJErzOafP
=Pu8e
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--

--YWkIMoeXrFmEFzDRQew2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6144): https://lists.cip-project.org/g/cip-dev/message=
/6144
Mute This Topic: https://lists.cip-project.org/mt/80114267/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--YWkIMoeXrFmEFzDRQew2--
