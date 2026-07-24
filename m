Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A94DC531C9
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 11:24:25 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.63])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16802.1784890657785975298
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2026 03:57:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=oc64u0rM;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.63, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKdp1FbMdLp3jK39a7tsZNxpVhsRxlarkRux6r3q1F2cNhgl5vkDeisc8HBzp68kL40C1DJ+pGov87oq3hkfhlO7szyTGY/SFNgRqnfvpwsLuv14ylM3ZVWTSKAqKo/sUduXEd7C66rCmZtLdJZCEeD+pH3Io+wYL/T0KBBiYp3hscRJ0tQr6EufxxBf7UuYFfja0+fgtWm/OanGO8JcJzMCUV2/SHol05y23l6ERJTICqLsqCwID1azpVP44lw+iiwidqH0sx6+zkrYPre8f0rZAnHC6oBMw6gK/Vu7f+agav3wN/eZ4WVj+il5OrAGAbHAgxeYLrimm7+HVHcUqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzGThQ0uokX5hfcR0NRQpBbjGdtU7/oa9PZ758BoTWs=;
 b=U8Aal+9NAK7pgllk48IDGC+nDbDE1OiNmPlMa/m7d7u77M86/PWbEihu5m7aIFn04LOy2SUgf5NIh0arqyTMihEG/ObcUW14AcK0B4U0XmP11PiGN+TrCgKTwrxuXGdGS2IKb2k8owrluDXkSn3/5EgYWiNWksUSy+libcI4mrztYn38UqJU/yDJ4nL5XQ13f1fwBZGailhU5kIZoFvGWp3Ut0/mUiNxZ/hMVctOhwWimnmAZl9bCS5/W64qT5Xf3uFLNpwHMuNVVVoX54+yvB344C2eARsFGkSoxlrCz5ocwQghXYj98KptMMk2JhmoZvzxjnB78NJBmkKJYQA5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzGThQ0uokX5hfcR0NRQpBbjGdtU7/oa9PZ758BoTWs=;
 b=oc64u0rMztoHcC4fIwgy2XkwqijoWTRwDOlPiudJmmsOCuFVEzdXbEyWwkMNuD8gS0G1X4goOA4qDvX3KxugnXdMZo0IazqXsG3dS3qGcPy5CF6J5R0+AMF9Hrh+9zARDHZE1L7UCiWahHk/VdxGHAIar9PBqzCO3yUJHCN53iA=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by TYWPR01MB10003.jpnprd01.prod.outlook.com (2603:1096:400:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 10:57:30 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 10:57:30 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "pavel@nabladev.com" <pavel@nabladev.com>, biju.das.au
	<biju.das.au@gmail.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 10/23] pinctrl: renesas: rzg2l: Add
 support for selecting power source for {WDT,AWO,ISO}
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 10/23] pinctrl: renesas: rzg2l: Add
 support for selecting power source for {WDT,AWO,ISO}
Thread-Index: AQHdCtsSsqGDPkMzvkGi4Z7cGo9d8rZucMGAgA4u/aA=
Date: Fri, 24 Jul 2026 10:57:30 +0000
Message-ID: 
 <TYCPR01MB113321502687D6A339BA7015186CF2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
 <20260703105923.251255-11-biju.das.jz@bp.renesas.com>
 <aldeYc-IRbM2fWHP@duo.ucw.cz>
