Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0BED6DDE2
	for <webhook@archiver.kernel.org>; Fri, 15 Nov 2024 07:42:51 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.15326.1731656548419776099
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Nov 2024 23:42:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=EDsUq2UA;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1731656527;x=1732866127;bh=qZQaDv8PpTdZv/UeJIVHeC/6s6VjlLphq5QYpCQ
	PmhE=;b=EDsUq2UAk3j/hCBA7Hkb2HACxDyJjdpQ2U++gE+mgT+kznxEU6MYg4DxtgpV6e8BGCOKa
	5mv1wLVcuAIbDU/3xAK4HZ+yNHpGl25yd7vo3CfzhBkj7BHYxHFRVlUPjEibvEqdhIWtSxAycIhni
	ei9ntkbGRRCodk1OyStTo2E26SbwLFDvJnGtCm54RqLaR5nsd9Vkx8Unn/eYU0bJxvA1gkWgfVrt5
	eqEzMmeee1HvsRSaSM+JwYupC7EsXPYENCWqJmiPRBp1jSiM1pQ9tBrWxyUF4af4Lu1yandO1elEs
	HlLkHO9ZWSTxcn0Nh8c8N0q6kP+Wep0U/S9QX162kA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4AF7g7l9199991; Fri, 15 Nov 2024 16:42:07 +0900
X-Iguazu-Qid: 2yAbJ1jgxuuPx0jN0m
X-Iguazu-QSIG: v=2; s=0; t=1731656527; q=2yAbJ1jgxuuPx0jN0m; m=sJFjppk34ClTVVdsGM68YqHfmNrQz6J0FpmYTkl18bI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 4AF7g5on3151332
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 16:42:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNyNDXNIuZoNdbnGNhWLb9TsHP5FySIUmDvzgto16wBvGsSpm8w8qBEWUDtbOS5xk54d5fW0soJghtFoLNIANGpzG9Ubomqf1HX72N+lLlC2jIRX6/lc8s/kEKHhS0AIISOd3XcOh7UlS8SWpNPNNLl1m7GXduBOE2nli/vmdjodyWDGr1l8vYlCyEcKVxdgwBuRX90RxYZS5nRFVwQlb+QvUrQALeodL+Q38zgjmpOICJV8uYzgMqEOj/AyTG8K18tZYmSPBwt0Gbo1MImtWofHT5X9iYnQElpmsHGOP0wPxDWFQK2e/JEdgD9BEGl9vaMnlbClp7KQMs9CtCSk/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Noxrwyb3kgV9YtLRAEL0EOOp49QaHcDceCR2A3RmFb4=;
 b=Neoga2i9Khkiaw2tQfkamlgIHAtiuxVdBKfbgCl7IdwPdAr5M4N52SU4MQelx0uUXuNGhkBTtZ+D0D6sUqomcQuT1reW9lZBzWs6ou70fhBaKyDwcXsmqTcFGGzxT5ZitCMPay2EFSk72eIzKoAbDYOeeXXvcY6S5+df0ZsnyT7JkpnItVJx33CS4lrRDDPVCEcoVQH9hgVWC4k9prWwHngVDKP+cliwezKNDpQJbh39mSeZ9dSYrGWwhFBxZropbJgvHlRnxD2qkwNctxtWF3v9zv6YmbDx5xo3bcK6R/ERQTERpxAFZCI/L9LxmX9TviWy/Q7DbKIdy9HKfQ0vlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: RE: [cip-dev] [ANNOUNCE] Release v4.19.323-cip114 and v5.10.226-cip54
Thread-Topic: [cip-dev] [ANNOUNCE] Release v4.19.323-cip114 and
 v5.10.226-cip54
Thread-Index: Ads1Yf1URfTbHyuMSkCZmHELOzlvXwAQz4RqAGL2ICA=
Date: Fri, 15 Nov 2024 07:42:02 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63883975498039258347AA1E92242@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6391DAC4B6A1B643A7D2218D925A2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
 <180779152CF0DBD4.27286@lists.cip-project.org> <ZzRhxEmkMK+9S6aQ@duo.ucw.cz>
