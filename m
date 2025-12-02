Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F410ACFD376
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 06:53:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2250.1764658417636281037
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Dec 2025 22:53:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=udTkaayV;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1764658395;x=1765867995;bh=
	y1RO2ha8h56leZVQu1e0Z0GDzur7t0rpSVHYadl+2Mk=;b=udTkaayVGvAYUoYXec8kEqNzBa2AKj
	J4nK7ZIZHnJibuDN8MCLS4PhFPMKnjdTbwSKI3GFD3HjA6ZT9vFOVz65lQ2D7DcRGSEmMjtQuMhaK
	c2d8vIkU60/a4g5vLZI37ywRuoGE6n+vjw59vXTL9Tin5y+vdMMmQdmBx5O8Ij7Hby8EiQy6nipoh
	/ogTqWQz8+Lurrcq885xY7rocDZW+6l52Pz0cRrCKtUll3nseFfatCXTc9N+N02cGkEryXOmB7KrU
	4iq3Yqdw4k7LWDCzj0BtaXLmpQfyL6WvMcvVT6y9E/CT77SyGkkyz3SyOjU/SlM7JKsI32Rf6J2yp
	Olcg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5B26rEx21656830; Tue, 2 Dec 2025 15:53:14 +0900
X-Iguazu-Qid: 2yAazhAVNc6qzSKQ8e
X-Iguazu-QSIG: v=2; s=0; t=1764658394; q=2yAazhAVNc6qzSKQ8e; m=FgldFBOgS/sfwqpaiI0lILN/qFCuURcb2DscyXCiWyc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dLBLK472kzyPZ; Tue,  2 Dec 2025 15:53:13 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNzyGHaOUCMIkTUzlEmLUgWElyT10ZXRNonj8Orc7sLKxrI0UurnJ0q5sqMY0TWwyldNcPokdS4cv/GYTXP0qfrOxp42JqNWcaR5Ax7SoMmS+jwbdnnb3NswJh528M2je3E3E+L3/QTLuMt00Qv6wdZ6i9QdfzpIitHt/iwSkE7I48RaQZSwSKZegmUuIoqMnY3HThmNkU990FwxjjExKVu7sN3sKZBG79hGRtw28o79mGMW/cFw2/CpdDpk5/NuueLBFGoN4n7lfpQ6mmxyfacvlckND/kEfy7MNlY00a9zJjN3uvOAVjDF/l/BnI/eOMoiHJqy8QSo4dtg3sSlTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyXMr+/DaJcYiSTumpFayRuWpWtnYjunmp2PX9oaLt4=;
 b=wxzx6bvnHUk6fJ5jepwYXdQIvCFw3kARE+/nOs/Y1meVEx8SgPeWtAmEkQi8EySOhJWNgIAu8cl/dnwZadSZKueZFLoHgM6fstXrR9ivYve7utoKKB/PGehcN/0M6+uQ4Yl0tcJ+6WyxwZ0d+kaBvazce4SRiqkAAV9KVxQK33sjqYLhG3WrjzqXU1l45EgHjWqskuEt4V44F2ymYzXdKpRGytypG4DoAq0uQNE2s0hkRQpm8lH8bTuGX+4ZvZZI8Rfa/YynQHncl5GBAKu4dovUk8VmyRuaU/n/3x9w8jNkrkm1tGaLE41kxLjPkWfscT+DgjxAZ9v2liEWgsuy0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.12.59-cip14
