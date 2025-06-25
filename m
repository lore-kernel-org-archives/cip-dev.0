Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B8CC7115C
	for <webhook@archiver.kernel.org>; Wed, 25 Jun 2025 06:12:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.9072.1750831938687231696
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Jun 2025 23:12:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=pbbuKY5M;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1750831917;x=1752041517;bh=rs
	oiGow7WK2hYJyjp4/yJEjMaFdwAhqXH9eStW93uvU=;b=pbbuKY5MwOJlS+g0yflJ1LEImALMDX9A
	gTcWgaoLkFeR7Vgfo/RpSFYZ8VBHaQGCHBx9ttrt7FYq5qNAIo99LLuJDtII/69JZC9M0jJQu0O32
	Py+6SmWFfB7YEm87F8l/x6XboM7SKt3OaeDoj9iJ3fm02b9wfgOb5PQA2vEeu3sgQ7O6iiLVpdCPg
	Q+5HbN+OpqwxJ6F0Pz7AbgfxjLNsRVKTBV2ByGkcMVCwZb3zX6ZpY9hS7frBGCmZiQbJIDVUvz0jd
	TQ/GWUj882MGAWN0O3zIFHumQTOdJpeadOEdAIDFWU5ZS9yNT2thd1/YGYOBROpEjs91nYHBGornM
	Lw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 55P6Bucx1277375; Wed, 25 Jun 2025 15:11:56 +0900
X-Iguazu-Qid: 2rWhqikygUreOjPT4K
X-Iguazu-QSIG: v=2; s=0; t=1750831915; q=2rWhqikygUreOjPT4K; m=kme6pRWnyrmnZrcdH9Lms/4RDfUSFqifutK9M8H9chs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 55P6BrT0109120
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 15:11:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mM6ma+uk+1w0fRrHTyOmf5FzcIhJ1YSn0o1SoxJyCpLt2gw7mTZEUhlDfr9NzZyqDKgmnKMxX0j6cKDtZjf2Veoo/U4+tr65ysDY1XX6u4Rnca5tYJ11rVgYGYnF67Wh4QPEXJl/XLKtMyxgCvLAnI6QeZ2VMo6Ec0HOXU0zyMp/rNZa83lFoFBzu0C3V03mJydShYtKEOPsqqzCBVcNgtWDoGWAp/UGexfW27nosshg2d+aBVKBz+4uzGGIojV6YzGSwrzMkdE4VKusBM+wHK66PokhE9ZKaSoOxY8Fq/q+BCa+9J/+y91XM2Nm9QfaMWN8GeiOIbOdmV1iAIVHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uojAJqTkODu+lHzk3jIogrSK1pj027rtfXGj07bsEg=;
 b=XZT+maRA6dDuS8rULXm6w/TeUIGCyZrcZ2abR/7Ccg5N6yP4gju1Z9MRWE2ffu1cUpuSWlcqlNqkjJq1zNxkvClMZto6OTaebOIVxm22/MMC1P0mozx1lq4dvukdgexMW00rFjyNCZTWm9WWA+66mlQu6R3LjPm67uFoi3D59OdErFE3QbDDvI7S6qLKsNIBoOdaJ5FB1qdZEwi7Ihynru6EsXB2v0pUaMvIgNigGHZkxB16TAsRYRQVEObxVEToh87Ft5lW2q3MD9Bt9iJoxAUbl+n+hDcm3sDGa4crqAE6I9A5MGPvuApLidcfSDAbYe6iiVA0IeNrgBUJ25E1fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <chris.paterson2@renesas.com>,
        <masami.ichikawa@cybertrust.co.jp>, <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Release v6.12.34-cip3