In-Reply-To: <ZzRhxEmkMK+9S6aQ@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSCPR01MB13011:EE_
x-ms-office365-filtering-correlation-id: c859d5ad-9db2-4aa9-195e-08dd0548fef1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Vm5QVFdSWEhteXNTNXVBaENCVTVsMUJRZkV5eVZXUFFUUWpwbzJvZ05v?=
 =?iso-2022-jp?B?c3ZLcDRyV3QxQkdaWCtCNmkwV3EwdmRJakM0VVF4R2RMbHQ5WGg4UTdz?=
 =?iso-2022-jp?B?Y2hlR2pVRmNscytMR3FzQlNOVlFYcXE1dXJ4NUhBWjJNODNiZmZUS2t2?=
 =?iso-2022-jp?B?WDg2Tm52cy9sbkhuUUw3QVdLUXNVaksxQ2p3aCtCWXJ3WWpWT0lzZC9l?=
 =?iso-2022-jp?B?ZmRXVmdUUG5vbUpEaE1UZ1czVU9GTkh3QnNaTFJXOWxldXFZYzhDc2FG?=
 =?iso-2022-jp?B?VEhiMEFOQ2tURWRKbVQ1K1krOW12akFPUjFiM09JTzNwK1lIaVBhNHor?=
 =?iso-2022-jp?B?VVhFcjlSNk9WSWErTjZYN2lyeWc0THhlUkpJRjd5MXptRXpndllZZTNw?=
 =?iso-2022-jp?B?bFg0Qk1GMU8zOXZnTyttZENGTWNYMkFLdHRNMzVXT1h4MjlMN21iMURF?=
 =?iso-2022-jp?B?T09yMmtab1RYYkt3VXhNaEs1cDlDZzVCRHAyUVg1aVY4Z21tVmJpWlVp?=
 =?iso-2022-jp?B?a09hOEQveU10VXoxdXk4T3hxdkc4MzRKRk9xQW5oeG0xYUFoRnVyd1Qv?=
 =?iso-2022-jp?B?L2NWYUkyeGNuR25uMXhLaWpmL3pkYXcxbDM2WWlXK25vMDhJTVcyR3Aw?=
 =?iso-2022-jp?B?VFNRdGZVbEg2bFFlL3JLS3BnbXBIeWp4ejg4Wk5lQTBDMFhPU1UreWcz?=
 =?iso-2022-jp?B?b0Z6di9BTHVKd3hkR1VUeENYVU12Z1FMRmhFMXNydW1DUkFhVTVML0N5?=
 =?iso-2022-jp?B?MGRnTDlJeUFmQ1Z4YzRwTWpEQ0JPMXVGK01EQXJZUjR4UnVWcksvdHln?=
 =?iso-2022-jp?B?OTZuZDR1SlhrU1k1Y0RuSzRuZE9PMjZaVWpIMFV3TitLZjhpQlhrU3Rw?=
 =?iso-2022-jp?B?cFcyc2lmT0Q0TCtrYVdGell3dTdkZ3haSjNXNXNwZE04ZWJsbnVzZSt4?=
 =?iso-2022-jp?B?dmNUcks1L0JmRjFBcG4yYXM2Z0tnOEdvQytOdmVrRmJXM2gxTXNFdU4v?=
 =?iso-2022-jp?B?NTlGckRLTyszRklOdFRlUWk0d2JFWHMwbjNod3NmeEM5T0pOOHJ4ZzRB?=
 =?iso-2022-jp?B?Y1BKMFQremxYM1g2OENBaXkyTjB2UlhzTkFnSWU1elBKMThHKzIyWHBK?=
 =?iso-2022-jp?B?U1B2K3JPbTg4ano2cURsb0FrN2xjTlp4Zmovbmg4dFVBUmhmKy9CbHBm?=
 =?iso-2022-jp?B?UXZkUjZSdVVzTTJmWnRBL21iNTFxVEF5ZFJkTTNrQStMNkEzU3U2N0Q3?=
 =?iso-2022-jp?B?RkpNaWlFRHFCcnZkTm42clBlS2NwQlJXaCs5T0lObWhMQ1NiMEF5STRo?=
 =?iso-2022-jp?B?dCtjWTBkdHpSVUE5YXpIUCswM0xFSkFLdngwaVFjVm5uNFBzUWtrV3BK?=
 =?iso-2022-jp?B?ZGhsMVlsMkhWSHFDQUUwRHRuL3dZK2xnSjU1WTVJZEZXNzArb0JQYVMr?=
 =?iso-2022-jp?B?YXVFdjVJYXJsY3BmMUYvUWQ1Z1R3OU45RkEwZ2tZT2gyMVZSWDljeVhE?=
 =?iso-2022-jp?B?aytSc3hSWTZTZWhzNjd0Y2lreW1Sbm5aV2tRQURXLzBNaTNyc2wwMG1M?=
 =?iso-2022-jp?B?anF3RjE3NTdxRDE0L3hycUpMWm5TYjhTVVVyMFB2RmZLVHh5ZE42bEl5?=
 =?iso-2022-jp?B?QXk5ZmVMV1VJaXpNQlpYMmJOK3ZONnJHSnVHL05nT3F0cndERXVrV2cr?=
 =?iso-2022-jp?B?b1pFLzdCK3dlSnJ0eDE3dVVMUytKcjZtZXVPSit2MzhEV0xVZFZCc3Jx?=
 =?iso-2022-jp?B?em9ZWEpoY0NlZWZhZVNwdjBDakZJc0RZTExZb25rUmc2THdGUTAwcitJ?=
 =?iso-2022-jp?B?NGRLS0R5UERVR0JpRjVOdFU0YllxMWMySjRNTW5KQjMwOHlHcFQyREJP?=
 =?iso-2022-jp?B?UHN5RmhFYTFNYWdhOTQ5eGVXSEZlbU54dWZkYUlUek9oS05Ed204bm1i?=
 =?iso-2022-jp?B?OS9XMzVCRGJpS1oyUEJ1Ym4yT3lTNUllWkpHRGVHUXFxK2k0RGt2ckJa?=
 =?iso-2022-jp?B?dXlTNXBha1JWTzlXeGxwS2I0TDhSMA==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TS9LOHBjcm9PYy9YdDRkeHYzRkFXdVFNcE9rWE1OZjNDQXYyamxhcHda?=
 =?iso-2022-jp?B?aUJ1endxQjM3cmlmSlArNUZuVG9rWW1MTzNHQnJXRGZwd2pzMCtZQ3Nj?=
 =?iso-2022-jp?B?YkJLNVZycHN4NzRBYmJoa2RQWWFnalZxek5Rb2ltWm9mcDhlQ0RQZERm?=
 =?iso-2022-jp?B?NjFLczhDVnM2QU9wQlVMZWZZRUlJY2twYkJWYjNISzJrY2hQV1JDb1Y1?=
 =?iso-2022-jp?B?WjFjd25QL2FZaFErWlI2L1N1TGo3MUtDdnB0VjJPR1JPUG5yYzlrazRB?=
 =?iso-2022-jp?B?OTdpbGZ4MWk1cjhZbjlsOWVpcmpRdkV3MElJaUZFa3RCWjJMdDgxaCts?=
 =?iso-2022-jp?B?QWJqbXVyRFFqNDV1OWRxRm9uMkRUUUZWT1RxUDFEQlNmY3hLRFVCTXpH?=
 =?iso-2022-jp?B?ZGJ1SUdvOFdTVlBtVCtHZDB4UVJiTHJSb1hjcnphMnpGY1J5OENtcGFa?=
 =?iso-2022-jp?B?WVB3VGdUaldaY0dMUUVRZnVHaXFVWXl0WkpoM2FCWFVOTUU3VGpUOFpQ?=
 =?iso-2022-jp?B?RUs0WU92dUQ1S0lZNDJUQlhiY2hzMDZsZm9IVVZLdmUybjVkTnNmOFJG?=
 =?iso-2022-jp?B?bnRKRHZMcWxkTm5xNEduVlByTlZRdkhOZjFyNEJScmFTYVE1ODhNM0xp?=
 =?iso-2022-jp?B?UjJKejR2bDBDSzNRUmFkVE5Fcm1DYWNnOUltWTRQaHJ0WnlMQTdObzFO?=
 =?iso-2022-jp?B?ZWVORGk2cnlUU0wwbkpVVFBWYitwYXRqc3RxdTEyVEtWUk9xWFFwYndj?=
 =?iso-2022-jp?B?S3RQQmJ5NzNzWkxFRHU1M3cyOTdJUDNNejBUNG5UbnRSUDlhUXYySnBF?=
 =?iso-2022-jp?B?WGVYcmNESWFIbTRraTc5N0VMTWlJMVg2RUdtRWNqeVhrS1BUQUYzMWND?=
 =?iso-2022-jp?B?YU1kb3FLTEN5blBRNU9UU25WVkhRSEpkN0IyWStSa3luZXFod0MrL3NI?=
 =?iso-2022-jp?B?T01CbGRvY3o0Wkh6ZnVWd29QSTZRZ2cvWEg4ckpFdWRLY0VXM2luWVYr?=
 =?iso-2022-jp?B?NHdacWNxVWtleFdKd3BSZTlSd1VxVyswc1pEOC9Od1krVUtPWlVNNElr?=
 =?iso-2022-jp?B?Z0FIS2JGQ1BiVEVBY3lhSm5uM005UmJrUGlYbXFFMkZNS1NjdEM1NEhh?=
 =?iso-2022-jp?B?a0tvaU45bkZnaE9lOUIzMGcwcHhkWTRCbkdGVHBuR2g0OUtISVNocUZJ?=
 =?iso-2022-jp?B?dkl6RnZGYk1TeXloRGh5VTJyM0o1dFlZdUFSaW11aXNERWprYTA3cEp5?=
 =?iso-2022-jp?B?K05vMURudEpnTEpjS0ZKQWxvMFBvNEpWS01nUzBUd3NUUjRtU1E4cy9W?=
 =?iso-2022-jp?B?UTV2b05oWmlDKzFCNXB6SExsRm10V1QxVG5CdVYxdkFLdWpNa2kxdnJK?=
 =?iso-2022-jp?B?Zi9FR2RhTWJuemZCL054SkhYOUIxcXhqOGFmekZrdmVaM0xhL1hxNUVr?=
 =?iso-2022-jp?B?VHNrQTFoRjg3eGpreGVDRUtTeUlIYklNWGgzNGE4Y0hDSk93Z2QrYUVz?=
 =?iso-2022-jp?B?MjcwN3JGekx5UVhzVHY5bHltUjY5M0MxanhWNGlWdnVpVzBhSENhanJ4?=
 =?iso-2022-jp?B?eEdjYXdHZGtkbXl3V0FuK1BjZ0lpc2Zwc2V3OHRDNk1mMS90Uy95VFdW?=
 =?iso-2022-jp?B?VFNaMW0zZnB2UU45bUM5dEJOckRIajNSNE5ad0hpekNWeDJSQVpPdXYw?=
 =?iso-2022-jp?B?VzVzdGdkZW55eDRaVnZ4U1NPQlNZUjlHc2t1SWxNYytiaDhxQTBId3I2?=
 =?iso-2022-jp?B?RitZVDZLTnNCY1hHamt2dWdXc0hpbllDS3FMd0Q2YUFHbUFFV1pSQmNW?=
 =?iso-2022-jp?B?TWNqUVMrUlphRHJicU0xSzlWZHdFajNzQ3VMbVNxZWROSnpsZzU2LzhU?=
 =?iso-2022-jp?B?ZWgvUUR1dGFGK0hBdEw1SWFWNlRnWWRMTUF3b2ErN3ZzZCtST2pNMnA0?=
 =?iso-2022-jp?B?N2dwUG1DWVZkci9GSHI2R1MydU9Zem1TcDBHbVhHS2dvYmFCTlBNQUVG?=
 =?iso-2022-jp?B?ZzV0blFKcjRCdjdxcXNQNVdMOWpRYmdsWGVOdUJpRmR3NStGbnd5b0JK?=
 =?iso-2022-jp?B?OHNkN241WWxJcEZOVytVOUttNnhBbmU3OWExQytQVy9jam93eTFrajlS?=
 =?iso-2022-jp?B?Z3p0MlZ2d1dFSGRjdEpyTnFiK0MxdG9sV0UwYzN6cUttclFmL1NUUkFV?=
 =?iso-2022-jp?B?aEdQMDNyd3BuMk1paURhekZwTEhSaHIwVFJGMkg4TFFjZ2Q1R0QvYXha?=
 =?iso-2022-jp?B?YUVyNmlrMk5yYncxYXEvbmtXOGpPVkFuZEFoc2NKZGFTMkVhQW83bG8v?=
 =?iso-2022-jp?B?UzFtb0JSejlmZi80bjhXRFhuMVJ3R1lPbWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c859d5ad-9db2-4aa9-195e-08dd0548fef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 07:42:02.9107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QBxxLu6UTusuuSlYiv6dlDj6dpNL+Nn+c5ZQBby2xA+TE9rnXHOw+6A12FCd9/IYyOizagJj1wGyV8BQTngSEcXfjuonUoYkavNG+IvaQki4zvEoLrKD92U/NP/twH5J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13011
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Nov 2024 07:42:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17257

