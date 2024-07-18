Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54074C3DA5D
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 01:46:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.6009.1721267198554880256
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jul 2024 18:46:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=CtC4wWyi;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1721267187;x=1722476787;bh=qJcgeGlZftGH+whr2PZGKpCtJ8IYusCDFzSR87Z
	czTU=;b=CtC4wWyicM56gM3NM3oqgCtSaEgf5DxLpq9ZzCeywWzp+ySn6obXmWg6/xuuRDYN3TjPs
	FcYwXjaQV7Ks5NyDpmGY7880X3TpxAu8fgXJMDirbzslQ8FnFrxNfrZclnTvGmJ8b+OMV8Qtp6522
	ZvGJeLNkrNwUkeN/2881BOxq39AY4MO20eebSeSuUmZ51PE4Z6SA2PPGfQyMUJAdfI4O3AGJvVJ/J
	BVrgRBRcY26RHTw9MSgKg4jJciwGS++0cSzh+jJyAEKUYcvytpBV1klQ4m/OVIE1oEP+hJvSxo8vU
	d51g60X+uiN0FTtwCaePB0o+EIpPuxd7rhTZD3vDRw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 46I1kRtB2105397; Thu, 18 Jul 2024 10:46:27 +0900
X-Iguazu-Qid: 2rWhoo1A0AXG3KEM7B
X-Iguazu-QSIG: v=2; s=0; t=1721267186; q=2rWhoo1A0AXG3KEM7B; m=S/jUzayL3AB0mAqScY8h4L20ou9bjNjQNkEIbqdl8pk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 46I1kPVX4073118
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 10:46:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5CtWPGsiJH50lhv75pg+UHn3UWhxT4sc2MTchxMgYB631xvmHWIYFCSg+++3TkoLTsmwwite9HaHElmW2w1Jw69g3FS5F3MG1iqd8F0v6bVi0T5mObVxh5i0uGOH9hrPc78YhdxswJfHWkO5AEJmKsb/UvDuEWSMNxVQ/oPvCt1LGP4BFy0U+ZrlbWVpq/3e2v0jsmzDP94xLBmTuH2SVmw3YpXNl8V0dJxarGiNYkssRIg+ntLCrhYBL9x6j5kmNsDWafCUxkjMjviroM/weqahsiORUOQ2kd+CcZd14+c6nLfksRsAzm0UnUZm/7OQMgQ+CRijGy2NJtnD1pAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWaoK/VV1whuWFIb5ZlzGJYgVmMuOGWgvJlOPpibSvg=;
 b=MhHkCHGu+/Owyz1lKbt9noAhwomyOqjyD9DSpi6bD1hMwPeajer7IVZrHd9gG5HpfmcB25fmQuB50cPPmizAvo//nQGhUiko4iLVh/mtTZXoxAQmvNTpl3b5qvojV3szxkBYkOxP9xjGjIHuPrViy3F822MrxUOwWHRs+4bJJpm3LLgnU4TjOD3hM+Ymr3/o3cvgKEA532RkA51lY26j38Yk1ZZruayS80WHT+TKVvATB28rxLzNVCSl3yfG+8VfbFW0S/CN4pBRjLvrs/RBdaRM8ik7LYECDBnf5fQzSyMSJBh3hBCSbm5GbrhTwe/I5ZKlLRSbJhMDk5SpuhufVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/31] Add PMIC DA9062 support
