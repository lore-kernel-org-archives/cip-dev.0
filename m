Return-Path: <SRS0=MS9+=D4=lists.cip-project.org=bounce+64572+5633+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41927C4363A
	for <cip-dev@archiver.kernel.org>; Wed, 21 Oct 2020 18:34:27 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9823D208C3
	for <cip-dev@archiver.kernel.org>; Wed, 21 Oct 2020 18:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Ah9xHfgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9823D208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5633+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VrtyYY4521723xloKA0euYBB; Wed, 21 Oct 2020 11:34:24 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.16483.1603305263408555080
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Oct 2020 11:34:23 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 55BE31C0B88; Wed, 21 Oct 2020 20:34:17 +0200 (CEST)
Date: Wed, 21 Oct 2020 20:34:16 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [RFC PATCH 4.19.y-cip 24/50] PCI: endpoint: Replace spinlock with mutex
Message-ID: <20201021183416.GA10468@duo.ucw.cz>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201012141933.9652-25-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201020204332.GB29993@duo.ucw.cz>
 <OSBPR01MB5048F76FC81C94ED7FE1C553AA1F0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB5048F76FC81C94ED7FE1C553AA1F0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: iSCwt008XeSphm0aVuAm94Tfx4520388AA=
Content-Type: multipart/mixed; boundary="J9kS0wjZ0HFVb5FVBoAS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603305264;
 bh=ZOVp7YMOWgCIfWoGx7sTgQbh/YGblmbUspvZ14bray8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Ah9xHfgnYT9oFR7w6RxXAcjL4kjNbw/S7e1dbOZqWBcN5JUMEVzSPh0yT8n1CGw6Ues
 j42EPe5JG5u9A9b/hUCSNd24GkZsCIAnG1yALSwUmFm1oohM92cFYWI2X87x/dUZv8s0M
 BmNbwUPRjtTfgPr9vxUGtW/JT5p/K1PUyMw=

--J9kS0wjZ0HFVb5FVBoAS
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > commit 3d3248dbd018502f654064c78efcd2e165ab3486 upstream.
> > >
> > > The pci_epc_ops is not intended to be invoked from interrupt context.
> > > Hence replace spin_lock_irqsave and spin_unlock_irqrestore with
> > > mutex_lock and mutex_unlock respectively.
> >=20
> > Could I get some kind of explanation why this is good idea?
> >=20
> Apart of one mentioned above other point I would add is on a single core =
machine mutex_lock/unlock would be good choice.
>=20
> Also to add the callbacks in controller driver might sleep. For example i=
n raise_irq callback  [1], [2].
>=20
> > As long as code protected by the locks does not sleep, spinlocks are
> > okay... (but they should not need "_irqsave" variants).
> >=20
> > They are likely to have better performance, too, when protected code
> > is small and fast.
> >=20
> I do agree with the above two points *if the code isn't sleeping*.

Okay, we can't really protect sleeping code with a mutex.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tre=
e/drivers/pci/controller/pcie-rockchip-ep.c?h=3Dlinux-4.19.y-cip#n410

But this one is not sleeping. It is mdelay(), not msleep().

> [2] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tre=
e/drivers/pci/controller/pcie-cadence-ep.c?h=3Dlinux-4.19.y-cip#n310

And same here.

If there's a place which does sleep with the spinlock held, I'd still
be curious.

OTOH, 1 msec is already threshold where mutex makes sense, so... this
is okay.

Thanks,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX5B/KAAKCRAw5/Bqldv6
8j90AJwNQUvpV+qFtlkqXNM2RbixwvffxACdFb9ED1Yu95fdN66LOidoKp5qdg8=
=vy+/
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

--J9kS0wjZ0HFVb5FVBoAS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5633): https://lists.cip-project.org/g/cip-dev/message=
/5633
Mute This Topic: https://lists.cip-project.org/mt/77461695/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--J9kS0wjZ0HFVb5FVBoAS--
