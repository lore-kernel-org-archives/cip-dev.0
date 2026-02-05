Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4915BEA7964
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 04:06:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13364.1770264360206458398
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Feb 2026 20:06:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=SROXi0k4;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1770264355;x=1771473955;bh=OfpY7JbQ8VrY5hPIaHyDmpaKYjYAmM4txHPkH
	SkMOYE=;b=SROXi0k4e0w5FC/rnpVidB9AUuHVGzTjPJ3qrJT5+p0qvkmxaJaqQ/nDNV6NdpWCMB2
	twDYWNP9n6gwPMT6BG89K7K/mb/cl4s5y9Q3j9BLrdNoz9VvT3HliTsybTZq/bimPatXLen08zqkX
	OQeIb29DdZnhuDA84qhUt1t6Zo9+kopR3103WCvCFH7beBTDuChA/7p4zaHpfS0sKXvGpiOM4mtfp
	TIPzZuDHSqEBWyWSj7ykGXQvAyDQNPnh+cYPr2TqYvSJSgd52POglOFUgMhaXJP3A4HIlfRrKjgvE
	ULf3qE55zk5uXtRrZWQGurXlaT2772C74N4vmy3VFafA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 61545s4u326218; Thu, 5 Feb 2026 13:05:54 +0900
X-Iguazu-Qid: 2yAbS7rJlda0GiHcTg
X-Iguazu-QSIG: v=2; s=0; t=1770264354; q=2yAbS7rJlda0GiHcTg; m=fGO7ovaAka+dcpIVRZznZ1Wd98l+LIlQy4qWVzdm/VI=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4f63YF4SCXzyPQ; Thu,  5 Feb 2026 13:05:53 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQsK5k/w1y9LH8nQHD25JpystZ4MunFMLxGdmdNtZ1ZLDfPNgNuHEymUpKwH2cjDIOcxDi8Co96CD73K6s5V0L22wIsS2fpIwrcmyDqERMM7H5k/gdVcwRYqr7xKzSf8rJBJM+Ro54wWEH6fukw5xS4ML2A/Kv8T78dMmlEJ7U2WRFE9I2IGjqwY5HD7BMsApj45hkRj7h2OnU/qTxoyaREpLTMN+CL+SBmo0WqBgGrWevS8UlhwPMBRDCjxUoZjkUc73TLre2miEOkNoV7VNAG7yiZr+1PJPMYjy4da0qt9IShd7GQGmU0l6Y730CMsTgG9Srlc2aDAj6684tS80A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfMt9zksMQfyKbQPM9Dzl4nd52FcuMdxS7b9pV1l86k=;
 b=PYN3HwJbLFhJZoS09l9JINaPDSNEnCT2EGMU2BSRR/j/C0kgpRKs3R3OhO4cx1S3dgtG6uXv+M3TKOJueBBCAh2J2yCxho+NUpNqB4kB6MrQ4B2jrE+fdBsMlQM9jd78O+m8Z9bO70IVGs3Fmiu7nmwl5wS+izRF3uySr7mTU5q7hTD2eKlXCA4tqLU4bdqyl8xVqrwGX0aDh7EbxsAwbo4AjQE53kMPPTeMpzVeOKfM7mw9PltSEn2xrbO2SjGExMKnaNwmCZvWFQFT9O1SM3gkE6CV3aL90Q5Rk7QrfZrED+DC8NXupEMjV8TTl7go+UWzeU70VcFZSCfVR9Vzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <john.madieu.xa@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <john.madieu@gmail.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/2] ADD RZ/G3E TSU support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/2] ADD RZ/G3E TSU support
Thread-Index: AQHclO1tEP4zVJPAaEq+XTkRW0jvprVw1JYAgAKqMKA=
Date: Thu, 5 Feb 2026 04:05:50 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148189BA8DA6EF39494E90F18CD99A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260203091332.98580-1-john.madieu.xa@bp.renesas.com>
 <aYHaMO8DZzKrUz7Z@duo.ucw.cz>
