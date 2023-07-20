Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DCCEB64DD
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 10:00:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.9379.1689847207162769570
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jul 2023 03:00:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 36K9xxlq266162; Thu, 20 Jul 2023 19:00:00 +0900
X-Iguazu-Qid: 2rWhQ1EpYB9RpPKgdO
X-Iguazu-QSIG: v=2; s=0; t=1689847199; q=2rWhQ1EpYB9RpPKgdO; m=Tlik/CCvrd8teardwkcv6sL49mRu75x86nrSyVHkQeI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 36K9xwKR3566219
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 20 Jul 2023 18:59:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cgslo/EuKKrzrTiYpmT0z1ijAuNaS1NmTPnhrRo7ZFDtzGFyfrSDTGrTtAAeusghu/8shzzEis9s4/1doDldwJvhY4FV4HRbRzWk/skzJsUy83t9UjaE8KoHfJF3IRhj1qNUNEzc5I0mqK/B3V7H3BUG2nM0D0cOaiurA9oMwuHPwoUqRpTmGO2+iglfXsZSq/1cNnqdEAkMc5HIvpRwbE82a474XHg6u3YFuDyEqHO4hOIUFJfb06Us9KU1xznJA0dnlVTeCShE3beUJooBv/sZfAA06gGStlTnuq8gQRxfVkk2LLO39KPf4Bz0wvtrE0MH/VaWqAUcTaQNnh3Aow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGjYnl2Ol0xNmCKBmtJh1VmlHrwB0l6wXfK1yMQAeO8=;
 b=EAesGIcL6m7JAlNAH18xNF26i6Dky1qLCUS/sUQZh4Wrkp5BA36mAdjIf8sumVQKsxIo1/nBNt+GjNFG3S4xTmu+czI8LJ7yMsmk6nm9AgagEALwULjBQnAXtHwTq1iXe5fzZ9niKOH0Isjqtv/wexc6qTA6WytpO2zXvZpQuHPN56ARb/zvh6DiZ5e1wyvjH8k4s7xN/jzWfDbCYMUQ8BEM8WWC62HvtuTQ/MuWqF0tVD7JNJekB+JIyn6ETUESARpf1HVgGwnyuY1aG6KpBmTDmkFAq2TYar2vNFoNDf+8UAQqM7uCKuVEwDPt0I3GnyeKY6q40DmxGhkZpQ9uLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/6]  Add RZ/{G2L,G2LC,V2L} MTU3 PWM support.
