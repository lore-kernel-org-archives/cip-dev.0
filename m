Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6481C71136
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 06:02:51 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.24037.1750053768801251144
 for <cip-dev@lists.cip-project.org>;
 Sun, 15 Jun 2025 23:02:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=V9v02hsK;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1750053759;x=1751263359;bh=W/jSENLLWFMiP1twy1WMhtDyHkEh4bc0rRMXkdt
	y21M=;b=V9v02hsKmMKus4iRiwPretv1OUExYWlrtVCIDxImlDGApn7nm1tdlQDMdEDLgCuYMHszt
	anPOhmBh4SDIPC7Ah1J0ODnEfsXNZrxhKWhs87hA9iS90K0z7CLIvumVBnnNdsEllq4v4k6eLlQzK
	6m1r+xq1g5Gvf2NH9kLqSHGYHsgGy6VH16j4DvueynvuxPBC+eQd4WQ2v5gQN+foI/vdJbxaPkzRa
	xnLAyZwCH/T9Wp5LjXw2VIgyVBimYDEoR3sj0BEyuPh2w49gaaEsCyXvJFFsGnX8eL+7LsbKWr8Xw
	g/G800kg/PyFqvsG8DJD53i+Dga6p5uBXHKMyDw7+Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 55G62cht161366; Mon, 16 Jun 2025 15:02:39 +0900
X-Iguazu-Qid: 2rWhWAeBmz8eEipzqE
X-Iguazu-QSIG: v=2; s=0; t=1750053758; q=2rWhWAeBmz8eEipzqE; m=V/yQsIqO5cmiosU8YEG7pZmVV4cc61686+aeJofxONk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 55G62bJM995140
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 15:02:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxo/uFHd6sNZH6mvFtUMJ/HFuOeeSXqsRkz8xzV7gC4zYcwMEn0al2PQ4DygICKgRzqL88aWJcK9vLcA30pKNf0hTyVIBGCFQZRDzxuuQ513QDI4W4htnQlqlkDUxqML/ax4v2gInZC/eJePgUbGCQ8NAS87VK2er4QD3If7vTXLQ4AjVfyBbwDuEfHLMtd8QYgNr4TpLMIShDzmf0AymqOgnfpKrq1StHFaGoqO0Gtfar7CBSSCprdPprj0VZejf6ukVJjWTaDAoWNw4SqLwQ0Y/aXZXOEPiZjY9/N1Nt+rjYvcb2xQb1haRhrZft9w9stvx/HbvK5b/PfQS2K8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncpSxDbyP1wsC7De69Mm1I45q6NF9HBqumXYEkv9aIs=;
 b=W+gzcj7Q8fXJi+0BtQtSPiPB2uKgT4ZE/Jx3prEcb+fZfJ72iZ2rQEO2clvdYlyJWQ5ZrObqXjDybPVbqDVTU+wsNnFiCvHwOqAg2UeZs7coxVdG/q2p7FQUNtJfSHvwbEpI6qjo2RGTVcqp9fl/o4jaUREeKE9B2/q7l5VCSihpNBepkFhP48N5sP59cb7S/M/ONNY/Q29VNvz2d9A/oQN2YBkly5BB3QLUwZvZlXjQ0d55kATRaTZnd3vPUfI8A+ZBoARtW2PnMNyfcePanFKXy1N2KgG31U0H8JkhJJIrXBoYFzaRZZHKIGXCOhzcJgqG/ODIiUpK7jsgfz0P3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <claudiu.beznea@tuxon.dev>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.12.y-cip 00/14] RZ/G3S: Backport ADC support
