Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.36])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.858.1793898012984470788
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2026 09:00:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=g94wd9Tm;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.36, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8pnBxbRKfbk4f4h9j3NYRumO1XAe5H1OC7PjjdmW+J8gqenJdpzarbb4nOARWDUtmofYSTMYIeqWiUDE6oti5r53uyh36XxgaQOgDmEZAkzKUC9I+1y7WL2KXlb7MEswxJsNy6c5sTwOtEkgcwd1Moact51nwOEPPNoxAOPw0qbe77DiYeE/nTwoONeh2oEkkwO/R5RZWi047Q0r/90qZYZoLVdYjeYwmi0HhIHqI3bEFa18w6HN0k+Zs1wjTtPP0DhhiKAk9PMw+YSkmuP0aLKxHCAfqLeIiSOyLSfzFiRaLEkWoYuI1JrFXI33c+s8PPdn62tGgYg6BhA4EmXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xICfFBlMIob8CBqfVOwJQQiRt1XF5BXJn1e68wj+VJc=;
 b=o8tucsiYvhI9TxucikkVgpROBdddGXAQHeIsDexfNzDsBM4ac1j7inMTzSJWu1Mb0ESk2do+Rw8w9M9CoMYvVDff1C9j/NGLcIRlkRA4+mY0sILxom5ixvNCF2vB+amM2zvdOG/7XVmSet1l4XuWOR1JgD+s0m1GUyKCgXRurIXWg8kBeVmPbw7BM+C3rl634NF4bJoz0x41k/ljgrHQ8NJkYgNFMSI9+emHnMsP6taEBYLXOQeJRxUUUqJM87aMA2cIgg8KctnCUfbJiO8a9S44zd26p3TNYDYN6ZdodtJRuaZ25eH07ztYX+VAe1RNGDIUOF4Ni+qOt4eT4Xx55g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xICfFBlMIob8CBqfVOwJQQiRt1XF5BXJn1e68wj+VJc=;
 b=g94wd9TmIuf1lSs857n/Sp89ma2AIVcAGIZibYQdIiqD3E8hzo8jpsjXXLzabDCZH/R9CaGRmWI/kElbwPmmKgSZmBz6bBHnSjxTfEwrghPDMm+W4SfMkcinydaMrHLoT/cXi9lvi2ru873xP3Uj7t5KHOIveZOQ5Mx+WgSrcHc=
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com (2603:1096:604:39f::5)
 by TYWPR01MB9887.jpnprd01.prod.outlook.com (2603:1096:400:237::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 17:00:07 +0000
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796]) by OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796%3]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 17:00:01 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 4/7] PCI: rzg3s-host: Add support for RZ/V2H(P)
 SoC
Thread-Topic: [PATCH 6.1.y-cip 4/7] PCI: rzg3s-host: Add support for RZ/V2H(P)
 SoC
