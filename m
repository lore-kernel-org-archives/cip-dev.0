Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751F6C8303F
	for <webhook@archiver.kernel.org>; Wed, 27 Aug 2025 07:33:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.9648.1756279968832684953
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Aug 2025 00:32:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=wF/xszDl;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1756279958;x=1757489558;bh=gdNFCgWCaoSFwmcdxAzHUgYraH2g/NjR73W5s
	tnncVc=;b=wF/xszDlLTfSto2kcJZE3zvBTI/Y9V4+uUJkL/6ldVsE9peHf7JF972mo/LKvfBJH+i
	96hJvo7GJCINWS3r5MgcBGlvVQScgNKVIdyst5sisYtWkCi6kFC+X5XVDaLM6L3BvSqCcaYr35B6m
	9FSnUAm6MI5Hump9fgFvAfQjvN+iyhziRhYHXLZWgBz6nWV5YzU9p0dIpAV8QoeUPqyOoWGv4XR6Q
	/dbMdFGTUqBrfVzWafAhmNMsqxpT8DOKwQygnQD4B94Rop32PmLayrdq8zX8938Zqo8pcF1BczKdP
	qRlPnFGj0JKIhQdUqb+Zy2RSLEcxIMpw9bA4VfSlX5Ag==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 57R7WcvG2934311; Wed, 27 Aug 2025 16:32:38 +0900
X-Iguazu-Qid: 2yAbpfLvKit5dyod5X
X-Iguazu-QSIG: v=2; s=0; t=1756279948; q=2yAbpfLvKit5dyod5X; m=whr28GMndZGMbg97h2qVuT2VMB2AycqSok8qXRO9HuE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cBbpM64XFz1xnZ; Wed, 27 Aug 2025 16:32:27 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WpVR5a1JMWW8p+xrX4X/1zc1Eyf8nk5D+BIG66bD6Mmnm7V5fvcLMa+rLumqLbppHyiNoSidBsLMjJ+m1e0K8OZYcd8OwbCF4T+/ficLgkuKt7n7yA1hNt+3q15C0zVNRZPQzRs8sLhR1nNT00cNTsTZI8U+8VLAy35NAMprkW6/2boP3STbGRklAg+4JA1A7juR2xY2oszp5vTPunWregVq/N0ET+gXC2veb2AeH0DqGqkNEAC79ceth1petjsPoiqsDViwKRnrgXKiWhDjOZyO8LdJK2AkEFWUDJmFAcCD9nGoK+2OyxkfuvIhhSlcgtqzY+MULiSIN71E3Y+s/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0fpuqPB/4J8WiF10wrIouQ/KSyVUXhQ8XGIsq1SsKY=;
 b=LQQiNuInykl2qXX/DSH39fj5gEdUbq59zDGMlAPKn4faknBzrs03SkcbFnirqRtMJGxVxR05hZxDgYaSmYfwYH9l6IwioIdc0bHpr2iGkM7FZSsTFxzebfiximDSFvr8lUtYatg87mtV19RHrIQZ5nLB7OHAVh9X25vOjRPsrY1wrgizCR0qHSnr6KQehlJJaJMpFvheUC8K62MpqdsCxHadfQ+yjp3r3um0pPbwEfGXvJMv+PSAhMwV42/GFJGh0suBBgQEAOqSFX/P+dhC0XMIbpy7pIwDbd49BP2MvT4CTPJJIg1rrfMZ95iSApOULJyFnBc3DExR1TIpP6+eVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <claudiu.beznea@tuxon.dev>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 5.10.y-cip] arm64: dts: renesas: rzg3s-smarc-som: Fix
 Ethernet aliases
Thread-Topic: [PATCH 5.10.y-cip] arm64: dts: renesas: rzg3s-smarc-som: Fix
 Ethernet aliases
