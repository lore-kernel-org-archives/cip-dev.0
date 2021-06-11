Return-Path: <SRS0=b7Hz=LF=lists.cip-project.org=bounce+64572+6506+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53125C48BD1
	for <cip-dev@archiver.kernel.org>; Fri, 11 Jun 2021 22:34:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40FA4613C6
	for <cip-dev@archiver.kernel.org>; Fri, 11 Jun 2021 22:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FA4613C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6506+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nYpEYY4521723x1S3ub2PXDT; Fri, 11 Jun 2021 15:34:17 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.424.1623450856478553304
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Jun 2021 15:34:17 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6AE581C0B77; Sat, 12 Jun 2021 00:34:13 +0200 (CEST)
Date: Sat, 12 Jun 2021 00:34:11 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] BUG: using smp_processor_id() in preemptible [00000000] code: TCPTSK/1809
Message-ID: <20210611223411.GA28449@amd>
References: <trinity-6c08d14f-96d0-4b01-b81c-dbc85783818e-1622901051584@3c-app-gmx-bs72>
 <20210606191433.GA18130@amd>
 <trinity-17b11b5f-9805-4527-89fb-1f3a0103a164-1623043418611@3c-app-gmx-bap15>
MIME-Version: 1.0
In-Reply-To: <trinity-17b11b5f-9805-4527-89fb-1f3a0103a164-1623043418611@3c-app-gmx-bap15>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: tukb9fsA63CpvuVXOu01HC5gx4520388AA=
Content-Type: multipart/mixed; boundary="HRaeZi76s6IkQrNeS6Zi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623450857;
 bh=0lsAOKGNXZvvrHW8FaVDZS67QcHVwwH/S8TlvLA0OCY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=fcjfsl5prvE9EJeM3GO/s24EWwj+jRwsl4xw/sscJ6WTrdgnjav1y1MzHtmfydeEsKy
 vmsPZXsp30e3EOI8t6HdwR9V1JSiN7kYieMmaAUQVVIiPtTHCVDXFUZryB2gx/rr2chiE
 7xSkihIYcrVH7aOr8/nQtJd+fTubtl9b+MY=

--HRaeZi76s6IkQrNeS6Zi
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I notice you are using -rt kernel. Do you actually need realtime
> > features?
>=20
> Yes, I actually need the realtime feature. I have one task which
> needs to run periodically in realtime (triggered every 10ms by an
> external IRQ).

How fast response do you need to the external IRQ?

> > Can you try to reproduce the problem on 4.19.193?
>=20
> This is only a problem with the realtime patch. The patch
> introduces migrate_enable which is part of the callstack:
>=20
> Jun 1 09:11:46 sicam kernel: [46802.944165] BUG: using smp_processor_id()=
 in preemptible [00000000] code: TCPTSK/1809
> Jun 1 09:11:46 sicam kernel: [46802.944210] caller is
> migrate_enable+0x40/0x488

Fun :-(. As Jan mentioned, testing if it can be reproduced with
4.19.193-rt81 would be useful.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmDD5OMACgkQMOfwapXb+vLRzgCfWqyIHlIah/q+3KzwgF5n3T77
Jz4AoLiJ3RJbuuTB4dnTrnOkmCGRU/cS
=SasS
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

--HRaeZi76s6IkQrNeS6Zi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6506): https://lists.cip-project.org/g/cip-dev/message=
/6506
Mute This Topic: https://lists.cip-project.org/mt/83330337/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--HRaeZi76s6IkQrNeS6Zi--
