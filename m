Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F4CC77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 10:33:20 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.106])
 by mx.groups.io with SMTP id smtpd.web11.5600.1686047595010941445
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 03:33:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=tY5sX+4K;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.106, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcDbSkBrgH/uIDFOV+uoFBmxH1Ob0ha0BdfeplFD7sRF2qnghEO4F3tj3GS9OuXqCqRCVsQ5GJAIZ+FY0N0yg4TWyKYg1P437CnZXTJ1Xui50ldOdKZr7B78OIZ7ZiEb/8xcEAC3t7oxul7fdNMqq7WgQ1mxRNxHrelGSp9JUIDSlVlkmfTcZO8DLEnLNRq1NYoTIyAURhp5l1I/A2S2mDSN9+3gyL9SovzN8+z9RPkAoKO2sn1wtWo6krzhF0q5FkBh4lT4M6eRrAqXaXNx+RC1UTJpIUycaFx+a6iJQtBFeBCR+PAL1BPTKRgCVbgoDGTJo4j9owHkjQbzolemng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bq4JB+opTQlvJFWlO9Wpg9jYEfPH5R6Ekf+YJC9G990=;
 b=UbD0vjQUxn/4uzQLjgU0JKII7PIk8pkaskOXaWW5IMjbXtCfY1CUsCJC95pGsCHvPCVXv3FIJZ8donfMLb+CDyqAt8JIU8Fg+1RAtbZuS8cj4d4uIR8vEsfwoOb22IIH1v8/JUWMKPotjALPTUgZRousvfw2nkJNBBMhDcYjZDOyd1xRAP6g8wgFOPkD7PMlUM2B+mH7OSjClm9tQtw5VF0nhhGuZueyzEQnBUqRtZ8YQTbgypo0nhSejbWNEohpWijyazMFANftXhvcxJ4s6lNQCqdqc9YJT0VvHZMF0gT8L2SvINzemra36ED61tyuOFZIu8Y444dddALAWgP6yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq4JB+opTQlvJFWlO9Wpg9jYEfPH5R6Ekf+YJC9G990=;
 b=tY5sX+4KUjM6hN8syj+045+1EaevwO/d5szuq7vwaKK1kyDRC12c9sOIvXdg+Zb6V4LPWv7bvcr6tV/nYcaZbZXGUqaSwsyeiGnrDV9ApNTlEsz/sPBz74ok8CEOLOlmQhwIo40PuCNkVUktMmOOj1Kbc1IrlHm56vYDfpUhNPY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB6226.jpnprd01.prod.outlook.com (2603:1096:604:f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 10:33:10 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 10:33:10 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 5/8] counter: Add Renesas RZ/G2L MTU3a counter
 driver
Thread-Topic: [PATCH 6.1.y-cip 5/8] counter: Add Renesas RZ/G2L MTU3a counter
 driver
Thread-Index: AQHZmEvm3S0q1okFxkK1byQ4exsgQK99jRMAgAADqeA=
Date: Tue, 6 Jun 2023 10:33:09 +0000
Message-ID: 
 <OS0PR01MB5922EB1CA93AD26D5320C7F28652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
 <20230606075235.183132-6-biju.das.jz@bp.renesas.com>
 <ZH8Fmom8vZ4DwxqA@duo.ucw.cz>