Thread-Topic: [PATCH 6.12.y-cip 00/14] RZ/G3S: Backport ADC support
Thread-Index: AQHb3Ew5m4fGu0XhVUq3ZdEIL3fETLQFT6wg
Date: Mon, 16 Jun 2025 06:02:35 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481838EE14D326D2910542929270A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB15382:EE_
x-ms-office365-filtering-correlation-id: 5a91338f-f9bd-4e75-41b2-08ddac9b644c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?N3gwdWhZN1lOeW1wdVhpSXJWbEVWSDN5Y0NVWDNRNmJBdlVYbzhCdTYx?=
 =?iso-2022-jp?B?bityWWNKNTFXSVlING5rS3VZTmJ2VDBkQmRZZXFaNGRMRjlsVTVidHM0?=
 =?iso-2022-jp?B?OG04dTl6TlkrUEs3akJYSU53ZVZkbENHZXhkWTJHcDUzZGo1SldHK05q?=
 =?iso-2022-jp?B?bHNYTlNjVUtlRlQ5WFdPQlpWbUcyZFI3NUM2UTk1cWhOMnhWdmdoN1k0?=
 =?iso-2022-jp?B?KzVYVE9VY0FKaWlIVjdVNG5ReUhiZGNCVTl0a2d5dTVua0RsVFZyTE0r?=
 =?iso-2022-jp?B?bWZXT3dYZ0tZV3BWQTJMUW9PN1RYZTFSazJLM0NHZllrS2xXcmZaTHN0?=
 =?iso-2022-jp?B?UVlnd2pjSnJhRmRsVFhTYUM1OFJybitaMzJlWlpyak9aMTJOTkZUUDl0?=
 =?iso-2022-jp?B?S1drNTg4b2JhRExQd2NoeVIvTExPejJhOGJKTHJmUy9SRG1yQTNJakFB?=
 =?iso-2022-jp?B?V2p6N1FpeDhOUE5HOVlLUHVjbWx6Mjl1eDViOGUvTG5WTVhpQS81OTVG?=
 =?iso-2022-jp?B?U3h4NXl5R1JYdFlHQlBwV2wwRHZzZVgxVDFleDUvenNCUUpMMWdXUGJq?=
 =?iso-2022-jp?B?Q25PSXFTdktVNnZVaWdTdkRrOVQ0QkUzaGM2YThiOXdOZkd0UWdIbjhw?=
 =?iso-2022-jp?B?U2xBMys2dkpTdjBNTksvWXRUc1lwcExZSFhROSsrZ0FSdXExc3kvRHBZ?=
 =?iso-2022-jp?B?UE16eG9ubkJTeFM2cjJXbTJHRnpWdjI3dG0wYWRnaUI3UzVBL2lHRS9a?=
 =?iso-2022-jp?B?ZGViT2V3RnhvMXk4bU5qRFBSSlUvZTd2MkhuK1FlU3RmK2hvYXhQVFl3?=
 =?iso-2022-jp?B?NDN1QzBBdmUwdlQvNEhDNnBUQzliblFTbThLRytDZ1d2bGhZTjVKREJp?=
 =?iso-2022-jp?B?MGZPdnZhM20xVWdjM2FKZFUxV0haVkFaTDhWVU01bGRINmhMdUxwd3lr?=
 =?iso-2022-jp?B?YTQ4eGt4TUM3Ym11dXVEUTRITXdsaEdjdXFiZU5DT1c5RjJyU1dkMlEz?=
 =?iso-2022-jp?B?OEs2QnpNT2VpT3RiaTlta1YwV3pkTllWS0ZzN2hrODV0WkIyc0tCRWx4?=
 =?iso-2022-jp?B?WUdJMDl2bFhiWXdMTTgyVnZVM1Zma2IwMGxQS1Y1cUVMd0NuaVkwajBZ?=
 =?iso-2022-jp?B?WVF5eS91Rm5MVTloOVhlTmYvR25sWklOZW0xcUN5bHhYT2M1ZVR1b3g3?=
 =?iso-2022-jp?B?OHJJalE0cXhVWFpLYk9kY05jQXdQZlNuZWVsYTM5TEtLSnBOSzJHNmlC?=
 =?iso-2022-jp?B?eS84TDg1WEJzVDk1Q09oMldUeG83UnVLU2J1N1RBdloxcmNDOE8ydmZM?=
 =?iso-2022-jp?B?MnV6NG82Si9QRnN5K2hhWW5kRzFTelFTdGMzSGFOekt2b3hINEVCMkgz?=
 =?iso-2022-jp?B?ZFlzQUMwQmxTVE16SGRQRHpuVDZpWFg5cUNsOEgvZjdYSmlKWklSaW9B?=
 =?iso-2022-jp?B?bWkwVGNDRCtJczhpeW56TXYzTXZUS2hBcE9GbjB4SzhIRlJFV3pzK0x5?=
 =?iso-2022-jp?B?K3BRVE13Rk9kTzFsMFlrTE1hNG8xUXBvQWRySkQ5WEMzVkIyL1hpRTFl?=
 =?iso-2022-jp?B?T0dQRmJqZm9LV2pGKzlKYW1wYzRIcEx5THI5OXYzUjFrclZWVmIyQU5R?=
 =?iso-2022-jp?B?M3Nkc2pTUDgybWE4Q0R3U0EvRkFTbGpmZGdXOTJUamJQQUgwVk1NcjQ0?=
 =?iso-2022-jp?B?aW9ueUZwcTVodTF2L3J0d2F3VDZPeFdsWnpYdVRmOTRMRlVlSGttb1FC?=
 =?iso-2022-jp?B?cVlIR0UwdnNSeDl6aE9kREg1blE1WkJKYzVxR0pPMnl2Wm44TUN0bE1M?=
 =?iso-2022-jp?B?ZlFlR0xNbzVpNWlHc1JpU0dCeEJlMzVGNTBDSjVNMGpkYzU5UDdSb1JV?=
 =?iso-2022-jp?B?ZkErMXJFZjZkTmxUWVc2ajgrVm1waE1WYnJBVzExb1ZaVVdUcC9IZ3RS?=
 =?iso-2022-jp?B?bkJCdnhTa1VEL0hZeVlFVzQ2WTc1N05wZEVob3lhTUtxWUpvTmJQeUNF?=
 =?iso-2022-jp?B?V3I0bFdFYVdaT3M2MWl0N3RqZitndXNKazBwY29WMk1ETmZMenoyTU5S?=
 =?iso-2022-jp?B?bHljL0d6eE1zUU02SWhjQzRkUlFwcVh3aVBhNkR1ZTIzVm00U0tVaVZE?=
 =?iso-2022-jp?B?ZXAvN1p0d2pSSWg2WnRYekVab1hVaWFINWJWQjJTc05HMi85VmFpanMz?=
 =?iso-2022-jp?B?RU9FPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dnhNaWJpWTNEWjNUSm1QQVN1Ull1UWNoZU52bGhQbThuUXp4eHdZb2FI?=
 =?iso-2022-jp?B?eG1Lcmw1bU9IM2t5RHVUWWtzM3ZuNW9PUmhuWHh2TjNES1NvYXZtSWpL?=
 =?iso-2022-jp?B?THVWclU4UmJnWUpDaEVseGZOV20yOG5kdFEwRGRaUkx6Slphc1dCc0lv?=
 =?iso-2022-jp?B?bzFDV0d4T0h0bDFlcUc3bkVEcklSWUhZNXdwVzJNZmRSSTJzOHVnNCtw?=
 =?iso-2022-jp?B?Y01wb1N2NWR0bHh3MDU1N21SUWhTemxXYVZ5am4rckNHdndlckpQM3NT?=
 =?iso-2022-jp?B?cHVseHpqMWYyZVkrQlFmWSt0bnlIQ0Z2RzdqM3NkLzUzczVuNlRYNC9B?=
 =?iso-2022-jp?B?NEM5bWtyYk0rQVlhcU85NFZVWittN1kxWm16cjAvSm5TZXVOZWhLVGVa?=
 =?iso-2022-jp?B?ODkyMkV5c29SV2M3Sk9YTGJST1ExUGZwa0xyY1VIQlpUTmM1clBXM3hJ?=
 =?iso-2022-jp?B?QzQ3Y2plL0xFOG1CVllZZ1lqNzIzTk4xZVlkbTlYcHJic1gxMnRxa3Rr?=
 =?iso-2022-jp?B?cXI4L01GYWZiTFRrK01TUUZWb1o5NHRaa3hEVEtkUWFSdkY0bGxGcDVY?=
 =?iso-2022-jp?B?U3NrVVlXOE5HYW9MYTV2K01EbmlnVEdhcDdFRlM0V0I4S25sTmhFUGhG?=
 =?iso-2022-jp?B?UzF1QklJeEFnL1F3d2lYUzZRRWFWZU9QRTY1b25RZjNLUU53QjN5NUk0?=
 =?iso-2022-jp?B?bjVjT3M4M0k4VUlXby9paGZBWWtyRjRmbG5VTzVYSGNEUUdkUHp2dThp?=
 =?iso-2022-jp?B?TkEzOFBsckNDekhKZC9XS0pjazZJYU1lSnpOUzd1MEVucmRwU0NSVmRF?=
 =?iso-2022-jp?B?WEZuOHQ4NHFwQVNWSjRIRXB0NTI2Zmp5dVZFSmRzYzhoRWN6eTd3QW9H?=
 =?iso-2022-jp?B?V1REaDE5blBFSTVCSnVMcmRkelcyRUNjV3Nod1pxZzdvK08wTHcxMkZy?=
 =?iso-2022-jp?B?TzQrTVBVaVVrN0lBUU1OTjJyU0dzcEJPOG1BeEZWcmRLNmhLQXVqVEhI?=
 =?iso-2022-jp?B?K3FPVjNHZ3JUM1Bzc054TU1IQkV5emRmem1LV2daSnE3TjdxZk4rbk9N?=
 =?iso-2022-jp?B?cXhvcW55L2swMkZvQ1BOVUg4SjUwT3doYkJ0Vk9hc1ZLd09yV3RvRlNs?=
 =?iso-2022-jp?B?NVpzSENCaG53U3VFNjBSTDExTDlSWjhJWUJaaG9WWjk0MThObHZROWxs?=
 =?iso-2022-jp?B?ODdEb2IvcWdKcmt4RVcvWUJEeWdHT0pCQWk2UXJuZEdZU3hKOFJRSzRW?=
 =?iso-2022-jp?B?SWNzano4c1psdTVGSE9pUWU1ak0zLzgwQzJYeGp6SUw0RXRqMWg1bG1B?=
 =?iso-2022-jp?B?YUtYcU9RT3JXaEQ2M3lSaDFZaEN1TU4yTTVsWGYxMUZNc0RlTWxTYTRW?=
 =?iso-2022-jp?B?SlZ2V0ZjMVA3N2R0K1ZsSlNDV0pMUVYrcHVLa2Z6NTM2K0lFcmxFRHRn?=
 =?iso-2022-jp?B?L014Q1d2U01vVURTNUJ1aGtMU0w4NjFQM045T0dPOVB3RmRrN3BvUXJB?=
 =?iso-2022-jp?B?SWl2Q1k4T2h1Nlkyc0xETFRGNlhNc01aeW56VEJhYTR5Qm9ndGpkV0tl?=
 =?iso-2022-jp?B?VS93dVE0S2s0UzI3d3BmZ1ZSV2crdHlualU3WUVaUG1MWjBxeEhZenEx?=
 =?iso-2022-jp?B?RG9XNXpOeWRQaWZVSExlVTY5K2JiMU5zRHUzVlFid3FML29tUjgvVTFF?=
 =?iso-2022-jp?B?dDZvVkFHZWJ0SFg0YlVSLzhXcXd0VUVCR3lFZkdCTm9JUFdCUmloR3pu?=
 =?iso-2022-jp?B?NmVtU2JIeEJTYWFieFYyQzdEaHUybHZOaGdDbHB0S3h3UTRuckRPSHBq?=
 =?iso-2022-jp?B?N21rNTFVT0ovdThYVHRNWGI0cmtUMjhOMzhkMEpBR2hsZTBzTWFyQ01n?=
 =?iso-2022-jp?B?dDFOSmFXbHZxb1djL0hnRS9KT3pVTE9YVW9xOXJjR1BXaFJkc0JOZTVo?=
 =?iso-2022-jp?B?aVplaWw0eUhlRzFlRDFJa24yU1NuTWNsTU1iYnFyWTNNandsYno0emZC?=
 =?iso-2022-jp?B?TVh1Z3hHUWs5UWJhQnloNk02d1ZIdmcrdmVMdHVrLzV4dk05SWlDS1B2?=
 =?iso-2022-jp?B?K2dmOXgyUzBaMXR3ZHpPc1haYVZDOEE0ZmR0S29hMzYzRFNTb3Z2alRV?=
 =?iso-2022-jp?B?VUMzWmRqMkx6QWFjMWlMaENxSGl4bWJ0UFJXcWlWdTM0STREQWxvNHNu?=
 =?iso-2022-jp?B?QUQvcDMzeGJvQWJFcEFqU0ZGR3U4TDJPU2E3WUNGMm41ekVHSm9MaHpU?=
 =?iso-2022-jp?B?T1hESFQybDZzaklGT0ZqQmdZcm4rV0xyc0dhbTNPMk9Ga2twYXZkc0lE?=
 =?iso-2022-jp?B?Ull0VzRBUmJ3Z1RUdm9MeGxxZ3duNy9XSUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a91338f-f9bd-4e75-41b2-08ddac9b644c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 06:02:35.8768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HTq1UQNtfVYYWy603bqUBPegI2wawRubkFSEbR3sDNYjA/AjbzEpDtBYHNhC+F78Wzx8s3UCs9F7QKs5crX/h1fHelZrsKM/hwRW/ivFegu58yJtHQRdBZbbPHNrYjf1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15382
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 06:02:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19092

