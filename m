Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FDDC36010
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 14:09:50 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.54])
 by mx.groups.io with SMTP id smtpd.web10.50876.1743084588196673013
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Mar 2025 07:09:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=dSZd1/XM;
 spf=pass (domain: renesas.com, ip: 52.101.229.54, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQCb3IuAyB+CP1Lfhbx2HzWnJJg60XX3/V3peVZvgMw6hvLqBfQLWAaj3ZpkteTtXHyd5UFn/wi3FR09h/mYlqkuQYs0LACjWL0TNXt5ZJZMVaTfSo9GksFN82SiWTI8dNRU3YupYxx6nOzwawUDwTD+g+JP+rFsdMccxsCAvQnlblCVtY4inLe4u86aKRYG22G0Yx8NdVoXeJmdFabeViKlHhyXLfZHFXHcb2SuOihA0fJcHFHqy6JLk6K6pCDIcs4yHM06eGMRPJKirE1woM2f+0gxWvFhw+Aiz9Jx4Os/z8vHJF7dIiX/JF3TqTeLrKtwesKAWwYG7yjbcLtkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4k9RrFm/ZQWNLr7OeaYOHob3WByA28DrAqFIROuwfo=;
 b=yMf0nMJtKbp5WVFH2nzuGMB5Li/uiwIyG5DLeL8qqdO13g3G/PEGhcrRwRWb5BfYglKAX0QREy4QtaVhuGBgwXiTTokSu4nuQbvIJEKVMiNW3RHzPABI1THmI7uiCgEyHi8zYvs0rgRVQWYYhi4IQ1QZtwaAFtpMiw4PkIQ4LgWQIMI9jkT5vd7dcXVl/GXXc5gTmMZ9dfhRB/uslw3EM37ZCxMoSD7cJ23h9SemDKRDNwgpo6HK7yomu/SDTcZdm1hk3pj22aDb2fvL4sO5YShxvPQPCjXE350sMVLVPe+cECh05ST2dZle+aRcs70f7FVp5XB5ebmYlg4oL0mfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4k9RrFm/ZQWNLr7OeaYOHob3WByA28DrAqFIROuwfo=;
 b=dSZd1/XMUrKWqzQc0AGrakomSCoZVzmdDU9cV9KaKtXXWiQlwz6FPgqcE3qGZgsZp2kyFmT/BLr1ZGR5lYI92qICaj9bssVUaicHI155VM2/PKMdAVG/z/L5HGA0QP/emGJ1Ze/y4ivxjwEpFukSphjHBzcE1vitNZ6evIYeTS0=
Received: from OS3PR01MB5896.jpnprd01.prod.outlook.com (2603:1096:604:c6::8)
 by OS3PR01MB7239.jpnprd01.prod.outlook.com (2603:1096:604:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 14:09:43 +0000
Received: from OS3PR01MB5896.jpnprd01.prod.outlook.com
 ([fe80::1b62:57c6:c2cf:641b]) by OS3PR01MB5896.jpnprd01.prod.outlook.com
 ([fe80::1b62:57c6:c2cf:641b%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 14:09:43 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Shivanand.Kunijadar@toshiba-tsip.com"
	<Shivanand.Kunijadar@toshiba-tsip.com>
CC: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>,
	"Adithya.Balakumar@toshiba-tsip.com" <Adithya.Balakumar@toshiba-tsip.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: Request to update all LAVA workers
Thread-Topic: Request to update all LAVA workers
Thread-Index: Adue/RC0RLD0UqcOTASX222hFpAV5gAJL39g
Date: Thu, 27 Mar 2025 14:09:43 +0000
Message-ID: 
 <OS3PR01MB5896A0BFFFA760FE2F5A8F15B7A12@OS3PR01MB5896.jpnprd01.prod.outlook.com>
References: 
 <TY3PR01MB110757C96225174319F00BA9AC7A12@TY3PR01MB11075.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY3PR01MB110757C96225174319F00BA9AC7A12@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB5896:EE_|OS3PR01MB7239:EE_
x-ms-office365-filtering-correlation-id: 1d74b5fd-d5ce-4e63-a106-08dd6d3905c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|7053199007|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZTVZcms4akhhNXoyRUg3bUM1b0hGb3FCNG1nMGpBcmNkTC94SmdyR295?=
 =?iso-2022-jp?B?NFh0aURmNTRyNG05K0FWVDlqZEVHZDhMVkpHdnUwRTNDZjVWTU5ueWhJ?=
 =?iso-2022-jp?B?ZEpjN3ZCRjJtUFo3V2RiNnlKL1NaTTdKNkZOQW40eDZWSXBUTlBYRHQx?=
 =?iso-2022-jp?B?VlNvampvc2lUQnlIRHZQVTd1TGJTaVFJYWhrNzVKdDdMMzgzSEo2by9l?=
 =?iso-2022-jp?B?NnRuM1lneUViN3FHcDNkV3VuUjhrZTRVK0gySHJoUmpHSENYbVFQeDFF?=
 =?iso-2022-jp?B?QWJpTjNWRjF3WDRpK0lCWit1eS81NWMrYTNsRVZmODRwdnUrNkpaeUow?=
 =?iso-2022-jp?B?NGFhUkN3cFFhU0xZQWNRQ1FkSmtSNnRuTmFGZHljb0NwU2JFRU02aE4w?=
 =?iso-2022-jp?B?K3FNWllKdWluejdhelhVbTlNSllYRE5KcGZ6L0tFYi9MK2xrNFJQUEQ5?=
 =?iso-2022-jp?B?THpVMHB4bVAwUG1zQmZTRnV0d1VMSUNzcFZOVFhhNCtLd3ZMbzVQOWU5?=
 =?iso-2022-jp?B?bmlSb3N6aHR1akg3Y2Q3enBXcDUwMDh0TC83SmhiTWpvd2s5eDQyOWpE?=
 =?iso-2022-jp?B?NnljTjkvS1RBaE5XMkJtT0xGZWRQWk90V0RIWkRVS2lxekZkRzBHV2t3?=
 =?iso-2022-jp?B?eldxbllnMkxJRDErTnlqejdLSkg4N240dVlrOFZNQitWTG1ITVE5azl3?=
 =?iso-2022-jp?B?a1pzZ2p3UzZqd0NHVlZqcFphMGdFWkFqMGh6NUVYYTFzeHpScUhFRDA2?=
 =?iso-2022-jp?B?SG1sRklIcFQxeDhadHgvOEVWbVBjN09tQjNrdE9scHlQTWQ0cEpXOVZL?=
 =?iso-2022-jp?B?QlNxQWZPSUN1WitjTGloUWRhS3k0TnBOTkhCUWlLY0VlQ3NnSk1TL1VV?=
 =?iso-2022-jp?B?bEpxTEhobzFkWG5FeU1vZEpzYTlOazlsWWV6ZzdFa3YxT1dKeVM2OGJQ?=
 =?iso-2022-jp?B?SUJDaW9KSUE1Z1ZKUDRLY1dpbXdaZGV3akZaNjVQLzN5QVEzOUNraVRU?=
 =?iso-2022-jp?B?Zlp0eW90V2pSbGkzRFExN1FPZEhHUjZIMHRqOGkrYXk2bXdBNm04Q0JE?=
 =?iso-2022-jp?B?bDRJR0FuTFRqWG50WE5oeHNTK2pRaWE3cEp2REFmbDZ3ekM2VkE1V3VG?=
 =?iso-2022-jp?B?dmxaYWl1SzlqRTdFKytrT20xWXM5R1dtOGhpdGhZVlpNRzdRNlE1a1lt?=
 =?iso-2022-jp?B?N3lCM1RXWWZET3hKaktsa0c1ZlpubndXcGhCZXJEUTY5ZVZ6ZUF3TEZy?=
 =?iso-2022-jp?B?ZTdPSkV5RlFPS01UQlVXdXo0d0FFOFlmaWd0TzNmdGx6Q1ZRZHd4dSty?=
 =?iso-2022-jp?B?c1EzSXgxUllqN3lVc3ZSSEZ0Y2hpRCtVTk4zRmRmTkw5NzFxU3RiRUZl?=
 =?iso-2022-jp?B?MUV2eG9VOFoySHFFZUdUOGFuenc3NG5najFxVGhyTFBmUnFCUlBzSlhp?=
 =?iso-2022-jp?B?eTFlQUgxdStoR1NFQkNNYXlreXFUN21sTGF4Vm9VcWNEQk9COUlxbm9y?=
 =?iso-2022-jp?B?Sk5hc2ozQnlrTU5DZ1doUThZRXBEbFJNYXNVdnl5cGhoQ0czMzN2OFoz?=
 =?iso-2022-jp?B?UzNmWXZ6N3JRZnNSVjBMN2h4SXVBWmR1SHkwSnRPZ0IrVExQeHdzTkxY?=
 =?iso-2022-jp?B?UE5OUndJM09LZWVZTjR4TEtDWTJEcHRyTlJVaXp1aW8vb21FUCtjeVh1?=
 =?iso-2022-jp?B?TEtiMXhGelI1eS80aVdOVHVoQUxrcGJJeHlNS1lVSW5McDNlcENLbHVm?=
 =?iso-2022-jp?B?ZHpBM3dhNkRIVDAzc1p3NC9MU1p6cjhVNzVER2plZWo5dkUzTXlKTjl6?=
 =?iso-2022-jp?B?MUF3Ryt6YmFhZWV1a1VjbUZtQnBKQ3UvWDRXa3NDWURzaGpUZmNwakZl?=
 =?iso-2022-jp?B?WU9DZVdTSTNxZjVQKzZKOG1aWnpYalVpN0V4RVFUNkdhcE9ReDNRMVA0?=
 =?iso-2022-jp?B?b3NMZTBFZDlPT2U4YzZ6UlA1ZE5DRkVjZTVvOVhjUWFSODNHak9oQjVo?=
 =?iso-2022-jp?B?YndqY2VvZXZ3dGVmaHVRVmlDYXdNeXM2OFpUQjIvenljbU5mVW9Sbmg1?=
 =?iso-2022-jp?B?V0E9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB5896.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(7053199007)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Sm5ISEkyOUxvaHVlTmZoWVBJbnpXTmt4MnhmbkIyVzNPRE1sRWphb2NM?=
 =?iso-2022-jp?B?RDcrYmpxY2lteC8yYmducmVoVVRUZzVHVithQTdhdFZTUXpralhqZm0w?=
 =?iso-2022-jp?B?dXNjV2FaVG9KeEdrWjV0YXNEYWQ1UTRJaGhOSDh3SGxmK2JWVUlxV1li?=
 =?iso-2022-jp?B?c0Q0OEVJcE9sOWVlMXRRenJMc2sycHRiQi81RVpRbVE1N1NPNXRKQ1ph?=
 =?iso-2022-jp?B?SmRqMVBLUzUvbklwQlZqMHplY1lqb1dOUFo2bDlOS0NPZFpwRWlFbDk4?=
 =?iso-2022-jp?B?RzNmS1hGVk15NFVYSzBSbGk5c2hHcXRGdndaM1pCQXhNUzNhbFlPWHNX?=
 =?iso-2022-jp?B?OFZMelRCUFVGM1grZzVjd1RBbzZKT3VHNSswbjltMm9uOUNORVFmTzNJ?=
 =?iso-2022-jp?B?NGRXS1FTalBIemx2YXNmc3RjNi9EMFVHcHJlZldlQUtzVHJZSDJ2L0JB?=
 =?iso-2022-jp?B?RCtUSXhBdXU3UXZiUkJKRGRWc3FURVN2WnlqeklRU2NGT3VUUXo4V3VO?=
 =?iso-2022-jp?B?czA5ckV1UFA5UWR6YTI5ajdvcmxidlVjeW1YRExtUnkxL3Z2K2g4U1Rv?=
 =?iso-2022-jp?B?LzJuVXN2WG5Jc0U0ZTAvYTJCSUdJbkZNRG9DV0t3WkNseStxUHIyd1Rz?=
 =?iso-2022-jp?B?M0tBcUk4YllmakRRN2YxZ0NCUHlsa1JKT2Npei9iQlZlNjh1cHRpVmx2?=
 =?iso-2022-jp?B?ZzBLYy9ZNGJhOU9ld0JaNXhPbWJTUW5BVVJ4NzUzWEY4ek4wYWlQVTRn?=
 =?iso-2022-jp?B?WEJWdERCTmdueWcyT2xCYUVoeVcyRWx5Tk90Y3ZyOTFZR0FFbzJuTUxG?=
 =?iso-2022-jp?B?dDJLUi9CaE9jVDVVd29BclhoQlprYjNUaktEWWdFNy9WaHJvMEpZSmRQ?=
 =?iso-2022-jp?B?UmxSWFRNaXM5a3MxcmJJK2JEYmVyTUhoZ21ZRDY2ZjgrS0lqNm5IdGxa?=
 =?iso-2022-jp?B?Qi9td1B1SXplNTloWFo2ellid1JwNVZ1L28wM2hnNGsrZzd2VUx6aFhK?=
 =?iso-2022-jp?B?TjJSbmtMNGJLbHpsekR5MUpNNGNPemp6bkRCU2dEMmo5ZU1Ka01udUxM?=
 =?iso-2022-jp?B?ME9KalFaVU5vdmlzMWhJY3dWWEpaTEFSWDIyQnhUVTZqbHEwT2NHSTRR?=
 =?iso-2022-jp?B?L0RXVUROQzhSZ0FLdFNEaGUvU2pGU3Y5N0NlRTFZK1dZY0VkMzlKYkZk?=
 =?iso-2022-jp?B?Y1hMRnBjbFVTQmVTWVFCSkVGelN2a1BJbUtUQnhiWHdUaC9KNitqVmFX?=
 =?iso-2022-jp?B?eGJmNGs2L2dFYnBPbEZDR041Nk9wMmc2d2pYNDN6K05zM1dxbUNmUUl6?=
 =?iso-2022-jp?B?K1JhQ3JtSVd5WU1LNUlmY1FDTGJOTUNaTGV3NzQrMEF6RWR6a3BER3N3?=
 =?iso-2022-jp?B?NWtrazV2VUMvazB5MVZZQmlOTGtsdnZuR3IyMnhnQVBwOHgxaEs2N2FS?=
 =?iso-2022-jp?B?L0lMeWdqK1BqdmZ2QlJMTWY3T3Awa0d0M2dZNG9ad1IydXAvY3VjS09X?=
 =?iso-2022-jp?B?NndBY1lhY3F0SURzLzc3UFVmcjJHbi9zZ1ZMYmsvcmMyK1lPNkZmTFhP?=
 =?iso-2022-jp?B?WlN6VXZWcER3ZU9xckNNc0d5K20yczhNeHRuT0RTbE94RVpRTWc4Mzcy?=
 =?iso-2022-jp?B?Uko0TWVQNStKb01kS2RGYUdoVWJwNE9FZG5IRnZ4UjhPNTZGcHFWa1I4?=
 =?iso-2022-jp?B?THFOMWlQZWhld1dndmtmTUJjbzhEcnA3ZnEzZUs1bmY1STBic3dUdUJl?=
 =?iso-2022-jp?B?Umxub1J4NnU5STY1SmJRVS8zbzFiRkN3TXdkOXJpMnA5bDdma29uRjEx?=
 =?iso-2022-jp?B?UUM3T2J0YzNMbVVGQ2JkN3ZLZEw0bUV2T1Z5a0IzUGpkOGp1K1orS0l1?=
 =?iso-2022-jp?B?d0VIeUtRejVtaDI0R1VXZUZLbWovQndHY3dENlJmaDVyeW83SCtBTXJv?=
 =?iso-2022-jp?B?d0ljRzZRVk5mVUxJTjkzRGtNSDBGNEh0NjVOSmJGTm5YTjNweENhOXRh?=
 =?iso-2022-jp?B?Mlp4V2N1MEgraDJ4bm91aUM1dG5BbS9XQUViTmVoMlhMaHVCK2NPWk9E?=
 =?iso-2022-jp?B?NXdOdVBzbkhYdEc5ck54T2JmamluNEVQVUJ3SHE4L29TRHFDVXpSQnJy?=
 =?iso-2022-jp?B?TjhzYnZIWjQ1SC9sUS8yaXhHSnFYZE9HcE55Q09BZ2dCbW1rdVhaYjZ3?=
 =?iso-2022-jp?B?c2F6U2tuQWhPMk1kRDBXenJpVTc1OHpFVDFaeWVwMjdRdDRza1h0dXNG?=
 =?iso-2022-jp?B?aXF1NzJHMlZKWG9SSEFtRTBieDAzQjkxdzcyMDA2b0F3R2U0TVFYLyta?=
 =?iso-2022-jp?B?Mkw5V2tVc1NkbEt3dUtqYUpxNlkrOGQ2U0E9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB5896A0BFFFA760FE2F5A8F15B7A12OS3PR01MB5896jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB5896.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d74b5fd-d5ce-4e63-a106-08dd6d3905c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 14:09:43.3966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOzS5swxCV0jAMHKeLIqSqiGpfGuRXLMONVDGjUHoKzge7e8EOZk59PgsF5ipkk/ZuS0XEla+BBWaf7umUQR/GoxZYaW1tCU1jEOH7W4tTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7239
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Mar 2025 14:09:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18378

--_000_OS3PR01MB5896A0BFFFA760FE2F5A8F15B7A12OS3PR01MB5896jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Shivanand,

Apologies, I forgot to get this done.
I=1B$B!G=1B(Bll make the request now and let you know once all is sorted.

Kind regards, Chris

From: Shivanand.Kunijadar@toshiba-tsip.com <Shivanand.Kunijadar@toshiba-tsi=
p.com>
Sent: 27 March 2025 11:06
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: dinesh.kumar@toshiba-tsip.com; kazuhiro3.hayashi@toshiba.co.jp; Sai.Sat=
hujoda@toshiba-tsip.com; Adithya.Balakumar@toshiba-tsip.com; cip-dev@lists.=
cip-project.org
Subject: Request to update all LAVA workers

Hello Chris,

Recently you have merged a patch in lava-docker repository https://gitlab.c=
om/cip-project/cip-testing/lava-docker/-/merge_requests/44
You also mentioned we need to wait until all the lava workers get this upda=
te. I checked today, it seems this change is not reflected to any lava work=
ers.

I need the above change in all LAVA workers as some testing is dependent on=
 this change. I can=1B$B!G=1B(Bt send the patch to isar-cip-core repository=
 until lava workers get this change.

Could you please check/request other LAVA maintainers to take this update?

Thanks & Regards
Shivanand K

--_000_OS3PR01MB5896A0BFFFA760FE2F5A8F15B7A12OS3PR01MB5896jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#7030A0;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0">Hello Shivanand,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0">Apologies, I forgot to get this done.<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0">I=1B$B!G=1B(Bll make the request now and let you know =
once all is sorted.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-ligatures:none;mso-=
fareast-language:EN-GB">Kind regards, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">From:</=
span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans=
-serif;mso-ligatures:none;mso-fareast-language:JA"> Shivanand.Kunijadar@tos=
hiba-tsip.com
 &lt;Shivanand.Kunijadar@toshiba-tsip.com&gt; <br>
<b>Sent:</b> 27 March 2025 11:06<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> dinesh.kumar@toshiba-tsip.com; kazuhiro3.hayashi@toshiba.co.jp; =
Sai.Sathujoda@toshiba-tsip.com; Adithya.Balakumar@toshiba-tsip.com; cip-dev=
@lists.cip-project.org<br>
<b>Subject:</b> Request to update all LAVA workers<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Hello Chris, <o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Recently you have merged a patc=
h in lava-docker repository
<a href=3D"https://gitlab.com/cip-project/cip-testing/lava-docker/-/merge_r=
equests/44">
https://gitlab.com/cip-project/cip-testing/lava-docker/-/merge_requests/44<=
/a> <o:p>
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">You also mentioned we need to w=
ait until all the lava workers get this update. I checked today, it seems t=
his change is not reflected to any lava workers.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">I need the above change in all =
LAVA workers as some testing is dependent on this change. I can=1B$B!G=1B(B=
t send the patch to isar-cip-core repository until lava workers get this ch=
ange.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Could you please check/request =
other LAVA maintainers to take this update?
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Thanks &amp; Regards<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN">Shivanand K<o:p></o:p></span></=
p>
</div>
</div>
</body>
</html>

--_000_OS3PR01MB5896A0BFFFA760FE2F5A8F15B7A12OS3PR01MB5896jpnp_--

