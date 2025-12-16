Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FA5D5E14B
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 13:09:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22247.1765890574155440618
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 05:09:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=ltNIyXu3;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1765890556;x=1767100156;bh=BvwlWFv+i2rppLq0guH1UP1eZq5EcGbzIpmuP
	lrH95g=;b=ltNIyXu3pJV5ifqmJa0zWJa8Qw6E5AwKV3WeXYfSSrbzejkjySfRPZSL69P5t6kfGAo
	ytXomapIf8icMHlthEyrkePaWrSoHUatOhIlkncHb+QzZYqbKJU6N0Cl4DhdsepOdtVL981MhDRM1
	CUFJ3VHUnlep3mRgJI5ZL+0ZPGqkLD3QkWLRfIRBa+AUfA5gSKRmBujHNapI5bO+bDMXQF8GNuWSa
	KTcciidAAmR7jjoISOEkkt6Kz1xJyVybpnkK2dtntVf9E2RQC36chh6nM92K92BbK79n6U1tlMZFQ
	KopWGmG0YAyZXbjqheQ0jql5HL9sIKnzSb3q1V9/SDYg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 5BGD9GRp4099548; Tue, 16 Dec 2025 22:09:16 +0900
X-Iguazu-Qid: 2rWg9DyHFIAkHnmqcC
X-Iguazu-QSIG: v=2; s=0; t=1765890556; q=2rWg9DyHFIAkHnmqcC; m=0seNsQejlsiEUt6GWFDDKwhg17MLWPu2TMtiGjuIfd4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dVy1l4zrZz4vyh; Tue, 16 Dec 2025 22:09:15 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMPXi4et3fbvFghlLrow1f2vObpQTQs4ES91Ras8UcvE8dnLxs5QQMAb14baSePpNbc9D/SjsQmyu/arjv0S8WoItZxWnxS8W11+CNjy7/MuE9s4E0rQvXx7sT/gqW/dldJEXAlWksRwjP9SXdK1PUCbWG08cxV3m8Y2xjeCeoeow3laGzmKhRZEhb/5kH9vYscBMKYxOLf1GlsVoWAjnPW8F7/GJKuTgBnjfgIERs9Fr2YMw+h0XTabZD+YXCIE9rPk1NYmZmr7zv2XANW7CKAiS3541TKaw+/WOyiva/wWpgfXi/QiLSzqANPURvmL0TDMC3OkfB3+YXeCPgjxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXDPIOCHizj7yD9ydIOcRIhFKrK+y2yr9y8T43h1nqA=;
 b=Hr8RgtpDiEM/cmmdyj19TJP82dBCWFFAPXYXNkIjg1OJ1PLDQq+OkYvXjoFVWV0spqrc86aEVnKlYQ3bObw3hYqSAA5rCze6BbBdwaMljyWNTGUeieMPuYEHqsrbAaQ9tUVVatW3FjW9zir3T7MFGLKHhwlXhNGQw0RLxHL1Qm+PBVYY9MR/8fpE4pgjM91c6oTDd6WgxyNrmPw9pr1cEZLu7knudaWJKcncMGGyXkji6Eezj6XE265VJdd6/e+cMEKeLcD+sUPb8K8gzl5nwNUUoKDtK+BDfWyTQdeiUQoOvU2qcMoH53cCOIKkC+//6FeIWb9ZB21ojtEnypcjtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <biju.das.au@gmail.com>, <cip-dev@lists.cip-project.org>, <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/3] Add 64-bit polling support