Thread-Topic: [PATCH 6.1.y-cip 0/6]  Add RZ/{G2L,G2LC,V2L} MTU3 PWM support.
Thread-Index: AQHZuYHGXKfgg8q0pUuf5Wf8w5OY0a/CbrOA
Date: Thu, 20 Jul 2023 09:59:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942068546B387A153DB9EDE0923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230718141129.119809-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230718141129.119809-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYWPR01MB12087:EE_
x-ms-office365-filtering-correlation-id: 547732fb-4eee-48d4-68d4-08db89080d61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 U/tBBQE+it40fHwNVsvQDS5YQmzFMyZMgUFwFoMeFKPybL0ZouYlWkZUMi7RMBE961z2FvgUHs4x0qwI6vTpYMKXaY/aQXbYM8nzaATasOML/uaFPy9t0nLWe8l4SwpBgzkiYyNE1+urMehpHaBUFTZjgnlpiatgRAvsCYQBCIb46JVqoNlHtW0MMYziV9g0/T1szL8ui2w8Dd+BDYzLH/Bt28N8IYR4zBpL8nIpURIWJ5hOpsG1KPis7nD0cThbt0dLwSToQUDh+UsM2Okf4gafCiNJ/TGkZSdeQ9Ow6EU/KxU86rbcoR2ZoeOG7coiXIvNVxf1xStcEp7n3jPYqXrAFx8RcsghYf6kCXn06rHaXeJr4S9RdRS9kggYAO3w5p++c2Y0EAoYsd9FcoYV4ceULclIzWi5l3lsSiOS6z4lpj9BwH3XcA9M9bpDK1t4TaJs8S31sheh76jhIiKXFOlemRXGxIGPFF4Hs0s1n1JLS+2uDABg0IE8A1/uE0yRURswoNT91e/ta12AopjpuhFxfK3gcQjvtqTyn/NAuITAbUqsvCVb1VK1o4ppk5ysNWvmnHQPgPsrjW+cWRiX0ga9UqHDW2CeIaO0z2Q6lDdjQokRMOe3jQRGdCe2JlVj77e7AqtnzJ63OwAlXjIjgw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(83380400001)(478600001)(71200400001)(186003)(53546011)(6506007)(55016003)(9686003)(8936002)(66556008)(66446008)(64756008)(66476007)(41300700001)(8676002)(316002)(2906002)(4326008)(26005)(7696005)(86362001)(76116006)(38100700002)(110136005)(52536014)(38070700005)(5660300002)(33656002)(66946007)(122000001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WnJNU0ljWnJEcXA4eklQNGozL2daRENObks1dkdHSGprREFSclNiekx4?=
 =?iso-2022-jp?B?ZHFYVzFseDhUTVBGTmRrOWZkMG5hVHh0SldEeU1ic3ZIbXVHR3NTZlI1?=
 =?iso-2022-jp?B?NXRaZVYxNytWK3VnSEVsVmx6YkZ5UUJxc2lVZXFrUlVhOCt4VEIzWkF0?=
 =?iso-2022-jp?B?ZGJYdUplVWpqZXNxbG5rTnNkTlJJa3lGdEpSSVh2THQraTZ2azFVNFFp?=
 =?iso-2022-jp?B?bzFFUUdpSnl1QmxpQlhSRDVRZzRxV1BYRjBtaHp6Y0hFc1VXaENBd29J?=
 =?iso-2022-jp?B?b3l4REZQeFd0OVZoY3lZYlJTa3dRckV2TjVlLzZXZm1ZTWJBVnRrekNq?=
 =?iso-2022-jp?B?N2RwaG8weGN6Y3NKTHpVY1R2NW9FZGxsMXZ5aXVZQ3Z3bmUzeUZpeHZz?=
 =?iso-2022-jp?B?MUh1QW5HRTNWVkE3ZE1xeVBUWm92RFRKQ01mMkhLekZVbE85cDRyTWNF?=
 =?iso-2022-jp?B?eFhwL09rQW4vYVRFdlpWL2ZucytJdmZNSFJ5dXdtZnFsT290WjNUS3ZL?=
 =?iso-2022-jp?B?dE9CRkhPN0h4c3MveVMrcE1sZ1ZuWjU4akdTaTdoOEtuNnBpZXpTZUdH?=
 =?iso-2022-jp?B?c0E2d1l4bTZLblFwUjNGTzV0YmU5R1RHcUJMVXBDUXp4enFMYjdMYy81?=
 =?iso-2022-jp?B?clptd3RML2lJemtFcDZMTjFzWHRnMVhIVTBCNVdBcmZ4djJZcmxNTHdj?=
 =?iso-2022-jp?B?Q0VKdXVDZlB6QjZJU2NTTlBPVWJsMitjVWd6Q2dzUDZZMS8xOVgzSWZG?=
 =?iso-2022-jp?B?Q3VXZWNHbWVGaGFsMW43bTRmME5lREE3TjA1ZC9pQS9RZ1czM0pRbkNS?=
 =?iso-2022-jp?B?RjYwdmdnQy9NMmJBVDFreVNkdnVyUzI3dlZobVhzVy9PTjBrVDhyVFJB?=
 =?iso-2022-jp?B?RXRCb1QwaTlQUS9HZHd1N056VW52SmFCNC9zbDRTb3c4VXY0c3ZncHJG?=
 =?iso-2022-jp?B?K0tYSnRrTExzcGFvOWlEbjNSUzdURjFhQ01sOVlhUVVYSUMzSGZZVmkv?=
 =?iso-2022-jp?B?STRiQ29idGZFSXZQbmJyR3BmOHh3cDhpN05adlVOcCtnV0lPY2Z3VnhR?=
 =?iso-2022-jp?B?QkFWTXd5amRWOE5obmdnT1IrRDg2dWVueEoyWnMzUFlTd3ROejhJemJw?=
 =?iso-2022-jp?B?RmZKVVZoK0lSdU85aCswSnFZSkNIMm83Sk9qS1I1bWF5Szdpdlc5KzZI?=
 =?iso-2022-jp?B?eTR6OStLOWU2ckJkVWRvYTRjblJsYkwzd0pKKzVKZnRsQnIySGZNUW90?=
 =?iso-2022-jp?B?YksrOTBFNEFtaVI4TXRIRUpCd1p0WFpnOUlmWlFzQXAyR1dLd3pwZGlL?=
 =?iso-2022-jp?B?eXhVa0dLbm1iZWZZMHB0SGREOGtyd0NBWjIrR3lxZkxoSEdrYVh6QUha?=
 =?iso-2022-jp?B?S3d1OVNRMzh4K1BzMndMQ3RickM1L2ZYWDQ1SUZOWnVUdGN4TlE3Rjdt?=
 =?iso-2022-jp?B?ZVU5VVloKzBmSGhCbFFsclVEclJURGVYQ3dvMEp3RFYxVlVISERMVkhi?=
 =?iso-2022-jp?B?b2dyWnJoa0Q3MlF2d1MrOUlzUXRoQ3FzeDdTWld3Wk8zMEhKOHlUZmhZ?=
 =?iso-2022-jp?B?aWROd2Z5eFFsZS8zU29zdWdKd0JmSHFBZmNraDQyNmUzUWpGck8xVHNu?=
 =?iso-2022-jp?B?RW5VSHdoNXFmK0NCUVd1TGh5ak9BUm8xV25FQlNiU0FhdkNXL2w5dVFJ?=
 =?iso-2022-jp?B?d28yaWxvVGI3Vy81UmJFTE9DaTR2bzhWV0FoM08wUkZ4OXJsbTFwZHU5?=
 =?iso-2022-jp?B?cGtnVVU0cDVRSHkxb0k3OWtpdEtWR2ZnczNqVDZRbkl6YVdESTJjS21S?=
 =?iso-2022-jp?B?ejVFSzdnM0QzaG9nNUZrWU1CT2daTDdBck05bkVOaFRibWZCbC9XaHBx?=
 =?iso-2022-jp?B?WXJJRTZJcXZoVnVvM0lhYkJtVWEyYjZuTk5RVzVPQ0t0eWptUjk1dlQv?=
 =?iso-2022-jp?B?Q2VOUFJwS3dHcXRRcm1RVVN1TTdvUVAxMVI2VG9YNWlLZWJybjNrYTV1?=
 =?iso-2022-jp?B?QXZwMmVrYTVLVEVWZHkxZTk2RTd6b2tzVzR5UFQvanozd1lxeFlTS0ZO?=
 =?iso-2022-jp?B?b1lTRnJTYytjdDc2aWZpWWoxRkV3RFpEYW9ZNGdTZ0ZqVlZlYzRJdDk5?=
 =?iso-2022-jp?B?dTRaa29JdkE5SER3WTFQbXlmaUQ1cklLT2loSWpnUUF4V25YRWRFNmFU?=
 =?iso-2022-jp?B?RGtselBRNjJLS21TVW1qQVpqeHZWTDFvVS9tazRxRUdlclN5TzhmNDZj?=
 =?iso-2022-jp?B?L1FUOERCQUY5K1VLOExHYWNOb1VOS0plUVdVMi9JblkrcXpvM3JPMXdH?=
 =?iso-2022-jp?B?aUNwb012bE5LN09KSnJtRy81U0J3S3pXZXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UblIt3sNf6wDgpdG6kOk/4ohnYA/IpI9aFnLYqgKcrmLGwmUMTU/aszcT+tpspBLH1pkP77u4Vo/hGPlc3UZQkYMRSoJ2GBStU7z6vU0IYx1IVxAlUKZEhu/dBRAPBrwFIqO6MeZIPqNg3wXNUt64MCZzIMImCQekwVWzqzInI5PkzLqPKXcOv8cUuIp26vUqid9va5ahWD+6dIiWNA5287f9TzQH8+BlteRvL/hDI92hjdSY2Y3no2zXwWepsMtQ4bTQF62Q4tyikVYVKaqRJ2HJ3bje9Uos2y9EhW29cwvF+jZCsZgJElLUQHHPZUoxBoJyS5gyxXHZvgtRXEUbKDb4E/kT12++LV8Up4qT7Bej8Xe48bkUJ3WV0NG4YHSvqhrb/B4wVwmB3aK9UQFmpiXI2aWaUBoGAtHWxBEKi1AeuuOQI/tZLPGyo3jXsAzurVgiqGUq4cmHWIp0T9seir8G2qAQTaIDMKl+RTpDF9i8m+Cdtp6VUa4GGrOu5/UAIlk0oUwdXdnGxUBFA8LjBU8WgI9/96J6jdK6uVlLe2vLksgMICo5HJw6Vs2qWSDsAEh4QO+Pf1nmiPMWVzEM1H55M/XcXDCz178qUL2OLD8xMpeAlRsZv8sgg/HjJyo+ZvfS3KedI638b2H4WqOUJy51/Q09ula+pZ5rgIgycqZ/8ADXid2WXPdboifMLlxoiUudnuz/hIsWPHkOcKdgaSkYu+MzX/JelT6K8aAnX+Cj+mI0xk+cYvOdIn9RT3myYnrFUb5Ipgjc5UaXqROmIh5MkaYvQUiO41v/QFVkGjnx1TzIDJpHuMuMbzOrz4TSBaEQCn3GKUOanwKUTPGl+ddnK2ObvYujTYM1n4F7sGPGXgB75M1jB9UlM2GY8ihfzHNegSsO5eAJBpWZVoARQ==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547732fb-4eee-48d4-68d4-08db89080d61
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 09:59:48.0280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: evTjKJPTaywIDF97jVcwnVMvNyH5DQGykLFEVa7obKQdzpxKK2qsz4FmfQLclv+xFc1M02s1DfWxhS2FgHNLubKa8s9hj4kFxalGzpBJa+Ze7YsOs5V4qg4EDnDJcwll
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB12087
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 10:00:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12444

HI all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Tuesday, July 18, 2023 11:11 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> Subject: [PATCH 6.1.y-cip 0/6] Add RZ/{G2L,G2LC,V2L} MTU3 PWM support.
>=20
> This patch series aims to add support for RZ/{G2L,G2LC,V2L}
> MTU3 PWM driver.
>=20
> All the patches are cherry-picked from the mainline except patch#4-patch#=
6.
> The trivial patches#4-#6 are cherry-picked from next.
>=20
> Biju Das (5):
>   arm64: defconfig: Enable Renesas MTU3a counter config
>   pwm: Add Renesas RZ/G2L MTU3a PWM driver
>   arm64: dts: renesas: rzg2l-smarc: Add support for enabling MTU3
>   arm64: dts: renesas: rzg2lc-smarc: Add support for enabling MTU3
>   arm64: defconfig: Enable Renesas MTU3a PWM config
>=20
> Lad Prabhakar (1):
>   arm64: dts: renesas: rzg2lc-smarc: Include SoM DTSI into board DTS
>=20

I reviewed this series, LGTM. I can apply if there are no comments.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


