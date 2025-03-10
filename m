Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8F9C282DE
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 05:18:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.30796.1741583929355374318
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Mar 2025 22:18:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key3.smx header.b=G5UUnmoR;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=kazuhiro3.hayashi@toshiba.co.jp;s=key3.smx;t=1741583903;x=1742793503;bh=RNf
	U5bmnSp+fNMmRkrCzS/2LzORpJ7bjKPe3V+gyT38=;b=G5UUnmoRIY6BQBmZiVXdjh0gmDRNIjUYr
	XghOy0B/3J3+fMyfVy1izzhA78AhnoBLxTOR6Mxp0Xe5MMaP/j8HOD1QjnyFaZYfOfz8jsLVj5SRK
	ybi+n16jjDn4fCipIzK7t7MG14y8ZkzAE2/gbzGN+Dm9j90A98+v5tPlrLWlWIxkwW6haU6POVHgx
	JRrT+na6NQQmtTdegzWiIhUp8lhJWYoxr3rL+eB9dNo46TA50TkescZIEygPYW8jnbi1PThMQrIuv
	F0ssk49LYlFw0pnikJp/CI9sJ6k9GUtQgju4zAsjZetfr4Q5+3evAzZxYYCe+4I26e2uDTB0Fx7Wi
	w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 52A5IMqr137190; Mon, 10 Mar 2025 14:18:23 +0900
X-Iguazu-Qid: 2yAbyr8UohkIkpHwqZ
X-Iguazu-QSIG: v=2; s=0; t=1741583902; q=2yAbyr8UohkIkpHwqZ; m=17IkrGSg3h/+PX8PG8gwggtXPakk5WmHrUI2X0J4ntI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 52A5ILG83713960
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 14:18:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z89ObizvofpHLOPg1zaiUKJbLrMAfJhtmPvbrImcR82sb6Azz5zFc/OiqCo9urNg9ca0oqnQ14SByPS6L0ghJk7B8Lz1E8OA3zQ+1gZrc0FJOzYas3w8m2bctyRjCuKWhaOEeGLk5O6p1HSkCxAEYDEWpzRJWA7mx25N4g7ZjfQCszH0EMovqslHcx9p+kjDz0Pd2QxFYJYbSvn2Uo15WVgK8ODjdBcgabc6n/fa1yYUbYvw8ZZw/9rt+Dx5PbG38gtKlqxQnBPCvO+GO6NXtL5zIrk1Kv96l/IZnEqfblcS61bPoKxVX3JFkr3aFTE8yObGBHft1ifjbKaJyRn7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNfU5bmnSp+fNMmRkrCzS/2LzORpJ7bjKPe3V+gyT38=;
 b=Sd3k8bTvdZ7eQ6Coj2tZ4Cix4qUXJe7dXN8mD6rTdCPHolcPs+Ml73HHg60HP8YimCBdASWuua91+ssB9TgY5j7kKpKzH/0bGP/+EId1XLYeawzyt9GfLIyShaF/qIZeYZ+Q8VahQ/0DTMKXhEqPG9PcVuE5G2qS4Y8RWV48yDta+lpw14Q2GUENNs3YjiCSWypp1kxWoHQ79rCJhDP95wLE+a99qSeMAER7cf75bN5atbsz4BZMiWK/6Q0wvXgOBm9RD8CWlj3qRd+TB4eLdYH63TelDVD5mrhOSiYO3QCAt5MPVB2P3wQ7/N+8d49fM7Zyysjc/boHMckVgn5ekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <uli@kernel.org>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: [4.4.y-cip-rt] Actions for fixing repeated unpin_current_cpu()
 WARNING
Thread-Topic: [4.4.y-cip-rt] Actions for fixing repeated unpin_current_cpu()
 WARNING
