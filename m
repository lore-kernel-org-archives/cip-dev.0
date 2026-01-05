Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5993DC79F90
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 13:40:31 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.64027.1767620429325598189
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jan 2026 05:40:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=DVBq7REN;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.34, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xc8LscFdD1jV8wH0NUE6r+V9r1SKfhLYYlnojxE4u5zYUaBZZhC7rxvXmE4dmRsHGTqaNh91CfXTP8MLmwlft8OP6u/kgdu8/kS//GtWeYezyfzYo6OANK9UiJIY5GW4yB2ewIlP8cH9uzyeOpgv1xyUZrbYK6SFjpmGDnhwJidCb1zjnBnVa2gvlTydTrpJd/9e4FKpfpQXgyo+sJWsDF93tIuMNkgnOBJhHn8/Nd/rWJW7YaiIKj8FKSJbGaSKjUZIckTEixGWecQtxwcPKXNVpJFjPEbj8rozBC0JQ7KcEZ88mKWYY+Pv7q2hFE5Nl5DU3HLifiPKDTHsHi4SGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZs3PHLAv79AXJoMHvXmhchYikz172wKPJplu4yFvHQ=;
 b=BLngEVTneCzVHDE/+LTp9HjfzppNNnqGgvYgLRNjVA3Amwik613Xl1L9GDSOFV81UtdX+aNMAIEv1wwmOgdX8x+QCftIbXUlUSRgvYap/UGpVdlFDs/5wpRcIj7/10CG0Ya5xQURe41KJ0DIUKfnUHty4Rtlpdz9aelTL1M7JBpoEPeZV3tiMdKmV/54iy4vws1IknAj89zGJz6/sdNEZpR5gdyDUtM2Hw5M4LsKP0K33Qqw3wjLQtDliTgMovx5Wmwl1qS3tb/JKa3sFxjEz/0ZOZBjnFumZPGzAbCwlH/3ZU0ajHIrHp5bQqPuZwR2ucZbb0rXf3qXTYdbc9v6rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZs3PHLAv79AXJoMHvXmhchYikz172wKPJplu4yFvHQ=;
 b=DVBq7RENrlfN2ACrAT8bNsdCBy1lASB/YQfJRJAFcwpy18i3kS53+13sL9coEKJV7E7zm3M8baXKDsUb54ULfzoMKx6JrUsmwYan2J/0Y842XS080JZa+qxENUZFOrIx1HunxX0klhob/CdBvTnbW4BCIa5LMoItUI3vI1N2rnA=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS9PR01MB12520.jpnprd01.prod.outlook.com (2603:1096:604:2f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Mon, 5 Jan
 2026 13:40:24 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%2]) with mapi id 15.20.9499.001; Mon, 5 Jan 2026
 13:40:19 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 05/17] watchdog: rzv2h: Add support
 for RZ/T2H
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 05/17] watchdog: rzv2h: Add support
 for RZ/T2H
Thread-Index: AQHcfjclhuo3NIxhXkuEumPn5CO+m7VDlN6w
Date: Mon, 5 Jan 2026 13:40:19 +0000
Message-ID: 
 <OSZPR01MB7019B74B463D9AC6DD6B4AF8AA86A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251231170026.17006-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aVuhl9TJVs6rlwNT@duo.ucw.cz>