Thread-Topic: [PATCH 5.10.y-cip 0/3] Add 64-bit polling support
Thread-Index: AQHcbcHPkkOM9r+8F0m5ntGsyWRPhbUkPlzg
Date: Tue, 16 Dec 2025 13:09:13 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148189B8BB07A8AC8B9189DF1CDAAA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251215125316.137879-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251215125316.137879-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB8425:EE_
x-ms-office365-filtering-correlation-id: bfe6f3df-748e-4a93-a9bb-08de3ca44f19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bTRWSlBGYnJkTzNXSUlVYjlhR1hNa2dTcDVmK0o5ZU1nOVlwZGNKUVI3?=
 =?iso-2022-jp?B?ald2aDBSYnY0MmZCMG50YkF4QnJWSngvUU9VcUEzSElVQUNHTm1PamtU?=
 =?iso-2022-jp?B?MFJ0M1dUcEU3bktxWmg3VUlCTW5Ya01sbEx5V1ZMK2s4V1lyMFZMcklX?=
 =?iso-2022-jp?B?aUJRRVZIaGlrL3ZOWkV5QllqZzVweW14a1EyRXRwWDRrR0xLR2F5TnZp?=
 =?iso-2022-jp?B?R0dPZ3MwVnluU2RXRjMrbDcwYUt0MXRWbDRiNHhieXJaeW03T2NoVnlt?=
 =?iso-2022-jp?B?WUF1bFhuRzNlUnJTV0hOa0hzSTcwazUrcGlxbVhuZUVVWUtxb3NURzVo?=
 =?iso-2022-jp?B?ak80eEhQaEZWRWJlU3lxMTFIWmIzZ3NkQ2Y3RUphMWhNTlNxZ2ozM1ZX?=
 =?iso-2022-jp?B?MjFLMHJzM2xHVjVXdGxuTXJtZmhYaTF0MHdIWHZ5QkoyNHRxcWpWL0Vq?=
 =?iso-2022-jp?B?VTh1c0d0b2ZtTUNLWFpQQVY1NGc3ZmI2eFgxYWNkQzdjU0lPcFRSVmg5?=
 =?iso-2022-jp?B?dTFGNks5am9wQWVXWStJajV2L21rWGxnclA3S01lbk8rb3JNbDdDd1VY?=
 =?iso-2022-jp?B?VHp6T0F2L3BmcE8xNkIwS2tlV2xZQWdkWDNVR1d1eXRMRW03dXZxNGNw?=
 =?iso-2022-jp?B?QzJlT1Zmcm5GRWpKQkNZOWkwbmNiR25PczRHMlMvbk1za3lMU0hNUDJ1?=
 =?iso-2022-jp?B?VFg0VHRHazFIR0sxMFJEZUcwWm01L0RSbHVYQkRqWGR6Um02c2VIR2E2?=
 =?iso-2022-jp?B?T0VIR1JNRTZOS3BMd3BqclBkTDdVZ0xtbnFocXRRanpMTVlGUTBPWm5S?=
 =?iso-2022-jp?B?c0dPUHlzZDBLQXAwaXN5WkE4aGQvS2kxWmFCRVN3cnorTTRQYlB0MUR0?=
 =?iso-2022-jp?B?WmwxdHR2bEJwaFNKU2t5WVFDY0gvdnNzMjlCQmYxMUw3ZkdiazVwbStV?=
 =?iso-2022-jp?B?UWJnTlVod2lnRFpvd1dlOE56dFh0T2JKL1lVRTNpamh5VDg4djc1QTF3?=
 =?iso-2022-jp?B?ZXdsSU5CWUlSczQ4dndtMUZGRVRqLzR0RzJHVFZpR3ZQVExzTk5lRzNV?=
 =?iso-2022-jp?B?Qzl0Qm15ak1vRVNYUk9IM1BOTXlOQS9kSWYxcUp1b0ErWEE0Vml3dTBD?=
 =?iso-2022-jp?B?aW9WaU0yZjlyaElXZmJrUFpPRGV5NklsL0pLaTV5cVVjUGJvMXpERjBp?=
 =?iso-2022-jp?B?ZmxJaU1oRWRuRUJENVlBKzVZbGNGZWhEWFM0MCtibDJvUzllU1ludW55?=
 =?iso-2022-jp?B?cXNJa3VWMjE3NGdjRlkzcFlmRlN6MWJYT3AxcE9SVlg2L2NGQitSVkVC?=
 =?iso-2022-jp?B?cE9yRlVFazV6SCtpajlXRWhDK3lQb2FPQmEvc3BqR0lwSTRyeWNMWER4?=
 =?iso-2022-jp?B?Tjh5RjljbUxhWGJOL28wekJxUGVqTDNwbWNLU09IdVJ2MWNqUFNjVEpv?=
 =?iso-2022-jp?B?LzRMdkIvWFl3Zm5tR0taU0FWbGF2Z2tvbGFQWnU4UmtsQk5tYm9QWXFD?=
 =?iso-2022-jp?B?YjYrNGRPYVJUbkdvZThQU1orWWUvSXQ1NzRLZ0tNVDZwdU4yRmNraVNT?=
 =?iso-2022-jp?B?QjJvbXFzZ0Nmdll6eWFmcGVNbEtpVHhmWUlnUWkxUGpRYUp1c0pwbUdP?=
 =?iso-2022-jp?B?Zk9Ec1h4QXR0Tkk1VndBYTdacWJPRTNvWEw4ZmsycStFMUVxdjQxcGh0?=
 =?iso-2022-jp?B?Y3hoYmh3Y2x2N21pR01HcWE3ajlGQ29tSm9MdFFqb2cxYzdJOVd3MG5Z?=
 =?iso-2022-jp?B?ejRpb0hYdUhFWVRpcFRFOUV2S3ZsQUtUcnhGeEduelpQK0RGNUQyNUps?=
 =?iso-2022-jp?B?RDZ3WngyWVdtT1U2cXhHdTBPanQrQ0h4TENPTXVsdWludWZIMmVscGRw?=
 =?iso-2022-jp?B?ZlMyMUh3dW5wTkJxb3N4SWtHcjF0NXJoVlJnM2dVZXJRM0RPUGNNL3hR?=
 =?iso-2022-jp?B?czdyQ1FyWDV5a1ZZMWc2N2RVVHJoaDcyV3BwaC8zdUtaV2d6RW84YVZo?=
 =?iso-2022-jp?B?RU0xOUc5azBESTg5b2pManUrV09keXAyeU1wSFArMlpCVlBpSUZlSDJ1?=
 =?iso-2022-jp?B?NWJEbkRNS3IwRGdFUGo2NFlrVG1FbGN6WXVrYUtrMjI1MUJ4OEVNTm5I?=
 =?iso-2022-jp?B?aXN6UThCTndvbVN2dXNaaVpPclFmVjhmTXpkeE5sMCtzZG1XMlQ4YzBs?=
 =?iso-2022-jp?B?WURPNUpDRUFrRWd4Y2t6TGxzV09wS1Zj?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?T3VWcGkwdkdST0IxcXpERG9JWGlNbDd1NS9hYkt5dUNUYUxjeW1vTlQ0?=
 =?iso-2022-jp?B?eVFBbE0xMjN1RWI3bTMyU3FHcHhRdzNWcG8rNDhXR0VtS2JnMysvbjJQ?=
 =?iso-2022-jp?B?dmRnSUlxWjNEUy9ySmpzNG1pbEtJZ3Jub1crWWhPdDRMN2dBaENqejhu?=
 =?iso-2022-jp?B?QVh3UlRjRXEyTDlHd1lFdURGWUhWaXVpTUVMT21TYm96MXFrVUlTN3Np?=
 =?iso-2022-jp?B?cFhiVGhJbGZncmVqK3JKS0xFbkhrY1BoTHJzc085NWc5K3B4WGJYcnNV?=
 =?iso-2022-jp?B?cVFMV29oYzRBWHUwUm1xTWF0OFlDeEJtc0JSVlFRdUtReEdXTVpmRCtt?=
 =?iso-2022-jp?B?THoyT011YUk4SUNJenRaOURFN1FCdkpML0pUZjZoR1pNWkdiS0ViTFQ0?=
 =?iso-2022-jp?B?ZWpXRVQwV1N3MDJteS9zNGYxZGMybFlPdHExYnFUQUtqWEUrWW0yWjA4?=
 =?iso-2022-jp?B?bjhtMlRPelVuMm8wditGUUJrMjQ1cS9OWUU1d1JjQTlzVDg4ZlNRcU1S?=
 =?iso-2022-jp?B?aW9vbTc5VDBUMDlBNlFQVkxPdzBxRHl3c05DOVpUeHdJR1JoL3hVbVhF?=
 =?iso-2022-jp?B?Ris5OUFJUXgvRFh3N0xkeENYUVkrU0I5STJiRUMyc3RFT1lMM0RQTmhN?=
 =?iso-2022-jp?B?TDRKVjBjUlhFalM5UXdSOHJ3VUE2YVVNSkZ0OGhaaFU3ajVUYTlKbkJG?=
 =?iso-2022-jp?B?RWFTY2RwdEZkN0lXYXlXZVk0bmkxYkhick51OWE3dzZYWGkxU01rT0Rj?=
 =?iso-2022-jp?B?Vk1HL1BLU0RIMjhId09iVUJJL0F6R0VCUDZBZ0hNWThGYnV3L2Y0NWhW?=
 =?iso-2022-jp?B?OU9TUTVieWlGY3pUYy91dHNlWmFZREI0VXB5UGlJbkpRUEdzREt2dXJj?=
 =?iso-2022-jp?B?N1l0YWtaN2xMakZtNmd4WVAxYjlsRGRNbjZRUytFdzJXYmdzKzhmTEpT?=
 =?iso-2022-jp?B?OWdYd2IwYUYwR05waHBLZVJQOVpvdmhLakg3ZVFHVmFwRWswTjloUktr?=
 =?iso-2022-jp?B?aHNLSmNnakhCbXJpMWFVWWE3ck5ESXpuK3hVY0JCTUFlWUZxeHNleTdj?=
 =?iso-2022-jp?B?R0EvczVVZFN1ZnRMVFB0TStaZDJ0alllVnRDdC8xYkN5ZlBqemtSWkZX?=
 =?iso-2022-jp?B?UGdHQkczQkdwUk8rL3N2ZkR6UTlncTBSd2RDMVU3S05xWFY4dzZhNmtR?=
 =?iso-2022-jp?B?NFIxNFZOc1lPUStpS0lQbFd0ZWFlWFlKbU02RmdOeDhZRFJBYk1ySGRz?=
 =?iso-2022-jp?B?T2t3UkFNdE5hNis5bXpzbEJaaHNac2h2ZDlxanJxWjFha0l1R1EvbVVR?=
 =?iso-2022-jp?B?Qm1QN2greXBQVmlqWVBkTkFyMzdJRGExNWRYZGxERm04ZW0wSzFzQ1dT?=
 =?iso-2022-jp?B?UmJlcUhIeE5FTkMvc3I2ZTVBSDQxQmRSNlRwbnRwNFpEdDB5Rld4OXVT?=
 =?iso-2022-jp?B?S0VEbVYwci9ZNU9mb1ZPQ0ZFUEVTSDdlQWl6L2NCbFRiOXNsblNnN29p?=
 =?iso-2022-jp?B?RzdzNFdXQ3htYlpRU0duK1RJemxoUnc4aEliUkI5VUpDSFErN1V6Nmtp?=
 =?iso-2022-jp?B?V2ZwR2VqVWF5anNBKy9GdVpIeXA1OUE4OWREWUtpU0tEYkI5eWtxYk4y?=
 =?iso-2022-jp?B?eGZWc05kY2FpZFp0UVlVR2swRjhkWi9MdHBoT3NQeVhvelcwc0VieFFD?=
 =?iso-2022-jp?B?ZENGNkNZTWV5QU8yZU5IMGxoTWFIY0RHaStvbnlaMnVzV0I0aWhpTlBP?=
 =?iso-2022-jp?B?cWdRSTBJSCtxQ3pCVWllQ0lXamlEY21OZFFIWUEzejFGTkRGbnJUM0hZ?=
 =?iso-2022-jp?B?LzhTTUpHOGVMbWJGQmcxT2pKQlBiaFdtVEwzMDRldW1yenhWMmhnRnJz?=
 =?iso-2022-jp?B?TSsrcE1SUk41Qk11NFJpZ3N2c0Irb1VObWFDdTlwUHR6c2xFS2dqR25F?=
 =?iso-2022-jp?B?QXkrR2lWSUVkT0VieUhaMUF5bW5QZ3orNkZocjdxREpnc1dmdCtUa0xk?=
 =?iso-2022-jp?B?N1BXZjRsTTc1aU9jTG9FdVlsVkpHNWZ0NXY5Z29kRlJjdllsQUdvemdh?=
 =?iso-2022-jp?B?VitoV01qa1NlZjJ4cHdwaC9TQ3EydDQzV3A4NUd0cXBWVkw2Q1N2Y1c0?=
 =?iso-2022-jp?B?SERPV0NHVUVCTnFqbkhuSGt2SXpKS2M2aVhKNnlVeFNwVkF0RDNvR1NE?=
 =?iso-2022-jp?B?eEpjVmMrc1FSNC9XZHZseWFrR3NiSUpEM3VoMnVJNWxUamtZaVlJLzhh?=
 =?iso-2022-jp?B?QUFlZmpIQnpKQTZBb1dhckNGVzNGUjF2NFQyMlY1L0RURm5qRUg4WExR?=
 =?iso-2022-jp?B?K1dRblYxVjJDSTU0Um5oQjR1MWhnMzhNeGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe6f3df-748e-4a93-a9bb-08de3ca44f19
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 13:09:13.2124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jwr5akRxJaNVKQWrBMVbyZxQvF2Us62n94QjZUk6t97HOecQqHXgLzgN8JP5WWu/WvYUk/bef8eM+IeRzy1/aWJyuIbrZRMX4vPNsLDszay0XUgFFioDrf2If8tXIgw7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8425
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 13:09:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21084