Thread-Index: AduRdgVHesA6lMyzSIW9gVxlWsy0CA==
Date: Mon, 10 Mar 2025 05:18:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB113856DBEC0FE3243885AABE1E1D62@TYCPR01MB11385.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|TY4PR01MB14365:EE_
x-ms-office365-filtering-correlation-id: b0d0a762-0a9e-42de-6f01-08dd5f92f86e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?V01DaElDRUVFbWZxR3FEZjNRUm5PUVBPdDJ6WkpkSG11Zk4vTUpCd1RO?=
 =?iso-2022-jp?B?S2w0ZUExZml6bnQxdCtKR1FWb05CS1lyUWxsSVpJTHQ1WmVvN3p2VXQ0?=
 =?iso-2022-jp?B?YjdPWlp1dWJzN29zS2xlRlZYME9rdThURXVIbERrc1JaZDhlTE14TkR5?=
 =?iso-2022-jp?B?eUJFZUVDTHA5NFRML01VN01WYmVPWmVXWnZuNlAyQTFOS3ZGdmRyTjk2?=
 =?iso-2022-jp?B?T25PV2dodUlZY3pwc0VaKzFQTzVGYUVQRjFzUmpzd1dVT0U2USt4cEth?=
 =?iso-2022-jp?B?bjRyYTdKZDJCdWRsRzJmZGRtMWRYWnVwV09LVkhwb0JNQW1HcytiT3Jn?=
 =?iso-2022-jp?B?Qm03eldQR012RmZWQWErbzlidjlqallVazZxdVZXVmtEblM0TU9VNWtT?=
 =?iso-2022-jp?B?TVY4TFhUNCtkbXRxS0tCS2JrRlZuRlMya3pNVDBZZmNnTjdSUzRBQk56?=
 =?iso-2022-jp?B?d3JTVVNVN1F4ck1ZSG1uVk54L0VtV3pwc0lwS0VvQzE4TkJWdmxkQ1VG?=
 =?iso-2022-jp?B?NEFaeEdDaUxHdUR1bnZCRko5WHdydzcwY2Q4OGVLVzRwaTJxaHZ4MWo5?=
 =?iso-2022-jp?B?MDNFMXRnWGFsd0pqMWZVT0tldHZPTFlvVHIxNmQ1NXZTU2FTZzlPUkRy?=
 =?iso-2022-jp?B?OW13aXhYS1JwUkpwUjhYd0NCSmxsb1J1N2lNNDFadjRKVTBScFN3enhF?=
 =?iso-2022-jp?B?SjRmMXlhc2ZuWkRZdXlaSWdkaXFtWjl2cFlBZUpNM1NzRzVKMThEeGkv?=
 =?iso-2022-jp?B?NGdkWFBiMEdCb0JIbDRmYW1YU3BRaFdCcU9XSE51WGdwblZWakZJK0Iw?=
 =?iso-2022-jp?B?c0pMcVpPc01XbmRKLy9mTVl4eDN3dCtaQWVJNi80ZXpTejJnT0h6a2xn?=
 =?iso-2022-jp?B?U29SSXVMbTlGa2plcnZnZytaZy80SlBieHBzaGpZSGtRYm5oK1poRGpv?=
 =?iso-2022-jp?B?UUE2VlRmZWVvSnhZcFViOG1wd0pTZmUwNVdycERoWHBZeWdUSU0rQ2hZ?=
 =?iso-2022-jp?B?WVpuYVBnZ21UVHY2NTdEb2JJeS9VU2lQRW10eVZyKzBqOGlKZmxlQURX?=
 =?iso-2022-jp?B?eWFoMEhTZzV5MEhqUnJDc3ZvZ1hPQ0xsREc5RzJXdERaVmFBalJUS3lq?=
 =?iso-2022-jp?B?bkZzZ0x5RSt1Qjd6MngxOG9ORFBKMmFXbVhITituS1pzTDFRcVBOVGNI?=
 =?iso-2022-jp?B?R0xVaWhZeXVlbHRjNjRPOHhJR0VPRFhkTjBRVkJ3N2hLQXVZQW4rRUhi?=
 =?iso-2022-jp?B?VkNKQk5IcEp3aDlINFUzUDVqN1FMYURwdXJPOUZOdGNtdVcwWUJBelNG?=
 =?iso-2022-jp?B?MHgyTno0MmpGUXV4YkI5STljcUYyYWlnYjVrRVQ1dWFHa09kSWYxU2Q5?=
 =?iso-2022-jp?B?V1FmQ1hxcUhDdDRXZldMdGZtSzA2MWh2c2lvVkl0aWJJUVdxUjc1a2dV?=
 =?iso-2022-jp?B?ZlhmZmdsb3FNWG9CUHB4SlMrdytIdDBjTDVxYTRiNHlIZHkxOXVBbXdo?=
 =?iso-2022-jp?B?NUhkRk1TUXNvc1pHZnVUS0lXNE1VK0NtekdNV3YzQ085MjI0NzA2V0lu?=
 =?iso-2022-jp?B?dzBHZWRTbWlwZmV3Z2tsRFhNYndKVzR6eFJxd1JFUjdLakNFZG11YmxR?=
 =?iso-2022-jp?B?SEtQZkN3bWE3YUNlallKQzcvRDAwclpYUGt3azgyRXJ6V3FXY0E5OTJu?=
 =?iso-2022-jp?B?YmlmNDRKV21HVFdtUzg5cFZyQloyMHFQV0NROVVLQmhJaHB2TkhkYmpZ?=
 =?iso-2022-jp?B?QkZIL1pIMy9aK2RZdjY2cDZISXEzSFF1bzFmUjkxZW9sY1F5ZzN3Smk4?=
 =?iso-2022-jp?B?Lzk2TkdJby83ZFg2RG1rM1ZDQnJZU29laGdqdlhjeFdGVXp1dDJWNTRS?=
 =?iso-2022-jp?B?QUxhMm9aNWpQL3hOYnpTa3luL3ZXSThKUlVvQm0vRnBTT0pYVEF6RVFS?=
 =?iso-2022-jp?B?YzRvVDZVcXNSRlkzWmdhdjVyREJrWDh3SCt3c3MrYlFWU3ZHZmtXVEdP?=
 =?iso-2022-jp?B?UFlNVkZ3d0E3VUpTSWpvMUhTWmtTWVVzS3M0RGFXWVZEbVQ5TzFnVTEw?=
 =?iso-2022-jp?B?aUxyc25MczM3N2VuazAzdUlxWWFSNzg9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?R3YzeVJnZkZ3VlZsSjNGL0xENVVIQU9NT0QvNFV5ckVJTVkzcGphNWRB?=
 =?iso-2022-jp?B?SlpVSmNVSmJjRFBQblBadkllNnV0WGpTa01vY05ST2JGYitPKzY0V2xu?=
 =?iso-2022-jp?B?RE1NUEloZUhOWDU4VnVPNTlZTUpkckU5Sngrc2JDa0xkQUdOK0FubUQy?=
 =?iso-2022-jp?B?VE56R1E2OXRSdTA2YkRSRG5hcDFOdllObXZTVWd5N0Y1SkZRTTZhZys5?=
 =?iso-2022-jp?B?MXVNSmYyTHAyYUdYQTFpYmZ3ZG43Q0xPVDJTRDVDQVArdnpUay9paHJV?=
 =?iso-2022-jp?B?QzIyMXcrRWlUZ1ZJY2V6UmNZVEp3ckFUQzNHWVhVQnBCNnY3TUtZOEkz?=
 =?iso-2022-jp?B?cEx6YXlvVTlId1hiejJNaG5YQlh4Ylh3amc3bEYrZUptaEhSZXllOWZp?=
 =?iso-2022-jp?B?Z01FVFlCbHBmSEVxaXJmbjY0N2h1ZkVOVnJrZmZ0eG5VVkgvaE0xRXNp?=
 =?iso-2022-jp?B?cklFeGpHeEg3aStEdGlDankrdVZleFFIbmV3bjZTZVRCZ1hIK2Vkb3hz?=
 =?iso-2022-jp?B?YitvRm1oZnlQS0FrNTE0dHBDYVRBU05NNXl1N3JRTUdHZk5NbmppTTE5?=
 =?iso-2022-jp?B?Y0xBU0l3eVhNUFNyakZERmQwSE44cXB4U1VBZXVjNWlKZlZWSnBDeHd5?=
 =?iso-2022-jp?B?ZENjRUJpRTNuUWlmM3lkRzlWWTFFWmhRUDNIQzlWQS9lN1Jma3hmZ0p6?=
 =?iso-2022-jp?B?MytvWmhXWExISXJXV1RtYmtQbmpoUVJzTXJKc01qei81TUNPQUh6RDMx?=
 =?iso-2022-jp?B?NjRNK011Mm9Yc05lWWliYkxHVkdtcXI2M1BCOGR4M1FCb05vOWxhd3FS?=
 =?iso-2022-jp?B?VTREWVo2SW5Hblh6aEc4V0tEZkxoQTVFcVVnSVdyRXRiZzhjVVBsZlBv?=
 =?iso-2022-jp?B?OFIrbktEK1JZSjR4RFBVOGVIc3VycVB3b3RobURpSmpvS3FodDNOK0Ji?=
 =?iso-2022-jp?B?Y1JQQWd4cEkydTB4K0RKMUVPQzM0T2dhR2ZOOSt5Q2czbUJ3Mk5JNFdw?=
 =?iso-2022-jp?B?TzIxTXVVb28vZUg2SlZ0am5DWjQzR2llWnE1ZThMby9YY2ZLSlFndm1V?=
 =?iso-2022-jp?B?c1M5OHpiRU1rSjlCd2Zmc1c3eEZSeHFNNnp1ZndGQWJqM0puaG0zSkVu?=
 =?iso-2022-jp?B?TVFFaUFvRGtmb3g1TU0wSU1WR1c3cVE3ZGxFQktpWHI1MjVuMjBFYURZ?=
 =?iso-2022-jp?B?YzM2d3ByMzFGN3Q3V2txQ0lvOUR2WGNLY0R1NEs0NVk5RzRXYmdIRWJr?=
 =?iso-2022-jp?B?MGYyNEhxRjZjMFNTaVNHTWQrOUIvWjFXbFQ3d2VQRDFYRkhxVFhvaVJR?=
 =?iso-2022-jp?B?YmRlOHd1ZmgvQjBrSVBsZ3FtRWZ5ZWNmUERSZTlDZG54UUd2MjIyeU1k?=
 =?iso-2022-jp?B?cHZ0VjdjTGNNWExGMVFpZ29uOGxZYy93em8rdWxyYUwyZ2pNMUVDa2NN?=
 =?iso-2022-jp?B?NjhmalZJeFhLM2ErZzVscndIdVkvS0FkbXFIMXU5SVY4OElFNWFpZ1h6?=
 =?iso-2022-jp?B?QnVhWHBwdDkxdSt1UE10Y2FQRmlib2txZ1JzMEJmNVlCZzIxQkZyczNh?=
 =?iso-2022-jp?B?QUZYYlpHclRtUmR2ellxU05RWnJJU0EvQllXaURkZ0hMOUpsamRqTDAw?=
 =?iso-2022-jp?B?NzdZOCtxSU5Zek9SS0dlMVRZR1pMb0NuWXBpZTVVR1kzVGtKMnZWSmtB?=
 =?iso-2022-jp?B?ZUs4d3pNVGhscldFbS9qUkQ2aVZldUdJUXZuNEtGelk1RVVzYjQzbVBI?=
 =?iso-2022-jp?B?My9uNStCRjd2azRia3VlczdVUFBTL1c1RUtWRDdya2o4ZEhVaUFhRE5j?=
 =?iso-2022-jp?B?dnhMakVtcitkSTZyaHB1djl6VkFzb2d5UWI4SEtCb2N6R1hTMFhDcm4v?=
 =?iso-2022-jp?B?bktHbHB2TlFtekJLd2tYWGJ5bnJxdnpqZGptYzhQRlBpU2NlaklST3Ev?=
 =?iso-2022-jp?B?bW9aQnRDL0syb2dSN3oyTjJ0K09LbmdZWVluQlBmYml6bHZCNGViS0pp?=
 =?iso-2022-jp?B?WDQvZUY2SUNQOXUzZ281bDc4SWlKaks1VnVrRkY0Sm9oeW53ZktGaW1l?=
 =?iso-2022-jp?B?QUcydVBGNmdGWSt6MHBhNlBkbjlQNU5WeTNHczl2MDZUN25WWE1QcTNq?=
 =?iso-2022-jp?B?N1NxaGN3bjQ2R1FWSEROeENxMTBMRnNELzVpMzFCQzBzRmhXb05VQ1Jn?=
 =?iso-2022-jp?B?L3ltd0VKWjM1ejhySWZyWUJaRzNLZE03RXp1T2ZXbS9mYlI0OEl2bTd4?=
 =?iso-2022-jp?B?dE9JTXVNVXRTYVhaeWZCeG1CTVI2aUlWTU9CMi9pcnVqcEN4QVJyTUJt?=
 =?iso-2022-jp?B?SUZ4YVBkWEtTNGpyV2tROGhwUjRpdkt1Vmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d0a762-0a9e-42de-6f01-08dd5f92f86e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 05:18:19.4115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZ9uDf/NwT017iaxemsFTNqBQiZQUG643RFgC+3Hba1TAMe15GPPnmqUM4Oz5zfDJrXv9Dq7ogx7P/OcPbqIWQyDyyAnldI6KH+OqZwm/DEql389nojqRboSC+lh/8jx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14365
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Mar 2025 05:18:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18071

