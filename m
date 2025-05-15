Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731D6C3ABC9
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 08:00:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.7771.1747296037576785538
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 May 2025 01:00:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=AI2sokKR;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1747296014;x=1748505614;bh=FQ
	oygOgF+znpy57iJAKhvCjQBDldSb92Ub7K70NHw2Y=;b=AI2sokKRq0pcIysSBeHPxmqbuKVaUX56
	+7+CUYAcPN13QNZbMWxF7hfX6KU6lOFE/vU7nq10e0P50YbRg47Ab5Yx7nJzrgC+bkYviYA454Vyh
	oOtn7M+bLej2al1CUcecii1ksb+I9gNy7YDa/m7zsQeCSgjJ5sOzSVC72upeRDUOki2/rNhMU7m03
	BtJJDM0Xxtcu/zUnYcxbg+FqHIQkR0ft2pM/kIlYpX0sFVyAK9lff5Exp5BrMVELFUzoTsrmyGn4q
	sLxU+yScpC6wUBnBThnQe0qNStx22TTk1VJ/WTkCXeIcIq3Rfg3w1rm9QcHXGJMsgq3vY+BnnqY4g
	DA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 54F80ESR2819529; Thu, 15 May 2025 17:00:14 +0900
X-Iguazu-Qid: 2yAbyr8UqW6nmlsvdz
X-Iguazu-QSIG: v=2; s=0; t=1747296013; q=2yAbyr8UqW6nmlsvdz; m=JLKzoUGCjeL5c0D0NMOQbd0JzLbn3vxe+Gz4JeEBuPg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 54F80Ca1958663
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:00:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIy8WJucoAbBlSeNJKnWZO3rmKLO58tn00vREKO4JUQrJ5eaPyDvhEZU6xTZKLGlwM6SoIv6jlUDASoRG0DS1N4K5xVIzVGMiNXHhl4kRa4MpOR7IuVZRMjOsMShqfl0gSu4KxS2rRuSQ/kvdmKmgky+VtUV9ToP7jcnmRwxfhtNjFJRoGfSlLXaJNHd33hPbJLkJV7tEedjNBGaWwiyK8aWmji4w3+1XezyJM9mFPmSgQsVM6J+TFggIaQnLPHdWy9CLrnlLCbPTeWLrTouXlmM0UlDslvEuXCZqBqcEU+R8Y1ON2bQ9STqGAgIinbUUzSFUvPR5LtNHLSOZy1+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMNBg/LBpJpxDJkmIssmSDRKsa6kq0TLwSQTujP3Z24=;
 b=eUwypJDcFOx2uN9vwg0gggaE9DNtG/hc1wEZMkuys3qGXaZQ0C95MS6WVMOwWnnxAWbykZg22Ukm0WWyOL1HGHytmfBwUiMuRgs4Wv7S9CvMcTPRtT5tdMV0djOEr+xq/IB2Be6hsfJHkLKfyH7s/KuyUtN+hNldemi0JhSow/hObJ++ekTdCWL27067gUE9BCH5Pi1ABA0eKVf6Fh7OkBAkCsLRmoD11mAXDzmYuOb9hHcoE0NVowlWqfhphcpCdVZN5VhWd/nqBL9WXMDq9Dzjc+huw5Owzj65RmZjjmoVHpUXQck6cf9Wro2KXMPFz6as6fGIxQ96711no8fxgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v5.10.237-cip60
Thread-Topic: [ANNOUNCE] Release v5.10.237-cip60
Thread-Index: AdvFbn1O8Mpf4xdvTaS1A/643ejkrw==
Date: Thu, 15 May 2025 07:56:51 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818B9CD7AE94C55ADAB26039290A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB13900:EE_
x-ms-office365-filtering-correlation-id: e26027a5-c5fd-4b75-2376-08dd93860d9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZE5ZdFN5MGJ3V3BoWnhxT1hFSEpDK2ppZnlZQUdCdzVtM0J4ZUl1WVpz?=
 =?iso-2022-jp?B?QWYyblZOZVVOOGo3UWtCdXd3b1p0djFicXFzUjRNa3FhTUFHMXphSkJz?=
 =?iso-2022-jp?B?RVMwU3BNaFRPQmtBaXBXQmlFR0ZLbkFFa3hpQ1oyUUxzWFRVNis5emVn?=
 =?iso-2022-jp?B?eVlGSlJxa2pNU1U4Q3UrV0phcFpoR29RY21RakpVdDhVOGxSZkkwYjk0?=
 =?iso-2022-jp?B?RVhxSVE5bGVDU2J4Z2N4NHI5aTFVNWJKUk5lMEtiQTAyTjk4ZWN2STdP?=
 =?iso-2022-jp?B?Uit0aUFOY2FuTnhJY3Z1OU9HdGJ3cjdGanlZM0FSZlUxbVVyRHk5c0xL?=
 =?iso-2022-jp?B?cThlYjVIb2JKR1FPMzBGd2h6WGxHYWdKNnovM3RHblpPOHN6aFdZVHJG?=
 =?iso-2022-jp?B?NDJqa3dVQjV5T0U0OHlPU0FvdDkzZSt2VndnbDdzTzg1TE9nY0IxMWdG?=
 =?iso-2022-jp?B?UjR4Y3JKN0tuT2xsNDJvdFY2TXFETEJJTEsva3IvMHlrWEdPSXQ1RWJJ?=
 =?iso-2022-jp?B?TU0zNEhOUXJ6Z3NGNklHdmpOVHJMNWR3U3RhVmIyTHBQazlIOUJXTXg5?=
 =?iso-2022-jp?B?ZkJ5b2cwYXVETFN1d3BMbVJXYzllRjFxRUdVK3JSUHE1RmFnQkZOWDBC?=
 =?iso-2022-jp?B?ZzFWeFlHNG9td0I4cXpRVVBrVTkvS3pvK0FJVERxUWJKQ3E4YUs5Q3V5?=
 =?iso-2022-jp?B?ajJjTnRHTE1tY1Y2U05MdnRUUmJSeGJIcEIyTk5lNVZCVXE5YkNtYVZV?=
 =?iso-2022-jp?B?Q2RKUmtraTdqZEV3WnBIUUk2Uk1uTWpKTjJOVkxrUkxSK1JvakFKMFlu?=
 =?iso-2022-jp?B?cEg2VkpMVFdIZnNXcGVZM29WYjRvSVJkRzU0V245RXVKRHNWTmZwS3ZJ?=
 =?iso-2022-jp?B?RlR1MThvaHQyLy9uQ01lSGRPUHFHTlBFUnY1UzBqWk42T3VJc01UMDQ2?=
 =?iso-2022-jp?B?VFJWSHdIR2RQMGVyTXBkR2ZBVDhramlKMndCNUpiYVhGL2s3c1BaZFJI?=
 =?iso-2022-jp?B?a2FrZVV4Q1BjSjVrSE1MUFNXSEhkcmZlU2txNU5OekRLMjB0Rmhwc2VU?=
 =?iso-2022-jp?B?RE5KYlFORktjK3RRVmJvcjEwWitkaWYwZGJ2WEZWUmJsYWt1eFBIZWlW?=
 =?iso-2022-jp?B?a1lZdzlodWRwYm5kQzlxNWJFUmhYa1ZHYnVETVlEN3BjOVlMcXJucHI5?=
 =?iso-2022-jp?B?d0RNVHBORFVudkVZdXA1anRsSFNuRytGcUIzZ01EdDNIOTFMbW1aYm1k?=
 =?iso-2022-jp?B?TVFxQ2hQOUl0ZWlpZXdVcXQ5bDc4M2pOUm9xbVpxckF3M2YxL3lsQ2Fq?=
 =?iso-2022-jp?B?b2NlSGZRQzFudTlMNVFrWThuL3Fab0RTZnlMWktndlRZYTk4WEdXaUpP?=
 =?iso-2022-jp?B?WmVick5DbW0vU1I1VlljOThlWkhkSzNBbGZyR211OWZ1YStELzEybEU3?=
 =?iso-2022-jp?B?N2xpek0zVzRxbDM4emJCYmJuQlN6RGVENVRVT3Bwb2didnhJWk8wQ1lE?=
 =?iso-2022-jp?B?TnFoUFFxdGR1bHNlNEhaQWIxZ3ZUSUhwSEFwRTBNcURrRUdFYmd4MHc3?=
 =?iso-2022-jp?B?UjY4OXdVUWhHZ3pvQVpFNTVxODFxVXlTR3U1WjFHUXM2cGkzak1wMU1a?=
 =?iso-2022-jp?B?bnA3YkxGVGJwdkpvVXhQRUFoTG95S1lqSGpyc2k0QStYbEtibUZ1cjRK?=
 =?iso-2022-jp?B?aHpZZDBFVW42S3ZkSVQzK05lS3dlUktzdjdCZTB0MGZKR3dwcTdHVHBV?=
 =?iso-2022-jp?B?ek05UXdJbnFZT1hteGtIRnhTK0pCTmtsWWVVRFh0bzNiT1p1ZFJCSjdj?=
 =?iso-2022-jp?B?MVhteTNMdGU3RnBpajlNaXJxN1RuZVR5ZVdWNzFWNTI1Y25mYzNURkhI?=
 =?iso-2022-jp?B?QytVOEpWRHZBY1R1anhmNEFwVUJzT1YzY2lWRTRTZWFYY1h0cUNPY0x1?=
 =?iso-2022-jp?B?d25UQlRQSEl2emRZNW1DNW1GM29xWWVrL01GM0F2V1Z2V1M2SUtNaVFr?=
 =?iso-2022-jp?B?MkhFYTZWNm5sRFQvUnV3ODdHaCtuVDM0d3NFSXJyeTJHQXpGaGk0ZTNp?=
 =?iso-2022-jp?B?c1Z2QU1yclFZRlF2cThRNS8xU2FCcTQ9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Wm4wZjg5cWl6bW4xa1FkUFdrV2F1eU93UENjbkpaTWh2c2xPaFRVNnRM?=
 =?iso-2022-jp?B?SVA2a0l3UjBhMzJXdjh6ekRTNThtQnMvUDMvRnMwdnprUVBGVmpZa3BM?=
 =?iso-2022-jp?B?RWtPL1h3Rkp5MGxvbWYxQ2l0NGVLWEIrelJObG1SeWRKWkxzc1p3Wm5h?=
 =?iso-2022-jp?B?NlA2UzVzZW1FVDkrbVkyYUo0Zi9Cei9KVEJtV0haaXkvaEpSTXFXdVhE?=
 =?iso-2022-jp?B?NWdpUVpwTXlQejhzc2JIZ1VldDd3UnorM0VuYmtteThRcWd3TEUrdzdW?=
 =?iso-2022-jp?B?V0c4K2xQekFxZmVkZ2pOYlc2Z244ZisySUdFM0RKV0VKUVBQTi9rNVMw?=
 =?iso-2022-jp?B?TDJGbERBUjNiSUUxVUNLbnZoUnNUQko4K21hTGZyKytnZnMvRG8yTDhI?=
 =?iso-2022-jp?B?bDNSWlJLR1k2ZU45aDR4dlJzRWNjcWJvWC9LSWNROGNsRUtsbkJsUzRU?=
 =?iso-2022-jp?B?R1lMS25aTnQvK0svWHNYODlvV2oxRHczQTRyMDJxYU92ZEI5M3ZWK2R5?=
 =?iso-2022-jp?B?NHUrTDYzMExnRVYvYjdzbmRERlFPLzNhbGU0REJ0allLZW1jM2EvRUx6?=
 =?iso-2022-jp?B?NDFGQXJqdXZnNHMrYVJaY0RNRFpwbm5VdVFvNDF6K05HM3hYdERTNVlY?=
 =?iso-2022-jp?B?a1ZWZnV6UE0xT3ZZUVlZSGVXalRrbEQ3UDhybjd3L3UxUWdjS1l3cS9I?=
 =?iso-2022-jp?B?NUQzczFqYWJvY0JzMDl5b1BvckJnY2NIWGtKazltaDZ6Q3V6TjlxYlpF?=
 =?iso-2022-jp?B?MFN2TUpjOXB6ajFSd0V6dk5Ccjhqa1ZtU3g4TitWd0IwZW14NXcrditl?=
 =?iso-2022-jp?B?SUhRZjdWY0JCU1pzRWwyQzdhaWlTUncyYk96dzNCV3hOK2RlRDRlay9i?=
 =?iso-2022-jp?B?R1dZcjlQZUdqeWhNWVYwWTU4UjF6MWJRVzNDUThOYkVNTHhaYjZUVmxk?=
 =?iso-2022-jp?B?T0FKSDJnWCtUYi9OVDdxYmVGTmxoL0oyWW1RNWNjMklodHZqM0tKdDNW?=
 =?iso-2022-jp?B?VFh6OHFOK3BNbHJtWkdjOVROaVZvbkh4dnhDclkya3lkY0ZrUTl3ME5s?=
 =?iso-2022-jp?B?Y0sydjU4eDhQRjZuRS9KVGNRYXZQS2d0NzNPbnNybk9UVkRWQ2hMbVlO?=
 =?iso-2022-jp?B?dkZaMy9ON0RJMlFaTER2R3ZSTndzbVJtdC8wdkdnU2g2b01razZ2VmRQ?=
 =?iso-2022-jp?B?NHpQQkJ2aS83aXlxd3FUeCsyYW9lQXNIVEhESlpick9vc1Q4dGZqNjNK?=
 =?iso-2022-jp?B?VFJuTlYzOWZHcWFiRTNRa1FrRjFCMURaZWdlTnF5UnlQNmhySVJ0VEZw?=
 =?iso-2022-jp?B?cWxFWXBQaDFNVDQ5ZWtpU2dCOS9JWmk3MmR2YmJxN3g0UXZuaFE5R0Fw?=
 =?iso-2022-jp?B?MDdLWUdyemFNY01BUEovcFEwVlBkR2NvczhqT2VkcUxSS2NvcGs2ZEg1?=
 =?iso-2022-jp?B?eDU3NEVxRUI5dUdlVjB1VHlpNnR5MzVHWFloYVBwUVJ3cjdDWVIwZ2JF?=
 =?iso-2022-jp?B?djUyTEtnRjBUZ3V0TDVUaFQ0dXhRWEZrdElvRndxbGNvRGE4YVNUYXZl?=
 =?iso-2022-jp?B?dnNQQUZGbFhTS0ZyQ0tvZ1lPMEhrVTZTNVFJeiszb1MzRmFQbnBpcDVj?=
 =?iso-2022-jp?B?QlYzTVRDSXFoV1dTY2hUU09jOHBmbWdtOWJSMDc2bUpBM3dhem90ZlFl?=
 =?iso-2022-jp?B?OWJybDVNbVZ2czAzZFN2UjAxYjdxTmU3bzNhdHk0OEZXZkdhUnp2WGpt?=
 =?iso-2022-jp?B?ckh0clZhMkoyTXNQRkw3cjVIVmVXMXdzV2NoSzkremIzNmN4Ky9ReXVw?=
 =?iso-2022-jp?B?dkQvRHQxWHZkVHlVdm0xcVlzNlZ4bXY1czdBQ2hjcktvT3BWUG03dlIz?=
 =?iso-2022-jp?B?MzNGWXlVSHJ1dUlVYWs3c0FFbFR4ZTRuci84bUcrZ2N3OUhJNG1ObUYx?=
 =?iso-2022-jp?B?Qko2NXlzZHJzMGhmNm9TSHorRjFxNi9PQWwxRFlBR1k2Ykg3VUZRY2ps?=
 =?iso-2022-jp?B?U2dWaFUrR2RkdVg0SGllZE44bzdCMGVmUlVyRHVEVmZkenJUczMwNm04?=
 =?iso-2022-jp?B?N3lxaFBVb1haWGdQYkJmUDZrVHZFMVhoV1hmWXoraWlwODIwTzFRbVdH?=
 =?iso-2022-jp?B?eW42ayswZDlLTys5bHFLakVmMjBrdDJEY3lTK3ZGcTI0NDEzeG1xTFNF?=
 =?iso-2022-jp?B?aE03eFNxNFBMQ2lyMUJtUUtpU1BaVTg3c2NhdVpDaHNyM2ZmNFdEL0k3?=
 =?iso-2022-jp?B?VGVDN0o0Wk9vbXhlZ3h0YWZWR2dFbEwrb0JpWGJWbzlCZFJHKzN6UkRF?=
 =?iso-2022-jp?B?Tlg5KzVmVDhGSUVnZkorVHY4cTRub0lTWHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26027a5-c5fd-4b75-2376-08dd93860d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 07:56:51.9494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lxIoF4ve/psuBifQXIGNkSsLVA6vbQaDGKOzEOYGpH5Mt2dEzQh6+Ckp5idT5ZqbPCeZXrG/SAReOKPDQ2pZjHJ0uQ0ovDzCfcNbmB8N1JL1Dv/W0FFmtwQ/ix9bQKoj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13900
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 May 2025 08:00:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18910

Hi all,

CIP kernel team has released Linux kernel v5.10.237-cip60.
The linux-5.10.y-cip tree has been updated base version from v5.10.236 to v=
5.10.237.
This release adds driver (sound, i2c, clock) updates for Renesas ARM64 SoC.

You can get this release via the git tree at:

  v5.10.237-cip60:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      f32dc72d4e2a5cadfdfca58f84404d51cae038a0
    fixed CVEs:
      CVE-2025-37838: HSI: ssi_protocol: Fix use after free vulnerability i=
n ssi_protocol Driver Due to Race Condition
      CVE-2024-56658: net: defer final 'struct net' free in netns dismantle
      CVE-2025-23159: media: venus: hfi: add a check to handle OOB in sfr r=
egion
      CVE-2025-23148: soc: samsung: exynos-chipid: Add NULL pointer check i=
n exynos_chipid_probe()
      CVE-2025-23147: i3c: Add NULL pointer check in i3c_master_queue_ibi()
      CVE-2022-48893: drm/i915/gt: Cleanup partial engine discovery failure=
s
      CVE-2025-37797: net_sched: hfsc: Fix a UAF vulnerability in class han=
dling
      CVE-2025-37780: isofs: Prevent the use of too small fid
      CVE-2022-49190: kernel/resource: fix kfree() of bootmem memory again
      CVE-2022-49219: vfio/pci: fix memory leak during D3hot to D0 transiti=
