Return-Path: <SRS0=q2D5=EI=lists.cip-project.org=bounce+64572+5711+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10C6C2D0A3
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 21:12:34 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50DA207BB
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 21:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="vpZ5DXXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50DA207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5711+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rOvnYY4521723xH93JbR9EsC; Mon, 02 Nov 2020 13:12:32 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.448.1604351551511962489
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2020 13:12:32 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B15A91C0B87; Mon,  2 Nov 2020 22:12:25 +0100 (CET)
Date: Mon, 2 Nov 2020 22:12:25 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Cc: Chen-Yu Tsai <wens@csie.org>, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] cip-kernel-sec Updates for Last Week of October
Message-ID: <20201102211225.GA2874@duo.ucw.cz>
References: <CAGb2v65-9JX36eScv7_ZUo7Yx69cpb331qYrLaUTvda7H3cf6A@mail.gmail.com>
 <20201102113906.GC9840@duo.ucw.cz>
MIME-Version: 1.0
In-Reply-To: <20201102113906.GC9840@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: naTpn1vVxFTa2b253TId5yPFx4520388AA=
Content-Type: multipart/mixed; boundary="jhf3GyBcFIRJDYxySNDK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604351552;
 bh=TQTra6EOb7/zXqJI0r8D5cyBu66lUXeNn2deLgYhc6s=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=vpZ5DXXGFWrXQ9B9symGA1n1XVzPfBbnLU0HI3he8c20L6WEMMXY76Eo++PJs6Y3r7j
 kvlOnUb0eYG19PvNEa+clSngmHPlh/LH+CoUwXOBtqHguBw4RRAPBf4F9/3sfqAVyPoNw
 7olp32l5hkucfXLbzVR1JDhXlP9ea8KNUW0=

--jhf3GyBcFIRJDYxySNDK
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > - Fix for CVE-2020-27673 has not been backported yet.
>=20
> Some kind of Xen issue, not really relevant to us, and fix is not
> easy.
>=20
> I'd say we can ignore this one.

This is queued for 4.19.155:

 | a9d6e970261d 0891fb39ba67 o: | xen/events: don't use chip_data for legac=
y IRQs
 | d103e667bb8c 073d0552ead5 o: | xen/events: avoid removing an event chann=
el while handling it
 | ed86a5182306 4d3fe31bd993 o: | xen/events: add a proper barrier to 2-lev=
el uevent unmasking
 | 6e894d279f4e f01337197419 o: | xen/events: fix race in evtchn_fifo_unmas=
k()
 | 0279bd8ca365 54c9de89895e o: | xen/events: add a new "late EOI" evtchn f=
ramework
 | adc67cdf742f 01263a1fabe3 .: | xen/blkback: use lateeoi irq binding
 | 322a5dc88d82 23025393dbeb .: | xen/netback: use lateeoi irq binding
 | 515827d40949 86991b6e7ea6 .: | xen/scsiback: use lateeoi irq binding
 | f2db1b870c08 c8d647a326f0 .: | xen/pvcallsback: use lateeoi irq binding
 | 8b0ac9a498d2 c2711441bc96 .: | xen/pciback: use lateeoi irq binding
 | 757d54717fae c44b849cee8c o: | xen/events: switch user event channels to=
 lateeoi model
 | c3c580896847 7beb290caa2a o: | xen/events: use a common cpu hotplug hook=
 for event channels
 | 7835cdf92784 e99502f76271 o: | xen/events: defer eoi in case of excessiv=
e number of events
 | f8bf3977d67c 5f7f77400ab5 o: | xen/events: block rogue events for some t=
ime

"defer eoi" should be fix for this bug.

So..we don't need to do anything here, and it will get fixed.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX6B2OQAKCRAw5/Bqldv6
8pQ/AJ0a7JBImBa/40+La1JQQT9/etv1mwCdHjl4llmBIV+mQ5GkI4kC/JukZQc=
=2+w6
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--

--jhf3GyBcFIRJDYxySNDK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5711): https://lists.cip-project.org/g/cip-dev/message=
/5711
Mute This Topic: https://lists.cip-project.org/mt/77879900/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--jhf3GyBcFIRJDYxySNDK--
