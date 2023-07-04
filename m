Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879D6EB64D9
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 04:50:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.51829.1688446252000265079
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jul 2023 21:50:52 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 3644oipB2254456; Tue, 4 Jul 2023 13:50:44 +0900
X-Iguazu-Qid: 2rWhc6jYw6Dcd27ORJ
X-Iguazu-QSIG: v=2; s=0; t=1688446243; q=2rWhc6jYw6Dcd27ORJ; m=LTb+dhKWQ8MKVrL9lYmZFTUILmjmNEKk6lrs6clUdRc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 3644ofuJ3123673
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 4 Jul 2023 13:50:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEp0e5DPFmG/IrXD9V7oVUOG9aSkNQMVElHOd8dbpfSqOjWHuDE98THdwCBwJzWpKyb6U8anqdNtVfL7iMEY7Au793ciVUg0XxDvXTGvBsZQqvGBBC7S82CV6laWRYU067vbAgrWjc2CIroqgvUX+XUfttH/5WGD8U4brJ+ee0EuJBLtE48NsS6vWtJ63HiwEHEkkzbYC6h1yVw5yyeF+5zn42YnWFWJi8wEKPcdi78FSQVT74CdiTxgFUyJD+ko0WwRjQ5qifNoi3lUMg1bAcGhSD88btjbrfTFn2b/I6NiYbB3vh9oF71jVg+ONE3tT9Ze3xWzFAXIT9UGQ6oNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6NHuU/WP5D9D3oKs78FPL258Y84lAa3vMqFBhzYmzU=;
 b=jzPHVFhlWcvf9uN3Ei7Cr5W9rIw3CjWGzrVXnfn/5EtTsHL0BahFkEAGXhTQGbjE3ZMM9zuCBcCd0LzRrgTjbWOkGT/MFhyG2D1T7+mHqfFx503ChMQPFTDeMTfNtdafcAcYjFEEIlr/zSJp3/gWqJ5fwwmJ8CCgng//sgeE8BXJxfhaQ801kmXDb39T/6bgct4p92bOC6kJifbK5spEngY+eh5dtmjWEZv+SZiYPiF/AvL8LZOjkwAerms+3YF3pEMisERuiQxZHgL8F4jQd787b7sIIQlc96NtPB2JByrsvT0bgaSIl0BoNyCLndzdVmdYU6y6ehsoPVyNprGk/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <fabrizio.castro.jz@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: RE: [PATCH 5.10.y-cip 0/4] Add Renesas RZ/V2M PWC support
Thread-Topic: [PATCH 5.10.y-cip 0/4] Add Renesas RZ/V2M PWC support
Thread-Index: AQHZrdAhVJYA8yGF4k6g2pbxA2VRKa+pChTA
Date: Tue, 4 Jul 2023 04:50:39 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942048E61B05194B12FFD4CE922EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230703170211.15484-1-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230703170211.15484-1-fabrizio.castro.jz@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OSYPR01MB5461:EE_
x-ms-office365-filtering-correlation-id: 32607dcc-a5fc-446b-72ef-08db7c4a36f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lv8XRPPo9ZCGcLXkJ3FYD94gi1UsOIuT+B4B9MfKnxMQdl0ef3q88M58vWMNdm5npfeJiv+m9KkmlMrTj+UGHrge6/HTA+YaOQhquXLQwQ57d2ChWz+Q1qeucEnOJxBj38Vf7a6QcPjYGvj2czC9BUK56ybE2zjMxn669Uz779StsV8F2iM/x2iPDdGpglvmuFyIr294Fg9+oArZqlujmCsE0KcXiEBy/ozUwJ6a00qU1KgKGxo0EbkOWJL0rKQJDnu41EisjEeYRcGGJmDZnsxsPxBtx41ndSwzbFV+koRTG1g4xyCOVvSteWzMyTNTItY+1+vjihhcozmiRYVJzjqD8UzphQdjw4XQ8e9bZiod01gktJPth+8EVuLHofy6G0QSSu4cn+wCa9HZdcmCfoIxraKMn7W3rNctO4QAwupNhvn3iLiFFo+MwCbcrfB3M32hEmL2c9XcXUQqYO9cgHKC/7SPlXntUH2n827jLWXmUq9A3oDiNj+gmfTpjGbbPN8XDZVkgQO25pwe6L8n18ZJB6vJIW9Jg8bKI8JszvMjKlObVNx1JoLUo/7Lfk4qT9lVvKGGVj3Kd8VzYjsME6CfzO6ygFygRjBxIS1uRXolsk9AeXBQb4qlqEEBSO7p
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(4744005)(38070700005)(2906002)(41300700001)(52536014)(5660300002)(8676002)(8936002)(33656002)(55016003)(86362001)(186003)(478600001)(26005)(966005)(6506007)(9686003)(71200400001)(7696005)(53546011)(122000001)(76116006)(316002)(64756008)(66446008)(66556008)(66946007)(38100700002)(66476007)(110136005)(83380400001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NWRWd1lCKzFGVy92TlcxZ054VFVwUXl5WlFUa05MNENSNUg2cFJNeFQz?=
 =?iso-2022-jp?B?dVQ1R1p4cXl0aWMwZTBhWFZLOTM5NDdXaU4xUUpyL1F5b0lCbjZKNmY0?=
 =?iso-2022-jp?B?aDNibWFhbFl1M3JkbEZLamJoSWRuMmlxTCtMdFRncHlaeURhUzNaSnNa?=
 =?iso-2022-jp?B?czVsQXZoVFpDcmFWeTN3ZkZHWkttbGpjUmlnUUZlT2tLWTc1WmFtODRh?=
 =?iso-2022-jp?B?Z245ODhqMGc2OUtEQnhRSWJrZG1UbWhPV1JnK3EzU09jam0xZjlXVG5O?=
 =?iso-2022-jp?B?cTU0N2NJMGExczFGZjFIcHRKaFZtKzBXZlFrZnVpbC9mWSt1TmZEOWZ4?=
 =?iso-2022-jp?B?SWlpT1BoVEJ6ckwrVWV5eXNNNWxTUmQrRUhBWDFoSVBQdGxUaXQ5Tmd3?=
 =?iso-2022-jp?B?czl1WkNxZ292N0FZaEVjcmNXV3N4cGh1OUZ5MFU0L2VFcmM4eng5UFN3?=
 =?iso-2022-jp?B?bmpEdXFLOThlRWxCcXhnYTBHRlAybmMzYS9SenYvbFBGZ0VIMEllcFda?=
 =?iso-2022-jp?B?SnRUbXFXTTA5VDdEK1BkR1NhY3lGQTFHWU1VMnczeVBGK2tFbk4wWjli?=
 =?iso-2022-jp?B?MTU0Z2psdHhuTEc5cS9tUFRkOUlkdjFseThPZkNQMU9BUXg3SnBzSnNX?=
 =?iso-2022-jp?B?c01tc00ya3ltdTdHRG9ocTNIcG1uOGFtQWF1dFdEcUkvZHJKM0pUQ2Rk?=
 =?iso-2022-jp?B?czQ3SjVqZDcvc3pyRDlna3hvcERlSlZxSTkyMTU3aHRNaWtRSkxEZWho?=
 =?iso-2022-jp?B?Y21xR1JQM2xyUXdBTDh0S1V6VnRPdXR2aEJuRENOUVRDVVY0Q2NWeEc3?=
 =?iso-2022-jp?B?cEFZUzNObG1xdDdpV0pkdEExRkN6b0pGczAvZ1VqTFlaSkljREE0eGJm?=
 =?iso-2022-jp?B?eWFuc3I4SDVqOE1wUExDbGg3cHNZdnVIQnpLSnVSaUw2US9aRlBzem9T?=
 =?iso-2022-jp?B?SWxMOGlzL1diSXZVb3JNRVEySjNNanRhNHpaaTFmRVVqMUxXa0NUSWZO?=
 =?iso-2022-jp?B?SkthRnRBK1RJQ29rRUM4Si9xL2l6RnJob0hRNHVXQ285bmFzUWtjMFVR?=
 =?iso-2022-jp?B?ZTZoZTdXK2JYbTdycExpQi8rSCtrS3g3dEpDc1p4Y3llY0hBYmNZSHRk?=
 =?iso-2022-jp?B?cFVpcWtCdGhEZk1QNzkxRUUyMVk1SnVSS3o3OTBGVGg2d3RRc1pDaWVJ?=
 =?iso-2022-jp?B?K1VEZEs4MW1Lc2I1bXNlSEFPVFRXWnJMSndERlcrWEdLV1V0L01DVFZM?=
 =?iso-2022-jp?B?N3dzMEFZOHJXcnNLbS9FeCt5SzNvc0tNdzZ5cEFHT29iVUlCK3NVT3VB?=
 =?iso-2022-jp?B?NXRhK1E5YUhhWlB5ZlQyVzRLaUVPb3JEdkhtcHNLb2NOOEpqVDdVT0Ur?=
 =?iso-2022-jp?B?TEM4VFNaeXNlNndndzBZb09idHdRbm10eEtaalVhMjg3TkFuNE8yREh1?=
 =?iso-2022-jp?B?aWNKUGt6d3BGTC81YkliQUFXd1drN29yNko0bUR3OUlmazA1Q1dVcWFB?=
 =?iso-2022-jp?B?U21xNVVjWUcvcGhLN0cyUmE2Ukwwd3g5MTg4eXF0TEJuM3JWMWVEQ0xX?=
 =?iso-2022-jp?B?b0VqS2FkWGZ6c3E1TVUrbzFLQVQwOHZIZi8vSXNKSnAvTGF0QjBIYy8y?=
 =?iso-2022-jp?B?eFR4T0s0amt4YkVkdVgwK3dRQUt3VmJENHZsV2VBelBNemdFc0w1UDhl?=
 =?iso-2022-jp?B?T2R5ckdsWEorUFMvN21WdnBGK1ZSR201Tzlwdk9zS3cwYUJ0NTRYS2ww?=
 =?iso-2022-jp?B?Tzg2dnZoeXFPRktvK0FVQVg2YTV1R3pkQmU1cVp5bTJlbFNKRHI5Yklw?=
 =?iso-2022-jp?B?ZitBZXFxT3FJblZody83dHNjcG9JNCsxN0F0U1N1dWR2UENvdmluOUxF?=
 =?iso-2022-jp?B?c0pjcjdId3pJUnZYd2ZZMW51WVpiN3NNMmJTRUlDZFFWdy9DSHkvNGVS?=
 =?iso-2022-jp?B?cGlTZXBDdENVNzB1cDZsNTJxaVdWUnc2MmlSQlNsQUJOa2dZSlB4MlB1?=
 =?iso-2022-jp?B?dFJRYjV6N0RVOEtWNVZkUzZYN0d2SWVHSVY4aFBwYU9uZFJldkhuYVN5?=
 =?iso-2022-jp?B?L0g2WGJKR3VDZlc3NVlTNGtsQ0ZxQ0dNY05Hb2Yxc0ovSHJNVzZickxp?=
 =?iso-2022-jp?B?cS9oOEJEQVlBTG5KYUFMQm9BSmNHa05PakVuclQwc01JaWxGaVdJNENN?=
 =?iso-2022-jp?B?cHUydkFBcXhlK3VaV2NuUDhiK3JQTHRwUzBWRUpuRmJzSEhiL0E5ZzZq?=
 =?iso-2022-jp?B?dDJqbnBLU0doN04zdWdzY20wVXVUT0J0VHpVTGZpc0VoQVM3TURIWml4?=
 =?iso-2022-jp?B?YjhMTi9JRHZzTnNnSGk1cFVxSlFlRGtIWGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	saxtP2CKI3LIdNvO1CuGG5w4OOn6rluz4XH5fqqqqUJTD2wEFSmWDFJsn1QY+uO/etmjM+ltpwqVvLgDfWGaBCu3eysgDxYQXGdqqUMzvZuMsiAvfdZHLkkFjbBhNUNnfRgs3lnuqfBjCwTs1B1XJrhQvLkrlVbYdV6U3nokBMWPra7MHi3rYgw0OBKGha+lQ1W5g/NshxaQ+GdMx1YGtxDn7nFZLTt1mq4aq6C9KnwkXNuk7mKmmz/RgScj5gjZCka/i5R72WhrZBbqp8tA3K7jBOKq7ljfJ3UYQitv4EzkLVYRYttozbQnb4uCBRzBGC/R7N0TXMotcYLLhW5zNuTeihZlIYXyJcaJ8ah99xhiza03zI45KgSOkYY6+2zFZt6RWVSZmkfKIkCQQPqmH/aivzvQksYuZH6LQ0u62402WWzFwedqZ6cuKgWrlAUpanzFjKhs2tvtHenZtMPbmysyXLs13jUBMPrdPpK2MlE4sQpdbF+dJPqwRY6SXuAE+siWKnZgv+WoAL2gg+Fx8uGLzOd00DqX6FLJ5IX/VUQQq5yy+XG3knWzn19fa9hbs7ukrQGKjga1ccntAFJJiMiaEIWG8bBdLjP8d0PkDeoKsR9J+RyFnGSprh6lRaNXzwcPVJ+HX8ANXPM3dS219+rR++ZIX11k1owzIDzxAk7A3KPJDWnhRQewkkVBsXcvuLgWH8KCKf3scGSaZuLyqLlWM1FPg1EKiRxjeG0OWR6GEjK4iXLftjBsp/SaiY57hZb34Vp2fhDHOweD1qgA0TJQHhcP6YsaIjGR+Z1FLX9A2mEWcteyDOup3OMtMSIEwbgjNz5nrS7xdiwt49T80wenoanKFNFAQqsPICTE1PQ=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32607dcc-a5fc-446b-72ef-08db7c4a36f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 04:50:39.4320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BkooRiobJobCCpt97N/dLz+Hj5A/09OhYqlQ6N4bAFmwTgryvn86670ywBM95h+On8D2Re18Wo8FABMKgmEZxjdRJ25R88QROuuoU9bWRdrDpVYJzReNZl0xlq+z9o4f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5461
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 04:50:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12200

Hi Fabrizio,

> -----Original Message-----
> From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Sent: Tuesday, July 4, 2023 2:02 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Subject: [PATCH 5.10.y-cip 0/4] Add Renesas RZ/V2M PWC support
>=20
> Dear All,
>=20
> this series adds support for the PWC IP found inside the Renesas RZ/V2M
> SoC.
>=20
> Thanks,
> Fab
>=20
> Fabrizio Castro (4):
>   dt-bindings: soc: renesas: Add RZ/V2M PWC
>   soc: renesas: Add PWC support for RZ/V2M
>   arm64: dts: renesas: r9a09g011: Add PWC support
>   arm64: dts: renesas: v2mevk2: Add PWC support
>=20

I reviewed this series, so LGTM.
I can apply, if there are no comments and issues.

Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/91994=
5015
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