on
      CVE-2025-37781: i2c: cros-ec-tunnel: defer probe if parent EC is not =
present
      CVE-2021-47247: net/mlx5e: Fix use-after-free of encap entry in neigh=
 update handler
      CVE-2025-37773: virtiofs: add filesystem context source name check
      CVE-2025-37757: tipc: fix memory leak in tipc_link_xmit
      CVE-2024-26686: fs/proc: do_task_stat: use sig->stats_lock to gather =
the threads/children stats
      CVE-2024-56599: wifi: ath10k: avoid NULL pointer error during sdio re=
move
      CVE-2025-37770: drm/amd/pm: Prevent division by zero
      CVE-2023-52757: smb: client: fix potential deadlock when releasing mi=
ds
      CVE-2024-26928: smb: client: fix potential UAF in cifs_debug_files_pr=
oc_show()
      CVE-2024-42322: ipvs: properly dereference pe in ip_vs_add_service
      CVE-2024-49960: ext4: fix timer use-after-free on failed mount
      CVE-2025-37794: wifi: mac80211: Purge vif txq in ieee80211_do_stop()
      CVE-2025-37792: Bluetooth: btrtl: Prevent potential NULL dereference
      CVE-2024-35867: smb: client: fix potential UAF in cifs_stats_proc_sho=