In-Reply-To: <aldeYc-IRbM2fWHP@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|TYWPR01MB10003:EE_
x-ms-office365-filtering-correlation-id: 615983f4-8a79-498b-47a4-08dee9725b83
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|3023799007|38070700021|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 zPxixgbYffyGFNT5Iu3BGAVNvTlSsVp7sKDLoyMcssTT6dH0JGv5DWzs78n4EB1xu9bjhRv4Kcai8Gh5ix4JteJ4lmunGsoimoT0SaglwXKrJZ1Sn2oFJ0UMAklWzCZF4RdssPU24OPybi/Jv6Elfvk7zdUNiwQTSm47QVjNEDLiRNTA+nmLOCu0RmZU/GMvkal+z0RQ1X8IHzhO2zpXH+bluOgrkEL3xeWcWCZeVXMvLD8XWRptQHMqz+w9vEE2wZrzKtaYdM5j6OYoOHBm6A4ApZVpplgpgh3/X8dxTCOHcdwKhu/nmAPlCPr29xWd3EZSiRKHbS6oLcHj8+pf56T7oxfZiP43ghbjCxScDXW6f2PBpEMSE/0D4F3FSYZKwsSxer7mWNaWAe4EV+jXfvi7fb7K8gUetVoO0ZRzPMzsuSgpFdYdGSLpN0zZjBcYV6kc6ddFlVMzjnFaVl0oDeHKrXc43rKDUiv88R1K8yTnD1mdMpw5HGnprkdOps4zygt7IPyYQLYOITiRQLoPCOskiCQkMsH3HUgEx+uQknNulQJog/EBaoNXayOI+TTGL4Ai5k4em5nqpwuTfvBBmZmFXQKh8atMzhmBgZwOxUScLlXZOACGaqQO7INi2Ff/6S/ygeI/iQmaRPn8BJ6Kn8iqSnIMG6JbEAG+gb6/Kir2T+s1xFreYC8NiBDZx6sulvKRDfP8KlzGfMxNocDSZBfqX6njM8vBLrpL/ui+Qxw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(3023799007)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?/okL8hFqE1s0QBBJAVNkP7UoIPUaJ65IQk3DjAQJbMX1QFzCBuhgx1KrKu/g?=
 =?us-ascii?Q?awmdR5Mpw337/9mpLEfq21eJup8+xxS2YYMFHmINgfx1XiJZ07FmXluk5vgL?=
 =?us-ascii?Q?cIqY5EccpgtkLXFLze732dNQfGBVRUsXbUeJoqKI4+q0ZlJ+/EVe3WaCnyrl?=
 =?us-ascii?Q?iV1PgWzdBFVIPDwSOo9wwKBPyEzFnJpaLbNeiv8pJlFbk56g6wBGYWf99see?=
 =?us-ascii?Q?4c0VhTl2BUUkRW/iAs1l7C7xdr2AKGcVMI/VvQ8z+g/s+cjQC5OHbUtBi4x4?=
 =?us-ascii?Q?3t1zm8YB+5LIHHguAI+bhhsYFcD6UjIb8YwsXmczSlpt7UOJNvHCZqrVXVDC?=
 =?us-ascii?Q?1PzearAxBYuumpZxF0GFyp6QWcD1qAnJRMMglh7vYM1a4b8PRylFXzyMZUnG?=
 =?us-ascii?Q?ODv1dW5/3ZKEv8ZlNMSd9aF8ktmCXbqUV0FIDN4yA276o9z6gKeGXjT2/YQ1?=
 =?us-ascii?Q?oiMlkmeFHXx78gqmH/Yoe+T+TD3bkyLU1ccbVbKUstjYDSDQIOHgulqrLY97?=
 =?us-ascii?Q?nz6IpaGLyj2nTKN3/nxA6m8EeGzqRwQ8cdJjvIOSVfY5Lfpc0OON/KhhfBmm?=
 =?us-ascii?Q?xwyOL93c+PRdayUAyoiswTaIUeq0VOnzEwvaMcpZCZKl82mSHBdAuNzk6OBC?=
 =?us-ascii?Q?tmJ9QqBAnBy4JrY6u5Jc/iCPJursJFh0Bd566LPd0DlnjhAfl/Ac5G6bgH4g?=
 =?us-ascii?Q?PkwvwU9M0gbR9eriyMFv5X8tm0TSGeydjh1hJKHkBmO5PUBqTBPaT9FSKk77?=
 =?us-ascii?Q?RKFxxaPROe/LNMTKjt9sbyYi5YaOgsL6IjVP5Zzs5rpdT9IYVD6cWvFrAiXN?=
 =?us-ascii?Q?oIPOub7WApneUND+/Y1LI7r8+3vxc/dwr0I5kYJrrRvDzr+lI5o2DgY7BClt?=
 =?us-ascii?Q?mOmGg1Xp6SfusMxCfJvWjfZ4rkbW4kxcI/LKbgs9wWatr0tw0JBvD5nuUvrq?=
 =?us-ascii?Q?h6HAVDQNHUgC2bb/VJP43drukYGmbaNsaUKqO6lTNc/0MurEtVh2o9pFJM8b?=
 =?us-ascii?Q?8QjBSBLcgRzmnUAH3mycNgbolodDT+GtxZQDTKq/c2r2xy7vKcHLQLoNaiOt?=
 =?us-ascii?Q?fACW0DXcqT+7SZOVjWI5Gydz84P7ZJr6jTN2LKGVvRz/sxThJDChB5JXot0L?=
 =?us-ascii?Q?ofRAhy2A2bgnKAcVrNdI82XljOhVDwc1dSOukhEGNPvRKyInUakHilGzwFoZ?=
 =?us-ascii?Q?37t9EMnoc2+X8RP5QeXoC6vITsn+1bgqxKPRYn4Jkw3QECcXDwj8Yn743BxP?=
 =?us-ascii?Q?wvoxE8QgVIQ0k9IbGuC0MHTRRjNrqNYuwKZO2wMlPsX5GdqwVgnHLE0q0l7P?=
 =?us-ascii?Q?nlayNo+MECi9sXfkyA0ITFKoKwg1XNso9k49oKx9nCK6NKBN6Ami9zeZY7Pa?=
 =?us-ascii?Q?/5AktWR1Fml/PMQPpqnzZmnA3f7mkgvqswO7GI4Jg8gGwMX6w9JNT2padVzq?=
 =?us-ascii?Q?sSm5bUULP5BAmTOL+TcqKhhoaRNaNv4AregQQMJ/MX/LkkAQv0Ve+s82iXee?=
 =?us-ascii?Q?fpXPx9wL/hICSQtbpjHYkv4PtX0izalwjZ1hQmSRZW6OHwxFNSq0BiDoS0WE?=
 =?us-ascii?Q?NcJC+ZBKIMH2JzEqJoX9QVYk/dHgBB1GJyXZRP2c8Aio4vH8k4Rs/l7oOHvg?=
 =?us-ascii?Q?zQuFdS1As/RPjduWBtu2fT3dtvqMbsWKXSb5SWKon9Iw5e7U7rZ1saf1o2G4?=
 =?us-ascii?Q?vM464oUzNBgvqATD+YnAxXTABoyrVBKugWxUC19UP2dAEyort4KFEg7r9gTn?=
 =?us-ascii?Q?cgLQ2kw2tA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615983f4-8a79-498b-47a4-08dee9725b83
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 10:57:30.3813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +RKUIevLDCXm541zJXbQF78zZIs9tFqs5NGwFUjvlS4CdWiDftHqeT3zanqiKEHgDM7GqfOdA3eK5j4fLQRc7wogIJec/4T+PrO589ODJEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10003
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2026 11:24:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23734

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via
> lists.cip-project.org
> Sent: 15 July 2026 11:18
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 10/23] pinctrl: renesas: rzg2l: =
Add support for selecting power
> source for {WDT,AWO,ISO}
>=20
> Hi!
>=20
> > The RZ/G3L SoC has support for setting power source that are not
> > controlled by the following voltage control registers:
> >   - SD_CH{0,1,2}_POC, XSPI_POC, ETH{0,1}_POC, I3C_SET.POC
> >
> > Add support for selecting voltages using OTHER_POC register for
> > setting I/O domain voltage for WDT, ISO and AWO by extending
> > rzg2l_caps_to_pwr_reg() with a mask output parameter so that callers
> > callers can identify which bit(s) within OTHER_POC correspond to the
> > requested domain. Update rzg2l_get_power_source() to extract the
> > relevant bit field via field_get() when reading OTHER_POC, and update
> > rzg2l_set_power_source() to perform a read-modify-write under the
> > spinlock when writing to OTHER_POC, since multiple domains share the
> > same register.
>=20
> I believe more robustness is needed here.
>=20
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -958,25 +983,37 @@ static int rzg2l_set_power_source(struct
> > rzg2l_pinctrl *pctrl, u32 pin, u32 caps
> >
> >  	switch (ps) {
> >  	case 1800:
> > -		val =3D PVDD_1800;
> > +		poc_val =3D PVDD_1800;
> >  		break;
> >  	case 2500:
> >  		if (!(caps & (PIN_CFG_IO_VMC_ETH0 | PIN_CFG_IO_VMC_ETH1)))
> >  			return -EINVAL;
> > -		val =3D PVDD_2500;
> > +		poc_val =3D PVDD_2500;
> >  		break;
> >  	case 3300:
> > -		val =3D PVDD_3300;
> > +		poc_val =3D PVDD_3300;
> >  		break;
> >  	default:
> >  		return -EINVAL;
> >  	}
> >
> > -	pwr_reg =3D rzg2l_caps_to_pwr_reg(regs, caps);
> > +	pwr_reg =3D rzg2l_caps_to_pwr_reg(regs, caps, &mask);
> >  	if (pwr_reg < 0)
> >  		return pwr_reg;
> >
> > -	writeb(val, pctrl->base + pwr_reg);
> > +	if (pwr_reg =3D=3D OTHER_POC) {
> > +		scoped_guard(raw_spinlock, &pctrl->lock) {
> > +			val =3D readb(pctrl->base + pwr_reg);
> > +			if (poc_val)
> > +				val |=3D mask;
> > +			else
> > +				val &=3D ~mask;
> > +			writeb(val, pctrl->base + pwr_reg);
> > +		}
>=20
> This is strange. You test that ps is right ammount of milivolts, but here=
 you just ignore poc_val, no
> matter if user selected 1800, 2500 or 3300mV.

Poc_val is used to set the desired voltage. For OTHER_POC register there ar=
e 3 bits

For each bit,=20

#define PVDD_1800		1	/* I/O domain voltage <=3D 1.8V */
#define PVDD_3300		0	/* I/O domain voltage >=3D 3.3V */

Cheers,
Biju

>=20
> I believe you should cross-check values here, so that if user requests 18=
00mV, he does not silenly get
> 3300mV (or vice versa, I'm not sure how the hardware work).
>=20
> Best regards,
> 								Pavel

