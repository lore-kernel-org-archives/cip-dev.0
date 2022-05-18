Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245E3C433EF
	for <webhook@archiver.kernel.org>; Wed, 18 May 2022 23:40:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web08.1490.1652917225740409146
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 May 2022 16:40:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 24INeMDB002952;
 Thu, 19 May 2022 08:40:22 +0900
X-Iguazu-Qid: 2wHH68dypwhKFbfi6q
X-Iguazu-QSIG: v=2; s=0; t=1652917222; q=2wHH68dypwhKFbfi6q;
 m=NywoaENDlZNINqBNlY+d3+bIke4kcSDj1KW+UGkrbmg=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1110) id 24INeKwm040052
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 19 May 2022 08:40:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZokLjPYRl2xPdsZlVVuibzHi/6M+c3SWEpCcdXF4dNRhd1wWOWzwiQ4CWNFGgYzmispA++OAcMLuMP1VnSY9BKLgoktTIPo/h1nSgSciNADLoKIrS4Rl26zu9SdMWPMFJUFU8EIVNttEVq7FhAIOa2I6mAlVlm3g7mtDiGiu4UdjtcgK2RXcW6s8Nl6FuHA7KoeSdfqDtHWNcIdVdD1AE61RebqEOX/kMAZzz5am3jWkRvEg65YitGdSgnro3Tu69I5sj96wFdyALiEP5ZEVKYRqZjt9hMUO388xrubU9NBWRMD/PIcaTNgIR33qiWsunVSml4hZDE4tOdPNElrag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqJgR0lvISibZkWY0x/gczF8q+KVS2a5+UOJQ1o+ZbY=;
 b=BvtvJdlNEAKmVMwWfZGyQPgC5/FIck+3dq8DMHHVab6oniCSMaY6Wawu+UonEQjNbDOptjpxAevxeV1aWVeT4w5k6XC8bRDJYmSqXFfXYA43X/EJAJj/S8YYAdNHTEr6FYo3LsyKd/pq95s+3NXC/KXOF1IfcFiWI3gKqvDGQ//M2Mtfh6dPArYRM6Pqu0P/QCHis1ea9ZE2R7XTab3ZlLZAVtdgadxlAVtNkXw+KGTXDefF+fmAnS+Is2188qj40JONvoTQr9d2aKeUqa/bI5kOf5uGUXj/EAfAqgoHQvJFL7SjpYGKuWL1Jx1EQIOpDkyjvPnubzOkAf6/UKmrYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <iwamatsu@nigauri.org>
Subject: RE: [cip-dev] linux-4.4.y-cip-rebase: patches in wrong order?
Thread-Topic: [cip-dev] linux-4.4.y-cip-rebase: patches in wrong order?
Thread-Index: AQHYYHf+3l9MiSHYWUeqHuDTVhgMKq0lX5HA
Date: Wed, 18 May 2022 23:40:16 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94206F854C936F554C2F490592D19@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220505120120.GA4543@duo.ucw.cz>
In-Reply-To: <20220505120120.GA4543@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdd7be3d-d263-4298-4f93-08da3927c2e1
x-ms-traffictypediagnostic: OSBPR01MB2952:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB2952D9BB9FDBBCA8B31C2E4492D19@OSBPR01MB2952.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 t1Sgu6vaZOE7i/kBWTvJ3SYS+blaQXgzSCANyAb72oYONAt1RL+3Bttm25fvHSqOTnlDismbYQ9KKtoaJMvEc5JTHLeYsuZu50ohRVkaLqg739XqYZsKNn6eUJ0AoYIdjRKZmxS9DryLm1HxLxikCLtvOmVJBBYme9NVAU87UMFwEx1575l/kbn0ofifHTlwiilhLPoepfmXi2ej1NWzc1OPPueMNWX9zL8jrwwZl5R+lue9QicUKdJ5UuTW1XgVrKEEEeyS6Ih2QksapBUeMNyqB4Ou5eGKyqU8jWdUU+yIJu3bKmYnkqLBzgNDQfFqX7xrkxtsgqxVVuoaC/UTm6Bz84Lj9JOht1CVPQKOzEjJXcK9GhlvEyha7+3+WaNmM2Jf/eNotNqpkqiZhx+5JQ3KikSBN/aUKl1zvkpGBx0F2K9SPrz4LAD8EF2gCandJhx6x/v8cmIpYuj9Rb2xTuZsepgBC8Snf/JeKLAT8UrU9DbaYy8cbXKwdbG3lYF0g+T2OR7mgfmnftvUzb1MKpzB3LfWd+nBvcKhog287BgvULeTnVT2hEUSpvANqn+5QvVybDCN9Kl4wr8NdDHh7x9PmTanZKd0SzechljucFiSGyFcTAGVaXp7IN32U/BMjn3R+aZQSi8NA7RQVD5MGDnVp/b4fZzRm6vtK4gUluURscUqPAWBuBkw9Ag2DQ11Cw4baMWRnLSGLDmliFdBMQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(71200400001)(33656002)(316002)(4744005)(52536014)(5660300002)(55016003)(110136005)(2906002)(8676002)(66556008)(76116006)(66946007)(66476007)(66446008)(64756008)(8936002)(6506007)(26005)(38100700002)(9686003)(7696005)(86362001)(122000001)(38070700005)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cFIwbXJDazVibTRMb2srY1doWUlzdnZ3dzF5UnJXTWRNdFNKdElkR0cy?=
 =?iso-2022-jp?B?b1lmaG1hU2d4eDNDWXEzSlFEeDdMYmN3SjBPem9sVk1NVFQvN3lwWjlS?=
 =?iso-2022-jp?B?OXA3aDlhRmRBR1RsQlpUSEJtTndsUHdxb1BKOG9na0h0WHNNaFlBOSt4?=
 =?iso-2022-jp?B?bEFUVlBFdjZzN1F6eEkvY092Q0dXMC9ZOU1SOXlLeTZ0cmdaQngySHl3?=
 =?iso-2022-jp?B?VDZZRHNNRStEckhXd2plTEdnekFFckwzMGVDLzN0T0Vvd3QzOUhYZTVG?=
 =?iso-2022-jp?B?aUdBSEE0eWZCSzQ5eEZQTm1uTnpla2dSRlpMYTFhM2JhNjZMWkZDWTVj?=
 =?iso-2022-jp?B?ZEFHVlFJRDYycHhqZUl1cGg2NHRxZ3JwamZEWTJDU0kvVDFxTGl2dmQw?=
 =?iso-2022-jp?B?MG5yMEVvLzBnTjhaYzhoRnpwRHVaSmsvSkpZVlF2aFJjTWoyak81T3lk?=
 =?iso-2022-jp?B?anJsMFcwVHpYWVZjaWZqdnhqUVhKUkdZYmczVzlib1hZcXdhR0xMOG1Q?=
 =?iso-2022-jp?B?akZoR0xqWlA2NTdvNk5tMTYvdVJ2MUY5Yi83QXNwTi9RTGUrT0ZkS0lt?=
 =?iso-2022-jp?B?bW5FQVFreDF2VHJRTWxqV0RrNU9iTngzVWxpbWxLWFJZMG5GSkhIdmUv?=
 =?iso-2022-jp?B?cTVVOEdXOVlKQldxLy9qdmNJWEhHRFgyaWxQWVlsT3FreitnZnZBWS9C?=
 =?iso-2022-jp?B?SzVsejFtekZPeEdyMDExanp5ZTFZNlpvT3ppTCs2OTYyWTc4cWJPTlZQ?=
 =?iso-2022-jp?B?dWY1a2ZYSGlNQkExTlVBb2hxZ1B1VmVNWi9JcHFKOVU5Sk1BU0w2MXVN?=
 =?iso-2022-jp?B?V2FHQmlFL3VlM2wyaHBITGZJSFV5bENLQ0F6UGhBc3EzV2xWYzcrQjFW?=
 =?iso-2022-jp?B?Q01MT3NybUpMZENmaGl5RXVvOTV6dTNEbU5xUkFyOFF5VjdsUUt0RzI5?=
 =?iso-2022-jp?B?Yy9Vd0ZYanA2akJpNXA0SFBhbU5HaWowVUJLajlPMWxKZXYxa0xZU1Zw?=
 =?iso-2022-jp?B?RGp3aFdORldkOEpVVG5TRkl6YktOQnloaGM0bHZqNDNGdG5zMzZqOHV6?=
 =?iso-2022-jp?B?SXNTOEQ1TVpaQUdKT29LQThYRzNPdHJVaFJjc24vbEsxaXVjemlQcElB?=
 =?iso-2022-jp?B?Q0k4M2JkZEUzM01xK3h5bWVUMmViS2g2OExodlF6WFNVKzEvbWpOQmF2?=
 =?iso-2022-jp?B?ZW1jdy9mTHplNFVRSWFaQXNaL2l2K3BmMTYwdU5JYjJheEUyMWJmcEhT?=
 =?iso-2022-jp?B?amhGMkNadExuQnZGaXhpRnRqSjgyMHdKb1ZFcUpsa3pDZTR0dlBmR012?=
 =?iso-2022-jp?B?U1ZlSkljc09vSmRJSnhTeldXS3hMcGNDVW1yZm45NUVpOUd3OEpNWWpG?=
 =?iso-2022-jp?B?YlFRT3VCemQ1STRDanJnQk05QmxQTXRzb043bTlTTEFYUWFPZUhEa25V?=
 =?iso-2022-jp?B?QThoTHQ3YnNPM2k0MzEySVo1NDg4UE93bGRFZG9tajZWVzVsY1ExVjBq?=
 =?iso-2022-jp?B?TVB2R3hQOWtQMWExNmhzc2hYQTBNK3dkZWxjSVM2OWt1ZFFWeVVGWEN4?=
 =?iso-2022-jp?B?U2pweW1zWUVHaGF2cVh1U1F0L2ZoZHVhbWFrc21HVkt4WTJyRmVOUUxE?=
 =?iso-2022-jp?B?cUpUWUVMVW9BUWZOUXdBVnNFN1RLTFJQdjVBK3pGc3VldnVONXk3RFMx?=
 =?iso-2022-jp?B?VDlJUXJXNG9DQnNoVkVvTHBFN2NvK2VGQzdqRXhhQkx4Vll1TDQyYW9h?=
 =?iso-2022-jp?B?cVRtalJjQ0xUdURXT0tnN1ViUm1VL2V3S0plRlVZWExTZWtLMXlxN2JR?=
 =?iso-2022-jp?B?ZisyN2RUWXBXZ2U3TXhqSVBsTWJIQ0lCS1cvdVIzcFlKbTdWMkI0N0p6?=
 =?iso-2022-jp?B?Y1hYNHV4OXliWG8vS28zbDgrU002TjdoaWtmVlVBQ1dGT3V1ODJoZnBC?=
 =?iso-2022-jp?B?UjV0ZENHczQyRlJmRjdnR1hacE5GM2lFSC9JamZWNlNiZXIxU0xWT3lB?=
 =?iso-2022-jp?B?THVBbkZQVERYb1VKT2N3ek4xWWdOVzE2VGxsQjdFMFFwMkxIVEhKRUc1?=
 =?iso-2022-jp?B?cWJ2Ymd1TVI2SUtZM2Vuekw0NlFNb09FLzQwTStleUI0TUdGOWQ0TEUv?=
 =?iso-2022-jp?B?dHZNWWNJL1VVM2RlTkdyREFVRGhxK3BidTFpZGlwVXRYWmVyeGQ0RVFJ?=
 =?iso-2022-jp?B?VnpFTndVQ2ZJcjl6aE5WSlhENHI1bnhXeWhtTXZCWlVBbWZHUW1Ob3VP?=
 =?iso-2022-jp?B?Yzc0VkV5cnBTem1oNkdjQjVtUmwyaFRXY0Zxa2s3eHNtZzFRQUR4aW94?=
 =?iso-2022-jp?B?NC9SUnhuWWFKeGQxM3gwZzBWVEkyVGl0WCt4MnRUaHpBV3VrTExuNUlx?=
 =?iso-2022-jp?B?REt1SFc0NHMrMXZoeU5QZnZxcnNTbUJzVW9ZTGhQZllKb29STXBvTjQ0?=
 =?iso-2022-jp?B?dXNkVFQxQ01GTUErekxPNDBPYW5vWHhHMlE3eDVxZ2pna3I5ZnRZdDFi?=
 =?iso-2022-jp?B?bUcrdjdWb3VsNGlvSXl5dHlSNnNnYUtkT0pMNGdoU3VIYjRBTXJpdE9X?=
 =?iso-2022-jp?B?WlZET2NlNHRMUjh0Ly81RHcyT00zMmhQRHRrMA==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bdd7be3d-d263-4298-4f93-08da3927c2e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 23:40:16.1763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 8TVgDzUysifyGAGX5u08qNHtSZG7YpKxVmmT7o5a/4p4+uq9s9YT4n5mGi493oLbRlPf8/Nb2xjCQorg2JnbuPNwg2ZQJ8SU2CDtM97F1qABQG4VuMRVIwoTyTXXsd7E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2952
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 May 2022 23:40:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8410

Hi Pavel,

Sorry, reply was late.

>=20
> In previous linux-4.4.y-cip-rebases, order of patches was:
>=20
> git log:
> [CIP patches]
> [Greg's stable tree]
> [Linus tree]
>=20
> With start of self-maintainance, we now have:
>=20
> git log:
> [-st patches]
> [CIP patches]
> [Greg's stable tree]
> [Linus tree]
>=20
> This was unexpected for me, may be unexpected for our users, and would
> make -cip-rt release different to previous ones. COuld we get order of pa=
tches
> be
>=20
> git log:
> [CIP patches]
> [-st patches]
> [Greg's stable tree]
> [Linus tree]

Indeed.
I will revert to the commit order above, and force-push.

Best regards,
  Nobuhiro


