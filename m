Return-Path: <SRS0=my8L=G4=lists.cip-project.org=bounce+64572+6142+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73899C433DB
	for <cip-dev@archiver.kernel.org>; Mon, 25 Jan 2021 20:44:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA23A2255F
	for <cip-dev@archiver.kernel.org>; Mon, 25 Jan 2021 20:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA23A2255F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6142+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ptGFYY4521723xmvE2dBZdeE; Mon, 25 Jan 2021 12:44:09 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.2130.1611607447964455163
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Jan 2021 12:44:08 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2FACC1C0B78; Mon, 25 Jan 2021 21:44:04 +0100 (CET)
Date: Mon, 25 Jan 2021 21:44:03 +0100
From: "Pavel Machek" <pavel@ucw.cz>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Siemens board failed to boot testing 5.10
Message-ID: <20210125204403.GA4690@duo.ucw.cz>
References: <20210125201734.GA26811@duo.ucw.cz>
MIME-Version: 1.0
In-Reply-To: <20210125201734.GA26811@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZmWyTgkHZN4d0eSRBcTrfHOdx4520388AA=
Content-Type: multipart/mixed; boundary="vIKLt6Hw4BUKFcx1rJ16"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611607449;
 bh=aq5H9u1bOqJIqjV9jkQRASeldS2WwX8oRm+MCdj/qmg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=YksuZNFsk7pM0DwCxJdPd0o4Xb+AGlrqK2LW1Jzdesc7ym+R1ZsK1lk3sZMax//ZKYP
 C5H/eSQfofzREakMeyaIUZinRpnb67a3RECyGjBfdIVCAMHaMwhwOgTWhx1pE5jW6ciOu
 XAlRoLMO0a9j5Ld4t71GANrihU7E617BCp8=

--vIKLt6Hw4BUKFcx1rJ16
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2021-01-25 21:17:34, Pavel Machek wrote:
> Hi!
>=20
> Something went wrong on siemens board... I'll try to resubmit the job.
>=20
> https://lava.ciplatform.org/scheduler/job/148648#L266

It still fails. https://lava.ciplatform.org/scheduler/job/148674. I'll
retry one more time, but this looks like permanent problem.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYA8tkwAKCRAw5/Bqldv6
8qTZAKC7TRfF/3SkHXFedtSAYh07g9GaqwCgqQZEomv6kF9pv3oFEcLs9WyJ6iM=
=8B4N
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--

--vIKLt6Hw4BUKFcx1rJ16
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6142): https://lists.cip-project.org/g/cip-dev/message=
/6142
Mute This Topic: https://lists.cip-project.org/mt/80114267/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--vIKLt6Hw4BUKFcx1rJ16--
