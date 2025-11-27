Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB1CCFD2F6
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 09:19:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14883.1764235182832199610
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Nov 2025 01:19:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=ozhB/4fl;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1764235179;x=1765444779;bh=816vXOIPXRKmSFdR9IoVLV1aTVC6TMQUTbCy+
	Va0Xo8=;b=ozhB/4flsoyEOaesC6VWXmqJO5JTICf2QJtt27weLdJINfHRPLJq1BOrsVqBQy8lv1/
	UiX2jjYrPokbsfGoEhgSscKyUyR3g/8I0YVYA5cIzQ5mlVXX987xQLXF7PduS1wYWXBLtMtWEb5y8
	jy3o87xjP8gFNM58yKzy5ACxreXbop4+Hek8xWY07OBYHzc0y4ZpZz+GNYUyscni7rQmKmJoORluT
	k6mA4TwpHJfhf/v6lo7LJvdH0mnkruhNdm7b8CrJArsY7aC3BDe5arSoC2VA4eDI4ou5nawcg2AAE
	bcrLkcysWBMKH0v+rkbRZPZxha1+7B5L23UIyWrX2wAg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 5AR9Jdb73345066; Thu, 27 Nov 2025 18:19:39 +0900
X-Iguazu-Qid: 2rWglrLTIGEJURDYTk
X-Iguazu-QSIG: v=2; s=0; t=1764235179; q=2rWglrLTIGEJURDYTk; m=ODn5SKiSdK8uq9EEMWhFAP5h+8m17kCumAu1Xhgq5Mo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dH9qZ6KSfz4vym; Thu, 27 Nov 2025 18:19:38 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blFq3volLWHoReZZKiFW10GbQU9S6HeBrBr4pVv3f8MPhKFUWoM47PllhTVmAXbdUpKpoGCBQtc33/IcVt3FSWnrGIPPfT44lKXAyTM7ZyItoqN1qgdGYfy+rE7ssj/1sOQihk6Rru4aX4foEB7Mu4lI+r0arYErF1t1f8WoYUtj668xStTrQkt9vBZUFnEP1BmUQG67ibzNeD7KMLzNmZVwSGiDY1hh/gU1ZHZ/S6gV3NY2DoS3Fw2mdflkMYl1vimZsZgQ/Mfhe/Lu/xvnwIxlgbClKbimTuM52gL28uZ6HbFJqnZd6OxkqsJI7NYzKEgo8SHQIDGF6KC46l+Tbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=816vXOIPXRKmSFdR9IoVLV1aTVC6TMQUTbCy+Va0Xo8=;
 b=wK3axR3AutKXKQfjZijFdfbjUhP7FQj0UiHLRzA1BDssz33imUL8zozoOIvCDWFXYixF1oxjhAPrL3IQ2mhxDE7ElBM6HrSknKFCHaos0NxTK8m4bbCNqogVHw22V7sEYeDxOQZsbJA5PRujrz550JsTM7wLWfHZXdV9SHvHouGLwOJ4EkM1zFOZr6I3IqA14BUHTgAQUm37JXrBKvgP9e7Ibre1aQeIrvOk8OcR+SNQ6IX+5iPGJhMbYWz9f9vfK7FwfAIB2jdR4zQFJBQEtacVOXeMbGrSG6hdTH51xMAlM6Va36xwz2IakriNa/cJBgr4y61NTi6MUAXEyTZAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHcX3BW54I/zUhmLESKpUS85awhx7UGPlwg