Thread-Topic: [PATCH 5.10.y-cip 00/31] Add PMIC DA9062 support
Thread-Index: AQHa11ljWomus3m9cUiyotNt3dNI3LH7uXyA
Date: Thu, 18 Jul 2024 01:46:23 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6391E5A421C14AFB726EE27092AC2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6391:EE_|OS0PR01MB5811:EE_
x-ms-office365-filtering-correlation-id: 60f7b942-21f0-4eca-9ede-08dca6cb6dec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WTRjZUJrRGtEOXVFc09pMXUvM1pqVHJWV1R2MzJRanRDaVhoQkNpMXBq?=
 =?iso-2022-jp?B?Z2xVYWpYdTVhSkZkakxYSTE5bHJjdHhIaS9wSk9Ram16bys5VE5kNGtO?=
 =?iso-2022-jp?B?S3E3TlZCVkJ1QkcxOWVzcGJKaWt5TGNxQzRhYm5YMm5QMkRLZkpocXN3?=
 =?iso-2022-jp?B?N3lEeWRTc0hvd0RqblpLc1dnbTEwa3o0NTRvV2dvVkUreVFkV2MrZjR6?=
 =?iso-2022-jp?B?cEdubUhvUGFFNGJTN21kblhJNDZVc1pkWnNUSEFQemJaWnBoc0JzWkpr?=
 =?iso-2022-jp?B?WnpDSUxuRlozb3I2WkdORVhqa2lWTklqRnpBa3pKdThVQnVqb3R6WWd5?=
 =?iso-2022-jp?B?NTNuQ2s1MTA2S1ZOb20rTW5jWThFT0dXcE81dzVodHJoTU5zSU5HRGll?=
 =?iso-2022-jp?B?U1NRQnRHY2ExVkcxdjhRTWVzTHBhaGQ2ZEJweDhHZlBPRnAwUVBLSGlL?=
 =?iso-2022-jp?B?eFZaajJFQzBUWEZnY21EL0hnc0FPbmk5di9vT3Vma0JIelRFOWZGTTEv?=
 =?iso-2022-jp?B?bDNuMitpR2RFc1cra0ErN3R0L0lOUUprVTQzcDF3ZXJIdjQzWG41Mlph?=
 =?iso-2022-jp?B?QjVEWDlMY2RSMGFXWFRhZWxLQUhMTS9sUFBaTGw0ek1ITzZjZ2tuOTdW?=
 =?iso-2022-jp?B?Uzc1bVE2WEVSa0JIYWdwamdINTZrOGsrcFBCZDV1ZFV5TWRyQ2V6REpt?=
 =?iso-2022-jp?B?RnZmanB3R29UQmh2Q3IreFJ0eEpqcDlkTW9aUEI1aytxdlAvUjJmVE40?=
 =?iso-2022-jp?B?S1lRV1BKYlg4aFNrV2t1eko3UHlVYWlsdldNeTI5RFhKTEtZTEpuV21W?=
 =?iso-2022-jp?B?cFBhMHEwRDJzT1ZlZjBSaktralJyR01Xam9ncTU4Z1BBMk9MM2dCenhr?=
 =?iso-2022-jp?B?eFBsY2pKemQ0c2phWEM5SlErUURjNGkzOThORjBlT2MvL09aQlh0U2JP?=
 =?iso-2022-jp?B?MEdHbXpROHlWd1kvNWRMY2w1cFhITXl0K0dOSWdjMHZha0JGUmdLZERh?=
 =?iso-2022-jp?B?TE85dUF2YW94UndhT1cyK2JaRHBiOWpKTDlqWjVNbER2cDlpbnJMbFBJ?=
 =?iso-2022-jp?B?aHVUcVErSzViVlphY2dIdHFyeFg0T0JuaU9vVDJVT2lGbTF4M04xWUFl?=
 =?iso-2022-jp?B?UzBKWWhSKzQvelVqOEtwMlZvQ0d6eWJqNy9ReERvUG5yelhDVUM1R2Uv?=
 =?iso-2022-jp?B?ay9lbEQ3ZWhpOFhwY0pUdEtnZzJoT3dWSUdjSEtiaTNHMEM3dkpLTVN0?=
 =?iso-2022-jp?B?VlZudG5OMk9naUJ1YUZrMWE3eWdUdXhmZC9nNlhwWlZ4ZW5zZHVDb1FV?=
 =?iso-2022-jp?B?eUlHdGlJZnI1M2NBSXJ6SHlGSlVQN3hnd0ZrdkI0SUE5Nzh4VTg4cjVI?=
 =?iso-2022-jp?B?b0RXU1dTQnEvTUdCME56em12Nk5qUGl3SEVKZWxPYkl5SkthNnk2WWha?=
 =?iso-2022-jp?B?bEFwelIwdjh0cjdwaEczQVJrVmJSLzVLaGxHM0VManRYUmlyNllnZGR6?=
 =?iso-2022-jp?B?REdjZi95U2Z2SVJmVEMrUTBQc1BKeGN6eTlqYUpDNzZ5d0p1aWNIcU9a?=
 =?iso-2022-jp?B?bkN3TFRVTm5iTFRYdlFQTkVoaDZhRXU0QjVBUXJBajc5NDdUdDZ0REtx?=
 =?iso-2022-jp?B?Q1JtOS96RVJuSnVjWlRrT0wyYWd6QW1aNnNzdlY4YlJZZERYckxGMHpQ?=
 =?iso-2022-jp?B?anJ6N2IvWmNjNW5hME1wQXZkaGtJSEFvSXV3TEdzb2FIR3lPT0FySkRE?=
 =?iso-2022-jp?B?RFNLWlpUekUvWm9rSjlVT3FDZ29YUU5nbVhpWmlnRmJkQ2lmVTFkVkgz?=
 =?iso-2022-jp?B?QUlVM2oyKzFZdyswbS9xR1duTFVSeHlJT0VmZWNTY2xIV2FXKzliSE9S?=
 =?iso-2022-jp?B?d1ZFRjV6OFROdG52NytadGZ1ek5ZQ0YvRFpXQnRwMXVwS1Mvbmw2ZzZu?=
 =?iso-2022-jp?B?UzhPR2VvUXlUdjd2cElSREVwbXdDWkpURDg0amJqUmFSYTM5M3pPRlds?=
 =?iso-2022-jp?B?OStNc3UyMHQ4anVuWStVT2ptOERVTjZGdm90Z29XTmJ5NHBmcXZ4UVJ4?=
 =?iso-2022-jp?B?WmNRejVibUNobm9NbzdxZWMxNHNORkE9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6391.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dXUydDJodkZDVU1QeFNPSjlOMlZOUFhTbDR2VmRMSmpJeUlMZDhzR09J?=
 =?iso-2022-jp?B?V2graU5uQzdFTkMrQVgxWnF0c2VyTVBpd1UyQmJiV1VSMG85d3RxL09M?=
 =?iso-2022-jp?B?cTl3SGZneEdQKzZpeU9vQWlYS1YxeEpla2FPdVZkOEtJdllQSXZiMVNB?=
 =?iso-2022-jp?B?cHZQenhaSXhqdXQzUjI0aWx0cmZrbHZqQjIzczJRNjh5eGR3TVZTMllE?=
 =?iso-2022-jp?B?dTJYVHdRY0lwQlFFcStVR0xHV1k3V1JmMDNHS2xNMk9wa1ZmL0lPVDBh?=
 =?iso-2022-jp?B?dVNiN0hjWi9UVElEajlzcFVBYVROaDdRUFFRMFpKQUFPQVZDZHZMMndE?=
 =?iso-2022-jp?B?aUp2aGYrUmxKdHJRQUdKL0F4aEhBeTlYREltZS9SVXh5ekc2d2Y0YWlG?=
 =?iso-2022-jp?B?SlpNbFo0V3JCNEVwZEpMa1ZPcDY1SmQrd2p4STVuV21lUnhrcm1oRlZ5?=
 =?iso-2022-jp?B?ampHR1I0ZmlGanhWSFpjdEIzc2ZIMEh4Z1FxaGE5a3N3Q2Vrc0U5SGhH?=
 =?iso-2022-jp?B?UFNnYjRhRGI1UURtaERsUU50VmhOa1ZxK3JtNm9US1hlR1dQcTlMdlYv?=
 =?iso-2022-jp?B?U0pzYzNDdkpRQjF5d2J5akRsQzExTzhYVWhpZEhoc2pGVktyaFZtNk5v?=
 =?iso-2022-jp?B?c29kZU1aYXVicWNHb0N5MmRRWGFjT1hmeCtubzRyZ0VFT1JiWForclh5?=
 =?iso-2022-jp?B?TDVTZlpEcUlINnVhUUJGVmJUZlJNKzY0UTZ2ak04SjErUXJkdG1zUDlp?=
 =?iso-2022-jp?B?dHpsaElZSzFTcjZqVlhXT1ZvanNoMnNwUWVSUzlxS3BQaXpLWHdLOHZJ?=
 =?iso-2022-jp?B?N2VzSnMrT0NZVitaeFhPaVlqdHZ1bW9HWjFaNExZNzZ5VS9nRHZKdjRB?=
 =?iso-2022-jp?B?cURKa0kwaFViR2NFbjdZK2VHb2M5RmZ1b1ZTQ24rS0hUa2QzNDNDNHdt?=
 =?iso-2022-jp?B?NlNseGdnU1RmUjczSWZBdVZVNkZMaWZSM0hPMjZTVWc2M2cyaVJ6Ukp4?=
 =?iso-2022-jp?B?QXNhOHZSK2dmMkF2ck5Hamt2OVlOdjJYQ1Zvam5MYWxDREpzQVJwUmhu?=
 =?iso-2022-jp?B?T0l0OTRyeHk1ODJFR3l6VzcxejM2cEh0enlCNW43VTc2b0htWFBROFRU?=
 =?iso-2022-jp?B?UDA1OE5QbHVtVENON2hoQmtjZWRGMlpIcXozZFVIU2lUeVZ0ZHJORnJq?=
 =?iso-2022-jp?B?bDI0MDZkbkE4dG9FVTZPNGZRU0pLdmFreTdRekhZaFM5NTEvRnFIbTd3?=
 =?iso-2022-jp?B?MCs5alhXem5KOERQM2pqdUtmSXhSbytLUFM1NHVybzR6QXQ0a28rUlRB?=
 =?iso-2022-jp?B?RGEySVhYTWRocGk4dlM3MDVVZkEzLzRpdEJYQ2hqM3RrcHNoYWczSFMx?=
 =?iso-2022-jp?B?cnd4eWN0OUJZK3VEMVBxanRCTUtzcWgzMld0eXZ4Z1VpYXRVV2pJVm44?=
 =?iso-2022-jp?B?b2RiKzY1MktaVFY4S2VPT0tjNUxFNTQwc0dyK1pQZDZBK2xyMFZ6VFQy?=
 =?iso-2022-jp?B?VCs2ZUw1VzBkTlZGbHJNTkF4TUhTdHF5NGo4NzVvR0h0S2E1NWZjdDVE?=
 =?iso-2022-jp?B?MzUvVzNQaCtuSHdvUXVkLzN6RWcyT2Z6djZGS1NpOWIyR2ZrUVNFaWV6?=
 =?iso-2022-jp?B?K0dKTnFUbkZ5M3JJS0U3bmxnUk54ZmxOSTcwdkpyc3RxUU5IWldCK3JZ?=
 =?iso-2022-jp?B?a2hwbzFmcjRlQWd5bWczQmNBWjZKK2tHc3I1TlB4T0NlNjU3Nk1aTHpS?=
 =?iso-2022-jp?B?Mk5ycjMxdzRjODI5VG42ZVcyMVpBcExob1dhSTJmKzVnVUk3WUZCRWls?=
 =?iso-2022-jp?B?Q29kbU40bDdrV1owNVpLWVpldm82TE1pQ2hVMEFQY1dCUmlZb3ZDYzZ4?=
 =?iso-2022-jp?B?Smo2V2NaUVVYWllxbENwbGxkVXM5VFVJTVJ3SWMzUHlhVCszZmFwWEZF?=
 =?iso-2022-jp?B?bFZlUnQvdjR2SjcxUzMvZE9BUDFCamFxSWIwRExkejgxdDh1akV3ekp1?=
 =?iso-2022-jp?B?SXEwR2d6cFhNeWVXcllqbjZzZDlzeW56UVZPendMdG1MczViQ0s3QUhM?=
 =?iso-2022-jp?B?WE1YRUVWNEVWcVNRaERlVjBxMzEwenp3ZjlPV0N0Q2FtNWh6K0ZtT3BN?=
 =?iso-2022-jp?B?bEZtQ3hzU2dBVEF4QStyM0p0TS9TdzlDZHAvOFVMbzI2STREckFOUWxn?=
 =?iso-2022-jp?B?RjVCRWtNZll6QTlaNWY4eEFwdmN5VTRxMVZlOVVHTlBaYWZwVklYZ1pV?=
 =?iso-2022-jp?B?TFovMnZseEdBeGFQdyt1Tk5seElHaDBvTHpzSDBIVkpQNDM2clhrTWV0?=
 =?iso-2022-jp?B?TVFycnBDcDhEQUFKSGwwektqcjcrNlcrOVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6391.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f7b942-21f0-4eca-9ede-08dca6cb6dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 01:46:23.2210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5YWc02KvUHauNw1A7KkEKiK8n8wnnKOHDhXIB9hNouFqjrHDG5LDzhdu7rrkmixsIuqrvfcFVvbh+WSZkJ/ay0kN6aYSWCXqnsHtC3VJzWcuuul2N8jqxR7tTHnGfIFL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5811
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jul 2024 01:46:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16571

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Tuesday, July 16, 2024 5:22 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 00/31] Add PMIC DA9062 support
>=20
> This patch series aims to add PMIC DA9062 support for SMARC
> RZ/{G2UL,Five} EVK platforms.
>=20
> All the patches are cherry-picked from the mainline.
>=20
> Andrej Picej (1):
>   mfd: da9062: Support SMBus and I2C mode
>=20
> Andy Shevchenko (1):
>   pinctrl: Propagate firmware node from a parent device
>=20
> Biju Das (16):
>   mfd: da9062: Simplify obtaining I2C match data
>   rtc: da9063: Make IRQ as optional
>   rtc: da9063: Use device_get_match_data()
>   rtc: da9063: Use dev_err_probe()
>   pinctrl: da9062: Add OF table
>   Input: da9063 - simplify obtaining OF match data
>   Input: da9063 - drop redundant prints in probe()
>   Input: da9063 - use dev_err_probe()
>   dt-bindings: mfd: da9062: Update watchdog description
>   dt-bindings: mfd: dlg,da9063: Update watchdog child node
>   dt-bindings: input: Convert da906{1,2,3} onkey to json-schema
>   dt-bindings: thermal: Convert da906{1,2} thermal to json-schema
>   dt-bindings: mfd: dlg,da9063: Sort child devices
>   dt-bindings: mfd: dlg,da9063: Convert da9062 to json-schema
>   arm64: dts: renesas: rzg2ul-smarc: Enable PMIC and built-in RTC, GPIO
>     and ONKEY
>   arm64: defconfig: Enable Renesas DA9062 PMIC
>=20
> Christoph Niedermaier (2):
>   mfd: da9062: Use MFD_CELL_OF macro
>   mfd: da9062: Remove IRQ requirement
>=20
> Conor Dooley (1):
>   dt-bindings: mfd: Convert da9063 to yaml
>=20
> Jens Hillenstedt (1):
>   mfd: da9061: Fix Failed to set Two-Wire Bus Mode.
>=20
> Kaixu Xia (1):
>   rtc: da9063: Simplify bool comparison
>=20
> Krzysztof Kozlowski (2):
>   mfd: da9062: Drop of_match_ptr from of_device_id table
>   mfd: da9062: Simplify getting of_device_id match data
>=20
> Michal Oleszczyk (1):
>   mfd: core: Delete corresponding OF node entries from list on MFD
>     removal
>=20
> Nik Bune (1):
>   dt-bindings: watchdog: da9062-wdt: convert txt to yaml
>=20
> Nikita Shubin (1):
>   rtc: da9063: add as wakeup source
>=20
> Rikard Falkeborn (1):
>   mfd: da9xxx-core: Constify static struct resource
>=20
> Samuel Holland (2):
>   rtc: da9063: Mark the alarm IRQ as a wake IRQ
>   Input: da9063 - add wakeup support
>=20
>  .../bindings/input/da9062-onkey.txt           |  47 ---
>  .../bindings/input/dlg,da9062-onkey.yaml      |  38 +++
>  .../devicetree/bindings/mfd/da9062.txt        | 123 -------
>  .../devicetree/bindings/mfd/da9063.txt        | 111 -------
>  .../devicetree/bindings/mfd/dlg,da9063.yaml   | 313
> ++++++++++++++++++
>  .../bindings/thermal/da9062-thermal.txt       |  36 --
>  .../bindings/thermal/dlg,da9062-thermal.yaml  |  35 ++
>  .../devicetree/bindings/trivial-devices.yaml  |   2 -
>  .../bindings/watchdog/da9062-wdt.txt          |  28 --
>  .../watchdog/dlg,da9062-watchdog.yaml         |  50 +++
>  MAINTAINERS                                   |   7 +-
>  arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi |  58 ++++
>  arch/arm64/configs/defconfig                  |   4 +
>  drivers/input/misc/da9063_onkey.c             |  64 ++--
>  drivers/mfd/da9055-core.c                     |   8 +-
>  drivers/mfd/da9062-core.c                     | 245 +++++++-------
>  drivers/mfd/da9063-core.c                     |   8 +-
>  drivers/mfd/da9150-core.c                     |   6 +-
>  drivers/mfd/mfd-core.c                        |   7 +
>  drivers/pinctrl/pinctrl-da9062.c              |  13 +-
>  drivers/rtc/rtc-da9063.c                      |  83 ++---
>  21 files changed, 718 insertions(+), 568 deletions(-)  delete mode 10064=
4
> Documentation/devicetree/bindings/input/da9062-onkey.txt
>  create mode 100644
> Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt
>  delete mode 100644 Documentation/devicetree/bindings/mfd/da9063.txt
>  create mode 100644
> Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
>  delete mode 100644
> Documentation/devicetree/bindings/thermal/da9062-thermal.txt
>  create mode 100644
> Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
>  delete mode 100644
> Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
>  create mode 100644
> Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml

I reviewed this series, looks good to me.
I can apppy this series, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


