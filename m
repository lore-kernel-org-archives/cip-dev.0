Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E83E98FAA
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 04:21:49 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.124947.1775708503591987924
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Apr 2026 21:21:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=eeVkJE6a;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1775708501;x=1776918101;bh=+OjEpP+KlrqK1LT6sgp0iq7tujBu7LuYdxUo2
	9pVR50=;b=eeVkJE6aHOqZcwGZdGGZ3UMF/6y8aMHBbyQaHQ9oQ5qY+TcJPPSsMwqbgk6HLl95AJb
	Ax5qXGvVAArnBqLvV0sVAL06Dh4uVjKVl/a+RmI/J9OeRjH4QpvbiHCghJITR+Glsjz+wOaGwDKi8
	8dY/IBaGeNCHCStnnqCwNGy+jkN3owpQfh6qFyl2uK2iDwjJASPelTBg3D5oGneriI6dOaFpuVJR6
	bZnYlQV6ge3qo11lro+YHP7rYEC+fdqNmmWHSD035TocW6fJFJjAqX0uDPSbpcI7RUv4hEPp3NGU2
	1GJUt+pKFSlI4tXvRggd6LxhbmtyU0wMj78B8O8NiO7w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 6394LeJC545819; Thu, 9 Apr 2026 13:21:40 +0900
X-Iguazu-Qid: 2rWhiLDMSPwHhJwN9t
X-Iguazu-QSIG: v=2; s=0; t=1775708500; q=2rWhiLDMSPwHhJwN9t; m=qlt+2g96q3ohZwl0ew3vLYBscB4U157rpLYuDkmN8ZE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4frmwM5dT8z1xnl; Thu,  9 Apr 2026 13:21:39 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWHWJN9rOm7IjLyTMbjHsPpbXyF2qHtaOch5tdkNt9DBWWI8JedcIgFORsyllZ4kJ/f/Yes49AheoTnKaHGwD8iYqZvciwGl/bHEBfQzdpDHA+YSDvbYHKccXhOjjFvoIdVJ5PxNtOhrctOFBm5CBSzqocJMW284NdSbEndMe0/0/0IuGeq6FRUT/qAFw/e74Mv+g/Bfwhd7S3oHGKKzwdVGYI5sNBY4BXL/D1Hfm+YZx/h/XiJoh1Tu65nLp8sHJ9kps53jnDGjnqLmwknTTlokfSBAiR34PSXCVxierJQWR2spveDkJWOeaFlOdQmKTDZ58Z0wamBREIRpWMyH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1hRzIfi4y94Ylkl2QUlPUkKs1jHKebz38wGczWvikA=;
 b=n15r1k9h0sEiwCd+L2h/guVU7zroaJwAjyFUb76iECfQAnLXInsXKqJojI20Xbig8EI+mxPLAB/GeiWNPnkD2Ue0+a92rNENTHo+ObR12DaDQTZwOiKTV3niuaNJdBCrVnQe3YM4yGunfXWSo6W7GrDL8dZb2rLIeab/VSOQ1MmhD3GNN4ZPM3TREevUNILNwbhr/oo7ma9Kh/L69rxLspSt8TGqKtoCYlqWMS24oDsJoSVWvN8dvH73HYa0KxKMv6iIirv1QENn1bJ30ztntWpRSQe1+QzKf4fY+1pWf+P4VtmI8nv+d6/aoIXHW481VWYk532DPtk992I76UwnSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <ovidiu.panait.rb@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/7] Add RZ/V2N TSU support
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/7] Add RZ/V2N TSU support
Thread-Index: AQHcxzut00Hjw9etjkmHdsTnnCvpbrXU+76AgAEEdUA=
Date: Thu, 9 Apr 2026 04:21:36 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818FF347CF8680AC35B7EDDCD582@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260408093951.66884-1-ovidiu.panait.rb@renesas.com>
 <adYyRYcGKV-VMAAt@duo.ucw.cz>