Hi,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Friday, June 13, 2025 7:16 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.de
> Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org
> Subject: [PATCH 6.12.y-cip 00/14] RZ/G3S: Backport ADC support
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Hi,
>=20
> Series backports the Renesas RZ/G3S ADC support to v6.12.y CIP.
>=20
> Thank you,
> Claudiu Beznea
>=20
> Claudiu Beznea (14):
>   clk: renesas: r9a08g045: Add clocks, resets and power domain support
>     for the ADC IP
>   iio: adc: rzg2l_adc: Convert dev_err() to dev_err_probe()
>   iio: adc: rzg2l_adc: Simplify the runtime PM code
>   iio: adc: rzg2l_adc: Switch to RUNTIME_PM_OPS() and pm_ptr()
>   iio: adc: rzg2l_adc: Use read_poll_timeout()
>   iio: adc: rzg2l_adc: Simplify the locking scheme in
>     rzg2l_adc_read_raw()
>   iio: adc: rzg2l_adc: Enable runtime PM autosuspend support
>   iio: adc: rzg2l_adc: Prepare for the addition of RZ/G3S support
>   iio: adc: rzg2l_adc: Add support for channel 8
>   iio: adc: rzg2l_adc: Add suspend/resume support
>   dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3S SoC
>   iio: adc: rzg2l_adc: Add support for Renesas RZ/G3S
>   arm64: dts: renesas: r9a08g045: Add ADC node
>   arm64: dts: renesas: rzg3s-smarc-som: Enable ADC
>=20
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   |  37 +-
>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  53 +++
>  .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   4 +
>  drivers/clk/renesas/r9a08g045-cpg.c           |   8 +
>  drivers/iio/adc/rzg2l_adc.c                   | 426 ++++++++++--------
>  5 files changed, 333 insertions(+), 195 deletions(-)
>=20

I reviewed this series, LGTM.
I can apply, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