Hello Ulrich, Pavel,

Pavel and I have been discussing how we can fix the issue [1] that
unpin_current_cpu() WARNING occurs repeatedly while kernel booting.
This issue happens with 4.4.y-cip-rt (In RT kernel, v4.9-rt or older)
and not with 4.19.y-cip-rt or newer.

I created two patch series[2][3] (two different solutions for resolving [1]=
),
then they were shared in linux-rt-devel lists for review.
The both were acknowledged "as OK" there.
Pavel selected the shorter patch series[2] and we want to apply it to 4.4 C=
IP tree.

Here are requests from my side:

To Ulrich,
Could you review the patch series [2] ?
Details of the issue and how each patch is made and work are written in com=
mit messages.
The WARNING has not occurred in 20,000 reboots in both cases[2][3].
Feel free to ask questions, request to improve patches, etc.

To Pavel,
Do we need to apply the patch to introduce "system_scheduling"[4] to 4.4.y-=
cip (non RT) first?
Its original implementation (i.e. SYSTEM_SCHEDULING introduction) happened =
in the mainline,
but our custom patch[4] does not make any sense for 4.4.y-cip.
Should it be applied to 4.4.y-cip-rt only?
The second patch to fix the issue[5] must be applied to 4.4.y-cip-rt only
because the original change was made in v4.14-rt branch and not in mainline=
.

[1] https://lists.cip-project.org/g/cip-dev/topic/108515524
[2] https://lore.kernel.org/linux-rt-devel/1738629964-11977-1-git-send-emai=
l-kazuhiro3.hayashi@toshiba.co.jp/T/
[3] https://lore.kernel.org/linux-rt-devel/1739170545-25011-1-git-send-emai=
l-kazuhiro3.hayashi@toshiba.co.jp/T/
[4] https://lore.kernel.org/linux-rt-devel/1738629964-11977-2-git-send-emai=
l-kazuhiro3.hayashi@toshiba.co.jp/
[5] https://lore.kernel.org/linux-rt-devel/1738629964-11977-3-git-send-emai=
l-kazuhiro3.hayashi@toshiba.co.jp/

Best regards,
Kazu


