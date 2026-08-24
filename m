Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D46CC5DF81
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 22:34:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9591.1787610848091334515
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2026 15:34:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=QyFpHrVC;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1787610845;x=1788820445;bh=UNy3xy90cvTzUYAR6UonUnQQw70qk9oUmWCc1
	4py2U4=;b=QyFpHrVCaW6Z9iDqhAw5twEHh+s6Mu05NNooc9/8J19hx5MjJoRVcGSQMsXm/mPyhWB
	1D+atQdg4MWGfVFi8M/8q492CqLHH5NIHOXF8aEGXEKZW9zybd/Bo8u1qy7uPgPJOJw/XqkvifkJO
	oStVAtq9Ms/0lpLsWZL8dx3xRTu/aDkuyKlpmbXt4WDJEbqCL1pQrwjATi8d1D9BxPuwxTnnV+Jqf
	QtvuZ7zAeINEtYIQf+IGpZdtY3QMcTE3XGM8qzL+pbf4rJT/Tcl5bz/I7A4+H8nUZWnVWFygTlaQb
	a3/9XDNjvsIr4n1Cv3KUtGCGo49rehTBT2QiO5ZdbsRg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 67OMY4tB1986855; Tue, 25 Aug 2026 07:34:04 +0900
X-Iguazu-Qid: 2yAbeCtgwwk7Y9RYHY
X-Iguazu-QSIG: v=2; s=1; t=1787610844; q=2yAbeCtgwwk7Y9RYHY; m=Js4vGthzOWHxKlskPLCTkVlzp2cq6ZAkT1eB5+Q6X6o=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hTQgc1xDRz1xnh; Tue, 25 Aug 2026 07:34:04 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nghm8rUMQGK1ku9/eudac9XRIK/8sQlj/WopKvy/b0jdE4zL0lzF2oxuofErrGR7jFIK9PP/u9Mh+YMISehQQvtkMUUYNrkdtBz+8mTcEWfiejRBRLcXLmsHMlgzltAN7RV3NYn//Fg1c2zEBMrg7RkfIZjk0X6tLY3N8I+sATluHBd5//enXXgWN7OgwB9j7uKG54TMmLp6+hYkzhWxzWn3uanwsMPQsTAzxOrFCu/xt/FDP8ADX2UST2uNG5A5oYS7LM4HB4Rpzqyouc9tqgwY5bpVEYfS/n9YoAunDMjD3T3hog+u/GYVUEA8cIBi1/1Qz1+nbxUWX8ALeovBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EddSEX6GCKNpQHlL1m0ZYhbdamxjqrkQclytlak34dE=;
 b=J8wJyooZyYx+5qV/khs49bHvGa3ksC9hQwV8iBqs228lovUmp4tgZIXmFLWP/QZj4Gv4yEUmpiO4yE8kj1MKIDsXvG8UXP86FrmMDJvy+ufq69Yw6niq5la9PNDfjqyda66wPTJzQX8L70GfhqRvqC6L9uPTWJTdPpXTUFGyijM7ZyLiBUuvAkXlwiYIIvn1Lmw9XnITg5doqJpoXAJpqYtI3R7kBn7iSGNAkt+3sy2WCXXRNhsVDiFptVZ34aWJoUUlEjsFYqm288dQm5j8EII9yEYyPae+HtI5A1QtWUu1F/4hptYqE/jiGKBIikqywYxGKw4yD14A6gluWAXuMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <cosmin-gabriel.tanislav.xa@renesas.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/18] Add ICU support for RZ/T2H and
 RZ/N2H SoCs
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 00/18] Add ICU support for RZ/T2H
 and RZ/N2H SoCs
Thread-Index: AQHdMW9bo/4wiqdVmkKQtP/RxxP0pbapuMWAgAK13SCAAIO6gIAA29ZA
Date: Mon, 24 Aug 2026 22:34:01 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818A7039C37C7449AF72E92CDA02@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <aolZq2gonRLG4U4k@duo.ucw.cz>
 <TY7PR01MB148186ABF5271325B7E7E7AD9CDA02@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aowOOePmsSk1I0ph@duo.ucw.cz>