Thread-Topic: [ANNOUNCE] Release v6.12.59-cip14
Thread-Index: AdxjWDnh4uMfzeacSRWuLUGnxpWi5Q==
Date: Tue, 2 Dec 2025 06:53:08 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481849CDFD85EFF52075CE24CDD8A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB9995:EE_
x-ms-office365-filtering-correlation-id: 62b44988-a9ea-4fa8-f6db-08de316f7379
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WXMxUU9SNDQ5SjY1Q3dJZGlpWHArSEJ4Q24rZTBKTVJ5TTJuc3hOQVQv?=
 =?iso-2022-jp?B?cVc2NG1DZ2psQ2FVeS9CSUYvbXlLbHV0RUZuSFp3eEFUdkJEdHFuUGYz?=
 =?iso-2022-jp?B?bVd5MlJ4U1RheWkyVXgzMDFneVVHSE0yYklMSXBRYlRtZUdPVTV6bER3?=
 =?iso-2022-jp?B?NVFKWldBaWVrUGc5OXpHb0toRVU5M3ZDbnI3SWVMWFNHMXJNaWkwaGJo?=
 =?iso-2022-jp?B?Mk9qU0tJd2QxU0tVSWJlcTNIV3JQcyszVUNPTFY4Y1htRldYRFdoMnhY?=
 =?iso-2022-jp?B?L1FuSGJ0c21aTlhOSklWVThyYkdSa1poemo5TUdwL09SRkUwbWhUaDJZ?=
 =?iso-2022-jp?B?VnUyTlp6ZWdlTkNnN3o0Z1Fhbk1kUHhRSWp6VkFNTTFkeDhzMCtSTWYy?=
 =?iso-2022-jp?B?SnlmeDZKNktqdXNGc1RRNnVHMnc5UUIzanliSHRlYzNVR2ZKV2hqT3Ry?=
 =?iso-2022-jp?B?WE1IbkI0aXh6NytTSjVHWUZHTk9qSFpNdGt1bUtrakZoUHdzbFVubDk1?=
 =?iso-2022-jp?B?RFJ5VlRTVnpFR3NPaWNwM2J1eGRtR1BMeExpTGJoNkxLbDFLRThkazVu?=
 =?iso-2022-jp?B?d0xrSldBOTN4d0RJVFQvcFFWTDZGcWVzRzhPU2tUWVZFOWxmYlBSYlJU?=
 =?iso-2022-jp?B?VkdLYXZHaHFkTTd6TWZRYzQydTdLYTIwZ2dmVVJpV2pGMUVONmZ4L3VE?=
 =?iso-2022-jp?B?NGkrVTRQamJXbWNxMndUQU4xb29PZm11QUdVMzE2NDRaenIzVmYvMXVr?=
 =?iso-2022-jp?B?UFQxaGM2TGtUQlpOdlBlUUpHOCtRWnpDR3Z3R3BJWVpzVWsvek83OVRN?=
 =?iso-2022-jp?B?ZURvTXZwQlFEdzF6M0RhbzlaaUR5bHB4dVdqYjVKYzN5RjFOZ1BWR1RD?=
 =?iso-2022-jp?B?VEpXUHUrUUtGc1NZYlFZQ0FESXBrV29SZDY0aG1PSzdWZ3Y3QkRnRXY1?=
 =?iso-2022-jp?B?dExMRHlYZ2J6YUZyNEMvM2lsT1EwVWFQYTJpSEU3WTZvRjJSektTZFlB?=
 =?iso-2022-jp?B?VUhqK1ZQRk1kbmhYdVIyL3J6Z1FNZ2RJdXhDQU9VVnc2OHBRZXRGaGJn?=
 =?iso-2022-jp?B?b2J3NlZOWUNIdzJWSzJLQVlvWkJNWEpiT2dOaEpvcXZlV3g0ZXRuWGxI?=
 =?iso-2022-jp?B?aklRL09KZGRaU21KRXU5ekFiZEFuYVZuTDRCQzF4S2drbTZ5MVhOTEth?=
 =?iso-2022-jp?B?QnlpeUJ4UVI2cXRFYXk2eXNYU1IxL0ZjM2hTdy84ZzN3ZDR6TERZNEZy?=
 =?iso-2022-jp?B?b1RQVEN2MHdsalptNzVaazlPRllVNUdHYXlMMS9ya1dxWVBmeWVlYk5k?=
 =?iso-2022-jp?B?MmlmOXV4Y3d3NGY0VVAxRkdiNHdHN1kxcUZrZXdsMmIvSm1iM3hkMUI2?=
 =?iso-2022-jp?B?MG1Ra3JORVI2amZKQ3FUa0F3RDBBTFRkejJSSS93L0hRVTl0Qis0OHJm?=
 =?iso-2022-jp?B?S3cxV21FYzQvYjRaM3JFSUNDWVA3L2VFT1QzbllTNTk2eXl0VjkzSXdS?=
 =?iso-2022-jp?B?NFU5T0ZXV0JQamI5RmRZaWF5WHpBQ0hDTGFTRjJXWFN4c05EMHkwZXFo?=
 =?iso-2022-jp?B?a1ZLSHZWL3ljQTVzM29oSlJiNUZvZkVyd3krWVowMEpaSE43akh3ajli?=
 =?iso-2022-jp?B?VkZlU25nMUV4QmsweG4rSjh1UWZoekNmTkFaNTR6ZVc1VXJya0ZZWFBP?=
 =?iso-2022-jp?B?eGYzWUgwN3FnTWU0UDIrVWJBczFYTjBjMEltemp1U1k3ZDIrWGVPOCta?=
 =?iso-2022-jp?B?amJqTFJiTTYyK2d1djhYT1QxNmZrMDl3ZG9nVEdMRWxJOFozV1ArRjh4?=
 =?iso-2022-jp?B?Mml3UUJyZUUrZG5sS0JQSnRzNng3ZlYzRVVQd2RBWW5kdEpVN0lLMElK?=
 =?iso-2022-jp?B?eVhIYjF6WlFBeldKMXRMTGl3VVlJOEV5bWVVUXljcTR1OThmbDFGNUwx?=
 =?iso-2022-jp?B?SFlXdmd6ek0vNnl6R050TmhibEpLbmxqUXRrbDBORDZkTGhlaDExeEZK?=
 =?iso-2022-jp?B?eDJ1b3hjcUZ3WVBtdjUvUVh0Yy9adFliamRlL2dVcWU0cHBZWGlscVZw?=
 =?iso-2022-jp?B?V1NibGkzZE9KNDBoZHZUbk43aHFmdlh6R1pHMTZvdzRFNzZ0Y3RoeTht?=
 =?iso-2022-jp?B?UzN2eXhvVHdMQ1Z2QkpGeTRFc21ZVm9iR0FSN2ZPcTVDNjV1dWE2UmdO?=
 =?iso-2022-jp?B?YnQ0RnBGUHQ0YlJTSWcxRzUvb0NVODlZ?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TXB2OHZMTTBXRTlFNmtNNUZoWW9mMDA5bDRHVFR4MU1WREdhY3M4bmFi?=
 =?iso-2022-jp?B?WmNiSGRsNnRYNXF5UmFDNHVVTVBBZDd2VVZwdEhxNXB6WUlSRndVeHBF?=
 =?iso-2022-jp?B?NElkbjZVamRSSlB2SG05M013TU42R3l1V0JUTmhkZkdHbTNIZ1R0UjZk?=
 =?iso-2022-jp?B?NjBPenIrQ2psSkVQOXZBOCtEcU9lY3ZBMzR1SlNpUVI3Szk0WUdxZVZR?=
 =?iso-2022-jp?B?RUNkZ1dZYUhzM29aTHZHaFZkS0RhbnI0Mk14RGxiRkZUTUFMT3E0YXZy?=
 =?iso-2022-jp?B?K0RvZnM3MzdmMXc4ZzIrRHl0cG1SeWo2dksyOUswQTl4ZGZQcTZBZnBX?=
 =?iso-2022-jp?B?Sk0wWXAyZzRFVTN0S2x1ZVJuUEZQLzI2K254OGFkRVIyRHVNQlYxQXVN?=
 =?iso-2022-jp?B?NWtrMUtqd0o4TFVFYXVVQXVDWkJKOXFyeFN5dTVuVWlMRmo2bG4yR1Nj?=
 =?iso-2022-jp?B?OEFxS2VtTjRtenlOME5FeWxRZCs4eGVadi9lYWROYkYxeWhzV04vaEpP?=
 =?iso-2022-jp?B?K1BWNGVSUlJsR1BHRGYxaXlHdDFHTnNsVTVqZVpVYWVhYnE4M1pPVXEw?=
 =?iso-2022-jp?B?ZmxXV1ZNWVFPV2YxOGljb2R6eWNkdzQyUWtvbDk2R1BaU3NUY3I4cG5s?=
 =?iso-2022-jp?B?N1hSaWEwaGNuTGdlc3FtVmN5UFY4YW1WTkJuN3hjckhmWGdCQS8yMEk0?=
 =?iso-2022-jp?B?Q2ZmNWJhSm9MMmVJNnNqSm9QMSs4TXdrZEpTUTFLdzhhZEhLSU1mWUEw?=
 =?iso-2022-jp?B?NS8vQldzY1hCbXc2Tks0Qk4wcnVsOEZveGZ6a3p4bW5DK1BRU3JPUWdl?=
 =?iso-2022-jp?B?b0s1WXhGYzVyN1ZnNVlSL1Z5ZVlZNDBKclFXdjFtQi9qSXVMc2x0QzU4?=
 =?iso-2022-jp?B?Rk1QS3VoL3hPWmVOaUtVZkNMUmZScS9OUWc2bm9jWXZnUHk2VUdvQ3BT?=
 =?iso-2022-jp?B?bzNSOU9yMEZyUCtUUUF1RFhsQVFDd0xvWTZQcVBzY2J4c3c0ZFJob1ZO?=
 =?iso-2022-jp?B?ZElwZFVqWDQ1Rnk3bHdST2FDNnpmR3JpcjRRZFNpU3hkYmR1ZFRYclVP?=
 =?iso-2022-jp?B?SXNwQmZMSVB2ODRxTk13cEl2M0lzc0dqWTNDNE5ZaW0wNVBYVU9mdUNk?=
 =?iso-2022-jp?B?Wm53ZVZHTGFyR1ByK1BJSGtDeWZ2ZjJZSk9KQmlHRmVPSm5MZkExelMz?=
 =?iso-2022-jp?B?Y0IveG11YThDU01wOEZXK2VSRllMMlhwMHV6TFdQVnh6bjZxa1lYak9H?=
 =?iso-2022-jp?B?ZG5qR3pMMmNBZFlrVnRSWGc3Yi85bzBGdDg0STBNV2psNFdsWW5oQVM2?=
 =?iso-2022-jp?B?cnJZVGNkdHhhQTNPU0x5T2cwR3FKREZEZjZtZEFCV0s5Yk1uUGFxbDl3?=
 =?iso-2022-jp?B?RmswR1ZZYTNGS09EOHVRdkUvYzFrVGhSYXhNTGtnOE56YWNUeGhZRmNl?=
 =?iso-2022-jp?B?ZDdUeUN3QVQrSEZ3bVU2RmE1bjlUeGJ0RHdnM3VVZUREeVhWQ1p3SUFU?=
 =?iso-2022-jp?B?Mk8zbUN2VkZXenpta0t1NndValozellTTzZNR2tGOWorVWdvZzNaYnZO?=
 =?iso-2022-jp?B?dkRxZGZmQXF4SlNpQkRTZDRBeHJtL1dKQ0hGNE5la08rOThxNzJKYzRR?=
 =?iso-2022-jp?B?MW9pMU1VZXg2TE9NOUJ0a0hvL21UN0dGMFhFQVFwWXd2b2NHL1VPeUha?=
 =?iso-2022-jp?B?NFNYS2laQnhna1NkV2laeVJ5aTdORmxueXROS09pallLQjU4WDZlbEhF?=
 =?iso-2022-jp?B?M2FhZkROaXpBV3ZHZFlETjJ6ZGFvS1QvSVZMb3Y0elFPTm9ydkNPSFFs?=
 =?iso-2022-jp?B?YVZGdWlHbGloYUc3b3JNR0xSWEJaZFA4RFlZYytta2dxMHZmSFBTL21K?=
 =?iso-2022-jp?B?c2Zzc3YwMDVKKzVZQU93bTJzWjhYQ2hjRXB4bDJCNVVCOHcwQXV0SmUz?=
 =?iso-2022-jp?B?cXJCZFlMcjZ0dFJFMk5pcStyL1RsbEhLbHRxaTZWd3pJb1BqMkZzRC92?=
 =?iso-2022-jp?B?d0p3RDFjZXJOL3oyaTlVK29MNWhqckpQUTVITjBLK3MwYWNLcnhqckhs?=
 =?iso-2022-jp?B?UUtMNlpmbWJnWWl2ckJVSU0vT25wTTR3Nnc4OXQ2QnZ4T1gzSnpUb016?=
 =?iso-2022-jp?B?bjV5c2FUbGFsMmQ5ZGVBenVmRHQ4TlFMa2pCTFdIR2FKNzIzTGFCMWFW?=
 =?iso-2022-jp?B?Y3k0NmJrVjlCS2ZsdWNaLzRtNkpyNTdDbHRNRUsySk5Bdm44akdDbE1v?=
 =?iso-2022-jp?B?QnZqZ1VTS2xhZHdrZ3ZUSjBGbW05T0pHL0ZmNm1ZeVQyakcxcU4zdUor?=
 =?iso-2022-jp?B?eS9tYXBBY2YvdUJhazNRelR3bjdWdE9pRFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b44988-a9ea-4fa8-f6db-08de316f7379
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 06:53:08.1415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +hhzEPEj6AxNIeyPFUn93F4QNt/uU2UOqjth6i5zRgqwFdJFCEPbP67uSW0YMUgtPrpv1Lpf6hNhEztzuGqoQwK+Xu+jhIl0urg9t0TGcWZo/UROMuV0ypdS4j+ctv2M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9995
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 06:53:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20783

