Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71817C0218F
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 23:43:27 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.60])
 by mx.groups.io with SMTP id smtpd.web10.15960.1738245969091913497
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 06:06:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Zec1L16u;
 spf=pass (domain: siemens.com, ip: 40.107.20.60, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9ZsHqaSWgTLP6hMPUBDytPNGt5+t0+reXIpeWsQQVNKtQib3c4EbGJDyz59tyJGk47fTXhVlYICiMOFTRE7klg+Mb/i3TTurt/GHMHhVOE5aBpuMhYbQvc5M8vyRZf1H2oZizMD3g6YWzH+/XHjdxKSs9otlIFn8pnzqDSq1USpC17r65QfkZjXqgrjEZR+I8g6QFNecNk9x24LSRWG4CE0xu07xKlDONduUyOmhqfIRVIXgdMtiUarHuv8ExaULnQ49n/qgFxU5Oxaly6AaAGXyTuwU9E+ujO/hzy4q2iv/hD2nv7AinBkoLggfFG7eClzMngOZCYgo75CaQk/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ejst1ipNH3FoqfKSNjQS9YtKE6t8+lX61FZmnaa2l2A=;
 b=qOsqR1t9N6MTn9hsP6X4EavO6BwuMuOjOZ951Qk6zGdFyGU/FgLxJBSeRFV2Ky/2rmig72gdbnMo+Undmp8uEqdMV8uL4ApRP80vABnXVPg1SWmhOX2EXPHkWa/AnlrmAmp60DKJ4G4meFSxU8U0hJOQlEXU6Oj/HVMdP9/vNNUrA7TzQpXop/WqAkoZP3E+XWredkVsKLZZhPYOszqFDi8g2btLUUv+qwzaMjzOa/ciPWxBP3bU4qDP/dul3yXpdbPSdHoz6tf5h3q00p9nmS663VckKafJtdxbmhJ0RTrS9THMnHaVxphfkIsa7m7H0EmHvaPnJxQ0G/a6Vlft1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ejst1ipNH3FoqfKSNjQS9YtKE6t8+lX61FZmnaa2l2A=;
 b=Zec1L16uXwCOhUWjKqM5mS7jze/ognukjk30xkl6nHU2bmFBfvWcq/hKBybpXNlgZPYl05SQayKatSg+FCX1bTy5g9vyRSbufzRr60l+SCQtFAPQiiMI6ehqhNEsokIEKX5OdkuHmCQx/IIO1u3qMRxm+Yq5dNPMfVbwe2RsUdhOLgEgcM3+aTFwIu0+uEzPouSbpPJXR4Cqj+C81rCb6jqsthU7LPkWQh9Q86VGLmgDHV3bug4J+myosH62Udk2TOoxtMtn76UQbphst0VnzevmwpCKgO3b4qQAtekE8AF/gHS/KdZnnrqwxjmbla0S2chSq5vxsLKtwazI7ZBg2g==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by GVXPR10MB5840.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.15; Thu, 30 Jan
 2025 14:06:05 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.8398.014; Thu, 30 Jan 2025
 14:06:05 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "Storm, Christian" <christian.storm@siemens.com>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][RFC][PATCH 10/10] Enable A/B snapshot for /var on x86 and qemu-arm64
Thread-Topic: [isar-cip-core][RFC][PATCH 10/10] Enable A/B snapshot for /var
 on x86 and qemu-arm64
Thread-Index: AQHbcvrYl2hTwycfn02QziDC81mHpbMvWj0A
Date: Thu, 30 Jan 2025 14:06:05 +0000
Message-ID: <96b0e4ca59368ace7192648c5db288db0ebc9610.camel@siemens.com>
References: <cover.1738229957.git.jan.kiszka@siemens.com>
	 <39b2a0d2ec39701f76a2b6b800f34ba3c123b0e8.1738229957.git.jan.kiszka@siemens.com>
In-Reply-To: 
 <39b2a0d2ec39701f76a2b6b800f34ba3c123b0e8.1738229957.git.jan.kiszka@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|GVXPR10MB5840:EE_