Thread-Topic: [ANNOUNCE] Release v6.12.34-cip3
Thread-Index: Advll+HUNXJn8MoFShiYfqB0cFLaqA==
Date: Wed, 25 Jun 2025 06:11:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818B75B7CBA834088780ACE927BA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB10243:EE_
x-ms-office365-filtering-correlation-id: 18e0c28c-b7fb-4dc0-f2b0-08ddb3af2a9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bUFZTzRKcUNzZVFoZnkvaHMxOGluR3lHNGZwQW50SXJ0TE1iVDE0N2Iw?=
 =?iso-2022-jp?B?NDFjQWdPUlIzMENJdTFCV2ZQcUtlalZOUjBtcmlPTXNVZ044RTlOKzZP?=
 =?iso-2022-jp?B?Sm1TWnMvbkZiYjA1bXNQNkhXMGowYUhlbUtBeG41dGNvVUhwZktxdWRS?=
 =?iso-2022-jp?B?SzZRSVJIdXJ2aWU1RjIvL1dEWVVKMWRmd3lRc21EZ3JQdTRRdjdkL2ZP?=
 =?iso-2022-jp?B?aFhxWVlYaUxlOXM0QXRWdEFndEtYQkxCVlA3bkpSU05idU1za3M3c2hi?=
 =?iso-2022-jp?B?dGJ4Y2gyMzNrNkI0bmdET0JQTUFENnN4WERvS2VCQnMzMnllSnZqNnIx?=
 =?iso-2022-jp?B?RTRNU0tjSWhFT2J3SGFuQTlaYjFCQlhUUDNzOGNqdk1McS9PV2NuR2FP?=
 =?iso-2022-jp?B?Q09nVkZRazZ5TnAxNkpTRExQdmgwMlFLR3pkQ1FvL09sREZ1TUloTStS?=
 =?iso-2022-jp?B?YWkrRlhoSXlJdEVwb1YxdkJ0M1pJTUtQdEJwaGtaM1A4WFkxeER0dDdK?=
 =?iso-2022-jp?B?L0ZYUmJnTDhPbFNYa3pQaXVORjE1dWdxTWZ2Z1pIRmljbGkrUWJpQ3hq?=
 =?iso-2022-jp?B?V1FYZnJCdU1LZm5NZnBkamRodmNwR0lKWndrUEZMclY4UU1tWUFaYWpK?=
 =?iso-2022-jp?B?NElJVE5kNWZFVzRzcWU2TlZQT1JyVmN4d0ZoVm1hcmlhUDlYNytTZ0F6?=
 =?iso-2022-jp?B?czFiM1BRWWFhcXV4WWpMSXJMZnprSFBDM3E3VzJUbU5lYngvNzl1MzNE?=
 =?iso-2022-jp?B?VUJZRkZDWTViYVovUlhCSjVmUFdpR2JDWVk2dWVHcHQ5V3RieWcxR1Ra?=
 =?iso-2022-jp?B?aitVWWhkUk15R3ZNTVBST3VNNDZ5d2JPd0NhcTRNT0JCMSsvUjk2S2lM?=
 =?iso-2022-jp?B?K1hqRUkrdEwzWENwVld1Y25vSjgrbnVuVGFGSGwxb0YzR2p1Y3hwWi84?=
 =?iso-2022-jp?B?NGlQckpoYWpFK3JKR2t4NGgzRGU0TFJjWjBlRitDSmZYcjdPZDdsUGJy?=
 =?iso-2022-jp?B?K0d6ZnVqRUthMTlFSTRwaGF1NVVaNk82TUQ0ZkxLUUdWTVlOLzUxVHMw?=
 =?iso-2022-jp?B?d21FdWVzWFcxWmtCc09TNlpVUlJxeEMyQ05qanNXcGNEOGt3L3UxTVV1?=
 =?iso-2022-jp?B?bUU4MUhOYTMzY0ptY3pFdkIvcUxBckZTem9PMkxnL3d3ZmRzSmp0azFz?=
 =?iso-2022-jp?B?WVRLV0YwVUZXTCtRWERzaytmSDNKaE4vWGx5YXZhQnhZeHhwUTZzZUd5?=
 =?iso-2022-jp?B?cGpaYS9waE1nLzhVQUxQdlRiNGhhVHRkUTJDc2ZndjhTVXUvRmNxRmVX?=
 =?iso-2022-jp?B?NG1vMlU0T3JQOVB6bldUUkJEdUpaV3lyWlYyY2JtRGdJT29tSFVNSitT?=
 =?iso-2022-jp?B?ZWpGZEloaWdEWTg2dklBTlBIcmRZNkt4bE5wZ2pRTDE0TFUycTNRQ0dp?=
 =?iso-2022-jp?B?Vm9XZm5ud1lDdGIwL0FJWUljLzlYWVRKZElja2dmdWp2am9OZU5PRm9w?=
 =?iso-2022-jp?B?OThwLys4UmIvL0VpVlBxUFlZNDdMNU50YkRzRFVVb0ZvVlIzeCtkVDBs?=
 =?iso-2022-jp?B?WDd1aUxmL1JMQnhaNjd3Z09ZRExmc0E5Mys0NmhSbk96QU5jOFJhYUMz?=
 =?iso-2022-jp?B?dVdtcy9NRTBrUjJlMSs1cmFmd2laVUpwOHBhRWRhMDRSR3lva2pOeTgz?=
 =?iso-2022-jp?B?a25mV1lQOWNLRVB1QTliU0tITXlpRys4cGRlSWtiejE2TFlRL3VIK1BG?=
 =?iso-2022-jp?B?elRUcUx4Y3hLd1g4Rjl6LzNGZklXMkErKzJiLy91ay9PWGt6aU5BbVR5?=
 =?iso-2022-jp?B?REN4TVlUV1BIVWJNQ0dCREFtdlhMYnQ1aTRLZ2owN0llMzFjdGY2N0VQ?=
 =?iso-2022-jp?B?L2w5TUJhZWpxL1AzV2U4bXFwZ0Fob053VmNwUVc1di93U0ZvR2R3aTZU?=
 =?iso-2022-jp?B?bVg2c2FlNWFMeXFkcHZQVElSUlNndWVFQjNwdFNSS044V2NpU25nMnF0?=
 =?iso-2022-jp?B?UkNJMkNtYjhiaDFEd05SL0kzdVlLN1ByWTBhQWxZNGkvelZMN0dTMUhM?=
 =?iso-2022-jp?B?TGZUdml4Rk43M3JkVVowM1lEb0NTRVJlYWxFTnhOM1V1dWZoZmRTdTN1?=
 =?iso-2022-jp?B?QVl6Um8zZkMzV2N2REZKZWpvb2VKWHNnYVpRUWJiTTlZQ3ArV1ZhcWZH?=
 =?iso-2022-jp?B?d1RzPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZGF1VlFLUVhrM2JEQnp2UGNZdnI3dm5kMjMwbUFzS0dyeTJPYzVLdkJp?=
 =?iso-2022-jp?B?WWUrU2ttWVQ2QTNEOWtqN0lDQ09FZG52OUZoekpvNkRDNkFkcnZURGRC?=
 =?iso-2022-jp?B?TGN1VWt1eVcxcXRNUkFJbGkrK1NobGlMdERCaXAvWTQrTUtoTkw2Rytp?=
 =?iso-2022-jp?B?YzdzRG56YmJXSHRFWmRPejRERnFYanVBeDBKMEhVZk1SRVlaR1JvM1FS?=
 =?iso-2022-jp?B?SG16M1ZOWC9yQm1PTUNFWlhHRWd6cGkzNXZQR1pjeGRtbUduUEljODl1?=
 =?iso-2022-jp?B?ZlZTVDQwbEFEMGZ0ZjRwODdhcDBxeFU1aUdZQjZ3MkM3blE1MFF2SElk?=
 =?iso-2022-jp?B?WFhMajRJaUNodlIrRGZoUzJmSHJBZnJZY3RHWlF3N1RuTHBPTWtMcEg2?=
 =?iso-2022-jp?B?Kzhud1VSeEJNdkRCdkljaXdTNjc2dUVsOVB0bWlwMXVUSWUwaVV0VUlD?=
 =?iso-2022-jp?B?RmRLSDhPY1N0TCswS1BSNEdLVXYrS2tRNy9TNXZtTGZHVUVNa2x6M0s2?=
 =?iso-2022-jp?B?cWVPUHd4Ukc4VHp5RUk4SUpJTEx2R1ltTGVjM2ViRmVEQVRHYnhUdkp4?=
 =?iso-2022-jp?B?U25BZ0VCNkFyd29uaGg1aWFNNWJ2TVIyK0V0T241TmpEb2JuZVNFUlhu?=
 =?iso-2022-jp?B?L2NOdng3MEhGSUFoaVdSeHJkVjRpaExLR1RnVlpTZ1NYZ1pWVVJyeFdn?=
 =?iso-2022-jp?B?ZUVwbjNpY2JXRE1yRktKK1NSc0xJcnhUaUZldGgzckViOXRBeVRGYmRH?=
 =?iso-2022-jp?B?V3BQTXFLU2wyaFJ0M0Y5UjZxZDNmTFZweVFmZUhYMTJmUFdKRi9LWS9T?=
 =?iso-2022-jp?B?Q2wyL29TT0pxbnlScG5OeWVUdE9PMkZleWdHOTZTUkh4RjJsME1zNkNR?=
 =?iso-2022-jp?B?dzh0L0NCNGlIRlF5bkQvaHVMNU5FWlRqaC84KzQ5MTFNYWQyd3M1QXdZ?=
 =?iso-2022-jp?B?MjhwOHJBR290Q1dqbkdCV09EN3UreFkzTXVsdGEwUFdOTW5aTHY3aFIx?=
 =?iso-2022-jp?B?eDhnUmU0bXhjTzI3djFKSW9lVkQ3MlB1Vm42S09BLytWSlBhT1pyRGRL?=
 =?iso-2022-jp?B?VDhxYk5obUhOYW1MMmsrck5YVFNIQjVYYjl6Q3AxN1RiWnh1NXlhOVRG?=
 =?iso-2022-jp?B?K0RSdFFhTEEwWHRuOXA0MXRQMm9Cc0FXblhmekZxMWc0SXZTNDJ5Y2h3?=
 =?iso-2022-jp?B?NExRY3ZnNVpabHpMbGtWcjBOQmVkOXltdHVDdGZtckRLSE5iMXp6eExk?=
 =?iso-2022-jp?B?R3RWeTc1WGNmeVZBZForT2RVUlBYTFhnWk8wYkhHcnBaQml4R00waHBP?=
 =?iso-2022-jp?B?NGFUUFJNK1k0eitSdk5zdUxEeXRKellRdUdKeDFuV3E2Y0wzUnl0Qm9j?=
 =?iso-2022-jp?B?bWc5VUVvWnRzYWY4RytoYVFqUUh1ZEcrKzVxM2xZN3pkT0RRTmdETi9v?=
 =?iso-2022-jp?B?bW1HS0Y3cEE2UnlwMVJrVzJGSWo4UmRuTmhJTEYwcU5XZ0tOVTRWSG1m?=
 =?iso-2022-jp?B?V0xPdm9FMEk5b3dzSW9oeDdBeU9xS1lpUUs4RktWMENDUy9MaVhvcVFK?=
 =?iso-2022-jp?B?NUlyb3hVR1dyLzZsRXZIM0hUbUFwZEFhOFEzcFFZeTEyaG9DNi84akpt?=
 =?iso-2022-jp?B?dk1DUlZzQTJFMmg5dVJ2K0NTd0lHTzBmS2ptam84eGdOMnV2OWk1TDBP?=
 =?iso-2022-jp?B?aDQ1Y1pFUStvSFdrMkFzNzdBYXAwYlJFanhLVzgvSHFRVms2NXg0YWhn?=
 =?iso-2022-jp?B?dk1OQmhiYzlwOE40ZXRqOXFzWXpidGJySU9hQndCZU9LQmtTSFg4Vkh6?=
 =?iso-2022-jp?B?blhHNkNxMVVsbWpZYlhpbjk4dUkyTW5qcVo2cmM3V2EwdERINnJ4TVF5?=
 =?iso-2022-jp?B?Qno0dmNWR0JxM0RrcndzVDd3NVhNWFlENzVBMm5pS09VMGpTM0I2UDNG?=
 =?iso-2022-jp?B?WFlCYXYzVVQ1TkEwZkZ3UGxLUnYyK2lmVVpiTENmY20wTTdWQm8wejRS?=
 =?iso-2022-jp?B?VEdBOEF1OFFsUWtNbWloY2ZDdEQ0dStXUkY0NDNLSHRETkViQ0RvUjdF?=
 =?iso-2022-jp?B?OTdTR3pIWkIxTmp2aEdNSWdwc1FzT21hRy95cWpSaitzdnE3MXgyTnRl?=
 =?iso-2022-jp?B?VEhKNmQ2N0I1RWJUWU1tV1hYczlqM3ozRUhwUHV4a1pPWklSci96ZmNt?=
 =?iso-2022-jp?B?R3NuNDhpU2w1aCtXdHBVVnFSTHUxRTN1N2czdTlEWEI1L2hnU0dSUi94?=
 =?iso-2022-jp?B?K0M2MC85TjI5T3B3OW1OZXQxcEg0cFJrQy9PUmFWc2xmblBDQjM5VGRR?=
 =?iso-2022-jp?B?bUlZOTVRcVk3ODlIb0xNUU5mZmIraDAvb0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e0c28c-b7fb-4dc0-f2b0-08ddb3af2a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 06:11:47.1719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owYfTkO/6BdRY5S+v/04YkpYcKlLWaOOA/h7aRSdzTo17fOXv1AHYOXvlaZ7q04IG93JszBoqdD7Z3icbNKxc3Z6mKc1xVkFiUvYzjE7JMuVIfZBVuQxXkC4FJbz9U6G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10243
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Jun 2025 06:12:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19230