Hi all,

Sorry, my announcement is wrong.=20
Pavel, thanks for pointing this out.

> Hi!
>=20
> > > CIP kernel team has released Linux kernel v4.19.323-cip114 and
> v5.10.226-cip54.
> > ...
> > > the linux-5.10.y-cip tree has been updated base version from v5.10.22=
6 to
> v5.10.226.
> > >
> >
> > Ok, so according to this, base version did not change,
>=20
> So I believe announcement is wrong -- it is v5.10.229-cip54, but release =
is okay
> and tags are correct, too. -rebase branch seems to be ok, too.
>
We have released v5.10.229-cip54 and v4.19.323-cip114, not v5.10.226-cip54.=
.
There will be no difference in CVE or other information.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Wednesday, November 13, 2024 5:22 PM
> To: cip-dev@lists.cip-project.org
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; jan.kiszka@siemens.com;
> pavel@denx.de; uli@fpond.eu; masami.ichikawa@cybertrust.co.jp;
> Chris.Paterson2@renesas.com
> Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.323-cip114 and
> v5.10.226-cip54
>=20
> Hi!
>=20
> > > CIP kernel team has released Linux kernel v4.19.323-cip114 and
> v5.10.226-cip54.
> > ...
> > > the linux-5.10.y-cip tree has been updated base version from v5.10.22=
6 to
> v5.10.226.
> > >
> >
> > Ok, so according to this, base version did not change,
>=20
> So I believe announcement is wrong -- it is v5.10.229-cip54, but release =
is okay
> and tags are correct, too. -rebase branch seems to be ok, too.
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


