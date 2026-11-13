Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3976.1794604831665584567
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Nov 2026 13:20:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=Q23bwo+c;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1794604820;x=1795814420;bh=4T4CsBK5MpbIo4gmsiodDFXQT/jgCzd6PDFTU
	dygrSY=;b=Q23bwo+cCMaQd48JDnlrzfn4REoSnMRk/nxkE+3e0JhveaJ57J8VKDJHVtBWaU3w57w
	1eu1qaqz4unZYL00lkprm5hjW97XzNTpaa1E9kf3QSGvSRNud8Js6qpjyrDE7OlSIrmOHFyAmWR2L
	PSkwWefpbG/NYXW5zlx3VBKnep89b9gtNuAWWRncH62PrAl3qUcxN/0zhPfTr3avkKcOfpfdm1xDN
	2NVpNrCiVfeg5R7swNgiSfoZ0YsphvoX1ClHqw8imahA2VoCIVRq80w3qEzS+Mx/TEkqe7nKPEkJy
	3UiF4kKanSgLKP2HIuGJyOSs4lpfUFyaAEqoQhpt7HCw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 6ADLKJ8P3078007; Sat, 14 Nov 2026 06:20:19 +0900
X-Iguazu-Qid: 2yAbMSk5Kr2Gybddmj
X-Iguazu-QSIG: v=2; s=1; t=1794604818; q=2yAbMSk5Kr2Gybddmj; m=B4xTEf5B4/qfi+I3FDBgitPINM2qsA2vyNIh5SBZLW0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jR9C63KdQzyPQ; Sat, 14 Nov 2026 06:20:18 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IS9Xq3Qamt3f34NYt3CWA3YacKPAI2PMxayolrwYTUBpm9JTX+GKuXTb7mskP+Wd2FoFjGkB31KoLlCD9YdEutHGiZZCS+Y6uXh6cmZ9mOp12KKzOTMPd+6jwTrIOkNfN3VcaGP8Yprw0ApMuxnoC+St248oTOYUuXhI0UIT0WsPqBsDbYSiD/0KRDxtX7z2lwp6T7yNV4zhgRJgs7Z3m+q9ik5P+cFXUReO1SfJTcfbpkMtX58kOKeXwN5rYyKaPblkJNh+OXAzKv0EICMXmatrLOHsbHF6TDOsHzBSN0vJ8RxAxKevSwyvQjGISGW+U9QI9XHOsk3LUfGxDmRAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tt3VOa0NIgO1mWm+u83gU436IG4Ao1afmZx9njstQeo=;
 b=KcL4aQQyEvuwqhP4E3a7k2hMZ7i1IZnGMBEo/NuFRtY5/hqFAIZW1Tl21pFCgEt/QYPKqKTEbLSKpJ6uXu1Xv+YIZgspmUQPGq+vjIbB2l2r8E6TYA3iaZsCkwP1ydEaxKtz3bpxmDvgZzIFhqIRkOG1rkfkYxm1MIOvMFOoHyZ7fGLWkATtJWCNCbjs1WXsYEOLGwFTnPGZ2h+soN8IScC9wfzPpdgj+eghXAOtL3bkfHUBoWVxmfJj4lrBwztOgyxb698yyaIosJnrMzMQzfmPHqVY4MfEBhl+KeDF56hv/DBqHgtM+gcLZ9ZZcsVZ9m65gMJG38t1IwuZjwUQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@nabladev.com>
