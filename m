Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E78CCF9E3
	for <webhook@archiver.kernel.org>; Mon, 10 Nov 2025 06:41:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42399.1762756873208294996
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Nov 2025 22:41:14 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5AA6fAAA3024754; Mon, 10 Nov 2025 15:41:10 +0900
X-Iguazu-Qid: 2yAaLE8zrXh6zWsvAJ
X-Iguazu-QSIG: v=2; s=0; t=1762756870; q=2yAaLE8zrXh6zWsvAJ; m=CuxsKEwX5+rNxCDwu93lsdDqX1FnquRscNVO22t29S0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4d4g6Y5ZjGzyPc; Mon, 10 Nov 2025 15:41:09 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAeF//LlE8DP7yMG1wIOj+BvLD4I6FoyNIgcEt4dKDbYBoBzCiU/reLhzMcEdxDBVWmX8T6sNZFMYP9j4Oz7Vnw+8QpKDJ89kRh4M557yAxeS4jOkrrMfRVIRQW3qbdey5PEhb3VTSx/OeG1rzv9dQ+8MryjhhMBciwzwEZUq/nm9nSldxdb7aZYrpSjY7mbWy79GgySbV+czjouM4A8VlRpsfEQhqxKVYI+s6FMm/jDWb8P6e3FvtLHVXUHfP1TrZzjA6tKLSjh1ZtavOobyrZLBALLRqP1Jo7jxe8UPiYPKk1nz/3sf95+uJCqu4R7jWkMkd437OVpdGI2nxY34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3jrTut3ZiIF3NSTzb+R9R0USBkzd1Jgcu7IQsckMpM=;
 b=gK+/O2BXzL8wm7azva6xvIOpVo7XyihNx3jXQayKEgU/G8BjWcyph2T6zhMW0OhzeYEcgAs0dW2EVovNsfigcltm2SDtBQqqpcyyYt0Z0Dtc9KfYStIHGsJWaXwTMr8LDW0zX+cYR4Yh26JsUtXK4i6n5LBOcUtCZ/P2YjTATXvreZj9ThQaS/Hq1cJ51hQDwPmoZAp6Ont0l/Esc4C6HtBnkKiKXxkeG0Fxk+3HdZGgck3P2NSSffpopiomCzvrWYXFMCoNMUMzP84MxoBEXXqgQKp7BencBA8i3GaQExO8m6xN3Tn/AmOxHrq2w5AiyTv+x7PvnCDQWDA8XvHcYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <Shivanand.Kunijadar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro.hayashi.f74@mail.toshiba>,
        <akunuri.sahithi@toshiba-tsip.com>
Subject: Re: [isar-cip-core][PATCH v1 1/3] scripts/deploy-cip-core.sh: Support
 deploying artifacts for RB tests
Thread-Topic: [isar-cip-core][PATCH v1 1/3] scripts/deploy-cip-core.sh:
 Support deploying artifacts for RB tests
Thread-Index: AQHcUJ8cyKmmNUzxWUm6lzxIOMZIELTqIPIAgAFQy4CAAAKAVA==
Date: Mon, 10 Nov 2025 06:41:06 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB966967DE34491663DEE575E0C4CEA@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20251108111517.752691-1-Adithya.Balakumar@toshiba-tsip.com>
 <20251108111517.752691-2-Adithya.Balakumar@toshiba-tsip.com>
 <25d8c857-fb9c-47b9-88dd-7450cf4490c3@siemens.com>
 <e3eac383-21d2-4cd7-ab73-e08ad53e42f4@siemens.com>