x-ms-office365-filtering-correlation-id: 96905c3c-0301-44f7-f1d2-08dd41373cd7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RXVVdGZPOW5sRjVaNGJyWjdjN1F3YXYxUFRVeVR0WlNYU0Y1Q1U0NnNBcGZG?=
 =?utf-8?B?bVNMVCsrOVRpYkRsbHhJaFo5d2l6cnBMYjRtSFFOeGlFWlZuQVY0elRTVFVk?=
 =?utf-8?B?WmlySEZ5R044SHh3b0dOZVlWRzZmZjdSUTVscnMzNFdXSnIrN0dvaGw0cWNh?=
 =?utf-8?B?T25tNjFpeW9YQ3o4M3ZDYWs5N0hHY3RERTByaWlHdVpNYlM5SmtTcENmNE4z?=
 =?utf-8?B?TEkxUTU3b211K1p3bWhYMG9EeDg3Zk9hT0FRcC9FVFR0QVhPbW0xYTEzb1pp?=
 =?utf-8?B?dWVmU1Z6dFRHcWxmQlVmbFZiNWRHUG5yL1h1OWZIbVRrQURtUzgyRk4xS05D?=
 =?utf-8?B?ZTlFWUowdVdJZTI3OHA1UFNIOGZSQW9uTFVGQ085bldGS3QvWW5kZVRsbE0v?=
 =?utf-8?B?U2JCbWI4QXAyOHdxbFdsTEpSTEJ2OVBGWlpUbG1YUWJ1ZmlQL0FGTG5abEN5?=
 =?utf-8?B?Q2lrODBIcW9ibGpVdzVyOEFvcVg3SzMwLys2aUZXbEpia0N6MjA1aTFGQmx1?=
 =?utf-8?B?eE5YNTloTkFJME5iVnBJRE5MVXhtQkdES0FqREpzd2pROGJPN3BJYUVuMFFa?=
 =?utf-8?B?TXBPd3F0aEQrb0FxY1JwaXRBdHB1VlB0K0krZmZZc2pZQ1hjSDRrMFMxVUZw?=
 =?utf-8?B?WFlXYzVRK01DZGtvMWNZbWpLaS9jYTJmbTVSWWdVMHl4K3RmWGRxb2FMeEd0?=
 =?utf-8?B?QThaRjN6d0RYZC9sUjY3SG44K0ZJVkFQMGZmdUhmK3hTQUI5dURSbVExRnZa?=
 =?utf-8?B?VGZjTHVMS1dpVTVwUTNWV2I0SVpFSiszRlY1MTBydUdrY2VSWGZyYlRVVVla?=
 =?utf-8?B?Rzd5Rk96QWpwWDU2aXpDbTVyQ09wWFU3S055TnVCbVR0TTRXK2g5QmxQZDVZ?=
 =?utf-8?B?aU5Vb1J2MldaTmR0ZGpxREtkRUZCUFdkQ0I2aGs0Y2s3RGxVZCtqd0QxMTdx?=
 =?utf-8?B?OWlyanhLTFFjZ2wyOHVyWEhwaU12VjJpbHRycFBRWHBWV3BkWW5UK1VOODZj?=
 =?utf-8?B?Sk9yQ0VaRHdMTnlKcWJHQW1TdXdNclQyRVFyUlYxTU83eWVRZDd2cm5PNnFO?=
 =?utf-8?B?TVQ2R0VBMlpSeUxMckZTUTFXZGFmQlpyd2ZtaGYrb1lHZUgrVWRreG1SbU5H?=
 =?utf-8?B?b1RFMFFBVFVtTHlFdlhORnN5VDlRSnlmYzZOTkszYzBvMllQV1dHNEFCMGtR?=
 =?utf-8?B?TU9WK1VDbHM3UXRoVW1EVzUrUi9tN2sxR2hjZy9GTllDSHlIYWNIR0prY0k3?=
 =?utf-8?B?T2RiZ25vRzhtOXJaTWpnSlFGVXFIL3AwR1dOL2ZNeG5pQ2ZiWTdDSTRKczZ4?=
 =?utf-8?B?am1kRFRZN21wWVplMEE0ZldNVitha2ZPblZ0UUxUenR4cllER1pUL2RQaDdu?=
 =?utf-8?B?MFFTc0JoVzdvZmhjTUJXdzlYdm95eGltb1pobVhRbERlTFNWVkROaEtsMmN6?=
 =?utf-8?B?aUh3MG0yVjR1ZzJNaURnWWZKNWIyNm9PMUVDVnhjb09LWENsOEdaL3k3a3FR?=
 =?utf-8?B?U0hWVjJ1SE1vR0I2K0ViYVIyR2t0RGpHNVY4aHpveTlKbEwzMmkxSnl1Sktu?=
 =?utf-8?B?bm0vSHJFWkRMeEhWOTZQQjVwamUrZzVGMlpCNXRmRW9XSGNVQnlGRzJpdzFa?=
 =?utf-8?B?cXpFQk0zYmF6REUyYzhkU3dNS0t0cnN2K2p0TTAzZm5Vb21MY2hBZ0c0VUR2?=
 =?utf-8?B?RVZ0Wk9WaGdpelc1RVh3MW5GdmRhSnJVNjM1QkpaMW54d2I5Y0IzemZpeDZi?=
 =?utf-8?B?QzQ4Z1kyODErR1dmSDhRenozZXRqUzVLMFd2dmpCWGxKUWd6WjRwRU0zejl3?=
 =?utf-8?B?NUdzby8yWmxlcmVReXY2QVBmREtPRitmaFBkVzE5QjMySDRyL0FFV0x5VkJR?=
 =?utf-8?B?WllVOVJRZlBDYTNnUlZUbENBOVVOMEtuUDQ5Wll2b00yTVZjZEhNTkFqeHlF?=
 =?utf-8?Q?0VeTP5eJSeggzaXovo1FyDEs9Lco6v2B?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?a1lLVUhQcW1tNFFHclJ5eEE1WVlvdENvSGVBZnRNaC9JTDRUUVMzOTdiblRS?=
 =?utf-8?B?OG9nclBlL21PdTRRc3FtS1NnVGFyNG90VHFZVDJkeC9WM2cyRmlZSGY4MEwz?=
 =?utf-8?B?RzQweFhlckpJbnBVOS9LT2w1QTJoUmRYcHJWNTh4Q1lGYmdoSEZJNWtwcFVp?=
 =?utf-8?B?ZEN1OExYazhyRklkZFp6bVpuRHIydklsckUzZWs5OU9UWnBnRm5iV0k0aUdX?=
 =?utf-8?B?NW1IRlVqVkw5dE9BMmtqcUdCSW1uWGNpdVpuUmJTb05QNXFaWFM5RkFkTnBY?=
 =?utf-8?B?UzFMemhDZmZEdzMrUWNDTnNzZktsR1BSaURVM2x4L1VDd3pqUGhWVnVaNjFJ?=
 =?utf-8?B?MHl6OWt0ZWk5Y1Z4cE1DcllTNGlNMUczK3kwdSt5aUJXNGJnYXdlTTdrVnZk?=
 =?utf-8?B?WGJsbWd6SS8xRk93S3oyeFBrNEozNFFudENBQ2N6SXQ4N0xCZ3NyczkrSVp2?=
 =?utf-8?B?Q1BiZzFxS3hvbXA1dURyMkFPUXB0Qld4OGQ0TEFRMlFlODBENjVHQVNpYkFB?=
 =?utf-8?B?NlcrZzVTTURYcFRpN09KTlFNRkhIV2x4MTV2endNSEY0QTdxL1JJR05RYmxn?=
 =?utf-8?B?UElCcWV3dldhL2JqbEg2UEtwK2w2bHBoZ092QllsN0xUZW9zeU12RUwvYzRK?=
 =?utf-8?B?WmpKZDgxS0pTMWM0aVZZMUU2K0hMaUZWUFloNjdYdlRIRTF5ek9jZnN1RVpI?=
 =?utf-8?B?N2tmbGh4eXhVb05YZnpjeHE2eWdpcW1TZ2lJbmFNUkliZm5lUWV1N3ZRVjBK?=
 =?utf-8?B?S3Vka2xPM0l3VEJjZzJSemN5ZE1lc0Q1c1ByYWRrWGQ4R0tBaXhEZGh6Nkxj?=
 =?utf-8?B?VjFuNnUzbFhjQzUxclEranY1cnkwQ1pucnFrM2twV21JS1EyZGtQa0YzNFZT?=
 =?utf-8?B?cDJhRGVjVWZ1WjVrNGhhQndRY3NGUHJKOG00SzRkalVTZzNTQ0t6bkVROTVz?=
 =?utf-8?B?bmRSa2I4RXNxODQ1WjdKTzRHREFyczFZWTVtald3ZElUQTNzNkgxUDlqSlNi?=
 =?utf-8?B?bDdNQWhyVEx4bGZ3WDhJVEQwZ0NBYldJUVc3aUxXb0NjRElFaHVOTFlNOFhr?=
 =?utf-8?B?Y1NRWCtEeE56cWRWMnhkYWhuYW80TFVML2ozanRlcC96V09rWU1uYUJoNnFi?=
 =?utf-8?B?YnFLaFBLaGVCN3BaQy96VVBPajNwK205b3JIZExubzJ4NTlWRXEyRkdnU3B4?=
 =?utf-8?B?NmU1V29CRndJSTh3U2tQOC9HVlNYaCtWZThUNTRYeUNHRnU5bnNtZE1JK1pz?=
 =?utf-8?B?SnJYNVI2Nzd5Ri81M3pMcjk0aE5wTTlGU2VxNkdScnRNQXQzTVZ3VHFRMVRD?=
 =?utf-8?B?U2NqYThicTRNdWIrQ2NURDBmWHJjQ3RPb0NLZUh0bFp1dmtsODdRNXNtVTdp?=
 =?utf-8?B?b2d4UzQwQ2dJN05qU3VPYlRnQW9pVWlJMEhUaWdONURQckdFTnlybXU1WGpj?=
 =?utf-8?B?b3FOeHoxOWE5aGNNalhQTVNoeWJoM01zdzZMaDdrREtKR292dlpsdVlKSVdu?=
 =?utf-8?B?Qk9Ya1RVNEhjQjllR3ZpQjQ1SXk3NmVobFdsV3pnZU9GcFFpZDRBVk5qd2F6?=
 =?utf-8?B?Zjh5QitEczFIK3gxTHB6dXY1K1dhWm5mR0s3c2VpM2ZxQmxxZ3p0eFlVVzN0?=
 =?utf-8?B?eGo4RHZSRC9JQnc5L2NnZVRZSkhmTFJUTHBaeDN1Yk5ONzdsWlI1YlNXL3Vq?=
 =?utf-8?B?VER3c1UwZ04wcDhsNU1MRzdoZ0ZtQ0cvcVYvMW5LNk45SFBpc1hjWUM5Ynor?=
 =?utf-8?B?anpvRm92UDNmWTJ4M0F5dGRncWYvRUVHdWwzUjdKVlRIcmo4c0JBaUplQ0Mr?=
 =?utf-8?B?VUFNVUFYb0hxbjJDZ0QxUVpORXArN2NpZkw3R3BJa3lNV25pUVFRZnVYRjI0?=
 =?utf-8?B?ZDAydHJEV296Uy94RzlKeTdSaUJHTXNhSXVyNzU4VzdGVU8zaXNhalgzYjhW?=
 =?utf-8?B?VDdFN1c2OE81Y05PeEphZXRDbDdvR1lJM1RyelVoT1JoL0pUQXNPdDc4bXo1?=
 =?utf-8?B?WThuU0tiaUdyaVY3MFp3bDRNNG90TjI5a2RmQ0xDVFREV05FOWN2OTk2NlFU?=
 =?utf-8?B?T3djcUp5UzdacGFxRUs2Qjlncm5OcFVySlV3YlNyL0xsZWwxdm9ZWGhUMnFR?=
 =?utf-8?B?ZHYzQy8rWjhHTS9nOHFiN0pneWdHZmV4cElpSUFqVXlQTjU1TCs1QTJNOVRS?=
 =?utf-8?B?UE5DbUxKelVVenNPVzlxL3Ftb2dhRS9IcVhERy9VdHFXK3FVN282b28xRzdH?=
 =?utf-8?Q?vFwuf1vyU4rnr+WClG5Y1+5pm5/DOb6EMeY09MXGsY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 96905c3c-0301-44f7-f1d2-08dd41373cd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 14:06:05.5824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gChk0wsuNEnUPa9xbrVZSYrNrCH4vE87Nsg8sy4ycCX5gkLRBs2bdCQAQeGUWTlr5I1IjPV0q4YfEzWAt4OYNK91yWdDA3NqUiPapjYIsnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5840
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <84B781867062F941B6611C4FA6D6A980@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 23:43:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17715

