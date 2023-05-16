Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB97C77B7A
	for <webhook@archiver.kernel.org>; Tue, 16 May 2023 05:59:20 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.111])
 by mx.groups.io with SMTP id smtpd.web10.14561.1684216758394634391
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 22:59:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=DZo4lrMh;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.111, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/Y4a16Sckb3Ci32AEx0LuFypdk1tUlJIhIyxgBlq7g0IeFV7IncXT6UTsxNj9WX+1Ovh/L8BhZBVxebAiaWl5ED8Mxcv//H4fx6wSuKkftwS/AZxmb67obDYHZx2DNgO/nESJzHMDpxt2Gi8mA/+aqJGShIqHvEJ40oBnhDTZCrVmZyWoSBq49ks7kT3KwhMtuI3hp/ZmllEZjjlk/cKynmhbUod4N44YDz5kKZN/Bsv2VKI1aCV0c0BfLRFLdtPEgr6EGHsMyddVFyUPJ38Hk5/bLxgWoz1ucDH3LlH/ogVq8GXhNgDBvjq48lNvdtm4VyOzptvwTBugaC1BrebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSjHJbtkI3WeFtV2dUqacu2jba3a5y6tMkAVxOZYKUU=;
 b=Oqq+rMc6cGQXzk+AsJeWGhonb1xlN7UONvYTjaYOenFnAlIJ5hzaG3q1SqakZ4l2pnHoDZDoVjI4q7Kh5Z8mKvjcwdl6z+eg4VyoK41mu5PICDovm2nrtWojeRznSGHhUBSY+uEQ4RPsQuq9WoBXR3zAEeWp6S38f/6rh/4yvuwcCWwfZW6BdJyXm7q4d71XsGwD6SVZiTKbduP1Y3rPjmUW8VeglbzlCTwTpLPcNkYwlzs8ozobotE5rBtZXSTpNg1dBPMEvtKtwjJcRj+KpR+Y4z6futBUjjkVDp4eym5/zSh3Cb6MXv3Ltutxr79MAcFQfTX07hyihb4WOvS6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSjHJbtkI3WeFtV2dUqacu2jba3a5y6tMkAVxOZYKUU=;
 b=DZo4lrMhtI7BST/+lwgHdYe9ACL9oDrl8RQe0CU17GZipkvkMtP/cFFg8joN/jeFrx/3MubHffd2SW9AoQV019ZSihHMjer/n7kiga3xitgU65VJevC5CKvNIucw8fFmfA0BBBIkIccM4c40DxduzDkqJZNCE1KbbnujkQ6xsDA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB5946.jpnprd01.prod.outlook.com (2603:1096:404:8056::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Tue, 16 May
 2023 05:59:15 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 05:59:11 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 2/4] dmaengine: sh: rz-dmac: Add reset support
Thread-Topic: [PATCH 5.10.y-cip 2/4] dmaengine: sh: rz-dmac: Add reset support
Thread-Index: AQHZh2yWbf2yuuxxhkaVPcwzHMg6oK9cZl+Q
Date: Tue, 16 May 2023 05:59:11 +0000
Message-ID: 
 <OS0PR01MB5922E31D2B70CD706FC297FC86799@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230515085352.25794-1-biju.das.jz@bp.renesas.com>
 <20230515085352.25794-3-biju.das.jz@bp.renesas.com>
 <ZGKXNyv5QJgs2q8Y@duo.ucw.cz>
