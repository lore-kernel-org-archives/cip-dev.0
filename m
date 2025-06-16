Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EE9C71135
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 06:00:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.24004.1750053619199406781
 for <cip-dev@lists.cip-project.org>;
 Sun, 15 Jun 2025 23:00:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=PlYyWpTM;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1750053607;x=1751263207;bh=3hCDJhMLD9fZXlqQGZYC69L4NGPZmhV8GPexvv6
	+JGY=;b=PlYyWpTM1UtnQxxCn86fWSutaMG1czU5hSjhbXKTTb6ECJJlRHf5Qup2H4+m4i0UfzNho
	LzQBPCVVugjODvLd8JA2vM2PDwe66vWbiImKrkqicX1Ik/H1uFz7V9DO1ULPrduGOafxvzZQTB4XX
	IbwvZm7gEorhD3rwSZ+1WGVpya/qgQeKeLeRY/fLLgTkR8top6LKv7KRGvQkIrOm7KGY21CH+K6j9
	lsEZH2oDbcDA3IEmCvopY9kKlgUEbdXJqf0HbaG57lw50Ozp45fjV6h5Bk+HJSxKdV8T9oumhthAc
	/L0hgfFkh8smHGwn6AZDtErPTKuebE3+H2p1cERxzA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 55G606KO186731; Mon, 16 Jun 2025 15:00:06 +0900
X-Iguazu-Qid: 2yAbaKzOjHuxNTjabp
X-Iguazu-QSIG: v=2; s=0; t=1750053606; q=2yAbaKzOjHuxNTjabp; m=pNZIgVSjF+dBMymb0RFRGPOqgzMyerulvTnSQcalvoE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 55G605Tt940296
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 15:00:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4G4Rk+ADUjvzeuXWP9SNLVTjvPivl0naNT7eBKQtfU0MS0SetBQ63Ht8s6C3tMUFdnJweBiabHfp0ZHJASdpnlNuIDEL4IdX4aya7Xar6Yv8xtgPRltDdjKG7scuqoNvqKEsDhNujEmvaBFGm1RifgA0RdaeMMZHn29/8V9FFrmAJvO4gYK/rGOf6wHvdCmCsSHoxACNhc5SkcQrfRXPFKoNAPOGGOgtqer/1uoomoetL/01SzlpNWfqijNCb0Qgobl1ZfWctyi4YmErJuXRarwcdJ6kwiKa4l4wf9gnjCXmrKUCh7tM0q/FpIz+OQ0ajvzNj9WsSzCpjAAX3paQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vugc1C+l+NVQJy4BMc/rJhRl34n0+aVv7r0+ynx6+bE=;
 b=bXs0poLD0DschPoYDyv9YzVZm9R/fEltzuPwzFnxzBBabSKUXBWgjmr3Glhf24G8MXEZlsGgRu2wQ6dgDONtbEYu4ULo+OT0zI4qf3xSBV+OSE621iKGZGgdOT0jmdgWgcu6X+zyfhcRT4bormbWXHjq2BWx+kEyqtq8jnBJwrE6fy8jV+ylD8+2qO5YNCe/8JbM7G9wl0RwfqxtW5cLmtzEOiFYZgYvKv64k2ffe6vY5v61rmR2C2jCNG4todSBsC8BTtYoQchMHzf+lSBkGimQUz13Qz8Up0L4qLvo4jQRfC8MbQ0bOSb0n8t77fVi7q0oM01O4bG3+HzmqcwwWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <claudiu.beznea@tuxon.dev>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.1.y-cip 00/14] RZ/G3S: Backport ADC support