Hi all,

CIP kernel team has released Linux kernel v6.12.59-cip14.
The linux-6.12.y-cip tree has been updated base version from v6.12.57 to v6=
.12.59.
This release applied patches for the ASoC, PHY, and XSPI drivers of Renesas
ARM64 SoCs.

Information about this release is as follows:

  v6.12.59-cip14:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      6c8999a8345015bf905b43fc7faca46313efb125
    fixed CVEs:
      CVE-2025-40211: ACPI: video: Fix use-after-free in acpi_video_switch_=
brightness()
      CVE-2025-40209: btrfs: fix memory leak of qgroup_list in btrfs_add_qg=
roup_relation
      CVE-2025-39981: Bluetooth: MGMT: Fix possible UAFs
      CVE-2025-23129: wifi: ath11k: Clear affinity hint before calling ath1=
1k_pcic_free_irq() in error path
      CVE-2025-40077: f2fs: fix to avoid overflow while left shift operatio=
n
      CVE-2025-38678: netfilter: nf_tables: reject duplicate device on upda=
tes
      CVE-2025-22107: net: dsa: sja1105: fix kasan out-of-bounds warning in=
 sja1105_table_delete_entry()
      CVE-2025-40212: nfsd: fix refcount leak in nfsd_set_fh_dentry()
      CVE-2025-22121: ext4: fix out-of-bound read in ext4_xattr_inode_dec_r=