Date: Thu, 27 Nov 2025 09:19:31 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818A2EEA5AE34C3322C07A3CDDFA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <3530c12f-3b5c-4b4a-8e5e-e8ed3c871a55@siemens.com>
In-Reply-To: <3530c12f-3b5c-4b4a-8e5e-e8ed3c871a55@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB9677:EE_
x-ms-office365-filtering-correlation-id: b4feed9b-cd64-4052-481e-08de2d961304
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TVoyaTN0cGFycFIwNS9LNjBsZFNzMDg2SnlXV3FCYS9sM3ZsVmxKM0ExREo1?=
 =?utf-8?B?Q1RRWWE4c0ttaE1ad25jU3JXSkxuSS81YlJEVlFVU3U4Qld2Z0dxcDhobVhE?=
 =?utf-8?B?Z2JHV2QwZU5rTmo1NVI1b1JHNGlkK3hkUUNzUHV5M1piYVBiclpjUHFabXN0?=
 =?utf-8?B?S0o2dGt0cUlSQUg5bjZwR20vYUN0enYwZjFsM2xnMmI5aG9QenVnZG9ZLysz?=
 =?utf-8?B?ekFrNHV0RlhyaTgyWnQrU0VWYW9SSEEvaXRJV2VtNUk4S2xtSElZQkU1L1BO?=
 =?utf-8?B?a0J2S2grVURVSzN0ZHQ4ZWJHaHVuN2VzNGozTmZidC9QSU9xcnlyTmwrUis1?=
 =?utf-8?B?NWNmUVMrWUsvSGQ2V1VPM1V1NG5WRW5qVktkcTkyRElIa2QxKzZPaG5QS0cw?=
 =?utf-8?B?eEVKOC9TVGdGeldSTHRtNlB3R1Jkcjh5TVJGdzJ3ZkY3bFRVRlQzV1hVMXRh?=
 =?utf-8?B?dXowMGVsNXVjZ0tUdXhFL3FkaFZ3ZzZycmdYTlkrclB3NW9TcW5qaXNOSkZa?=
 =?utf-8?B?eDNJYXVPdWRHUHdjNUJ6Ym5ZaVp3VEduZzh6dkxwYjF1ME1mbHkzcGljVGIv?=
 =?utf-8?B?UVJxSDJPZ21lVUZHNEhuR3NZOVdQSThvRjNLTkNLWlUyL1VCaEtLcDMxV0t4?=
 =?utf-8?B?Q2F4c2ZFTjFUMVM2cUhHZWtBT0hLb2krb3FnUW45b0owOTBaR2REMjdhc0RZ?=
 =?utf-8?B?a2JvOUR2RVRsVHZaUzY3cDI3NkhaVjF3SkN3WHJJWUE5c05WYmJyYTFPR01W?=
 =?utf-8?B?VGJKNmNsSWJnMjVaQVQ2akRWTzMvdGtkcm8vcXpFRmpPQk4yZkQrNkZ1T01j?=
 =?utf-8?B?eGwxaHNHMFhoM0h3bzFQWVpKdDdlR3NvbVQ2a0Z2WW5nNm1aWkQyd25nNG9p?=
 =?utf-8?B?ekROMEJaaUNyd1FYKyswU3hVSnE5NlVpSU8wUTNCNGo5THNYbUEzenlqVXgx?=
 =?utf-8?B?TzBXMHNqcExoSnpRcG9lK0JXN3pPY2dmZFhxNGVhNmJnaC9uY0krSXpTM0hw?=
 =?utf-8?B?TWRSVm9jbFRNSExUOE1hNk9aekVYT3J6Vksra1l0TWlZdFBUNTdGa1VUQldG?=
 =?utf-8?B?V3FYTmlWYnI0YTVSZWxmbGVhTm5iMG5wckdycFVhSXpRdUxvK1RQK3ZvUVlC?=
 =?utf-8?B?dmpWMUZibGE3eEhRTGYwdlNiNUZ1c3pDc3NNTncvR2ExV0dZZkY3TC9laGdR?=
 =?utf-8?B?VUVDa3lNdHZsd295ODNCbHJJTG1tbk93VGlmOERHU3EvalA4ZlVRbjhBVGE4?=
 =?utf-8?B?T28vVFhYMmZTYmE5UGtiK3BrNUFVbUthak1heHdjNnMwYWs1TklrcmhIQ2I4?=
 =?utf-8?B?OUtYbFZkaUhsS2RHYlZQc3lwdkhWdTJvMlIwV0p5aUU3RUpEbzBBTVpuYVJn?=
 =?utf-8?B?WEErMFFhNERDNENuMHZRazFybDVUeGpXYkpTR0dBK1RrWUNhWE5aRXVhUFpF?=
 =?utf-8?B?QUtyS2FZUmJ3c0w2dHgyQVo4VFVJQmJ1Um5iYUVNWkZvT2dGVlJ2MCsrVlMx?=
 =?utf-8?B?bDAvWnRMWElJRVBsU0YrUG5QQlFvNjlzNk9ScFN6RHgzUUNkWFdieGRmbzZz?=
 =?utf-8?B?SlZnRUh2TmcyQy9OQmhEdWNtajdtTHMyNEltRUlXczcrb3pDcG9kUkNoMlJV?=
 =?utf-8?B?TXh1QjdDWmVDUUtGVjY5OW9FMnN1elcxbENJOW5KYW5tUHhEMW1QanMwQUdO?=
 =?utf-8?B?aUh3YmhEdnVYUlp0Qy9PclVXKzJ2QjdyQWpoZjJPc3g5aWFJYWlmbjhjL0sw?=
 =?utf-8?B?VDBKUHdsVzgwV0RyQWl3THdoenkyRmdjTTQ1Z1dtbE1xeVNJemF5U1FhZ0Uv?=
 =?utf-8?B?VGZXaDRpVzZ3eE9vdlRiZGxqMGxaQmovZUpjLzRqSERJLzMwUVhKUms0NU9Q?=
 =?utf-8?B?Q0RVVGhQWXlQTXk5d1FDeTd4SW1uQzd0UVRKbDRWa2xGRFl5bGgzKzlHUjZ1?=
 =?utf-8?B?ckt0c3RveUxVTk9qN0tEMGZaZnB4UjZzRGZMWXdPSmJBU0RlYlZ1M3V5UE9G?=
 =?utf-8?B?RGVjWGNNMWhnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cGNVdEdDY1pzYVJ2dzI1WFhPSTdkbWZ4NXhsM2o5NjR0K3V0amJ1UVJYNENh?=
 =?utf-8?B?bFlQN2NUYk1ZdDI2QnVtOTVLSW01Z2dCS0xlMXFwMmZIWHAydHBGVlRtN0hX?=
 =?utf-8?B?VC95eitnTSswSWxOT013aEhOY3RJUE5hbkdlRVowS1lMWlhXMUlzZGZacUlY?=
 =?utf-8?B?UXcvYUxhRUh0TGE1UGFpM3AvSDJRU1ZMWVFsMTh1UG5NcTVQenZuS3NVN0ZS?=
 =?utf-8?B?S3pad2JQaEFhVUFpL2NoYitRWGhwblZuTVRLVGNUTzNSeEtJRFhIU1RVSzN6?=
 =?utf-8?B?MmliVkRCMnRKWkJXeVQ1Y1hxTFFHcDcyVmNoQkpvckR2OXpwMzR2V1VLK2RS?=
 =?utf-8?B?cWVOeXFydi9MeDR5cmZENG9LNXJYNTBiUUlIOE00OS9xeDV3bFFRejhQWFhw?=
 =?utf-8?B?M2lFV0xPRE1QZnc4Z3ArRjlxMksvcS9GZEZyRHB5WUN2QWM1aDROL0c0c0xD?=
 =?utf-8?B?NVFwREZtenpXbWxsWnpiNXE2cGhDOWZ1c1Z2bUt2RHpZeEdKeW9SRmV3VzRY?=
 =?utf-8?B?NnVpWXYwcGNQT2M3bDlBNUZwTUU2cFA3dFE3VHVHNFRucTg1SFBGMTVONFdE?=
 =?utf-8?B?WGVQSnRYNm8rL3p2L3c4TW4vMjVoUDRPWU5COGkvbDVqWWU0MEdjZy8rVnRJ?=
 =?utf-8?B?TzZwNjhiRmxvS1ErbEIyTGlzNmJxNERXa2V5MzgwWnF6WUVnMmZ2SjY3TEpX?=
 =?utf-8?B?dVVCekwxdjhKMzlBdkkzR0c1eStCMmZqdG1qUEZueW1pWFJuTVI1OWRtQWsw?=
 =?utf-8?B?aTlrK0VaQnM0elFSdW9qbHV2MVI4ZlhyMlBqR0g1SzB5cms5cEhCcDZCMmh1?=
 =?utf-8?B?NGg4akVEWXkrKzc0M0ZoZFhieXN3ekZXKzFqNnZtRzE1RG9GMHBuQkNVSnp4?=
 =?utf-8?B?UDh1VGY1OFlVMkdIb0RWbVVSYlJYUFkvcTNhQjNlQVE3eUM2ZnN0VXh1VGZC?=
 =?utf-8?B?RjM1SXhhUGw0UUYyZ25ZVTQxRDV5ZEZjNlFZc0MvYjRLaXhtRkJwWWxUOWdW?=
 =?utf-8?B?U1RSQ05KeFBKRG5WbzdrbDFPWDhNdVNKNGU2YjNzcU5oelhyN3UrSVdxaHlZ?=
 =?utf-8?B?N0lHV250SzA2U1c2R3Y4K0dLd282RDB4a3d6ZmdlY2lJdDcreUdtdXZvRGx1?=
 =?utf-8?B?dlNseUlEUGtYVEk5ZkhTYnMrRU9jYkR1N0x6Q1hRRm9hTEJycjlxZUFuMTZN?=
 =?utf-8?B?Y2NiMXFmbDJQYzRuZXQrWTBRdTE5K21icUxNMzRBcVN4dmtrQzVlYkxrUXF5?=
 =?utf-8?B?emp6akFaWm9YTnlrYzlkbm9zZnVBNjdYSzVjd01hRnphV3FJMkNXZ095MEZG?=
 =?utf-8?B?YU40eU50WkxBRXZSRkdGTjkvYUQxTWFjQ3hIRGJGam5CS053TWM1VnN5clIr?=
 =?utf-8?B?ajFtNDF0TklCRDh0Q0c5WUYxM3ZlNzhBSFhBbDQwd2dpdktGS250clR6VjVR?=
 =?utf-8?B?eTVLbmdqYS9EVFdMOXlycUp5RjczczY3d0k5VVFiVHcyQUUvR3c4L2ZUNXUw?=
 =?utf-8?B?TDdjOXRkOTR0ek8rdHJrUitDSXFmSWx5eEMwVlVDUnhJeWFiK1RYZThSVW93?=
 =?utf-8?B?Vlh4VzZsaDdRNTFtdkk5MnY5RmVxc2t0dWtxSERXcTZhVXhMeXNySWNGRlVo?=
 =?utf-8?B?aXdOWkJBZ1pvdXdxdFhOWGJJaFcyWmJVd2V3WmVOM1ZXVW1CcUUrSDhvVXV3?=
 =?utf-8?B?MWJxRWxpRU9iNWVURTY0Qmw2UThTaFhjTVNqV3Q3SlFWSUR6aG94bFhQb0VJ?=
 =?utf-8?B?VUlPNjVZSnJqUWl3U2Y2aytySGZ1b1Z2QWRESVFKNHJqSzdTLzQvN2RCUGtD?=
 =?utf-8?B?RkJMWHZGRTNSajhpRFF1c3dLSjVaTFVXV21IOHYvRWV5YmtZZG5JVDBMOEh1?=
 =?utf-8?B?b2tyZTNIaFFqdG1FamRIMmlCczNDZ05ydlVESHVURUM0TWMvODY1em94K2Vm?=
 =?utf-8?B?dTZjWUsvQ2xKMEFMU0VrZkpneDhnVVk0cHBtS3BUdU1vVjFLQzRGRlJySVgz?=
 =?utf-8?B?Q1lwTm9CK0JwclFiWGh4dk5lV1VmajdzVEpocVdOTWJSTXZNdHhBdzdnSCt0?=
 =?utf-8?B?QVZWci9iV0J2dWJnVkJLeHdKYmpyYU12Y2lhUEEvTkcyWFdTdis1V0tLNEVF?=
 =?utf-8?B?aVhBRkFUQVhubTFESU5GeWpVZWFPL2FOcmZnL1NVSzRRdy9BdG52SEFSTmVV?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4feed9b-cd64-4052-481e-08de2d961304
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2025 09:19:31.9149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ecXKAigfvsIxrySI39N30cbwssNkeq6+DLoMqihwHG8Og+8WIA1Pv5/ORz3/pJIAAfi1BlewQL1qluHbYQeP9WU8jMglxZ6QhR+wz6oPSshUVPCFlKPkv+YribCUbAje
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9677
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Nov 2025 09:19:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20740

SGkgSmFuLA0KDQpJIGNhbiBub3QgcGFydGljaXBhdGUgaW4gSVJDIG1lZXRpbmcgdG9kYXkuDQoN
Cj4gKiBLZXJuZWwgbWFpbnRlbmFuY2UgdXBkYXRlcw0KDQpJIGFtIHJldmlld2luZyB2Ni4xMi41
OC4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxp
c3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24NCj4gQmVoYWxmIE9mIEphbiBLaXN6a2EgdmlhIGxpc3Rz
LmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMjcsIDIwMjUgNDoz
NSBQTQ0KPiBUbzogY2lwLWRldiA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+DQo+IFN1
YmplY3Q6IFtjaXAtZGV2XSBDSVAgSVJDIHdlZWtseSBtZWV0aW5nIHRvZGF5IG9uIGxpYmVyYS5j
aGF0DQo+IA0KPiBIaSBhbGwsDQo+IA0KPiBLaW5kbHkgYmUgcmVtaW5kZWQgdG8gYXR0ZW5kIHRo
ZSB3ZWVrbHkgbWVldGluZyB0aHJvdWdoIElSQyB0byBkaXNjdXNzDQo+IHRlY2huaWNhbCB0b3Bp
Y3Mgd2l0aCBDSVAga2VybmVsIHRvZGF5LiBPdXIgY2hhbm5lbCBpcyB0aGUgZm9sbG93aW5nOg0K
PiANCj4gICAgIGlyYzppcmMubGliZXJhLmNoYXQ6NjY2Ny9jaXANCj4gDQo+IFRoZSBJUkMgbWVl
dGluZyBpcyBzY2hlZHVsZWQgdG8gVVRDIChHTVQpIDEyOjAwOg0KPiANCj4gaHR0cHM6Ly93d3cu
dGltZWFuZGRhdGUuY29tL3dvcmxkY2xvY2svbWVldGluZ2RldGFpbHMuaHRtbD95ZWFyPTIwMjUm
DQo+IG1vbnRoPTExJmRheT0yNyZob3VyPTEyJm1pbj0wJnNlYz0wJnAxPTIyNCZwMj0xNzkmcDM9
MTM2JnA0DQo+ID0zNyZwNT0yNDEmcDY9MjQ4DQo+IA0KPiBVU1dlc3QgICAgVVNFYXN0ICAgIFVL
ICAgICAgICBERSAgICAgICAgVFcgICAgICAgIEpQDQo+IDA0OjAwICAgICAwNzowMCAgICAgMTI6
MDAgICAgIDEzOjAwICAgICAyMDowMCAgICAgMjE6MDANCj4gDQo+IExhc3QgbWVldGluZyBtaW51
dGVzOg0KPiBodHRwczovL2lyY2JvdC53bC5saW51eGZvdW5kYXRpb24ub3JnL21lZXRpbmdzL2Np
cC8yMDI1LzExL2NpcC4yMDI1LTExLTIwLQ0KPiAxMi4wMS5sb2cuaHRtbA0KPiANCj4gKiBBY3Rp
b24gaXRlbXMNCj4gKiBLZXJuZWwgbWFpbnRlbmFuY2UgdXBkYXRlcw0KPiAqIEtlcm5lbCByZWxl
YXNlIHN0YXR1cyBbKl0NCj4gKiBLZXJuZWwgdGVzdGluZw0KPiAqIEFPQg0KPiANCj4gSmFuDQo+
IA0KPiBbKl0NCj4gRGF0ZSB0aGUgZGF0YSBpcyBjcmVhdGVkOiBUaHUgTm92IDI3IDA3OjMzOjU4
IEFNIFVUQyAyMDI1DQo+IGxpbnV4LTQuNC55LWNpcDogaW50ZXJ2YWwgMzAgZGF5DQo+ICAgbGF0
ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBXZWQgT2N0IDI5IDAyOjAwOjQ0IFBNIFVUQyAyMDI1
DQo+ICAgbGltaXQgZGF0ZTogRnJpIE5vdiAyOCAwMjowMDo0NCBQTSBVVEMgMjAyNQ0KPiAgIFN0
YXR1czogT24gdHJhY2sNCj4gbGludXgtNC40LnktY2lwLXJ0OiBpbnRlcnZhbCA2MCBkYXkNCj4g
ICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IFdlZCBOb3YgIDUgMTA6MDc6MDAgQU0gVVRD
IDIwMjUNCj4gICBsaW1pdCBkYXRlOiBTdW4gSmFuICA0IDEwOjA3OjAwIEFNIFVUQyAyMDI2DQo+
ICAgU3RhdHVzOiBPbiB0cmFjaw0KPiBsaW51eC00LjE5LnktY2lwOiBpbnRlcnZhbCAzMCBkYXkN
Cj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IFRodSBOb3YgMjAgMTA6MjA6MDggQU0g
VVRDIDIwMjUNCj4gICBsaW1pdCBkYXRlOiBTYXQgRGVjIDIwIDEwOjIwOjA4IEFNIFVUQyAyMDI1
DQo+ICAgU3RhdHVzOiBPbiB0cmFjaw0KPiBsaW51eC00LjE5LnktY2lwLXJ0OiBpbnRlcnZhbCA2
MCBkYXkNCj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IFR1ZSBTZXAgMjMgMTA6NTM6
MDcgQU0gVVRDIDIwMjUNCj4gICBsaW1pdCBkYXRlOiBTYXQgTm92IDIyIDEwOjUzOjA3IEFNIFVU
QyAyMDI1DQo+ICAgU3RhdHVzOiAqTGF0ZSoNCj4gbGludXgtNS4xMC55LWNpcDogaW50ZXJ2YWwg
MzAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBUaHUgTm92ICA2IDA5OjAw
OjI1IFBNIFVUQyAyMDI1DQo+ICAgbGltaXQgZGF0ZTogU2F0IERlYyAgNiAwOTowMDoyNSBQTSBV
VEMgMjAyNQ0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNS4xMC55LWNpcC1ydDogaW50
ZXJ2YWwgNjAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBGcmkgTm92ICA3
IDA5OjQ1OjU3IEFNIFVUQyAyMDI1DQo+ICAgbGltaXQgZGF0ZTogVHVlIEphbiAgNiAwOTo0NTo1
NyBBTSBVVEMgMjAyNg0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNi4xLnktY2lwOiBp
bnRlcnZhbCAzMCBkYXkNCj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IFdlZCBOb3Yg
IDUgMTI6MzI6NDUgUE0gVVRDIDIwMjUNCj4gICBsaW1pdCBkYXRlOiBGcmkgRGVjICA1IDEyOjMy
OjQ1IFBNIFVUQyAyMDI1DQo+ICAgU3RhdHVzOiBPbiB0cmFjaw0KPiBsaW51eC02LjEueS1jaXAt
cnQ6IGludGVydmFsIDYwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogV2Vk
IE5vdiAgNSAwNjo1MDoxMyBQTSBVVEMgMjAyNQ0KPiAgIGxpbWl0IGRhdGU6IFN1biBKYW4gIDQg
MDY6NTA6MTMgUE0gVVRDIDIwMjYNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTYuMTIu
eS1jaXA6IGludGVydmFsIDE1IGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTog
RnJpIE5vdiAxNCAwODoyNjozOSBBTSBVVEMgMjAyNQ0KPiAgIGxpbWl0IGRhdGU6IFNhdCBOb3Yg
MjkgMDg6MjY6MzkgQU0gVVRDIDIwMjUNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo=


