Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A5AC71136
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 06:06:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.24059.1750053965428933730
 for <cip-dev@lists.cip-project.org>;
 Sun, 15 Jun 2025 23:06:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=DqvBHjNR;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1750053955;x=1751263555;bh=rgfpdefgy/WmKnD0F0ChQ1lEwURBgCnAFmhJmim
	3pnY=;b=DqvBHjNRqLOgOju7jRwgXYdqHMtLmwGC6rLZ0RurN5ce30mgNsQ0jeRvUt3r5Qwu7yuzc
	2ySCmvuTfXbSqXOto/IGG1JkdIy1jgho6DGiS3Dm4Zf3bWvr72Z8wk/SD5/m53xHKZTut3zBTI/+w
	os059YYC2JwWOCUhmdXVaintUXNR9UDd0HkBLCgNjHzycLp8xxkTz0XKD+NP6EvdbKz/kAoEekaaJ
	c7nBSa6RtALVg8b7D5aSJPv7AZWTYhjXNlctfKXTXNgQCmA3UuFrUOrKbxCStkuc8z8c8jPyBboLS
	sSokLoKej9w4RqPDur7nQnsBF37GLfI8iY3y0GJ9Xg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 55G65tCw3448782; Mon, 16 Jun 2025 15:05:55 +0900
