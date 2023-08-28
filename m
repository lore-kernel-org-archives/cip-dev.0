Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2A9C71153
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 08:26:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.9077.1693211214418667635
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Aug 2023 01:26:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 37S8QqbV2842269; Mon, 28 Aug 2023 17:26:52 +0900
X-Iguazu-Qid: 2yAaEO0UREvdDcUT6G
X-Iguazu-QSIG: v=2; s=0; t=1693211211; q=2yAaEO0UREvdDcUT6G; m=D3eBaqnxwyNeLddAAIxRTXgUcpKIiencnt/OGf2aK/A=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 37S8Qn8n3951512
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 28 Aug 2023 17:26:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgX48hJHEwxHGH9xhEl5f5rYsgvTEFLBSgyYj2orIukyPJCyDXTSQZtVI4U2kBbtL8lf0FMf+GRgc/xNUa+o8Ul2bdfmq+/Hr6UgOQH7mVuTr6nxvLm1GU7hoU25jmGkPVfogCvywZhNBX7+vqlrseAJuo4+LTEhB1fEvirbHG6v66gKRaGVD3QAz32U6HejU1g/82IOhFV+ojGgkybj84sm9Yj3sGIhjPnglprsiQQrmYlmlIrWlKkq6u6LXUsBq6ZbWZ2Sm5a48Pp0+AQbe3dK1PA8CwqJST8GEHzKlJXpCMoldv1r/urQoHb4/IpVJWiyoKLVicquSHunIRHXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJcP8vqd9LWU9+P6pkDp5ddtjh8/0XqEbX0IvlP9U1A=;
 b=lE5+mmtT4OfOr8wYfX1H+boaci26cSkbKFselWCKnEAs+GEc2pyJk3r9xTYFUpbsg7DUoQmsm6dBlfpaFlDEOnl4dveQYjNGEyvNZ/UmFgz3kZNovPiJwm65v1gI2yB4JnwfLUmB+hmtzV+mk/w0mKZG/RfKkT9NFflHUlggpq92UodwJ0iJvHJms9RzBBh57WKCL90qTk5BqWThwWYiREyfPnvRafaIrnLkLmwZwdpCEI6k52YPKJhaHDrp+gZPGoVrYWqABTc9vn8eXRHmgsQVEMiz0l2BpDXD4N1b1lW8XY7TaJPE9YEgtqxdJ1KHQz5dTUpU300fKWpdEALBjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>, <iwamatsu@nigauri.org>,
        <minmin@plathome.co.jp>
