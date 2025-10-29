Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDF6CCF9EE
	for <webhook@archiver.kernel.org>; Wed, 29 Oct 2025 09:15:46 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.2746.1761729337029081657
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Oct 2025 02:15:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=GXzujQph;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1761729327;x=1762938927;bh=h3o0fp//q7rLMfSdGxM3Arkf5aLE7H8N+o+6e
	j4e8dk=;b=GXzujQphtWAiNn/X+xTdMP7hm42QFFY8ArKtCqh3aSpiqTHcmDpTaynxRk3ZxImmGgp
	0jygDyEAOmfSkgPfdvnWKwEikw8x62s65nzekbOHk16jnZwoQg7omiFgkboDASGXlMiZPtgRqHrIF
	1SVBSjXYxBsP5JLAxY8flnjsAE5x0C80sT+9/fM3ZiF7qp9V1/wMY63U1dL+PnvpKCdS/WSCbOVZy
	XKGHRgHBJK9miS5FY6/3VpmmOArmLCn895qC9rF+MnCKksh0gSAdgl5FMsAzvD7FSB0rBuetu6Col
	+zFwQelhhJgwFS0h2fYJDIOoD/EVfnksPwBNy3stkzjw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 59T9FQ8O1604537; Wed, 29 Oct 2025 18:15:26 +0900
X-Iguazu-Qid: 2yAbL6ern2G5kRNRsA
X-Iguazu-QSIG: v=2; s=0; t=1761729326; q=2yAbL6ern2G5kRNRsA; m=GQuXSLm8Myyil0okTgLWmTejFGNSFIb8czCJGi5cUlc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cxM661S8vzyPQ; Wed, 29 Oct 2025 18:15:26 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Az66iiq1NdgyJGpZ/PDvm32N/8V1NTqiJkw3pV4E3B0Fabd9x1zvPqEyMQlNSxw692QIhF7WX7cPhdXGBEM+7N4TRMRyiVlU25yRLFkF7jPIWfNgspymih61Hq3OE3Vn/GnD16nUK+h9KyIfFW9LjffieCLeorzWuydVwKintWDo2rWTVU0z3q2gZlP/XuHLoRPzj0DtF9si9LeUTvMpPc+qX2hMn5uKDT7MjJdnSauri4xcn1HW9xFUoq1sRY2W/m3r/8+vQpR+60FYPSFrxIDZ4y/Vt6ql2x1nLQK7FjfWjAwfeTIVuB5GKEYnxaE9lDUCYHufmVWUsuqXrUvytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3o0fp//q7rLMfSdGxM3Arkf5aLE7H8N+o+6ej4e8dk=;
 b=mxCIbwbKfOX6kIfn6+n2vlhmnVCXCFiK6ibgHQxs3DTDErwp8r4drG34zquS54vJtU7ZKKL5h0hZiIr+pBjHqHJHBkwLlMZcK+dP9+NdQUqHk3ZLQIE4a7OTw6ZKnp6360eAsZR0vC1C3gxK4eRub+qVxTEbdoAUPzwx3BxfSgVqHJQFKQF5X76myckXeaqfPEDmW3xWe7S20cki82JMy4HXsirpON3R0OIApgBb8A853MhIARpsd0fvHFRcLregccNbtwHtPpZou5OSKhKtV8YoUxbhH0KIrwmpMYSbrD9wzE9U7qxR1OmlYMjWu9d3ylfyuf8S2nbBp+VHrUyNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: RE: Request for review for 4.4-st69, 4.4-cip104