Subject: RE: Request for review for 4.19-st21, 4.19-cip137
Thread-Topic: Request for review for 4.19-st21, 4.19-cip137
Thread-Index: AQHdZlEYKcY9WpIK1US1ZZSa17qBnbcpe/xg
Date: Fri, 13 Nov 2026 21:20:15 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB1481861B94152E5B2912D7FB2CD7F2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1931298540.80350.1793132613065@webmail.strato.de>
In-Reply-To: <1931298540.80350.1793132613065@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB10064:EE_
x-ms-office365-filtering-correlation-id: d60e926e-c7c3-4175-da2c-08df41cbe930
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|6133799003|261009221727099003|261009220027099003|261009223027099003|261009223327099003|261009221227099003|3023799007|56012099006|11063799006|261102123227099003|10067099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261022075727099003|261021121427099003|261022113327099003|261022115727099003|261021130227099003|261021123027099003|38070700021;
x-microsoft-antispam-message-info: h0afApNgAWvRFy7tj7+nXPLwDttD9q4biO/IFDkQJDb1fS5kx5vL3hQulLkZ8rgBCdvOqFvFpiuSY4/QfT2OhVLak8R9sPWFPjYO3e2jK+1P6lZv6wcT+mB6H+FphpAoE9ihIdBAq0SPfKI2Ka11I/FL5K4Rhnp8Ujr03PNt7NLiu2CkVhnamBldsxZliB4IUF+VfMoi910jVC+HRoHGtoqSOgld7CbwCb/IklAumt+15cQqmd1QnCP9HQCmCvdz9ZlApTY9xHp7cVsBg4wSThh7DCdX07VpNtdwPj3mwLnsqaj6cWFvTdco7IkxrpFbWNQpq4cncH81bb4MusGwA5xOfX1UEnpeH1+xd4wYp/01tV7jHfhyU/bAQdjUc+cTAnWOHFw9miMOA9xQXgw26ObbcrAQgzGycvealEixR/V0I7nOTAbT9slzVa5VPC6/WXlZmxF75NzfTj//vqlUnkWG7GvMie3FPmuqtTJvhE1yI+pqXjRyWJ//kf3dZzozjuHDsWOMT3cAGEHVRMqrJyjNMr5MtpKfl9mU3Nkdb/hQRVPh5Mg9bsXZt5IgODEW080NxNnsx9rzwpOICO6lYcy1NVpNNT+CIPmb8nUV/kD6/xp/hwlpCqC0NZ7H/BHZblVpOt2FtbHTJKu8jHLTbmLe1uJxtuc8UG7ml5IBFks=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(6133799003)(261009221727099003)(261009220027099003)(261009223027099003)(261009223327099003)(261009221227099003)(3023799007)(56012099006)(11063799006)(261102123227099003)(10067099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261022075727099003)(261021121427099003)(261022113327099003)(261022115727099003)(261021130227099003)(261021123027099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?NjcyMTNGTzNwSFJXaGpqWUdsZ0tMM3ZPb3RxMmxUT1RQQWxnaEJHdTdH?=
 =?iso-2022-jp?B?dFdNREVPK2FPeUlCakVuZmg3TldRVGRQQ25rc2pVbjI3bkxIUDZzQTIr?=
 =?iso-2022-jp?B?RHM0TG90eFE4ZjIwMGp4Y3NkVkxyREJiMElIZURxenZqL1huVUl0Wk1E?=
 =?iso-2022-jp?B?eTVoWmhjc2hhVy8rQllUL0twVUdPcng4TThzMGJDWjUvVy9IU2tUQzR0?=
 =?iso-2022-jp?B?Wm52QmdBYm9nTjJjM2lxV2MxbHhIZE5MVEdSMDBPR3RkTFhFTWRUWEFa?=
 =?iso-2022-jp?B?WW8wL2ZXUUhrZkJpU2ZKKzZMSzZnbTBhaEU0ODdQYUhDN3lKQ3FEdmFn?=
 =?iso-2022-jp?B?U1ZXbnhlYSs5YldFOVNZN3ZNak9KQkMwRUJrbHRGazRiOWwrQW5ZcDFy?=
 =?iso-2022-jp?B?K3Z0V2J6dlBSVjlSaDZFOE1aWDBheW9aQ2tjQmdBMTRGRmhjbzZYeFZ4?=
 =?iso-2022-jp?B?elFibVlKbUl5RHF0Um1aTVVaaWQyRHgvYzVTOTJDSm5DNTBMeVlwVnFu?=
 =?iso-2022-jp?B?dThzenlzZTdrWmVTalVxZXQveHFhbDVHUDhodXc1L2krc0FpTE5JOEp3?=
 =?iso-2022-jp?B?Q3J0dkFhRnFFclNRTHk5ekhHdHlTTFpwZFZSTGpZRCtVS3YxWU1vMk1Y?=
 =?iso-2022-jp?B?RkM4VkgvbkhzS3p2V25hdk90ZFJxSmE1R0lqNnVZRTNNK0p2ZG9Ib1pR?=
 =?iso-2022-jp?B?ZXhXT1grTkg4NnhaYSt1RWFaUjFZT05IWU5PWEx0bXhCcExpQkU5RndF?=
 =?iso-2022-jp?B?Zk5kTVRZRlhIYVc4cjN3eStmOStHS0RITTczUmlRTm4vOFRZS3VsT2Fy?=
 =?iso-2022-jp?B?T05nRXc3Wm43LzJLQlVtd010ZmJ3N0hPcWExQ2I4blRpRXpQdE5sNFIr?=
 =?iso-2022-jp?B?SmFEb2dKMHEvWWI2czlOMFJIZ1h1L1BTemovQk96ZUlja2ExenlXYnpV?=
 =?iso-2022-jp?B?OXF4QzZOOVVXdXovUU9tV2RoY25RTzNaVFlGcndhYVlCUjRpZklvdS9E?=
 =?iso-2022-jp?B?azJUS1pCQmFsTUxlZ0hXaGs2akU2MzloUFhjYng4MC8wSnpveVdNc2dn?=
 =?iso-2022-jp?B?VTF2RHlpZDNHY2cxOGpUZW9zVGdleVROZmN3WUJIVFFSaGhrSnpRNFBp?=
 =?iso-2022-jp?B?Y2MyMmdTRTY0aVV5Q1VRYm5GdXNKVHgzNi9wTVY1cHpsd3VmWXp2MVJR?=
 =?iso-2022-jp?B?ZUhYZStiU0dwU3drVDJiRk9JMUVmd09NOUVoTlhkRlIrTEQzaVJtMU9R?=
 =?iso-2022-jp?B?ZjhEWHVBYnJYVkZYNlBsMGtwSHZyVnREK3FtMHF0UERXdHBjekh1ZlBh?=
 =?iso-2022-jp?B?NW1zU1I3aFZOVVkxNEFqOWhoUkJjTkpzUXhYTnJEQnNvWG9PVUt1RFNh?=
 =?iso-2022-jp?B?V0JiTkRPbmtTZkVORnl6YnNRMXVDcmpWc2o3d2hkRExuL2pKaCtUZHEv?=
 =?iso-2022-jp?B?NGd3ZVFBSmNFZGNZeEJrcm9HTTZ1T1ZEL1dpcVprbi9hZnZ1Zzl0aUkv?=
 =?iso-2022-jp?B?YWlLdzl5dVVnRjEyRmVEWm9Ld210dUwrd3E2L0FhUEpEam9UaSs4NUxS?=
 =?iso-2022-jp?B?NkU3UVJlMHdBQXZ1dGxnc0JoVk9xRTdJQVpsbUN2QmxQZTlRczQ5L3kv?=
 =?iso-2022-jp?B?cVR6S0owVWJKQ05hWElXSUMyVGNla0dPSTExcWJjY3RKb2hCNTZqSk0r?=
 =?iso-2022-jp?B?K01kWjVpNFN6ZVljYlVON1drcGg4N1hGZUtIOEFTSUxlbVNyaFYyYVdI?=
 =?iso-2022-jp?B?eDBKdkJueGdSNjE4SnlURXN1MVM0MUEzVmNFVTNDNEI2MnR0VzhUMFFU?=
 =?iso-2022-jp?B?RzNFeGVvVTBPWVJOWWJKc25CYVoyT1pnR2YxNWVSMkJreVJzMSttbHhz?=
 =?iso-2022-jp?B?TlpNUnluTjRnam8zdGswT2RtMlhhbXhvYlhXK1VsQlVoZTkxekxuUHh5?=
 =?iso-2022-jp?B?R0FnMk9SY0VuWjEwVmlObHpsWW5SU3dMaWVEUmZJeWxKdXcwNVZMbXNO?=
 =?iso-2022-jp?B?dnZyRWF3VXN3ejAvMjVQRHZMbzVYWVQvT010RFk2a00yeWd0cFNZN1Zw?=
 =?iso-2022-jp?B?cTRQNkdaZENqdy9OZWVEOEVoNzNITjB0VEZzVjdNTTI2aXNYM0hpYVFv?=
 =?iso-2022-jp?B?enJLVWg4dVdtcEN0dGVUVlBsL3I4ZDhpWWVQM1k5NlJhRmFNMWtOYmZi?=
 =?iso-2022-jp?B?VHpyUVR3Z3UzYkQ0YTh2REU3c0N6VEc2NXdzNHZwRXZSb2ViU2ZXOSsw?=
 =?iso-2022-jp?B?SDZoU3FuN1RETURiQjdOd0t4d3B5SlNTWnBVRG1IdC82UGZIYTRIRzN6?=
 =?iso-2022-jp?B?K3UrRjRoR1diaEdjaWYxK3FKTEFoZlYvc3dnVW45d25wcVFEOHpLdEFL?=
 =?iso-2022-jp?B?UWx5K1RTZkhzNEUxMVR2QWFxb3lYMDl6RG9GOWRGY0RjUzFhb2l5V3RN?=
 =?iso-2022-jp?B?RWpCRzBpWUZzNGxWWThla2FGU04yQVhzMjBtT1YzVTdwNkVDRWRrZHdR?=
 =?iso-2022-jp?B?ZXZjVnZVV1NJMlJ0RVJPQkpmdW15dWxhSll4QlB2eE04b0RYTzZWRWY1?=
 =?iso-2022-jp?B?YjVTRFdpMD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P/PC0xxz+K6esh8bAEC/cHz+xpk7k8GlEhs39gAfOg/kS97rRm1Ke0Vqyt5MuiMplNlH8CD+Mk6Ww1UCNRzgXHNGPUEcs2AxkGRezE8jo7KKCdvfspbMob9FnLPNfW+jtR+DxbYS0aFPHZ7ajv5E0LPSQQdkUkHKMKPUElsfNLx8p9cgQQNSSn6sNGK4f/BznBmxVc0JVqmyYsswI+0LKOlgkD8Fxz3S6Pe+PvGIMFCRN9nzYDTwHpWI8UZfobIQN5/gH6lPhAYxfKQhsrxlSEW+zDBExF5WgvEO+JXpXuQpCtsg7DtJF+/m4Lj3rnLTTDKkH+s8k8u1slCSms00vQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60e926e-c7c3-4175-da2c-08df41cbe930
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 21:20:15.6214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HrXo79iDF4sLB/UIOzvJ02R8plsbKL/OV+E5FsZxJeHVxfQ/38fNbW9wdF4sl6Z6x/bOLwBhJdEsqJIcEJCz/Rwz1XAppTwtVOSd9KAO3buOWDv99yBZUGbYnEsjstWn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10064
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 13 Nov 2026 21:20:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24802

