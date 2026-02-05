Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46822EA7965
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 04:06:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13491.1770264388945969768
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Feb 2026 20:06:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=jFTHkXan;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1770264385;x=1771473985;bh=4KDrel4WvuspqHch6ie0tPGQ5BTjt6O8CSJM5
	fm0508=;b=jFTHkXanWgpRjyg/Mp8R/gZ+9EH29snAyFyA3/H/EFmplLINtzMweZ5wyA1qG5QQrDo
	92z6C4vXn18Ppkn9IdZPc2for9suHFHb5ucBPYlMH3iTRzVUZJ6yUTssw9YJIMKLImDw5fIhu7A5C
	R2mtSIKof77G2jOnY9B7tyxjpzk5jtCi1awkUMiQMp4sPy/RaN2JUXkpeXOM9hC5HFJFW2LAhk2gn
	Xkayzs5UVFGmKNsFP41DmME1qKGtO9GaVfYYjGWbXJEG1y22i4IAPLYFnYOFJMWiVyPaG5DQlNoJJ
	rli6mli4V6vSpsJW5DbgEuVKwYoYzhFfzIZJvlG96nfQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 61546PFb385103; Thu, 5 Feb 2026 13:06:25 +0900
X-Iguazu-Qid: 2yAbS7rJlda2c2uDVg
X-Iguazu-QSIG: v=2; s=0; t=1770264385; q=2yAbS7rJlda2c2uDVg; m=Gza4KIDVgnwFmUplq6fBGyV72v9arzk5w+j59aOLF3k=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4f63Yr5vkCz1xnc; Thu,  5 Feb 2026 13:06:24 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USfvXWCgwBTChRreuFwgXi5cd5euyq5s1wVEu0JmTYktAsMN4xYSNRgkp7EZVYLBQzpOLehzAI3WI/akSUd1wiwovSdsTTffcZzQ9duf4uFv7430OXZjzhkmpq6Itieuf2fYi4qCq1H2W7eF9HPaq5uJsxWwsoK9uKZ3ujeeNMZGRaYTpT7KUzubDgSNPLA6Nf/dJh/9zTX5U/h2H/bT0zozIASqgrWgvvEhvdz+CxEIyVAIY84zNfR2EeIle81vWXIpsvcRKxs1N7eVsVpN07QJhnxh5uz7/pwF5+5tfMPoaqj+4zB0sQViftE45CpxTLS8tOD1dYq7emnbs7c1bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3Uk/P5pqAVQFFwXNjiMge+rzx+b7hDBH+jH9Wvn2HU=;
 b=sPT5NWBUoVDylsHvPyyFgYqQqiigMliERli5wUwfN7wL9ZoA3u/G4l5uPJh2S9uAB4/ZA0fd0tAzVFVALSgY/HdjshSU3xZj8R0rsODvcNr7OBhLFR5P9f8nUy/NFDSGe2RmUQEVMR4+Hhv7LYpkXFCqK80kqk+7+FjC5Ht/W1R2ugNSzwtr0mh8nytF98OrwrrSF2T04O0QjqDGMOziyofgGgaGJroYXuTgLYH8aC/0JjxIWmxQgKb1uS4c3hs0DtSGl5xDpP9FnZvNPlDw+ZUgejx38U3GiG8ZEJMWBQ4tPV+q14D6IYKFUiiH5A/BVgxsanecVxtFQGPvs6WaJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <john.madieu.xa@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <john.madieu@gmail.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/2] ADD RZ/G3E TSU support
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/2] ADD RZ/G3E TSU support
Thread-Index: AQHclO07wnuNoBIiiUmehWUaQOQJRbVw1SgAgAKqcoA=
Date: Thu, 5 Feb 2026 04:06:22 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818457B7C1536159A9E0154CD99A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260203091201.98565-1-john.madieu.xa@bp.renesas.com>
 <aYHaqqXncpyY45B5@duo.ucw.cz>