Thread-Index: AQHdbUCqoL82mRJkYU+p7MGVfCxtY7cfsxBg
Date: Thu, 5 Nov 2026 17:00:01 +0000
Message-ID: <OSCPR01MB14315B5A4966C38A15309A4F1AA772@OSCPR01MB14315.jpnprd01.prod.outlook.com>
References: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261102125309.7743-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <auyrOmptVJH_CEUm@duo.ucw.cz>
In-Reply-To: <auyrOmptVJH_CEUm@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14315:EE_|TYWPR01MB9887:EE_
x-ms-office365-filtering-correlation-id: 4abc9f41-299f-4fff-4178-08df3b5e3b20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|38070700021|4143699003|11063799006|261009223027099003|261021121427099003|56012099006|261102123227099003|261022075727099003|261026121527099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: Td4spDeFxxHP+CjSNFxevXreM32ajYY9yKl4g21Z1qszpYOnYw4y1gWShFik9M5NSJp2Au4peQyyrM7fYyUesNwKwnBVcLYosCkgRmY86+UM9DPUh4f+9VbyhKkz/glay38taIQRlYnNMnijED+s9UZjTPx3WE3kylZW4H9F/S7aZ8fkHt93YS/LsIJL2ybe6xN8D2AA1gK8HsOpX3j+8SpSdPE6/Vl8/eBKdJrjoC2t2YihdgA+FfCjxXbG6OZlmPLMsI2H63xWBJuVNhxbJ6nj7Xy1VbjogSEmOabrFaensnFEucAioauNIfEPj/IbxzwV/bXElkZSigWWBFUgtFRhyLStZjI5DaI0147vq5T1j91xLOnCwpROxdxfSLBKjvqwEaSaAQ4FqTCghSNVM/PI4uza0MslmaxqLAS5ZmbZCJ0XkdGS8/1Su72nGnElpVtdeHA5MQJIjQ0+SAnnXUYN6AaMIWsu24ul5UYvAeuW+Px5COr1J7cO/2zTNFJeRAeA2Q2cPhA1Q4NvreLMxXhyJGErKS55uqxUN2l1w28uOqCtG93Gsm6+Qe7KssJ7cWiR8q8KxmB0ywCGRpD4RfPJkLnOSC0aade6tlBEjUDm1AUnqCQoUDynfq62Ln8ZiKgIZ2Cex0IxheC6cBajZ5Jeb+9DAB40tspPvyXkpdeKeR4mBAZFa0IwCaXYA2lXPDbx5M9Oh21kjinD0BK9Olu2ypvqFVnW/9MvegbDjdo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14315.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(38070700021)(4143699003)(11063799006)(261009223027099003)(261021121427099003)(56012099006)(261102123227099003)(261022075727099003)(261026121527099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XGRuJgYqsmO0m/+kzLRdxR9B8iz+u5npPBN1E+xipQC9QQffe/lH7I7XkaJY?=
 =?us-ascii?Q?Twj4NZvIPESaFCu6L0JYJJ128LU2yb85vdlVCydi7RNx15a51EJlch0goj8f?=
 =?us-ascii?Q?l3CW69MgD4V5QSMP45ZxQjwNraygDm8brtrM+Px4by7kIMLXOsdmU1zNBLZ1?=
 =?us-ascii?Q?KViZt9gsyPg6SlXI4AGZ1wbjhkJQoO8cIilUx8h5wrJ7BQZvdzAk/nP9SpgC?=
 =?us-ascii?Q?pPc0qBIPuZbMxkqDaCK8lk9IOya10lCIAeKYr63EhzoUyzsr0kkAYAuMyRvu?=
 =?us-ascii?Q?6Iw1ei4BgpaujTWQLZ4x9AayAS/S3JLcswhXvIgkveFTPkHzclgMTG4W/B7e?=
 =?us-ascii?Q?qhx7W3sQ4tnW6z9Ln001v4fWxakQWpad8rN/pTR+Zh+2X46pEvczrBnYPHhc?=
 =?us-ascii?Q?V2gg2KCYxGvh0alw2wowGu/f1iyOko6LUV7iP7j2ZdMbrPnZyuWm1MMyXNJr?=
 =?us-ascii?Q?Zj/gmw5D9R5V9xWN6a7fyy/mp0TbyT7VK1DWQRdeENEzpJLBgocSi2bCO3kC?=
 =?us-ascii?Q?BQDzcZF+5f5AislFklexyXvjJ/xMhYtSANv9HKQeoeyZ8K0KC0DX0nTdPMdU?=
 =?us-ascii?Q?fDfKvVZCAGcM+xcNUtgaBp3y7idUvsUPJQAu8UlT37VfDXTDcYjxW+/RmYKB?=
 =?us-ascii?Q?XOJW+wwwGJ/mfDW47ELrVZPUBDLwbfShMB4mayX6pICxkfXJ0+69GQigugGm?=
 =?us-ascii?Q?OYHuu2KbuKg+6Nf/J4XQrdJmZHAeHoz13ysQ5HP4f6dOjH5FQ2oFZnx7vHEN?=
 =?us-ascii?Q?A/XS1m67dPLe+StIVfPFBs40V/3UoCKC7YiMa82VDAuNxDLA/k1Xsg5eIZHR?=
 =?us-ascii?Q?1F6TdPeUPAHOwSNhR4IpJfTqJdM3wIFQ5c4CB5KO2vcgBWDE3kAnrA/dKsGJ?=
 =?us-ascii?Q?HqTCHbG59o3OHx1eGLshqKEQFoKBjG4ZrYiL4k5ocE4Migq4Js+42+pSHUvx?=
 =?us-ascii?Q?vOlpLZwwjjq+U5L92h1MPYR7YQL+KpkfQehD2ftUQdlMQnyag2Vmx06AZtim?=
 =?us-ascii?Q?V8VDwEaxVEuVaQmXp6arBY5N+w/LAKxgL1e9QkFEnU3ezkHxNuKLnycMw17v?=
 =?us-ascii?Q?6ILliH/ekzt205oxldB1XHlowHjfaK+RN3w74jYPJlKFV3rVa8QC3BEWpKcg?=
 =?us-ascii?Q?hiRYKAJJhwAwzu3D0vp5IN/BOV8AEBhspJWlbVrDxpypTxyDrjn1z6GAZXun?=
 =?us-ascii?Q?c3aShAmpUlqoL+xZ6jBuxI4UGvp2jHlD33WpYnfEe2QXWD3WRtTgPhFci9dC?=
 =?us-ascii?Q?zEZxZk2bRB8PPDNp9ASZamSIxg5Ohwn52NPWdy+QEAECg6p3Dx/TqFY7jUle?=
 =?us-ascii?Q?wwvWuMvkyiUiL0E5WtTQmAOlZrgfT99jQkcdbkHlJ94Tc1fI40qLP1DzTjaU?=
 =?us-ascii?Q?hU5KHqG33+apj+XCtCpz66CC1Jl3KnZIYer/rcgTVRRIK2X5H9k8iW3GQo2i?=
 =?us-ascii?Q?rxwCaEBt2us32ju3GzW9rGyCF+nLMg59lD6EbX8I0KfW36VEPjz7YH7Ps/QL?=
 =?us-ascii?Q?F4P8p2kyYTRS07GUtzhhCQVQC+tJvodMqwGnGYAYFv8ejMgTMBtAaGejzbN8?=
 =?us-ascii?Q?KkmGuOav20O9C5Ml4IMazXOCltIlYsXVdc6MDb/EURCwuGzKE+xEoPyimFOV?=
 =?us-ascii?Q?g/khyPNW94+Mniybsbp7aC8MWYzIU7/SkIVnkuyDP23DtI+buJP+eszLGAMa?=
 =?us-ascii?Q?ndjM7VZmT13WIUO60BytwSJkJ7CZ4PNvm0uAoJwT2AOXUg4N1zOxPPQ+79QA?=
 =?us-ascii?Q?k2a4OhOxRJx2fyWtcClIpFAZAKVuKAf6gFXE+f5Q+Lz1tq9bnK/t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14315.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abc9f41-299f-4fff-4178-08df3b5e3b20
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 17:00:01.4407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YwQ9woR/LnuNJ3gAABw20B9wZJN5KC1Lx4NsEUgczIQBnCFtOfoi7Dy5v2O+ie5bbF41/xgHPdwoVbh5r1xSwLIa6IYPs9MQwlXiEu5WU22OHfcmMlSGnl3EUiLttKSy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9887
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2026 17:00:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24650

Hi Pavel,

Thank you for the review.

> From: Pavel Machek <pavel@nabladev.com>
> Sent: 05 November 2026 16:14
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>;
> Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 6.1.y-cip 4/7] PCI: rzg3s-host: Add support for
> RZ/V2H(P) SoC
>=20
> Hi!
>=20
> > commit 007c7304d80f1462b98a36284f45adcc1eb8adec upstream.
> >
> > Add support for the RZ/V2H(P) SoC PCIe controllers to the rzg3s-host
> > driver.
> >
> > The RZ/V2H(P) SoC features two independent PCIe controllers that share
> > four physical lanes. The hardware supports two configuration modes:
> > single x4 mode where the first controller uses all four lanes, or dual
> > x2 mode where both controllers use two lanes each.
> >
> > Introduce a setup_lanes() function pointer to configure the PCIe lanes
> > based on the hardware instance. Implement rzv2h_pcie_setup_lanes() to
> > detect the configuration at boot time and program the lane mode via
> > the system controller.
>=20
> ...
>=20
> > --- a/drivers/pci/controller/pcie-rzg3s-host.c
> > +++ b/drivers/pci/controller/pcie-rzg3s-host.c
>=20
> > @@ -1762,6 +1873,16 @@ static int rzg3s_pcie_probe(struct
> platform_device *pdev)
> >  	if (ret)
> >  		goto port_refclk_put;
> >
> > +	if (host->data->setup_lanes) {
> > +		ret =3D host->data->setup_lanes(host);
> > +		if (ret)
> > +			goto sysc_signal_restore;
> > +
> > +		ret =3D devm_add_action_or_reset(dev, rzv2h_pcie_release_lanes,
> host);
> > +		if (ret)
> > +			goto sysc_signal_restore;
> > +	}
> > +
> >  	ret =3D rzg3s_pcie_resets_prepare_and_get(host);
> >  	if (ret)
> >  		goto sysc_signal_restore;
>=20
> This existed in original code, but I don't quite understand what action
> sysc_signal_restore undoes, and comments do not really help. I would not
> mind someone double-checking this.
>=20
The sysc_signal_restore label asserts the RST_RSM_B signal which is ideal.

Cheers,
Prabhakar
