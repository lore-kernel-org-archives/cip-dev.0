Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C69CCFA04
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 17:28:13 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1512.1762277283861492107
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Nov 2025 09:28:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=rd1Zv3kE;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.68, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjdmfYYhv/LK0mZlMwouBNxMrqni2dnha+0hV0lkkOslopBrjAIAelGPNpZAcPHuO0GnBf22nHtyuLspZSz17KkF0PBT2CakBqTGHl+OzNa0HAoslc+a/rsXywcqjD8NBF1Z/W1E3StqWZ6SFkb4XPlVaaNo6lhmZ8lR9iubAGbOztWE4DK/4QxuoO0FxU50jnCncfvg+GXj7+/6emRcKusUgEHNLGGdPEhUg8gSkkswGH21W/kMFm9WVq/Wyg3RUREL8AzVhw/bssIMU2t7Ma/X3vEDZd6WdlKs+bC+lUTHAT78NeVHwLTWIsQYzzCpGx4v6Odl9PHytKdioZE2tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTGSCAl75YjOsQwDHZw6kKIj3HgZbSoDEpBu8ASBwmA=;
 b=EpydUA0UaIK60qy2S7EFaE6WT227CmtAAQZNP9KjauHIO63V+MMkYiOgO/OQ6DamuxYcdzKygIZ884V71mEwv1ii8gHS//ljfTHBiaVtX0svwDH1fNNa/rQ13GgbCtm2hLvHGG/qUVKvTJ+VIWBDuxaYDwSo2eXaKq6rA0T0MNdb2WptKxqlD/sX3txmxW9IWGBCY2sMQ3VhPu1xlfS5lnI7YbEI+oz3Cdc1q6aardk5bwpnpE/H64r2PslCzVCj76xU6UgOFJsSxmBI6RD57kQNYEFq1XWQao/d0z8gAyInBN6ah5TPtY0WHkc1H+VzZTQtldUj44PhLpv+yKqTWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTGSCAl75YjOsQwDHZw6kKIj3HgZbSoDEpBu8ASBwmA=;
 b=rd1Zv3kEyS03UPjnfnbRgyF06cVIiALeDYODSCEs/IcUJsKrsztQc6lspiVhTCgfBzKf96fS9v2RjFI4KWEpSRhprOfcgxJJ/nfQ+KxYomjB4HPM3YylcVnhaW8iLgN7yJbwPGQmeLsP8MmhbUb2esjyGJH8NgE6QOdtkDKrjIU=