In-Reply-To: <aYHaMO8DZzKrUz7Z@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB14985:EE_
x-ms-office365-filtering-correlation-id: 7208fd34-19bf-4fb6-49b9-08de646bd9ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|14052099004;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WW5CUTZuZm1rOVdkVERrR2dIamNjbWx6S0FVVlRPTUNKeVdqVHpVMTRX?=
 =?iso-2022-jp?B?QUJsL3orUmxEcG9NZ1BGMXZGMDAzMUJlY0x1YmxYSDMyOERPVXBwL3Nj?=
 =?iso-2022-jp?B?ZVJyU1BKTTFZUi9GS2ZScVNBUFZrcUhhb2VIVW5NNUY5V2hvbGlBSHZ4?=
 =?iso-2022-jp?B?YkVsUXRHRmtzYmkxZmw0OGcxNHdQUEZDZTZlMkJIemVaUWU4bWw2VVQr?=
 =?iso-2022-jp?B?aTNuTlUvd1dxWStrY3NmZkFLOW5QOGU0NkRlVWVKUC9oWFFteS9ialZ6?=
 =?iso-2022-jp?B?dHZnd1h3NXpzZ2FyYjZMcmxwVHhteVhZc3cwZklDc2p5M1pSZjFTS2FK?=
 =?iso-2022-jp?B?VlhibldVN3lVYmlkdjFUUmg4M2RJTmNwR09TUEh6cTJyVmlQbW5td3RR?=
 =?iso-2022-jp?B?Y1lIc1p5N0dvelBtRTlDTTNhZkpHTjdkK3ZCY3lLU0t5YzdZMTV5Mnlv?=
 =?iso-2022-jp?B?RDd5L3FsT004RnI4L0Y4TEphYmNWVkVTaDFTMGtVMWlGQ01sT0lEREFD?=
 =?iso-2022-jp?B?clRwODh4aXlZSEtUc01GZFNwWU1sczZvRWR3QTZkZDNPQlpSeEJBaUxj?=
 =?iso-2022-jp?B?cHJmN1pKelNNNnFyKzNWS0xhZHRaRDd5YW02bFJZbGJTMUM4MTlKeklW?=
 =?iso-2022-jp?B?UUdtc1I2K2d1eTVmcCs3SElPVGkrWDB6ZUVMT2ZCWnpTNEFmdjB1NDNw?=
 =?iso-2022-jp?B?cWVjMnpyWTNRa3dFR3huenlDemdWdGsyOHdDQTBCTWxzb0VUWnpUN1U1?=
 =?iso-2022-jp?B?YW9Da1BxN0tJeTNTTi9oRE5LNk1hYXVTdk44T2xFdlQvbjFpcUk2TU5i?=
 =?iso-2022-jp?B?V01naDdPQlFFS1BoWkFRSmNiZHRuNnRPdXZpRHIrbFRjVHIxVE44cnlk?=
 =?iso-2022-jp?B?c1hMSjlvQ3hDYzFTcXUvaVpRQk94OGh3TldZaEpDM1hIWTFTNGMxUXFM?=
 =?iso-2022-jp?B?NmJxenBZekpGdmE1eUt6RnIzYkV5SGt3b2MvN1Y1T1F3VGNhZ09Wc2lH?=
 =?iso-2022-jp?B?SGlsM2QrVFhpNDR5MU0randWRXQzMkwvK3RjM1l1b2hQTEQ2c2J4N3kw?=
 =?iso-2022-jp?B?Rmpzb2FQN00rcGwwSno4VUNmbDRrREdqL2RIUEtmTXVVL3BZTDVWcHZj?=
 =?iso-2022-jp?B?RlVwNktJOW51eUJyNGpNS1dtU0piR3hnU1kxeXFVOSs3cWZ1d0pvK3Yy?=
 =?iso-2022-jp?B?RXYwd1BvZUR2L0NKMS9PaW9mSVgzcE5mUCszSElGMXpVQUZWVXY2ci91?=
 =?iso-2022-jp?B?Nll6aXQ4UFRra3lVUFhzWlp2OXhRYWJrUXRsa1d5WnU1d0ZvOGp5RUpp?=
 =?iso-2022-jp?B?M1NlM0dxRm5DeHJlVU5RTjI2YUNNdzBNYnoyVGdZRGtPdXVSYUdTeGJD?=
 =?iso-2022-jp?B?NHB6NXJ6WWJyUTVDNWErQWJ3UEpWMkVTMUp0K000ejB6cm5kbHBUYnZT?=
 =?iso-2022-jp?B?UXpiSTRyM3FRaW9EcXJYclhYV2Q1Z3JjVW9IMlptNWRLSU9UNEpMaFJG?=
 =?iso-2022-jp?B?UzhsUEIyaFZsbC9CZFR4UjVmTzd3NGlGZE1FVHJTcSt0azhxUG9xUUYy?=
 =?iso-2022-jp?B?eGlsY25ORGNBdU9yYnpKakp0dTlBL0Y3N2VXYzV1NzhidDJTcTJsaXFW?=
 =?iso-2022-jp?B?YjZhQ0piOXdWS1hXb0R3L3dpZ0oxTUJIdWRyRlV1bVl2Y0RpR0FHQm1w?=
 =?iso-2022-jp?B?SXJGNTVDeVluQWpLb3dGQk1lTjZrWnNaaHFQNzNFR3BCcEtta3VqTG9Q?=
 =?iso-2022-jp?B?eWxVTHRid3gycy95Nk4wcTFzOXh2bFltQ2pHQWpNb1hFM0YzVERKR2ZN?=
 =?iso-2022-jp?B?Z2hMbWorSzAranNWd3U1U3BjREo4eFc5bWpHVXF5Um41N0EvR0htc2s2?=
 =?iso-2022-jp?B?cEd5dDF2SitvNThWdzhkQ04wM2RGcThTTG1VRGdBbGhCaWN4d1A3Nndo?=
 =?iso-2022-jp?B?bGp2ZkFsYVB4TWhTcXRCSGZQdjZHUkNjQVFnN1VYdTI1ZEo3bnN0NnR2?=
 =?iso-2022-jp?B?UnA5YjVvcy9iSkJvWmh1c1ZsVUxTMzlUd0ozRzZodUJoenBGVFQvK0FT?=
 =?iso-2022-jp?B?bHVZOXh0ZmpCL2NuVXZ0TnUyMUU3TTBlMHg3dWR6T3RjVjFjY0NUSDNT?=
 =?iso-2022-jp?B?eSthdlBXSjQ4cytLTmZPT0FOVVRJdWp0VS9oNWM4ZWVxTC9YRGdlbW0y?=
 =?iso-2022-jp?B?MUtGUHYyWHhrakY5NTR0dEw3L3d4K0g0NTNZaEk1ZjlHL2xSUkJRV1E2?=
 =?iso-2022-jp?B?dldsekx0Mmg4L1poMFhsdGhQdFpjcmdCTjMvVzdLWEpVSHJSWm1ncW1I?=
 =?iso-2022-jp?B?UWJMZkl1eW42enhpbmtBaEl3eFpXN01vMDQwdThudUZ0TFNkMUpsSDkx?=
 =?iso-2022-jp?B?c1hCcnc9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(14052099004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?d2xLQWhTeVRUN2Q2eHR5dFNmTExLQ05rMXpsV2lSTHF0WjdPdnhFY0Uz?=
 =?iso-2022-jp?B?b2lrbC9HMExPUHVUOEtyaEZFbjA3YXE5VjBCYndvYXpNVmN4Q0E3WWwy?=
 =?iso-2022-jp?B?bHZGVTRVS0I4U1RiSVZzYi9ETTdnbTFCUlo2bk9COStmRFJ4bWVKcmFu?=
 =?iso-2022-jp?B?cmg4bmNZY1F2VGJlRjBjcHcwZTVqeU0vRDlSVDh4TlIrRSswWHhTMk1E?=
 =?iso-2022-jp?B?dFpkalFrSGx5NVJ0TXVWK1JQaWtoNEJFblc5cFhJdnpHK3NtZXU5cUZr?=
 =?iso-2022-jp?B?amE2NGExdWljZjRNVUZ1NzBvMkFreHc4UDlpamcwZ3NFaTVEdGFGY2Vt?=
 =?iso-2022-jp?B?ZEg1dzh0cm94WkNnWStIbngrTUlPeU13UXdsRUk2Q3JPZU5PTFVkengy?=
 =?iso-2022-jp?B?NXYzbk01TENNR201MXd2M0llRW00ZE1rUWNYOHZ2akFPMzh5Y0lXVXhN?=
 =?iso-2022-jp?B?a2luQ2FKZkY4R0NiTUEyaVB1YU9OUDVlZWFOU2F3Z0ZMYk5vVzVGblY2?=
 =?iso-2022-jp?B?MExuOWg5b0NuTS9BME9zUnd1dHF0aVQwZlNadHVDdGZIMktST25uRmpE?=
 =?iso-2022-jp?B?c1VLYkhFYjN3MCtQUTIxS0Z1cDViaFJIWktQcTBJMUoyS2pnVkVJS1Vz?=
 =?iso-2022-jp?B?R0plQ2JzZ2NGcFdOOVJlRGplSHowUC9tYUtyK2JINVhkVkxrVGJnREFK?=
 =?iso-2022-jp?B?aXRNN0drNlI3UUh2aXNJeFFIUDV1MGVvcWRlcnUydGtTNVNXYTBobXlp?=
 =?iso-2022-jp?B?UnRRL1BCWW5KK0htY3V3aTVQREREWFlPNzZ2eU45aXlxdENVWCswS25p?=
 =?iso-2022-jp?B?dkpSY2Q0ZVBqL1BVeFAyNVg5bzJEV2dpZngzdCtNUVl5cUpMbS9VVk80?=
 =?iso-2022-jp?B?blVlNC9NR2pJNzNtRDBFS1JNZGpnbk1ndjFvc0lDMW13aUQxKzQ0N1Ew?=
 =?iso-2022-jp?B?bTNCcmJrYS9vMDRzb1RGZmM3SVpaYytFY2NWbElaYXpzMld3YU40cjlB?=
 =?iso-2022-jp?B?MXk2UC82N1Y1YzE4d28xRXRDRGZ3aW9yMnhEMVRORDFXNDBtL0hweU1J?=
 =?iso-2022-jp?B?aEJEdVNsVjdqRjJTOGVvTy80RGF0bnZqQVR3QzM4OGdiK05BczJHWk1a?=
 =?iso-2022-jp?B?WnRvK1gvc01WQW1hMmwzT09NUklyb0VJRGhOckZzWXZETEpTTlljS21U?=
 =?iso-2022-jp?B?b3ExUjlGUzZKRk1CS2hGLzBDTHVlTC8rbk5UL2EvaTFaWE1JZTRVKy9o?=
 =?iso-2022-jp?B?U3N1OTdNU3NKWS8zRll3aDJhcVBNTDhmaUdlTXcxdStRajVUTUE2TTVU?=
 =?iso-2022-jp?B?eVlER2JiNUdOS0dtUVNDSDBzK0h4Vk52QTIySVNJR3ZVZDVwWCtEcWtC?=
 =?iso-2022-jp?B?NkJBWk0zRnBTcDFQYmcydm1Db1ZidHJHZGdkME9Hc1Rrd1FNQ0tVcVJs?=
 =?iso-2022-jp?B?WDhVT21JZjAwYmhFTW5ldlIxWitRYUpHTXg5YUpjd0p1bWluRkRDTUQr?=
 =?iso-2022-jp?B?cW1xeVpaYWpDOHdSYTdlSzJBaC9VS3NkM3NFbXc2NzdMZG5QY1BzcEhG?=
 =?iso-2022-jp?B?SVpPcTBOcXRTRjFNZkJRSm04UmNmR3FaVWJiOWRJR2ZjQlhnQkdLSURQ?=
 =?iso-2022-jp?B?RnJyUUtYM0w3UTFER2dGVUxqL2FKSWFRcU4vUUtUaDdlNGRwTDhQRE5o?=
 =?iso-2022-jp?B?OEVjWnQ5aFoxZTNIK2JpOUI2b04ydVJnQ3BPQStpKzlHeERGWjlaOENO?=
 =?iso-2022-jp?B?aTFxbHlBU2l1d0lyYy9xcS91UlcrSGhGRHNieW1nb05qRFN0eVZnQjds?=
 =?iso-2022-jp?B?bEhUN1Izdk80VGIwWDdzQjdyM050ZTU0aStybk03c3JUUDBWM0RvajND?=
 =?iso-2022-jp?B?WUllY0svRDBFcld5aVZTU1ZtOW9QQStyckE1MktGemg0RG1oSUxiZlZF?=
 =?iso-2022-jp?B?VDdSeGdmUTdEd2s0dExSUGJsWGU5VWhTNWVyRGxNOW8vM3NsYVZHSDdK?=
 =?iso-2022-jp?B?Z3BYeG9DTlh6KzJxUnRXM1YveHc1TURXZWR2NzJwOCsrS3dPYUpaVVZF?=
 =?iso-2022-jp?B?WGU3bmVScnY4Sk5UbHRJNTRKeVE2REtkZ2FEUEtibTFtbnlLYmUwL0RE?=
 =?iso-2022-jp?B?MEo4cjhKQzdIY2xPd29XOTNFelNYcFBvT1hGTjNnQytXRlVCSDJvRTdj?=
 =?iso-2022-jp?B?Tko0ODdMaUNzaTErcGZzQzhWRGc2eE9PcVUvVllGQXVuK2dTRys0RUNz?=
 =?iso-2022-jp?B?UUdDUzc5bU5SVlpXMzNzaHpJd25uSTVPa0dyS0hXVkZraXJnVE1ZUTNV?=
 =?iso-2022-jp?B?eVFWOEdlRkZCcUFWcVMxMUVhTUtNOHJtdXNsazNNT0lLV0JjNER4RUR4?=
 =?iso-2022-jp?B?elUyL3ptQjRvNDM0UDB1NDZEd3BBN0pUVTEwRFVMVUU4TlZXanNnTXpz?=
 =?iso-2022-jp?B?WGhRVWkxMjRmbEkwMUNCSFpsOHpha2x4R2xxTVE2K0d1V2xrd3ZzYzY3?=
 =?iso-2022-jp?B?WkNHNkU4dFM4MUVNT1F5OVd4VmFPb3R4Sk5WUndEdTZiUUd3VlBMK2xq?=
 =?iso-2022-jp?B?bTlQbHBlTT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7208fd34-19bf-4fb6-49b9-08de646bd9ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 04:05:50.8886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tEGoUcTU8tUSGkAIy+uOd5/0apzI+ev8oyB6C6BWiPJhAHVGb9is1PQcTpQDMHaklSYzYjV3tcZsJXm5s3QisOj3dGwZOsFs0RNtW7EHj+mAGe2ddAjS6Q2jh3uyh1VP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14985
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Feb 2026 04:06:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21828

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Tuesday, February 3, 2026 8:21 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>; Biju Das <biju.das.jz@bp.renesas.com>; Lad
> Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> john.madieu@gmail.com
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/2] ADD RZ/G3E TSU support
>=20
> Hi!
>=20
> > This series adds the TSU (thermal sensor) support for Renesas RZ/G3E
> > and addresses an unbind issue seen with the TSU device.
> >
> > Patch 1 extends the PM domain detach allowlist to include the RZ/G3E
> > SoC compatible, avoiding asynchronous aborts when the TSU is unbound.
> >
> > Patch 2 backports the upstream RZ/G3E TSU DTSI support (TSU node,
> > thermal zone, and CPU cooling maps). It also adds a "syscon" fallback
> > compatible to the system-controller node so the TSU driver can access
> > calibration data via syscon_regmap_lookup_by_phandle_args().
> >
> > This has been tested on an RZ/G3E SMARC platform.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I reviewed this series. Looks good to me too.
I applied and pushed with Pavel's reviewed-by tag.

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