Thread-Topic: [PATCH 6.1.y-cip 00/14] RZ/G3S: Backport ADC support
Thread-Index: AQHb3Ewja1APnyM9l0edN890MdWd87QFTrxQ
Date: Mon, 16 Jun 2025 06:00:03 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818B847F7102C9CC3CC1DCB9270A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB15382:EE_
x-ms-office365-filtering-correlation-id: 75011764-c89e-4e3c-7039-08ddac9b0959
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?RFd5aHdIcEVWNituK0ZqY2plMm9lc0lvVXUyR2djQUdQSVRjWURHNnpQ?=
 =?iso-2022-jp?B?N05MVDdaV3krcDIxL0hjOWd2Qmk0Zk9wVjMyU2lxYlAzYkxsRkIzWWds?=
 =?iso-2022-jp?B?UUR5OUdXTTkzcDh2aWVHQ0habDl3RGd1ZmFSQkdUMHlYallWZWhEaUc5?=
 =?iso-2022-jp?B?ajdIQUVvQkpacW1STTdiSHRmMUZtL056V2pZd2hrRUdHZVRkTGJCK09R?=
 =?iso-2022-jp?B?STNwSFFBVko2WHlmNXF4N2xkMlFKS3IzSHB1a2FNNEFtMmxQYk5FK1lw?=
 =?iso-2022-jp?B?eHAydmUzT3NLMDhBb1d0ZjFIYjc5OTI3bTQvbWlVTm05SXNlQSs3TFdP?=
 =?iso-2022-jp?B?ajcySFhBSDYvNkZSWVoydGhEOGRvTCt4RC9EK1VJZGR4SXExT2FzaWFk?=
 =?iso-2022-jp?B?R0pjcTdSRUo5MU5WLzIzV2JOU2VObjJkazBMaDhYeFNza2dWTCtZZnZG?=
 =?iso-2022-jp?B?NUc5cjF2MzB6NW1EWmMrWTd2TXU4SGtKdGlvMDlvQkMwclNia0ZlM3hD?=
 =?iso-2022-jp?B?VTQ3bUVLa0tmamhCU1pEdjJDdVZCT3VSNzNhYkNNREpIZnlSaXRNQ3VY?=
 =?iso-2022-jp?B?NEI1MmR3Nk5qVnFDS2NnZ3VDV3VESVlTWktnLzVtcmw4dzQ5ZTJpY2NH?=
 =?iso-2022-jp?B?VWsxMkNvdHFaTzZQYjhvM2ZkbGpadGFHOWRPcFVYR2NPN214Y3dzaXN6?=
 =?iso-2022-jp?B?ZGRJU3RlLzJMdGZrQlBXd1VQRjUyTW1FdHhFRzU3a1dWd3h3VkdNZm9L?=
 =?iso-2022-jp?B?Z0lma1c0SFAydWxwcncvMGxjM2plTEtoeiswbFdyS1dtTmZkUDFqa3ND?=
 =?iso-2022-jp?B?L0NYUk1QVHc2MUFnL0lSM2xjaUNrcWZpMytjaTUwdGtNM3RkUkJXczJS?=
 =?iso-2022-jp?B?UTI5bTUwaVJjMmE1V0JXWURHNVhWcFZBTklSZXVLVklna0dBbmQxVkE3?=
 =?iso-2022-jp?B?a2s4KzUxMng2Y2p6NktYc1Q4UjZXYkZUQTlQd2h5ZHZUdERWQlhrblJO?=
 =?iso-2022-jp?B?Y1Nwbys5cXJGeUNxRzFMT2NBYi9FbjZwNExIVTFXRmZZVXJBWEtKZWlw?=
 =?iso-2022-jp?B?aU51MjE4NmIrL3BNYlNSdjgyRFBTdmlLZTNRTGlHK3lxL0NUaURGUDhC?=
 =?iso-2022-jp?B?aFdBNmwvaks0NkxaM0JzZE5wN09vYldNSG5xWUNUNTdNd2s3WERYbWdJ?=
 =?iso-2022-jp?B?Ty9QS01FS2NPYUtLQ29UUUZMTkR6NHZYNmNtSXhkejBmR0FYRXVKVFlk?=
 =?iso-2022-jp?B?Q2luaTRGZUtIaHRoczBVTEtObkhHR0lZb3VFK3g0L2FuZnhwRVJtcE41?=
 =?iso-2022-jp?B?SG5mMGJTMFVEVitRbFFxSnBlYzEwV0k2a0FKYUdhYmtvU3NzcXEwYXJD?=
 =?iso-2022-jp?B?MXlMKzRLR2I5NHdyTzBpTUVLTDVTTXFqRHlET3pEaWNSRUpEU0ZpN2oz?=
 =?iso-2022-jp?B?Q0hzM0ZBVVNNVGFESkJlTjBSaGtwS0hEKzg2SFViOVd1eCtqM1FCbnpM?=
 =?iso-2022-jp?B?UXBhUUltQ1hsNDgxTjNsQk83R2RtZGFDRWcrWFFSNlNZb1M5KzNzdFVq?=
 =?iso-2022-jp?B?VGxXeG9ZOTdmeUo1amcvQzEyKzBENnYwQThobklYWGthSWJsZXdCL0Q3?=
 =?iso-2022-jp?B?cDdGaW42OFlhS0szVWpqbHBIZlNMRHc1MW0vazU5cUllbzVWdUhiNDFZ?=
 =?iso-2022-jp?B?SG5SVmtrSG54dnZobFVOd2dETFl4TlZ2UytVdGU5aFRGam5VaVYxSVVn?=
 =?iso-2022-jp?B?eUdGUUQ5ZXVIajZEaWQrdmJGV09CeVhLMTloS3FWZE8vK1dPb04xR3Zx?=
 =?iso-2022-jp?B?QkEwTXpzRTdwbERuVFJJNTR4cmdtdHdualBrbkdpYUVwbnFyUGJsS0Z2?=
 =?iso-2022-jp?B?a0JBZ3ZWU0FKUitlTkRPWEpTdmdmbDkyY3BKb2hZT2YvZ09QTFFSSFph?=
 =?iso-2022-jp?B?YTMxR3ZhVkdMOXg2aTh5WUgzd0ZBNVZ0RzlMYXE2ZlVTZU80azQybnR6?=
 =?iso-2022-jp?B?SW90ZmdqYmFrQmVZUjgza3hnYWk4cXR4SVFxZkpkb0pRZFNyQi83WFIv?=
 =?iso-2022-jp?B?TzVXRUZ4V0N1RVBvTHdHeVZINWUxTVNrditwYVJkbnRxQTNaV1VKazFH?=
 =?iso-2022-jp?B?ZndTSjJxTTBsejAvTjcrdGc1VDNYa1JsZHR5NXhqMDk1YWx6QWdDNlFX?=
 =?iso-2022-jp?B?c2JRPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aWJ0QXdvN0NXN3JRdGVwd0h0eURQZnFaLzhWMTV0dGFST2VYOWZDdkp4?=
 =?iso-2022-jp?B?ZG8vTVNaSUgwaU1zcmFDOUVubndJL0J1REVhQVIxMzRCYkZiMGFUQnRw?=
 =?iso-2022-jp?B?cFZzR2ZORnptbk9rK2x0TzlaZFkrb1BNVXoxUmlzREI3QmxGSEtQRXNr?=
 =?iso-2022-jp?B?YXI1U1lLV05Ed1dNVkpESTUvK1craXNTSzVaZ1NTZE9PZ3RDMjBKS1FP?=
 =?iso-2022-jp?B?S29UdlRnMVZ0em1YQU95WDVYdDJ6am5VbEZmbWZiU0ZRaTVNVk5kaEZB?=
 =?iso-2022-jp?B?VEtWR2JBamlXWDJZTkdFQStxRjFhU0NVK2hRN01qMHBRYUhYZzRKWGQx?=
 =?iso-2022-jp?B?K2dXc0dJbnlxYVI5QjF4ZE85eXlMTy9BMmZ1WCtWRFJVakNxb29mZVh0?=
 =?iso-2022-jp?B?blVkRDZxMTQ4UUpmeVFyZExqNEFyak1uZTBsajAyU0JFbWQzd3FrMFUy?=
 =?iso-2022-jp?B?cFdYVkpQaDBTMkt0SHU4VnFYSEg3SzZkaWdzVklnOVZRWDhnSVc5Q3NQ?=
 =?iso-2022-jp?B?OUZYTWlpK3NRQlhsNHJCd1FLRStDQS8vSGd3czJ4MDdYbkdSRzdDUktT?=
 =?iso-2022-jp?B?a0tTZ3A0ZDZyS2J6SExYaVVMMDZSV01SbENQWkNNd0pPWG9MOTN5Vkl3?=
 =?iso-2022-jp?B?dWhNZ2hiZ0M5VVkwelFhMHJWelltQlB6MWp6UHJoc2c3Qjd6UEwvcGRt?=
 =?iso-2022-jp?B?Uy9EcTBiNTJEU0g2NlZRVjZHK3JVem54Y245WTA3SWNJWFEwMFREeDVU?=
 =?iso-2022-jp?B?V28xMHZseHVoNGo3RjQ3d0dWaW55cXRqbkRxNCtKamNta0M3Z0xlMXds?=
 =?iso-2022-jp?B?NCt3Y0dUcEdnOG10b0lrNGRITGlnN0IrQWdyZXJHQjV1UVZCNXNYVHds?=
 =?iso-2022-jp?B?UkNzM1laSjJ2NkV0VXM2MjJFRCtnL05VQkVsRG05aGNWS2RhNjRtUFpp?=
 =?iso-2022-jp?B?UVFZTkpEOXA4d0tmbUR6K3d3dE15anRhVnBJVWVXQXoyTFljT1pHazl3?=
 =?iso-2022-jp?B?NHlUcjB0eWwwb2J2QlA0UTZNV2dNM0RMbWtYZktIaTNBeFZITjBNWDNQ?=
 =?iso-2022-jp?B?MlgxRGZRS0xvRTJqVUdTM0dMM1lHRTNEeG5oRFVOQkR6Y0J6ajhGOU1q?=
 =?iso-2022-jp?B?bVdLU2JTSjd1NUZWaVdrMmovMUo0TGdVTVowTW1vUHNXQUFWc1d1KzRz?=
 =?iso-2022-jp?B?blI4d3Z3SFg0TzdlZGREY0krUy9SeERnZjEvc3dDS1luK2ZrMzhZbXBy?=
 =?iso-2022-jp?B?Mys5QnczOTlTOXhoOVdYV004azMwdldpa1I0dStLYjhlTUl4ay9kQ3Y2?=
 =?iso-2022-jp?B?ck5rYkVzQllaTkVhM2RTQ3EzRnRtMVZPMXI1WW1NK1o2NjRUcS9kSkxB?=
 =?iso-2022-jp?B?M1ROSC9HTHFNcFdzN3pTMEswdXBXRzdFNm15U2M2NGZJZTR1SFgzNTNt?=
 =?iso-2022-jp?B?UEdtcVI4L2daaUkzNVVuWDNiTVg3VmhQRGpXWC83YTZESkw1ci9GZ0Jz?=
 =?iso-2022-jp?B?alFVTjBUZXl6NndETzdzcjRFMkM2OGY1bHpnWCtOUElXWERWVjdBZHRs?=
 =?iso-2022-jp?B?dW9uVVlCdWR1VjlucUhVZVhxQjBUNWNqVG5QS1M0eWpsOHJMbnozZkJr?=
 =?iso-2022-jp?B?Q296TXd0VDk5ZDBVOTJ2SjdremdGRmpPTkd5N3hIcDJvSnd1Z1hPelhD?=
 =?iso-2022-jp?B?OEtyQk9WZDByM2JFZ3pKQUhpODZ4RWlQc1V1R1RUUG4xNTdvbkFxMng1?=
 =?iso-2022-jp?B?dFc5aHZIWFNmRkVrRlVValFxY1R1S1kzT3hvVE1XSEUwSTd5ZkhRQ1g1?=
 =?iso-2022-jp?B?S0ZVbG9JcS83Sk5DbVNuc2t3QkVoYnFxM1VQTWRCdmRSZGwvVjZ6SzhB?=
 =?iso-2022-jp?B?em4wTUVLR3JHcTFmVE9XdEtOSHdrdzJHWWVjOGpTME5CanQzUGwvbnNj?=
 =?iso-2022-jp?B?d1c3WHE5N3YxekE1ZW14VHRxOUN3ZisrSzZEaVBCSzllSEFGK3JFTEU3?=
 =?iso-2022-jp?B?UGwxSXZrOTVuWlJDR2xLZXQxcGROTHMzWHVwWGM2NXNDRGFNMG9oNVpw?=
 =?iso-2022-jp?B?c0xVdzR3RjlRL1JEMDZVTXlER0o0RXlTQXNKbG1Wa2xUc1UyQnRqZm9S?=
 =?iso-2022-jp?B?K2pzVDhmNUxzYndBdm1pZThWVXFHUUk3SGk0dlUzUTFxVlpXR3ZQanor?=
 =?iso-2022-jp?B?bWYyeExLUTRlbU5oSlEycjJlbSt6V3pQWUNoZ3kvR3BXQ05vdU5xQ05S?=
 =?iso-2022-jp?B?K3JMWkt0eGZZZHIxdDE1YWlPbXpEZVVuSndWNmtzU0ozd3Yxc3RSS0FF?=
 =?iso-2022-jp?B?RkhlYThKSnVvU1p0aUhnRGdMVlBCcGZ5eFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75011764-c89e-4e3c-7039-08ddac9b0959
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 06:00:03.3036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p03250GHkGkHTdg4KAnye8TH8tmC3aYkWikROVrVNKvEGX4e6/xf6sUphdTFn8DzO21VZfC3HpCdAxerpLixNrzdyYWRDDDPK+2afGa8ZYTr5WMIYr0s3Gpsjq06yFU0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15382
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 06:00:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19091

Hi,=20

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Friday, June 13, 2025 7:15 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.de
> Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org
> Subject: [PATCH 6.1.y-cip 00/14] RZ/G3S: Backport ADC support
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Hi,
>=20
> Series backports the Renesas RZ/G3S ADC support to v6.1.y CIP.
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
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   |  39 +-
>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  53 +++
>  .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   4 +
>  drivers/clk/renesas/r9a08g045-cpg.c           |   5 +
>  drivers/iio/adc/rzg2l_adc.c                   | 426 ++++++++++--------
>  5 files changed, 331 insertions(+), 196 deletions(-)
>=20
I reviewed this series, LGTM.
I can apply, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshibc.co.jp>

Best regards,
  Nobuhiro