Subject: RE: [isar-cip-core][PATCH] Add support Plat'Home OpenBlocks IoT VX2
Thread-Topic: [isar-cip-core][PATCH] Add support Plat'Home OpenBlocks IoT VX2
Thread-Index: AQHZ1Wf5/CLWZkRDa0OLNZTE4Lk26K//SywAgAAaeyA=
Date: Mon, 28 Aug 2023 08:26:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420D3C6042C375FB255DE1292E0A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230823021713.87089-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <e42fde0d-023d-4e03-a081-0d471172c6f2@siemens.com>
In-Reply-To: <e42fde0d-023d-4e03-a081-0d471172c6f2@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS3PR01MB5672:EE_
x-ms-office365-filtering-correlation-id: 0d5cda5f-e5fe-4ec4-82f2-08dba7a0855a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 IkZNiCmrfyzOQ+8/8pXiuSsVvS/6D1j3uharBodVAQ0U3VNJ55awbDM73BwvgJcW0Hj05L+XB3Q2DcZUI7gqheNQL3ydS1zyNOyoOMctgOgFx0+EQsQEA2palhcY02NwyLJOwdTI9QejeGx0C/HLpmiz39BLVRaUECQiAHLEY2FgYRk2Ms2FqrZkPCT6cJ8seNs23NNVr4d0PmjNJN7C1KcqBUjBghzDDmZMkmisRVtTsXO4lsl/EIlOztxa5MOS/Jye0faB9Ym/F9KBXizZ05OJH2zKeu7l/FBgrAhlLX0bL7UetIoCHiF8LBwsGoaIAaZ+Q+ybITFZ8xzdPHwVZ4beKg0gHgXxlsUDgVYZm+6vCDwq+O4Tl5YusQsCEeWGSa9zY6yaIdsmE7VqCC6EgMF8VUhcc/t92Y6e24hKbbj+nn7G6neNZoRMJQ6yz4eNG/WrSrgzKmdTc83NqqYNbLGV3vxVPUDv+O8FPXJ/nLmWcfarLOnlpjDmUv01ICgVL7+C7zxKJ1e/yyaN4mCt1Hzxcc/djBj9avzqKMaPo8pKH4LuRpmuIKRtPcqUPTBCNIdl+MWAjTkWcjjo/d+kQd2iCCnSN+B3J3dtEHz5z0HVO/3n2oFzrxWkOteSx9Sz0YoHcoH3wlJM6ysqHH93Fg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(122000001)(38100700002)(38070700005)(86362001)(478600001)(83380400001)(71200400001)(9686003)(53546011)(7696005)(6506007)(55016003)(76116006)(64756008)(316002)(66446008)(54906003)(6916009)(2906002)(33656002)(66556008)(66946007)(66476007)(5660300002)(8676002)(8936002)(4326008)(52536014)(151773002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eEl3MzN4T0RsaW1PWUhzYmFyN3BLZUpoRk5Kd2hMbGd4L0pWZU00cFFTYjRz?=
 =?utf-8?B?NDBmUDRqcEw2RnZCenNRbUNISmRlRnA1WmZyMmJIR01jTENTajRHUlFndXdH?=
 =?utf-8?B?VzZqZmZyanhGRVMwUFM4amVnMFRhdlFDTUtuemNJRzE5T09hTlJic0JpL3Y0?=
 =?utf-8?B?VlExN0hXcmVqbUtMWmZ4ZC9SdXFJbkdlQ05zYk5wNEFyZ1ZBK2IycVNyN0Y0?=
 =?utf-8?B?L2hBVUo1MGI2akVWZWl1RmxMTVRJTFZwREp0U2w3WHJCMm01dXlKdWhpUElw?=
 =?utf-8?B?S1NKR2MyV0Q1Wk04S0ZMeGlZQXZzc01nY0RWQ3lsQ0RtSlprWjZ6SXNXcHlq?=
 =?utf-8?B?UFVFQVQwaHcrN3QxQ3hrV3BXclR5K1QyRnlZUFIyMnZsVzFHSTgyVWI5dnRt?=
 =?utf-8?B?K0o3TDBxRnB2WGcyb1EyM2JaanlnQXBFc0dzUEdHWEkzSm00MmQzU0RTSStE?=
 =?utf-8?B?dXpHYUdzSi85aDFjbVZ0N21LN2NkNml6V29ZenkrUXhYU0lzQXJqM2l5UnlX?=
 =?utf-8?B?YmduR0NOZnhCZjZMTVBEWnhaa1BOVm4vdmRzMUtUOG5IQnhGeWNNVGMwZGU3?=
 =?utf-8?B?UnBKdzFnc2c0ekRmTGJxZno1aGhlOTExK0JuQndQRnY2dm5HdWdsbXMzMTQy?=
 =?utf-8?B?aWdvTXFnbzRpdjJ3TWhmdUJZbW1GL2xHRjVGYmR6WkVkK2hBSFAvS0taUlBQ?=
 =?utf-8?B?ZDlVd3NJR3Yrd3JqOC8yWmtaMUxqNzFzekFtWWRjMXJycEIrOFNjenVFNGVW?=
 =?utf-8?B?SEhUZ016WXlKSFdlbXJjUFlVcUxNaGhsSGl2OHJidWVVWE94RFhQYklpS2VI?=
 =?utf-8?B?TnVOYXpOSU1QMTFuS2ZHeFhPd1NUdmxaV202KzViMTJSREFyVHY1NVU0RmlL?=
 =?utf-8?B?anIvRkppUGszL0liNkF5Wkw2ZXFxbkw3QmlYcWRKbEFtK2ZuaUVLamZRejZp?=
 =?utf-8?B?RWlKMXphWkI0WHRxZEgzQXR1allGQkxxMGY5YUFMVmVVUlpqdlpIaVY3clIx?=
 =?utf-8?B?SnFJNjRJNlVQV3V6YTRBcVdRNis5cHFUWGlLVXliZ2hyMGRVWXllaDVUV0w5?=
 =?utf-8?B?Ym5nSllWYlJ2ZHYwcFBZQkVYN2pUbTRZSFI0K243OFQ0bTFrUzNDYVZ2RVBT?=
 =?utf-8?B?RmViUXNvaFhWekYrVFJTM2ZjcnFia3UzVWxBYXdKNmtDMjVKT0NjK0Z1bVdB?=
 =?utf-8?B?VHdkVmZsL3dIc1UxclB3OTJLQnN0c2cwZE0yc2tvQUJEYVJXY241Slo0cGE4?=
 =?utf-8?B?VXgvUUlFdGNBOVk0cGQ4N2xiVk5aQThjRy83Zmg3Wkt0ek5nazdRa1NkUElI?=
 =?utf-8?B?TGpsUmp5UFNSclI0UGNHWXMvVjQwcUxxeUhMbXljb1dUdUNDOFNGQ0ZRUU84?=
 =?utf-8?B?UUdJTi9VdG9BUTFLcm1xTW1QWWNlb1dWWERHN0xycU90aVptdVgxVEJLVk1h?=
 =?utf-8?B?S3U5cHRqNExVaWdKUEhoT1I1akxtbVVYL0VJT2NQTDFDSDdwS24vK0JzL0Zt?=
 =?utf-8?B?RTMvK21Wc2U4RnZJY2xpcTZnVjNNS1JLQVFhcHBZTmFwY3JrT1ZpTnZjaFd6?=
 =?utf-8?B?VjlQVU1RV09ZaW55SFh1V2kzb2w5aGp6UU9FOWJhZjFpaDh2S05KTzIxenho?=
 =?utf-8?B?aFM5d2toT0ZUY200WHdYTk9STlB4bTRiVW4rZWNxckNVMHc3OTZlczRpN1Z6?=
 =?utf-8?B?Ny8wdWIyblJESDlUS1hvLytaTFhoblJIMENvVTFNUWo1NDdOa2JBc2pUbFh2?=
 =?utf-8?B?R01XYmlUK0pWcE9lTlJUb3JmT0hkMGhnWVI2Uk82aVE0ckYrWExhbHZqRGw0?=
 =?utf-8?B?OVE3aUJiL0lqWkZMNEZWMnB0cHBtM2FrUSt4dm42cHREYVJEUlFMZlZ3NlZ0?=
 =?utf-8?B?VkZSVVMrNkFEZnZpNEE3c0p6aGtOUnJUTk50d2poMVpWUC96VFJvTS90YlBn?=
 =?utf-8?B?dUhQN050aXBWTzhxYWV5c0piWDBpYjBxanpwL2lvbUJoZUhEeUFEekdkMkQ1?=
 =?utf-8?B?SGxJU29kZWJuWWZ3cFBiOFdFZmRVRUdIYitSdm9EOTNoM2pJUkY3K1pJTXF3?=
 =?utf-8?B?QzdjVStCM3UyZ3NFcDZPZEozRXlWSFpVWUR5SitQNENyWVpRMWQ1V09jZlZz?=
 =?utf-8?B?UkVFYmF4bHlwRlZyQUZnU293TERmaFBwVzE0dlQ1R0FnbVZTbGRiaHhDdy8w?=
 =?utf-8?B?UTlDNnh6cFdlZHQzT2RYeFNUM0lmaldaVkRRQU9RMkFkSjNMUGZaZDNUVnJT?=
 =?utf-8?B?UlQ0bitwUWJwMUk4RERWcWNxQnlBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Uo2lFwuzKa0t8/DBH0eA2AROydfHIRKz8L/Rp9mxCG0hzSUwLPYea+PepWG009vAUmH1gR+WgeGkv+IpDKJeEiBlFG6MYOVh76deN8TFmJNfj9/kzuyqMLkLRdtjTR4umG9MJqpQhpt2K1014BP2h4FYh3VWMPi37SA/9vCnd81lKBiOdU+79D6H9esC3F7M7MBMeQWG61/YEWGzHlVTwEhbdJ41SlxlA9JQcC2o/jPUY/Je2ueJmSdA1xle6AB+rPC07s848h7XQ4SEOdve3hf+khm8E/V8X+AxCkrOOknBsptuKx82PTOShXX6ZDBWQ70U4THAtsQaz5hQJsnVqa2VAAgKsNpFho/+0A4iWXT50IdSPE/JkZ/B64cznXQsVzVwPpw5b+/NVGxchjVwT45imTyY2Pu8kKbpC2D8OAMIoQO0fCQQ7mPShfAvCQ2dFM4t5kMyJfdYEXhP2MWIO/qY0Hhja129HIZlpdkPvOCXl+pfCE4p/6uwE890H4Jt3Hit8wAapNOwialjn+ztZxs/MuzJa0I6TRoylo6dJpGkOlfHZz50W9U6hL8DdetbhTjPFzilkJ8Ib+ko6INau2khXpKUzAZ2OUnDyQSdsdMKE0R+9Tv633IErUcIgnt1kqMNLMu5/IxXrp0GoVqJEPqgFpNnqkMEj1yegQ76Bbq/L2OlaqxtW46C9hS0jUh1nbhfOXls4dCcgxMSm611pO8Yfdter2lBr7WYjJMU9xLejyflP9TFAAGBeh/O4eWNepjo8RdMRNpx95MZI4pzeo/fANUULUkWWab9OSWyeOvm4fe4MnxaNFc/dkHNn3JE3xX3B5Z3t6rnl8lyvE3sptxoFRqnnSlUncjbIc1V1YK3xX8Wr3EbQZF65jAuyqWA//S2qhZionI7/pvCZV8e36/MpLI/4UElXRgN2AV/lMc=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5cda5f-e5fe-4ec4-82f2-08dba7a0855a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 08:26:47.6430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mUJOIR13NZGkz+APqNl4LViRm1Tkb/LntCj8Q/TDLVdnz1ft9PqHVQ0kN8XMJ4rFpq8+b/rBPXf+LfQdLLgnD+3qgQt8OWCk+7qRiSrbgTWjMwhS2zurxL3n6rm6C7fZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5672
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 08:26:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12880

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6
a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDI4LCAy
MDIzIDM6NDQgUE0NCj4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4peL77yk
77yp77y077yj4pah77yk77yp77y04peL77yv77yz77y0KQ0KPiA8bm9idWhpcm8xLml3YW1hdHN1
QHRvc2hpYmEuY28uanA+DQo+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgTm9i
dWhpcm8gSXdhbWF0c3UNCj4gPGl3YW1hdHN1QG5pZ2F1cmkub3JnPjsgTWFzYXRvIE1pbmRhIDxt
aW5taW5AcGxhdGhvbWUuY28uanA+DQo+IFN1YmplY3Q6IFJlOiBbaXNhci1jaXAtY29yZV1bUEFU
Q0hdIEFkZCBzdXBwb3J0IFBsYXQnSG9tZSBPcGVuQmxvY2tzIElvVA0KPiBWWDINCj4gDQo+ID4g
ZGlmZiAtLWdpdCBhL3dpYy9vcGVuYmxvY2tzLWlvdC12eDIud2tzIGIvd2ljL29wZW5ibG9ja3Mt
aW90LXZ4Mi53a3MNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NCBpbmRleCAwMDAwMDAwLi4zMDUw
Njg0DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL3dpYy9vcGVuYmxvY2tzLWlvdC12eDIu
d2tzDQo+ID4gQEAgLTAsMCArMSwxNSBAQA0KPiA+ICsjDQo+ID4gKyMgQ0lQIENvcmUsIGdlbmVy
aWMgcHJvZmlsZQ0KPiA+ICsjDQo+ID4gKyMgQ29weXJpZ2h0IChjKSBTaWVtZW5zIEFHLCAyMDE5
DQo+ID4gKyMNCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTUlUDQo+ID4gKyMNCj4g
PiArIyBCYXNlZCB3aWMvc2ltYXRpYy1pcGMyMjdlLndrcw0KPiA+ICsjDQo+ID4gKw0KPiA+ICtw
YXJ0IC9ib290IC0tc291cmNlIGJvb3RpbWctZWZpLWlzYXIgLS1zb3VyY2VwYXJhbXMgImxvYWRl
cj1ncnViLWVmaSINCj4gPiArLS1sYWJlbCBlZmkgLS1wYXJ0LXR5cGUgRUYwMCAtLWFsaWduIDEw
MjQNCj4gPiArDQo+ID4gK3BhcnQgLyAtLXNvdXJjZSByb290ZnMgLS1mc3R5cGUgZXh0NCAtLW1r
ZnMtZXh0cmFvcHRzICItVCBkZWZhdWx0Ig0KPiA+ICstLWxhYmVsIHBsYXRmb3JtIC0tYWxpZ24g
MTAyNCAtLXVzZS11dWlkDQo+ID4gKw0KPiA+ICtib290bG9hZGVyIC0tcHRhYmxlIGdwdCAtLXRp
bWVvdXQgMiAtLWFwcGVuZCAiY29uc29sZT10dHlTMCwxMTUyMDAiDQo+IA0KPiBJIHdvbmRlciBp
ZiB3ZSBzaG91bGQgKGFuZCBjb3VsZCkgY29uc29saWRhdGUgdGhlIHg4NiBjb25maWdzLiBPciBk
b2VzIHRoaXMNCj4gdGFyZ2V0IGNvbWUgd2l0aCBhbnkgc3BlY2lhbHRpZXM/DQoNCkkgdGhpbmsg
aXQgY2FuIGJlIGludGVncmF0ZWQgaWYgdGhlIHNlcmlhbCBwb3J0IGFuZCBiYXVkIHJhdGUgYXJl
IHRoZSBzYW1lLg0KKFRoZXJlIG1heSBiZSBvdGhlciBzZXR0aW5ncyBhcyB3ZWxsLikNCkFuZCB0
aGUgcGFydGl0aW9uIHNjaGVtZSBpcyBhIHJlZmVyZW5jZSwgc28gSSB0aGluayB0aGUgc2FtZSBz
ZXR0aW5ncyBhcmUgZmluZS4NClRoaXMgdGltZSBpcGMyMjdlIGFuZCB2eDIgaGFwcGVuZWQgdG8g
aGF2ZSB0aGUgc2FtZSBzZXR0aW5ncywgc28gdGhleSBlbmRlZCB1cCBpbiB0aGUgc2FtZSBjb25m
aWcgZmlsZS4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K