Received: from OS9PR01MB16368.jpnprd01.prod.outlook.com (2603:1096:604:2b8::6)
 by TYWPR01MB10145.jpnprd01.prod.outlook.com (2603:1096:400:1e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 17:27:59 +0000
Received: from OS9PR01MB16368.jpnprd01.prod.outlook.com
 ([fe80::69fe:a6bb:3371:3f0c]) by OS9PR01MB16368.jpnprd01.prod.outlook.com
 ([fe80::69fe:a6bb:3371:3f0c%7]) with mapi id 15.20.9298.007; Tue, 4 Nov 2025
 17:27:54 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: [PATCH 6.1.y-cip 07/25] pinctrl: renesas: rzg2l: Unify OEN access
 by making pin-to-bit mapping configurable
Thread-Topic: [PATCH 6.1.y-cip 07/25] pinctrl: renesas: rzg2l: Unify OEN
 access by making pin-to-bit mapping configurable
Thread-Index: AQHcTYmfYUeQ/ZBRNkqfBMvm4S5xtrTiw9ew
Date: Tue, 4 Nov 2025 17:27:54 +0000
Message-ID: 
 <OS9PR01MB16368EB62EAD6B6D3C8EC5A72FFC4A@OS9PR01MB16368.jpnprd01.prod.outlook.com>
References: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
 <20251103113608.36240-8-john.madieu.xa@bp.renesas.com>
 <aQn2n2gbzfxfr7KY@duo.ucw.cz>
In-Reply-To: <aQn2n2gbzfxfr7KY@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB16368:EE_|TYWPR01MB10145:EE_
x-ms-office365-filtering-correlation-id: f2a9e485-0170-4b7c-4788-08de1bc77cee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?VCWACi0k7Gkh1JMoEq12e2EefOoYY1Gp51h18m3TrJsZ6hK8XrUhfgVTkEqs?=
 =?us-ascii?Q?5Mt3+Cfi0AiaJ8t78CiKSkAv733pQ5Spjq/TwN/BxrV+sSBIrkBPb/YqC42a?=
 =?us-ascii?Q?0uSSvfmgy397JFOM7NDc6RCybYKdH7F+aSAzTn3XoCU2lfU1sdvhvYK0rNnM?=
 =?us-ascii?Q?p825IjfVHjSUauUQg+JlP+0DIvlUWlLz/aV0JNJkf1x0YlyNetXIIELyVX0P?=
 =?us-ascii?Q?RwVJp7eTitA2NghKIWrilBSESBH9dht886kYjOFoOMpRDkufT+BQpICnWhZB?=
 =?us-ascii?Q?3oQ6o/jsvL8OA1zQwDjIcPao6hE5c07hn1QQH7naXrjWGeKMqZg3lTVIUiSK?=
 =?us-ascii?Q?YBw6kZgRx58WJP5N0kvc6O8BvzLQpNhhvmbrwMMhx+pHs9z+/U7N79H0h5u+?=
 =?us-ascii?Q?XV+0EpZbvbI+9eyK2xQ3oh4em04tl2E6DX5gwdoHY++ONeN45HiCTitkrzeW?=
 =?us-ascii?Q?fODgshqtTOr7O+PuP0qsX0zkpDpQeKqivq92lQD4uamdq1cLkgGUdXBnTmPn?=
 =?us-ascii?Q?O/JxQcZKPHo+dE0273H9eWQFfY6nWAs1KLDcrohChGtz82Pu0DR9yr1BnNwR?=
 =?us-ascii?Q?jWf42tkQc2tpuXfLue5LLt0v8+wYGzzdEL+OGa43jaHhl1JrZp0ulRhhCZcs?=
 =?us-ascii?Q?LSiSNCH2wRDOzTCqXI2YdZ+y0ATHBmeB82vmyksDE3c+SkjQ114lG843H8ou?=
 =?us-ascii?Q?uehqmKKlEcD5l/Cv7QnoumPZiuduJaHMcitH/B3OPSC6dHWz157TG1npzy/M?=
 =?us-ascii?Q?WU7VSsPpXTKG0aLkR0kP6mQ/yJHxAt3I+F2Iao5CcLJqvlFkcN9pvnqe6/Ka?=
 =?us-ascii?Q?TyxPn8CBUcF+W8qb9iQGwTmCXBJy9fQ9z8oWTsyBGUtZL0zTAo140t8WfG/n?=
 =?us-ascii?Q?gSHf4CI7j+o7Dy9qVwIQTICpqPmsQq2Sw6YSnuxuXEBm7UVrEx/pDr8PvOay?=
 =?us-ascii?Q?ykY0znW4jOTmiKgctz7Biy2474M2gGEFGik8/FMd3/jSUZZUMolWl8NZHw62?=
 =?us-ascii?Q?nE2aAe952oM1UMxv+gP+QsCyhJ+8P2xThH5Yb+8HthtMe4a9KREERrB5ODIQ?=
 =?us-ascii?Q?j0kvxSVHyjrC62fBxDJ4IsdHjSVreAnPt2JzTkYYmN5hAl+1UQiNI//fZ+ox?=
 =?us-ascii?Q?0BCv4YjkgWUTdLIltrpu+sW5APfxLCjBITPsanStqpKxYLwj+4l04BBtmya/?=
 =?us-ascii?Q?cU3PXLea/GpTaierZNMxCg6jtwwhyVkIuMnS9k0IgwB8OL5md5s8nTKvC7f1?=
 =?us-ascii?Q?UumHBMyc2Ov5cziARCRnX+bt2/k3TYLjvp5hfkzuw1txYBc4/n6MLMoD9sP0?=
 =?us-ascii?Q?n6OO3HnBROmD3D42crLEDMq5mpmLw/8qq7j40aV5+/zHyjCHeshBLAfabDEW?=
 =?us-ascii?Q?GgGEItB5uEhMhgotRmUnyWNzSRrkE4QxPTXoQvzvAQBkixMRMZUUxpjqdveT?=
 =?us-ascii?Q?4jaHHI863irb5g7rpWysH5Q1/NDZF6GURuoOPiqr0b256YlNtzzQF4pPS7RI?=
 =?us-ascii?Q?W7hni9Esq1s5RBE47tfP/+ke9jtJ3ZMaV0ci?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB16368.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?diOo09y0hcVNyP82gS9taqzu4mpJpK7ojbHicE9zQYGpOyNgApx+M65JXICh?=
 =?us-ascii?Q?kTVQfJ+PKD4xxNvK1Fq2mPpCClbd7xvU+hXUoVBSgv7NO7jarnc6FHdH0bBa?=
 =?us-ascii?Q?4TZ54GjBBLLsphNeU37EA4FmSpKGaou8j7l06JTqJqFWVV7IMGp2farYm/vz?=
 =?us-ascii?Q?voHfi2O/Z0IGEf+qMvtnmqRekJ6I94FOpWxfGfsXvwiaZ5e6XzlIjxuVJdDv?=
 =?us-ascii?Q?2k6JZj7FYSzJ9UhdcYRTyTTaCSM2MSkDAyiejMIFYwylPEPNkP2tOyp5NKKF?=
 =?us-ascii?Q?o0tQKHbhtWc63J9bw7eUXfdbTyoBLfsMlwyxAouW4HnS1D2ziz5/IB7jLpvS?=
 =?us-ascii?Q?pmSfvnpmMODJk3efldBycJDZAQfwaynaY2bs/34kKaJogxQM8fWW2izfFx6F?=
 =?us-ascii?Q?WmYWy/A78tJPfGk1esCuMSwZn+XtFzJ1TnotVojek5Q8WPK4JbBXUV2JAjTH?=
 =?us-ascii?Q?3AbPUh2pnggCPr4xPMV63PPDJ+QbzF6jCvvX8qmz5mlchqbbCkY7OY5N5CtD?=
 =?us-ascii?Q?9G9leFcIXBrfQkENXodLjgq47tTXP0hlxP05BLm0jV20t4rhbaN4TU2XPxNK?=
 =?us-ascii?Q?HIxMT/ubyu4WQuSHi1El9D5NVTKGw1H8vtjM0ChLG7ag+BYv7WV5mdtFSU4B?=
 =?us-ascii?Q?t8bFDScBkV6wfDmcq2uf0zLEpkVQAKv223r0TFcwRTlC310XvOATqDvO7ev2?=
 =?us-ascii?Q?GGVLM044gzrPQSOAa+iAMom5EvA3fxSC9clSA1mB7vNIa4Wncj8HyQTCiAlX?=
 =?us-ascii?Q?sXtzTAENlMx68ZMyRpxeNtAwtlionFnH2U2RBMSGFdgJEEYd/W0US9E4OvIY?=
 =?us-ascii?Q?Sdekp76SkUE2afZAa7QpS5wWc15FCAzVedipKIOfErGQYe1yLkJfFWOCOeRa?=
 =?us-ascii?Q?vhNee3zOi8zAzFVP6PiVMrePfzpXIlZ0cSscb+/sNyAIzUPWBf8SXXY0YzNP?=
 =?us-ascii?Q?QoDPMOSsnnX7EWixasOadbS/3gjvOp9ObxqswoZGhjqT/364Osc0sqfKcIme?=
 =?us-ascii?Q?PY5to80txE+AotYkywzwOIDsTc2oQkrys/hsQo+IGgbl5vAeeY+iWXHlpC0Z?=
 =?us-ascii?Q?Qq6ZY4O873PnIOQQQWyJGDuE0EulEeRwWFpIMYTD48LHnn9BLXjgEqXqwBZM?=
 =?us-ascii?Q?AmSulgRE2MoY+uCTmTqHkMk04BMygXPPZJH+vpy2NEYoLIAiMeWPEGcnqphK?=
 =?us-ascii?Q?hC/C5AuhcKOR+Q6WZ2en8GE6rO7SFB4yN9yrfwpTHOJvFM4z2XL3uta0Lg5i?=
 =?us-ascii?Q?QgDowcjTRcklzK/lLjxN7gohkSMYhGO+GW0ERi8l/HESnUMB2xk4SPo38/20?=
 =?us-ascii?Q?e0HNOe0yiIMX8PD92Ee64naRDIn1DhgBRbEEAViZfFVwRFSbggNH9NF+aLrY?=
 =?us-ascii?Q?DeC/uwNjeS1pnmLxwuVNtwX3vsPZe5sWlZ9DiJ9XLGupbxSTgBx57kJufoV9?=
 =?us-ascii?Q?RNB9goh4TmPdc64ohFoKVkFzC/Tsde5bECwGlDCeIz0Q3wJ0pGu9WokSc5ob?=
 =?us-ascii?Q?b04nO6TkyR7O/zvQDS5p36xD9CnlGix5JD0bPEImCB2O6ds0nhuI1sORgt0R?=
 =?us-ascii?Q?cQRkKN+TtJsKg2WxEs+hP2v/+poGnMto76wg9ahAwNiJlgb0R3ViE82xCQTZ?=
 =?us-ascii?Q?LA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB16368.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a9e485-0170-4b7c-4788-08de1bc77cee
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 17:27:54.1435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZk9hFe3ZK5WQJ5rhlwqrAqh4y5NOY/sS0NXtWYm19+R9HqVkeUoiaKXtx2MujgouGAChtlunq4EAEdR6e1yATf73gEsuf4Z3649brknOTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10145
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Nov 2025 17:28:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20353

Hi Pavel,

Thanks for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, November 4, 2025 1:51 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: Re: [PATCH 6.1.y-cip 07/25] pinctrl: renesas: rzg2l: Unify OEN
> access by making pin-to-bit mapping configurable
>=20
> Hi!
>=20
> > Refactor the RZG2L pinctrl driver to support reuse of the common
> > rzg2l_read_oen() and rzg2l_write_oen() helpers across SoCs with
> > different output-enable (OEN) bit mappings.
> >
> > Introduce a new `pin_to_oen_bit` callback in `struct
> > rzg2l_pinctrl_data` to allow SoCs to provide custom logic for mapping
> a pin to its OEN bit.
> > Update the generic OEN read/write paths to use this callback when
> > present.
>=20
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -1063,7 +1064,10 @@ static u32 rzg2l_read_oen(struct rzg2l_pinctrl
> > *pctrl, unsigned int _pin)  {
> >  	int bit;
> >
> > -	bit =3D rzg2l_pin_to_oen_bit(pctrl, _pin);
> > +	if (!pctrl->data->pin_to_oen_bit)
> > +		return 0;
> > +
> > +	bit =3D pctrl->data->pin_to_oen_bit(pctrl, _pin);
> >  	if (bit < 0)
> >  		return 0;
> >
>=20
> Returning success on failure... is strange, but I believe that is
> changed in later patches.

Indeed, this is updated in later patches and returns -EINVAL.

>=20
> > @@ -1077,9 +1081,12 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl
> *pctrl, unsigned int _pin, u8 oe
> >  	int bit;
> >  	u8 val;
> >
> > -	bit =3D rzg2l_pin_to_oen_bit(pctrl, _pin);
> > +	if (!pctrl->data->pin_to_oen_bit)
> > +		return -EINVAL;
> > +
> > +	bit =3D pctrl->data->pin_to_oen_bit(pctrl, _pin);
> >  	if (bit < 0)
> > -		return bit;
> > +		return -EINVAL;
> >
> >  	spin_lock_irqsave(&pctrl->lock, flags);
> >  	val =3D readb(pctrl->base + oen_offset);
>=20
> But his one is ugly. Any error return is converted to -EINVAL here.
>=20
Same here, missing .pin_to_oen_bit() returns -EOPNOTSUPP in later
patches.

> Best regards,

Regards,
John.

> 								Pavel
> --
> In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
> Office: Kirchenstr.5, D-82194 Groebenzell, Germany