In-Reply-To: <e3eac383-21d2-4cd7-ab73-e08ad53e42f4@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TYWPR01MB11110:EE_
x-ms-office365-filtering-correlation-id: e6304367-e4af-4563-a7aa-08de20242053
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|8096899003|13003099007|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?UmdaMnZJLzR0TnlwOU1FNUxZMXFYem5yNWtKZWsxbnA2NUF5ZlhHSHo4?=
 =?iso-2022-jp?B?UWkzU1pxZDRSajh3K2I0TkVia2psTlZEOGF2dHA3dEtyZ0V2SllpUUNP?=
 =?iso-2022-jp?B?RWxHMnYvUEw1TzJQQlJKWVNMWXFxdGlENWd4RnM0bkQzQ21wbHl2VmRI?=
 =?iso-2022-jp?B?QXJRUnI4Zkc3R2pJK2V5WHJnVE1YeThBTlYrY0NmZEZoQUtOcFRsWVNq?=
 =?iso-2022-jp?B?VzJrUGgrWU4rVmdWZ2oxSCsxMWFlcWlzL0pZTjAwdXowaUVKdlhFcDA4?=
 =?iso-2022-jp?B?L3l4bzJMT0tkODAxR01QYjdpQjVGMklQYjQzSHhaTXRVQUhJbVpzMEd5?=
 =?iso-2022-jp?B?Wi92eU5WQ3dBR1N2NEFqY21JWlFoY2txNkU3K2FaR1BYSW1MWFpaRDBO?=
 =?iso-2022-jp?B?dG4zZytFWDRTZXc5VU93cVN5R0hHWHhTdmd4dmNMc09IUlVMay9hWnRs?=
 =?iso-2022-jp?B?Z3VVMTR1Qy92bFlxeU9vdXhiMVJoZzdSa24ya1Mxclpaa3k2TG1tQ3VP?=
 =?iso-2022-jp?B?NVhlZSswNTNNMTVyWm9oeWdjQStBWHVaS1ZnUEQ2OUxaaUZyc3FMUGxs?=
 =?iso-2022-jp?B?YTVhbnpuVnBnSnRxaEhJeDJ6elpxNDFHcjlsak50b3ppa2FUczk1aWpV?=
 =?iso-2022-jp?B?MUVwWU1aZnZxamVLb21Obm1nYmZxTXdBSloyMmkzclBiVWlhd2FqZTZo?=
 =?iso-2022-jp?B?UWlGNWwwMTdFR29HdGlDYTZLRHM0dTBpZVdjbnQvdGJ1UVB4SWM3S2Z1?=
 =?iso-2022-jp?B?MWFUNmF5ZTRmMTZ4dUFGWjl6YWczWU0vUnVGNml3K2hSbGlGbk8xbEox?=
 =?iso-2022-jp?B?RlBseUNnTUplbXF1VHNTREtqQkVobDA0L1FWRWZ0Sk5aa1hJREJkQ3Uv?=
 =?iso-2022-jp?B?M2c0WFVDRVZUL0tKWk4wVkp0OHFWMitXT3lITWtEQTlSTFZNNlV1RDcz?=
 =?iso-2022-jp?B?SjRaZjVyOW10UDM0WXdvdG1TNWMzTnZaVHFia3NvN2lqQlB6TDhZT2ZK?=
 =?iso-2022-jp?B?Rng2RWtoeFF6cVhld2svZ1AvQ2RmbFF6YzArQm44YjBLWmNJQW16Y2lO?=
 =?iso-2022-jp?B?VW5XUWZPNk4rUGhQTG5YOVpObGZ2SUZvOW5YcGsxYWppNmFCZEF6d0Y3?=
 =?iso-2022-jp?B?WTRwSUYzM1kyRE52Y29WQy9POVU5WjBsY2hIZjU0d3F5ZVdOTUpUU3FW?=
 =?iso-2022-jp?B?SUswMk9IVXZsREJFRGh2bW1DUVdsS0o3T2lKSEJhWmV4WHlJcWdoZDJi?=
 =?iso-2022-jp?B?Y0szRW5DaWl0MEwzODkrSUhqK1RqUHZ2b3RrSjVPTHl5clN2cEE1YThz?=
 =?iso-2022-jp?B?S2dKTlRqa2pJeC9adWtna0UzRmdYNXJCOWFvN0R0KzBGT0lwNU1wSkxR?=
 =?iso-2022-jp?B?eC9DYUhCK2tqWDBld2xhNXh3bWt2Zlpld1h0a01IWVhqSGIvcEVFMkZn?=
 =?iso-2022-jp?B?THZKVFZHMUZnK3BjR2NXMFBZVVZtMXZRZmU1U0ZYSDVVZG9RTkRFeDRk?=
 =?iso-2022-jp?B?ZFJWck92NFkvWjUrOFZKUFRSR2JRMmc4NjlwQ3oxbDNzTHdsR1FJY1BP?=
 =?iso-2022-jp?B?UzV0aG15ajBVeHJ1VDdUak1sM2xMcjhvR1ovV1JYN2htNWxUb1FFbitr?=
 =?iso-2022-jp?B?RnJ3cXZlOXpFdFhoMEUvV0puOEh5YURQdUhDcERrY1JPZXI2Yk96U2kv?=
 =?iso-2022-jp?B?YXpYNFZSTWowS2R5TWlEd1JHK0EvSEgvdnpHWTZ5N1FYUHJpSjJMbVNh?=
 =?iso-2022-jp?B?WS9KV3M3b21YblNOS3FrZ0lyekVrYkd0M0d2dm9uWkQ1NHBTdnZZbjlK?=
 =?iso-2022-jp?B?VkdsL294elI1L2x2N0NVSnlRckxJcVVEWTBrODNWd0Z5Sno5b013Smx2?=
 =?iso-2022-jp?B?SnJ3M1VEMXd6QU1vdXVsbGxkbzJzZVYxTnlBbXZKbXA2bVBFUWN2YmxR?=
 =?iso-2022-jp?B?SmRUWCtFd3pPU2I3M3l5a2VoaTZVSnVNeG11b0cvRHhhYmQ5eU10RmY1?=
 =?iso-2022-jp?B?L1dBVkpKVklZMjVFaXdrUmJhTXpveVI4ZEJHVWFsK1Iwa3huN0xRZzJP?=
 =?iso-2022-jp?B?eGpwMDV4bzJGNU1HaWkxalVKZUovWEN6NXI4Q3VOakJTU0R4WXlkUlNK?=
 =?iso-2022-jp?B?bU1pTFlhcTlsM0tJK1BRUWd0NVRNNS9DNUJqMFQ0RHRzZSs2WVc5Ui9y?=
 =?iso-2022-jp?B?QlhZTXd1TWczbHhCcWdRV0REWUJIZ0hSQ050Z0hmYW9rWWRnSVVoR0Mr?=
 =?iso-2022-jp?B?U2xsWTBYbElKQUdIN1E4eXNFeExkRWhoYz0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(8096899003)(13003099007)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?b2ZxVldySU1SUnVsZWpXd0FEKzlISFJqdGluVTNyS3NLb1FQVHZ0Wk1O?=
 =?iso-2022-jp?B?ZDNmY0JkanhxQVRnMzhzRHgvV1dSWVdUQitKRDhHb1pOVXUvaFhzOXM5?=
 =?iso-2022-jp?B?cCs2MDlLRzArREhWeUo1dWF0ZWxhN2NoeFRVL2NqV3FINTJLcU1COFBU?=
 =?iso-2022-jp?B?dndXNGtOU2twQzBqcmRsd2R5TDdjN0ltRlJ3Y2NIWGUrdVJqWDBFblUw?=
 =?iso-2022-jp?B?VFhPelQrdlZieUJsNDJQdWNXNXBVN0xvYllKa1FlSy9IbGxRdGQ2dlFy?=
 =?iso-2022-jp?B?VnZ5K09mL05qbVd6b2FvcUFzQ0JmUjV4aHBUZGdOWko2bVZoTm8yVjE1?=
 =?iso-2022-jp?B?MmRlUGZLT1JKcUE2SlFaWWFpdVRkdmkrZndFcm1lWmJTYTNzQlJzM012?=
 =?iso-2022-jp?B?QytJUUJEN2o3Nnd2R1p6aHBReDk4MXdIUXdYRHZLM1huQXhyRXJOQ0FD?=
 =?iso-2022-jp?B?eFdhWUR6ZEFOR0xyYkI1NXF3Y1NIakcxcHNNeFlsUVJqQWRUNFFaOGZU?=
 =?iso-2022-jp?B?STFsckIyMGR6TzI5RU5BZ2Q1SDFlcFZQOE1VRkt0REh4VnhDWFVhRUFy?=
 =?iso-2022-jp?B?TU9CS3pYM21BU05sTldSZFZwTUtxdEM3alVqWGd3SmFJM05pNXkrZUp1?=
 =?iso-2022-jp?B?WnJ0eWlBUG16Y3UvZnlPZ2JJTmIwaXAwSzFqS2F2Y2VMc2RDYlNZSklw?=
 =?iso-2022-jp?B?R3BHWDhSYWtUaFN1eFl2ZnNKaithNms3d0FBbTVEWndidFdKTnZiOUt2?=
 =?iso-2022-jp?B?bXNFUGdWTEhFdlJaVWtTbmRCSVRxYkxlVGNsdU9PcDNWSjFKQXZ0UEt3?=
 =?iso-2022-jp?B?SGUyb1hEdjJjRHRZRVhCb2s0UUl5YnpOQk1IVDhsZmVFUGgxRGdneHky?=
 =?iso-2022-jp?B?WjdaVGtncEV5SEtHWjAxc3ZUODBwYTFjbW55c2daVGhDTnl5azRpTXlm?=
 =?iso-2022-jp?B?enVMaE9vWjZ5UTNNTUxxalBhNWhCWERaMWl3T1NyY21wQUpVSk5DNmRx?=
 =?iso-2022-jp?B?cnAwQzd1S3pQNGI3NDZaYlNEWURmWVYzSW05WjNGajdMVE1XT0g2S2Uv?=
 =?iso-2022-jp?B?U1BOSE1BdWdoSXEvVHpONGdhVUlUSDNJd0FkcktFcmx4ajkwZnJFWk9Y?=
 =?iso-2022-jp?B?YlBLOFJmTnhKRXJhOEJYZ255OTJuT21MU0ZnTnFSOXdhODFEVittYlRQ?=
 =?iso-2022-jp?B?SDdlVVdsSmc1UW9QajRHV25XUE5BeHpuUzdLMlViQkZGSXd6Si85cUpZ?=
 =?iso-2022-jp?B?UHA2aG9QRE91NCtsdng2b3B0aWlSaG14VmVNSDU5OWJsVmNoVjM4MFc4?=
 =?iso-2022-jp?B?cE5GMG1PeWF5cHhGOEM2dmVDY3JCZjNPRmRINUozNFN6UDdnMmVMbmFN?=
 =?iso-2022-jp?B?aE1qNXNwVEtQalRWVHlKUGNwYXpaWDM5ZVA2djhPVzBDMUV2Y09kNVZp?=
 =?iso-2022-jp?B?UkQyS0dJRUhHS0duR29WMnVJK0ZLYml4Y0daMzNzZzVRV1RCbjlKNi8w?=
 =?iso-2022-jp?B?Q2h0cVZTQ0VrM1lZWE1GTE04cDNVUTRWZTl3bnBhazJKMlF0UFlFT0tZ?=
 =?iso-2022-jp?B?RU1uU2N2Z1lFL1ZDYklsbFNVUmZObDdJSk80U1Q3SzdxRmZIR2F6RWpq?=
 =?iso-2022-jp?B?TVFzZjlRZ25uZ0lEZWtiRE0xcW1Md1F0Znk5MC9CR0RlS01kcEVlTnBT?=
 =?iso-2022-jp?B?cURzSmY2RVI3T2FmUTMwdi9qQzFYcnk5Nnoxck5uU0Q1SU82RjRJcmZB?=
 =?iso-2022-jp?B?cFM4MnpIekl5K2g0d3JzY3Q4STN4WFNIbVphenFqd3VQclBJVjkwNlZN?=
 =?iso-2022-jp?B?VEN5cTNNdTRDQVNNKzFSbTlHallMM3VpcWZNZXZHMUlYVjY4TWgrWkVG?=
 =?iso-2022-jp?B?bnZxVEYwUkdoakpiUEZ2bXIvMGoxdGJ6YTREYU10cnNpUkdVUjgzaURw?=
 =?iso-2022-jp?B?TTdwR0w0dGxENDM5Q05xeGdsakl3Z3NxR1RwcW42KzB0UFpTWU5XWXlo?=
 =?iso-2022-jp?B?d2lKalpPa1Zhd1lLdm04TTk3U0NmQzI5YnIwM2ZXRS9RVUJ4V2RObWxX?=
 =?iso-2022-jp?B?WTZNTk5rcDBxWVk0M1pwSks5M2RVUllwazR3Wkk0LzNaMnhpVnpDKzZR?=
 =?iso-2022-jp?B?d01melBYb0l5QXk4Z0RoRnNGaXFNNEpKYjZjRkZPU25aYTJpOWNlYlFF?=
 =?iso-2022-jp?B?dDRzQm83Z1hJejdvdVlvVlFHeTBubkNyVzZjckZCUnZpeTJYVTYrNnVJ?=
 =?iso-2022-jp?B?QUNjWHV4NUxrZmpqQ2h5VFB6UU1kclcyMVdQakVVYXBUazhhSHZ4UWNO?=
 =?iso-2022-jp?B?N0pFTHhIcTVjYktxWndhdXh6T1BJSlRXMWc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB966967DE34491663DEE575E0C4CEATYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6304367-e4af-4563-a7aa-08de20242053
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 06:41:06.5657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /zZsmEyA2xZOUWpw6FpXUqQeS0bsNRzqL0CYMsBFvoDhY+Rprh7sisq5We7m+6uF2zPJlJ6+dUDNVn5DWeKN7DuHIM4pyrE1EatWs4cJGcF33ixC9jKDwDfkjXH2cDdn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11110
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Nov 2025 06:41:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20485