X-Iguazu-Qid: 2yAbUt1VHMm7VbcmgU
X-Iguazu-QSIG: v=2; s=0; t=1750053955; q=2yAbUt1VHMm7VbcmgU; m=WvnLMTUqzIQgasEEnQYoCBSVM8ma5Nj3fjCR/9BVr7Q=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 55G65sHb1992529
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 15:05:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnGENMg+tzItXidm4jUbryrK1eLUFonB9769nOzNe2voazaM96UVI9hlFzqQPZMkMrPAQzsI2P91GfhcwKs+1Sp9PRd7QnrzBCJeGuTW1sjEfACsMH5FEX1t7JpR70dQLPgeWhoPkMAY5mp73GmcT/m5024d0kHiNL+Wf/mLPbLdJuUgenpy+ZrlFdY9mI/Q4+kRvpaQuWRbsYE35cfEn0e8iJSzRqTlwdyHLKLIr133+dpZ1CYjJ2u7aT6hVXaRWad+mbdMZmnG9RrOPsFadyG6UKKcptemPHgdfHOv+uxlIkaogr3Ft1DlBVvvz0IqqMFDYdJcDxVm2DphybFyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKJFZm0BTJcjtgOK5uwfPnfqOkZ9pDF76R9Ij7JDPR0=;
 b=nXycTRLohUH+d4baSlH/NErOAL0d/GrjOc21zbOv3al8ZnDhH/tUY7cE0YEA7MGLCqLIDfzscs/uou3RPQHNtsEBkvbOvaCd8YK+/4eKk4Sc68dzSSO0M10TvjFMWQFbKsdGMML4uw3+4B9xpvCcDS6fBVd6YZ683cxpQalYWSK3R058W+mbjQTW7QmlB4dwImGBMPqsz+yrNUzzgxpKdKvNW7TEpfiWYgk+sl9D+0j8A1FVryk+ZcqSCK78MMY14W3cP88EDAcc3kLnF1xprDveB/BA5Ba+A0dAy3uGSL0jWI0H4ap7tzrV8/Ptou2XVpzBaPo/5SQekxmwn9A5QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <claudiu.beznea@tuxon.dev>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip 00/12] RZ/G3S: Backport ADC support
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 00/12] RZ/G3S: Backport ADC support
Thread-Index: AQHb3EwTHFhHd8b0hk2iN4A7I8tclrQFUKqw
Date: Mon, 16 Jun 2025 06:05:50 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818F570BA2356DF7ACB80E89270A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB8621:EE_
x-ms-office365-filtering-correlation-id: 533d0fe5-42a3-4194-66c5-08ddac9bd805
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bXJSRU9QQktFZlgrdUdueWNzcEdBbDdtUG1OMHdBR1FpWkFBM2YwZ3ds?=
 =?iso-2022-jp?B?K0NrQXpML0djMi9FcWFRelZWc3poMUVaa3BiaC9RQ3JTdWlMdTJ3RWh3?=
 =?iso-2022-jp?B?TVJyVzVEejhxdHpWZVluOEFKRGF4U3pKMGJnUnZrV3pkRlJ5bkNJUHo4?=
 =?iso-2022-jp?B?WndHc084bmtRVVkvNlVpRWM4SzRwOHczODVzSEwvQTd2cWhSaVRYMGd3?=
 =?iso-2022-jp?B?a1FFTkNOeDhBODNoVk56NXhkeWsrSnUwcFFHeE5UdEViU1UxK01nbVUy?=
 =?iso-2022-jp?B?bjFGWFhmbkd6NHNjZ1NtT1p2R1R3M20yVDlVbktKN083TGNsR2VXMGZC?=
 =?iso-2022-jp?B?UlM1MktTU1IyS1lRaGNWc1JkMHV1Z2NlZ0YwcVFLa2YvYXFQMGorMXpZ?=
 =?iso-2022-jp?B?S0lNU3MvY1RtcWdyUS8raS9UanRzTkpiSmZ6MHdiUkNwcHR6L2krd2NI?=
 =?iso-2022-jp?B?TjBKRGN6ZEI2UmZyK29oUWZnZmR3RGxPa0xnZmUrUXhWaWxRSTBDM2pm?=
 =?iso-2022-jp?B?Q2Yra3FmQzF0RVM4OElWWlBYME42WjdnT2tHR3VwMDNzcFNKSWczS3g2?=
 =?iso-2022-jp?B?MW4xZU9IV2N6TFJ2andvSmpiRGxQNlM4ajN2ZDMvRHlhVUNFdW5tRUVJ?=
 =?iso-2022-jp?B?TDMwVVdJZkFhcEtxK2dlYjcyRWJsaUNjZGIwVkdPNHFPMFJpYVRFSWQv?=
 =?iso-2022-jp?B?aDJmNHE2bmlweHBxekl5MG03VHo0NWdMaUcvdzNhckNhb09yS2tCbmtt?=
 =?iso-2022-jp?B?Tzg1Z0RaZjgycmJaa2JtV2hYaVhVT0twcEZDYmlEUndORUsxT2xuTnRr?=
 =?iso-2022-jp?B?ckxFWjJueGQ0SjV6OE9aMWphb2hiWnVBeFZROVVTWHAzZjAxOWNsdVQw?=
 =?iso-2022-jp?B?VUpZNzZVQlErS29MZU5Panp6M0JVMFU3ZTMvbitaQnVXaUFPRjhHZTRO?=
 =?iso-2022-jp?B?SnJKdUlySWJlVkdES3lwYyszSGI1Q3FtZ2xBNWFyelkrbHV3M2RramtR?=
 =?iso-2022-jp?B?aVk4ejEyMzFld3FuQXI5UW1nWVJvRGpzeVVLNFViY0l3cHJWNmxuWllC?=
 =?iso-2022-jp?B?akpabkkyQVYvdkVIcVJmWDBYVHNmN2daTmQ0a0I1MUVmcVRUOFk5SHN6?=
 =?iso-2022-jp?B?aTlBc2RZTXdzdmtjOHNRc2E2ZFlpN2t1bGY5c1E5ZE5BRVM3amR1SFJm?=
 =?iso-2022-jp?B?aEQ2SGtPUjRUaWM5ZC9jS2tUc1M5U0VKdmZTQ3FhY1ZqR3B1VEY2OTZV?=
 =?iso-2022-jp?B?VDhNaVpua005RDU2UmQzczRETjJXUE56cDZwWW4wL3dNdWhiSEJLWEs4?=
 =?iso-2022-jp?B?U2JWZS84S1gxdHc4aG8xVHN1bm5nU0JnTGdCZXBUempCWlE4cm5mMnNj?=
 =?iso-2022-jp?B?ZW9rc01FSXpRcWo0V3JQNlgrd2ZYbXZyMVZNWWRWL2g2WlVtdWxoWHFs?=
 =?iso-2022-jp?B?dlpwSDhFc1pubHRoRDNQR3ZDclNBR1lsd29pazF5UFl1N0RCczhaTjBN?=
 =?iso-2022-jp?B?dW9CdTVNTDRwdi9mZUljK2RCc3BSYmtyNldLQmI2RHdBMGNJdnMvTG1H?=
 =?iso-2022-jp?B?a04zdEhNcGxyNFpiZU9zbURaU1U1T0xNSklOaEdCYXdQWFVBaDdaNlBV?=
 =?iso-2022-jp?B?a0pvWldHZVY2dDVQNVRwV0VhN01XSUVYRDFBUE9GQWZzdi9EQW4xZDNZ?=
 =?iso-2022-jp?B?ZjJIeVhYTkh1eE0ycWZwYmhSbXBqc0dMVGZVd0JXelFRYWNiUVpTc0lw?=
 =?iso-2022-jp?B?dW5vdWxJUzNmUzRqc0dvMXRqVUZCYndtOVZvQjZhVm4xWWhmRC9zeDg4?=
 =?iso-2022-jp?B?d0p6SWhlMW9Xa1dKNU1RcDBiTnlWb0ZuNEs1VGM4dGZDQWd3c1hpdTlY?=
 =?iso-2022-jp?B?aU5YN3UyMTNNQkw5dzR3WXVzZ05ENkE5ZUcrWEovVnlaQTFhRGhHeFpz?=
 =?iso-2022-jp?B?YWZGYXU0aEFCWWRYRk1laEJTUnhBV084Y015anYrQ2RmdjZlRk1Cb2I4?=
 =?iso-2022-jp?B?MVdiNW4xUCtLN1ExREFDYjF1TzBDMFZPd0RraHpVeG9mQStQS2czMnNQ?=
 =?iso-2022-jp?B?elZoRGxDWlUwd3pWS3RoM2RmbHZaMk1TendPR3BUMU54QzQwSnFSZ1Rw?=
 =?iso-2022-jp?B?OTcyOU9iWkZjbzFIaUg2amgwanp6NW9JV2x0QWcyMEJHUzlSY0E2UjlO?=
 =?iso-2022-jp?B?K2o4PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RWJLWUlIbE9QVWJnZWYySyt1bmo4Mjhlczk2NURReGt0S3RzSm1hSjUw?=
 =?iso-2022-jp?B?akhpbk9aMXhZOFZnc1F3V2lxYWZycnBVMHQ0U3J0Z3BpMEZYcERPc3NZ?=
 =?iso-2022-jp?B?QUJLK1Y2Ynl1M1hVeVpJajY5R3JJS0tGelV5OVRqaWNMc3NwRXA5N2R3?=
 =?iso-2022-jp?B?TndTN1pIWGM1NFhrdVBidjk1TG5VQURUdWFNMnF5bXczS3ZpQ1VjWG9n?=
 =?iso-2022-jp?B?dmQvcU5WUmIxaFIwMGtZazZYKzRlZGxOREtUVHNDWWhKVlRXcFNIUFZF?=
 =?iso-2022-jp?B?aDg0UWFUNFFlQXB1Yll2bDg4MngzcytMblkzSGswbEF0K2hkcVFCU2VO?=
 =?iso-2022-jp?B?MzdKWXVZSk1VeVlPNXlNak1McnY4Qkd4bTFuRW1WRm1peXp1bzVzN1FF?=
 =?iso-2022-jp?B?QTFURFRjd0xCMzZ4VEEzWWZzcEFUajc5a1VFNUszTHoxb3FLYjBWWVdY?=
 =?iso-2022-jp?B?WUU5d0pDK1NmZ1lFcW8vM2FiYWVyYkxNb01rT2xPWloxRmxOMHpDa1Iy?=
 =?iso-2022-jp?B?SnorUmxORmREU3FkSU5BeDFoRTd3NWM4aHcrSWZkQXMxOTJNRlE4bXNF?=
 =?iso-2022-jp?B?dFUwVEhMZHRlZVIrdk4yL0RmZlNEeXd2VG95NVRmOE1jR05HeGFMV3FD?=
 =?iso-2022-jp?B?WFpGNzdvOU9lNjkwemR5dnZOb3VMWEc4dm4rZzhGeWpQenVLb3hRRlVP?=
 =?iso-2022-jp?B?ZitzZldjaURVclgwdFozMGI4VEw3UnhjRmN0RWM2MGcwV0oxMXdoelNj?=
 =?iso-2022-jp?B?UTAyOFErTFpHaWZ1V2ZlWUR2SFI4Nlk5czk1VFd2ZlhNblpKSGpweGF5?=
 =?iso-2022-jp?B?anY2QzFhMTVXNE5RVHU2Rmk0ZjR2Tm5BWVlDMFVnMWdtZjVZYlVFY0E1?=
 =?iso-2022-jp?B?Uk94QUZVVDZZZVMzL3YzRmg2ZWhERGV0Y29kaTlPV1F6anlQWEd5RHQ3?=
 =?iso-2022-jp?B?UGNrdXlpbGR2UlJ4VzhJaFVrN1lmclh0YWhIM2pmRGM0VFFhU2N5SkVJ?=
 =?iso-2022-jp?B?czk0ZjZoWVlKY2Y5OGIwMGRmQ2ZQUGRLT2RQMDFhbDRHbmx4MjI1U3Ez?=
 =?iso-2022-jp?B?ZHdWalZycjBJOHdYdHFkdkphMzVvWHQ4bWJuTkw2VFRRY2pXZnZqRnBI?=
 =?iso-2022-jp?B?Qk9nRVp6QkdjTkZlQnJ2RjhucFQ0Nm4zTE5UZzRuWXJKZVhlUWFiVHVM?=
 =?iso-2022-jp?B?c0JLd3FqZFZvNzd2UjdRbVF6STBTdkRnK3V0a0QzT0txNk9ZUGhGVnVX?=
 =?iso-2022-jp?B?TkdDTE50eWFZdWVmOE55dkhCQlBpYytOSFpDeVNkMGNkSk0xVGh2bkMz?=
 =?iso-2022-jp?B?ZGlNWmJQRWRWZFVBMnFaQ29rQ2c3U3FIUGYxVUp4UnR4cEp6NjJ1UFBq?=
 =?iso-2022-jp?B?dllpUWI5VkpQSk9WcUVMVGM3MjFiK0x2TDhWd2J1ZWpIaDJOMWRGSjF5?=
 =?iso-2022-jp?B?cDhGVE9nY0FjMG9sRXRIYXV2Y1NaaVloMTZVZ0xCUThtdzBmUXFoQXY0?=
 =?iso-2022-jp?B?L1UyWXd0UGNHcVhVY0YrMWluMnNWdHNzL1diTUMxWW5qVEJPUmdXdFFF?=
 =?iso-2022-jp?B?b1hub25tQUpCN3Z0S0YwNDllOVVQUGN3ZE9tUHFzSXNQRWdXbzBzSlVF?=
 =?iso-2022-jp?B?dFUrSWw3aGM5K1V1NFBmVlBFOHpHN1NQeUVtb0FIN1c4MzczbXdJUjhT?=
 =?iso-2022-jp?B?QzdISExUc3N3clZ2TmJzTTJrcU54Nm0vMVJDaVNxVUl1eXZrZGF4Y1Ux?=
 =?iso-2022-jp?B?eERQeEVhZW5neHBuWDJKZnJUa25xdjZ5ZXdpWmlRTEdRdGNWNmY3aDdJ?=
 =?iso-2022-jp?B?bnFQbm94d0FTSlgxdTg4b2k1SGtHb2JzandFcFl5Y0tFcVJ4bStWbTVQ?=
 =?iso-2022-jp?B?Zk43aFZBa1pGSDVwVTFxWURXbWxLZ25YRzNobmdQaTFDdVJnQ1VUUEgw?=
 =?iso-2022-jp?B?UEEveFE3TzkzNmJXbGtRZk44andHQStXSjB1cU1FekZxbVd6c012eTFG?=
 =?iso-2022-jp?B?T0sveEFSdTlKSkNJSExWM3VpeWdnTzBQTVhJZm0vQ056dmVBbXFoaVQy?=
 =?iso-2022-jp?B?cFRBOW9sNUJVS0VONFN2dmxQaVNFNmt5WGVYYjRIanl3dGtDaUI1N0lY?=
 =?iso-2022-jp?B?UUVKQ09iNVBtU1NaVG40Q0lNZ2JvR1BzTzRYbzM0SnppMUZSaG91UlRv?=
 =?iso-2022-jp?B?aVhITTVWbmlBVW5JUUQ5ZlprQS9taWZHRHJQdFRXbGRwNG9xMUN4NUQr?=
 =?iso-2022-jp?B?dkJHNitJWWxUUFI4cm9ZeVdFWDVsWnUvU0QycnJYTWZvdUdpTWl2a2l4?=
 =?iso-2022-jp?B?OUJRLzE0ZEpzbE1rdFNONERqZDdNSmU3ekE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533d0fe5-42a3-4194-66c5-08ddac9bd805
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 06:05:50.0159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ormMU+fwyP03iNnGfPlWGrR6tz8V7he5YaUbVwpDPHnYo16gCOOpEu8rk2ACW56fK+sSEWGyYaoK0bXY1D040MkBOunB8UDpIvwGEUHmQOg/ljOzhfbWddgVoNTPAHPe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8621
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 06:06:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19093