In-Reply-To: <aVuhl9TJVs6rlwNT@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OS9PR01MB12520:EE_
x-ms-office365-filtering-correlation-id: ffdb8e4b-9377-4fd8-5144-08de4c5ff7e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?2lgm9yMLXw+B5WxE4DlrVEopdnbHdcFYDcLo71u5D24kIWB1vToQI/z4EQEZ?=
 =?us-ascii?Q?c7xUP5w6qjjTOYaFl6e6ixwFsSnVRm4QSGX0FrmAafkGzqZVuW3sjSHbbTX/?=
 =?us-ascii?Q?585jtsXGKK9T0PLIlcpTcv+AWjlMnnE6O9vlS98AYiQYMG4jFnb2nig4TneV?=
 =?us-ascii?Q?mt05Zd4FSEOD21ml3asBoAxF83WrfRFijnw7ZQSZliSUPpzmMKPBV825oNFZ?=
 =?us-ascii?Q?zOzCVLrOan3uviSVoRwfrFxR+YR7drLFWkdJNxHkvM6hmpEJM7UbA+mpL72L?=
 =?us-ascii?Q?imrj5CZo0P4nRedl4mDkAX4cwmsbLRCQi/oreT2mj6HpQOe1/5Vrhf0rWdCQ?=
 =?us-ascii?Q?V+QFmljXiQS3dx8WzEH4pg83JOYsJYpr7S2LnQYBr49hWJ4M0P6m18DL3miQ?=
 =?us-ascii?Q?/D4zredcQF4k+UqqqGcihi5AJuULiu8h4qSGrgi0ryR0z6WazUWm+4SZ3uwB?=
 =?us-ascii?Q?L6vgViuGqagZO1WAOsN2xqxRUMjChbNpTVAuCJDsUSsch5nV/f+z/jmiEra8?=
 =?us-ascii?Q?XfcnH3hAwPaMxvcAdKArQWxc5GOhYblAqe8/1pWpU/MHm+HGuM87GVJnSXlk?=
 =?us-ascii?Q?FiXZHEc+7iFyriTXH5rmDyAT88HO2MUBKpCkcsR98H+tP/Ehn82TR5D5056L?=
 =?us-ascii?Q?2oFA9XaekLUDU1Tbh1zd7XiynpbQW/iS8RKtEngCt1xoZin2m2XNcWFOQPHA?=
 =?us-ascii?Q?ylvETpRlEuRLfQN8utpbNavUtkawpUxByfMGAOGlOKPY9u5MrziJri5dj4Ah?=
 =?us-ascii?Q?XC2TWDlQYM+1bpSEuwW1MSgvEVWvxmJalFtUXSs0vkGq304THJ1zK6ndo/sw?=
 =?us-ascii?Q?NrHsY+Ik/1hNoEKX54it1q5EkPnkgoBX3KH2vWbQLuo3L41OgAPGweeNkRHT?=
 =?us-ascii?Q?Z3F8C2z6UKdIJvnrBveSZcN87Es2vttYYuXr+zTB9f0LtM/OMJlRbkXD4VSb?=
 =?us-ascii?Q?ylk8KVyqxUCPC/sHhhtemKaJYWeDFl3FS46Tw/Pzm/lC9+F/zlY9/ECq2YbL?=
 =?us-ascii?Q?ecjX3pHX8zDpgvXMaKYnPOov8cwUPbx3fMQFGmh729XQopJUwIxnnXmaQHN7?=
 =?us-ascii?Q?P5oDWlYsv1rcecrjovQP61eA89D/AaaazrYC18Ki8yQALx3+he6QtpZSykMx?=
 =?us-ascii?Q?FCLlIuZTzrq0uTbdxLAk0dOiF8++o3EIO54/at+5Vu5gdmodbNzRdzaorIDe?=
 =?us-ascii?Q?/mWZFDgJPoZyDZLbfxd2NYKScWo4EydZM4DHIt8KDSsJlW9aD30xfJDdbQjs?=
 =?us-ascii?Q?+I77vKJpWpanfigPW8TP7kETcN3ioWSfgIDtB3j//zqdUDIKt4hZBMOd8Ziz?=
 =?us-ascii?Q?ZznvN44JuX6BXPTPY1K3sKmWuA7eUfbTTgtD+G+OjVCBKDO4Zc1R2bdW8bU5?=
 =?us-ascii?Q?onqtrJWLfaw8HCiPP3Hn8UW8b8CoLyvG5076TmVjbGzyA3KEiCk2FB+Nc09f?=
 =?us-ascii?Q?/GrgS3IAkH1zwI/UksIgq2oURTt2P+wfuV5kcUtvpI7ClW1Ftdm0ghSjgp2Y?=
 =?us-ascii?Q?KAihyigwsWTyP+yZjX07WPMUEfl+Zb5j3a1M?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0qF5DnpiqsGILdnI9O4jT3fjkcwB4nMZW5Iw+tFCQcOd4T4ZkUk/yETcmdGU?=
 =?us-ascii?Q?H8t5OT3TRLJ397Vb2aKeZmbT0HKzEmwBuBB446CNeTDl3+LOp11mTysABJDr?=
 =?us-ascii?Q?rSm22YxPsPhksPXbqRQN5MuoJyZLBXRiE6bxmig45k5Ah0p7iD6x/+06QS+L?=
 =?us-ascii?Q?EZNgzw6N/TT98RjDhlaM8TijDsTXv5Vdv/jK2qO9naO7580ylqw0n13jo3Ih?=
 =?us-ascii?Q?89Wz5ATKexCg7NCSGGKyNdCsGSBrt7qSmfKEFXY8kDn3uqQLTFHLoKIXq7Pr?=
 =?us-ascii?Q?m9ANcNx+uEF4JZqCYymYSbVqyFEjNwuDqcpNbIOEOyjSlTJIUvXAnSO+sbsO?=
 =?us-ascii?Q?8K8raxcGATceIw6wVQiZ9mEDVt1ToOy4x/5F7YZh4jIa5+N207Lt7MkTZByQ?=
 =?us-ascii?Q?U0fzYCufTO29ngftkCSc126lo01L4Manh4CsoXx/xVpQH12oX3sxd8jzyEy2?=
 =?us-ascii?Q?eMIRfJ7SrTYll3b3z22+C28aLdL8yd4S0WgwBvAg0/zx0Jq26kkq6B1dlGGW?=
 =?us-ascii?Q?NBEeAuMA4dvlFTG6toVnikyXQxqCEYlgr4zOSFA4wAA7QVZ+X+7lBrxM93Dg?=
 =?us-ascii?Q?TfP+wdTsQzq7947/2PnR9x5lQmHzbynrShx1KRvQtRX+wDJIc28eauLXfsOx?=
 =?us-ascii?Q?LPK1tiarTDpjsa7M/ypCB51ChnKMCF8C+K1DDsLhtc69mRcFW7urIv4sgTqY?=
 =?us-ascii?Q?o9YzyRBeqkb+LFLEbfpzck7r4yx66WJo1Yx2abOJ+Pp+dIdH8BRKOxvgbpj1?=
 =?us-ascii?Q?p9BrKstAYEBhGWYHfET1vtLXkbmM1QbFGZUN+7IfWu3j2B86Uji3aTwIi4V/?=
 =?us-ascii?Q?OuT11kEPxWd9Myj7b1wIx5bUb2Yu+mEeiOy0qrBBqTs/FepnTXE2rEtNjg+l?=
 =?us-ascii?Q?Ot7aReluOC4yZPG0zdNw/8ypsiaJc6/FKrYy/+peb3he7z1hROUJwA0sMuAw?=
 =?us-ascii?Q?O/u5Xo5IufGvtsNG1+i8YdDntLI2UQjQpIzIeNxHIDZGyl8v6Osu3KNByVeA?=
 =?us-ascii?Q?gfZP5+mXHyD9lHGd0JO6QXcrXWJ8OKsoHlad5uq3/c7q/XwIv+VEmqvl/n2K?=
 =?us-ascii?Q?7UG8YrKElVi1NZNZAbmzjJa01OcfbzNMvhJSFGXDQYqZUIuZcomE8+10ygYR?=
 =?us-ascii?Q?x+n3D/+pM8p0BDZRxsoCVNfxyHiBdzYHYCM9FbqLq5P1AzFPE4LD36+OQNCB?=
 =?us-ascii?Q?2c/2sX8YX8DoMJY8VrTH9Dq7oVOpoK2WqaPjwJB+skNncX73HDYKAyK9TvKH?=
 =?us-ascii?Q?M+V+mFLr7YhHVgaHbemtdc6kJzBzsMtWrL4+mjehxrUVhaX2/Qbs3LUizb2j?=
 =?us-ascii?Q?1Okd+uJqKs3xFE0yWyOYYpttxCpXdL7RmP3SqTbSx0sKvSf2H7U9uIFaGexD?=
 =?us-ascii?Q?ZUzXxSwoUB9i1GeC3HQoUTtxbuAKyaO3S49YYsHvDi30/QkfTSWUi1XyntyC?=
 =?us-ascii?Q?hS9lhq3LSR6hWp5dw2MqjY1PUZ0upfx8h/g2TBc/TJ3vknmXXMVvSzRRjdt+?=
 =?us-ascii?Q?v/GqQufd8BZKbvgUV823dv+gqfKLle6Mk4PlnwimBqvy1xds93KMVSnabEsG?=
 =?us-ascii?Q?RO7F0o3xqK2qPikk3bDwhY+TcbytweyifVSpe/ZBtxJUL0wwEuunGTee8oMV?=
 =?us-ascii?Q?1yEjP7GPzSfpAuv1lRBnvDavwdAnVP13fBugZJs8iLhdPYy3/oBqq2YfWWIv?=
 =?us-ascii?Q?Mmp5zMWGFfDU0b+5CtAJdkFh+IxtJh1s6y0LQJagn4ma60cNOVr6EdllwPQv?=
 =?us-ascii?Q?+EKE/CmCxFYYxvXgvjl8ou3Ff9/oDYSApUCMasZB1U/18KoFypHp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdb8e4b-9377-4fd8-5144-08de4c5ff7e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 13:40:19.7505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LfyuQ5UYxsQ7F2CgEolbMcz0CWCZhTAUhYQAw6fmtIte7Vk/u43Q9fNd3N2aVyTuP96ZvktmEVeYmDiRFxT5r+uL8KHfzsG5NyRy3nb78w9XyrYbAq84x4AWx/Jktocu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12520
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jan 2026 13:40:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21313

