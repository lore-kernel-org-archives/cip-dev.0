Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04328F531FF
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 03:25:55 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11008.1776223544008544967
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Apr 2026 20:25:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=bjamy8q3;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1776223540;x=1777433140;bh=eFOMIh8kOBQDtBA+m6kTVZxTyNwtslQWdoorU
	xlGcsY=;b=bjamy8q3+f/8hc9JI9cOppbtHVp+q190V85LIyhTETWBcNwho5+A3oZhM5kcXuK3bYA
	wUjXFNdFDqbP0AacMiHkZxEnBI58Rxc5dQvN1r4w/3+enrgnXuNSSLq1x5Sp5Xo3mlEePM9QDkVGU
	eAlDY8dZcyH0/hWHFVClKG4aLGg7z3l0kuORTbyeQIzgfm9TumgdIHPKjjYnM0v+3h/zTZQXZ7AqH
	7K9+nOn+LCnFxZAAeqJd8UK9biZfvTGTSsy+6Zo/vmATr29eXqYvPHRZeaEyE+hlOX33C93etSEqh
	7NadhNzS55cMwotFVxQ7zrFTJ3Sb4e6BkHzjKfotLpSw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 63F3PdtM2046350; Wed, 15 Apr 2026 12:25:40 +0900
X-Iguazu-Qid: 2rWhZwovGzXyYYfBmV
X-Iguazu-QSIG: v=2; s=0; t=1776223539; q=2rWhZwovGzXyYYfBmV; m=M/wSwwihZhbA0d5bRh4r8dOQt+XmTg75Xi+TBQcc6oE=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fwRNz1gHFz4vyq; Wed, 15 Apr 2026 12:25:38 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdOOxPAjWZM5syLSFfa42vJu3pZnYJ3BLBYu0ZrQ/7xKtcqKKMScN2Bo1G/fIyfVb1DQUFNnGURdxTmUWlbKU/mPavSuGcQdlmm3dpj3cK34gKuNoD371ffhw7DTABikUiBjM/JFJf68YSbCgCxPeGaJd4Hrm34Ad7OvkSJ0uan6tqAfRACOMuOb28zJOvijgzDETetFXmv8C4eFKAqQMyCkyn3Mhnz/nOOWh9DdIeHZ72CUcUbQyLlrXQ2C7joRU+9HZDAAR3DGFNsYBI95Ds00RQpuqc14PPdHvVLvsd1sxFJKwioT/n+Nq6G6UelG0mzIG0DRz3r2poPYXa4uvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPz4C7YTrSY+nS6bDxph68BG/9U25/w7FR8poal+/oE=;
 b=O9rNn1Meo/30GiJFTloQlO8GUsa1zYlTatRu8JaYZaoye6gkstHsApMeT/4Kw2IufebGaIiH9Wb3wbjNn6C3tp8IrXxnoPOxeXbAgPZ5d81SfcCLVL9ZLTKEGFyG927StTPtpLSKIee8VFIAVXsweFqv7cVR64MC0zgHJ39I3mh/CDkx51BuqnG9lW86Drn2oDfLOOmhyfhmhvcwOgdsTs8KyoAvffYEp9rTw7CEi/Ty02BcH2a40ZyoY/ZWGLRVtaMJB2TEm4E00+hGEIEL81hGBegFS/kLHsr+tE2GLIyAdfQSNXji0WJbbuB0bki1l8USk+e2PYjNiwN6ZzrSiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <jan.kiszka@siemens.com>,
        <cip-dev@lists.cip-project.org>, <Chris.Paterson2@renesas.com>