In-Reply-To: <adYyRYcGKV-VMAAt@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS9PR01MB17120:EE_
x-ms-office365-filtering-correlation-id: e425c346-32d0-4ae6-2755-08de95ef7da5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 
 41N1QN047VpAC89ArtDGR6oegDy3UvpommdEaMvJ+GNrWU/y9kGreR63j/bwX2n82oV/4VW5y/gh79DbDAu4eUneO+E8U59VWy4bMW9XwnctTI4+USCln5/lhZwb8v8Dx75JIEcGIlkZ6UrZNf6OXrtfbD1dOBR/V7w1tXXKFDE7RYUFjVzMVxvWJRNRA6eSkMAYDzRHmlHypQ3YHR7+Gj9hccQw4+F2/zccMrVsccl9RZ8gdpI9S+gLl8ZpVsrJ3rbInom5S6EdlaU3F55bZX0EfDr4gFgVxSvI6eO2JU0PNhxwYC8OBZ55iAtE6K1cZJyOeGFuwxVhSJOxkhTFIa6MulA0Iaz6wvmGJOWIoICzssCcto+gnSinQqYssTVYl/IfaNQI7ThFJtE2ISSDNYCFNKSNIxFDHSwJWU5oxCIy0oLf4Nl82AznklQvKeAyiLO3Sa4VnV8vNVQC2lQlnylMJ/7/8DUVa0u2JxjBguw71fMEzlQZwtr/l8aYuOsbL+hzGMuzyfUbgd9iTrNfWg2upyB4dOP00i3JNgu/eMzlJvysGs4HZl4h1QBL6xCGOVJgQs08GZr6DYPjRNqLh9L8nlICFGGPPyeSr87GRz6tipxLCHzThtsgT8NzMJVwoEo7M9vNU+UIqo+PahfjUd2l0xUTzlMJBMrv5HqxLsGTjgzrg6ent2TNIuq9iIL0d7iOK9dUDSfzRtx7na1C4Sw7Qc6vT735s+0UUaP6p6I2ZyVy3SZQHCeEIylz7n63q3ksgq6MjvOfrz+WzgfxDuDzcZvKSUkhlMGDmCilk2o=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RnBwTGpyRStDaHY5Y1FKL2YzMklMbXppMHVLS1RiL2ZvaUFCY045d2dk?=
 =?iso-2022-jp?B?eTJlSDBzY2V4b1NXdHdBSHRMVW9NZGs3VjFpZDlpUlgzN01UQUx5K1dQ?=
 =?iso-2022-jp?B?by9CdDZVQUVrTkx1ZHU0aVVRTGZQWXBjMS94K2htZmNQeUxmYlZLbmp3?=
 =?iso-2022-jp?B?L0dxMVN5VlFlQko3ZjdZbWpHdGJwL3gweGxDVGQ0VnZQck9hekg4eFpY?=
 =?iso-2022-jp?B?SlVqbkVzSHl3alFlMnlKQXByK0JOeE04RWFYbHl4Y1RLNHNja0F0OXlq?=
 =?iso-2022-jp?B?ODJHNlptYm14QWZMVjFjb1pHcnU1TnpNWW4ySzN4MzdvMFo1VlpPdzFU?=
 =?iso-2022-jp?B?a1pzS0FEY2pqdFVJVDBscDVzM2VaOWRLYlRYSG11eHZtUHNyMmFRb0Ft?=
 =?iso-2022-jp?B?b3N5M21KM2hnT1M4aCtkQzJEYXA3SUpLMkphNy9POHgzN0lvRnRyZ2Uy?=
 =?iso-2022-jp?B?eldxTDVGQTZ3OHJEbFptc1lqakphS0ZlRU0zWll4NjN2eGRDMm0zdmZh?=
 =?iso-2022-jp?B?VE9telN5OFE1R3I2VlFBeTM1eFk1S3lTUGdCdnZ6cld2QkFXbXdLZ3hj?=
 =?iso-2022-jp?B?eXAvb0hCaDZhbFFlRlRTWFNjUVlmMU03M2E0Zk1Ea2svc2hma04rUXU3?=
 =?iso-2022-jp?B?ZUdrZEV4Zzd4T1g1U3FuSjdMRDc2RmFyTWJ0YU52b1lNQTVJQUJ5dVR1?=
 =?iso-2022-jp?B?bm9tVzR0QmZpaG9Ha0tTTXdxMjJ6ekl4RFRKbTk0eHc3aWNEMFZGaGlR?=
 =?iso-2022-jp?B?KzA0dkc4Z0hnMWtibC91aG0yZ2RVQ0doTnMxck42Rk9Hb3FxYWdaSlgy?=
 =?iso-2022-jp?B?Vm4wTk1qTEIzL282WHBDUHZNVTdLczB6T1JVSEJEVEpubnlaTG5sdlBM?=
 =?iso-2022-jp?B?Z0krSjg5VUljYVZWS1hadkd5R0pyMlpoamNKRFFkVTJtRll1ZkpqSmo5?=
 =?iso-2022-jp?B?NEFPcE9mWWVHbEdnNlNVbnFoWU80MlkvUkRwMGk0ZDRBaW4vcG1rR0dW?=
 =?iso-2022-jp?B?RENEbGdOQ3psclNrcnJ6M3A5cm5BSmoxSFB1c2NoY1lRUUYvK0IxSDRN?=
 =?iso-2022-jp?B?cEF0ZHNaYWVoMEM2dG9ZcDdjOWJlMDF0OEZYeElud2pDZUw4dzVXVDR5?=
 =?iso-2022-jp?B?dm8rNDg5c2ZLdXhpdlBLUHN2OGpPVEc1QVJyT0ZFM1VtQzBQUjBQZVY0?=
 =?iso-2022-jp?B?SmdCcDVTdm1kMW90aEhDNE5RdEpMcVpoWkZwaFB1WWI4ZVI3SldTOGd2?=
 =?iso-2022-jp?B?S2VveUc4dkJ5T2JYc0VQdnZQeTRhaS9qYXFLSXIrRktLbURJeUs5SHdk?=
 =?iso-2022-jp?B?azdIZkNWNEtnM0pESlU5dlBlaTBmcFJRQ2sreWJRcmhEMG5TV1hMTWdk?=
 =?iso-2022-jp?B?bkswMk5YTEx3dWczajE4b0ZGSXJSVFNhNW8vc01IVFF6SXFjamVLWTJC?=
 =?iso-2022-jp?B?QkRvdHlndzBPM2lGODZLS3hZSUVwalJLZ3NmUnlaeUw2V2V1NkVDdzN2?=
 =?iso-2022-jp?B?TGttMUJOaDNodS8vSzJZOHhqSTF6ZnJxUWdMSE1DOFlTOGZkb1JwbHM5?=
 =?iso-2022-jp?B?QTdKSWZIdGRDQVVGWExnV2NWMVRMUmNuMWRUM2lhejBmM3hKWVpsYmFt?=
 =?iso-2022-jp?B?bzAvYWdFZi9SRTJXRUZYMnQxZ0xSWEFXcFlrRTNNTWJLWG5YU0NaQytw?=
 =?iso-2022-jp?B?QnFaaGhJeGd4bHRFN2lTTWE5YXRzMkVyWUNMZnQrT1I5bFluT0V2ZXNX?=
 =?iso-2022-jp?B?SUhCdkFuSUw5SWtGS2RTTHVuN0lFdUJxVmJINmU0RzhDbjdib09oeDJO?=
 =?iso-2022-jp?B?aUxZUEQ2N0hxa0svWXVPcmpnbVRlWk00empSamdYZkx5bEUrMzI1T3lK?=
 =?iso-2022-jp?B?ai9tU1Y4L0JKNGl4ME82Mks3TnJlVzVtTDhJdnY4K1k2Y0lyeHJRTFhF?=
 =?iso-2022-jp?B?aFNuVXVCQTZBSG5RWmp2cTlMNHZXQjRUMklwd3prRnBraHFXQzI4SmJT?=
 =?iso-2022-jp?B?VEptQStJL2hKMUp2MG9UaUpwZnpvd0JQUmNZQTkwclBhMlJSemVxbnBW?=
 =?iso-2022-jp?B?aTdWRHFQbVpCN21rY1NLTWFRcmY3TENTaXBPeHJNdDQ3NWhhcjJRMndp?=
 =?iso-2022-jp?B?dDg3VW9lV1h1S2xGUzNtaFpQOFYwOFA1aXc5Wm1UT29qc0JxeXR0OFFP?=
 =?iso-2022-jp?B?YUtFZTVET0ZhRFhnR3JPb1VQRUxZUTlKdFVVeWViT2Niays5eFh0ZGFU?=
 =?iso-2022-jp?B?eC9VeG5IL0hiM3NxVUZQVzNPcHorSjc3ZkJQa2krWGFyMFNWeXcxKzdF?=
 =?iso-2022-jp?B?Rld5ellUS0x3bVBJclovOW9FZlhPMXdwc3h1b1lqRTNtazN0eXV5c2FF?=
 =?iso-2022-jp?B?WGxwOVI1TzBJbjNvRmpTVzV2c05iQjRpeDNHYWZTcUgyU0FSTkVjbG85?=
 =?iso-2022-jp?B?cktjYnFsTXdkY2RNbjhmdG9jZ2REejBRNkYzRHkxTlFLUXhHWUt6cDRL?=
 =?iso-2022-jp?B?R1pVU3dmNnhaMjVjeHB6TE9mNlBiZWxNVytYS3IwMUNQT3BDY0wzREZJ?=
 =?iso-2022-jp?B?aUlUTlgxMD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	oVTj3MBcjD1JB+byNxGq6rn/Rk0nyWEHoSyO0Kz4LO4HQkKq+MHSPUmlAzrbfkH0Ghtdd/WxZ8bFMgmDxH287dW/2DoE4qbPSUP7cMIxHBMisRbvH6HK0eR6FGYvXqS1hzOQy4aws92esEWJHM7CF9zZaPsMDFDFUVnuLnWTIMfIrwfBx57ln0VeEVGjy79jcQ2cmBPeLk4ChvVQDJd+vqBY0UFJWGbXELjISzGE1KQa5coZDtgs9XUVFwVDoh3xCRBijpYiZnTWtt+HkHuxTSZ+KcyCWpMa9Pz0xTTohcGhczSX9Kkgn98Aw/jW/Y9pBJxCH/XEnBUKZY/Gmu7rsw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e425c346-32d0-4ae6-2755-08de95ef7da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 04:21:37.0346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m9qWetSTQdBc/pSGOmUE7DgoDNqcPQS5rt4cEP2XPf+PVUZEReaFLkbfx3Td0quxYgD8ZVumMfn3cN7yvKyagMSAmS8gtgHtQcovZau3OadqsAbHuB90vGNMu86oyKJI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17120
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Apr 2026 04:21:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22656

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Wednesday, April 8, 2026 7:48 PM
> To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/7] Add RZ/V2N TSU support
>=20
> Hi!
>=20
> > This series adds TSU support for the Renesas RZ/V2N SoC.
> >
> > All patches, except for patches 4/7 and 6/7, were cherry-picked from
> > mainline kernel.
> >
> > The RZ/V2H binding patch (1/7) was missed during RZ/V2H TSU
> > backporting, so it was added in this series.
> >
> > Patch 4/7 is needed to fix asynchronous aborts during unbind. See the
> > MSTOP series for more details:
> > https://lore.kernel.org/cip-dev/20260115083451.1064048-1-claudiu.bezne
> > a.uj@bp.renesas.com/
> >
> > Patch 6/7 is a backport specific change that is needed to allow the
> > thermal driver to read calibration data from the system controller.
>=20
> Aha, explanation is here, I just missed it. Sorry for noise.
>=20
> Series looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I reviewed this series, looks good to me too.
I applied with Pavel's reviewed-by tag.

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