Hi Pavel,

Thank you for the review.

> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 05/17] watchdog: rzv2h: Add
> support for RZ/T2H
>=20
> Hi!
>=20
> Minor nit below:
>=20
> > --- a/drivers/watchdog/rzv2h_wdt.c
> > +++ b/drivers/watchdog/rzv2h_wdt.c
> > +static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
> > +				 struct rzv2h_wdt_priv *priv)
> > +{
> > +	int ret;
> > +
> > +	priv->wdtdcr =3D devm_platform_ioremap_resource(pdev, 1);
> > +	if (IS_ERR(priv->wdtdcr))
> > +		return PTR_ERR(priv->wdtdcr);
> > +
> > +	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	rzt2h_wdt_wdtdcr_count_stop(priv);
> > +
> > +	ret =3D pm_runtime_put(&pdev->dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
>=20
> I believe this can be simply "return pm_runtime_put()".
>=20
pm_runtime_put() may return 1 if the device is already suspended.
call trace:
pm_runtime_put() ->
   __pm_runtime_idle() ->
       rpm_idle() ->
           rpm_suspend() ->
               rpm_check_suspend_allowed() [0]

[0] https://elixir.bootlin.com/linux/v6.19-rc3/source/drivers/base/power/ru=
ntime.c#L292

Cheers,
Prabhakar