T24gVGh1LCAyMDI1LTAxLTMwIGF0IDEwOjM5ICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBG
cm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiANCj4gT3RoZXIgdGFy
Z2V0cyBzdGlsbCBuZWVkIHRlc3RpbmcsIHNvbWUgZXZlbiBrZXJuZWwgY29uZmlnIHR1bmluZy4N
Cg0KSGksDQoNCmRvIHdlIGhhdmUgYSB0YXJnZXQgdGhhdCB1c2VzIGRvY2tlciAvIHBvZG1hbj8g
VGhlIGNvbnRhaW5lcnMgYXJlDQp1c3VhbGx5IHN0b3JlZCBvbiAvdmFyIGFuZCB0aGlzIGlzIG5v
dCBuZWNlc3NhcmlseSBjb21wYXRpYmxlIHdpdGgNCkJUUkZTIE9PVEIuIEluIGdlbmVyYWwsIGRv
Y2tlciBkb2VzIG5vdCBwbGF5IG5pY2VseSB3aXRoIGEgQ09XDQpmaWxlc3lzdGVtLiBUaGF0J3Mg
b25lIG9mIHRoZSByZWFzb25zIHRoZSBkb2NrZXItYnRyZnMgZHJpdmVyIHdhcw0KaW52ZW50ZWQu
IEhvd2V2ZXIsIEknbSB1bnN1cmUgaG93IHRoYXQgd29ya3MgdG9nZXRoZXIgd2l0aCBvdXIgQS9C
DQpsb2dpYy4NCg0KRm9yIGRldGFpbHMsIHBsZWFzZSBhbHNvIHNlZQ0KaHR0cHM6Ly9kb2NzLmRv
Y2tlci5jb20vZW5naW5lL3N0b3JhZ2UvZHJpdmVycy9idHJmcy1kcml2ZXIvDQoNCkJlc3QgcmVn
YXJkcywNCkZlbGl4DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEphbiBLaXN6a2EgPGphbi5raXN6
a2FAc2llbWVucy5jb20+DQo+IC0tLQ0KPiDCoGNvbmYvbWFjaGluZS9xZW11LWFtZDY0LmNvbmYg
fCA1ICsrKystDQo+IMKgY29uZi9tYWNoaW5lL3FlbXUtYXJtNjQuY29uZiB8IDUgKysrKy0NCj4g
wqBjb25mL21hY2hpbmUveDg2LXVlZmkuY29uZsKgwqAgfCA1ICsrKy0tDQo+IMKgMyBmaWxlcyBj
aGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2NvbmYvbWFjaGluZS9xZW11LWFtZDY0LmNvbmYgYi9jb25mL21hY2hpbmUvcWVtdS0NCj4g
YW1kNjQuY29uZg0KPiBpbmRleCBkNzg2NjQ2OC4uNTI0NGM4NmEgMTAwNjQ0DQo+IC0tLSBhL2Nv
bmYvbWFjaGluZS9xZW11LWFtZDY0LmNvbmYNCj4gKysrIGIvY29uZi9tYWNoaW5lL3FlbXUtYW1k
NjQuY29uZg0KPiBAQCAtMSw3ICsxLDcgQEANCj4gwqAjDQo+IMKgIyBDSVAgQ29yZSwgZ2VuZXJp
YyBwcm9maWxlDQo+IMKgIw0KPiAtIyBDb3B5cmlnaHQgKGMpIFNpZW1lbnMgQUcsIDIwMTktMjAy
NA0KPiArIyBDb3B5cmlnaHQgKGMpIFNpZW1lbnMgQUcsIDIwMTktMjAyNQ0KPiDCoCMNCj4gwqAj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBNSVQNCj4gwqAjDQo+IEBAIC0xMSwzICsxMSw2IEBA
IERJU1RST19BUkNIID0gImFtZDY0Ig0KPiDCoElNQUdFX0ZTVFlQRVMgPz0gImV4dDQiDQo+IMKg
VVNFX0NJUF9LRVJORUxfQ09ORklHID0gIjEiDQo+IMKgS0VSTkVMX0RFRkNPTkZJRyA9ICJjaXAt
a2VybmVsLQ0KPiBjb25maWcvJHtLRVJORUxfREVGQ09ORklHX1ZFUlNJT059L3g4Ni9jaXBfbWVy
Z2VkX2RlZmNvbmZpZyINCj4gKw0KPiArSU1BR0VSX0lOU1RBTEw6d2ljICs9ICJidHJmcy1wcm9n
cyINCj4gK1ZBUl9GU19UWVBFID0gImJ0cmZzIg0KPiBkaWZmIC0tZ2l0IGEvY29uZi9tYWNoaW5l
L3FlbXUtYXJtNjQuY29uZiBiL2NvbmYvbWFjaGluZS9xZW11LQ0KPiBhcm02NC5jb25mDQo+IGlu
ZGV4IGEyYzVlNTNlLi40OTMyM2ExMSAxMDA2NDQNCj4gLS0tIGEvY29uZi9tYWNoaW5lL3FlbXUt
YXJtNjQuY29uZg0KPiArKysgYi9jb25mL21hY2hpbmUvcWVtdS1hcm02NC5jb25mDQo+IEBAIC0x
LDcgKzEsNyBAQA0KPiDCoCMNCj4gwqAjIENJUCBDb3JlLCBnZW5lcmljIHByb2ZpbGUNCj4gwqAj
DQo+IC0jIENvcHlyaWdodCAoYykgU2llbWVucyBBRywgMjAxOQ0KPiArIyBDb3B5cmlnaHQgKGMp
IFNpZW1lbnMgQUcsIDIwMTktMjAyNQ0KPiDCoCMNCj4gwqAjIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBNSVQNCj4gwqAjDQo+IEBAIC0xNiwzICsxNiw2IEBAIEtFUk5FTF9ERUZDT05GSUcgPz0g
ImNpcC1rZXJuZWwtDQo+IGNvbmZpZy8ke0tFUk5FTF9ERUZDT05GSUdfVkVSU0lPTn0vYXJtNjQv
Y2lwX21lcg0KPiDCoFdET0dfVElNRU9VVCA9ICIwIg0KPiDCoA0KPiDCoFBSRUZFUlJFRF9QUk9W
SURFUl91LWJvb3QtJHtNQUNISU5FfSA9ICJ1LWJvb3QtcWVtdS1hcm02NCINCj4gKw0KPiArSU1B
R0VSX0lOU1RBTEw6d2ljICs9ICJidHJmcy1wcm9ncyINCj4gK1ZBUl9GU19UWVBFID0gImJ0cmZz
Ig0KPiBkaWZmIC0tZ2l0IGEvY29uZi9tYWNoaW5lL3g4Ni11ZWZpLmNvbmYgYi9jb25mL21hY2hp
bmUveDg2LXVlZmkuY29uZg0KPiBpbmRleCAzM2Y4MmIxNi4uMGE2OWVhODIgMTAwNjQ0DQo+IC0t
LSBhL2NvbmYvbWFjaGluZS94ODYtdWVmaS5jb25mDQo+ICsrKyBiL2NvbmYvbWFjaGluZS94ODYt
dWVmaS5jb25mDQo+IEBAIC0xLDcgKzEsNyBAQA0KPiDCoCMNCj4gwqAjIENJUCBDb3JlLCBnZW5l
cmljIHByb2ZpbGUNCj4gwqAjDQo+IC0jIENvcHlyaWdodCAoYykgU2llbWVucyBBRywgMjAxOS0y
MDI0DQo+ICsjIENvcHlyaWdodCAoYykgU2llbWVucyBBRywgMjAxOS0yMDI1DQo+IMKgIw0KPiDC
oCMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1JVA0KPiDCoCMNCj4gQEAgLTEwLDYgKzEwLDcg
QEAgRElTVFJPX0FSQ0ggPSAiYW1kNjQiDQo+IMKgDQo+IMKgSU1BR0VfRlNUWVBFUyA/PSAid2lj
Ig0KPiDCoFdLU19GSUxFID89ICJ4ODZfNjQtZ2VuZXJpYy53a3MiDQo+IC1JTUFHRVJfSU5TVEFM
TDp3aWMgKz0gIiR7R1JVQl9CT09UTE9BREVSX0lOU1RBTEx9Ig0KPiArSU1BR0VSX0lOU1RBTEw6
d2ljICs9ICIke0dSVUJfQk9PVExPQURFUl9JTlNUQUxMfSBidHJmcy1wcm9ncyINCj4gK1ZBUl9G
U19UWVBFID0gImJ0cmZzIg0KPiDCoFVTRV9DSVBfS0VSTkVMX0NPTkZJRyA9ICIxIg0KPiDCoEtF
Uk5FTF9ERUZDT05GSUcgPSAiY2lwLWtlcm5lbC0NCj4gY29uZmlnLyR7S0VSTkVMX0RFRkNPTkZJ
R19WRVJTSU9OfS94ODYvY2lwX21lcmdlZF9kZWZjb25maWciDQoNCi0tIA0KU2llbWVucyBBRw0K
TGludXggRXhwZXJ0IENlbnRlcg0KRnJpZWRyaWNoLUx1ZHdpZy1CYXVlci1TdHIuIDMNCjg1NzQ4
IEdhcmNoaW5nLCBHZXJtYW55DQoNCg0K

