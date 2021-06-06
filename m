Return-Path: <SRS0=bTU8=LA=lists.cip-project.org=bounce+64572+6494+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_TAG_BALANCE_BODY,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA1BC4743D
	for <cip-dev@archiver.kernel.org>; Sun,  6 Jun 2021 19:14:41 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A7861287
	for <cip-dev@archiver.kernel.org>; Sun,  6 Jun 2021 19:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A7861287
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6494+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MrizYY4521723xYUQRUV66mt; Sun, 06 Jun 2021 12:14:40 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.27086.1623006878693008221
 for <cip-dev@lists.cip-project.org>;
 Sun, 06 Jun 2021 12:14:39 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 54A1F1C0B76; Sun,  6 Jun 2021 21:14:35 +0200 (CEST)
Date: Sun, 6 Jun 2021 21:14:33 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] BUG: using smp_processor_id() in preemptible [00000000] code: TCPTSK/1809
Message-ID: <20210606191433.GA18130@amd>
References: <trinity-6c08d14f-96d0-4b01-b81c-dbc85783818e-1622901051584@3c-app-gmx-bs72>
MIME-Version: 1.0
In-Reply-To: <trinity-6c08d14f-96d0-4b01-b81c-dbc85783818e-1622901051584@3c-app-gmx-bs72>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jFOCkmtgp7SSMjYPunPUqtjyx4520388AA=
Content-Type: multipart/mixed; boundary="5QFs6L9HTrQmk9CTNfqM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623006880;
 bh=7KSuKqWY7OaevOEtrHkIkla4nQaR6h9AQUj4O5ed6gE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=toimUCnVPpzqDw+wcn+8kD+YRPzImr1ceM12iarIGneZQZic2dPtrCUixVCy/oP00r8
 MKqFnMcCoGttM9oz2nHneFSWu1n6BaKg70gB2sxXUzE1yxV7twORfR+4VbZ5h2Vwf+o71
 JA6vAtEPUW78ByRgCkl+Wxx2lZGn8foFV9o=

--5QFs6L9HTrQmk9CTNfqM
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> <html><head></head><body>

Please avoid html on mailing lists.

> I&#39;m useing the kernel&nbsp;4.19.165-cip41-rt18 on the Altera
> SOCkit and I encountered an problem with high TCP traffic.

I notice you are using -rt kernel. Do you actually need realtime
features?

Can you try to reproduce the problem on 4.19.193?

> Can anybody tell me what problem this message triggers?
>=20
> The check_preemption_disabled function is called when
> smp_processor_id() is used. This function should be called with
> preemtion disabled, but I think migrate_enable will allways enable
> preemption ...

I believe you got your analysis mostly right, I'd have to study the
code some more to see what is going on.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmC9HpgACgkQMOfwapXb+vLppgCgse/CYCeAlWPdnh6vKAjWCoVO
hpsAoKtJOOxNXpQozC512+cx2dHvwvip
=wlyR
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

--5QFs6L9HTrQmk9CTNfqM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6494): https://lists.cip-project.org/g/cip-dev/message=
/6494
Mute This Topic: https://lists.cip-project.org/mt/83330337/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--5QFs6L9HTrQmk9CTNfqM--
