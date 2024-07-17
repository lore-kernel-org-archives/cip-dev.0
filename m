Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28361C3DA4B
	for <webhook@archiver.kernel.org>; Wed, 17 Jul 2024 11:28:34 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.63])
 by mx.groups.io with SMTP id smtpd.web10.13020.1721215712237346738
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jul 2024 04:28:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=u8Bb3iha;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.63, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0OYhNhtAgZkpFEGF1QjuJMsHKzIFpRTb1NSxmFmxZCIR30S8Q6K/ftt75uQtx5F2EHMtJh3YN6o+0GhG9AC4n0UpcBJLwZiSHOgmu0TwEPL2e1x1zifxJ9N3XgkLgswHPncn3lTIjbw5qiJwcjTulCnxrRlLL5n/IptbN3CBvMnjGBqv112M6Mq4OVjGCtVI/dO0HznrDozitWWkys0y8LvA1q7/WLbqi6mIDEucridez+0iPZXOJ0ZvK67qmM4zcEsJ3/ed/HTo5b9VrpUi7f5fAuZJ3qZmonBRaP8WpKysAvRdQEhGZUatt3ptLqsLM7X7fTnf7chIz1eszhozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmCY2yaG4A0QZQnm8carD0RQaxYazHvQeQQw80zHDmU=;
 b=N5dVhSqbupNp87KPWydSxbqodCjaSoit9GBSjCq5N/foWUq+T7Qkfm/fkMNypYro4RJmipysSzJkVN4h27m3lkChHS7jQvWA0abkfg3FSRymwSzBOh8/gpxuJo6r9jD3XA1zHcpm3n3SpDO+iHgVU5J6EVXBzv0UBgLkhQsJwp45gqDkQhbameg7a19ZT1umICM+1auxP9K/PtVM6SQZng0uclfvZJSrJVmtNRmJFo4XyTU/cllZ/KBwkJa4/jCc8UeXhL7EkxOlN6f3hqhEUyAt7qV10lwxXIj8mJ76zhVorGG6omDv0K+EWUpgqYPvOVCO+EtEUGuQdKEgQZYEMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmCY2yaG4A0QZQnm8carD0RQaxYazHvQeQQw80zHDmU=;
 b=u8Bb3ihap2QEEU+eDC51Jh0HK/GVg2DNK7RVcWxhTcKqfzj7TAXlkbGSTNqHHMj7znrrVsywYZoNl5SFaCdj9xXh1tHZaGi0ilmn0BDL3kJyaHQUDWsPZG9/9Fk76LVPy0Lelo1C6oxtmrYbz+NuQaqr8ffGoS3VABMtBGMgeSw=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB8789.jpnprd01.prod.outlook.com (2603:1096:400:16d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 11:28:28 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 11:28:28 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 23/31] dt-bindings: watchdog: da9062-wdt:
 convert txt to yaml
Thread-Topic: [PATCH 5.10.y-cip 23/31] dt-bindings: watchdog: da9062-wdt:
 convert txt to yaml
Thread-Index: AQHa11l+zT8GQ9D1AkGMLFjAids1L7H6xRKAgAAE30A=
Date: Wed, 17 Jul 2024 11:28:28 +0000
Message-ID: 
 <TY3PR01MB11346AF4B50D83A2BAFCD5A4486A32@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
 <20240716082255.56551-24-biju.das.jz@bp.renesas.com>
 <ZpemkYsK6zQgGCF2@duo.ucw.cz>