--_000_TYCPR01MB966967DE34491663DEE575E0C4CEATYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

>BTW, why are we still pushing the individual partitions? I though
>diffoscope can now handle also partition tables, thus complete images?

Yes, that's technically true. But there are issues with high memory consump=
tion of diffoscope when run on large disk images. I had mentioned this brie=
fly in one of my earlier patches [1].

And the reason we are also uploading the individual partitions is purely fo=
r some additional information from the tests on which partition is problema=
tic (not reproducible). This was also introduced by [1].

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/0a690f76=
9eee198bae94f3bd8f696f84f3841cea


>If that is true, we should push the wic images instead, and then use the
>presence of an 8th argument to control if they are deploying into a
>subfolder to allow build 1 / 2 differentiation. If that 8th argument is
>missing, the artifact is to deploy flat (and only once).

The current patches (patch 2) deploys all 3 artifacts (wic, wic-partitions =
and swu) for RB tests. And using the 8th argument to control deploying to a=
 sub-directory (build1/build2) is a good idea.

--_000_TYCPR01MB966967DE34491663DEE575E0C4CEATYCPR01MB9669jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-siz=
e: 12pt;">Hi Jan,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&gt;BTW, why are we still pushing the individual partitions? I though<br>
&gt;diffoscope can now handle also partition tables, thus complete images?<=
br>
<br>
Yes, that's technically true. But there are issues with high memory consump=
tion of diffoscope when run on large disk images. I had mentioned this brie=
fly in one of my earlier patches [1].&nbsp;<br>
<br>
And the reason we are also uploading the individual partitions is purely fo=
r some additional information from the tests on which partition is problema=
tic (not reproducible). This was also introduced by [1].</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif;" class=3D=
"elementToProof">
<span style=3D"font-size: 12pt; color: rgb(0, 0, 0);">[1] <a class=3D"OWAAu=
toLink" id=3D"OWAf378e233-265f-b6c4-f715-21f322ca12a9" href=3D"https://gitl=
ab.com/cip-project/cip-core/isar-cip-core/-/commit/0a690f769eee198bae94f3bd=
8f696f84f3841cea">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/0a690f769eee=
198bae94f3bd8f696f84f3841cea</a><br>
<br>
<br>
</span><span style=3D"font-size: 11pt; color: rgb(0, 0, 0);">&gt;If that is=
 true, we should push the wic images instead, and then use the<br>
&gt;presence of an 8th argument to control if they are deploying into a<br>
&gt;subfolder to allow build 1 / 2 differentiation. If that 8th argument is=
<br>
&gt;missing, the artifact is to deploy flat (and only once).</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
The current patches (patch 2) deploys all 3 artifacts (wic, wic-partitions =
and swu)&nbsp;for RB tests. And using the 8th argument to control deploying=
 to a sub-directory (build1/build2) is a good idea.</div>
</body>
</html>

--_000_TYCPR01MB966967DE34491663DEE575E0C4CEATYCPR01MB9669jpnp_--