In-Reply-To: <ZH8Fmom8vZ4DwxqA@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB6226:EE_
x-ms-office365-filtering-correlation-id: 91898739-e0ee-4a6b-2e7a-08db66796c77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 oriDmZumDamuOR79yCm1+zI+fUEg1BLQVzmuoCjr5VPWfFH/mcvHFVdiiC0XE5qwXMdXKf1Lbif4yWDchM8f52gUY2tOy+w4JsWpr9xfFXmQ/SUUPLptK6GKE3V7As14p3Zdeg29NY1DwXDCvPa4uBfmSqmzlTgc6aGRYVL7qbpKFs8ocfNeirXoNi6hMiq1pRJgXw+dk2LTgdbYHawsAmb1gxfWqt4T9uCg8p8v5jzLGVTT+LbknnG/LGKWksMx4pwO8WiMqiAnMMmUIqKZIvy8tTOjbZlU4T1uj8umqgPKhvVgDeR4qJxKokUVne5fm0er5yrTBa/ypsk67snYZQ9EoRkS5D6n5XYHP2ZC82RgrcsW7EBQzzJftzTaCI4/x6daLcRfnbgWBdL2BEc9vOCTRDRAPWKIah9bzUDUqnJZKAy+r0OBFd+h87cCgAOERzYXi6SMDtc+6iI2BqwKXnLlmNuYgcQl7ZdzHhW5OWoOG719ZbFks7r3bAx02dF/51ppxfuYcYjNGT6ug3/kcYQj82/wku1OyECpki8TpWP+ZEaS3UN6SLUfJxXx1FYvJIojP8UEqAiCfYzP0SgopJ4h2XSgF5q8FI1cH5+8iijIfvICLX4i5E9+/0lyfVWK
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199021)(54906003)(66899021)(2906002)(38070700005)(71200400001)(478600001)(33656002)(86362001)(52536014)(38100700002)(41300700001)(8936002)(8676002)(5660300002)(55016003)(316002)(6916009)(66556008)(4326008)(64756008)(122000001)(66476007)(66946007)(76116006)(83380400001)(66446008)(6506007)(9686003)(26005)(186003)(107886003)(7696005)(966005)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?13m61q+zdTn/RbZ90WYrZsk7xi3Av4NdIdtnbTqmK7LCblXBX+CbAEf+gDX9?=
 =?us-ascii?Q?5nz6Zfkwj+4p9GslSORjg3+zRw/RmQS+gBSzw+X2GsJsWp3OgFKoftpXuCRR?=
 =?us-ascii?Q?aDzyQG9sa8IY9nE5PLGMzRBM9Be2xc4md7wOgcWZewaFEu9ZDLBfRVS6t1oP?=
 =?us-ascii?Q?hlISsNApVO40Q/aPWLm0HmGgaQJUyQ4O19DBhnZzwsWfhaS4jXqVoQVu32NP?=
 =?us-ascii?Q?EL+M1bSlO8DQDcwvn1ue9azBSCcVBEdJC0K+fyIq8OxhTOCgIvKgLorGF5KW?=
 =?us-ascii?Q?c5sO3XqgjCJMTqSAVvNCz9gYvesI1yyW+OGwSLH9UwNR3TtE1nPpV5eZVL3j?=
 =?us-ascii?Q?RViB2XtB5cdvGD7towicjVBjujEKGDklYgc8eDOEfCsEZhYrzmPHsioY7Rho?=
 =?us-ascii?Q?2Yy9FfrEAQmZe82BVZ/JToYKLoyPogVGsRC6Wm19dZyWl95v88jzQUc3ObJG?=
 =?us-ascii?Q?uglujby3tVikio3lnxzwYCBcsSML83wZ6l3KwbJkP6yZpHtlwdLqBbzuD6OZ?=
 =?us-ascii?Q?lQlfmUt0DxkluhJZJlC5LU2WLQ7IKJlVf6wnyLeq77/RhSnJ+cmbK+g4ioyc?=
 =?us-ascii?Q?nss88tauicwVUaW2Ud9WgVyHeCn4Sh2CVcdqbGCjO5PzBziYL49MBBaaEbkt?=
 =?us-ascii?Q?5dZaAPBGhoe6pZrzLhcsr+nQ07TjgcZ0S9bXvgq4gvKFiOCIFqiwD1cARkSp?=
 =?us-ascii?Q?EVbXX5JFlC5vUHsrM1hiL8W8QfjKpsyAdzP+3goJeFjzKs2vgb8DAtDiZ+wj?=
 =?us-ascii?Q?0O4HVB1G7/RW8dCA6s+5UTC6dnE9YEMxW3ABZEpOWkAf7Cra/3WeV2TZtLHL?=
 =?us-ascii?Q?SS+YddPH75Ot/7gLgVXFVCdNYVvF4qgGWlsmBzG9gVd3zP26giwVev8WJyIZ?=
 =?us-ascii?Q?x8iP26krv1XaJUsh524Kgv1hSW+vmvscTUkz/clim1TV094YtAYYpW+hbEri?=
 =?us-ascii?Q?uL/i2u1k1+VoZwE+dGn2atjVatB1KVt1DoVT3Sj2m4GhJvAI2Jg47EOwjg0k?=
 =?us-ascii?Q?AhXitgdkhnYSztKn/ENwE3qeomYnndTEfCd2VNY5yzlM2JyJgwJgsLo1Fdus?=
 =?us-ascii?Q?vR9XscykmrnTBbAfPpmhe7Qaz+1J/FMdd7Jt5obg1jqfjtddDqWq00gMjI5t?=
 =?us-ascii?Q?amV5WpUWNGThUCOl87q+RGXgqgVe38hGsHFZ0VriacOGW/Ux+4BPLVyKvwER?=
 =?us-ascii?Q?6dSekVWTZ8wU22waY4m6z7ErxMqYZ8isvE3C0X9lZ6DybvYdYaqmemM6of6M?=
 =?us-ascii?Q?4XQsTUSx2DfwqeMzh4JPjzqwc802Z5PyPRieROUW9k7lizjBYRQoLVr9gg21?=
 =?us-ascii?Q?i9ugSxzCQ/kJi7mjw/OENmOrJAFL4O+WtMINGicB1chAaazBNOk0IGs+WpRd?=
 =?us-ascii?Q?td8jvGYoYW7kslNRlyjYNLkg1rxunLZ5+jmVRCgqao3WU+e9Xndjx5ZxDT5D?=
 =?us-ascii?Q?Po3mHq+zvtymRVic+2Gn45NuRIApKMFZksqs683J2yZ1sKtXzRnlHqbc1lJe?=
 =?us-ascii?Q?eu1Rk81hiDf+XNmForga87UEtEfkqVWbyuSyA0FDE+10ldMR5il8/CmrO16K?=
 =?us-ascii?Q?g0+LVeWeHIKlE4H2uuCvxcaup93DM2AheBgrO7qfDEICm5/r3Hjk6S3OYQNn?=
 =?us-ascii?Q?8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91898739-e0ee-4a6b-2e7a-08db66796c77
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 10:33:09.9625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/eG1vGEKaXmrTbQaBUTrNGjcOL+2Zc1/Rbf/skGe5h6VDhUO3A5l4rXyYNkWyuwbHZWXVrzT5KMLMMDNFVQsG/DkwcJ0ZavBQVCY6CfjtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6226
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 10:33:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11865

