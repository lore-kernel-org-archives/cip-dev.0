Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D48AC7EE31
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 09:17:20 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.95])
 by mx.groups.io with SMTP id smtpd.web11.4511.1686043036603675333
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 02:17:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Bt6Xur+0;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.95, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apaxx7vmLaDHVU8ZZK6icX0NR4M2OJEz3qfs1KITddyRSRe7Rx5wBj1j0W1cALVzhOyFbEh0ulhsQkMzpmOcmkqsfPUWneRevENGb5FwXmbnay1sCmCVu+OX7Ma5XrTrrY4//SA777iOkLPMNFAyjD45WhA1ggDMiXEhoVfZOdNxilZyrhmxOfpsEYTUPnwn7jA5I07QS2TnjtL3gD/4qRMk4KTr64MJFQ2XawOt0iDQEUetI+gB/wj/mQl2nvOTRT/s0ZxfGuCWewJHLAQ/em1r3r1xxfDmp+192tcEVxUx93h9mhZAALJrR8yYI0eUDCjWFfUgD7On6FGk0cpFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0jL1+LwGPdOWjR06CIsS85PpuW/vEAQq3AZhh1xPzo=;
 b=kQx4yxFITwy50DZSdLV4LEP7wptD30YubXhOJDQjqZvlmOIfQvYRxUV6gswthh9LMGL9QiK11PF47wO2+RsODGwGZT9Zq+sArXEEs5DoB3gv+qrFp9L8cIr2P5cldfQJrah18ps/EVdO7d0SbIPD2wHvdrwePE2cnrEwzXAbQYNTlMQesIqn5NfLCjiby/xKQ9wg8Gg83s5cC8P3jbX/1CqjWfdXazUpX+/Py0Y5JmmWDzmCWKifcpfSyti86TvOEd/5xZiefdpy33xPxPE7SBYm/wN31UI/mVyPEZbKpLIpFn/ZgvVy+BFs4ebqc893qDiDTSyWsp/erVolmhdBFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0jL1+LwGPdOWjR06CIsS85PpuW/vEAQq3AZhh1xPzo=;
 b=Bt6Xur+0GZPzMl6lc44lDxwnqqKg4mzEp8LQjmrSJ57yE0EduWRD3Iai+YL0sloWORLoA3mGzVsFK9GKPoXj8Zm/hHGGA8F2uYNkwEAL1EVBj6BCwG0GndFQgygsWck6UABmZgY7p/bJQywRCNjEGenzq8+6I+yS+Rf3aMntlKQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8814.jpnprd01.prod.outlook.com (2603:1096:604:15d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 09:17:12 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:17:12 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/8] Add MTU3 core/counter driver support for
 RZ/G2L alike SoCs
Thread-Topic: [PATCH 6.1.y-cip 0/8] Add MTU3 core/counter driver support for
 RZ/G2L alike SoCs
Thread-Index: AQHZmEveAqDJseRZIkWtuC2wZy0K1q99fmaAgAAAQXA=
Date: Tue, 6 Jun 2023 09:17:12 +0000
Message-ID: 
 <OS0PR01MB592226547765F3A740314D2D8652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
 <ZH75S2f7nR3fHCDP@duo.ucw.cz>
