Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABB0EB64DA
	for <webhook@archiver.kernel.org>; Wed, 19 Jul 2023 13:04:06 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.101])
 by mx.groups.io with SMTP id smtpd.web10.13060.1689771836304117856
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jul 2023 06:03:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=FctML5lR;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.101, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5kDqEB6kLfDLmxPGUeFbGaEPD0CsKsHjqoTet8DFXvvkZJwR9XgwslV1PWC19aq1nIBFbGIRrYHAM0xsAgz2UxuL7M8CfHSIMAVN+vKaYECjkTG36BRzDd/gQQGQZlFVX7bAC/SB5F4/6xYZHoBPK11wSMBjEoKAIr01mC7fIxSUO3K8pmvlyP8a5tVvdeiaH5HSiRYBgdjKJx8RE4RUYFZuFLhoGeu4rY7EGCh0lGJFMsd20zm1Sao2q9oe8yKM8j6EEUGWtfpOgCJJVu6A2pgwpd9Qtmq/JAMR/5JVuRvuuONlezmr+yby02UPqlmLFIZCctPrGch9XxxpG6M8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMAlBNPI36qORx6dnVXk4m3IdZPgt2M+fjH2raNctFQ=;
 b=W9FVVFxSBiN5WQVUyj0uBWn2cZTLninROw3lN1YAwpOCSDbipAj89DwlTvWKdCS55E+BPoHk/E65dtnmuylbG6z/+SpofJ2KCLnFnE7XYEv5wtTPpKs/yYRj6Wo+AAjaOKCTEwBYPsk1Lyi3A7iUiTJe/v3W1zSLKsd51UgkAkce0sKeKL3bBwczqyfTXM795ioWg8OBWJIghakCrDmCFswh9rZZnVk3g2QVNvZaR6oW0JuGFfUGg4+REbr3RcJ1o7nVQHbKDsrngSTgtHSWh2UgTQ4UYU+rcm7QwR21Ue9ml9M8koqnwx2MxtUtFqH12SIKJeM6qJWnl23XgI4LjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMAlBNPI36qORx6dnVXk4m3IdZPgt2M+fjH2raNctFQ=;
 b=FctML5lRFwThF1bn8u1Q1eRiKqPXJWHvtcBaPKumH4hlugIsQWk6iM4CsG6k7C3WQ9fjM6kGMb/crMNt6VPCD5BlKe89905ZcymTvBcBKBeGV0k7Ctod0KJwtCfAs1jk8zOeG0J/8Em+ez24+VzGmWnJiUUFWB/3uxymn8Qmtto=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5703.jpnprd01.prod.outlook.com (2603:1096:604:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 13:03:52 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 13:03:52 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 5.10.y-cip 08/13] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Topic: [PATCH 5.10.y-cip 08/13] pwm: Add Renesas RZ/G2L MTU3a PWM
 driver
Thread-Index: AQHZuj3wtWud4gm20ESWGw+pQ5abHa/BDTzA
Date: Wed, 19 Jul 2023 13:03:51 +0000
Message-ID: 
 <OS0PR01MB59223622DA8C82AD2A955E058639A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230718140608.119449-1-biju.das.jz@bp.renesas.com>
 <20230718140608.119449-9-biju.das.jz@bp.renesas.com>
 <ZLfZRrLwZmb7ZIf8@duo.ucw.cz>
