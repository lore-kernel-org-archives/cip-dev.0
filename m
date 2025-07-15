Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DA1C83F1B
	for <webhook@archiver.kernel.org>; Tue, 15 Jul 2025 01:16:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.4356.1752542208438761147
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 18:16:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=bC5/9bni;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1752542200;x=1753751800;bh=cX5uSvuUp9ftJwhKIskeJ3/+/bv0sUxX2QDwnht
	N4xw=;b=bC5/9bnietQBxzmDqFPPFSaGSG0JUiv1ZQz5Y03YASDHspkWZnEaEKuSPUwu4a0ZqLKTV
	AW4RwbLwkbPkNkgBRlkjWa1MgbAKXaTbhz6oo+iZHoyV2+pMmkZaJWjtJb4NRSnyBBBtl5Z6341qD
	GOWXLWcddaW209/91VfzcR1rszvhEZNS1T/4RuS4/xvhUMr4WPiMzBQpXdODI9CYNeoKfhV0P05Gx
	VE/ZVsCwQY3jYRuEj8zhdZXtlGgMI7WwR0dLlydAkF9avh1y2PVqk6HIgViagbOu+nCU/Pw6hg3W2
	qVl6SS75rBV9aGgM1rsWPnSVPQg0Wu8I4Qae/splSw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 56F1GeRx1346573; Tue, 15 Jul 2025 10:16:40 +0900
X-Iguazu-Qid: 2yAbj3N9bujR9D3uYC
X-Iguazu-QSIG: v=2; s=0; t=1752542200; q=2yAbj3N9bujR9D3uYC; m=0P+amVHHF8dqtJhsuD7M+KHKLFUYzOIdWsOEKpUT+e4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 56F1GdPG2156072
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 10:16:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbmUm2X2R0TN9mwXfIY1Xeqvg/u7VuYl1clcPZbczjqJd1zK+cn9hBvYGuqvHDM8hmPmTrz7CcxrxgxgOZLbWVRIEu046codY7P6zDBXdc+5Ul92r2qRFXmwOzaiFB2IKktFpi/p4vN04hm9U0Jj1J6RX5LpoL65mwNMUr6E63z8lX8LHcFuypqDoqpMwCAC09j7xInOeNvOLLXeRXWBzJy8Mgj/9oMMd0HIiyC2hWTy1/R4xN+KcjbnsppZdLVllNs7FFiyRIZdyEXeT3NNTznlmfQLTAe26NNHwRdzX1sX3eMywS1vX/yHZTDc84mFXN3T9txK9ucZGHseUoiZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4oGsN1dlRclEXR1sSGt6VhEzszcPwFjD2N5PIBTwBg=;
 b=PACkhZcBMwVGIeD5gLLIfDp+OHWoET7c5cKHv8S3KK94PBUbpcR2B5s0fkYke0KtBG7eXWf2foyYg1aogG9/7lDeqW6u5SjpUTWzk7mdcDJwNFjjnd9j7v8hDxgKZE0xl2t8tBhtODhGmOGMhecDJKZZ6bXM5NcfrtCMwasOQPtHg9ZKxgRl4l+kmLv0kByBk9BpMSwvO+Ewg0ceFJWVXsHothQpPw21fwC78NMotSFTA+olvdawD7OFNiYdPw/Ng0PcJAcvk7MHMRh5ygp2cDyk5ExF8s3T4zbDkLFmPY1GwSPjLTrwr5KRIYDGCheHf60lbpkh1FRi8uVwY0TVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.12.y-cip 0/8] RZ/G2L DU enhancements