w()
      CVE-2024-46816: drm/amd/display: Stop amdgpu_dm initialize when link =
nums greater than max_links
      CVE-2024-36908: blk-iocost: do not WARN if iocg was already offlined
      CVE-2025-23142: sctp: detect and prevent references to a freed transp=
ort in sendmsg
      CVE-2024-46774: powerpc/rtas: Prevent Spectre v1 gadget construction =
in sys_rtas()
      CVE-2024-44938: jfs: Fix shift-out-of-bounds in dbDiscardAG
      CVE-2025-23157: media: venus: hfi_parser: add check to avoid out of b=
ound access
      CVE-2023-52621: bpf: Check rcu_read_lock_trace_held() before calling =
bpf map helpers
      CVE-2024-24855: NULL pointer dereference bug was found in scsi device=
 driver
      CVE-2024-50280: dm cache: fix flushing uninitialized delayed_work on =
cache_ctr error
      CVE-2024-35943: pmdomain: ti: Add a null pointer check to the omap_pr=
m_domain_init
      CVE-2024-27054: s390/dasd: fix double module refcount decrement
      CVE-2025-37739: f2fs: fix to avoid out-of-bounds access in f2fs_trunc=
ate_inode_blocks()
      CVE-2025-23146: mfd: ene-kb3930: Fix a potential NULL pointer derefer=