In-Reply-To: <aowOOePmsSk1I0ph@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB11792:EE_
x-ms-office365-filtering-correlation-id: 3728855f-8cef-4480-a138-08df022fcba6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|6133799003|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 pDEqx1RwC7OfMF+bvy3JX4loCW6xHYtOY7RpXpybx3dtnH2KqCM8x3fOZIEbuXSTEWP9oVtRKHNCIMCEsyZEF96Wxfc/w/Oc1LjysyVEEROKgBgRdszP+9qW/kJj0tCnffhecUPz6Wn07dVoG6w5mvwiQm238xjiRIVihdG+MRwxz3bHxysecSWPGs+r+Rqg9PQrVMoRSYAK7bTG+99HQZiyItCu7kECFpEjeNDV7M1CXon4OIqskBQOBB+YP5lPoUb5s/WvMADHLtTdPmS9zeRa9eNyvvvhTM+o/a9T4TfX5h8W0IdQjYROh/rGn6MmK+dG5eM4/AEujLQPDNqapvGazf4CaXcatp9ZXLPpoqf3ECzosZJK5gxd6FDgLtAMGt80kXpB4Ub+um6DGg9/+x3fcTR2taJ5s21VgwrydUtS3qXPGBSAic5+EaO01L1Wth4K3wUO7T6ZJ3a8o+YEBvq+acz6eN5RkZXAets3UkmIH8B5wywuVTJm3paCwU8cIIGLPzNclww2oUoF1IrA7wtIK4WmT3Osso5F+ygWZwfOtH8gHMXdvixXszcu78pkzuY6Xz4KniijOWZw0XxFzI7Be2Py4uOUI00KJOEBgOAIBjcKAcT3WxR52Y2MRTAS7ei4AK1oWvlGn5cTQ3PPWg2NQElOm5x0gI8CBxb4EoC3vH2igbdD2BnN/vSypx4rC+hFDXAfvE50aGbzOZWPnA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?M1BONnRTbVEzUUJmZ0E2QzgrUXlEc0ozUWNFUGIrT1NKMzNMY0lLTW8r?=
 =?iso-2022-jp?B?Y3JwWk1tTXh4NGNiUWg2NGtaczAyais2a2JudDJnZ0gxUzBSL2xaLzlX?=
 =?iso-2022-jp?B?RTZWa1FPRFVWb0ptSFh2QWRnSjQ4a0JxRnBzTmRqeE1MaldhNDhFODVQ?=
 =?iso-2022-jp?B?d21HQ1N4OVFBVC85QUR5b3lhOU44aUxRcFFGWm5MT2UrK0lleDU2UUFF?=
 =?iso-2022-jp?B?Um95M3Y1dWhDMHhOdzkrTkZYTFZWK0tyZnBKejF3THk1azJrYmd2Y0hl?=
 =?iso-2022-jp?B?R0JCaFNQQzV6dUxndUQ1K0JXSXBGYVE3Z09taFB5QStRR3FpRW05MENO?=
 =?iso-2022-jp?B?L1RBaDZYdmE0emk2czhhYVFwVG1raGZCMldBejdMMG9CWGJaenpJVVkv?=
 =?iso-2022-jp?B?MjFLT0pmMW1IQm1LS0hLbmRxYjl0aWVvYkJoRDVDcVdNU2dBU0p5aXpV?=
 =?iso-2022-jp?B?a2wvNVAveWJuei9Fcy9BWHZ2MXZ1SVpnWUIwd0JjTjZjaHV5aFlvaVRh?=
 =?iso-2022-jp?B?VWNZUkZ5aXlzRDdnOUE4RWM0R3d1MUhSZDBuMXc0a0wzV2R1WDF5bWxT?=
 =?iso-2022-jp?B?WVp3R1M4YytWWFlTcFNIWXpPaURMZDJnTCsycFVEYWgremdITEZVZ3hR?=
 =?iso-2022-jp?B?RFdoVEw4Um5sL2c5Q2lQajh4OE44MkdlTWFuS1RxZnZpVFNWZlRkZFlV?=
 =?iso-2022-jp?B?U0ZBTk56QXB0VnJYbEdpQnVxNHRkeWJWeWZibmFEUkhEOXNiMXhsSjhM?=
 =?iso-2022-jp?B?OFROYy90dy9VNTJMVG5ycXBkZHhFaXpuNElyTmlidUpwQ0xIQ09SS215?=
 =?iso-2022-jp?B?SDFxdHN2eHAyUlB6U2oyS0E2MUFNL2g5cjJzbXdvTllPY21zSXlMUGxK?=
 =?iso-2022-jp?B?Q0swQ1NtM3lHTXpRaVFvTFFZMWdjWVVjOVZtbkdSYU0wM2F3OHlsY2dm?=
 =?iso-2022-jp?B?aFFLQlh3ZWhIWWd4Yi9uTG1rRDl6TEkrSDdhSnpKUW5DV2w0RmJmNFE5?=
 =?iso-2022-jp?B?ZE5RY2N0bjc2OTFYZytJdGhnVEZOZnBOZ2V2enpOMEpOSHVLYjhlMzkr?=
 =?iso-2022-jp?B?UEdwQ2t0RGh1YmdxbUpJN041M2xFbkIwSU9xbkZJTEtiZzJRNkx5S0oz?=
 =?iso-2022-jp?B?NGRpR2RUTlB5Mm1VWXlNZGVNUko2RUd2Q1VWYnQ4WHhxelVlZ2dQM3Fw?=
 =?iso-2022-jp?B?dzlhcGRmMU8wU2szUmluT3ZyYldrNktMcEI1bzFrYVVXdlRaTFJKZ0h4?=
 =?iso-2022-jp?B?UW85ZmRNY3A4N0RvNVVHdVM3Y3Zkc3NkdDBBdFI0OE02NEg3K3c2ZnNi?=
 =?iso-2022-jp?B?NElmUmE0dHpIV3RXK0l4Mk16WFVxQVNjVDllWjhyL0MvazJITVA4VUwr?=
 =?iso-2022-jp?B?MGdRY0ZVbTVxRnRQMWxaL1d4REdUVGJDSVB0Rk0xcmpXVTZ0YitkK3du?=
 =?iso-2022-jp?B?VEsrYmI1MlluMC9oRUFXUWVLNVI2cndkd0MzNW9GQkV4cDZLcHNVRy93?=
 =?iso-2022-jp?B?RTZlUXN4QUxzRitjN0NuR0R2L1ZiejhpVVNXL2RzUXNSZG84ckxLaVpC?=
 =?iso-2022-jp?B?ZTZRcWRtRmtxR0YzR29VNmZJcGgvb3I1bE1XWEdzbUZGYnB5ektjd2o4?=
 =?iso-2022-jp?B?c0FEZWdZaWZhYXF5aTRtOFA1d0V4dkt2RjFqejFEL0ZmWXJFZmZqYlZk?=
 =?iso-2022-jp?B?QzN4c3U1cTUxNGhCWWV3aFpUL3lEM0dyZ21PeGNNbkdYOEREWVQ0RERS?=
 =?iso-2022-jp?B?dU5hTzBUUWdTWlNGcTg0Y1dkUEdvSHBHL3hYWFR4TEt6clg3amZabDE3?=
 =?iso-2022-jp?B?ZFJBeVJZVDZLajB0YnlzNFF6ZG1MMGw5bnl3YkRIRThzYnlVdDU2c05J?=
 =?iso-2022-jp?B?bkFJeEFBSDA2TmdZR3E0T1NSaGhWWFdqTGRUeTVibmhyNEdSWFE0dU42?=
 =?iso-2022-jp?B?VzVmcFJrMzZvdnRTMFZFdENQd1VyWGJyWk1WMWoyVGdLblNBYm5uZjZW?=
 =?iso-2022-jp?B?VjlHR0ZXNHU3akM5RUROQzgxK2JHc2U3TTdHL0o0bks5NE9qV05aVUhH?=
 =?iso-2022-jp?B?aElUYmpTSTZlYWVhS0NsYVlYOHhCU2ZFUjhWOTZJdzhlWmxOWEt6WDNw?=
 =?iso-2022-jp?B?aDNsQ3QxRXFvV3JvVmtBTFpGbE5CcTBRRnkyeUY4dGhlU2RiUk1iY2Uz?=
 =?iso-2022-jp?B?QUl3aUx5VG1UM3VGQk11bllOU01acEljczJTZUtlMDJYcmx4SVNxM3o3?=
 =?iso-2022-jp?B?d1EveXM3cnAwaU1aNFR0L2NyUUJNcDVZUlVoTi9qSmtKL0lONW9YVGZr?=
 =?iso-2022-jp?B?TW5BVnJ0aFc5Znk0MEZXcC9WYkQ1c21JakhlL2t4VXo1OVdpekNJR2Ez?=
 =?iso-2022-jp?B?MjQxQ1J1cGs2dEwwYlQzRURqRUhOVWkzOUY0cFlJMVBTRi9wWEhTbmFX?=
 =?iso-2022-jp?B?VUFTc0xuWWFzcU13c0NIYUxwOVVDRzdFWTBWR1M1bWc4QVNwb2lvZlZ1?=
 =?iso-2022-jp?B?T2JsSURXclNqK2xQSFU0cEVGdFhFY2JFWW5ERFJLNHNNSjhMUGNYWWNh?=
 =?iso-2022-jp?B?cjg5VTNPUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	qjqNrDsiKdxjVUDo+34wlcMYFNST2MEnLp/zjmHKUn3lsjVSeZ2hWTf8K4VN9DI3gp3CXfm12aqb2u25PFPLMTc1xTklDAzNPQduzLZXr2imET+2Z2dZsAm9kronUR4zjB6gh19drww0uXBbazaBujQAbqfxn71e0on7tUatMLPHg3IT4O3U7+4vngKIwhMZ3+qKbcitqpypqjq8bQKTgRpupvENGwScxf4CMG3GvDhsepskzVAjQSz4OOONbdHC6BCbLy7dg6GAzNCrIDYIMfMN32K+vQoaVvdh9g/bHjVAy4g8N0Nvg5J6jJ0E/H8Kl6KHpsTejTeBUeMQae2MeQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3728855f-8cef-4480-a138-08df022fcba6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 22:34:01.2794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2W4ru6lgmqomYpOK24AKwgzx7OnDhD9GcTQmmoaQA8QvyKxyVOVBtuzED9pZK46I0bEa4x1vUjV8EnqR+5uTmOzit9MA0JR9zp2JAWabaCbn+NK06djkVfQHgPW3O4E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11792
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Aug 2026 22:34:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23996

Hi Pavel,

> > > > This patch series adds support for the ICU block, including
> > > > software-triggered interrupts and error interrupts, as found in
> > > > the Renesas RZ/T2H and RZ/N2H SoCs.
> > >
> > > This looks okay to me.
> > >
> > > Reviewed-by: Pavel Machek <pavel@nabladev.com>
> > >
> > > I can apply the series if it passes testing and there are no other co=
mments.
> >
> > I also reviewed this series, look good to me too.
> > I applied with Pavel's reviewed-by tag.
>=20
> Sorry, we were working on the same thing at the same time.

No problem. Thanks for your work!

>=20
> It passed my testing, and I pushed the resulting tree before checking the
> emails.
>=20

Great!

Best regards,
  Nobuhiro


