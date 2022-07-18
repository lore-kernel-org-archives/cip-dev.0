Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221D5C433EF
	for <webhook@archiver.kernel.org>; Mon, 18 Jul 2022 08:55:21 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web09.24960.1658134509619067292
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jul 2022 01:55:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@denx.de
 header.s=phobos-20191101 header.b=ehH2vItb;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: pavel@denx.de)
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de
 [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: noc@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5CFB283FAD;
	Mon, 18 Jul 2022 10:55:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1658134507;
	bh=TlOco7Ydjg+N1tPGa7rDnlL/YcvUzgznnFeIl0Qc7FM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ehH2vItbcwGPkKwtBcO9PRjjqZgHkWgTJPmCiws4then5Ms8g2ZT2g5EQLNnBUjG2
	 SDoFiZNUZGMYhPmlvDiKgBaeyp9/OYd0SdsHNF03v9N+hTd+xaki6ZPTC+7cXpfJhK
	 XgO3tHvLYqov7wM/J2FiMfA+akEDRaw+LK0mkD7/IbVy4yuIFP0D0Qw/XhYKt6OUH6
	 sLeKzi2MoipjrUjNlJuyIQflNmwFyLgs5A1i7c/VT98SlH+cf9D5vLvwEmu4bJ3xm/
	 c3tyORw34SufJRzOVj+5FcfLmCzj7ggDcXcFTLKFj/uzEtEDcX5fc95mxCDzo8unV8
	 kvF8mU4NGs03Q==
Received: from pollux.denx.de (pollux [192.168.1.1])
	by mail-internal.denx.de (Postfix) with ESMTPS id C65361811BA;
	Mon, 18 Jul 2022 10:55:00 +0200 (CEST)
Received: by pollux.denx.de (Postfix, from userid 561)
	id A38D61A8BA8; Mon, 18 Jul 2022 10:55:00 +0200 (CEST)
Date: Mon, 18 Jul 2022 10:55:00 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH RESEND 5.10.y-cip 03/13] thermal/drivers: Add
 TSU driver for RZ/G2L
Message-ID: <YtUf5HKy9MGPd8i8@pollux.denx.de>
References: <20220715073916.2321319-1-biju.das.jz@bp.renesas.com>
 <20220715073916.2321319-4-biju.das.jz@bp.renesas.com>
 <20220716105351.GB18467@duo.ucw.cz>
 <TYCPR01MB5933D3A6DA16E05E80D87DBE868A9@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <OS0PR01MB592291A21992DB4B471AB5E4868C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: 
 <OS0PR01MB592291A21992DB4B471AB5E4868C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Jul 2022 08:55:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8843

Hi!

> > > > commit 673c68bd48390dad01f7d17670de3e33b60860ac upstream.
> > > >
> > > > The RZ/G2L SoC incorporates a thermal sensor unit (TSU) that
> > > > measures the temperature inside the LSI.
> > > >
> > > > The thermal sensor in this unit measures temperatures in the rang=
e
> > > > from
> > > > ???40 degree Celsius to 125 degree Celsius with an accuracy of ??=
3=B0C.
> > > > The TSU repeats measurement at 20 microseconds intervals and
> > > > automatically updates the results of measurement.
> > > >
> > > > The TSU has no interrupts as well as no external pins.
> > > >
> > > > This patch adds Thermal Sensor Unit(TSU) driver for RZ/G2L SoC.
> > >
> > > > +#define TSU_SS_CONV_RUNNING	BIT(0)
> > > > +
> > > > +#define TS_CODE_AVE_SCALE(x)	((x) * 1000000)
> > > > +#define MCELSIUS(temp)		((temp) * MILLIDEGREE_PER_DEGREE)
> > > > +#define TS_CODE_CAP_TIMES	8	/* Capture  times */
> > >
> > > Two spaces, plus "capture times" does not really explain much.
> >=20
> > OK, will fix the 2 spaces. For " capture times" Basically we need to =
read
> > TSU_SAD register eight times consecutively at 20 microseconds interva=
l.
> >=20
> > I will try to drop the comment /* Capture  times */ from mainline, if=
 it
> > does not really explain the intention.
>=20
> Or
>=20
> What about "Total number of ADC data samples"? Does it better?
> Please let me know.

Yes, that sounds better.

Thanks,
										Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

