Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1408EB64DC
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 01:49:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.2362.1689644963616283476
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jul 2023 18:49:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 36I1nLIF4075162; Tue, 18 Jul 2023 10:49:21 +0900
X-Iguazu-Qid: 2rWh1qS7zw893yv7Gr
X-Iguazu-QSIG: v=2; s=0; t=1689644960; q=2rWh1qS7zw893yv7Gr; m=ve3ubABDjIkmvodjhT2QbKUSG4yhE88bhs8JLzDbyeo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 36I1nJb42466432
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 18 Jul 2023 10:49:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOQGdyatLlCfXffwyC81XpGRAP5jH+DN+Qkvg+o8gITm/0300Wkae++vAFdNlDO3c08ox6UAw07irBGFX8hor348rKKGVHXYJye9+2DnaWQ5IJvnOsKHYujkE6fCOhjIvp8ZLdQGvL7R5Kb2vWfxM0j5vqjw6xa9mnQGDbWOFRpayHYPQJeljTjZEIpCzeCCaGGiQIaxiFt92LntkhZMY4Mif8C2IAHVrfOG613Ke9Qwg9sKLOnXW1GHBzvWRCgrDuN8PL5ihwQ8jxF2v/W04XRCJ1BVu4lF8G/qntCKemvh9G+ekW/Nddrbv6UtIn369dIG0kx0LSLKtMY7MT/qaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqNMcYrKJyaiOl2wSV+E8SpDJfhnLWwSfQPSTfv/UA8=;
 b=HOLSTeLjNfd79qXCSDb+Mw4iIxRJlUlZbIk50ViW7lwSzKy7BByIBB5u1HTjM+lYMLUeDKkOeQExpy9XeuXIciDdshTNIzCRLr9ik5MO19iZc5sIFF8cU2zL7/P5W5dHBWfF7pFDZypYybUq4CNaiv+Ps6z9zCsjTJKT0L1D7KxmGKwb3IcyVZ057oMvV57SuJlF/0dyqiiDGQL6vhRFHVu2Z6kLp35wCOgNNRR2SUe7h5uKckdfUuli4j+aE2pW+b3zwmL2k/BgWGFuiRYNQp3xhBCL6lwCjiX8G/ggUNNDVjL2YYWtDat3hbXhXE2jT+7sYe9PklBQLJtYpPkRsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <Sai.Sathujoda@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-kernel-config] 6.1.y-cip/arm64/qemu_arm64_defconfig: Add
 nftables configs
Thread-Topic: [cip-kernel-config] 6.1.y-cip/arm64/qemu_arm64_defconfig: Add
 nftables configs