In-Reply-To: <ZpemkYsK6zQgGCF2@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB8789:EE_
x-ms-office365-filtering-correlation-id: 9b6fc333-b238-4700-a708-08dca65394a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?DBoL2oFKkiD5jnJzaT0XOJHy4Xt3RYaCjyxdxdJgAfajW8jPh82pJoX/iBXJ?=
 =?us-ascii?Q?cR5X+fRrXxWHadoA99QMItmqew+QHaZjw7/rxZD9XqgBKHyvU2oK8OGph9fl?=
 =?us-ascii?Q?VwOqW3xKiXaPmL0GNiJo1jBRVoQmWAGDCoZJ4h1qRetww0pBMlBsLj19s9py?=
 =?us-ascii?Q?y1vbd4W/SFY4AQl8T8UxVcBJvefmzQotf+6w2/T677x5CQ755iY+AkwQVYSV?=
 =?us-ascii?Q?SSFHRW6CRLJwmtG/wl0aL2f4NuEFC2UYqqMqfAm861XKic8/xcHCCy1UNu5w?=
 =?us-ascii?Q?BolpU/7lVPROyJpkqPjtunMwPEu+1CaO2gq821OgkohsVQl4tlnw9/2E2de9?=
 =?us-ascii?Q?upxNDoI/7ZzEeEpTaQKD1kaW9hA4yqAwcux7uhP2JnGVSfAAQCuoj8Pzd0xJ?=
 =?us-ascii?Q?oV10RSLtGycODPGVCJE2N6lUsZj3/HAGszb+LdasUMk9qekNtpUNpgxa0Rq9?=
 =?us-ascii?Q?5zGjtTnH0V1lKeheHfYII3Vi+r4l4/DNT+Jq4v+Goi503UWSISuizC/FK+Ch?=
 =?us-ascii?Q?Wo+FZVJzbgYih7HndJbYwRHBia5N7Wv/I295VDHVxD9UNqlLyYoacNmj4+vS?=
 =?us-ascii?Q?7zm1RkBRgZ3hZbhqadmM/0Ot/Rx871bdgJifP4nqAANBKwXMb1SUST0W1zpq?=
 =?us-ascii?Q?NPuMuT/5952Lb/LDJX+O5GqHA09jLx4Yeh4GnNzpzn+EUHVI/Q9dutxm064B?=
 =?us-ascii?Q?AG8zVEm/WIwGeo01Owou6mk6yT6huLTf45zOIn4TQsjn3lzPoy6IOXmbAKLN?=
 =?us-ascii?Q?ZssjU3SG3/5eSFjWg2bcWuhc2xs0D2sVtCLxFpQDk0L1LayXh6J4Dt8noyx7?=
 =?us-ascii?Q?ABqNsILlNXeMCa0NY3jqZPwiv32W2Xgn+p2xcL48qMzzAaVFA0MvFKLB0Kns?=
 =?us-ascii?Q?yFeLIxuDIky23UfDTx9OJWXNCP4paqpOCg/4B+IQYn4HfHJa6w7yNPdrT8E1?=
 =?us-ascii?Q?5Oj3qQt5blRQz1+cJBC7YWS/DBUCS3IjNTOHSePJTitfefjXmCuNpLd1GSuV?=
 =?us-ascii?Q?yRgcGUWlzjCaqc/txQ18+5xUm7iQ58a7LOhJB/3SfWVteC8HelHFQNVEhMTA?=
 =?us-ascii?Q?sjy3hk5Wvh17Y+We4SwNc/eQSn/l9PbSrKw/go0GPy6Ha1Vhg8xoEfGvJZZr?=
 =?us-ascii?Q?T9lTkitQn93WxwYblQvvF8I/CHUe9G5fuqcvWgaAcZSyaEiCIfHB45BlGs/O?=
 =?us-ascii?Q?b3wI6nU+QeB4gTMJg7pMSOnG08f+6WaaFB9zlTcGBsc6GCgi7Hu1BY8SmtTB?=
 =?us-ascii?Q?bvir4I5EVGaZaSABn1yaiZsinLNLWBzdVZTNxM8uzLQcG6z4ybHYV8L87NLv?=
 =?us-ascii?Q?KcKJYDsMWdgEpUtKL5kQ3f0BirDws9bZsmwieb+ZAnbfSWVSiJkWdIK1aS1I?=
 =?us-ascii?Q?JZJZ3i0la5BhQZYBtzRGxNTOm8Q5zXKUXCDW7gGEAgerTOB13w=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Vi35ythePBVl504bWqEkcVWvVUEbLHGX9xQxUvvupD37d3JJusv7Rq03FasS?=
 =?us-ascii?Q?MqUTKTT3z4taKHxmjU7RHDPfGc6ZelNGfF4uOH8OEidHOJZ7/QvJvz18SQNy?=
 =?us-ascii?Q?nYU8jXw0xjSQCdDyacwF6Jtn1+7OvHqnvwN/0PRenVjEKjxBP/e04yaT1V7N?=
 =?us-ascii?Q?pNQSqTuP9rija9mvw0Fank4xsDGUFLLVy9Dtk4mINPf4+/HRKN5tES2UP+U/?=
 =?us-ascii?Q?Y8ISsVxgvi3peuvjy5dWliUqS9BjvfsxuKXbZCnu0u55wLw0B9OAO7KRyy/K?=
 =?us-ascii?Q?Qf2Sq2pRWAJEW2zUPt/HhaEsLlrQa+pcYC8Rj3gP867q/46C+eiRagEfup7f?=
 =?us-ascii?Q?ot7+F+oS3cMrNO0XVn8WMRIkWnf0r92eK5O7Gi9U4FzTnhHIp8Mya0LjRP0c?=
 =?us-ascii?Q?BfL+sCmvOqd1aPTAjWPvR6SdaIo2sMxu5ZoMlEl9Bsj8FP8F2hJxAZ0FZ0IV?=
 =?us-ascii?Q?Tes+2OxXWzRR1fgf4KUEsdOvNI+EVthNaUv8xvKqFjNxaYS5TBCicDGRaYXY?=
 =?us-ascii?Q?Yh9X2F4et2x6afRRO3Z5pOTIPji6wwUimyqzUwMZcPMg+kiOSCb/fy45FJOm?=
 =?us-ascii?Q?rPe7774mkenn4uMEAI37hX2rF5zWTZ0E5FrMBYPrPzRJ+ZHLgtemFaAyyxEK?=
 =?us-ascii?Q?UKOZoGybZBpoC9bE2/iT4ZVPyhPtxUpEkvz4FEoVG5Pn2VLa29w3+f6HzNWP?=
 =?us-ascii?Q?uRZQ0ri+1CM29Qzji6mYntoo//Ozfz1BxCevpmmfSynTgjmVbxUSdPY2ANjW?=
 =?us-ascii?Q?iZGvtAMSrCU5nz6RvGC/HqgeyJINQ8DYBe8bjPM9o9kkpsn33b4nbO94DK6k?=
 =?us-ascii?Q?dQO8OS7LCdnafIZragGClkIQMFi3hrRnjUkpKXQVUmfTCYSSgDiMuqq07cgm?=
 =?us-ascii?Q?4wjGvnFbGHMaBM4EyqoTxE4GaPvhmumx5Fkhfn5GgAOOAxaAabjw+F20uR/I?=
 =?us-ascii?Q?KBKr+mC/m3ZZs5hEnv4sZdIMlaZlnbLIPrEz6VgRZqFN3iFWRSgS1pxsBcp0?=
 =?us-ascii?Q?k8uPodKkH3w7JYbf+gaU4cmwqpRgldI6naYh/5DRzoFCF0B5YJzTiiprmtny?=
 =?us-ascii?Q?qndUbU8H8RFKO5Wp/mRNHXqq7mQt3g5ByxuJvUMxUXWuR7er4HcRTSsA65XG?=
 =?us-ascii?Q?hCku7T2co7EVi3wZs4+y0J8rhtdMXkCps+5gYkfiCsigz119daC5ERcnQ8pj?=
 =?us-ascii?Q?jSwPpiVDwf4b6ilUdIpnKQ5H7NXNVgAsomM9xmgMTGrLHfdv0Y42hQbvpFBC?=
 =?us-ascii?Q?X+2xnk6pp7pZfj4x7LwH4fYkw6MTjK4Mljsq46HKZDXTWO98tL9fwXrRnQeQ?=
 =?us-ascii?Q?8Ib9sqVFoU6DtyzHJ7c1GrLXMx+XT3BBjMqu5uvHbmM+9M89jXG5wW+hvNTc?=
 =?us-ascii?Q?7wA6l7X0RQaGWRDE0CbYlOatduxcydIjoMwSH0cC1cxLMklHYNt2DNjWAOgh?=
 =?us-ascii?Q?V5Pugca3gH+AF0uZnPK3N5/XXQ/k2GaTsC5MEX9QgzND/mCI5XFOuLGW6dSs?=
 =?us-ascii?Q?z6y1WQEWYAm6LrM8CiIH2P7NJUjpsuafJ4f4LAzrsb5IJbxRJhx5ZR90IgFw?=
 =?us-ascii?Q?eRpA0JxXyL+LDTXA4zxTLmzCREaHI3VWfqqQjrdkVTz18StY7UlsY+lixkhL?=
 =?us-ascii?Q?lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6fc333-b238-4700-a708-08dca65394a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 11:28:28.5619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ssph1lb+wdFLOLwi13bf4sYh2bMLraPJfYW2ycG+f3SOkiLqGAx0d98lmgaQZGKl30zWcrFkqK25zF70ZQYGuKwvCPRgqZ2y6GbUT1ZIN6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8789
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jul 2024 11:28:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16566

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, July 17, 2024 12:10 PM
> Subject: Re: [PATCH 5.10.y-cip 23/31] dt-bindings: watchdog: da9062-wdt: =
convert txt to yaml
>=20
> Hi!
>=20
> Its really nit-picking, but git complains about trailing space here:

Ok it is still present in next. I will fix it in mainline and then backport=
.

Cheers,
Biju

>=20
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.ya=
ml
> > +      Only use this option if you can't use the watchdog automatic sus=
pend
> > +      function during a suspend (see register CONTROL_B).
> > +
> > +  dlg,wdt-sd:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