Subject: RE: [cip-dev] [ANNOUNCE] v6.1.167-cip53-rt29
Thread-Topic: [cip-dev] [ANNOUNCE] v6.1.167-cip53-rt29
Thread-Index: AQHcy3ypLq83ZRqzC0qXoORKEnl0OLXfd6DQ
Date: Wed, 15 Apr 2026 03:25:36 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481834575A4B8D42F262AA35CD222@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <ad1FXBucvcGYi9wc@duo.ucw.cz>
In-Reply-To: <ad1FXBucvcGYi9wc@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB14717:EE_
x-ms-office365-filtering-correlation-id: b4388df4-35a4-4e4a-93f3-08de9a9ea90d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 
 e5B7QjeUwBNfPCTtA4pT24mF4yeOYx/QhnZp8MNV6fH1PCCsSAnmc8TzcBIMVtjk6ragRs69kTsHaImqHY6Mw5z+Im2xjMXMQbzJI0BvXUTFeR5QFDuuMLDoV9n8PXIGZ+NwtcgqdMF0REs60EA+v6dPnglXIxPhtvCR3AwmYFnGg8h2EY5jqt4HE9IgSwrxFweJzEmusDunzwcpsTBurpzrlm3G3hCNiuRmzwFOTKlMd+P3H9u8W6CdkVpwZFGtoP+bs9IMMqiSgAgB5d6urJyoem/JsMi8oZWjPDs6wvWtXU5lqz1axp7ZWz0dUMXcVhN/0FTQl8Qq30TrWXtD1WMYJEyqVhHLDSrEvBCZVWvmpDekk1aD9gFea1la1D/KO+jnkOuqzNipi4hKLDbuxtLpquaRH5j/cOA1Q26NeWIGqI0Bd82+p+mWt2yW7TkgSxIIsVjs0SXSZh1pf9/81ktFgsrJDxrAkL2wZ6feoAApZQ6fEuU3wJs52jvwXyNC6ESO4eXHhFEk4uLIsLV5bG5752I/EsbbFDPQp7KE7InsgvVpbj1YOAxM4J/ctIAy1mXzz8tqof0JAeq3UHvONC4phq9u5g533Sh5j+1S+GNcZOIP5r2nPTKCRfVeTAc1gpoaGmVd/nCpHo/yuukB6PTRulRGxczxjxjz70+koPQHKd+92d0mEumnduUV9+xwvsrqU/avmBqrOqN/fPoqnPK/swlgAWZvjld/I/H4oJI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SjVjWUlWTTl4TFh0MHBEOUdiL29PNDYyQzVJemlwMy9QekhjbFJSRStq?=
 =?iso-2022-jp?B?UWVKV2RRejNSalRNVWZFTzJscFZKQTV0MTJRQzQ2d001bmorUkJNYUVI?=
 =?iso-2022-jp?B?NEw2eGtRaHJtZDR5YTY2MkI0TDhzbFQvakcwMDJTY2ZDcXJ1TzA2QlNw?=
 =?iso-2022-jp?B?VDJ3RGRjaktSYWpBMEtDczZKZWZrUzNGM21JZnlseDQzWC9Ua0kwVGtS?=
 =?iso-2022-jp?B?T2djNEhpaTU5WXh5bXUycCt1WHFidi9SUDF6RkEwQ2llZXJ2MmdveGFm?=
 =?iso-2022-jp?B?OTZSdldEZVRvbTloeERvdXFQUkZ2Z0I4N2VNYVErWERQMU45c1l0MWky?=
 =?iso-2022-jp?B?d01TWDVuOWM4bnB6LzJYdFFqbjgvdGMxWGxvbWNpU3lKeVc0d3lLNGZL?=
 =?iso-2022-jp?B?Q1NObE5UbTZNSkhCMG01azFOcmEydVNMM0FDbzZnMG8wakJkTFA5bVRY?=
 =?iso-2022-jp?B?R1RGVHZTRFFzNHdacUk2NXo1cWpBYitwRjc0K3dTY252YUpxL3ZSWGJy?=
 =?iso-2022-jp?B?T3ZVcGdqSWw3VlBXTXVCaXhHc3N3bXVMYnVaeDRPQ2EwZW1pV0VOdHFM?=
 =?iso-2022-jp?B?VEhxV0NsRnY5VkEyK2NPSzBZM0Q1NmxYSDJSZWEzN1J6ZjllMXBNcWgw?=
 =?iso-2022-jp?B?aXZPdmlzK3c0RnM2Y3pUek82RTZCclQvK1IreFV3U2JXVDZwTEFRcklP?=
 =?iso-2022-jp?B?STNYWXc3L0hDaTRzR1lONEptK2pjM2p2cmJZY3FESEw4ay9ramF3diti?=
 =?iso-2022-jp?B?NGpaTDd3aW1wZW9XR21pNitQQVFZWm9JVkladTJIZFM1OGwzanJ5dUE4?=
 =?iso-2022-jp?B?QURBSURoZVQraVR6a3hhKzhIMDF1T0VWdTg5T0pQY2dvNjJqSW0wVFFI?=
 =?iso-2022-jp?B?QXVpajl5ZzgvczZFZ1gxSE5PNWw3bDYwMjB0RmhWZ1RYOFVNbGhoV2ho?=
 =?iso-2022-jp?B?bERScTlvaEF0eStSNENYQytQcGZIbnl2UnB0TnNreVRSakpRM3p0WU05?=
 =?iso-2022-jp?B?ZjNJU2dLQys0NFFUYXltU2FoQit2NDJJbFdtNEtRN1YyVzRxMHFseHln?=
 =?iso-2022-jp?B?czFjbDA2ZUdabVFTdjdxTUI2ZXp5VG1ScGoyNGE4dUZyVG9NOE1QL0Vy?=
 =?iso-2022-jp?B?OWJpRjhiNlIrYzJhVFZISmRKN0w4Ym41K3ZTUEFVZ0xFdXY5ZU9xOU4x?=
 =?iso-2022-jp?B?WFRFcE10TWdrRlNQVHMwWjNCMDc5L1FwUnBNMlpEVHFCZk52ZDJMblk2?=
 =?iso-2022-jp?B?MXZ1Nyt0TEUyRVpYbzFNTjVpRE1hMXdWckRpZFZucGh0bXc0QVB3dWsx?=
 =?iso-2022-jp?B?Y3hFSE5wR2M2QXpCcExwNHBUNnlEbHpiakdrSjUxUGkzMFJUMEVnZUQ2?=
 =?iso-2022-jp?B?T21HVnhtQTNsNWJQRSs0SFBUdkMzOWtIQ3cxWEZMRHpnMVdqb0pGbWV0?=
 =?iso-2022-jp?B?V0tGTFNZbHVwZmd5MmJnSzdCOGxsS2dLaW0xNEtZNDZWbDNkVitFVEVt?=
 =?iso-2022-jp?B?bW1aTWNJckpPK0RKMFlqZ2FmaHE5MTM1bXJTWExMaDJyZklyZkRnVlRU?=
 =?iso-2022-jp?B?eGFrVEtuVFlESmdSRkR4a1dUNWpKcm5pOUROY3JjMmk2NFBJbit3THht?=
 =?iso-2022-jp?B?TVhyM1N4VEc3THlWcEk1QkZyaDZIWFFnOFRSUzdOS0U4UVlydjZYMFdE?=
 =?iso-2022-jp?B?Ulp2UnFXVlpvdVlBd2czK2tRMXlNQTdSRDZRdTMya2ZTLytXZDRCdXlE?=
 =?iso-2022-jp?B?SC9KTFAvM0tRTlZKZnFIeVhmSEpQRWNLZTUyR3UrQkVJUHExZEsvbXZ0?=
 =?iso-2022-jp?B?OWJOWjNlbUgwY01KcndIaks3S0psLzl1VnFMVzdRK0Z3UjlSUkhXSVFP?=
 =?iso-2022-jp?B?c2hNQWFwK3dWQTN4aWYvMXNHQ2tlK1R6NFNTd2V3Wkw4NnVnaXNRdklW?=
 =?iso-2022-jp?B?a09uMGdYbXF0ZSsrcDdVdVhnQk01ZER1Z1Rra3lqVUs2eGI5T2VlVUc1?=
 =?iso-2022-jp?B?L0swTWlzREMvU2lpUHVKZ1U2MGEvc0Rzak9CbUNiMEFxc1FzdWRqTzZl?=
 =?iso-2022-jp?B?SUF1Z083cklIeXp0NFVTeENVUXRJNFo3bS9DOXF3cnk5VnJybFRZTCtp?=
 =?iso-2022-jp?B?TW85TThJRlhQTGwvNHNjdDNIVjNYaDYzdndoSUxwWHRkWm0walZ3QUtE?=
 =?iso-2022-jp?B?cHZTQUR1dEJ4YldLQkVXdk82THEzKzhDUUZEMGFSUFNVVnZxYm9EeGxl?=
 =?iso-2022-jp?B?MXVTeHF2Qk0vSUQySjNRaGxNTXFEVnBpTzJQLzNaV1B1dFlmbGcyNTR4?=
 =?iso-2022-jp?B?aVdsK0NvQWRwaUhhSVRGT2JFY2wzMmxwRE4xc0k4dkVsSWRWRHExREVN?=
 =?iso-2022-jp?B?S2pic0ExVU4zRWp1WHh6T0E4MXdLVE1HNkhnRFRFeVdYazRjR3RjZzhy?=
 =?iso-2022-jp?B?aHczNUw0dVhYeUQ0NzcxRG5TZ05yQnBOY2hoTXMzZ0FyZ0E0RnhBNTNk?=
 =?iso-2022-jp?B?bCs5T2cyaFgwN0h2d0liM0xqYWszN0dPVHM4d3FBU0dTenlHUjFiMTlB?=
 =?iso-2022-jp?B?SkpKYU03QT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	s1KEC7DtZTIYi8fSM14xpC169Cv1EtXgaRYHl472/HMPjk6P8r/P3b9+fhPxScybj/4r3lzt+NUyt6bZiBSf5gW6J6Ahmxr+Jps3mpegmVI94Xtnt8O0x7gEc4UTCJFVom3GyecSONnKLS4HjGzG3q9Fdde1DYgSq23/N2Q/TsJc9YLTd6RYwqs0Ai2e5fCqtPmAuNh52o6/4iAepnKsT6c8jPQIggLZZ6/owHvT9WZrC1LEhFXzNZDBgxSmwiWk/+rZP0JNe3T02oTVtbrQ4VEYdTrMPe3T9oo2lbid83rQ8S1r574aKeKzpYSjM3JTObJqI3LFkouvgAX/eiLwhA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4388df4-35a4-4e4a-93f3-08de9a9ea90d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 03:25:36.4812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Q/ECyw+n4IS6GIDMioHaWylHz1ixWMCl5DrtMEPPlgZ4sywJ8ZwiHuwbv0smQ6HeM+nRDePUHnu0Hl1OHD9SH8uORH1Q3kPIlke+r4oVt/QD4klhXGnPXhUcC+3Ubwn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14717
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Apr 2026 03:25:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22703

Hi Pavel,

Thanks for the release!

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Tuesday, April 14, 2026 4:35 AM
> To: jan.kiszka@siemens.com; cip-dev@lists.cip-project.org; Chris.Paterson=
2@renesas.com
> Subject: [cip-dev] [ANNOUNCE] v6.1.167-cip53-rt29
>=20
> Hi!
>=20
> New realtime trees should be available at kernel.org.
>=20
> Trees are available at
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinux-6.1.y-cip-rt
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinux-6.1.y-cip-rt-rebase

There seems to be an issue with the -rebase branch.
Could you please check it?
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/245020045=
0

>=20
> And their content should be identical. There are also tar archives, at:
>=20
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