Thread-Index: AQHZsuomoikBxkLOskm2+sC00L4y0q++zVlQ
Date: Tue, 18 Jul 2023 01:49:17 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420741B81997C22E9253D839238A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230710045106.4117-1-Sai.Sathujoda@toshiba-tsip.com>
In-Reply-To: <20230710045106.4117-1-Sai.Sathujoda@toshiba-tsip.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS7PR01MB11836:EE_
x-ms-office365-filtering-correlation-id: a7a5f9e2-90c1-429d-42a5-08db873132a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 z5HRdTDsIfSSH9pmJ61w1F1Tq+LKovKvBhBZ3JbNZVdkk1fMSUjW7NRsujtQedOYNO3T4FQiWIRbb0xHKtm8+aAyDphM66Mi/XtL8p4eQ+QKtNWlhDjG85B7lwdNqG+z4nRbLRRMxpBdkx14VUCB4nD/YPD60cdMN1fBZeAdjRTDhgBYLHc/KHw1lqb2UOX8EIs2NcdghcpiSbMlFk0ZCx7W9idsNST4Kt1TUulIZ8u8T5fxeEBx9kmpuVw/QaRQh4xjQzdY9VlyBpuDix2+XYikA1BxyElTQixokZsOG1ThVaASuK+gGwi7BBmETrQKMFH7pXUAsVMhpNddat/Xjc/ljnT8yJIDO+p1DgHSOhLpdJ1ngz4J5JvKKlhjmHH7gvajwLVsobKSgnYFUh0zV37s7D/wdO8hywS4ubPlakRadiuhzmm3Y10cpA+3SPWyHqT2Bc8bicYUtH2W4H07fpmGmosahuYls2NIpjzgTTRqFApdjgypAA5UHvI4V5nEeB/ADfVqi6x0g7jRj0Xv48nINmCalhhr4pNlzSHZTt0EnP1/ssY2vY80DKhI0ed7r1Hl6GTHmGc6Zh3tF805mxfrfomrClOkFpcxjUs8T2uKJ5Oj18f1rAyhwBRTjTazbrMrZZ2tgjSnD0NWI40Ceg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199021)(478600001)(71200400001)(186003)(83380400001)(26005)(6506007)(107886003)(53546011)(9686003)(55016003)(41300700001)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(33656002)(4744005)(316002)(2906002)(4326008)(86362001)(7696005)(38100700002)(110136005)(54906003)(52536014)(38070700005)(8676002)(8936002)(5660300002)(122000001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?d0M1TEx1QWU2bmtYNGpuVlNoS21GbTBiNkRMdG91a2l0NkRObjVpRzdk?=
 =?iso-2022-jp?B?TW1VamhYODVLbUZCeXRPSVF0NnAraU1uVjA0NHp3eSt3VjNIUTBRK3JC?=
 =?iso-2022-jp?B?YS9NUUF4TWl5UFJLNEhQbXZOa2Jxbkcwb0xSSGxpVFg3ZFVLSGU1eGFP?=
 =?iso-2022-jp?B?U2xrWnZEcGNVZXN2MjB5c05ETG9rOFFqY0dhZjEzM0lwazgzdythMDRl?=
 =?iso-2022-jp?B?eE9EMFl1RmZhdHVaN3hXSjkwQkFUOUIxWUo5NGJCc21uWWhEdm5EVndw?=
 =?iso-2022-jp?B?Z0JTdUNIdGhvdlk3aStMSTgzRC9CaldqbHlxL2RwSGxCcXNzMkJKNFR2?=
 =?iso-2022-jp?B?Q2Y3bSs0WWpzUytXa29Pd1IvVUw5S2dCc2VxUTM4dUxENkxRRDlSMDZp?=
 =?iso-2022-jp?B?WGNnc1REcHZvMzVUaXhld1NsTUtvc0xycUppM09XSy8zZ1B5ZTFWSDA2?=
 =?iso-2022-jp?B?c2lPRENOSWs3ditBeTU2NnFLc2RSdUJXY3MwS3hibFowYVdtdG9kWlBH?=
 =?iso-2022-jp?B?VzJPU2Z1cms3UUg3OU1rbXFNRFFWdnpRYkt4dmdISkxIUmtqcnBpMENS?=
 =?iso-2022-jp?B?bVJ1RGJVTjVES09hVjEvUld2OFIvVHJia2xib2dEVmVKOEdpTUY5SDE0?=
 =?iso-2022-jp?B?cXZOR3hFUm9PNXU5Q29sczNQOE8yTFUvd1NKYUd1NW41ZERBS001MXpp?=
 =?iso-2022-jp?B?SHVEZkplVkdzUWNLeXZxN2RHOHBQYzFYTk5heDA1cHFZdEowN3E2M3Rq?=
 =?iso-2022-jp?B?NjRUbGxHakhqTGgvdGRuaWJPY0txQTA3VGdzWncxWGVkOEFZTWNsSFJt?=
 =?iso-2022-jp?B?aUNObnR2SVRNZUVWMGYvMWljTTB6NTlsN05ZZDQ3M1lKNDhyeWVBeXN6?=
 =?iso-2022-jp?B?UDVmdzcyUGdDYkdkSlNxTkJkOE5kWnl3RE04ck1LVDNNK3QvL3RUTm5J?=
 =?iso-2022-jp?B?YW1wdDMyZ0VCc3g1WXh5bXNOdlZ0c1JoandubkpxckRCM24zVUdmcldX?=
 =?iso-2022-jp?B?V1dCcXVNR2srTUZDMWdVQjZsZnA5OGRZSHVQY0dQVDRaVE5XcXFVYTN2?=
 =?iso-2022-jp?B?Mjk5Lzg3dmdOWTY0SEV5QTdleXduR0JpclRjcUtvaThJakZCQWtoaUdz?=
 =?iso-2022-jp?B?ZlRXdmNOYlFPUU1qdzJhejZ5RU1nd2RZL1QvejR6cWtPTmJzZTRHMXZK?=
 =?iso-2022-jp?B?VnA3YzIyTFBSbXBJbTBNeU5mMVNHQ3NEMklvMkZJWnVpQWNZNDNSdm1J?=
 =?iso-2022-jp?B?VW1QaHVGck5wYUxSU3dwcXVGcXJnbGw5NnpITStDM1cvdW5Yd0ppUTJU?=
 =?iso-2022-jp?B?Ryt4a1hROTdJODczMU1nbWFnL3M4aVNlTUZiRDJXTXUwTEdUTjl4aFpB?=
 =?iso-2022-jp?B?bGRlWkRTUXBSMFN0NU4xdW1DNUhWZWd1eTNSczhUclQ3WUNLUVN4ZlRQ?=
 =?iso-2022-jp?B?YW1NZU5GWXJwUmtET2JzRk5sN0c1OVBEUTFldmJLZXlWK2VkamhMLzZq?=
 =?iso-2022-jp?B?VFBlN3ZlVDBKSTByOW5EVFEvZktqVEs5d09Rd3J6MmJBa0lkNXk3Vzk1?=
 =?iso-2022-jp?B?Q0FzL1cvNjZkRE1FZkNtN0VPN0d6eUtyL3Q1emEvOUNTQjlaa3FJZi8x?=
 =?iso-2022-jp?B?Mi9DL2xsOVRKUHRJbk95dCtzMjBLZGo2MWs0RG9FcHBtMnFxUFNqa1Jm?=
 =?iso-2022-jp?B?aHFRK0thNHA2Rm9salRmZWFUT2VXdU04OTJDQ1hZZmhFMUJKUlFyVGtK?=
 =?iso-2022-jp?B?dFZGdXAvbzVzek5Eay93S1dHSisycEg5bjJRTlZaaGplM2ZoYTZIR1dN?=
 =?iso-2022-jp?B?NVRjdDROM2xzS0hoa2xEaThuTDdFVi96cHgwUk1Va2F6ajM2R09HRVNy?=
 =?iso-2022-jp?B?b1IwRzZ3Qlp1S3FiMWk5dkxReThKbTRjb0pYREJDSGg2c2JYZzJXRExH?=
 =?iso-2022-jp?B?d3VmVFhGdFNTUVpSU1hzd0srUFRKRjdYUkJDOTV6ejNxRlVDeFFaQUoz?=
 =?iso-2022-jp?B?WDUrWjVHL3drK1k5OURtcXRSTEIxUTlkSWNONnBDV1k2Z0VTakxORDFS?=
 =?iso-2022-jp?B?dDB4L2pjSEdxeTRxVGFHRWIxRWpleTNTNUZubFA1N0pGaVRFaXlSWTFZ?=
 =?iso-2022-jp?B?aUJJMU5lU3Znd1RJYUNmcUY2RVhuUmFVdjBFYThIMTUxWUV4SkV3RTcw?=
 =?iso-2022-jp?B?b1V3dDdsN3gzRTlQMXdpb29lN2RwcHo1L3IrWldnTG9DUFJ6bk01NHRy?=
 =?iso-2022-jp?B?bXJyOHk0K1RXb0lnUlFqWWJiWEd6THVPNGV0eEYvZ0Q0T2h3T3d5L3cz?=
 =?iso-2022-jp?B?SndxbzJsRUJCalV1MkdvVmJISU13aTVhZ2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cbLPXF9NxxDG0KoCgr0esYDNfvMxzI4L7sE3cQn64r5n+UzuP7EmQaDb+OjA+qHSdPER44rFssqmj27WBdTsbJqyiVMWaOPQxC8RGNAG130dxR1vwnULG8i/OzsBgvvxy8wTYro2tGKcPzDuvLztq0603bDzPI/+z7xtBG5iisaf3CJU4hCszvA70bisyqMdUNOHoygT4nv4524w9vx8cz0rrs2yJAyrHNSzciF6f86nqTres5HkqM7OHWIthwUOblc+ALYFLmcQtqYxQ0yupk5b5yo4AIzmOaBBzG4kLGI0ZVdfN1EusRZwn6/PML0M0z+z7XI4RWNDlUqsbWXWIIftpnjIHDZfvvwd9IHa6OuS8ufHMWz9Up2p8moLde+O0N8agYD0YbrIv9+V26YBvOXJNjtgcuoI8AZLiAiaYAppbUKcfQm7WPa6oAhPQFZnjiWCC6RIZc7ioXUJr8l22Flnuc0vpcPp8Regy7YNU8m69ua0paABtuFXh+aBvnOx3QOPMqe69SnX1/2vYr5keyYfa7zLUp99g77XPph9nfA31DDG70ZRS4y46cCjUpejpJ8PL3WuH0+SiiNsfzQmkHaZXuRMMMdoEABI1BnbjNWp3RRD1bjO/fzLS4qOwlAKI+90Gm3pzbvC4AF+/LMR8cvOkbKmgEKqhn4dyg+ywkHnjqvgb3SxVH5fD9NFGKshTLB8uqbzLhO0U6AQE1wuFdDU8wrtR/CD/Zn5ijphMiJxfM2qfqwIxPBf+sHT0zENttPtA7324LJIlqR2pvj9E6JQVYFznPUid4iCDs+Q05zFVAR5pI8VGSexeBAGjVFl
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a5f9e2-90c1-429d-42a5-08db873132a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 01:49:17.5820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0wOOWERsYFEC2fZpoMzE3AawDZdWvAVBA6h8Qt5VbTmcaNbaB0Os/zu3v6bNaympVzO5qBASEJAqn2G07XEWZFX3tnLe9UbhlpzMO0lNNehAoIa4c4uGqDgo+wGBd6q4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11836
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 01:49:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12374

> -----Original Message-----
> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Monday, July 10, 2023 1:51 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; din=
esh
> kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m>;
> hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I=
#G""#M#P#S!{#M#P#4=1B(B)
> <kazuhiro3.hayashi@toshiba.co.jp>
> Subject: [cip-kernel-config] 6.1.y-cip/arm64/qemu_arm64_defconfig: Add
> nftables configs
>=20
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>=20
> These kernel configs are required for nftables package to work which is u=
sed
> for IEC-62443-4-2 evaluation.
>=20
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>

Applied, thanks.

Best regards,
  Nobuhiro


