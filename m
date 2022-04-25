Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE88CC3A5A3
	for <webhook@archiver.kernel.org>; Mon, 25 Apr 2022 19:26:12 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.26499.1650871543392739382
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Apr 2022 00:25:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 23P7PXFa013062;
 Mon, 25 Apr 2022 16:25:33 +0900
X-Iguazu-Qid: 34tr9prRx6IGVr5Dld
X-Iguazu-QSIG: v=2; s=0; t=1650871533; q=34tr9prRx6IGVr5Dld;
 m=28viL6yjH7gkjBtL8XSvQMocSHLsgNdMBPWgFjn6TEc=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1510) id 23P7PW5Q039411
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 25 Apr 2022 16:25:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpIJWQZkRlkDvUgVDnAiTCdMwqPjQq4mS5zlFnS7CsazuSXP+54W1tVvqh0p4MHDEnlvneRibZwjNWb+uPYb5uYanohcXcEGFy+m+PZm8gemE9dDBt0TJ9VXLJ+2qMp6YN0Lhi2rkNWDwGnSrKUMSLcRkQEc+lvEN1zNe2cUYiciGeWn++c0QI/CQH0zcQ56F0CQs0Iv9R38YITUuL0yERSNI56WB8l9p1a9i7t3yfH3OIi8RdvFUlgwnP+cF5tBhQDOq1WB2sn6TbVpZm3u/JCTYBYkRMe27BV5osv3QHCb83jgA/xsYNOKTv9IYPa2CK5uh06v/SwMhBUEXgGhmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWyCMXfu2FZCv5EkdzzfricoqjBXXvJ2HCHHFa16oMI=;
 b=Yweq0AqU95kkXgMSB+EI6N6L+7eZhmide3uJkWg66KIH3R4HncLKFvzWThbsIncDMdsFHL2XobiXsfpX2yBNYNdU1q2cmsI11H7xFRjmKFh0PNMeXazzOk8s4cykEE/Cb5r3x6QnaxXeMYNUFysCVSYbslZYJQXkk8/BctgLOlskWFCcJFSxwwQnU+OqNaq2BAShwWO7P5xnvpFZA9IrT5Pruy3oMYLdQvbqfRSWPjhu6o/wroxMqA6JNe8AfciKF6cKn4A5O4xKimFwGFkLvG+6q9tAeFkRIRXSU9BrAJg2LswvaSXI3M9ghqm/Sb0L5v+a2XwpeyzmFVVpNoTdUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/24] Add sound support to Renesas RZ/G2L SoC
Thread-Topic: [PATCH 5.10.y-cip 00/24] Add sound support to Renesas RZ/G2L SoC
Thread-Index: AQHYVP53PzDhpsg+5kqJFwxgPIQK36z5r8LQgAZ2Z4CAABpJsA==
Date: Mon, 25 Apr 2022 07:25:29 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420DE0716389DC3BE8136B592F89@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYWPR01MB9420C80542707FC4B160E5E992F49@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <OSZPR01MB70199C4F3166C40240BFD058AAF89@OSZPR01MB7019.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSZPR01MB70199C4F3166C40240BFD058AAF89@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e1ce5a5-3e7a-416a-bc66-08da268cc6cf
x-ms-traffictypediagnostic: TY3PR01MB10416:EE_
x-microsoft-antispam-prvs: 
 <TY3PR01MB10416FBE8C23403DC2A56B3A892F89@TY3PR01MB10416.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wR9r4gd03+SjbQeFw+S85Sr2IU6slJCiVZPtoXR4lRE9q2AfEp+DPOJ5Xvs9deYAMNGtjuB9D5C0rd2ATpj6tX/C1ZcBgb9BKy1hWTvqoDsm1HxGsBx+hgunVGvs1G1RnKc4o8iEGm73h9q68TQKWwTYofPSA+Qt32p10mE9NBRy52gpuNINWqvaYGrqGGALv6rnaay0O7B1QMnLSRhVGW2crEkawinRJJNmtAyC8QyAHLy32NzhCZA/9UM7RvT8iD8cZnmy1YfClR34sNLJ8t+xR8AHQ3hYW2A/KFdytUd4ynxLR7s3DdrtwCSN6UWVvZZSVhz8jVSq2kp+aNzi+S0KnNI29RJcQFggjEs0Ux8NG4vcIrsiNKRewGkzl/EsLWDyRLXyy8XDvdcEDWT6spT0X+fqwgvfhMVRIgCSMr0xsliX5KQd/amYxUZkhqiK681JUQTH4eEQznPMMH8UublBeDKyV7EYqAYEyJhU2oAFxugmsww2Xu6Z+fbarYTNkuPb/H6n/MTyGWP0fC9b0VxIFLT/RnOUfO7n2bEA0D5oAzyHhGULL71v8ETxm7ikYiTgrSi6xJZ9QmeE4UXwo69kpdNtBGzKKvz2Tnd8oMV0Trwigx46lB+g7Lsvrt8pj1l452W1HGa+IQ/co1aYFGz61VhshhL029zP/EzvT5GNNnyDLwI4EhQD7WJF5yj2rbTrJLajyy9qYUKQUNXClXXX460HzE+wD2f7V8A1rA52CA+/ZtoiUZKgmrAsP/NHvoPHe693arJf92Ghc0+ZcUNS/WJ6hlNmfKodakKShK4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(45080400002)(186003)(4744005)(508600001)(64756008)(66476007)(55016003)(110136005)(9686003)(76116006)(2906002)(33656002)(5660300002)(966005)(83380400001)(316002)(8936002)(7696005)(122000001)(66446008)(4326008)(52536014)(6506007)(55236004)(26005)(8676002)(66946007)(66556008)(71200400001)(38100700002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?a3IwU0FyUXpBL0VmdmVSTXFWbkxsQ3lUd1kwUWtBeFpZRWZnTDB2bXNq?=
 =?iso-2022-jp?B?VGhVMFBOTEl4ODcrWHJPR1pWVzFSL0FONXRmNmdHTkc4ZjRWalA2WkRR?=
 =?iso-2022-jp?B?TnFwWFpGVnZmWTh0ZmpoY1VIV0RORHErZ3NCNy9jNmxwK1hoU1JYaUtV?=
 =?iso-2022-jp?B?b1lvSlJWd2FIRFVFUndNWGtSRVFxbUJNL0hrQ2dXS1RRbGpoMm1yYjVl?=
 =?iso-2022-jp?B?RUNoRGE4Q2toQ1lyY3NPbnFFa2FRRUFiL3ZWTmU2M0lFeGxadzhnYW5w?=
 =?iso-2022-jp?B?US9lWGNpbmNFOHBESy9DdHRDRUZybUJxU0YrWHByVUdtUEpOanU2SlNQ?=
 =?iso-2022-jp?B?eFJMcmdJV3gvd3BncTU3SGlGcUtBY3pVcjFWM09JZEo0Sjk4bUVxeWlZ?=
 =?iso-2022-jp?B?cEliU1pnK2xwc3VzNWJSWExaaEszcGZpaE12WU5IRHkrR1ZNNitoZ21y?=
 =?iso-2022-jp?B?L2puRDNxczduTU50VUdYcU5zUzMxcUlUU0lvY1J0OTVlemdaU1F4U1ZN?=
 =?iso-2022-jp?B?MmpRLzZkMWxMRTFBQ3JNRXYwZHdBcktlMHRBUHM5OVRkYytLQWRnV2RB?=
 =?iso-2022-jp?B?SEdwNnhKMm8xWWwrcEY1Tk9tbjh3c25vMW1tRk91Z2NJV0t4TW8zUnpu?=
 =?iso-2022-jp?B?U1JRdTlhWmJIdUdjL29OM3pNU29MUjk2SjVrZU0xWmNqdzB2NDNmSzUx?=
 =?iso-2022-jp?B?MUhFLzZaazhtWlBPdHJtWVhmdXhVdEZ2TG5weStqdnQ2YTZpZThzK3B6?=
 =?iso-2022-jp?B?NzJ1ZzVseGw0Wjk4ZXQwdkVWRFZuSVdFN0xsSTQvS3RLaE1nVE5zOFQ0?=
 =?iso-2022-jp?B?QlVOVXNWVWRwSTU4TmMyU0xsejc1aURWcm5xbk5kdjErdkhxWFBuMmZh?=
 =?iso-2022-jp?B?eUNBL2FzT1IwTk5OVTE5alg0R3FTb29leEMzQzlQRWNEM0R6b3VENW1R?=
 =?iso-2022-jp?B?YTdLa0JLaUJJZm9uWFIvK21qdmNWRHhld3NrNFNEWlpVQ0NPU1pnd2kr?=
 =?iso-2022-jp?B?M0V5cDN5cDBWTnFXRVo4cG9QSElTOWR1SUp0SGFoczJyclBxSTZmcFlV?=
 =?iso-2022-jp?B?Z3cxNUdQL2x3eEpWRU0vMGtCNWJwdHZabjJiNFMyMmIvMTRJMm1MQzRZ?=
 =?iso-2022-jp?B?UVM0V1NkanByRjVMK1BTMnFUeW5EQ1RvRnJhOEpUMGl2cmJLYTY5RDdL?=
 =?iso-2022-jp?B?SitrRkdOSTVIM21EQkl1TUZLK0pwSzAyUldSRm9mUmFkcHVZRDQ2TXR4?=
 =?iso-2022-jp?B?UE5ZVGhIaVJnOHlxUGtJZVYvN1FnQk1GbVVlYVd6SGV2RWFDUmRla2RY?=
 =?iso-2022-jp?B?aHBPVWEwQUNYUXg3STJKZU81RWViaWFPSW4zNWtWM0JiNkF0alhOV1V5?=
 =?iso-2022-jp?B?RTJOVkdnSUxLWHBvazdoZE9xNFkrclRFc0xIZWhVQ1h5M0tMcnE3YS9a?=
 =?iso-2022-jp?B?ZU9PbHl4S2t4OUFKSk9kcnZvRitmQlVRWXdnQmg4OEJXb1VtQVRMdHo0?=
 =?iso-2022-jp?B?MEd3WTA1R1l0RlZ3Ni9jVjJ2eHZQNC9jTWFjWHZjbTFKMW9IOWJ1TlBG?=
 =?iso-2022-jp?B?eHRGYk1uMUFMSUJkdXR3TmNjbGlzanZybnRFczhSSWFJeXp1T1B1dndx?=
 =?iso-2022-jp?B?UW9PZmM1UStJYzZSc1htQkV3aHZBVWtYQ1lyaFkzaUxEOU9RZGlLMmtt?=
 =?iso-2022-jp?B?ZzlNU0t4NUp6R0RObEZrUStjREdlZmhOeTM0SUY5NzdWK1lEdVprZUFn?=
 =?iso-2022-jp?B?cHRpTkZ6WVQrUEY4SWVxR01iQldWck40aHkyVko0Y1RNbVd6akFValMw?=
 =?iso-2022-jp?B?eFJXUkltckxxUUdWaFlFbXhZVG0rMUN5Mk5MWXVFeTBFNkZ5dmtVd2Js?=
 =?iso-2022-jp?B?OC9JQVNRdnp6cVpmNTU4QXI1YXlUVHBCb1UwVjQ5cExWQnVCU1VJcTBX?=
 =?iso-2022-jp?B?bjZVMDJtcU5QUU1xZ0tOaVJzYU1QVEJjczJDbEh0NXhrM2lBK1FMRitM?=
 =?iso-2022-jp?B?TjlNVFlLMy9KSDVwRWp5UEFscUZ5cGZlTmpyZ2cyMmNwWmd0b08rM2FJ?=
 =?iso-2022-jp?B?cUlTYVEvaFNiUEx6cUlOVEFNM1NXYWVQY1dUZHdpTHI3VlR3MDlQeFhL?=
 =?iso-2022-jp?B?Y2l6TVFCKzl4Uk9kbzdhQlpIU3YvMVpHWTA5UWhuV2sxbW42Qk5OOUg5?=
 =?iso-2022-jp?B?S01OdjNqemVKQkE0VjN5NnR0UDllN010dHJRcGdFY004K3pySHBKU0xm?=
 =?iso-2022-jp?B?eFRwSVZjNExiRHBJZjZ6SW1MUkgwVFJSWHFmL0dtS0xaRW9NbVdtWFBK?=
 =?iso-2022-jp?B?QUlEOFhTcGJTam9MQkl3bkhBc1NnbUVKUEkzOUdtenY4eGFqd1plalZQ?=
 =?iso-2022-jp?B?bjVJQmNkaWUrT050WjVPZFQ3WkVGM1d3R3FJTkpKUitNbGhGbEQ5NlNV?=
 =?iso-2022-jp?B?REVLcUpNVWxtV1AwYjBHWkNtam5KdFlpblpsVWJVVTgwREZOV3VQMWYy?=
 =?iso-2022-jp?B?U29EcXJmTlJBS3Z3SWJPNVk4b0NPVzM4cU9JckI3YXgwc0Z1RXpEcTZi?=
 =?iso-2022-jp?B?ZHNnalArTT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2e1ce5a5-3e7a-416a-bc66-08da268cc6cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 07:25:29.8970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 8eh0ysD+fNHj2pJYR63yF88rcZOsrGI+bj0VPHLuEuvmsBgdPJxjG230k4RFOhxRTrK6sz+qAIRPV3cwEIDQZn+WRPk5EM8UDyqNV5yJgcRTlnI4AiJe++V72C8WUYda
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10416
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Apr 2022 19:26:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8193

Hi Prabhakar,

> > Looks good to me.
> > I am testing on
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
l
> > ab.c
> > om%2Fcip-project%2Fcip-kernel%2Flinux-cip%2F-
> > %2Fpipelines%2F521117833&amp;data=3D05%7C01%7Cprabhakar.mahadev-
> >
> lad.rj%40bp.renesas.com%7Cb4ee1a6285394d44892508da2346a0d8%7C53d8
> 2571d
> > a194
> >
> 7e49cb4625a166a4a2a%7C0%7C0%7C637861083493803991%7CUnknown%7C
> TWFpbGZsb
> > 3d8e
> >
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C30
> > 00%7
> >
> C%7C%7C&amp;sdata=3DhAsfuV2fT66SH6cFpfI8cuUQMO8QVozG7EVlYAhMR
> u8%3D&amp;r
> > eser
> > ved=3D0.
> > I can merge it if there are no other comments and test is successful.
> >
> Looks like there is one test failure, pretty sure its unrelated to the ch=
anges. Can
> you please retrigger the failed test so that this patch set gets merged i=
n.

Yeah, I already retrigger it. And I planning to release a kernel including =
these patches.
Sorry for the late schedule.

Best regards,
  Nobuhiro