Thread-Topic: Request for review for 4.4-st69, 4.4-cip104
Thread-Index: AQHcR/FwW+z4oQR4S0q94J7eZMJ32rTYvcFQ
Date: Wed, 29 Oct 2025 09:15:23 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818DB1B8949574A3367636DCDFAA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1483065062.11009.1761645498941@webmail.strato.de>
In-Reply-To: <1483065062.11009.1761645498941@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB8147:EE_
x-ms-office365-filtering-correlation-id: 6e4e9b0a-594d-41f2-05ad-08de16cbb0da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TVpkRUVEaU8wWlNTNUdrMXl2KzR0b0NZVE5uTkU0UmhNeFpXV20xZDZ5UTZk?=
 =?utf-8?B?NmpnYnRjb1ErWEEvUGx4dFN2ZVI1WDU0ZHoxeWltb1Bsbno5TTJHOTRMVVI0?=
 =?utf-8?B?V3RWY0NHelpRdnJnVkVsZzlGcEhFTEhnbldTcyt1aTJMWUQ1eWJ1L2RoOGJD?=
 =?utf-8?B?ckpRVXB5aGhJVmhiRU13R0NDWE1rYjJWcWRqMjdOcXNOMjgrQ25WYzVwOVhu?=
 =?utf-8?B?eERLSlJxK0o3UGVtSE01d3EzeFV6aWxpQTlKM0pTZUtWN3Z3N3QwOUgxSzZB?=
 =?utf-8?B?YWlwVnU5Qy9xMFlWY0Q2cFlHK0hyWXoxMmtsRGkreERaa1RsNElKQjdnUDVZ?=
 =?utf-8?B?cTVReGJoN1NIQ1ArWVNuS2svNlQ0Qm9jd0MrN0oyTjNseS9YWTBRQWNVMHZi?=
 =?utf-8?B?N3NESUp6eERpRVZpaldhZlc0MGs0c0IvU243MlYwRjhkUnowYTltTXdERlVS?=
 =?utf-8?B?UGJVbFQ3dDRmemJuWFdzVjdBQkZLcDdNRjdwRmZtRXViVWQ2WWZZOFBidldz?=
 =?utf-8?B?RUVWUUlCZVNWTEZ6Tk4yblpTazE3Q0h5ZXpTU0dzTHdBd0xBa0FzRzJCaS9i?=
 =?utf-8?B?TzJkSEg4d2FnczdGZVJ6VGw1SlNVZnNuMnkvK3AzRmM0c0ZGMEVDN2NGMVlO?=
 =?utf-8?B?WDA2MVkrbDM1Z0ZOVGJ2dGJTdFNDTkI0OVU5SWhxWk5Ha2txNmYvVHBGeDhS?=
 =?utf-8?B?Y3c1b0N2VUczUW5mekMzLzJQa2NkV0Y1ZU1IdkV5Z1JialROczZuU2cvY2E4?=
 =?utf-8?B?SmoySGNuYUlSbS9pVWYvNDgzMzAvdG5ZK3pCT1pEYTVibEZtS2tQem9KSHdP?=
 =?utf-8?B?VkJKYzdIa0dpUmRFaCsyRk5tMFE5K1JacFVpZ3dkN2JZSTlacGtzZXcvSFZK?=
 =?utf-8?B?Z2NielhCT1NsUW8rcHZQenhJSUo0ZzRiOGRDUmRlUnpWOVplN3VMVkxuVzVV?=
 =?utf-8?B?YW12aGNrdnBIRndUR1g4c3hKTms4ZXkwYSt2NlpDL3pFelVwdlN2R2JuZFhQ?=
 =?utf-8?B?Ym5TWXF0S1h6YlZGT0R2UXRsd05BNnFlRXZYYTZaMUtPbVZLRkhEYkk0WnlV?=
 =?utf-8?B?S2RlV3JlNXNuK1IweFNaZVVOVXRVbENIa0tpM1N0R0J4M2c5bHhuSTFIUkpw?=
 =?utf-8?B?UUoyNFdpcU9yeXdXR2ZuMnlteXFOL2lSVGU1THArNDE4b1RSSE1uVnZvMDJT?=
 =?utf-8?B?QjhtZlBEeW5mdlZZUElOWmU3TkJKd05peStWRjkvM1hKb1lxcUpmWmhiY1BU?=
 =?utf-8?B?ZkovMDhMeERRRGtoc3Jzc0hUYXl5aURQV1haeUd4KzFvN3RUcm1vTWRwa0NQ?=
 =?utf-8?B?MkhLZ3FMQU5Qd0NMY2Vyc1lTSkpnMExEa1VKNDBlUVF4L3V5M3NEWnF2djBQ?=
 =?utf-8?B?aEhsOVhac1RFVjV5VVRwQlZyT2NRM0d6REZ6a1hpNUo0QnhFN0hqbU5OUEYz?=
 =?utf-8?B?WlhDYW9LU0FjaDB1dTB3dmo3TTRPcndodEZ1bm9UdExsUGFCY2tvK21rNEZN?=
 =?utf-8?B?S3prUHpCZ21IdHlVaExyQzk3TDhmcXJ2bEEvTEZwZGZBVHFHK3J0SjNPeFp5?=
 =?utf-8?B?TVAzdmp6VWc3U1NLaEluZzd1NGdGQ00xeFRMa0NaQzJPUGlmdkxRdDJ4OVpS?=
 =?utf-8?B?Y1lIbU1NUGtQWVo0NGdYMld2U1FIVDhXc0J3WVFPZ3RYbkJkVWY3Q2V1U2Er?=
 =?utf-8?B?Tm9OK2tBQ29nM3R6NE9LMTZELzFOUFRzRitqRkVrcW1CT0lZYTd0dnJOT1RG?=
 =?utf-8?B?V3lwT2xxSlBGMWNGTUZnaFRKYTY5KzVTOWVrdFRzWmtPRXFHakpsYURuMy9U?=
 =?utf-8?B?eDFQaTlVZE0ralNYRmRYbVJNR3BKL3dVci9KU0RXNjFIZzEvV1laMFJPMlVl?=
 =?utf-8?B?K1ZIWmNCbkVwWmQvaFJ1NkJzOFVBOW5xang1VS82WDREMXpHY0E0Y1BJU0tz?=
 =?utf-8?B?N0VqSHVJOTR6d3ZCcWx5WTR1aCs2UVRZOEhOcmRaY1Y0TWkwRWdtdmdHUXFk?=
 =?utf-8?B?YU8wWDRuUUVIc2Q3bDBiUkhTdkg4RE5IRmlWeEFiSlJhbm1PVzh4V2FqblJL?=
 =?utf-8?Q?2QItVL?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cnYrQ3FjN3ZtODdaa0ZXNXJ1MkpMWTg5K2ZDU0lydDNMZEh5VHRnbjVYeUhq?=
 =?utf-8?B?T05DVzRIR2p3c3dEVmdFSUYxQWlIbXZKWnE3MWs0TGZRcnVseEw0VTh4Y2s5?=
 =?utf-8?B?SkQ0RkQyKzVTdjhQTjB6UHRCZ0Rva1FqUjNpaE84Y3JJMit3c25uNEZ5M3ZC?=
 =?utf-8?B?aGR5TXVHT0pRQjFsZklHbnVUU2NPYVh0YmQrbmZFQUVJSzFoeU80QU1pbUxT?=
 =?utf-8?B?QTFGbkkrZE5kejJjdVRYc1draEJzZnpDRVVMc1pLMUxuMjhXSnp6d2RBZ0F0?=
 =?utf-8?B?UkNWUUZ4L0trK0VuV05vNnlKY2U0ZjFId21EU0hyb1hhNWFBRzduN2RUR29H?=
 =?utf-8?B?cTQreHF2M2NwNys3Zm1kNDJ6aHNVaisvSjV3RzNYalBqbkRVTzQrQXBQS0pi?=
 =?utf-8?B?V2hJSXZ0bEtDNVRXczFrUVIxT0FPaktxSXgvNUV6cUg4bGRuYWtNK1NOeTlU?=
 =?utf-8?B?b1NPMHVOOFgxdHg2RkVlVUtSVXRCcG9peXBaSkxyUEVFaEdKTVJCbEc0eVlP?=
 =?utf-8?B?N09NODBwQU5ib0x1dEZuUjM0d0hqVmp1TS9CZXZCbGcvNnIvSnlRUXVjbXo5?=
 =?utf-8?B?aUdIYzRDaDVBL0ZCUXRRQll3Q0hVQmlpQmg3UDJmN3Jwdyt3NTV6aTZWOFY1?=
 =?utf-8?B?aDVTbk9rOHJiVmlmYjhnTndpVkJNWWFyZUFaZkVBRDU0MjdrL2JyaXBNMGNI?=
 =?utf-8?B?NS80M1JwdUJKaC9lZW5UdW4vWW0vMHFFNlpiMms1K05JZFJqM3V1Z3pLMHNR?=
 =?utf-8?B?MzdxSlVoNTBRZ09aTVJ3Mm0vSzU3NTNudi9rRlF2VHBNa0QrK1FTZSs2QTdx?=
 =?utf-8?B?S2NpZUU0NG1ybkYzSFVibDFvZzJ6czVhQWZuejlhOGQzNUpaNGh6bnhibWxm?=
 =?utf-8?B?Z0k3Z0ZWS2tMditNZGpxejRlQjg1cUpERnc2d0g1UGVrblA0NHU3aEtCS3dE?=
 =?utf-8?B?alovcWNlc29iNVE3Z0JFQXFSMkZJbGJsbjloM0VBVFpvTTVqalYzcXFYWkpj?=
 =?utf-8?B?b1hNY1lXRHhWQmNCWm1vbE5mV1dwZlJ5SDRwTXVhK0lKckRqTDN6Ym1ubkpv?=
 =?utf-8?B?U2x3THR2K3U1ME93SkduOVdEd1J1WVBWWjFSU2NxbWR1azI1SDlGV0FVRW1u?=
 =?utf-8?B?b2R3TjVkanl6TDVPTWlKSTBKTDRFbHoyU2hVeUhhNFQyMXVTaTA3ZzNhSWRh?=
 =?utf-8?B?eldQMWlUeFFLdDFQcnNXd0xOcUQvWEc1cFEvTDRncGYvWUJhK1pjQkN2SVFI?=
 =?utf-8?B?a0t4ZEFpdTRFb245cnc0cTJ3Uzg4QzZsS2UrQi93LzkzWUprTjFvRUZzWWlv?=
 =?utf-8?B?Z0QvSDNrTXYwNHNTVGtCT2VibG1jODhPaURRM295ZlRTYWxFc0x5c2o5YU1U?=
 =?utf-8?B?dVdQMEJyMzg4SWlpRmJ6b0ZodnBya04wNVFwa0hheEZNd0NzdmlEUkc2QzNj?=
 =?utf-8?B?NlJjWk83SjRHR242TnR1SmZWRjZMOHNlRVVQVTMyak9tZkJLWjJYZHFqUG5K?=
 =?utf-8?B?ZENwNE1EWThRWVg4cGg2SDE4VjBldXZReHF4Yjg1RWpEWlh5RnZlVDZoUEJ4?=
 =?utf-8?B?dGlBbXV5akExV3dEbzJYaFFVcDVyRC9kcjBlMGhWWVpnMGhQVFlodVdMZ0dq?=
 =?utf-8?B?Mjg4VmxDUkExTG5xQjhZQTZ5N2puMlIySFR2N29kQVdvbmMrUkFjZCt4aSt2?=
 =?utf-8?B?emJRSEVhb05melNHcFB3ZllwK29qdE5iYTYvYlprZk9pQzlTeUdIZlh5dlVB?=
 =?utf-8?B?N2NvcXRUbGVTVUN6Y2xqUmMvaVlYU1c2dmoydzVSeERQM2FMQS9hWUo3R1Ra?=
 =?utf-8?B?cmVGbW5sUVlXTTdxR0tmUlIySlpkWkdUU3BUbkFlUW9IU09zZjJQTi9YdGQ0?=
 =?utf-8?B?TDNhNC9Jb21QY1VFOW5mYVJlejM1KzV6Z2JYN25WRzdCMDJPUUVYbFgwUmRK?=
 =?utf-8?B?UWRNMDJpdWhMblJFWkpVTWZETndxZExyUEZZM1E5S3RWNHFYQ2dobHVpUFlW?=
 =?utf-8?B?NEMzT0VSZzN5M2N6SDkvZFFaQVhYdm5xMVdTdjVWaVFoK09GUUtrSjlWcHp2?=
 =?utf-8?B?YUJIL0ltR0phcDNsVmgrT05qMkdiWXpuSlk1bXRBN09JR05ZaDJVM2lmc2VC?=
 =?utf-8?B?ZkZWM09wN1Mwd2Z1MTROcW04ZS90S2NvZGhtY3owUTR6WDI4djUweUNHVW1S?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4e9b0a-594d-41f2-05ad-08de16cbb0da
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 09:15:23.4139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6U+VOkqLCWaUgZjPDmZXiLM8mLlaSFlTkv51vRbnetPfJvt8Df86D358/PS/Lf0TY6S4xnMz+K1sCmI49UQcNfZzt8jObOkYPNw43dhBKwymlchVKuGss/4UiDAJce+1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8147
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Oct 2025 09:15:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20271

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxyaWNoIEhlY2h0
IDx1bGlAZnBvbmQuZXU+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjgsIDIwMjUgNjo1OCBQ
TQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IHBhdmVsQGRlbnguZGU7IGl3
YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6ENCj4g5rSLIOKWoe+8pO+8qe+8tO+8o+KXi++8o++8
sO+8tCkgPG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmE+DQo+IFN1YmplY3Q6IFJl
cXVlc3QgZm9yIHJldmlldyBmb3IgNC40LXN0NjksIDQuNC1jaXAxMDQNCj4gDQo+IEhpIQ0KPiAN
Cj4gSGVyZSBhcmUgdGhlIG1hbnVhbCBiYWNrcG9ydHMgZm9yIHRoZSB1cGNvbWluZyA0LjQga2Vy
bmVsIHJlbGVhc2UuIEFzIGFsd2F5cw0KPiB0aGV5IGNhbiBiZSBmb3VuZCBpbg0KPiBodHRwczov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jaXAvbGludXgtY2lwLmdp
dC9sb2cvP2g9bGludQ0KPiB4LTQuNC55LXN0LXJjDQo+IA0KPiBkMDE5ZTRhZGE3ZjgwIG1tYzog
bXZzZGlvOiBGaXggZG1hX3VubWFwX3NnKCkgbmVudHMgdmFsdWUNCj4gODZkNmE3OTBhOTZhZiBp
NDBlOiBmaXggSVJRIGZyZWVpbmcgaW4gaTQwZV92c2lfcmVxdWVzdF9pcnFfbXNpeCBlcnJvciBw
YXRoDQo+IDY3YTY5MDk5YWY5OTEgaWdiOiBmaXggbGluayB0ZXN0IHNraXBwaW5nIHdoZW4gaW50
ZXJmYWNlIGlzIGFkbWluIGRvd24NCj4gY2FlYjYxNWMwZjczMyBuZXQ6IEZpeCBudWxsLXB0ci1k
ZXJlZiBieSBzb2NrX2xvY2tfaW5pdF9jbGFzc19hbmRfbmFtZSgpDQo+IGFuZCBybW1vZC4NCj4g
YzdjZjQwMWQxYmZmYiBmYmNvbjogZml4IGludGVnZXIgb3ZlcmZsb3cgaW4gZmJjb25fZG9fc2V0
X2ZvbnQNCj4gMWJkZDQ5MmUzMTJjMSBvY2ZzMjogZml4IHJlY3Vyc2l2ZSBzZW1hcGhvcmUgZGVh
ZGxvY2sgaW4gZmllbWFwIGNhbGwNCj4gOWJhNTgxMjc5ODRiMSBlMTAwMGU6IGZpeCBoZWFwIG92
ZXJmbG93IGluIGUxMDAwX3NldF9lZXByb20NCj4gDQo+IFRoYW5rcyBmb3IgaGF2aW5nIGEgbG9v
ay4NCj4gDQoNClRoYW5rcyBmb3IgdXBkYXRpbmcgNC40LnkgdHJlZS4gSSByZXZpZXdlZCB0aGlz
IHNlcmllcywgbG9va3MgZ29vZCB0byBtZS4NCkJUVywgY291bGQgeW91IGFwcGx5IHRoZXNlIHJl
cXVlc3RzPw0KICBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvT1M3UFIwMU1CMTQ4MDhGRjRC
NjMwMzM4M0MwNUYwNUQyN0NEMDBBQE9TN1BSMDFNQjE0ODA4LmpwbnByZDAxLnByb2Qub3V0bG9v
ay5jb20vDQogIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9UWTdQUjAxTUIxNDgxODA2REZE
ODNGQzc4QjQ1RUYyQ0M5Q0RGQUFAVFk3UFIwMU1CMTQ4MTguanBucHJkMDEucHJvZC5vdXRsb29r
LmNvbS8NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K