ence
      CVE-2025-23156: media: venus: hfi_parser: refactor hfi packet parsing=
 logic
      CVE-2023-52752: smb: client: fix use-after-free bug in cifs_debug_dat=
a_proc_show()
      CVE-2024-41073: nvme: avoid double free special payload
      CVE-2024-50154: tcp/dccp: Don't use timer_pending() in reqsk_queue_un=
link().
      CVE-2025-37740: jfs: add sanity check for agwidth in dbMount
      CVE-2025-37795: wifi: mac80211: Update skb's control block key in iee=
e80211_tx_dequeue()
      CVE-2025-37738: ext4: ignore xattrs past end
      CVE-2025-37768: drm/amd/pm: Prevent division by zero
      CVE-2025-21853: bpf: avoid holding freeze_mutex during mmap operation
      CVE-2025-23144: backlight: led_bl: Hold led_access lock when calling =
led_sysfs_disable()
      CVE-2023-52572: cifs: Fix UAF in cifs_demultiplex_thread()
      CVE-2025-37789: net: openvswitch: fix nested key length validation in=
 the set() action
      CVE-2025-37756: net: tls: explicitly disallow disconnect
      CVE-2025-37788: cxgb4: fix memory leak in cxgb4_init_ethtool_filters(=
) error path
      CVE-2025-22027: media: streamzap: fix race between device disconnecti=
on and urb callback
      CVE-2025-23139: Bluetooth: hci_uart: Fix another race during initiali=
zation
      CVE-2025-37749: net: ppp: Add bound checking for skb data on ppp_sync=
_txmung
      CVE-2024-54458: scsi: ufs: bsg: Set bsg_queue to NULL after removal
      CVE-2025-37782: hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read=
_key
      CVE-2024-50047: smb: client: fix UAF in async decryption
      CVE-2025-23140: misc: pci_endpoint_test: Avoid issue of interrupts re=
maining after request_irq error
      CVE-2025-23158: media: venus: hfi: add check to handle incorrect queu=
e size
      CVE-2023-23000: phy: tegra: xusb: Fix return value of tegra_xusb_find=
_port_node function
      CVE-2025-37796: wifi: at76c50x: fix use after free access in at76_dis=
connect
      CVE-2025-23145: mptcp: fix NULL pointer in can_accept_new_subflow
      CVE-2025-37766: drm/amd/pm: Prevent division by zero
      CVE-2025-37741: jfs: Prevent copying of nlink with value 0 from disk =
inode
      CVE-2024-53185: smb: client: fix NULL ptr deref in crypto_aead_setkey=
()
      CVE-2025-37758: ata: pata_pxa: Fix potential NULL pointer dereference=
 in pxa_ata_probe()
      CVE-2022-49309: drivers: staging: rtl8723bs: Fix deadlock in rtw_surv=
eydone_event_callback()
      CVE-2024-56608: drm/amd/display: Fix out-of-bounds access in 'dcn21_l=
ink_encoder_create'
      CVE-2025-23150: ext4: fix off-by-one error in do_split
      CVE-2025-23163: net: vlan: don't propagate flags on open
      CVE-2025-37765: drm/nouveau: prime: fix ttm_bo_delayed_delete oops
      CVE-2025-21681: openvswitch: fix lockup on tx to unregistering netdev=
 with carrier
    added commits:
      CIP: Bump version suffix to -cip60 after merge from stable
      arm64: dts: renesas: rzg3s-smarc: Add sound card
      arm64: dts: renesas: rzg3s-smarc: Enable SSI3
      arm64: dts: renesas: Add da7212 audio codec node
      arm64: dts: renesas: rzg3s-smarc-som: Add versa3 clock generator node
      arm64: dts: renesas: r9a08g045: Add SSI nodes
      pinctrl: renesas: rzg2l: Add audio clock pins on RZ/G3S
      ASoC: dt-bindings: renesas,rz-ssi: Document the Renesas RZ/G3S SoC
      ASoC: dt-bindings: renesas,rz-ssi: Remove DMA description
      ASoC: renesas: rz-ssi: Use NOIRQ_SYSTEM_SLEEP_PM_OPS()
      ASoC: renesas: rz-ssi: Add suspend to RAM support
      ASoC: renesas: rz-ssi: Issue software reset in hw_params API
      ASoC: renesas: rz-ssi: Add runtime PM support
      ASoC: renesas: rz-ssi: Enable runtime PM autosuspend support
      ASoC: renesas: rz-ssi: Rely on the ASoC subsystem to runtime resume/s=