ef_all()
      CVE-2025-40213: Bluetooth: MGMT: fix crash in set_mesh_sync and set_m=
esh_complete
      CVE-2025-40097: ALSA: hda: Fix missing pointer check in hda_component=
_manager_init function
    added commits:
      CIP: Bump version suffix to -cip14 after merge from stable
      ASoC: renesas: rz-ssi: Use proper dma_buffer_pos after resume
      ASoC: da7213: Use component driver suspend/resume
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable serial NOR FLASH
      arm64: dts: renesas: r9a09g057: Add XSPI node
      dt-bindings: memory: renesas,rzg3e-xspi: Document RZ/V2H(P) and RZ/V2=
N support
      clk: renesas: r9a09g057: Add XSPI clock/reset
      clk: renesas: r9a09g057: Add support for xspi mux and divider
      dt-bindings: clock: renesas,r9a09g056/57-cpg: Add XSPI core clock
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable USB2.0 support
      arm64: defconfig: Enable RZ/V2H(P) USB2 PHY controller reset driver
      arm64: dts: renesas: r9a09g057: Add USB2.0 support
      phy: renesas: phy-rcar-gen3-usb2: Add USB2.0 PHY support for RZ/V2H(P=
)
      phy: renesas: phy-rcar-gen3-usb2: Sort compatible entries by SoC part=
 number
      dt-bindings: phy: renesas,usb2-phy: Document RZ/V2H(P) SoC
      dt-bindings: phy: renesas,usb2-phy: Add clock constraint for RZ/G2L f=
amily
      reset: Add USB2PHY port reset driver for Renesas RZ/V2H(P)
      dt-bindings: reset: Document RZ/V2H(P) USB2PHY reset
      dt-bindings: usb: renesas,usbhs: Add RZ/V2H(P) SoC support
      arm64: dts: renesas: Add CN15 eMMC and SD overlays for RZ/V2H and RZ/=
V2N EVKs

Best regards,
  Nobuhiro