Hi all,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: Monday, December 15, 2025 9:53 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C=1B(B
> =1B$B#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 0/3] Add 64-bit polling support
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> As per the RZ/{G2L,G3E} HW manual SD_BUF0 can be accessed by 16/32/64
> bits. Most of the data transfer in SD/SDIO/eMMC mode is more than 8 bytes=
.
> During testing it is found that, if the DMA buffer is not aligned to 128 =
bit it
> fallback to PIO mode. In such cases, 64-bit access is much more efficient=
 than
> the current 16-bit.
>=20
> Biju Das (3):
>   mmc: tmio: Add 64-bit read/write support for SD_BUF0 in polling mode
>   mmc: renesas_sdhi: Enable 64-bit polling mode
>   mmc: renesas_sdhi: Replace magic number '0xff' in
>     renesas_sdhi_set_clock()
>=20
>  drivers/mmc/host/renesas_sdhi_core.c          |  2 +-
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
>  drivers/mmc/host/tmio_mmc.h                   | 15 +++++++++
>  drivers/mmc/host/tmio_mmc_core.c              | 33
> +++++++++++++++++++
>  include/linux/mfd/tmio.h                      |  3 ++
>  5 files changed, 54 insertions(+), 2 deletions(-)
>=20

I reviewed this series, looks good to me.
I can apply this series if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