In-Reply-To: <ZGKXNyv5QJgs2q8Y@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB5946:EE_
x-ms-office365-filtering-correlation-id: 6d79b67b-176b-462b-f446-08db55d2abdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 joN/todz4FYeszHlvL9mcpUZu3d8eITFstx5vYAm/UD3V5ChKvXuR2aeE3ECie3chgkkuZi1BYQr43XGdkxNSPosJ2KL898iw/16RzkiM1nkQQbIlWkY85JNZalHpV4mSkMQ+RT3M8/5/PnTBfWxHV1Uz3dpA4MRoIi09uhFH7RfXdSoIWCa+b9i7c3iRvofiB9Cv6crt8r7vXwp+REx7dg7yu0q7Sv2ArYIMuYCSjKd2Zbf6EARsYQaagZ+5UZRrAZNIVJSW1V4/EPwA3qM/paWnnCob1pZvhkXQnTEqFaFNdCvuxOY0RxYTRki7mbJHIuZB+7u61H+d3rssE1NX2reWiuRk1N6Fpje91rYqQQc5c5T7jcP0lJzNyrYJ68cjN1mJnpoNXafy1FgGNYJ46UJZ0ak4tQqOHKT4upjaKgd3NhyaAzZrjKJ2iGhEn2BcUep/dZPjYMwwW8LPS/aiXUI/0zWn+b+XjD7zHvHoYVeZ9ZtYTk4YdclSKic0wuT76ew4DcxwDq/Ru93J6AcgMfo86i4xaBCVzoRtqHks7NaP3OZlLXH9ZvjnHJtl9yWVAaL0hcA8IRJfqdw7hONsxUdFg+SdrQBO8xZptSzhlN8J9aEnyyfdpr8gwm8WBWN
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199021)(52536014)(5660300002)(8936002)(8676002)(2906002)(33656002)(83380400001)(186003)(122000001)(38100700002)(38070700005)(86362001)(55016003)(107886003)(9686003)(26005)(6506007)(71200400001)(64756008)(4326008)(478600001)(66476007)(66446008)(6916009)(66946007)(54906003)(76116006)(66556008)(316002)(7696005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?tLo4YwbG/f5uM0jOx7SgT6mWFgjNCpMDLU5EnnB3hudB2B9KL4b4JjfbCG08?=
 =?us-ascii?Q?CGweEARw6BYK418f+VBv595Pfti8iaPBhVfO1cNwHlIcCJo5TpmRynz2oRQk?=
 =?us-ascii?Q?iKK7n/G2JHtEMs6QiLnLhnzXfsoVoRFeDQnGVyKQbTlL5RhuHKKuSlRQHqDD?=
 =?us-ascii?Q?3SngJgqzFbkhnc4u44DuRFwSVSeq094Gcte0OjsCthOjtHtwCX9uFY0pFlMo?=
 =?us-ascii?Q?5QnXC6IMu+clURhbYwgUnekLrkOozL63C+ik2ccxCwQm6r2Vkrof5uWuKyV2?=
 =?us-ascii?Q?sA56SC5xhEvctDFoVVtd5p7t9ZXqd56ivkZQcldLY2nDu0S1PdZ2bRe7krxp?=
 =?us-ascii?Q?diYipWl/ZuFzO/9M1smaiIoDZ9nlnrTDJymR/2vq2n+54a6smVUwdBKz9WRn?=
 =?us-ascii?Q?NOGOHXSoo9Qx6MhiJ8OyVl/mt1mWCXNuch7fTmbv2jRaDheaQ5T4M8tqAWAo?=
 =?us-ascii?Q?pbt4l7bmdyhoJAO6P1GL5XFvMpvPTSHX2kOIf0dXJmp25rTWuVLvvztOHaYP?=
 =?us-ascii?Q?SmX1FstVQD/k6rmF/nQcPWu/2fOjRf1zNRi6eG906PS4ifamaIz8GuGFvSgw?=
 =?us-ascii?Q?0XMNTcK1r2SdbU78e308OrUQEEbH2RidnW3UVSBZXyqdl7AstTMWU5WGo8aq?=
 =?us-ascii?Q?fqv4lBRLHKbxtUcVK0UDC9Sex3MC+iEe+xCSQfnyVCaZfbxDLiteKAN8twJh?=
 =?us-ascii?Q?FYfzHZjlX0w1M2pd2JQ9Mf2libCxolYM2Emrs6wKhFTIBanl8DunVjjevFOT?=
 =?us-ascii?Q?c2Du2SobflTfXj7rKlz8j3uIL1Z8bcd5lPbtsz4mvW4bXh1ZOeWImR9BaVXs?=
 =?us-ascii?Q?sZqaxh9jQ4xORsa4L8C9+7gaXGVEI8mJEclj4IPTnbw8eLwfQ4U1phBZKyLA?=
 =?us-ascii?Q?LAAPUyn2kj3SRYAua0PfKg7fBXgKUxQJdPut3q43f4J51hAdzaMJqmizDcUN?=
 =?us-ascii?Q?ed68YGieD/FrULnDg1F/w7LMvDc3yY9hpRF1CCZnLACx1JfcewynZwsNgfEx?=
 =?us-ascii?Q?TwXVb/MRvgqnpv15I2dlBCJzTOvv25hsE0ctpOXPMbjeOG6y1Vfb0Pis4Qkv?=
 =?us-ascii?Q?bdNjfgglHxXCEboSJuwVlR1aMCMY5T9hVdJnY72o8L9pROqOtFf7PpPznT2n?=
 =?us-ascii?Q?VhPOhCVztQOjWbWfv4ienYm4Bj1pmD7pzDMvVfL7ByARV1p6KtCAVu0xW5Vi?=
 =?us-ascii?Q?nz+n4DVG0WI8RVfeXDxzSc5Kv/NrYoHhVLZQhucO4BTd4yRkV18BVWT0VQMA?=
 =?us-ascii?Q?6gMiTEudw2RkgEzoOpmvfYbyUAP9lWiH68a8Lt0yWojTQuXsEKwvKceb5hBl?=
 =?us-ascii?Q?OL3Op8njS/vB3D5s2rHxoJRBCMTzbdPtmEOddzNvLjdz4cRzP03/Uz7LkLH5?=
 =?us-ascii?Q?c179Z425v3wsHhcZVyii7TnuFexuawodsp5ua2IQVEpH4aSR/l5Ggt9CVW/X?=
 =?us-ascii?Q?7to5MZl1D+lJCRFEDV+bZom7uxD6lRHZLgZpYYjsDNdqgypcezMnKo7UUOfJ?=
 =?us-ascii?Q?HUPVHa9Z+LCVubE+NCXMuvSPb9TvoW9dqnwtzQHq8E4Y27dSizaAtfh0DCV1?=
 =?us-ascii?Q?m9k4YGj46JMY6M1iE1F3+U+MPO76PhuzNthZpsys?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d79b67b-176b-462b-f446-08db55d2abdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 05:59:11.7745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xoJUQHaacuPPp9dCmSYi4J3wGimqESyIKWPmQipSsln+WLLgKS/SBwKvJEhehOy8DLUi7j3LeXSgDasCi3eSmynmtATcr/Y1iUwnBtCa3C4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5946
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 May 2023 05:59:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11464

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 5.10.y-cip 2/4] dmaengine: sh: rz-dmac: Add reset
> support
>=20
> Hi!
>=20
> > Add reset support for DMAC module found on RZ/G2L alike SoCs.
> >
> > For booting the board, reset release of the DMAC module is required
> > otherwise we don't get GIC interrupts. Currently the reset release was
> > done by the bootloader now move this to the driver instead.
>=20
> > @@ -896,6 +903,10 @@ static int rz_dmac_probe(struct platform_device
> *pdev)
> >  		goto err_pm_disable;
> >  	}
> >
> > +	ret =3D reset_control_deassert(dmac->rstc);
> > +	if (ret)
> > +		goto err_pm_runtime_put;
> > +
> >  	for (i =3D 0; i < dmac->n_channels; i++) {
> >  		ret =3D rz_dmac_chan_probe(dmac, &dmac->channels[i], i);
> >  		if (ret < 0)
> > @@ -940,6 +951,7 @@ static int rz_dmac_probe(struct platform_device
> > *pdev)
> >  dma_register_err:
> >  	of_dma_controller_free(pdev->dev.of_node);
> >  err:
> > +	reset_control_assert(dmac->rstc);
> >  	channel_num =3D i ? i - 1 : 0;
> >  	for (i =3D 0; i < channel_num; i++) {
> >  		struct rz_dmac_chan *channel =3D &dmac->channels[i];
>=20
> I'd put it reset_control_assert() after the for () loop freeing the
> channels, to be symetrical with the init order.

Agreed. Will move reset_control_assert() after the for () loop.

>=20
> > @@ -972,6 +985,7 @@ static int rz_dmac_remove(struct platform_device
> *pdev)
> >  	}
> >  	of_dma_controller_free(pdev->dev.of_node);
> >  	dma_async_device_unregister(&dmac->engine);
> > +	reset_control_assert(dmac->rstc);
> >  	pm_runtime_put(&pdev->dev);
> >  	pm_runtime_disable(&pdev->dev);
> >
>=20
> AFAICT
>=20
> dma_async_device_unregister(&dmac->engine);
> of_dma_controller_free(pdev->dev.of_node);
>=20
> would better match the init code, too.

Good catch. Will fix this as well in mainline.

Cheers,
Biju