Thread-Index: AQHcFwbVIy1d8QE0kEC3GFkzGiSV0bR2Gu5g
Date: Wed, 27 Aug 2025 07:32:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148184F30E9E61B7E25235309CD38A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250827035801.568246-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250827035801.568246-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB7179:EE_
x-ms-office365-filtering-correlation-id: cb484b03-9d5e-4cbd-22c0-08dde53bde9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?QnY5ejhiOXhCaEdyZ2pYTDV1bGdNcmptRWVjRHJ6dWFkRk9NVVJ6ZWx6?=
 =?iso-2022-jp?B?Yk4wOEs2S1VxZUFKVnh6WnRCTW14MHM0K3lXQjBKQzdmWGR5T3F2NWVP?=
 =?iso-2022-jp?B?Wm8wYTQvYldZZkNXckZ3Z25ya2pGUExZL3RqckNKejVXYnRlRXI5bGxq?=
 =?iso-2022-jp?B?MExFb2V4SC9raXhkVVByWVFsL3BrQVVmUHR3ZnVhQXg0TmVnR0dNUEo1?=
 =?iso-2022-jp?B?ZnNXU0J3VEwvZGx2S0lScmh3THFPTENvYm1Sa25ZdmxpVmg3UHR6MEcy?=
 =?iso-2022-jp?B?cUxNZEV4cHpjb1VqMmJEemVBVllWQXRSOE80bHp1K1BtekFha2lXaFV5?=
 =?iso-2022-jp?B?WW1wc3B1TkUwRnY5aENWckNyczR6N1U4VHhwcGd4U2lXUGZmNVZ2eVNy?=
 =?iso-2022-jp?B?Ulp0YmJuV0ZqRFFJTHRSak1TaXloQVNFV3UwSDN1cWVHcEtReHlNUkg3?=
 =?iso-2022-jp?B?ajlKbGNFbmZrZXVFT3FCYkxCem9BS3lmZ0FwdWVFZm1oNDBBWUwyVUFw?=
 =?iso-2022-jp?B?VlhjV2ZXeDEzTklvOHAxQTFKM0NZVTA5K1NSN2tCR0VsZjZuTjNySG1h?=
 =?iso-2022-jp?B?MGY4bC9ZU2RtU1R2V1AxN04xNDJ5eElad21xWkN6ZG1FYXBieXBEMVdE?=
 =?iso-2022-jp?B?R3crWm9yR0N2OFozTHpuM3dmSE5xSms2T085dlV6WDhqYi9UY3Z5MTFR?=
 =?iso-2022-jp?B?MU84cjdQa2VUSEwzazl1Z2tIbTVsWkdlOUdIcCt6ekpWMlFDUXhJV1lR?=
 =?iso-2022-jp?B?MmE3NWVPVW9zcmpnUWVabW5KMlYyZDFJeU1MV2g2cW5GSHlnVmJLdXlV?=
 =?iso-2022-jp?B?NVRJcEFyelAwRTdPYkZGTVV5TGljK2tLUEZTWFZwZEtHWExZZDJkakFt?=
 =?iso-2022-jp?B?RWljUWZLT3ltem9nc1VBTGhPRXVxcUhUSTlsb0krKzRjU2RJRGJJT0Qz?=
 =?iso-2022-jp?B?ZGs4cXlGZmU4TFRUWHlPdU0vVXpWMTBDNWdwYXQ5UEdPL3RWTjhiL3E4?=
 =?iso-2022-jp?B?MGNQVWlYU1FpMkxEcC9SVVNsWlhrT2FMNlEyL3l4VStjRzRnbmlHcUVV?=
 =?iso-2022-jp?B?NWpqb3lSdHpFa2svV2cyT0l2eEVwd1RRN0hZeDJzdnBjTW9rSnZ4dFY1?=
 =?iso-2022-jp?B?eVZ3eVZiOVdtL0cyZkdqK05QeVNDMTFndFVCMVo0b09MZUlNRG1IVSt0?=
 =?iso-2022-jp?B?SFZJMDl0clYrVjd4eSt0VFZTZmtSWlBxNU1hemU3RmJsdHBkNUtOOXZL?=
 =?iso-2022-jp?B?Ky9ha0NjU21JNHRwRnh3b3ZGWlc5QXhNZjB1Y2lCWDl0NVM1UjRCY0xu?=
 =?iso-2022-jp?B?am1adGdKeFgyUzFLVG8zelpDcVBrODVkYnpCNlNqRmhUQkRXdGVPRnNF?=
 =?iso-2022-jp?B?ZGphUzMvT3pjMHAwQmZqaU1aM2Nsd2drb3Jqclg1TWhxMkdLOU4zaVl2?=
 =?iso-2022-jp?B?Ylo2elU5NDZpaFcreXYyVVNkTXNsd3F5Zkt5WEx0TEEwWUtqdFM2clYy?=
 =?iso-2022-jp?B?KzBoWFdySldsZnhCUWt3S0IxZFkwWHVtM3d6SXB4eFp3WHR2MlBLWldT?=
 =?iso-2022-jp?B?WkwxNm1aMEtqQU9CKzNwUjNyeTl2Sm1IOWdRUUJ0cWtzNmRvd1FlSU9P?=
 =?iso-2022-jp?B?RXNSZ3ZOQkcvTDlzQVRpTENab3ZYTkNmWGd2aWZsOVpjZkIra2NzY1RF?=
 =?iso-2022-jp?B?MDVPSzZKWERJaGw2QzNkeHJtODE0QTkyZzJpN3IxcnBYdnhsSjk1aGh3?=
 =?iso-2022-jp?B?TVFIUzUvUWJneFdNNVRwRk0xRnFKUDhmbFhCLytybldNL1UrUGdKWTR0?=
 =?iso-2022-jp?B?Y1lCSGxZR0svcElaVTh6R2ljdFZoakRUODJnUUpkTDNzUXBDUmJQbGVx?=
 =?iso-2022-jp?B?TmZZTkpXaXBGbkNxMGR4SlF3RkZmb0tkSVdEcEM4TXVMWjdRYWp6T3Vu?=
 =?iso-2022-jp?B?RnFmNTV3Y2p5aVBsL3NHOVNqd2paS2hsOE9TRk1kdm03dnBnOC9ZUEg0?=
 =?iso-2022-jp?B?aUJUUHRWcngwNVJXUnRLcGNmZ2dMZnRkQmg2NlN3VVRORXRmZGFYbzQ3?=
 =?iso-2022-jp?B?Rk1qT1dXR3psdmI1bFc4K1dNMnduZmdWblR0SWIrR0xKb3VFSmFEc0pP?=
 =?iso-2022-jp?B?UlVhVEpRVXBBK1RPU0VvZHR1b1NheXlCMGJwKzdpNElVQ3VYODJXaURJ?=
 =?iso-2022-jp?B?OWc0PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VFpDVEVCbnBmOGl3Zkc1aHZUYkJ5NzFpUVVRcjNoa3hOUUVMRmw2enFx?=
 =?iso-2022-jp?B?eWV1NW04T0xmQ1RkemFaK0lGUHdwMDhKbGlEWXlGOTFsREJaWHJDLzBO?=
 =?iso-2022-jp?B?TStqVTQ4UjRNVWdWeHc5YmVSVGlZQ2ZlVjJqcE1YM1grRXM1azY2anp1?=
 =?iso-2022-jp?B?ZUVTcFlmOE9LV3dRTG9TY0FBaHhVVmFsNjJjL0ZoWmVmNGxzb3JwZHh4?=
 =?iso-2022-jp?B?NENaWlJQS0E2elBpVkJCUUliaWt6YzIvN1hOQyszd3FwREdVNTAxdnBs?=
 =?iso-2022-jp?B?SUtzS0dRZlY2T1g4RjJzaG1DbkFoSHB2SW5uYVExWENsWnd1a29UaUZn?=
 =?iso-2022-jp?B?UDdjWEZma2M3WEJlWWdHS2lSQXNQSjBTWHdHcUJYV1U2alVvS244QXh5?=
 =?iso-2022-jp?B?WTBONFVWWmRyd21QaVJseHQ4cys4WE9HZkZrckhrbnRmMEl5aDJEY2pN?=
 =?iso-2022-jp?B?YWRJQTdJTW9KVCtScUJDR1NhK244REtNZ2w1WFVhU2QyNktWYXVVaFNh?=
 =?iso-2022-jp?B?cng5VTJyQjVEaWl0ZnlPUjFQUG9zWGZzak5FNjRiM1pUWXZmSzZSczE3?=
 =?iso-2022-jp?B?UUN1aURiME5SenpyUm9FckkxMEtIc0dtbUVHa3oyS2xSbWF3WXl0NXU4?=
 =?iso-2022-jp?B?ZS9oUHBzU1laRHU2U2pjUmpUQTU4V2lXSFovN0oxWHNoejFJSTREaDQr?=
 =?iso-2022-jp?B?cG8xK0NHekRLeFJ2d05XZTgyU1daVDRIQUFZNkxXcEhWdG0rNGlqb0JC?=
 =?iso-2022-jp?B?WXBnSWN3NEoydDF0NCtTdis3VlV4TlBCN01ZTmdVOUtZQzl5U0JmU3NL?=
 =?iso-2022-jp?B?clArbDlOaWVhWDlBd2pQelRqMHdZM0tTNFp5MFE2VGJWckRQVkVMYno2?=
 =?iso-2022-jp?B?WGswZVlsRU0vRGRmK0pSbUtmYVpUN2d0K000Mm96eEdNNDhDaG0xejkw?=
 =?iso-2022-jp?B?ekkyZ3JCNitvMnpMdUdzbS9Ma21HRkk3RmphVkQxeHVIQ2RUY254eUpv?=
 =?iso-2022-jp?B?eFJMb2dPV1pEenFZcllSOUEzbmIrR3U3NFRZeTJTdnJFdDFXa0R4em91?=
 =?iso-2022-jp?B?ajQxaHZFTEZobW5pbzZKS0dNUHMxZERnVWY1YmlRZUFwOHE2QW1LSDhl?=
 =?iso-2022-jp?B?UHV3eHM3Mm5xVlZTTXlIYmd3L09FbEJLc1lNWi9SamFRMkxlc0NlVUFT?=
 =?iso-2022-jp?B?NndPZ3VXYWlYQTFoYXNPREVpQnVaRDM0L3NPY1ZxalBicE83NUpwMnFn?=
 =?iso-2022-jp?B?UTU3VGtIQytXUWRvSDAvVStPQ0VIRmQrSVdOWlFCaEhvcGpsUEtuelRw?=
 =?iso-2022-jp?B?N3NKWFIyL2E3aE1nTms2VWNQcVhVSTE5NjFONnh5d0RCM1hGNDJLUFZW?=
 =?iso-2022-jp?B?NGdid0JYaXlrcC9OU3FYYTc0cTNLNDlHdHR1R0FDZnF1Z2t0K3dJWC9n?=
 =?iso-2022-jp?B?NjlZYjR6amhSTDBNZ21qOEZJcFhRUjh1d2NnOHlya0NhdjNGcGl1ZTc1?=
 =?iso-2022-jp?B?N2dZaHdMS3lBQ0hnSlN3Q3pNZ1lmUTVVVUtOSWkvQ3ZsVG9PQkVRZnZk?=
 =?iso-2022-jp?B?TDhSTlpTY1YxZ01TV09WUm15UWIwSHJBTlFxaFlhNVNTNDA1dVlMalVJ?=
 =?iso-2022-jp?B?TGV5dVNFeHozYTRrYkdZdW16bW9xczJ1bFVSTU0wZzdhdUNXNndnNlFp?=
 =?iso-2022-jp?B?WTdUR1RXNjd3b1dYTjVINmMzTzRzR2VRUXcrLzEwemxwVHlMbTBWV0Y1?=
 =?iso-2022-jp?B?NkVvall2eCtTbFRWMmRJeWdzTHJWZUZvSWxJV2RwdGx4b1JicmZnOFRm?=
 =?iso-2022-jp?B?NDBzellLRzR2S2xyKzNtak13QzJEcHZUVU5rODhpdkp6OTB3cWlHd0l3?=
 =?iso-2022-jp?B?T2NlcWRmZFdmc3NGZktYcTZoenA2ejZ0T1c1WHZkZ2dZekIwb0pPRkVG?=
 =?iso-2022-jp?B?b2E1ZUs2c243bFJzVnpFTUFEVzAyajk3cXVMY2lJTVBaeDRqU251eG5S?=
 =?iso-2022-jp?B?UHpSZ3RXd3VuRjZqSkN0Ym16ZkJHMEVvZ1QzUlVGL0Z5YTZZZmRSb3Fs?=
 =?iso-2022-jp?B?Y2dUNlNHVWtjTytzeDBOaTUxWHFnNU03ZEpEODFHY2RvZ0RUaGl4Umti?=
 =?iso-2022-jp?B?MDNqVXQ1OW9ycFp2aGlLZ0RKMklwRGhhUnV4RG9sZUJ0bU9RZFZmYnJS?=
 =?iso-2022-jp?B?TVN1YnhZRUl2NE5McjRWZkN6NEg0ZEdaeHNYeFNtU1hkZEhlK2g4dFJz?=
 =?iso-2022-jp?B?ZVI5ZEFSZlE1R25qZDBqME56d2QvQ2w1TWM3Nkt2RlYvWllORlpUR3Ja?=
 =?iso-2022-jp?B?elB4ZUlUTjlmdjVYNWtDbmU5RzBkdkZleUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb484b03-9d5e-4cbd-22c0-08dde53bde9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 07:32:25.6794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWJCaDcoFUu0b/ANlPwkV4YvSbZPKupMgf4Z0uyjvadyRuQUOfG9jJVyy6R0diqvnqBYNGFX2jbXbyV+PUrWE1XxHZfqfFLp+RbVY+yStVZMipf7pO0IAbVp6eYHNpVd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7179
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Aug 2025 07:33:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19972

Hello,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Wednesday, August 27, 2025 12:58 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@denx.de
> Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org
> Subject: [PATCH 5.10.y-cip] arm64: dts: renesas: rzg3s-smarc-som: Fix
> Ethernet aliases
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit be4e4dd8a1994e5730dfdb8dfaf1f2418f8a199d upstream.
>=20
> Fix typos in the Ethernet aliases.  U-Boot uses the ethernetX (X=3D{0, 1,=
 ..., N})
> aliases to update the DTB with the MAC addresses.  The ethernetX or ethX
> aliases are not used by the Linux RAVB driver.
>=20
> Fixes: 932ff0c802c6 ("arm64: dts: renesas: rzg3s-smarc-som: Enable the
> Ethernet interfaces")
> Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link:
> https://lore.kernel.org/r/20240328065738.3049316-1-claudiu.beznea.uj@bp.r
> enesas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> index 3f050a28f2a7..3d707c9c6e46 100644
> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> @@ -20,8 +20,8 @@ aliases {
>  #if SW_CONFIG3 =3D=3D SW_OFF
>  		mmc2 =3D &sdhi2;
>  #else
> -		eth0 =3D &eth0;
> -		eth1 =3D &eth1;
> +		ethernet0 =3D &eth0;
> +		ethernet1 =3D &eth1;
>  #endif
>  	};
>=20

Looks good to me.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