Hi Pavel,

> Subject: Re: [PATCH 6.1.y-cip 5/8] counter: Add Renesas RZ/G2L MTU3a
> counter driver
>=20
> Hi!
>=20
> > commit 0be8907359df4c62319f5cb2c6981ff0d9ebf35a upstream.
> >
> > Add RZ/G2L MTU3a counter driver. This IP supports the following phase
> > counting modes on MTU1 and MTU2 channels
> >
> > 1) 16-bit phase counting modes on MTU1 and MTU2 channels.
> > 2) 32-bit phase counting mode by cascading MTU1 and MTU2 channels.
> >
> > This patch adds 3 counter value channels.
> > 	count0: 16-bit phase counter value channel on MTU1
> > 	count1: 16-bit phase counter value channel on MTU2
> > 	count2: 32-bit phase counter value channel by cascading
> >                 MTU1 and MTU2 channels.
> >
> > The external input phase clock pin for the counter value channels are
> > as follows:
> > 	count0: "MTCLKA-MTCLKB"
> > 	count1: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
> > 	count2: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
> >
> > Use the sysfs variable "external_input_phase_clock_select" to select
> > the external input phase clock pin and "cascade_counts_enable" to
> > enable/ disable cascading of channels.
>=20
> > +static bool rz_mtu3_is_counter_invalid(struct counter_device
> > +*counter, int id) {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	unsigned long tmdr;
> > +
> > +	pm_runtime_get_sync(priv->ch->dev);
> > +	tmdr =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
> > +	pm_runtime_put(priv->ch->dev);
>=20
> pm_runtime_get/put is unusually fine-grained here.
>=20
> Do we need error handling for pm_runtime_get?

No, it is ok. For error handing, if needed, I need to use pm_runtime_resume=
_and_get.

>=20
> > +static int rz_mtu3_count_ceiling_write(struct counter_device
> *counter,
> > +				       struct counter_count *count,
> > +				       u64 ceiling)
> > +{
> ...
> > +	ret =3D rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count-
> >id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	switch (count->id) {
> > +	case RZ_MTU3_16_BIT_MTU1_CH:
> > +	case RZ_MTU3_16_BIT_MTU2_CH:
> > +		if (ceiling > U16_MAX)
> > +			return -ERANGE;
>=20
> Missing mutex_unlock here.

OK, will backport the patch [1]
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/counter/rz-mtu3-cnt.c?h=3Dv6.4-rc5&id=3D1e28dfdf40d7293882ba7eb7=
0a3bc0e9ab625377

>=20
> > +		priv->mtu_16bit_max[ch_id] =3D ceiling;
> > +		break;
> > +	case RZ_MTU3_32_BIT_CH:
> > +		if (ceiling > U32_MAX)
> > +			return -ERANGE;
>=20
> And here.

Same as above.

>=20
> > +static int rz_mtu3_count_enable_write(struct counter_device *counter,
> > +				      struct counter_count *count, u8 enable) {
> > +	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count-
> >id);
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	int ret =3D 0;
> > +
> > +	if (enable) {
> > +		pm_runtime_get_sync(ch->dev);
> > +		mutex_lock(&priv->lock);
> > +		ret =3D rz_mtu3_initialize_counter(counter, count->id);
> > +		if (ret =3D=3D 0)
> > +			priv->count_is_enabled[count->id] =3D true;
> > +		mutex_unlock(&priv->lock);
>=20
> Elsewhere you did pm_runtime_get inside the lock. (Which might enable
> code cleanups).

Mutex for protecting shared resource

And

PM for register access.

Both are having different functions. Ideally, it should have
done inside the lock as you said for consistency.

>=20
> > +static int rz_mtu3_cnt_probe(struct platform_device *pdev) {
> ...
> > +	mutex_init(&priv->lock);
> > +	platform_set_drvdata(pdev, priv->clk);
> > +	clk_prepare_enable(priv->clk);
> > +	pm_runtime_set_active(&pdev->dev);
> > +	pm_runtime_enable(&pdev->dev);
> > +	ret =3D devm_add_action_or_reset(&pdev->dev, rz_mtu3_cnt_pm_disable,
> dev);
> > +	if (ret < 0)
> > +		goto disable_clock;
>=20
> Should we have dev_err_probe here?

I guess, it is not required unless there is a valid reason.

>=20
> > +disable_clock:
> > +	clk_disable_unprepare(priv->clk);
> > +
> > +	return ret;
> > +}
>=20
> Do we need pm_runtime_disable here?

Not required. On error case, the action_or_reset will call rz_mtu3_cnt_pm_d=
isable.

Cheers,
Biju