Hi,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of claudiu beznea
> Sent: Friday, June 13, 2025 7:15 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.de
> Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org
> Subject: [cip-dev] [PATCH 5.10.y-cip 00/12] RZ/G3S: Backport ADC support
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Hi,
>=20
> Series backports the Renesas RZ/G3S ADC support to v5.10.y CIP.
>=20
> Thank you,
> Claudiu Beznea
>=20
> Claudiu Beznea (12):
>   clk: renesas: r9a08g045: Add clocks, resets and power domain support
>     for the ADC IP
>   iio: adc: rzg2l_adc: Convert dev_err() to dev_err_probe()
>   iio: adc: rzg2l_adc: Simplify the runtime PM code
>   iio: adc: rzg2l_adc: Use read_poll_timeout()
>   iio: adc: rzg2l_adc: Enable runtime PM autosuspend support
>   iio: adc: rzg2l_adc: Prepare for the addition of RZ/G3S support
>   iio: adc: rzg2l_adc: Add support for channel 8
>   iio: adc: rzg2l_adc: Add suspend/resume support
>   dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3S SoC
>   iio: adc: rzg2l_adc: Add support for Renesas RZ/G3S
>   arm64: dts: renesas: r9a08g045: Add ADC node
>   arm64: dts: renesas: rzg3s-smarc-som: Enable ADC
>=20
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   |  39 +-
>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  53 +++
>  .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   4 +
>  drivers/clk/renesas/r9a08g045-cpg.c           |   5 +
>  drivers/iio/adc/rzg2l_adc.c                   | 405 ++++++++++--------
>  5 files changed, 323 insertions(+), 183 deletions(-)
>=20

I reviewed this series, LGTM.
I can apply, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