In-Reply-To: <aYHaqqXncpyY45B5@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB14985:EE_
x-ms-office365-filtering-correlation-id: f696ef06-9175-48d0-14bf-08de646bec70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|14052099004;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?QjRIUVFhZXRGNlJyRWUxK2pYQW1MNnJoQU0zRXNYb292bGVpS3ZlNGU1?=
 =?iso-2022-jp?B?RTM5a2lBMHdVNk5kTlVsR3p0ZUtFNi90RkxkMnhkeDZoQVAxQTc2dXlR?=
 =?iso-2022-jp?B?V2xqakJkVDJrU3VpRHg4QUM4UlhZaGU2d2JhdkFSVWJJMGhvUTVzbndP?=
 =?iso-2022-jp?B?R25kMkNGUXdsRVdaZFlKOW5tN0RTdTl4K2c2S2YxZzIvUTZ1Rk50RHlv?=
 =?iso-2022-jp?B?UGlCb0d0RTZUYTNYNzhzai9nd0MrbnE5VE5DNDhmSjRmNHlaN20yR3Zm?=
 =?iso-2022-jp?B?WlJIVW1hV0JUd3pjNzYzY1dNelVzall2Vml1Mzh1MEtDL1pKRFhMbklY?=
 =?iso-2022-jp?B?c29kVUZVNWhHNXJuWW9RYnFHZUwyRTAyTGdZNDc3ZUtwL1AwTmdRc05k?=
 =?iso-2022-jp?B?OE1wcTVubzhRbU13dy9GQXVVUWxwMkRMVUxFM25WTXY5WWdNcm1lTTZH?=
 =?iso-2022-jp?B?aUVmejhMWDEyUy9lV2VLK25IcW95N2FPYmdKUmhRUER3eWtHZGJtL255?=
 =?iso-2022-jp?B?MUFoWC9meEJJV1dBdzltRTJ5SkhxMkRJZDJ0bTZSbUxYOHdsU28rWFpv?=
 =?iso-2022-jp?B?QUlWK3lRMFU3QkZ1aDZWSThlTHJlTDBWRGRHKzJ2SmprS1V1RjFscWR2?=
 =?iso-2022-jp?B?bFYvcTNqZm1QU2JxcE5QcExpeFJVQ0FMampYaEtiR0VXeWhCN2d4Qkp5?=
 =?iso-2022-jp?B?eGJXOXk2R0x2R1REL0xMRloxMXYxVXpyencxZ3dVclhVQzBXZFZVR1BU?=
 =?iso-2022-jp?B?aURFenVyWnMyRlJwZDlycTQ4SXBqc2NvSjlMdGordklNblJMYVBMbkJz?=
 =?iso-2022-jp?B?b2JUeGp6aHZpT3FZUk9ndkEyK3k2MmZadkxQREYvOEpDOHFoWGdwRVZI?=
 =?iso-2022-jp?B?cytyTC94Zk02Ni8rcFljaDZuT2ZDYnhwZ1pIVlNvSk0wSmNEbXdlYVMw?=
 =?iso-2022-jp?B?NzFjMmpDRnRlY1Q0S1BXdDJoMVBlSUpzcWVieXprRHNDdm1xMGx1TytN?=
 =?iso-2022-jp?B?c3NEZjg5aGtLOVkvMnNFNUplM0YvcHJnTU8rdkk0c1VGUEFyZW1MUlly?=
 =?iso-2022-jp?B?VHdHK1lQT2F4WWtwU1pTbEVSb1Q0N2thU2FzUURYaC9TN1FzMnd2OHlw?=
 =?iso-2022-jp?B?aEV1Mm00aGhmNytqMVVTanl1SDhvMnlNTUdkMDN4aG04Z29sVkRjV2lK?=
 =?iso-2022-jp?B?OHgwUERGLzdmazZSRGh2QmM0allVNk9wckF2OWtwVUVGM2ZBNGhRQnZL?=
 =?iso-2022-jp?B?blZBTVdUK3N5ajR3aDl2UzJFK1JCYUFoa0NnYnd1eDh0Q0czZXhwS0U2?=
 =?iso-2022-jp?B?VVZibmhwdTVVZkFjNWJmM2RPRUhYV20vbkUzUUFKRkRhMFBtaU5aQ21y?=
 =?iso-2022-jp?B?Z2tYamJXUmtVbHROZXRiR3lHWmsvVXJMVWVrR01DUHl0SHhCRkJkNjFl?=
 =?iso-2022-jp?B?R2FFaUlZT1BNWUNQRForOFFmQ3JtdjdPNzBXRnR4ZGR6Zi9DZzc1cmRS?=
 =?iso-2022-jp?B?THVLOXpVSnh3NlpFU1oyeWFOeG9RbENlendWdENqOVFRNmxLTEVheW9U?=
 =?iso-2022-jp?B?czZLUnN3Z2ZtM2VSdE5LTDdHZ0RKQUlyY1FSV09Gb1pRVlZiakxjOG1Q?=
 =?iso-2022-jp?B?NWRPOVJ1Wk5XTWxoSzNJMXFBYWNieGZqT2M2R29UdXA0eWpJck9jdk9M?=
 =?iso-2022-jp?B?WDhLMDROS3BTSy9IUDBuUlVvZkpadm9ocnpKMS9nQ1NiYWtpaGg1cFdH?=
 =?iso-2022-jp?B?WDNnT3VURzdENlpPQjlJVUpzZmJqVHpkNnp3Rzc3dmN4UStZUENTeHky?=
 =?iso-2022-jp?B?YTYwbDRLamR6T1JuZ1MwbTQ2UGxoNUV3MkZXTEUzSW5aNTAyMjMydTJq?=
 =?iso-2022-jp?B?MjRaUjdyRXNKUGlKNVBycnRiaWkvNm9WTWUyY0JVMkxLNTJ2VUxwQlQ1?=
 =?iso-2022-jp?B?ejRVTEZUQ2NJMlE3dTlDVkZOKzVvMVpHUjBFb3RLOS83T0tLZmRadHNy?=
 =?iso-2022-jp?B?MlcyVWkwQWFOVDhEY1FSNHJMVmxTMkhBYjZNS2RiSzRndTFrN0VDY2Rv?=
 =?iso-2022-jp?B?L1FNbVh4ejNLUC90SWxNUTlSSFNpNWxacHQvWFZmY3RqY21od2pUWllG?=
 =?iso-2022-jp?B?ZnhFdUh4eFA5OG4xK2RaWjBHT01vWkJMT1ZlMlAyRWp0czB2UVFRU1lp?=
 =?iso-2022-jp?B?MXp6d0hoN2FUN29WNDNXOWkyY0RpYzh4ZFJhUDlZZ0E4WXRad0x1QXZz?=
 =?iso-2022-jp?B?MzdobStEcUZ6RzFMTEpYcHJMRFZvNUUzbHVIeGV3a04ra2ZmemlQMVdZ?=
 =?iso-2022-jp?B?cktSYlVpZGNGREY5MUgrWEgzeHdpTlBTQjdQR0pzMEFDMXhwNG9GUDgr?=
 =?iso-2022-jp?B?QmVtdjA9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(14052099004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?clczY1dxZTJ2emxoeG5KK2VxQ3JiTEloSXYxZ0xwNkh0ek9RWldtRWRQ?=
 =?iso-2022-jp?B?c1EvTHZWRDBocXVaRXM2bmtlak1SMzl1ZnY4cjZFVTA3WkhzcitOTFNF?=
 =?iso-2022-jp?B?bDBNd0NsQmZLZWo2cXBRdTFYR1ZLeXNlaHV0blJZRkROWHExbVIwc3NC?=
 =?iso-2022-jp?B?U1B1WGpnUHMwQytVREEzTFQrNExqU3lhbXp5ZlcvQk9rcU1tM2xoeXE4?=
 =?iso-2022-jp?B?SjFBaTNlZTY5cnZ3RHFacTk2MXdsUFIwT0o4Z3Q4M0ZzQjdJaVJ0Ry9I?=
 =?iso-2022-jp?B?NWNQbU9yY2tUWk9DWUdFSGRHaDBPRHh1U0FibkJvcmYyWThpUmFZM2dk?=
 =?iso-2022-jp?B?alJjdHR1elhueXhwUVdHc05DVW9lOXBqd0dreU1qbzRsY05MVklvL2Nw?=
 =?iso-2022-jp?B?czdwTXNHV3g1VEZodkxiM2J5TTZNSWU2cHczK0E0d0FLQTgxQXZZZFlQ?=
 =?iso-2022-jp?B?bFZIMzZFdlpJNTh0aWtVcXJUbTdkV0d0RTFJSU5YR0ZBZFBvT2hVQUR4?=
 =?iso-2022-jp?B?SGIxcHhyU3h4UGxodUZid0hUU1MvWldkQm1TZEFUTm5lQWEyTithVWVB?=
 =?iso-2022-jp?B?MVJMM2w3TXVaalNKcjNIMUthSFNpVnltaVgzeE9WdWg0SkVmMHZjbEh6?=
 =?iso-2022-jp?B?UWRjdFI2OTVzWUpjMVJreGFJVGdBV1pwNzdXWERhYlEwai9jZW5GUUh4?=
 =?iso-2022-jp?B?N1FoV005L1hSaVV3MFIzTFlpV0t4Z0g2SGdTTzEvUVlpb0dUamlPZkYw?=
 =?iso-2022-jp?B?QWtTZUFBUHhSUXgzeWcyWHp1MGZOMnZzSE1BcENldE4vT0lxSHVOMDh4?=
 =?iso-2022-jp?B?OUprbnBGZUpoU3BRMTE5SEcwNUVzcjBVbTlQckwrZXl4ZEFLRGxGNVVx?=
 =?iso-2022-jp?B?WWl0dTdIVk1OOGZZclVwczFOREFsTXdKUXhQckFReTROWUt5Y25QVENn?=
 =?iso-2022-jp?B?eEZCQnAxSER2bkdTSHJzSVdmYW41MzhEZGFhSVlPdytOOGZzN0lRejBt?=
 =?iso-2022-jp?B?RkZNbG4wN1prQkRoR1dnUTZyWk10TXBVbU40d25SbVVOejJZbENqVXVi?=
 =?iso-2022-jp?B?MmY2cVRYUXpRMHpCT3F6R2FFQ2hpbDcrbHZ5UmQ2am9ROWc5ZmtvTThk?=
 =?iso-2022-jp?B?cVRVTnJWdzhraVY1OGNFSnB6V3Nueit5SWlRNWxSaTVNNEswTE9GTHlr?=
 =?iso-2022-jp?B?c0xFTzhQcUltT0R5ZUJEK1FJcnFIWFgxWjFVb3BpR2Zwb0xtcWtYYzN5?=
 =?iso-2022-jp?B?YjZyUStnbDlZbXNJdFdQUnRUZWRMaUVJRm1RaWJzYTRCU0pEK1M2Q3JY?=
 =?iso-2022-jp?B?S0RXaCs0OGhPdmxGZlh0V0xubVQzMlUzcXB5RFV4Wm1WNXNFcERQTDEw?=
 =?iso-2022-jp?B?QjNkTkEydmgzdEJmYnBJN0VqeXdvWHRqaXJXa01lbm5YYzc1T3ZWV1R0?=
 =?iso-2022-jp?B?VkZocG1PZ0tid25kOHVsUlZVQTZpTnZzWjl6cUM1SmtYNmZmUFJBckUz?=
 =?iso-2022-jp?B?d1FoemMrTVhHTEo3WHdZTnNFaFNNNnY1YkFzTStuR1VTM29BQ05ZZEtR?=
 =?iso-2022-jp?B?ejV4b2pZenI5bDlIK2VRTmJYWFp3cDdKQnB4Q3k1ZHE2T1UvQ1RodDRM?=
 =?iso-2022-jp?B?bFBCOUFsNVNsSTA1WmNlSnp2MzgvRytsTmFLYUE4eG5rbFJBckJiNzhD?=
 =?iso-2022-jp?B?blBIZHp1YlREenBxK2ZvMlYzeFY4TDd3QjMxZ2xva0ZiT3JmV3dWUTBF?=
 =?iso-2022-jp?B?dFMrb2V1eVFtM0RLbml0aHZrQjVMZXVFQ2JQQnhKRnFyVXJFZTBLQUxx?=
 =?iso-2022-jp?B?dlpRMU5xcU9QZ3NNQ3BZRlhYbDBQTGZuUkY3eFk0QndKWm9xd1E1eEFk?=
 =?iso-2022-jp?B?azJaSVJ0K09MVjJFWC8vMy9uL0hFOWVEL0pGcEU3RDdIK1hCdVBsRDRk?=
 =?iso-2022-jp?B?SkJrSzUxZnY1OEZtcG1TTDg5blladTlNTHBEOVlWdDV2eHROUTVkQndJ?=
 =?iso-2022-jp?B?QjMrYVZtbW4xZmdJbDFLUWtaVzQ2NTFqdEJBdkpFdjJsZUZQK2Fxa2hr?=
 =?iso-2022-jp?B?NGVUTEFwd1Azc0luV21IM2FPZVFhcEdlRlBRREthYkljVjJFOHEzYVV5?=
 =?iso-2022-jp?B?WkZMSFE4VnY4ZXFOdUIrLzZWa3NrZ0RJMnN5T09aZ3RNNm5UTzJuQnUr?=
 =?iso-2022-jp?B?M3Urc1lISVFtQitxS3RUTmJROVExMmxJck1QMVlZYTEyNEhQbVJuaW5Y?=
 =?iso-2022-jp?B?Sk9qUVRsSVNYaHFvYVBlVG4vNkRoL3JWcnpXdmQ5SUlOZzNLcTJiL3d0?=
 =?iso-2022-jp?B?RDlwM2trejBNazVnY2laTjF3ZmU0MGdNMkdBZmpGSVo2Q0VDNkc3emov?=
 =?iso-2022-jp?B?Q0RId2psMUk2QktjY0tqTXlxQnFmcXk0QlZ5VXNLaVhUTFkzbG1xb01U?=
 =?iso-2022-jp?B?dmxVZUVpZFJXQXhlQWlnbEgrbzloTGVJZzduVW1DdTk5TlBQNlIxNGg5?=
 =?iso-2022-jp?B?Vm5QenBRQWM5dERZN2dXRGwvMnNhVzN0NjR6d3JQSFR1K2lId2xad1c2?=
 =?iso-2022-jp?B?T3dJS0VUdz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f696ef06-9175-48d0-14bf-08de646bec70
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 04:06:22.3616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axICMot5J8dlCeL0jSdQp7MxZ2a+nCzSWbFOeu4lAXLkP4jKisDtUtNOmDMwDedkHl8AHeYgTudVED+nhJhbkjbiv12XCfNcJrcoEKd/S11f8pSQVb143j/abpPt9eAr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14985
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Feb 2026 04:06:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21829

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Tuesday, February 3, 2026 8:23 PM
> To: john.madieu.xa@bp.renesas.com
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>; Biju Das <biju.das.jz@bp.renesas.com>; Lad
> Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> john.madieu@gmail.com
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/2] ADD RZ/G3E TSU support
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
> Same as 6.12, this looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20

I reviewed this series. Looks good to me too.
I applied and pushed with Pavel's reviewed-by tag.

> I can apply the series if it passes testing and there are no other commen=
ts.
>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