In-Reply-To: <ZH75S2f7nR3fHCDP@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8814:EE_
x-ms-office365-filtering-correlation-id: c7974d08-b101-49b8-c9b1-08db666ecfe4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 b2ZZAtg0NL+BGkp73V3b13Yn+qPdWpy7D5fokA932etalAqkw8hZN8xP4I0BC/BbuifR0UHDaePg7dgr1+mMTcNvKKrCliOBIiBMkE8FdYTyt91uokIesb3ffb098t6HEBQt8eUhNXTdh36Zug46M4L6aOSAdhFyQavaJeLX4/5+X+j31gksTLIF9qqzNbQlSdthiN4AoLausQFYDvMyWrwMFu5mwuJvUKu8TRnZMRDCq8JsYYnPqToUGo2nyrPMXfadgsO80cA6IJM0cCiVJtwEK1+QpzMAAJJgsKAbhDgUeJ87gqRFGdT1k00KfnbLwOVyUKlGZUAIIZ4irN4v9hMQ52VP7IsyZ/K4X97Y7HDGZOEMQ2ujUrx7fP6Nrg1uOYCdFudWS9Hpi0d6Kkh0xAAQfBwlx3upu+Cs+OTy4iSHiJwrMFYR6sDcbox21/NgxC+IlvQjiN6CFvUJf6EtazVI2z5Y+vp+5Hnjg31aZ9mVmr3WV+Im7Ym58PoTW7lNxAfm17H2ZssGcMvWavbtdHV5S38yevsf/ELBgUvCMhNAqeyXf7EA1p3CKd7Fb4ijiyJcK4VgLt5tL19E4XE6RGyETr9mxIfbr3bMOyVqu/0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(107886003)(6506007)(9686003)(186003)(26005)(966005)(4744005)(54906003)(7696005)(2906002)(71200400001)(8676002)(8936002)(33656002)(478600001)(55016003)(66446008)(122000001)(5660300002)(6916009)(38070700005)(86362001)(52536014)(38100700002)(4326008)(66476007)(41300700001)(316002)(66556008)(76116006)(66946007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?tsXuxFKIMnNVE4sItp6Er3V8L6PX59OtFQejHSbngRDXSnZUjRrLtXyVRK7O?=
 =?us-ascii?Q?UEnrhnPlwnkTwT2D9l9CSJs6WVelRSqdYZZPKyURd5d9wgXHeO0ziRqYfk0v?=
 =?us-ascii?Q?7TPGA4wESxi4NVPYD8Akh9b7DM8SovbBSqlAf3IdJwHuWDT1mEi4rOrbkL4R?=
 =?us-ascii?Q?VtRHpIGv60JIB0ZDpSawNWQHU+dhskWrP6e8t23geDOp4vLQBi2VzeWUa4+B?=
 =?us-ascii?Q?LXzKGBM7ryPDY7G+5MJ7k+cpOlSqHv0PLBtXZ5InNggSavKd0s1bHORO+j6o?=
 =?us-ascii?Q?uk0VPHgoBt5hA5jFE7BIA2FErRzOrK2/noGiq6+higN+gjvuM6ru/ADFEtKH?=
 =?us-ascii?Q?gILhzpvYUBaLHTJGTZCK8yRE+BOaHtjoa/0fI5nijjsvmtLJl2DTKCEVfsNP?=
 =?us-ascii?Q?D80mwQa91bVi39EDHVZFGAVSwoSDFupiZiRLFIbZRMgR/WD6lEr/5bCda1R7?=
 =?us-ascii?Q?vz+XjAbZebXQ0eOL+Wq7oQ2zS5Fv62fN2LAIOrt+6JpWQ/vnQtmLRS2tliY2?=
 =?us-ascii?Q?3EYcI3enqB+RMTFj1w/l1eFzqHUaef/lJmtbFbjmGkUJPBzAOLnQ7fFJ2NBK?=
 =?us-ascii?Q?poOg0twHKkI5tPKQneZiMa1fI+q9tcRFHKZ85DvGRQoTt22YpFeAlEEcQqsi?=
 =?us-ascii?Q?u6h1QN7h5nlfGk/vtwdxvy6/iGmx5MlQ8OyRZof9LiYcYAafnaVOZ98DDOFu?=
 =?us-ascii?Q?bcFmzxbGkhRtmdkbux2VrgL+QlYt69MS23QilTKjv//QbalXcZ5aPjrW4HSU?=
 =?us-ascii?Q?kDyMkObhIcTtyncXGL5k5pG3NoLy94IrCT3EN4Ya2nZxUHH5iOCw8cKTGYNP?=
 =?us-ascii?Q?1ieW1sLNSThnuF1c1rg3d1c4stgrw+ee2mX4YqVKmUiCEqNnUbCmRPrZzOj9?=
 =?us-ascii?Q?APHygymgz8YBR2AdWJPZ+6zEi4f3e+0iqSrsubVO2GctrnhEmhDPjUoy/kou?=
 =?us-ascii?Q?BzCebKLrw0MEd81lCSAE6OKudoKYgX2LyVeWcJFtBUhU/7VG+35U7Dk+yUj5?=
 =?us-ascii?Q?DIYZA5z8+RObNEZ+oOh0jytW4XmAVzeIb26t4saiqfdiQftCdNF68ePDC12B?=
 =?us-ascii?Q?IWVHoYHVQewAc8WHlSZMsfIk6m9Oy+2EodZPL6p5671Q3EIXRLKo4gJktFW9?=
 =?us-ascii?Q?j0QIlKw4CCv3FGzoRACy2YRUREnebzFC1AhsaevWjE/a6yX5qE878AVVjAhI?=
 =?us-ascii?Q?62jtK8tC1nNzW6E9QUukYwqCs5sBMLWJ473C8EXmu5twAzzSOgvBErrNW+Kb?=
 =?us-ascii?Q?9oxZJ9lV5Rjczq6P0Uu/tjpkmdEmas0cl8Bu/s3duJfEncH1+2ZI78FAD/F5?=
 =?us-ascii?Q?Y+XuZocHjHjkQaFzFmxbM6/0aqhm7o6d7ntFbZIp13HDyy9QlhMAyVyXYjH0?=
 =?us-ascii?Q?Iw7WBLKEx1Ob457/5xFyzl0GDMALpk/E6yCSDkWIWBzYRWo0VsprvRjYdC6O?=
 =?us-ascii?Q?5kJxhWhYNiwBWVqSBO9cDKk2KGmK5ZEye7JuG0oYexPICS6LfdKRHh9/Ae77?=
 =?us-ascii?Q?htr6dYSo8WcDzft81Ok+pWPWu0yVMh+YM7vEU8T+01/MDSZAYstNAvc6w9QG?=
 =?us-ascii?Q?4soWYo7LxyO6T8sKo2ZtsXFcYio5+09Us4WfiT1qNZjn4YDvFxYP1Pufs6MT?=
 =?us-ascii?Q?zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7974d08-b101-49b8-c9b1-08db666ecfe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 09:17:12.3030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zd4IpeSA8HvHUi1f1+DYMS2McH0C1EmH8uI2czhOC0CRCS8Dgf4RY1HixEN6qYASpnOMEQSd2AkiVISM8CeUhEOKWnmKeOC9PTC5FHHfwt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8814
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 09:17:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11853

Hi Pavel,

> Subject: Re: [PATCH 6.1.y-cip 0/8] Add MTU3 core/counter driver support
> for RZ/G2L alike SoCs
>=20
> Hi!
>=20
> > This patch series aims to add MTU3 core/counter driver support for
> > RZ/G2L alike SoCs.
> >
> > All these patches are cherry-picked from the mainline.
> >
> > It is tested with Rotary encoder[1]
> > [1]
> > https://www.mouser.co.uk/ProductDetail/Alps-Alpine/EC11E15244B2?qs=3Dm0=
B
> > A540hBPfDpUEkDmFV5A%3D%3D
>=20
> I'll review this, but lets delay merging this after 6.1-cip1 is
> released.

It is ok.

Cheers,
Biju