Hi all,

CIP kernel team has released Linux kernel v6.12.34-cip3.
The linux-6.12.y-cip tree has been updated base version from v6.12.32 to v6=
.12.34.
This release includes updates for IIO, WDT, and SDHCI for Renesas ARM64 SoC=
s.

You can get this release via the git tree at:

  v6.12.34-cip3:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      177a618ddfacc9b65ef4c532a0e3b35c46979eb6
    fixed CVEs:
      CVE-2025-22122: block: fix adding folio to bio
      CVE-2025-22123: f2fs: fix to avoid accessing uninitialized curseg
      CVE-2025-38083: net_sched: prio: fix a race in prio_tune()
    added commits:
      CIP: Bump version suffix to -cip3 after merge from stable
      arm64: dts: renesas: r9a09g047e57-smarc: Enable SDHI1
      arm64: dts: renesas: rzg3e-smarc-som: Add support to enable SD on SDH=
I0
      arm64: dts: renesas: rzg3e-smarc-som: Enable SDHI{0,2}
      arm64: dts: renesas: r9a09g057: Add support for enabling SDHI interna=
l regulator
      arm64: dts: renesas: r9a09g047: Add SDHI0-SDHI2 nodes
      mmc: renesas_sdhi: Use of_get_available_child_by_name()
      mmc: renesas_sdhi: Add support for RZ/G3E SoC
      of: base: Add of_get_available_child_by_name()
      dt-bindings: mmc: renesas,sdhi: Document RZ/G3E support
      clk: renesas: r9a09g047: Add SDHI clocks/resets
      arm64: defconfig: Enable Renesas RZ/V2H(P) Watchdog driver
      arm64: dts: renesas: rzg3e-smarc-som: Enable watchdog
      arm64: dts: renesas: r9a09g047: Add WDT1-WDT3 nodes
      watchdog: Enable RZV2HWDT driver depend on ARCH_RENESAS
      watchdog: rzv2h_wdt: Use local `dev` pointer in probe
      dt-bindings: watchdog: renesas,wdt: Document RZ/G3E support
      clk: renesas: r9a09g047: Add WDT clocks and resets
      arm64: dts: renesas: rzg3s-smarc-som: Enable ADC
      arm64: dts: renesas: r9a08g045: Add ADC node
      iio: adc: rzg2l_adc: Add support for Renesas RZ/G3S
      dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3S SoC
      iio: adc: rzg2l_adc: Add suspend/resume support
      iio: adc: rzg2l_adc: Add support for channel 8
      iio: adc: rzg2l_adc: Prepare for the addition of RZ/G3S support
      iio: adc: rzg2l_adc: Enable runtime PM autosuspend support
      iio: adc: rzg2l_adc: Simplify the locking scheme in rzg2l_adc_read_ra=
w()
      iio: adc: rzg2l_adc: Use read_poll_timeout()
      iio: adc: rzg2l_adc: Switch to RUNTIME_PM_OPS() and pm_ptr()
      iio: adc: rzg2l_adc: Simplify the runtime PM code
      iio: adc: rzg2l_adc: Convert dev_err() to dev_err_probe()
      clk: renesas: r9a08g045: Add clocks, resets and power domain support =
for the ADC IP

Best regards,
    Nobuhiro