Thread-Topic: [PATCH 6.12.y-cip 0/8] RZ/G2L DU enhancements
Thread-Index: AQHb8nxo74mjDQCWtkSl2xfqwbSzPrQyZd7g
Date: Tue, 15 Jul 2025 01:16:36 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148182453805A3F5871FEF0C69257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250711155633.103449-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250711155633.103449-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB15953:EE_
x-ms-office365-filtering-correlation-id: 523a708a-b078-4490-ad8c-08ddc33d3e94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?anJXakxhNVUrRTFKbC9udkZmTEZKd0lKTDh3Zmh5Y2RtbGtaZkRzSkJj?=
 =?iso-2022-jp?B?NFplRWlNbEV6S3I1OHQwT3VGMXdlV2hqV21uaG5keWdxQ3pFK3R1TWR4?=
 =?iso-2022-jp?B?NWdXcGJ5UG50ZUk0MnAwbnA3QllvV09nTWVmM1FRZTl3Z3E4Z0lWN2tE?=
 =?iso-2022-jp?B?cGR0YXprWWRFT0FUS2NrWXlzT2kvcWFSRCtibVUweXFJZFZoL0h0ODhD?=
 =?iso-2022-jp?B?ZVRIaVQvS3R0QVhHNGFzWEIwWkI4dVoxZXVZMEQxNlVGN01YRWZBa0VW?=
 =?iso-2022-jp?B?dUdtUTBBQ01SYnZkTjdQVGNMeHdsVTM0d2ZmNFFrQ1lIeHJRVnE5Q2F0?=
 =?iso-2022-jp?B?Y3F1ZlFyZ1NSaVE4YTNvSjFEbHduSWUxaDh6dVg1RGt3czViWGV4RFo5?=
 =?iso-2022-jp?B?VmlTU1JaWDFOM05rNERRSUwwQzNOWmRrTmhQTy91NEhFOUdzRU8vWXAv?=
 =?iso-2022-jp?B?QndBR2VHaW44TTYzazdSR2U4R3A5cENCTHpvQkdhRmt5dWlYRkc4OVlO?=
 =?iso-2022-jp?B?TWxZQ3VQVHY1a1pyRjFOc3ZWeHRUL3J5V0x6a3VlR1g2Q1MyUXhFakpB?=
 =?iso-2022-jp?B?N05jSzBqdDhXQnVTM2UvWFBJMWtJVHlkajFpZndTUEdWdldKQi9SOHY4?=
 =?iso-2022-jp?B?eHJXVWVRcW1WOTBZbVJNd2R4bXV0Z2U4MkdPN3pCcEMzVHc3b1FBVFN2?=
 =?iso-2022-jp?B?VlVXUWs5Y3JxWTlDRWtlZzM1VVFLSm92cmVyd2VzWjc2U3QrOTZhcmpm?=
 =?iso-2022-jp?B?K3haMW1vb1pENEU1ZzdLQWlBdFBUcVZ0ZENDektCKzJ0V1VJM3ZQcG9K?=
 =?iso-2022-jp?B?cUJJQmpJeFYrYmVqenVCaml3OURPTkhadDRZeVZIUTI0dG1BNUFRNFlH?=
 =?iso-2022-jp?B?RkgzRnNZUTYyeUVjZENua2RiTGtuVkVvV1pBWktHWlJJMi9zUGRuRi9W?=
 =?iso-2022-jp?B?ZnEwRncyeEtEcWRYMWZPbkprbHdIWmxIT29qSUM5KzV3M2xadVJjSVRR?=
 =?iso-2022-jp?B?NmZuSWZobVQ4QTMvV2RBZGphUVJYRUZJSU5pbUJkNW9JYlN5QmZFdm9D?=
 =?iso-2022-jp?B?Vm10b0U4di9QZm8zZkJVMmpwcEp4SEJyQ3daazROUWd6a2ZkZk1xOFZt?=
 =?iso-2022-jp?B?disxRVpKS2JwNkZlYXdRNnhaWm5zTFRqcDBaR216anFzNGQ2dysxdVZt?=
 =?iso-2022-jp?B?Ykd5aDFqMWlmNVlUMEtWOEt3Zm53WmR3d3kySGJoNW9YOXcrSUtiWTZF?=
 =?iso-2022-jp?B?YXhaRDlWSnRPUmRibjBMWmEzSm8yYzdSNE9laUZCZ3lYYWJIK1M2Z1lz?=
 =?iso-2022-jp?B?UStjM0tsd094SlMyMVg1MUtEY2ZLNVpua1c3ZHhSL1NmcUpWcit2ZmJ4?=
 =?iso-2022-jp?B?NExZUGk4d0dObXdDKzlSZHFmaVZRSmppUnpETUMrdzRma1I0eVhGWXZH?=
 =?iso-2022-jp?B?MDRRSnJrU3FXNUsvaWVVQmN1Q2ZHZXJ0NnN2SmZhWVdqTmtkbnBjUGgx?=
 =?iso-2022-jp?B?UlpKdHRZVTNFa2J4SGFwZUV3UjhaVXk4OStuOUZIVjZRMzQ4Q1FrNk5r?=
 =?iso-2022-jp?B?OG5TSXVjN0FLOCtxTnRPckorTDRyWXBoZTJnblZrZHAxY1BCVlhNTVNk?=
 =?iso-2022-jp?B?SnBMdXIyeGlJb2JQM2tzRjBWaGozS1FIdmZPaE5yL0tTVlV4b2RheW1G?=
 =?iso-2022-jp?B?bjhxcjhvZWtrdERVaWlvSkZDdU94THVHRHluSVlpQm9tRFZaTUh0TTBW?=
 =?iso-2022-jp?B?TDBPODNxTzVXcTRwc0hPSFR4cVhFK3ZXcXl6VGJYVEZRWGttOENYZjdR?=
 =?iso-2022-jp?B?NzZkNjRQM2RxN3VQZi9CNTJ6WVEvb3VGRmtWeC9CdEVxMjBSNFVmaGxs?=
 =?iso-2022-jp?B?MSs1dFpPY3d1UnVxVnV3SEt5Zzc2NzF2UzEzS3dqMndPeWdxSDZzaUQr?=
 =?iso-2022-jp?B?U2hUY1RaQVNVUFpkVWI0MDhpd0QzN2paSW85dWY2cmRycGxoczhaTUVx?=
 =?iso-2022-jp?B?blJDN1RJK0NpWjQyUUpVdFNBei83UHdXZmJxUkpvVXA3MVBtbzUrenBm?=
 =?iso-2022-jp?B?ajVjZmtLUEJSZlNEbVJuVVhMSXJUUVFDTnhXRmd3NnQwTlU5WmlnaGU1?=
 =?iso-2022-jp?B?RitHTld0MEcweGFkR3dha3VzNkZsSTVRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MDhLelQzU3VjRHhlRFdINkk5ajE0ZHQwNE9ZUFZJOTFIS3ZQVjVNMHhX?=
 =?iso-2022-jp?B?bXM0TU9zVlZRUXh1bEc5dUV0RUJFNnVWMzlFTGxveGJVa0hhaWpkWXcw?=
 =?iso-2022-jp?B?Z0RZdGpTSmgvN29ybk1kd0tDYmd1ZWJuL0RZdlBEL1h4NUs0QWlFNzNl?=
 =?iso-2022-jp?B?RHRmNnZhQSszZk85RkhqWnQ0WUF4a2kyaG9kWVp5SXl4d1doUmQ4QXlD?=
 =?iso-2022-jp?B?ZERpeCtxTUpvb3ROWU56VUVBbVU1enFKUHlqNjNaSXBUSjN2UTREdC93?=
 =?iso-2022-jp?B?UEpTOGtsdVR6MG4zWW5zeEUvZmJKRE9yVUZHaS9Nbyt5UEgrV2lCY2I0?=
 =?iso-2022-jp?B?ajl4T1ZUUENRWFp5bjFZZVo5eWFrRGNobXc4RGlaVGFrQ2dEREp5Q21o?=
 =?iso-2022-jp?B?N2VIT1JhU3ROSGpid0lPTzQ5dHhNSzhsRVNRdHJOcnZGbTJEbmNuV3hh?=
 =?iso-2022-jp?B?N0Qzamh4bC9XdmswMjd1cjFNYXkySUVQN24xRnVtbUFRS25sOXcvbHkx?=
 =?iso-2022-jp?B?b1pKdmVBNlZaM3dUTHdscWI5OEtYeTBQbXE5OFB3OG83NlVsRmVURC9K?=
 =?iso-2022-jp?B?VTkzUkhvdEgrZHMvRUUvam44NW5DcUhyZGMwUXVkQVVhK3NrMnZGcUN1?=
 =?iso-2022-jp?B?d2IzUXQzQURyM3R2YWF4UXJoOFFRcEdZWUhwbmMraXp4T0k5ZEo4TEQz?=
 =?iso-2022-jp?B?YlJKQklNekdOTTg1anptTmlJNUpuOVRQYldkQ0xqdG1MckVibFBleit0?=
 =?iso-2022-jp?B?T005aUwySk83bCtOMXVtcEhEUFV0VExzU25zdlpLS0ZxL3JqN0RjSW5t?=
 =?iso-2022-jp?B?SXNIT0t3RytkWG8vc2pDWFpBNmxYV2ZMWXF5TVNLY2R1Uml3aFpwWitL?=
 =?iso-2022-jp?B?dlZ6TjBxSE93ekk2b0FzSkdOZ1dvOGVPMDVMSmg1dzRUTTdkSXkvMFJm?=
 =?iso-2022-jp?B?ZlFqWFpHZ2ZqNDZPcnBLbkFXOGx4d2RXTkZPcnZZR3I0UE1qTHVYNUNT?=
 =?iso-2022-jp?B?RzM3VWh4Q042VFVwUEZVZitVOUtVbVgyWVRWNE1UcDJ3Tnd3T2NXSXQ2?=
 =?iso-2022-jp?B?QTA5QjRreHVjWFBPTlVoNVFqMGZ1YW1kL1pxYjQyV1dLTHFzRkN4cFdS?=
 =?iso-2022-jp?B?SU5paFpib29rUllRL2Q2b245Z1hIYnhQRkIzMmNjbXBYanRqWDBKSndL?=
 =?iso-2022-jp?B?aDFra0p6bUdTYlE4NitNVHRKSVp1YmM2RnN6OFl4RFRCdjRoRzdKblM2?=
 =?iso-2022-jp?B?V3lzR2ovV085dzZIRlNEZENXVHVFM3paMWZVYnRGdkJJZ0ZHRy8xcTBC?=
 =?iso-2022-jp?B?b05RaWwzTE9IdjZUTCtxZmJmT0EzMkZpSWNMREhmZTQwUWpxV3FseEh4?=
 =?iso-2022-jp?B?Y2ZGclVGaU9ldzlmSkcyek1vcEZYUDh3UTE5aGZQS1I1YU9BSUg2Zlh6?=
 =?iso-2022-jp?B?a3p1eFpQRGV1WDdTUHc5MkFBdUdrN3RvcG9yTURHYlhtQVhwQ3M3cFBC?=
 =?iso-2022-jp?B?ZlZXazV3Z3NIYmFQZkpzaDczOWt5c3Fqak9nNHYxd0N3YWJrc1FhUVZi?=
 =?iso-2022-jp?B?QW9RUjd6bHkyWUVmZHFzQ1FrNUV5SGY3NmQ5M3c3cXhIK3VCT3ZkTTR5?=
 =?iso-2022-jp?B?RHFPSkhSUXdud0l6dXNZYVAydHRWQ1J2dkFFWG9jMEVnemxLODFhSmVT?=
 =?iso-2022-jp?B?aGdOL0JLV2hPemxqN0tQMTZ4QU00bjlhaGkzSnI1NGZhNnhSa1ZBZ2tV?=
 =?iso-2022-jp?B?aXIvRmhHY1gvZ2NsTGxYK2hub3pESkJqTUhCQk1uZ1JzdW4yRmRDaVFa?=
 =?iso-2022-jp?B?MDBwQWtZRkhCV0dlQVd1bFRFVFdoYUhLZThLQ2tuM2ZSOGRHS1A2eUhk?=
 =?iso-2022-jp?B?REN6aUdPaFpSSkFCdEFEalplOXA1bE8rV1ZLYTV5K1pneE5oVGQrVTd2?=
 =?iso-2022-jp?B?c2dSVCtBOE9DSjIwbkZoeEJUdktUcFdhODRHaU1DY3o3RzVnRXdSNWhu?=
 =?iso-2022-jp?B?VnhZaFI1cjM1UVY5VW9rRW91U2NJRWJBMUJzK2RPMW1UN2hjM3g1d3pQ?=
 =?iso-2022-jp?B?cFpMbmdYVGhoSE5WV2J3K0FmWkd6N0tOdHRMTTQrb1dPU3gxU1dRSUIz?=
 =?iso-2022-jp?B?MmxxZ0dvYncwWExNVHhJZnBqbFBqY3JhcEpOOUVlNXFsZDBEYndrelRu?=
 =?iso-2022-jp?B?UUhYTGlxTVl5K3I3QUZGRnpMVGc2WFNxSWFIVVdlNkk4RTVYN3NJeGlN?=
 =?iso-2022-jp?B?OWw1a1dGZFM1QitCazlCckF3ZDJ4bHdYU0xCVWRzc1FPQUROUVBRaXJ2?=
 =?iso-2022-jp?B?YWJXWDQza3dad1E2anp3WGROSEkxQjFPUHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523a708a-b078-4490-ad8c-08ddc33d3e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 01:16:36.6651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JsFJ9e/U4qC1JQmd5nBmMc/Wv+oCkhiE7kz4H9r1NTBoXesZCA0pfmkHwB9rLySWaKlsIJbR9oU8xlTCu+tuf+T205Tt2jOfDZGLvqBnKplHHULuuyKMxuM/pQEw1k0L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15953
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Jul 2025 01:16:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19529

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Saturday, July 12, 2025 12:56 AM
> To: Pavel Machek <pavel@denx.de>
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; cip-dev@lists.cip-project.org
> Subject: [PATCH 6.12.y-cip 0/8] RZ/G2L DU enhancements
>=20
> This patch series for enhancing RZ/G2L DU driver.
> All the patches are cherry-picked from mainline.
>=20
> Biju Das (6):
>   drm: renesas: rz-du: Drop DU_MCR0_DPI_OE macro
>   drm: renesas: rz-du: rzg2l_du_encoder: Fix max dot clock for DPI
>   drm: renesas: rz-du: Add Kconfig dependency between RZG2L_DU and
>     RZG2L_MIPI_DSI
>   drm: renesas: rz-du: Drop bpp variable from struct
>     rzg2l_du_format_info
>   drm: renesas: Add zpos, alpha and blend properties to RZ/G2L DU
>   drm: renesas: rz-du: rzg2l_mipi_dsi: Update the comment in
>     rzg2l_mipi_dsi_start_video()
>=20
> Kieran Bingham (1):
>   drm: renesas: Extend RZ/G2L supported KMS formats
>=20
> Laurent Pinchart (1):
>   drm: renesas: rz-du: Support dmabuf import
>=20
>  drivers/gpu/drm/renesas/rz-du/Kconfig         |  15 ++-
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |   8 +-
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  |   1 +
>  .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  18 +++
> drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c  | 120
> +++++++++++++++++-
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h  |   1 -
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c  |   9 ++
>  .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    |   2 +-
>  8 files changed, 153 insertions(+), 21 deletions(-)
>=20

This patch series has already been applied, but since
I have reviewed it, I am replying for the record.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