In-Reply-To: <ZLfZRrLwZmb7ZIf8@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB5703:EE_
x-ms-office365-filtering-correlation-id: c50d17ca-6af8-4de2-e4ad-08db885899a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 o7hnfuLBkGCNDWVW9Uz0By01NirwSSD6p50bwOl67HXqh9yE6mqynDhDHpnrdXd53cSZS8A7x6WA0mom9hL4HNoknqC99nJUgVpMIdS2UB5Y1EM8Zqy3YzClxwe/ioLoFwtTadxjdqsLPZQocdHxw13gYqOg8G25FoZOA57K6jJHOQ6yWBmHFTL8MLdo1vCcoNEgzT97rWoK/qSb3elpPKiSN6xpzjFfWPdU5unvdEkM7gWqvMA8hB06s66sF6HNOEFbrBFmdrYZsRAZPtCGQZrK7qFugFqdLgxGPBp/ilTMIEtJ4YJ73ZYY08fG0QQ2YLph4ZWVb57HD8LqT8MBGvHyrhq0tu8kzH6vclGBDM/UBXNv/MWCkkZqeX7hQXiEdvLxBmiQoArxNfqj2QfC3/EtqdTPAxtS5ya2DYJnGXe4xuFVnMqb5D2zOKKmD2ZaRiGTjLYpG3jsOmyHVYy7LrBu7O7FuAluuJGVcies7CLKa2jp6mfdc1JcYit+AgB/R0Do50+5FyUyx8xuXopIM+mK9ex0dVOuvd3nLT6xSwcGnL0Do+7u6psQj11aSrI0KFKKkaKUhxpyLq52xTjbXWhuOi7RcK+Fm+RB0+5yBXkTCDXSY7qWIMU8fKEg2iVGm31JFGCp1RoT3TG6S+inUw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(71200400001)(7696005)(478600001)(54906003)(66574015)(83380400001)(86362001)(33656002)(38070700005)(55016003)(2906002)(6506007)(186003)(107886003)(9686003)(38100700002)(122000001)(66946007)(66446008)(76116006)(4326008)(66476007)(316002)(41300700001)(6916009)(64756008)(5660300002)(8676002)(8936002)(66556008)(52536014)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?jOptZPHHLqi3Fx2Aj/YcvJOtGQ32wiUb1P3LFwBN2/BQC3BpLtZAHN6z21?=
 =?iso-8859-1?Q?748yZ8NlhoBVfRjN6aK0jEAMzScMPy4jdULUK9ELrnbDdBVCk/RF5mo9WF?=
 =?iso-8859-1?Q?bPUVGTjoCCEJQ39quuoMZhB4ChfbCnmxTN9JFltaeidefg3pvtwiwEwH5G?=
 =?iso-8859-1?Q?LDzZ3ZumhXe1wDDqk0BGQA3q0qjh1o99pwDz3RhiCgF4zXRCVqrivko/rd?=
 =?iso-8859-1?Q?J7Rlh1AaNB2LCN0UxP1+rkVFG7ehceS8Q/gLHM6kgBry+Y3d4CsUWo/rdB?=
 =?iso-8859-1?Q?aZ//lmDdMPFAJ2Mq3+XsSLP7flizyJCjucRNJXSmLKX8ipDBEBWfGVNVY7?=
 =?iso-8859-1?Q?PVsEEXj8cqD6ccxUdQGuTNga9BQYy60vkLtGuFE8fmjCR9FlWeS7xKQXXW?=
 =?iso-8859-1?Q?iwHfVD3hU6Z9WUAOrXf4U9nOjPDHKDf9y8ZcTZsgxRNEBHbnvqPj57MExp?=
 =?iso-8859-1?Q?A0aGJiuA8WRj8RrgPp0Z9EsTNNZ9YxDxMAV3efFIyPka78BKzypZopfzQ1?=
 =?iso-8859-1?Q?dspNQrQVx8gmSr8lNuG9tH0AQesPfA5wX+7PUm74Zz+5iBaFfUIkRgEgo4?=
 =?iso-8859-1?Q?UcKN6CRsPypVEGOrwFWX56YX36RKT+kNdVIuSRLSvcpw62HGa1s9ehVhnP?=
 =?iso-8859-1?Q?H5IzCwM+C2Kv4n0w+HKXlXQvYdW8p3LdOE6LJrslco/cpIgU/rE0Uv6hbw?=
 =?iso-8859-1?Q?mMCDw27PMD6s2Eq6K64H4xSOwoYIqF+SJI9jcpG8gLvfbkV0WKUbEIeERR?=
 =?iso-8859-1?Q?Cmym79uGliXaYZaHBEL/SNydTP9woxbeIkvJp0M70+3PnovXX9wTQyZ1Pf?=
 =?iso-8859-1?Q?hxOMZbe3dpa/yeHcnCJVFPlq+mUOzkawB2qu4dvnmLu4wlsJu/DvpHNgDe?=
 =?iso-8859-1?Q?33Iwl/l8dv6BjuL2WcMqrdznSCJsj/Ge1paDS3Melxz0VDe/hMO9ExLeOS?=
 =?iso-8859-1?Q?r83znbP9aAxjmVFEXXDqlpq9ZidM+Ob+rYuBZG0/f5KmUBQZGUDdSPFfA2?=
 =?iso-8859-1?Q?n8bL8H+kF6AQBW1v4+qghIwkNHV908h98lYpiXVYVBZgKS2MgBRap2cac6?=
 =?iso-8859-1?Q?goNB6k2GlLx78UsQH3sRe/u/aT12GoUMWJ/h6Pjm+8EggP4wHLYrd/Rmto?=
 =?iso-8859-1?Q?ZfO1y3nRxlaTEjZS82eG1f/bD8UFmn7RtVX/9817Rj2QPbZtoYPb25MgWF?=
 =?iso-8859-1?Q?7wumt0TS4BAxtzxUvj9NR2SWTpvXqHqm/9fDcaAi2tpPVf9a53QT470fQ9?=
 =?iso-8859-1?Q?LQmU/gW1DpgtGtVD4CKW9iqwNbj51W9/lZt0ZkAvcIK55FCpPHWQ3GMRvQ?=
 =?iso-8859-1?Q?Zr4+r9Zqjin4CVVXTJEVe/Vn8lyX0Vc3lrY6c52ZY3+zmY7x6yrP8ojWCm?=
 =?iso-8859-1?Q?n9Swxu5pQ2zqMjHA5rIOyZc9WqzOJ0DJfkJSN+CWnBwQ1hPUSnbG9FohVD?=
 =?iso-8859-1?Q?tCO3ThDuvM5SSlIEVzlyKjOqHXbDu9DcZ5evMqmgvP6c7zJlDp+rUcrN7U?=
 =?iso-8859-1?Q?kb2e0eMJ6XH0tqXuEQ157YaIZMuUWfpx3uT1m4ugOXbkwUJ6O/xdn7utP7?=
 =?iso-8859-1?Q?2bNICZxtShCQjdx7et1PPBXOqGXrAYJRO7/q9DOutKjuIgojHnjmtcOLOX?=
 =?iso-8859-1?Q?uu1DBEByX1bYs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50d17ca-6af8-4de2-e4ad-08db885899a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 13:03:51.9119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EYrJgG62BLxTNQCLzZqZWTSjbVea4Swv6DNPJQ3YPXFZbyBRG/I0m6vOm+bK2DfJMEEx6i00kM/j0RdNpDSnMwk8P4/9/ZlNRf0AWPl+SnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5703
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 13:04:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12425

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 5.10.y-cip 08/13] pwm: Add Renesas RZ/G2L MTU3a PWM
> driver
>=20
> Hi!
>=20
> > The RZ/G2L Multi-Function Timer Pulse Unit 3 (a.k.a MTU3a) uses one
> > counter and two match components to configure duty_cycle and period to
> > generate PWM output waveform.
> >
> > Add basic support for RZ/G2L MTU3a PWM driver by creating separate PWM
> > channels for each IOs.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > [biju: - Replaced return type of rz_mtu3_pwm_get_state() from
> >          int->void.
> >        - Replaced the macro DEFINE_RUNTIME_DEV_PM_OPS->SET_
> >          SYSTEM_SLEEP_PM_OPS and dropped pm_ptr. ]
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> > +++ b/drivers/pwm/pwm-rz-mtu3.c
> > @@ -0,0 +1,552 @@
>=20
> > +static void rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct
> pwm_device *pwm,
> > +				 struct pwm_state *state)
> > +{
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> > +	int rc;
> > +
> > +	rc =3D pm_runtime_resume_and_get(chip->dev);
> > +	if (rc)
> > +		return;
>=20
> Should this at least WARN_ON? Unlike mainline, we can't error here, but
> I doubt we should just ignore error silently.

WARN_ON or dev_err what do you prefer??

>=20
> > +static int rz_mtu3_pwm_probe(struct platform_device *pdev) {
> ...
> > +	mutex_init(&rz_mtu3_pwm->lock);
> > +	platform_set_drvdata(pdev, rz_mtu3_pwm);
> > +	ret =3D clk_prepare_enable(rz_mtu3_pwm->clk);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Clock enable failed\n");
> > +
> > +	clk_rate_exclusive_get(rz_mtu3_pwm->clk);
> > +
> > +	rz_mtu3_pwm->rate =3D clk_get_rate(rz_mtu3_pwm->clk);
> > +	/*
> > +	 * Refuse clk rates > 1 GHz to prevent overflow later for
> computing
> > +	 * period and duty cycle.
> > +	 */
> > +	if (rz_mtu3_pwm->rate > NSEC_PER_SEC) {
> > +		ret =3D -EINVAL;
> > +		clk_rate_exclusive_put(rz_mtu3_pwm->clk);
> > +		goto disable_clock;
> > +	}
> > +
> > +	pm_runtime_set_active(&pdev->dev);
> > +	pm_runtime_enable(&pdev->dev);
> > +	rz_mtu3_pwm->chip.dev =3D &pdev->dev;
> > +	ret =3D devm_add_action_or_reset(&pdev->dev, rz_mtu3_pwm_pm_disable,
> > +				       rz_mtu3_pwm);
> > +	if (ret < 0)
> > +		return ret;
>=20
> Should this goto disable_clock, too?

Not required, as rz_mtu3_pwm_pm_disable will call disable_clk, see suspend.

>=20
> > +	rz_mtu3_pwm->chip.ops =3D &rz_mtu3_pwm_ops;
> > +	rz_mtu3_pwm->chip.npwm =3D RZ_MTU3_MAX_PWM_CHANNELS;
> > +	ret =3D devm_pwmchip_add(&pdev->dev, &rz_mtu3_pwm->chip);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM
> chip\n");
>=20
> And here?

Same as above.

Cheers,
Biju
>=20
> > +	pm_runtime_idle(&pdev->dev);
> > +
> > +	return 0;
> > +
> > +disable_clock:
> > +	clk_disable_unprepare(rz_mtu3_pwm->clk);
> > +	return ret;
> > +}
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

