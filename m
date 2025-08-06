Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CEFC87FCA
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 04:44:49 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.17954.1754455484990122145
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Aug 2025 21:44:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=XXHOQVFO;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1754455482;x=1755665082;bh=Mi7xZb6TGFuGqUoJFVAyiqWGuySf+FwABS0Yhlo
	Q1vo=;b=XXHOQVFOEyHcEHeH+cXn/fIY5uOOwvmUkTQDiWbRlEqqXjbpR9UoUw0IaVE9jhwhvIqQU
	omCkxA8z40qkSnzFHEbs09TML6mT9fEkilfcX02dghyj3Gd80PzOt/bR7WoZjybe5zJtwDCd21m01
	00x6LeFraK57oBBJ1MvueIx5k60EWg1xzAjr2aK9PFRDFdJbzhyiXn5rDLqiluB5a2YxjTT+FRqK5
	/Ry3Q8Wbl6PWz3GIW6WsYXRp12Ujtyv0Fhdr92/xjjFRTkzmXbbpLLYkTNSDSTHkuVBD+4gjLqJ9f
	KIznuPMpPLtM0dP/wHu1PG7CW22ZgrATf7k8JVTfiA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5764ifxH3446907; Wed, 6 Aug 2025 13:44:42 +0900
X-Iguazu-Qid: 2yAbG2MEJZh6vwpjE0
X-Iguazu-QSIG: v=2; s=0; t=1754455481; q=2yAbG2MEJZh6vwpjE0; m=bdqlz3GACZLB8YymAQeU0WzmYLfwvOjYA7QPJjuQnYk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 5764id2m2125205
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 6 Aug 2025 13:44:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dh6Y3e6b2gylXVCBIE74ehWO4JF/pWLYo45CqnUcl0twyJhbSej1DXh2rGjx9WT1v7dyXBf0woO+TKBcEah8y3YoSE16P7p/ALYGKNAQ8+742YbrXqVJTQv2XiTsdreZISDjzRZdDubhSpyf0p8LFKefiZeKypa9lKmqvV3VCJHAUiluzwGfVJ8EMWiFPBXr9CAIerihDo1Z31xlA622mPtKZvuOFNsNK/Kj2qXkK5XCZ4Kf1AC58r4UgBGMjPMdZEOomrKdta2d+sUiokF7v2tVAX6EaPsZZBEerKs2iIbMspeTVQ7Z9WM3CsaHhalGXCzq+RxkCPyefovn49NMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mi7xZb6TGFuGqUoJFVAyiqWGuySf+FwABS0YhloQ1vo=;
 b=craqzZMBTfz+zJ5DyqXyxxpFKvaIKe7pTQniRR8R/NnHV9Guqst4FA91AhBjPU6D6DbV/kTPzKm53PMiYupNNh0zz3B6gqUY6Rp+w6osmDN/qEkWdDm6Mgpj+VPFVTS9xfZNrKbq9pHAdctDeEXYM5AxJnrAsWITRJ+s4vjwmFUkTMBCNBoUVmfM3aiw7WlHEY4VM86MDKksbw2XzMB3IEOXp6P5ZneBEClmZN/CEtRIHetm+7Jb9wNpeLk+EoOfkbagX+5n+uoyWgR/BU2AQJ0JdalmcUGDC3TFyB5bdC5h/dtXzfqy89MmN5fYCZFI6SJOIBG4EMSe/4/monVXFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH v3 1/2] kas/opt: Add option for not install kernel
Thread-Topic: [PATCH v3 1/2] kas/opt: Add option for not install kernel
Thread-Index: AQHb/T/YuCuInYULLEKMTJ5Ox+nbzbRT1emAgAFI61A=
Date: Wed, 6 Aug 2025 04:44:37 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818214AE6ECFFC8F50D6E0B922DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1753432849-18257-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <049a4714-982f-41fb-b4bb-4e65017148e3@siemens.com>
In-Reply-To: <049a4714-982f-41fb-b4bb-4e65017148e3@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB10323:EE_
x-ms-office365-filtering-correlation-id: c7bff0c7-d55b-4b4c-3861-08ddd4a3f2a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?aGtqb1NMb00zNEFXWi9iY09tVEJCRkNzNDQxY3l3bko2aW1US0U4TmVNQUVR?=
 =?utf-8?B?b1dRK1lCL3J3dzRlWTdmNk1peWYwWGU3am8yVHZHUmFYMmNrenVYdDJ3SjRw?=
 =?utf-8?B?RndrMjZXM3Y0Z0swakR4clo0ajQ2Rjl5V2k0V0ZNTG9xejJzYXA2bHlxZFp1?=
 =?utf-8?B?YVJQdEJuU3dXc2ExTW0zSm55OWNLcUhhQ3JIemdXdXBTUWMxeGtGb2xQVzJC?=
 =?utf-8?B?Um9wRkFvQWE1WXh6cVhkVDA2cFdXdUp2djlObFJVR2lqZlUxcGg1V09tRnRJ?=
 =?utf-8?B?S24xVE5uUGhIWnh4KzlxYTZVQVQ2Y0l5MnFZdnY0ZEY0cERHNWtGMllSL3cw?=
 =?utf-8?B?aFlIREw5VUJ0TElJaUp4ZHhpczFTZndCUXRGSGhPZlNldGVXSzVtRGlLQmh2?=
 =?utf-8?B?QVg3NlFIQzQ0em51UzNLQklvSHVXZmJHVEowKzZuZEZka1cwOUFYSmFsWkNz?=
 =?utf-8?B?d0RXaG03cG9JeGJqdms0RzViRUE4QUE2YVBzeVBYWUtpSUFNRWZvL0Zpakda?=
 =?utf-8?B?MXd2TS8yWlFDRm94aUF1cUJTbFB5clZVdDB1RC95K254UnkrKzJPQUlsNjdv?=
 =?utf-8?B?UWpFYnRpQ2lnTVc1ZDZUaFpNc0l1azNBY2IwaCs4OWpQSFdCeHBJVWxYY0FY?=
 =?utf-8?B?M21PVU8rN2h4WlVMdmUzdWxLZm9uUlpDc2g5ZDExUTUvSVByb0pqM1pGS3Mw?=
 =?utf-8?B?UXVSSm02LzFCWndtYnNtcktFdkVnYXpFdTJvdGtRZUcvOFR4Rm5vUTdQc2JH?=
 =?utf-8?B?OTBSTVROUkVsc0RvWGVrTjV1ZnZnK21pamNPekRvVUNtSXNWS0cweW1odlBv?=
 =?utf-8?B?bGlSMGtmS0xlZzZENkZEN1Jyc1Z5dkE2Zm93bzRrMGdyeSsrTndGTnBoSzhK?=
 =?utf-8?B?Z1FsNnpQMGI3VzREcXZVdmdwZ1U5Uk8rRFcwV1Q4VFpueG9XT2xEbkpBVUds?=
 =?utf-8?B?clJyZG9IZWJvM3dwMFJrK3JhS3ZZUFQ3V204czRPazYvMGxVV0dGd1k2RFpG?=
 =?utf-8?B?SWw0YmgycGxpRStjOWV2Y1owYXY0a2gvU1h1ZG9ZbDFUa3RDMHFUMnJ3STV2?=
 =?utf-8?B?eXYvbDZteVhUYk1VYkIwZlZWOU5DWHdYVzBZaDBkaFE1akl3Vmlla0hCZnVn?=
 =?utf-8?B?S094dFpvcXlKVi8rMmxtVUlOZk1QaDZWaUtBMFVseUxaMmE3c2IveCtnYXk3?=
 =?utf-8?B?UitDZ2xrdjlhS0RIeGM3R1AwbFNyMWtkcXIzT2pHMHZLWnBET0JvZEtsVjg1?=
 =?utf-8?B?dnp0S2RRb1V2THhIdkVvMDZ5RmFlZDFOMVJ0QVovK1ZjTDJUakIrZDFqU3RL?=
 =?utf-8?B?K0NmZSt5NWFhdWg2K21FK3BNQXBLSkppRnlub0hoQmNvTlhFeGF1QmpjRktS?=
 =?utf-8?B?T1cwemEyMVJNanVudm00NXNPWTl3SjJRcXdIL1lxamJzSUZLdUZJaDRDclVa?=
 =?utf-8?B?YVlhMlVBdXhKbHJRc1lVQTYxZlhVaDZLTHhhN0llUU42MGl0dmtaa0VoRmMr?=
 =?utf-8?B?aHhORWZpMEtTTVJhbjZ0ZndBWVdvSmZOeUppWmJYV2d1YkVFeHBZaVBnSnR0?=
 =?utf-8?B?dUtod2dWL09tLzcrWnNCbU9OeGQ2QUQrc2p2bUtBT3laMnlwS29OKzBjaW01?=
 =?utf-8?B?d3RaeEtHazBNYVN6cXdnMkdBeG1TMkEvN3BYcGxwcGJTTG9NOHlyRWp5UzY3?=
 =?utf-8?B?eTNxSW9GaC9UZWFZbytqcWFROHk5MVNpOWZHNkVEVElDdCtQYzdlUkUycVYy?=
 =?utf-8?B?RUc0MG4xbmZCK1VPK1RRNGtuOUdHYmcvNm0zdkpHM0NMWTVuSWw4bkxkV21N?=
 =?utf-8?B?Unh3Z2RDT0Q1WGlrWnVsTUtIZmJabjdsKzZLQ1YvSCt1NlJYUSt0S2tIRTF0?=
 =?utf-8?B?d3B1aGNsWmVZd3JCNXFQWktyQzFSdTZ1MWZuaUZ5cjhyWjFHelJrRFI2eEVK?=
 =?utf-8?B?VTdZVEZ2U2ZBK0VkRkZqb3FnQjRkOEl6U1pZd1VYa3RrWktiQ2xjTFkyUC9R?=
 =?utf-8?Q?Lf+WFyXqPaFTTpJY0p8yaiBS0HqFNY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T0hNeE92dHNYZU1TWUUrQVJ6RGxnQ3Y3L3paNEtjaHNuRmovaitIKzBscnpa?=
 =?utf-8?B?Q1FtbThtZkJpblJqY2dQS2NtT0FKSEZ6S0M3ZFE0V3ZiK2pXdlhLb2wzTkdQ?=
 =?utf-8?B?c1Zlc2RmdFJGRDV3alAzdXZxQy8ycGN1SEhSRzNUZ2pOYXp4RDh4VjdaS2sz?=
 =?utf-8?B?Qk15RHl3TGRCeGEwYlR2WTM2VnhMZ2FjNUVGZ2hoYm9OMEo2NmdHSmpyQzBl?=
 =?utf-8?B?YjFXWVVKVVBXc21ZZmRaQlR3Z2ZkNXFKanJTaFhYSTJlODdqS25aaU15aVNH?=
 =?utf-8?B?ay8vZFdtT0NYeFkvbEN6M0VJcnZLYUdzZ2doa2hyMDZIcG9TM1grZ1VmUGU5?=
 =?utf-8?B?djFMUTRlS1R3N2duQXZjTFRFQ0hsbjdLanRkZ0h2RURXMkczSzR1VzZTYm1H?=
 =?utf-8?B?WTd1SUR1bzUxQlpNSGdLL0dGSVdBVTFjZEdlZno3dUFzU2dscm5MMHNxaFAx?=
 =?utf-8?B?RXJSVXp2S3RPT1RuR3M3TWovSzdLSWxCU0g4UmljUW5Sby96aEZiMUNLS3Vv?=
 =?utf-8?B?VitqVUVxQm9pY05KandBOHFHdjRaUC80emxMc2h6cmRhSnVFRFk0Y3NuaFVC?=
 =?utf-8?B?Z1NMcWxibWtrZ0Rpc0l1MTFUUzBSNTFXOG5oYWVHbHlkK0o4K3FSSlNNR1BN?=
 =?utf-8?B?dE5ZNklPRzFXdUU0VVJRYXMyYW02S09sbUpUU1JuMTlOZy9tengwbGRPNlBp?=
 =?utf-8?B?MzVYVmZ2Unc4MTJqVmxiY2RWUmQzN3BuaXhHS3Z4U1pJaVhiUFZhcGIzMHJv?=
 =?utf-8?B?N2VhcUdjWGYwcTlQMWgzTU5pRWNYaVY2clBISm9qVll3Q2ZMbHZhOU1HbFJ4?=
 =?utf-8?B?cmxTbkEwTndqbnBvN2lGVGxVc1RtUmpUaHJNVUorTG1xU3liNVZSb24yejBp?=
 =?utf-8?B?cjdhZXpTc3ZtS04xdE9QQW9ZbFdEWnAvUjFmOW0vUWdZY2JYSXZMVWR6RzVK?=
 =?utf-8?B?azlBbmNVVFh1SklRczZFVWtmL29LbG9Tb2xNTUNiNGxqNHhXd00vVzJjNlZk?=
 =?utf-8?B?eUVwN3VJS3NrTzdPdC94MDBpOTgxYTJzWUhidHkwLzdlbUpGWkphTlQ3NjZp?=
 =?utf-8?B?V2RORGkvU0JObisyeGJZYTVMWXgzRnpvaTZWY1B0NjkrZjlzemlGZ3pWaWx1?=
 =?utf-8?B?ZmJUMjBMYXV4T0J4NVlxME1yZ1J1bHVtdU1YSG5JbkFFZlJNbHVOS0RoVi9Y?=
 =?utf-8?B?ZW5zMlVnN1RlOGFYcktnVGZYUWczMGhoQ0VmWDEvMTRWcUtzSG4xWGs1T1Ru?=
 =?utf-8?B?TlpkUXFST3MvWmdtWm9aVW03YldEVzJWNkFDbjRuM05CRVJZTUdraGJ5VnBa?=
 =?utf-8?B?K1BZK01OY1k1MG1iOEcrOVk4cTVEQXJlMUI3ZzYvb3hKNmowWGNTSjdRL3l5?=
 =?utf-8?B?Um43ZWk3R210YXdMMkJTRjF0bFVUYzJNa0VhcUtZVi9uM0ZsWDE1OUtCSDJD?=
 =?utf-8?B?ZUErd2RqQXNnQy9VVWRPUXNTUk5KNkhSZWVQQi9CNCtGdWVLNC9ZRXNlbnZB?=
 =?utf-8?B?YXpvdldLdXZaNDF3bjg2ektLTktYb2lnZCtkNHFqNkdPYkxDQnlIZWxRczFP?=
 =?utf-8?B?bXBveGtMWlV4Q2RRWDRyV2VJeFVtOWhpNWorTm9reFZNR3JWR3NURVpSYUJY?=
 =?utf-8?B?c1J4cDcrdS9sS3RzZGtNZ0hVREpoN0tleVpTakpVUHNZdmlWeDJTTjVYNVJH?=
 =?utf-8?B?enpacng5M1pHYjNvZXprcEFDenFSSXlRR3RnQlhHbGVPUXhBOVAwNGpiazhR?=
 =?utf-8?B?YzVQNHJ1WGhCeUhvZ2UzZUhScFBDOENURm9mS25xTVYwRzhBUWNrUWFrd2pO?=
 =?utf-8?B?TTkwV1Y3SnlaQy9FM0F2MHZVQkd5bk5uckIxeGlkN3BDYkQ3QVVUNGx5WkZF?=
 =?utf-8?B?bytnc2NGcmxMOGREbkkwelFvREQrRldVbksvY2x3aEozMUtxN2ZJTHd0K25a?=
 =?utf-8?B?YkxESXJQRXBGdnlOcFJ1ZDRGdXc2R3N3TWtFM2VTL09WSWI3cEZSaTNsMnkz?=
 =?utf-8?B?OXZKQ0VVdE5MS0gyT3YyWS9hVGtHMDlwc1N3MURzV3ZmUHJ0bFg4aE5pdVha?=
 =?utf-8?B?SjB3czhoZzRYQTA1Y1k0cThwWHZKVWowUkRQTkRWOFVxOFNDRzFiQU5zblBX?=
 =?utf-8?B?MHhnZXovQlVMUTdyKzIzUUpMbmprSjRYejRrdmx3RzdZb2JQcGJCVFpQY292?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bff0c7-d55b-4b4c-3861-08ddd4a3f2a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 04:44:37.2015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zN0fstst3yot0RFEOYLr0n0LMZHuj296HWSelOXYwL5o6hIbj1H6ArQhRo77ygUR35dB3jGjrkFKIYG3lY0CTtpZhZMc2CuiXQ4XgAqOJ1vWCPpL8ax7PkVpbyG1wq8b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10323
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 04:44:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19677

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6
a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA1LCAy
MDI1IDY6MDYgUE0NCj4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yk
77yp77y077yj4peL77yj77yw77y0KQ0KPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28u
anA+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYzIDEvMl0ga2FzL29wdDogQWRkIG9wdGlvbiBmb3Igbm90IGluc3RhbGwga2VybmVsDQo+IA0K
PiBPbiAyNS4wNy4yNSAxMDo0MCwgTm9idWhpcm8gSXdhbWF0c3Ugd3JvdGU6DQo+ID4gVGhpcyBh
ZGRzIGFuIG9wdGlvbiB0byBjcmVhdGUgYW4gaW1hZ2UgdGhhdCBkb2VzIG5vdCBjb250YWluIHRo
ZSBrZXJuZWwuDQo+ID4gVGhpcyBpcyBtYWlubHkgaW50ZW5kZWQgdG8gcHJvdmlkZSBpbWFnZXMg
Zm9yIGtlcm5lbCB0ZXN0aW5nLg0KPiA+IFdoZW4gdGVzdGluZyB0aGUga2VybmVsLCBrZXJuZWwg
aW1hZ2UgZmlsZXMgdGhhdCBhcmUgbm90IHVzZWQgZm9yDQo+ID4gdGVzdGluZyBhcmUgbm90IG5l
Y2Vzc2FyeSBpbiByb290ZnMuIFByb3ZpZGluZyBpbWFnZXMgd2l0aCB0aGVzZSBmaWxlcw0KPiA+
IHJlbW92ZWQgYWxsb3dzIHlvdSB0byByZWR1Y2UgdGhlIHNpemUgb2YgdGhlIHJvb3RmcyBpbWFn
ZS4NCj4gPg0KDQo8c25pcD4NCg0KPiA+ICsJaWYgWyAiJE5PX0tFUk5FTCIgPSAiZmFsc2UiIF07
IHRoZW4NCj4gDQo+IC4uLmJ1dCBoZXJlIHdlIHRlc3QgZm9yICJmYWxzZSIuIFBsZWFzZSBvbmx5
IGNoZWNrIGZvciAiZW5hYmxlZCIgYW5kIGNvbnNpZGVyDQo+IGFueXRoaW5nIGRpZmZlcmVudCBh
cyAiZGlzYWJsZSIuDQo+IA0KDQpPSywgSSB3aWxsIGZpeCBpdC4NCg0KPiBKYW4NCg0KQmVzdCBy
ZWdhcmRzLA0KICBOb2J1aGlybw0K


