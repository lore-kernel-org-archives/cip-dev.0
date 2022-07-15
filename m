Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EDDC43334
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 09:29:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.4465.1657877336231700419
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Jul 2022 02:28:57 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 26F9SjJt010348;
 Fri, 15 Jul 2022 18:28:45 +0900
X-Iguazu-Qid: 2wHHu0tpvgACLoe9Ew
X-Iguazu-QSIG: v=2; s=0; t=1657877324; q=2wHHu0tpvgACLoe9Ew;
 m=Gx6IFBV9cm8yud2F7pIDwOkOjHwfs2iS0qHMDVPT8Ps=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1112) id 26F9Sh2h007983
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 15 Jul 2022 18:28:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZvga06nmfXSacw5oNP2S9LkQGXuFtPtFwZSC8u/JTE43ouq7Z65wbepQhgBkpcMrNyPa0lEWk9gBvAujizxLYlP4tB/p/Owy9avuDMxwE3hrohk1pe5qZh8FyLaTXW5VhWGyae/H0s5cYc0GGzyrh5GKdgrUr4ZzJq72/H5gzPbND/KlwdPSEXkkOvIl6iPhvUHesjAmg+5jXWCR1bY2J8skXYS24FlhRp8kgJePFcWV0VqTCsZMv/k51m0qVvxHi6zAJn4rHGHaMf5RrXZKVXsh1ZvlJVh40yMw0C5JfCNjcf0eiy6MvZ/Y9YORoatXH3Rs+JnP5gsWT0R+J/v1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoR2VBhxr6YjjG1vck2kEG4/rHR6flrtKI/2RMvnrAI=;
 b=IJUrSdNnIRpBW2srVvRrmmKffA8jKmCchLWyFrvOdlZbP6kAvxh1i39vzt2rybyGYLSDgylfRY+SNrcnRmdoPLFeLfDhzWTlbTuKeie2KJakMrLQLlg9TjnmScSkuDjAk228CE5tjjoEz62f3y06tCqcwQZkNEJfi3nI8ImjgLVSoIX+Lkg9tthQw/SRN+40Usl9+UXpTkgWdTHzjrMvTFBJYkQ8tZZZRD8TQTloefjdOpAlSj8NgZeuTk+b7kkqfvUin85K+IHmtV0chmP8Rg8qAZnw45+OjI8jZSGETks9f2a7US+JB0+nK6UMYVCsD08cui1B4FMWqe8L8XMKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <Chris.Paterson2@renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH RESEND 5.10.y-cip 00/13] Add thermal driver and watchdog
 driver enhancements
Thread-Topic: [PATCH RESEND 5.10.y-cip 00/13] Add thermal driver and watchdog
 driver enhancements
Thread-Index: AQHYmB4MJWcVfACBx0CO2Qzj7n4IIq1/DbwAgAAbkEA=
Date: Fri, 15 Jul 2022 09:28:40 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420198D60D8CC87C72B9958928B9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220715073916.2321319-1-biju.das.jz@bp.renesas.com>
 <OS0PR01MB5922A0492B7405B2D6F409C8868B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB5922A0492B7405B2D6F409C8868B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 819cc7db-c9d9-4010-35ba-08da6644673d
x-ms-traffictypediagnostic: TYCPR01MB10215:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8KNAg7Nj5jCunpeZJJm8WwLinDg+yv1bRL/YjqZfuN7Mb6y/+AikiSFFJSJn8PH1BY2BdW0k1YVp1ljfoRak6Dr8Y6cxsO2IgxN7FjttGKwgg+E0LzLc3Gv2RWvcAoF8bW9YgBfY5P5K6yFzhzadbb8lyCjAv8tPgZ5i94NpUJvx9ixsduQB1oIsg01DiKWoZkZWgp5nORfpKukJxlPrzlodS+gkZzowKW9iQ78fjb+35/yHg8HUq9HniGwcsrIGtighhacqpxOQzIefeOxlGfmcGswzvK56E7eEyFA3VJMnGklC2kQLHVKGyyKSYeckPR0wpqlvT2s4L7qMybrT0F3tvb7UGPQei6il3pVFyWpLZuurbDCyGDOAeaURr6Jt3WcJNP/uSLGD1hHybodRP/TEaEMBA5l9ka1cEW5b3L+WfFMAV4BG5JAfGOS3gmGbDDyifJpcvBgM02AvcRrI96i4bOWjBNk2+Rk1/eHh0rQdxPmO6J0WQO6Ustt/VZ0LC2h6gid67LKQdZJmpN7Jh+2PXhXMVOBcE9hzWsVUoLX+3Zb9hzCbZQi6a5RgeFzAF3G7+nS8/X9ri6KoBLaNHiVxOa9I0AFCaPdOQ6kaUuK9rE4LDxIYaeUJT3zfteTmrLRmtU0tBV92vx4LnHEzWSbqAJbmXpV/ala+uL4sAJCli9I8HbPSud8Fnk1o+YPrpNdjWunqJkOEmywK20pf4pYkdM6yjWSgP1nvJsKTUyl+W3gHoOY9ZiLbXDqcqb0tFfLWS8a90bTdgys/c3yq17+2+1UFlL/LrCoQ6ZUdL1D2vft++en7ljNIF81wjikuYUSRfHjpb+4UoMzDkeJna7qUMEnJo3UBUnCBvj/MF3M=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(84970400001)(54906003)(76116006)(122000001)(66446008)(64756008)(86362001)(55016003)(110136005)(66556008)(8676002)(5660300002)(38070700005)(4326008)(316002)(53546011)(26005)(66476007)(52536014)(9686003)(41300700001)(186003)(38100700002)(966005)(7696005)(71200400001)(2906002)(66946007)(33656002)(6506007)(83380400001)(8936002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OTNqU1kzOXIwTFJuMW15VTJaVjVtQmNXbEJjQzdwaWhCV25jS3RCT3VT?=
 =?iso-2022-jp?B?RlF6c1JtSUhxN3lRR2pxRVlOeGg2Q29PTFBzWFdxQzh4ZHRjd1drSVJj?=
 =?iso-2022-jp?B?bUg4TlpNUE1UbWhybjBhS2ZHUFpVTy8vTG1aWVVEakpxcWZDRzhraHFT?=
 =?iso-2022-jp?B?R0JXNmN4S1l5eVR2SHM3YkdOeTR1cmtNMmc0bE1URnMwWmdDVnplZTB4?=
 =?iso-2022-jp?B?dzkzb2dHbGtCdlQyUXQ2ZWY0Z25DQnQ1TEVtMTV5WWNzV2JaTUJGelE5?=
 =?iso-2022-jp?B?c1ZHSGxVMGdycWo3aXQveVJZTXh5dks5Z0Z0SmRPY0IxK08vUG1LMUJw?=
 =?iso-2022-jp?B?cVdTVHNwUlpNVkF3aEVMaExreTlmK3Ayb1B4czMxamtjeGl6ZjFhTzdT?=
 =?iso-2022-jp?B?RVkvRUxoSFlIWGFXU29GMGpObEM5V2dzcXVTVWQ5Q2huTEVFbEJ3N0Rm?=
 =?iso-2022-jp?B?ZFJVeXhVeU9aS2N1L29YNVZkVWVjV09tTTYvZjBMaFFpVitKRFRJbmFq?=
 =?iso-2022-jp?B?NEhha1NyVFcxR3VRM2dobWhLSmc2dEtoeWwzQWxoMW4zWlRFeEpaeWdZ?=
 =?iso-2022-jp?B?cmhFUFdGNjEvSXFLS29RMXBjeFo0VDFyNnBKd1p4YTI0MGlQbVZocElX?=
 =?iso-2022-jp?B?d0xsYkdIdlBIMmtyZ0laNUpPL2lzN1F5SUsyUVM1UlBieUU4VnpmQXM1?=
 =?iso-2022-jp?B?cUhJQjN1ZDUzSDBZVTBROUlsQ1dDOUZvajd0MTNMZERIRWd6cWlscmMz?=
 =?iso-2022-jp?B?Y0hQN0RsTXY1bzVUVEI1M0NXbzJqSWxsMTNCem9rOWp2NzRWOUkrRFp2?=
 =?iso-2022-jp?B?V0w1eGZnMk15Zkt6c2x5WERWUmYvZjlvdUN2MHQwRS8zQnBLYkpob1Bv?=
 =?iso-2022-jp?B?RFFtS0diS2lmU3h5NGg4Tko1Y1JpemJRMk1OQlJvRjJ0TnRmcFJ3OXZu?=
 =?iso-2022-jp?B?QlJvRjZnWGJTS0RLWlJiWkRuQ2pISTlvR2FqaXpBVGVScGhGTWVSa0dX?=
 =?iso-2022-jp?B?SG1RZ0RRTWsxRHpWSldVbkhic0lyUVk4d005WVVRdUFLWEhtOTZHTy9k?=
 =?iso-2022-jp?B?ejlZYjRubHlrMnhUWkFyeUtoLzl5ckdjUElXZG1ad3FXSk5xYnNmQkQv?=
 =?iso-2022-jp?B?eTlGM1hpQ2xZNi9JOVNTTlp0ZnNmdVlkZFFmR0hoSHFUTlNtZVBTSlVV?=
 =?iso-2022-jp?B?UFpvbVRhSm91ZHdJQWlkSlNRc3NOZ3lON1E4S3hyUDBYTjJRVzExUkRs?=
 =?iso-2022-jp?B?emVzUUhuZnBuRjk3eTBrd3pwVWFySVh3bkhuR1F5NFFnNzhwdU5QWmk1?=
 =?iso-2022-jp?B?cFllWG5DbjBEc1dQRC9SVlpYNWw1Nis3UEc1d1cxekNzTHN6Y0tnMExv?=
 =?iso-2022-jp?B?QnpNZ0MwdW1UcUZGYnpCbGw5MFpYaDR5QmhqK0I4SVROVHRRSXYyNno1?=
 =?iso-2022-jp?B?MVV6Q0JNNlU5aG5OU2lZOGhaWVY4cm56Z0RycG1RTHp1M28xeG8vQ3g1?=
 =?iso-2022-jp?B?Uno5T2J5ZTZLMy9MN2M1bi9DaXAxMDFxbk9NSkNneUc4ZjJYRlIzSE9k?=
 =?iso-2022-jp?B?SkZmVGExNUMybkZxR0swMjBXMlk0SmhudTJXTFRHd1Q5YnJqcGZSc0Fa?=
 =?iso-2022-jp?B?UGdmT0NRU01ZUFRNUnV4NDM5OUZ1eDNCdjQxL084eExjSXVHUTdPamhn?=
 =?iso-2022-jp?B?YUJwUlhIcTMwM083Ny9yellia3IrU0ZnR0FBQy96VU9NV1RtOS8wYVhK?=
 =?iso-2022-jp?B?N0h6eHhSQXEzYVJEQy9DZ2lBVEIvZXJVTmFJK3loa2V6anBLNHZBOExn?=
 =?iso-2022-jp?B?dVNMZzdxN2hYeTZ3NS9OZ0c3SHZhZlhLZTZqMS96eC8zZGdRZWJlZkFU?=
 =?iso-2022-jp?B?WjlxalcxUWZxL1JBV3VpRExXaExPV0EwSkZ0eFppako3N0xtbm1pcWhq?=
 =?iso-2022-jp?B?ZGJoN3JoU3IvS2JiMFZtQXhqNFZPb1FJckVBVG4wai91YUsxam1yMzYz?=
 =?iso-2022-jp?B?UnFRRUljOVFGRm1HSU44cGtvRlczYWhMSkNvZCtJeDRLQm5Gay9wcDhQ?=
 =?iso-2022-jp?B?YnBUZDl0cVo5MnpLS1V5dFhFa2prQW9rd2gwK1U0Mm5zbHZNaitzc0VJ?=
 =?iso-2022-jp?B?cTZCRnRxc1pxVWdrK3dSaEpNUTd6Z1ZOTVNJdS9oRXNjdk1TQ3BpWXZr?=
 =?iso-2022-jp?B?QzI1NldDN2cvY1pwRVFpR0d5MEpnT1dnTHcxaXBKRTBDV1dEY3B4Qkcv?=
 =?iso-2022-jp?B?Nzk3YW9EaTd4MjQ4OFZrRG0xK3RtK1FTbDE4cmd3U0VTdjQ3N0swUXg4?=
 =?iso-2022-jp?B?ODUvdFNhWEhpYVhLdlgycVlzTythOUtxcHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 819cc7db-c9d9-4010-35ba-08da6644673d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 09:28:40.1908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 tEA7qKl70mS0takByYB5t7jQj/G1iuQovTuk+fJrA3VNPsHDVrGXv3uvbXuLS4+EopEgDyBU+TJgJ2z1RTPykDsHfwAUYmS1E5A5EtpyRP8EdlJFSlw6KIDIzQFSO1L4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10215
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 09:29:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8826

Hi,

>=20
> I can see patch#2 and #3 of the series landed in [1], but it is not showi=
ng up in
> [2] and [3]. Any thoughts on this issue?

Yes, this problem happens sometime. And I don't know why.=20
All emails have arrived, so I am getting a patch from MUA and applying it.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Friday, July 15, 2022 4:46 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#S#W#C"~#A=1B(B
> =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: RE: [PATCH RESEND 5.10.y-cip 00/13] Add thermal driver and
> watchdog driver enhancements
>=20
> Hi All,
>=20
> I can see patch#2 and #3 of the series landed in [1], but it is not showi=
ng up in
> [2] and [3]. Any thoughts on this issue?
>=20
>=20
> [1] https://lists.cip-project.org/g/cip-dev/topics
>=20
> [2] https://patchwork.kernel.org/project/cip-dev/list/?series=3D659971
>=20
> [3]
> https://lore.kernel.org/cip-dev/20220715073916.2321319-1-biju.das.jz@bp.r=
e
> nesas.com/T/#t
>=20
> Cheers,
> Biju
>=20
> > -----Original Message-----
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > Sent: 15 July 2022 08:39
> > To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> > <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>
> > Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das
> > <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad
> > <prabhakar.mahadev- lad.rj@bp.renesas.com>
> > Subject: [PATCH RESEND 5.10.y-cip 00/13] Add thermal driver and
> > watchdog driver enhancements
> >
> > This patch series aims to add thermal driver support and watchdog
> > driver enhancments for RZ/G2L platform.
> >
> > Resending this patch series as patchwork is not showing
> > patch#2 and #3 of the earlier series.
> >
> > Andy Shevchenko (2):
> >   kernel.h: split out mathematical helpers
> >   units: Add SI metric prefix definitions
> >
> > Biju Das (10):
> >   thermal/drivers: Add TSU driver for RZ/G2L
> >   thermal/drivers/rz2gl: Add error check for reset_control_deassert()
> >   thermal/drivers/rz2gl: Fix OTP Calibration Register values
> >   watchdog: rzg2l_wdt: Fix 32bit overflow issue
> >   watchdog: rzg2l_wdt: Fix Runtime PM usage
> >   watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait context'
> >   watchdog: rzg2l_wdt: Fix reset control imbalance
> >   watchdog: rzg2l_wdt: Add error check for reset_control_deassert
> >   watchdog: rzg2l_wdt: Use force reset for WDT reset
> >   watchdog: rzg2l_wdt: Add set_timeout callback
> >
> > Geert Uytterhoeven (1):
> >   arm64: defconfig: Enable additional support for Renesas platforms
> >
> >  arch/arm64/configs/defconfig    |   4 +
> >  drivers/thermal/Kconfig         |   9 ++
> >  drivers/thermal/Makefile        |   1 +
> >  drivers/thermal/rzg2l_thermal.c | 248
> ++++++++++++++++++++++++++++++++
> >  drivers/watchdog/rzg2l_wdt.c    |  83 ++++++-----
> >  fs/nfs/callback_proc.c          |   5 +
> >  include/linux/bitops.h          |  11 +-
> >  include/linux/dcache.h          |   1 +
> >  include/linux/iommu-helper.h    |   4 +-
> >  include/linux/kernel.h          | 173 +---------------------
> >  include/linux/math.h            | 177
> +++++++++++++++++++++++
> >  include/linux/rcu_node_tree.h   |   2 +
> >  include/linux/units.h           |  22 ++-
> >  lib/errname.c                   |   1 +
> >  lib/errseq.c                    |   1 +
> >  lib/find_bit.c                  |   3 +-
> >  lib/math/div64.c                |   4 +-
> >  lib/math/int_pow.c              |   2 +-
> >  lib/math/int_sqrt.c             |   3 +-
> >  lib/math/reciprocal_div.c       |   9 +-
> >  20 files changed, 544 insertions(+), 219 deletions(-)  create mode
> > 100644 drivers/thermal/rzg2l_thermal.c  create mode 100644
> > include/linux/math.h
> >
> > --
> > 2.25.1


