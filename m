Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB87CD98EE
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 06:03:16 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.2])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9391.1781676192019704166
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jun 2026 23:03:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=BXaB5qRb;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.2, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEzXS/3YPpRnG11j6CEyy7SANoVb0iHCxRyYsGcvze2Yniys5H/rVFb0k+1If2D0ndkFoRWMbYmh6nO47pnzrTyGrU3rqPoSYyfYDmAUQ/3+A+2AAAfob5oP4Cw/2Be6qwwCaA5FI2tBbcumlEv563WY/F+noNbWlQa+2GQhaztRkRlrwvKn0+pyisD7aSZMGM0yOw+jQ9a+nvrnAbTgdZCMMxUhCQMAm7HoneS2ZTVxtM3OU071gubr5syqs4AZouKkdLgUqrNBBaJXl4rvacWhzxvVSLacP/hmbq+LB3eWTVbpM40Ps6WGEvqZ7ei1OlI8AN+dUcDMiJliDDgHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLVa2OY72GTolXlE+zFXp6t6Pw0Ej0vQ0XiR8F4EWMI=;
 b=eBxriy6+fAmAsir9ZaLr/VbXKZnMYNGJs8PAwz/3o+SubB3qsaAfp92tqVdqZYtS8+gFIWKBBiVtvvDi/Us1VDxWSdRSrVBpf0jueBrkwvNporJ4xMGE9cZRpTLrHYSISOaLbl4AIoxtKbrAs7cohXwBGy3sxNGzN7jXT3lZb4MxvqDcGJVI2FhdQqcQ0uaqxdOCh5FIOuuYPRfotBSdTscu3hjbpmeaXOZpCmLpXnbeM4NqHzIXBUSYlNLsYEVzrm/vQa5MAQ1jIIP2nY3V8qy2qvtCHEMDG25iIhUwNMyPBGHus5+4BayJWUm28hWqJiQWh9UahBmjs8pFGrV+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLVa2OY72GTolXlE+zFXp6t6Pw0Ej0vQ0XiR8F4EWMI=;
 b=BXaB5qRb7yZh7YrxI4JkHpJPW5Bo/ROxx8P2R/1femmqQoIo8+7NeLGmzvTvqIaSupckr64kDooFDaUf1nZPfP4kyT4DiK4OmVwe45Fx0auUGfgPBF7zFX9jNLSls3efHlzA4KVpGMf4E6JTyW/2hx26/7rNFYl30aHxIi/ZCMk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11999.jpnprd01.prod.outlook.com (2603:1096:604:245::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 06:03:07 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 06:03:03 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
	"pavel@nabladev.com" <pavel@nabladev.com>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB support
Thread-Index: 
 AQHc+RIwKFPPVjUeikSpa+v7h7aK+LY413QggAECSoCABYA3gIAAyK2AgAAlrvCAAgHuoA==
Date: Wed, 17 Jun 2026 06:03:03 +0000
Message-ID: 
 <TY3PR01MB113465DBF7530E6B918E49F3486E42@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260610194849.2502517-1-claudiu.beznea@kernel.org>
 <TY7PR01MB1481870E0F531E41AE63C8462CD1B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aisi82Eui1N1svgC@duo.ucw.cz>
 <38f60ffa-0dda-4e8b-a1da-82f9288e1faa@tuxon.dev>
 <ajBolVke5ENiZ9n2@duo.ucw.cz>
 <TY7PR01MB148180CBA9D53CA9256F7189CCDE62@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB148180CBA9D53CA9256F7189CCDE62@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11999:EE_
x-ms-office365-filtering-correlation-id: 9c9a9558-16a7-4cd8-4aff-08decc361817
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|4143699003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 8UwhhuwpFqQaNQZAfpP8+qsUBIomYhjudntMgHzJ48G6kWHdqd5j9oyjda5hjgz5J85tdJPDdsax1p/N87O2Es5qyTSm3NtEkmHI1A697KIACWDKkjpMTN1aGPn/rmyoyFM7wveiUgEsO0JZogOdmyyCvL4VqestGc0Gz1KX2/gPULkHd3nRUF7JWg5L/ZkvpgEAAwYnT/rZZJTmDkVHBVccXN6Vyet46G6876czDcessfpGVZF60qA6XQwjm6hy+ykIcYaXKvBGl0LHZd65LNkc/hUMhRpae5+6mND2OB/Atjm8SlW9GhaE+CkCOm184wWsAbM9NlCol0GNX/ryWNTZ1LJOaycsvV8fHDr8QTKVNHwHXa3NloihtYETrDA0XAQuhGwFa5pWIqq7Dt0x9T4n1cf8WINASJNnz5I9Y7kKLs9DmBxBd53GhgmGu8Tkj8Ah/FbXjFLGKzlFBD2Cmz45pkTwZr0zaj8KnRmxp3HSDW1FCcOmv59Nku0Xr/0chZmAd9nvBB+HATF9OOkhcPnWaQ9DFxxkfm1apqFFlWHVZ6aNkwE51/kxeJulgXDH5FpqUEemGjRw1vbYrAwXxElcUrGCQPyp9F4oYN1VvE2vzMFU78veEonPjPCo0WZr1YNiPtsCE25IIkFFXQpyz2si28nftFMDztRF1m0bSji4rGQA9/1i1iy423PXXoXtvnUsUIe1JfG8cnV9ygFQ32eRghFCPIgnq6JdFAXAHsyw0bbKOksUvvOzgWPkGWMi
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OTlDODBGWnl2UzJaeVFFakZ3cEJvc2pJWTZQSkV4RkNidzZ0VERWYXhZ?=
 =?iso-2022-jp?B?dVBUcXFrc0JuN2dCSjNramFPNWdVL3FFMGE0WUdoWmhjaTVWL1J1Q1RJ?=
 =?iso-2022-jp?B?eDJwcHR5bnRCM1pBU2lUOHF6SEIxNUYyTjJ1NFN5b09kOXJvMncyZ1BT?=
 =?iso-2022-jp?B?UHdtblpSMUd5S0RNUnlSRG9kNDJUcUlVWVRqcDdudFloRFVLU1l1ZVY3?=
 =?iso-2022-jp?B?R2l6blhjOWxqZGNtUTI5azRMR0Rod01Pb0lqdUtoKzcvMHFDVE12ZTVP?=
 =?iso-2022-jp?B?VThEU3lmSU0yRVlVSEVxY251Zk5za0FDUks5UDlNNnhZZUJEcEpKQmFs?=
 =?iso-2022-jp?B?b0pFZXpGZi84SGtqbjE3Y3pjMllrZDJmdDdWem4wdnlBcFRIbkxCdyti?=
 =?iso-2022-jp?B?eGZrZWhWZWRLaVhkK3pBWG1sT1pwaWNDemYxNEdDeUk4N1YraFlPd1dl?=
 =?iso-2022-jp?B?ZUZobEo4cCtwa0loaEhtLzE1aXczTGZvem9BTGtCaWVTelY0WW9qQmcw?=
 =?iso-2022-jp?B?NklBd1lPcVZXdUxIMVp6SEd6V3NwTWdma2tzZnJ0eWlMYU1XdEhFNEQ0?=
 =?iso-2022-jp?B?UGtrV2h4SGxScVhnNUk1bnJCUmFPV3dLWC84dHgvRE55dGxSZ01SUzN4?=
 =?iso-2022-jp?B?MTRFWjFXSFdzV3RTSndiQSttbENGMUlzcWs0bnpDM3pSSDlGSTNpc1Rh?=
 =?iso-2022-jp?B?YUFGa2c4YThsWk9CT0tGTmVyYU1GSUR4bVJSeHVNR2lrbzg5TENaU0dn?=
 =?iso-2022-jp?B?N1BZRnhTcVd2TmZibVluMDU1MmlHeUFjckJLRG1QUDdyUUlWZHNPVjAr?=
 =?iso-2022-jp?B?WXVyTFNmZHNwZHYvMnlLUk94WGZucDV6TWEzNkxjU1d4RVJBWTk1UGpJ?=
 =?iso-2022-jp?B?RlVHc2Rlb0Y1WnArYUJJQlB1ZDZISVB3LzlqL2dRblBRd2pwQ3NadE1u?=
 =?iso-2022-jp?B?NnpJWng5N0JHVEhpc015dGNTUlJZMDh2Ui8yRzhSRkZvZHlQdkVibUxl?=
 =?iso-2022-jp?B?VlFWdVVrZUR6akN5UElMcmNYZzh6dFQ4azI1WTAwMkdOTmZ0dWl2R0JO?=
 =?iso-2022-jp?B?SFpYYjBLNVVIVEdkWlB6VDg1dVJxcy9kc2syMUhnKzdDSWs1SkYxVkkv?=
 =?iso-2022-jp?B?bS9WbkxlTDlyYStERXBISGNKKzE2MDdiK2xCVHlsUjhTZnF0M3hLVnpZ?=
 =?iso-2022-jp?B?SHRuWkQyQ1lETXFpN0xIdGxSbExDcktLTWtZKzJZUXpxQUllZCt2OEdG?=
 =?iso-2022-jp?B?cXl4ajNZK285NXpQd1pTR1VMZFByMURqZm0xRWpDd0FqYzkrR2FqamJj?=
 =?iso-2022-jp?B?Mzg1RElVOW91bC82SGFCWnJQRW9IVjc5L2hvdkREVW1aelc3T3R5dlN1?=
 =?iso-2022-jp?B?dTYyWGY5UjdyQUx3ZkNtb0ZUNHJCcGdSbzdMWUs2OEpHWGQ2bDQ0bWpQ?=
 =?iso-2022-jp?B?cjhMdVdWOGw3OW9IMjlUMlFnWFdGMTRDcmpOTENjak9rQnZKYzVpdnBp?=
 =?iso-2022-jp?B?aktyaWszSWxCOWJLSmQzQTFTNmkzUjAyc0Q5RE40UUs3M0F3Z1F1cGRH?=
 =?iso-2022-jp?B?cC82K0tPK0xUdGlBdTE2OGhXdWthMzF0RnBySUQ2MFN4MllOQXc0Q3Ar?=
 =?iso-2022-jp?B?eXJZcHN1SzhLQXFTTEw0Ti9sN0VWbFlMaXJ5ZVBhU0ZieEhEZWt1Tjh6?=
 =?iso-2022-jp?B?UDhieS9TTm9za0VrVHFySlU5VExqVGE4dUFUd2FSdGFxamhMYjBJOFVz?=
 =?iso-2022-jp?B?bjBLRkcyWXlCdDMraVRkMElXUU9WcHE3VXhTd2JsRjRqeU4wTDFWM2E3?=
 =?iso-2022-jp?B?VHI1R2l6OHhYcGJXVTFaaGFOaFdhR01HQTN2UW1KS2F1SEovU3BZc3la?=
 =?iso-2022-jp?B?L3U1NkJweXZqMG5OM1dxaHRieVlyaEVZdURBZjNSWnJBbVF1Y3JJZFVs?=
 =?iso-2022-jp?B?RUNnQXpTRDZzUzhwQXhJWXZMT3k4TTZBTG43NnRleEdLRzJDZXA3VUtp?=
 =?iso-2022-jp?B?SmgyL3Y3NlRUTXRoaVNKcHI0OEt5ZWh4MUxISTRZbzh2QmVtd1lWODJX?=
 =?iso-2022-jp?B?dnRKQzFOYlpSVm10bU1VRkJENkZZT2kxblcrVWZaYzJhNWF6aHUzaWlO?=
 =?iso-2022-jp?B?K1FQaWFhMlUrTU9OY3RCaDVyR05rMmQyYmRHSnRaYWZra1ppa2tFNWQw?=
 =?iso-2022-jp?B?KzViUEU0MzAydG5SdHlnZFdXVzYrVEFEWE1walRvekk4SlR1UzFHbGtS?=
 =?iso-2022-jp?B?SWgrU2Qra3M5VHNqMm0xQXJZNkExUVRnQk1BTjFLRSs0ajlTakhrT2ps?=
 =?iso-2022-jp?B?aXh1bzRwZTdJNHh2M0hSdGJNNUt6S0NBbHVRYjZycG1leThHMmE3NmxS?=
 =?iso-2022-jp?B?OWhncG5XcWMzKzlEZ0htWUNpR21FMzVRbVprSjV4TGVoV0QxVHJadWpB?=
 =?iso-2022-jp?B?cGZwald3YVlSMzRpSGNJb1RIc1dtdm00dzVicmpMcmJzejNBU0NsVlEw?=
 =?iso-2022-jp?B?aURLaXQ4WFFCalVnNHFpSmhrYm9va1lqenRLdz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9a9558-16a7-4cd8-4aff-08decc361817
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 06:03:03.6949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8PwllRX4YrLJllrnTd1hXcXDOcdA5qAFFgKr9IIYoTSAWdHJ9Q9z8TKVvZIRjoAfpusYQpJzhNBhOKGAnLyw/6asMusa2+9BpBsC8gBCDFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11999
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 06:03:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23157

Hi,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Nobuhiro Iwamatsu via
> lists.cip-project.org
> Sent: 16 June 2026 00:51
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB suppo=
rt
>=20
> Hi all,
>=20
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Pavel Machek via lists.cip-project.org
> > Sent: Tuesday, June 16, 2026 6:03 AM
> > To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> > Cc: pavel@nabladev.com; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B=
 =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> > <nobuhiro.iwamatsu.x90@mail.toshiba>;
> > cip-dev@lists.cip-project.org
> > Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB
> > support
> >
> > On Mon 2026-06-15 12:05:03, Claudiu Beznea wrote:
> > > Hi,
> > >
> > > On 6/12/26 00:04, Pavel Machek via lists.cip-project.org wrote:
> > > > Hi!
> > > >
> > > > > Thanks for your patch.
> > > > > I reviewed this and other series, these seems to be fine.
> > > > > I can apply this if tests are OK and there are no other comments.
> > > > >    Reviewed-by: Nobuhiro Iwamatsu
> > > > > <nobuhiro.iwamatsu.x90@mail.toshiba>
> > > >
> > > > I'm looking into it. As this modifies generic code, I suggest we
> > > > are cautious here.
> > > Please let me know if you want me to limit that code to RZ/G3S SoC on=
ly.
> >
> > I'm still reviewing the series, sorry for delay.
> >
> > My first preffered option would be explanation why this is okay on
> > 5.10: (Will it change behaviour on non-renesas boards? How sure we are
> > the behaviour change will not break something, or slow things down
> > significantly?)
> >
> > +++ b/drivers/usb/host/ehci-platform.c
> > @@ -442,6 +442,17 @@ static int __maybe_unused ehci_platform_suspend(st=
ruct device *dev)
> >         if (pdata->power_suspend)
> >                 pdata->power_suspend(pdev);
> >
> > +       ret =3D reset_control_assert(priv->rsts);
> > +       if (ret) {
> > +               if (pdata->power_on)
> > +                       pdata->power_on(pdev);
> > +
> > +               ehci_resume(hcd, false);
> > +
> > +               if (priv->quirk_poll)
> > +                       quirk_poll_init(priv);
> > +       }
> > +
> >
> > If we can't have the explanation, limiting to renesas boards would be f=
ine next option.
>=20
> This concern was also discussed when the original patch was posted.
>    https://lkml.org/lkml/2025/11/7/557
>=20
> If we are only addressing specific SoCs, I think we need to fix it in Ups=
tream first.

Some discussion related to this thread, and it expects

https://lore.kernel.org/all/b417865397822176e83bca6b9d8094fe92ff2451.camel@=
pengutronix.de/

and a patch for fixing assert failure in error path.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
drivers/clk/renesas/rzg2l-cpg.c?h=3Dnext-20260616&id=3D0b0201f259e1158a875c=
5fd01adf318ae5d32352

Cheers,
Biju

>=20
> >
> > Thanks and best regards,
> > 								Pavel
>=20
> Best regards,
>   Nobuhiro