Hi all,

Due to the recent issues with MS O365, I was unable to send emails.
Although this has already been released, I am sending this reply for the re=
cord.

> -----Original Message-----
> From: Ulrich Hecht <uli@fpond.eu>
> Sent: Wednesday, October 28, 2026 5:24 AM
> To: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d=1B(B
> =1B$B>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwama=
tsu.x90@mail.toshiba>
> Subject: Request for review for 4.19-st21, 4.19-cip137
>=20
> Hi!
>=20
> Here are the adapted backports for the upcoming 4.19 kernel release. Ther=
e's a
> total of 95; 1 written by me, 2 by Qwen-3.8-27B and 92 by Qwen-3.8-Flash-=
Next.
> (The latter are labeled with "Assisted-by: SLTR:qwen-3.8" and "Assisted-b=
y:
> SLTR:qwen-3.8-flash-next", respectively.)
>=20
> As always they can be found in
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinu
> x-4.19.y-st-rc
>=20
> 0f9dd2fd36dc88 ipv4: validate checksum_start before completing checksum
> 1aef1ed67bf592 netfilter: ip6t_rt: fix zero-address non-strict match
> out-of-bounds read 1772d2f27fe10f net: openvswitch: conntrack: avoid
> modifying shared unconfirmed ct entry
> 994be280b21cd2 net/sched: reject IDR error pointers when deleting actions
> 2548133fd1bde9 drm/nouveau: Fix gem reference leak in validate_init()
> 893066ca3560ef drm/nouveau: fix double-free in nvif_vmm_dtor
> a91fd56ecf47a4 gpio: zynq: fix runtime PM leak on request error path
> b78ecf68a5560d ipv6: sr: enforce exact attribute length for SEG6_ATTR_DST
> 28db7b5b3dfc9c ipv6: do not let ipv6_find_hdr() return an offset past the=
 packet
> end
> 59c0dbc48ea5e9 af_packet: fix integer overflow in prb_calc_retire_blk_tmo=
()
> 7582eb829827dd drm/virtio: fix object leak in
> virtio_gpu_resource_create_ioctl()
> 5fc852076e0f08 drm/virtio: fix object leak when drm_gem_handle_create() f=
ails
> a27a4884b8c4af ipvs: revalidate ihl before icmp_send
> 88588102ee3ad2 bpf: Fix out-of-bounds read of rtt_min in sock_ops

I suggest including the commit ID that references `SOCK_OPS_GET_FIELD` in t=
he commit message.
It is likely 9b1f3d6e5af295a72deb5e3f04db07a6a58be72e.

> b9027a1c10a535 i2c: at91: release DMA channels on remove and probe error
> 3975c809ff001e net/sched: hhf: cap hh_flows_limit at change time
> e37dae2a4576c5 net: lock the socket in sock_gettstamp()
> e1333865998044 tcp: do not let tcp_rmem be set below 4096 ffc922c95d046b
> drm: Fix drm_pending_vblank_event leak in error path for out_fence_ptr
> cbf63e3778be51 netfilter: flowtable: hold reference on ct until flow is r=
eleased
> 2f3223465d9893 dma-coherent: report a failed reserved memory assignment
> cbb22c9ad14604 iomap: iomap: fix memory corruption when recording errors
> during writeback
> e081a6b8380337 fou: Fix use-after-free in fou_create() 15dca0467fbc1b i2c=
:
> smbus: reject oversized block transfers in the common path
> ad002df2ef4324 ipv4: fib: bound automatic table ID allocation 36d5575a8ba=
ded
> net: mpls: clear inner_protocol when the last label is popped
> 0eceef464ddb41 cpufreq: initialize policy rwsem before sysfs publication
> 7a85d5bf37497f cpufreq: zero-initialize policy cpumask before sysfs
> publication
> f33862037392e3 macvlan: inherit needed_headroom and needed_tailroom from
> lowerdev
> 8c7a3c69bd6c75 drm/amd/display: set new_stream to NULL after release
> fab55095a265ba net/sched: cls_api: Don't replay RTM_GETCHAIN in
> tc_ctl_chain().
> 7dbaf7cbcc17f2 bonding: use skb_cow_head() in bond_do_alb_xmit() and
> rlb_arp_xmit()
> c991dca2b3c361 net/sched: act_api: budget all shared attributes in notify=
 skbs
> 7d08f3c8750eb2 drm/virtio: Fix a NULL vs ERR_PTR() bug in
> virtio_gpu_user_framebuffer_create()
> efc263c2c0b10b wifi: libertas: reject short monitor TX frames b32f72a2057=
95a
> xen/front-pgdir-shbuf: free grant reference head on errors
> cba01a9b47aaf1 net: stmmac: xgmac2: disable RBUE in default RX interrupt
> mask
> 7a599b7230d280 wifi: nl80211: Increase ie_len size to prevent truncated I=
Es in
> new peer notifications
> e6c0bfb715a6d7 ASoC: codecs: pcm3168a: Drop CONFIG_PM-conditional
> preproc directive f6c6a70da060ea rds: filter RDS_INFO_* getsockopt by cal=
ler's
> netns
> 98f4c9eafa9d27 scsi: pm8001: Reject firmware update in fatal error state
> f0a0787eb48b2a thunderbolt: Set tb->root_switch to NULL when domain is
> stopped
> 6fe4d16722f049 NFSv4/pnfs: key the data server cache on the NFS version
> af43e84cb9da3b NFS: Always clear an invalid mapping when attempting a
> buffered write 5b5b707281db3c lwt_bpf: Restore reserved headroom after xm=
it
> program
> 05fef2249c1be1 firmware_loader: do not queue completed sysfs fallback
> requests
> 81db1e6ec46877 ocfs2: synchronize heartbeat callbacks with o2net teardown
> 7383d078e76942 remoteproc: fix OOB read via signed offset in
> rsc_table_for_each_entry()
> 3d73e501fdc537 perf intel-pt: Fix off-by-one in auxtrace_info minimum siz=
e
> check=20
> 1b1ebee1d17f8b tty: clear cdev pointer after cdev_add() failure

How about using this commit instead of modifications?
c3b5623fd97648f2747444aa8932ae604662df93

> af6929005c4a3a serial: amba-pl011: unprepare console clock on unregister
> 6434896a882257 wifi: mt76: mt76x02: do not WARN on invalid rx descriptor
> length
> 65d7661a2a2887 locking/lockdep: Fix NULL pointer dereference in
> __lock_set_class()
> 9590d724daf3f2 remoteproc: Prevent crash handling to race with rproc_del(=
)
> 1d2cfeed814ebf power: supply: sbs-battery: Use a per-device serial number
> buffer f535e3674afd1c RDMA/srpt: Pass the mapped task attribute to
> target_init_cmd() d7b349ebdfdafc ASoC: meson: Keep link pointers valid on
> realloc failure d38f463c73bccc tty: hvc: restrict HVC_DCC to ARMv6+ and
> ARM64
> 3f78220d000d94 xfrm6: fix out-of-bounds write in xfrm6_input_addr() when
> secpath is full
> 1b1bd4efd7d8a1 iommu/amd: Prevent SB IOAPIC from overriding IVRS
> validation errors
> 05c7c199894226 soc: samsung: exynos-pmu: fix of_node refcount leak in
> exynos_get_pmu_regmap()
> 4939afd8061ba8 HID: roccat: bound device-supplied profile index
> 3c1c45a994001e bpf: Enforce expected_attach_type for tailcall compatibili=
ty
> efff42e7625928 tcp: clear sock_ops cb flags before force-closing a child =
socket
> e8453ec6b7f770 xhci: fix lost bounce buffers on TDs spanning several ring
> segments 8eb84d0751f98b drm: Fix drm_crtc_commit leak if signaled when
> PAGE_FLIP_EVENT is used
> f0e7e4f141ca70 scsi: qla2xxx: Zero SFP DMA buffer in FRU/I2C bsg handlers
> aec9df1263875c batman-adv: dat: avoid unaligned fault in IP extraction
> 53a94e6cc49ffe mtd: rawnand: validate ONFI extended parameter page
> sections c8846b93ddcb6e HID: wacom: validate report length in
> wacom_intuos_pro2_bt_irq
> a8a753f7fc41b0 scsi: core: Fill in DMA padding bytes in scsi_alloc_sgtabl=
es()
> 303a77ac1be15b selinux: reject an unclaimed class value in
> security_get_classes()
> 4fae216b4a1760 tcp: fix potential race in tcp_v6_syn_recv_sock()
> 393c2ca46a3b27 fsnotify: Fix stale object mask after concurrent mark upda=
tes
> 83cb9c25f3391f openvswitch: Fix CT limit teardown use-after-free
> aeca4496f07b9b netfilter: nf_queue: pin bridge device while NFQUEUE holds
> fake dst aea3fa3f950c8c net: cap advertised IP tunnel headroom
> ce12d5b2bdee84 net: openvswitch: fix flow mask use-after-free on flow
> deletion
> f139bc5bef5bc9 power: supply: max17040: synchronize work cancellation on
> suspend
> 7c74c8f9a71e98 sctp: fix stream->outcnt underflow on duplicate RECONF
> responses
> 7869f195dfe0a9 SUNRPC: harden gss_unwrap_resp_priv length checks
> d93d0c0458686d SUNRPC: harden gss_krb5_unwrap_v2 against short tokens
> f57c93fdce94d3 SUNRPC: Guard svcauth_gss_release() dispatch on
> rq_auth_stat d10d5ffbde1f9b sunrpc: route to a populated pool in
> svc_pool_for_cpu()
> b86a2634b755b9 nfsd: add fh_want_write() for early-verified SETATTR in
> nfsd_proc_setattr()
> 3af3a1546df5c8 ALSA: aloop: Fix racy access at PCM trigger
> 3a1fe75c4db943 mm/swap: reject swapon() on filesystem-level encrypted fil=
es
> 4084800d553361 selinux: switch two allocations to use kzalloc_objs()
> b29f321b90465e ipv6: mcast: Fix use-after-free when processing MLD querie=
s
> 68018695bfef2c xfs: bounds-check buffer log item's dirty bitmap
> fe55a808ff6078 KVM: arm64: Retry fault if vma_lookup() results become inv=
alid
> 9ef244c1264489 inet: frags: publish queues before arming timer
> 9779b445f542b2 packet: synchronize pressure clearing with ring
> reconfiguration
> 86ce0c431c5480 net/sched: reject overly deep qdisc hierarchies
> 13115d704fea78 serial: amba-pl011: synchronize DMA teardown
>=20

I reviewed this update. It seems to be ok.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro

