Return-Path: <kumar.dinesh.h95@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820B2C982FE
	for <webhook@archiver.kernel.org>; Tue, 22 Sep 2026 15:04:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12680.1790089446646902544
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Sep 2026 08:04:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kumar.dinesh.h95@mail.toshiba header.s=key2.smx header.b=Yn5DJZsM;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: kumar.dinesh.h95@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=kumar.dinesh.h95@mail.toshiba;s=
	key2.smx;t=1790089444;x=1791299044;bh=FK9Y2jHOgwAJ8DjZ6wtqMstPH+ku0xBKjdyMaNy
	NH98=;b=Yn5DJZsM1TbeCdj6qOU6GMfiYylbhgnlfaxV+lNddjeBdypRYCbsYa0k5XXgko9S+eTZ+
	PIz+0RBtNRMc4f2Rzqtsuf2VbSyUtLDpLk5pSg3cICNDcDu8mybWJ+bqXaGO81mFo/5C3Uw4TdRMr
	C2LKlocMl3X6BjHkLlRnRDai0XaMLOSsIhQ1WwNx/PPNXd93NVzxrl3a+1vjuRY7L/gheLqM56Zb8
	CttTU2eMkvveTSIc2q1zJMGAmU3xe+gab0pHKK1q7vi8rZ62bWTY6SJjjq7PuaVi1PiUG7YrnGsUY
	cRpPawSkc+fJ6FSBIAs5t0AmTSKd1bBao+Z9UCMPRA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 68MF43BZ3264746; Wed, 23 Sep 2026 00:04:04 +0900
X-Iguazu-Qid: 2rWgdPSREB1ot2bGNM
X-Iguazu-QSIG: v=2; s=1; t=1790089443; q=2rWgdPSREB1ot2bGNM; m=YAjezaJbuBtyFFrsGDzd28H2DL2aZpOr4KN36JHCWis=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hq3Jz18P5z4vym; Wed, 23 Sep 2026 00:04:02 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhWC/rbVKvtK3oSfT2iskYlOHyW7yy3Fia7vMHoYXoEJkN6H1ZAL+UN8afYyLCUAxuDbi5q4IJsA+0INJDFKy8TuH/x6GkFmUyIBxG+VMcpKieVp3DN5fOFZheuDU/yOjeClEAbxClwrvUO81PDoI1SW1FGsZaWpzlCLvnjujhgKX1a0gdX17BbDF+VSiaJZbPfwPIYxNe1WhXuBAvg23qpV+CdSbm983/FRWS1vjr6gilvXRgrY7FrWA35JbVsIDoSmOJv3NfIMD4xYso+S3oUYbdPrRzAyHtJ/a/gZvRkbNl8K16bbdE4JkVPTLrJizBnq+uuDO5Bny4XgGOySjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FK9Y2jHOgwAJ8DjZ6wtqMstPH+ku0xBKjdyMaNyNH98=;
 b=i1DvsktGiXpDHIhGD4MMEssO75RbK59QS1NzNaXazq+iwMeehpAAHIvFZ6fbsiEqZSFQr3PwCjEJ4nb3ufn+Efpf584fAiv5xPwXUzVrwYXQOY//1LrA5/yyJ79FEJYIuPl4cB/sKizDUoH1Usbahed9lTQqZD7hpdlQizpnjrbWOV7DEvi8h39ch919wfj/04rA3E0E3RHgM8FCTYb+bG+2BXpzeWC2kzKa9swGlPDTwWnW4e49oUS1SDfizLJKDRu3LwAbDsUyAVM4n3EEncdeSW2KcgrEkltyIw6cwtvjxz3sO3hapHIiPFvCfru+T4psF1EiRWwq56uG6diLJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <kumar.dinesh.h95@mail.toshiba>
To: <felix.moessbauer@siemens.com>, <clara.kowalsky@siemens.com>
CC: <jan.kiszka@siemens.com>, <quirin.gylstorff@siemens.com>,
        <adithya.balakumar.f33@mail.toshiba>, <cip-dev@lists.cip-project.org>,
        <kazuhiro.hayashi.f74@mail.toshiba>, <pasquale.nieddu@siemens.com>
Subject: RE: Technical Showcase at ELCE 26 in Prague
Thread-Topic: Technical Showcase at ELCE 26 in Prague
Thread-Index: AQHdOrPL3byzwBA5jkC8W9/stittPrbazfbg
Date: Tue, 22 Sep 2026 15:03:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSZPR01MB8515FFD1994E7124AED5FFA5AE832@OSZPR01MB8515.jpnprd01.prod.outlook.com>
References: <061493623afc73d341909da51c685e87e3fc8fa0.camel@siemens.com>
In-Reply-To: <061493623afc73d341909da51c685e87e3fc8fa0.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8515:EE_|OS7PR01MB18086:EE_
x-ms-office365-filtering-correlation-id: 0355cfdb-1801-4387-7ae6-08df18babb95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: 
 zKyKfriWOXNyRDpShZ/3UyBd0hu2T7zfqfnSg7ptHWNydBbWFiiKCBwGzq5dyf8y74MNE6FInhCOnl2XyTYUrb2amawHee3JtKOigsef0ZJfj4qSjSuVnhdn4K0cCdhIlVRcAZoNn63pOKncyppvk0tKGLPWiQ5YD6yrNfb68m8CAYkAPXLvj6veGyV4buhi3GIgMh9vsoQMVm8JNTKLP6Wtajqs0bRznIJ+6FEenj4KxFLtReIUs5kT8nKeSSSUUFmgEFmRmLRf9NtUEfKSUNRCks3DIS1RhV5CwJDZm6A4aDGCgyRRd7Xuzc9B+8Qc3V8v3S8cNBGFgBvkNrK40YsABGCB4mlY6HKuPKcUI0tYQRsTELCspC3/6nfPp02FqZtVgOvopQQMkfyPSPwyW7oWKfiIUIsNqOp6ySdNEh/Y1beCH/sx0zDZ1Nv7tMIWzoW/vckIAp09jjIYMJiYwmgAvlMMbiMIKwgCwdjLOFjWwwmomJwNc5xgP0pZCe+7Mwg0Ii9YBGPR05DcihQrGi3mI2oQ+SuHLiL+BYjZV7VTQ9GJyNf46Qricd1/RbFOgAnrH+VhDU6Li1t+cMDPhWC5Yr4XfrIyqF0Gx27OULFCkuj1d2yI1f85cxGM2nuL6wzopcbeFPR3rvY3rF+ywJOZyjh6t7fdBJCZpXd/E1I=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8515.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VkRzcUNEZTFIZ1ZnMUdKenRVR3Rudk5LL0JxejJJdm9lcGNDL3ZwejBsaC8v?=
 =?utf-8?B?aDJpcndOdGZPSkxNSDZkQ0RRY2RtQnJVWmZ1cmIwRUxCS1BBTUdQY01aOU54?=
 =?utf-8?B?SmYxeXpRMTdRYmlrL2p3QzVZNEl5em5BSUtqMUpKaEVaMkZpWGd0RGVUR014?=
 =?utf-8?B?RXVNaWZyWFZYbm9iUW1abWVES1duMGUwZEtRMG95eHRhaW1NcTh6dTl1dkJ2?=
 =?utf-8?B?UUpJRTJ2TUM3eWJENVNaajRxb3MvYjNrRU9lVHE0SFVIVWVvaVcxMVprYTJ1?=
 =?utf-8?B?aGs0dVdxbTgxUXVUZDRFR1Q1d2Y3Q1l6dHhnOFE3ZG5JMnlFSHd0SHk5dUhu?=
 =?utf-8?B?MkVEeGt3c2tqdDUvYm5GZnBjbkVWZG0yTWlPWWtiaVZnbVJLSnoyMjRPQUt2?=
 =?utf-8?B?a0diQ25aR3MyOWQ0M2VJSXMwaHB4V2VHSWxCbk1vUHcxdktOTllLZ2xGRVk4?=
 =?utf-8?B?eEgxRWtjMnN3WStSb0ZoTVVkdG1Yb0hIY1BNY2NDbmRuTnIvUVdMdGdaeXlS?=
 =?utf-8?B?ZDlrK1d1S2FJM04xYnlHaG9qWU9nWS9vdU15V0pxTFAyQ28wVzNWS0JWcnp5?=
 =?utf-8?B?Tlk4b3lWeHRvMm9vd2FYcnZmRTlOd3hZMjBhL1NHUlJQY1NpUkpHUjhUd3I4?=
 =?utf-8?B?YTNpcXBiL0MyaFgzc2xJTEZ3STVrRHNuUy95ajJxQXJBQ1c0aVJVL3loL001?=
 =?utf-8?B?Q1V6Rk1tQ0F2ZmliMU9aMS9nOU44QTFrU0paY3dveDNiN0luZm9LL1dZWHdP?=
 =?utf-8?B?Mk9pZ0Z5b1RScGZFM0xxcjdTN1ArVDN3MnVvZTJMcFNobkkvUUlXNVFGRkF6?=
 =?utf-8?B?dENkV2JmcVB1WjNKbWpyVzNpMTN6ZjdzdVlVR1dqSXRWRHpwQkEyZWZVeCtG?=
 =?utf-8?B?UDQvR2NROFhvSkV1MHBXUnYvNXJNdlkvTGcyNEFvT1l1bTFObUlPNFVzbjVx?=
 =?utf-8?B?djVUTU5VMkJuMkZrSlZGSFhXdExQN3hyOEZhOTFpSVpoUjFKNzhMb3dUZS9T?=
 =?utf-8?B?RmROc3ZOQys2Mi9kS2lYY3B0OTRPYU0vdW9qS0pWN3RlQjRIa2tmaUluNmtM?=
 =?utf-8?B?MDhxN3FTUTRLamtEOSt5VVZqMGxsQisxcDBmVEczTkNrWlRENEpqSUZLVFVD?=
 =?utf-8?B?OFFGelAyOFlwMVkxV2ZSeHA4YVRIOGJwOTllMEJpYjI5T1RXR29ZaWptdk95?=
 =?utf-8?B?U3NXTEN2V0lmeTRFaytiWVFoVjVZRCttOHk4ODBsdFpEbHM2c1drc0pjN0ZG?=
 =?utf-8?B?amdoQTBETERDYkI4V3NmUWpiQW1qMTZod1VxSzhjR2lTZzZBSVFCbXJVL0gy?=
 =?utf-8?B?Wk5CS0FySkkzSHJmc0tzK3IyWjVMclJqb3dROUlQR2ppbDlHNUJJeU5NdENZ?=
 =?utf-8?B?RzJDN3hiTjVNRUhNM1B5K3QyTDZTMEkxczBtbU8wNXFjRHZseEJyRE9pcmdo?=
 =?utf-8?B?Mlpxd2JYT0hsbjdDMGtFTm53cituRWFyZHFJWmNvY21tVlB0c2dRcmVrWkRo?=
 =?utf-8?B?dUVxWlVvT0lSQTB5dk9ZdlNXZDJuV0xSYWJ2eXlnRzUzdzArcklFZGptYnJn?=
 =?utf-8?B?WDdRL1pDQkRoUFB3UUFUTENyTU4zNnZxWTArSHFIQVVyakpFZjEySHBYQ25h?=
 =?utf-8?B?UzlBT0Npd2t0bnY5VmE1d01jZVJISC9NRHFybDduSE9uQzh0cFhTbUlDTkZV?=
 =?utf-8?B?OVlzMmFrYUxuM05iQlNveUx5QVFsNDVjK1ZVR3I5TUNHT1VoUE5uNENCczVo?=
 =?utf-8?B?ckxPcTI4aTJHWG1LMEx4KzR2b0kwOXJiRWxUdjJBYVpNdmY1dE1lblpDN2Zu?=
 =?utf-8?B?Z2FTQjZNZktMU0w0WW9wZmxUOXpKTG9QWWFDcThMdnNOb0NOa1laaWEyRGRu?=
 =?utf-8?B?Rk05WEUyQS9RWFJXYnJ0alZyd043d1BNUkkzZkppVW5PbjE3VU53SWZqeUZs?=
 =?utf-8?B?c3V6OWxDV1dYN0dmNmh1a1hZVEs4VXFRKzZMR3VURld5aXp4MUNHZEU0NDE4?=
 =?utf-8?B?VFQwd0ZJN3VmWkhJbWZXWDhvV01HME5wVW5FaEpuZ0Q3Tjg4OGphdkNveWdq?=
 =?utf-8?B?SEpBczFwZWtqdVdqVWdacE0rakdlb1pYSVBCcGJFWTgvYVVNcFlMbVBSbm9C?=
 =?utf-8?B?V3hQNU9ReWxwUGMwOWpFQ0pkUlV1cmVaLzZYZGVFSW13S2MxWGtabWZkSGsw?=
 =?utf-8?B?cUdCOFdWenlhTWhPQkRLYVZlU1BTU2tON1U3Q3pqUitZSGxhWGtoNUlyQ1Vw?=
 =?utf-8?B?d0NhbkJlZk13ZHNQR2t3S1g5ZG1QRXV3VmF4b1prRmZzVTZ0MmJnZzFEc0g1?=
 =?utf-8?B?NGZ2ZUJ3RlVRY2lOR1E0ODhWSHRYaUhONmhaMzU1bnhhVGs3MFBGdEE3ZDNM?=
 =?utf-8?Q?QgPeDN9lMyfw8fD8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Nzd1tXo1hKzV+ERa/xIRpTDh9RDqrq/olJhgvelT4vBHyUmz5ueKmrQPxbFkPuYA1bKictQrdhexUl+4yZVDrf6/j5iVbgRV54lNCr+Catv+fIDzHZNnSIXmVE2z+r5oNNf7F8Brl/W/dF0kGqU1v41vUcNZzoFhBI2mcuyMxZ6q2Y58SADGZjXhuMU900pXigqH5iEY9YPk5QTn4MCpsioalKjF2fIOR/oBIcoSwRW0GuvC9JN19V1V6CnH+/7kRV/xVtgQ2auZV88FAXIlLZxZ6zTivvAud3uTZvyoMTCo/UxrdTYU1iUcL1dWoRSRz4erVE7cLMO4lS06RMtQuQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8515.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0355cfdb-1801-4387-7ae6-08df18babb95
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 15:03:59.9622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0JS37hDHalOstHoX1CBiHouSwrxiBjw17TQ8Xxym8yRTWG/XVBYxcDkGhEOIpYXFZRXIwqjMPrRBeVIjJGzHWm3ezprJbcqU+rFNjv+UO90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB18086
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Sep 2026 15:04:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24266

SGkgRmVsaXgsICBDbGFyYSwNCg0KSSdtIHNvcnJ5IGZvciByZXNwb25kaW5nIHNvIGxhdGUuDQoN
CllvdXIgZGVtbyBwb2ludHMgYXJlIHF1aXRlIGltcHJlc3NpdmUgYW5kIG1hcHMgZGlyZWN0bHkg
dG8ga2V5IHRlY2huaWNhbCBDUkEgcmVxdWlyZW1lbnRzLg0KDQpNZWFud2hpbGUsIFRvc2hpYmEg
bWVtYmVycyBhbmQgUGFzcXVhbGUgYXJlIGRpc2N1c3NpbmcgYWJvdXQgTS1DT00gKyBzZWN1cml0
eSBpbWFnZSBkZW1vLg0KSSdtIGdsYWQgdG8gaGVhciBhcnJhbmdpbmcgTS1DT00gaW4gUHJhZ3Vl
IGlzIHZlcnkgZWFzeSBhbmQgUGFzcXVhbGUgd2lsbCB0YWtlIGNhcmUgYWJvdXQgaXQuDQoNClBh
c3F1YWxlIGFuZCBoaXMgY29sbGVhZ3VlcyBhcmUgd29ya2luZyB0byBwcmVwYXJlIGdlbmNtcGNs
aWVudCBmZWF0dXJlcyBkZW1vIGFuZCBzb29uIHdlIGFyZSBwbGFubmluZyB0byBmaW5hbGl6ZSBj
b25jcmV0ZSBkZXRhaWxzLg0KQWRkaXRpb25hbGx5LCB3ZSBhcmUgY29uc2lkZXJpbmcgaWRlYXMg
YXJvdW5kIHNlY3VyZWJvb3QsIGRhdGEgZW5jcnlwdGlvbiBhdCByZXN0IGFuZCBmYWN0b3J5LXJl
c2V0IGFzIHRoZXkgYXJlIHN0cm9uZyBjYW5kaWRhdGVzIGZvciBib3RoIENSQSBhbmQgSUVDIGNv
bXBsaWFuY2UsIEkgdW5kZXJzdGFuZCBkZW1vIG9mIHRoZXNlIGZlYXR1cmVzIG1heSBwb3NlIHNv
bWUgY2hhbGxlbmdlcyBzbyB3ZSB3aWxsIGNhcmVmdWxseSBzZWxlY3Qgb3B0aW9ucy4NCg0KU28g
SSBoYXZlIHNoYXJlZCBjdXJyZW50IGlkZWFzIGhlcmUsIGtpbmRseSBoYXZlIGEgbG9vayBhbmQg
ZmVlbCBmcmVlIHRvIHNoYXJlIHlvdXIgaWRlYXMgaHR0cHM6Ly9kb2NzLmdvb2dsZS5jb20vcHJl
c2VudGF0aW9uL2QvMXJHV1R2SXo5X3NtNEhKdVBVcFFQVkEyYnA4WDRZUmFfL2VkaXQ/dXNwPWRy
aXZlX2xpbmsmb3VpZD0xMDk3ODE5MTQwNDc2OTczNDQwNjEmcnRwb2Y9dHJ1ZSZzZD10cnVlDQoN
ClRoYW5rcyAmIFJlZ2FyZHMsDQpEaW5lc2gga3VtYXINCg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBNT0VTU0JBVUVSLCBGZWxpeCA8ZmVsaXgubW9lc3NiYXVlckBzaWVt
ZW5zLmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyLCAyMDI2IDE6NTAgUE0NClRv
OiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KQ2M6IEtvd2Fsc2t5LCBDbGFyYSA8Y2xh
cmEua293YWxza3lAc2llbWVucy5jb20+OyBLaXN6a2EsIEphbiA8amFuLmtpc3prYUBzaWVtZW5z
LmNvbT47IEd5bHN0b3JmZiwgUXVpcmluIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPjsg
YmFsYWt1bWFyIGFkaXRoeWEo77y077yz77yp77ywIO+8pO+8qe+8tO+8o++8v++8pO+8qe+8tC3v
vK/vvLPvvLQpIDxhZGl0aHlhLmJhbGFrdW1hci5mMzNAbWFpbC50b3NoaWJhPjsgZGluZXNoIGt1
bWFyKO+8tO+8s++8qe+8sCBESVRDX0RJVC1PU1QpIDxrdW1hci5kaW5lc2guaDk1QG1haWwudG9z
aGliYT4NClN1YmplY3Q6IFRlY2huaWNhbCBTaG93Y2FzZSBhdCBFTENFIDI2IGluIFByYWd1ZQ0K
DQpIaSBldmVyeW9uZSwNCg0Kd2UgKFNpZW1lbnMpIHdpbGwgcHJlc2VudCBhIENJUCBkZW1vICgi
dGVjaG5pY2FsIHNob3djYXNlIiBbMV0pIGF0IHRoZSBFbWJlZGRlZCBMaW51eCBDb25mZXJlbmNl
IEV1cm9wZSBpbiBQcmFndWUgdGhpcyBPY3RvYmVyLg0KDQpUaGUgZGVtbyB3aWxsIGJlIGJhc2Vk
IG9uIHRoZSBpc2FyLWRlbW8gWzJdLCBzaG93Y2FzaW5nIHRoZSBmb2xsb3dpbmc6DQoNCi0gaXNh
ciBpbWFnZSBidWlsZCAodXNpbmcgaXNhci1jaXAtY29yZSkNCi0gZ2V0dGluZyBhbiBTQk9NIGZv
ciB0aGUgZ2VuZXJhdGVkIGltYWdlIChnZW5lcmF0ZWQgdXNpbmcgZGVic2JvbSBbM10sIHJ1bm5p
bmcgYXMgcGFydCBvZiB0aGUgYnVpbGQpDQotIHBlcmZvcm1pbmcgYSB2dWxuZXJhYmlsaXR5IGNo
ZWNrIG9uIHRoZSBTQk9NICsgaWRlbnRpZnlpbmcgd2h5IGEgdHJhbnNpdGl2ZSBkZXBlbmRlbmN5
IHdhcyBhZGRlZCB0byB0aGUgaW1hZ2UgKCJkZWJzYm9tIHRyYWNlLXBhdGgiKQ0KLSB1cGRhdGlu
ZyB0aGUgaW1hZ2UgdXNpbmcgV0ZYIFs0XSwgd2hpbGUgZm9sbG93aW5nIHRoZSBwcm9ncmVzcyBv
biB0aGUgV0ZYIFVJDQotIHNob3dpbmcgdGhhdCB0aGUgbmV3IHZlcnNpb24gaXMgbm90IGFmZmVj
dGVkIGJ5IGEgcGFydGljdWxhciB2dWxuZXJhYmlsaXR5IGFueW1vcmUgKHJlLXJ1bm5pbmcgImRl
YnNib20gc2VjLXNjYW4iKQ0KDQpPdXIgbWFpbiBnb2FsIGlzIHRvIGRlbW9uc3RyYXRlIHByYWN0
aWNhbCBjb21wbGlhbmNlIHdpdGggQ1JBIHJlcXVpcmVtZW50cyAtIHNwZWNpZmljYWxseSBhcm91
bmQgU0JPTSBjcmVhdGlvbiwgdnVsbmVyYWJpbGl0eSBtYW5hZ2VtZW50IGFuZCBzZWN1cmUgZGV2
aWNlIHVwZGF0ZXMuIEkgaGVhcmQgdGhlcmUgYWxzbyB3aWxsIGJlIGEgZGVtbyBmcm9tIENJUC4g
SWYgYW55IGFsaWdubWVudCBpcyBuZWVkZWQsIGZlZWwgZnJlZSB0byBjb250YWN0IG1lIG9yIENs
YXJhIChpbiBDQykuDQoNCkxvb2tpbmcgZm9yd2FyZCB0byBzZWVpbmcgbWFueSBvZiB5b3UgaW4g
UHJhZ3VlIQ0KDQpbMV0gaHR0cHM6Ly9lbGludXgub3JnL0VMQ0VfMjAyNl9UZWNobmljYWxfU2hv
d2Nhc2UNClsyXSBodHRwczovL2dpdGh1Yi5jb20vc2llbWVucy9pc2FyLWRlbW8NClszXSBodHRw
czovL2dpdGh1Yi5jb20vc2llbWVucy9kZWJzYm9tDQpbNF0gaHR0cHM6Ly9naXRodWIuY29tL3Np
ZW1lbnMvd2Z4DQoNCkJlc3QgcmVnYXJkcywNCkZlbGl4IE1vZXNzYmF1ZXINCg0KLS0NClNpZW1l
bnMgQUcNCkxpbnV4IEV4cGVydCBDZW50ZXINCkZyaWVkcmljaC1MdWR3aWctQmF1ZXItU3RyLiAz
DQo4NTc0OCBHYXJjaGluZywgR2VybWFueQ0KDQo=