uspend the SSI
      ASoC: renesas: rz-ssi: Use goto label names that specify their action=
s
      ASoC: renesas: rz-ssi: Use temporary variable for struct device
      ASoC: renesas: rz-ssi: Use readl_poll_timeout_atomic()
      ASoC: renesas: rz-ssi: Remove the first argument of
rz_ssi_stream_is_play()
      ASoC: renesas: rz-ssi: Remove pdev member of struct rz_ssi_priv
      ASoC: renesas: rz-ssi: Fix typo on SSI_RATES macro comment
      ASoC: renesas: rz-ssi: Use only the proper amount of dividers
      ASoC: renesas: rz-ssi: Terminate all the DMA transactions
      clk: versaclock3: Add support for the 5L35023 variant
      dt-bindings: clock: versaclock3: Document 5L35023 Versa3 clock genera=
tor
      clk: versaclock3: Prepare for the addition of 5L35023 device
      clk: renesas: r9a08g045: Add clocks, resets and power domains support=
 for SSI
      arm64: defconfig: Enable DA7213 Codec
      ASoC: da7213: Initialize the mutex
      ASoC: da7213: Extend support for the MCK in range [2, 50] MHz
      ASoC: da7213: Avoid setting PLL when closing audio stream
      ASoC: da7213: Add suspend to RAM support
      ASoC: da7213: Return directly the value of regcache_sync()
      ASoC: da7213: Populate max_register to regmap_config
      ASoC: codecs: da7213: Simplify mclk initialization
      ASoC: da7213: Add new kcontrol for tonegen
      ASoC: da7213.c: add missing pm_runtime_disable()
      ASoC: da7213: Add support for mono, set frame width to 32 when possib=
le
      arm64: dts: renesas: rzg3s-smarc-som: Enable I2C1 node
      arm64: dts: renesas: rzg3s-smarc: Enable I2C0 node
      arm64: dts: renesas: r9a08g045: Add I2C nodes
      clk: renesas: r9a08g045: Add clock, reset and power domain support fo=
r I2C
      i2c: riic: Simplify unsupported bus speed handling
      i2c: riic: Add support for fast mode plus
      dt-bindings: i2c: renesas,riic: Document the R9A08G045 support
      dt-bindings: i2c: renesas,riic: Document R9A09G057 support
      dt-bindings: i2c: renesas,riic: Fix 'unevaluatedProperties' warnings
      i2c: riic: Define individual arrays to describe the register offsets
      i2c: riic: Add suspend/resume support
      i2c: riic: Enable runtime PM autosuspend support
      i2c: riic: Use pm_runtime_resume_and_get()
      i2c: riic: Call pm_runtime_get_sync() when need to access registers
      i2c: riic: Use temporary variable for struct device
      i2c: riic: Add support for R9A09G057 SoC
      i2c: riic: Pass register offsets and chip details as OF data
      i2c: riic: Introduce helper functions for I2C read/write operations
      i2c: riic: Use devm_platform_ioremap_resource()
      i2c: move drivers from strlcpy to strscpy
      i2c: riic: Use platform_get_irq() to get the interrupt
      arm64: dts: renesas: r9a08g045: Add DMAC node
      dt-bindings: dma: rz-dmac: Document RZ/G3S SoC
      clk: renesas: r9a08g045: Add DMA clocks and resets
      clk: renesas: r9a07g044: Add clock and reset entry for DRP-AI
      clk: renesas: r9a07g043: Fix HP clock source for RZ/Five
      clk: renesas: r9a07g043: Add clock and reset entry for PLIC
      clk: renesas: r9a07g043: Mark mod_clks and resets arrays as const
      clk: renesas: r9a07g04[34]: Fix typo for sel_shdi variable

Best regards,
  Nobuhiro



