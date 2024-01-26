Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0C0C47422
	for <webhook@archiver.kernel.org>; Fri, 26 Jan 2024 17:18:08 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.80])
 by mx.groups.io with SMTP id smtpd.web11.12372.1706263125258987253
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Jan 2024 01:58:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=A5QVCN3j;
 spf=pass (domain: siemens.com, ip: 40.107.8.80, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF8Y8Iq9P7La3jH25tS1JgR7pYQdoHKAIMuXF2aOi6PAiKTkqDJvtOrre2oQH5+cUn1FxP84Zs8EzpPnipdQDfgoObLzQNVMoHj+tt5Gonx15O9Cmd4m41TNOCCK2ueX4RTeQTb2oQdfBH9ssb/vVajCteWjzPdJZm6003dF0SFKrcB0+CUPzELoQmPCtXiG/oyC+wS2AKwZxkK1el8WoEJNoSNUkyE/a5nIGFVWgxYDPx99rsZ2cwY1wq0ZwCL0ZPOq+i/tg8Fh1YvEga82cDwak06At2Rd/uT5gjq5VUfCBeqEgW49ngmCHXv8He0dislzkswXmcFmMmWZ41GpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81Qt/y8A0WjJlQxtctWaWt8H9h/sYjqRVhZNKgqcntE=;
 b=i/c5uh+3+bT+3DtN/7XeTkA2CvK7y5Tm2gpU+dJYTjlsN8UjCZ1uIo8MtlXPhIdeQv8PBJygvxV4Wm39IE6fGwqD0e+ICa/TND/hnmcJQWn0xD3BuHruEu3bYBYEIWWYIFj0FDOsS9WQViymbPvwC2RQG/8RcLY+sS/+hD3GmWgfCwcYdeg6uccL2JlSjKgNmHiIE3py8URHk/Lag1HJBdEg+M0J2jEc58ilIXqmpwWIZQYPvP/3QZ+xkUCRLuhDLb1Pr7rymxdhd7S6ryeE/hiOTPYdnBN7K+f9pljdKETvpf3haKa+9kTv3U0u4EuEbDlF9lCfV3DE2qCNSUiYdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81Qt/y8A0WjJlQxtctWaWt8H9h/sYjqRVhZNKgqcntE=;
 b=A5QVCN3jDdjuah7DXW2OFDWp18wQwbiciuUvEhjcC/JihfcGqp/heoh7Bky7hhnWihwZhYK1Ybd6/N8EesaX3ShYfVuELXwJXWjAZZ1lVrBOK0cWYKx5hpOGPbuWijWWKEuoKBbuBlJkU5vUc1WcWzzk0bjGNy0ktFhXqRVjvaBxusvG5cC/6i0+kz/e/RV5C4wLW+e01axWaXTpuUBB/k/rcTteXilcpKrTN5AK7ZUEYp1Nm9YKnyvccPiF7kxQxNTw4MtQGByDlN/YjfaJ6bcqvZMAd9vsKU43oiLlpOWGXUgyxZcBr11cHG5wZ83yNd1Ijgz0bLIzxeDf6Luy9w==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DBAPR10MB3995.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 09:58:41 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c123:2b7e:a12a:d53c%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 09:58:41 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate.bbclass: Remove
Thread-Topic: [cip-dev][isar-cip-core][PATCH] swupdate.bbclass: Remove
Thread-Index: AQHaUDcR2EuN/CvQCkGVKPEsKlBIubDr3AsA
Date: Fri, 26 Jan 2024 09:58:41 +0000
Message-ID: <ed45d82bcdeeb100b15ab71a02aa5c9aa5571556.camel@siemens.com>
References: <20240126090719.634980-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240126090719.634980-1-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DBAPR10MB3995:EE_
x-ms-office365-filtering-correlation-id: f73bc5dd-c04b-4f14-7fcf-08dc1e556064
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 3h10Y+VTq71ctHi52SfjJku42T/qUWq8Amhi8cdm6k8PCZspUWX18jT1niSP/lmZAw4GSJaCsOVH2qccdfOQ8a5KvS0RbbrVgC84KUSynizVr/hteFump8yhYL2aHYP6OsZywOukyh7pAs3rB35FWt/XTE/fwL59hpGkhth5ZWEZdlbu4MBTGWdiVNT1Xo5W65cYM3fGr0vi1u1ASF3wJ1KgCuYtglCtb1YtN5OqJr9BUSbm1SCoU8NCzY7VKWqjibcNqQ14s6Cq9jehwYwwwZUZ0hlejKE+l783B7FHWYZttWT+SXGc0TdDDYOmazMpjtLcu03S1RA+sIy4ltpYtKwrvuS6VV0pQ1YA5CVXUtH0/jzzGYgmbdhHDMXDgk8X1rkbXysfwkqJjcPCe4jmrcrPtXqL0lJ9JTGa132uA5JOwBQtNsa5bI7BBThzoFkGEB5oqcl8dB2eZ5XlM04NA720iN1YYvJ25N3WjiSu35Ij3j4WpN7Ntx4ux6RDh1aR4i3sSFmqxfuzHddEe2FFsDejDD22dzpIXbn3Fhp6bKAgal0wEgPPbbFJvKIvEd+vg1ajcuN9O0nzv+dMHQ/6SZq/S1Xeimen8klHdhOhKlKK6pxyIeEaYdJEeiT3NakMQiu1ue/R30eZcW7nNJYjzw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(6486002)(2616005)(6512007)(122000001)(38100700002)(5660300002)(8936002)(8676002)(478600001)(2906002)(6506007)(66476007)(66556008)(66946007)(64756008)(66446008)(71200400001)(76116006)(316002)(6636002)(110136005)(41300700001)(38070700009)(82960400001)(86362001)(36756003)(403724002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Tk16a0RnemJyNVNCY2dIUTV6NERmYitHOGlvUnBjb1FZZmhOSUxNZW1haFRC?=
 =?utf-8?B?NFV2azd0RVVVTVV1ZDFxWlNNeU9GeEQyeWljYy82OW0xa20yd3JSMmZ2eUJJ?=
 =?utf-8?B?UHBJNEt3VXVQN1k4eDRzSG1JdGN1MnRhdnRzS2NPQkRYUGkwQXA5RG9wOWND?=
 =?utf-8?B?QURta29CbFZNVHZreWhGQ3E2TEhVMnRhcDRNYjVMNjJWT01GUVhVRmVLZ2Jy?=
 =?utf-8?B?TTN5Z0tWbXVMRk5Nc0N0UlNENEVuL2JmNHRyY3BXalZhakl6MUZEenYwYUJK?=
 =?utf-8?B?U3BtR2hVbTE4ZWpIZnAzUlR1S0RRdUhqczNmeU15aEdHWnZ0STl6a3ZKdFlX?=
 =?utf-8?B?M083REhpWm1BRlhhR3FIQU1aR1RuSURYUFF2bHRKTldSamkzbmhTSHNsTTNJ?=
 =?utf-8?B?UUhBS2EvdkJEcHdHa3BhQWR2TWVVc0tXRUZFZzJlVE9jUVA4NmZRaU5UVHVl?=
 =?utf-8?B?ODRNWm9sOTJGUFgrNHZKdTFRcWlGVm1HNmNoSXNJL3dRQWJVR2FJTFVyZFVn?=
 =?utf-8?B?NFcreUxsYmtjSDJQek8zTWpqTFQ1ZXN0N2FIS3Y2WlRMSEFLQ0xkejI1MjJn?=
 =?utf-8?B?MVpoc28wY0gwdk9ISXZrck9XUW5COFVheCsxQ2hjUVV1ajM5eGNuUE5UOW5W?=
 =?utf-8?B?K3FBYUhwNUtXdWFRdi9yeWowNFZYOEJMdjlFTEVXaTlVZHEzMlRVNm9hcTNY?=
 =?utf-8?B?UElUSGZieFFaMXVlaHZiRHdwYVErVkpNMjBIWWRIY0Zza3JSYVRIVnczelNJ?=
 =?utf-8?B?Q1A5U3RRcFFjRW14VDBrbmFyaUczMHdHMjdUaUVuZVI5ZmlQcUgrQThtZmFy?=
 =?utf-8?B?THpicDJhWWhGd0N2dk01MmF2TmNCYjV2L2dvSDkzUGNHeno4ak55cDdKUHpx?=
 =?utf-8?B?Yk1ZNVdVa1JTb0x0aDZzYmlCWGsrT0lKRWdPYTVsL1NYYVdaZzMrMDhRMzky?=
 =?utf-8?B?blh0Z096MS8rYzRWWGJhc1VWZHN0YWwvKzFqTjVHUEMyYWd5dUhON3Z5U05t?=
 =?utf-8?B?SGpMcHhvK1VVcGswTkgzZThYa2l0Q2E3Wm1sOWJSUnE1ZldoNEI3V280VnNi?=
 =?utf-8?B?emgrVmh3M2xHUXFYYTkwSDdIUHFJZUcvWFl1MVhCdUFCbFhNc1dHN3U3dWVF?=
 =?utf-8?B?ZmZuWFpJbkdmNUJtZ0NNc0p5Y0l1b1NoQmhOb1ZkQVhqa05Ta1puRS81VjUv?=
 =?utf-8?B?aUNyQk9CUEFLaW13a2FKMEdpQTRzVU9wU21yNHdyekdOamt4ZUhiWGQ5dnpQ?=
 =?utf-8?B?dkZTZzdnVmpCTEc3N05pTU9IekxHQzErTWgvNnJwNTVxRTBKNlVIM2pJMWNY?=
 =?utf-8?B?bWpDeGEzUnQ5VWhNY2hXNFNiRUdrK3hUUUhBQXNEODNLY3lSVGJSZFVMSDdi?=
 =?utf-8?B?c0t4eDl2ZmxWM1RJU3BCTCtNRnVjeVdDa2o4bUU1RGlMeG14TGY3S3RKYlRk?=
 =?utf-8?B?U2VzZ0JVa2JqNUc4NHU0SlV2TzA5K1VOMWgrdUZFYWgrYng0UlpVSFNodGNN?=
 =?utf-8?B?YXNPN2d4UmdoZ3JVbGUwbnFIaEpHKy9HVHVPRzROVXFYc1FrVjRiNzFyY0w2?=
 =?utf-8?B?VHR3SDZNdFlZLzFxQXVpZlNwTzJhN1AwcFM4cUIyK1ZqcEtDVWJEbjhFbVpp?=
 =?utf-8?B?VEVpUEJEYmhYazFHalNVVXBHbU5waXhKelBVSGFPQjJiUHNwMVVFRHNmNUtQ?=
 =?utf-8?B?RkxuOEZZVUxiV2NIWTIvaFB1UmdrWkh1K2NScGVSdkpzcnhpQXVwZlg3cGd6?=
 =?utf-8?B?K3ZIeWdGNTA0ZHZDYTViMnpNdFI5MHJGWUpwcm5xckVoUEZTazJuS2FOVEZR?=
 =?utf-8?B?aEJ5dFpwU0Jva3VBNVN0ekNPQWJra1cybFJxaTRlSllFL3hQcGY5L0lnOGFW?=
 =?utf-8?B?dlYwdGVBTW5FWksyZ3ZMSWNmb1hnU01oK2FuZmlPQnEza1FmNGQ0R3RYTzNx?=
 =?utf-8?B?Y0lCYm10V2J2Nzg1ajhmKzdVTnhTUTJnb0ZLaCtrbnJCa05nSXJ4OVpPNjhy?=
 =?utf-8?B?WkVWSTgyYkdyb21EOTMzQzIwcVBLSHJWOWZkTkk3MS9mQlFveVdLTHB5N3lv?=
 =?utf-8?B?bUpJRlNXdXFPeXNCMDE4OHpmd0NOdGdnUG42NzgyZkxka1pMQWhjSkFya0ox?=
 =?utf-8?B?NkxFd3M5T1cwSjdmd0hVUnVJcWhiK0E3bXhJZ3NiYlFIVUhNZEg0VXI2MUI1?=
 =?utf-8?B?R1ZNaVpBdzhqaEZ2bWI5Y0Q2V2FnUmlpQVhWM09rSHRYckZmTjY3YWRqZWlk?=
 =?utf-8?Q?wfjwfadZBvSoJ2DEh4BlHyJSA6DfCmUGqeORr0U0vI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f73bc5dd-c04b-4f14-7fcf-08dc1e556064
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 09:58:41.7613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MML04lgL7p5pkGSNHGdXxuQ+KsfppKcclWwbgf67sj1wRHtM80vSnyt+TYWkwrW9KW3uQk3jjqpeP/6edW8aJazMf5Trp+XhLTxWmkzKizY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB3995
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CBB58F372B97E48B5FFDE959E50FEAE@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Jan 2024 17:18:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14469

T24gRnJpLCAyMDI0LTAxLTI2IGF0IDEwOjA2ICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhpcyBhdm9pZHMgYSB0cmFuc2llbnQgaW5jbHVzaW9uIG9mIGVmaWJvb3RndWFy
ZCB0byBhbGwgaW1hZ2VzIGR1ZQ0KPiB0byBgc3d1cGRhdGVgIGFkZGVkIGFzIGEgRlNUWVBFIGlu
IHRoZSBsYXllci5jb25mLg0KDQpIaSBRdWlyaW4sDQoNCkkgdGVzdGVkIHRoaXMgaW4gYSBub24t
Y2lwIGxheWVyICh3aXRob3V0IGViZykgYW5kIGNhbiBjb25maXJtIHRoYXQgRUJHDQppcyBubyBs
b25nZXIgZXJyb25lb3VzbHkgaW5jbHVkZWQgaW50byB0aGUgaW1hZ2UuDQoNClJlcG9ydGVkLWJ5
OiBGZWxpeCBNb2Vzc2JhdWVyIDxmZWxpeC5tb2Vzc2JhdWVyQHNpZW1lbnMuY29tPg0KVGVzdGVk
LWJ5OiBGZWxpeCBNb2Vzc2JhdWVyIDxmZWxpeC5tb2Vzc2JhdWVyQHNpZW1lbnMuY29tPg0KDQpG
ZWxpeA0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3ls
c3RvcmZmQHNpZW1lbnMuY29tPg0KPiAtLS0NCj4gwqBjbGFzc2VzL2VmaWJvb3RndWFyZC5iYmNs
YXNzIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gwqBjbGFzc2VzL3N3dXBk
YXRlLmJiY2xhc3PCoMKgwqDCoCB8IDMwIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiDCoDIgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvY2xhc3Nlcy9lZmlib290Z3VhcmQuYmJjbGFzcw0KPiBiL2NsYXNz
ZXMvZWZpYm9vdGd1YXJkLmJiY2xhc3MNCj4gaW5kZXggMjYyOTFiNy4uMzFmY2RjYyAxMDA2NDQN
Cj4gLS0tIGEvY2xhc3Nlcy9lZmlib290Z3VhcmQuYmJjbGFzcw0KPiArKysgYi9jbGFzc2VzL2Vm
aWJvb3RndWFyZC5iYmNsYXNzDQo+IEBAIC00MCwzICs0MCwzMiBAQCBkZWYgZGlzdHJvX3RvX2xp
Yl9hcmNoKGQpOg0KPiDCoMKgwqDCoCByZXR1cm4gRElTVFJPX1RPX0xJQl9BUkNIW2Rpc3Ryb19h
cmNoXQ0KPiDCoA0KPiDCoEVGSV9MSUJfQVJDSCA6PSAiJHtAZGlzdHJvX3RvX2xpYl9hcmNoKGQp
fSINCj4gKw0KPiArIyBBZGQgdGhlIGJvb3Rsb2FkZXIgZmlsZQ0KPiArZGVmIGVmaV9ib290bG9h
ZGVyX25hbWUoZCk6DQo+ICvCoMKgwqAgZWZpX2FyY2ggPSBkaXN0cm9fdG9fZWZpX2FyY2goZCkN
Cj4gK8KgwqDCoCByZXR1cm4gImJvb3R7fS5lZmkiLmZvcm1hdChlZmlfYXJjaCkNCj4gKw0KPiAr
U1dVX0VYVEVORF9TV19ERVNDUklQVElPTiArPSAiYWRkX2ViZ191cGRhdGUiDQo+ICtweXRob24g
YWRkX2ViZ191cGRhdGUoKXsNCj4gK8KgwqAgZWZpX2Jvb3RfbG9hZGVyX2ZpbGUgPSBlZmlfYm9v
dGxvYWRlcl9uYW1lKGQpDQo+ICvCoMKgIGVmaV9ib290X2RldmljZSA9IGQuZ2V0VmFyKCdTV1Vf
RUZJX0JPT1RfREVWSUNFJykNCj4gK8KgwqAgc3d1X2ViZ191cGRhdGVfbm9kZSA9IGYiIiINCj4g
K8KgwqAge3sNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoCBmaWxlbmFtZSA9ICJ7ZWZpX2Jvb3RfbG9h
ZGVyX2ZpbGV9IjsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoCBwYXRoID0gIkVGSS9CT09UL3tlZmlf
Ym9vdF9sb2FkZXJfZmlsZX0iOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgIGRldmljZSA9ICJ7ZWZp
X2Jvb3RfZGV2aWNlfSI7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqAgZmlsZXN5c3RlbSA9ICJ2ZmF0
IjsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoCBzaGEyNTYgPSAie2VmaV9ib290X2xvYWRlcl9maWxl
fS1zaGEyNTYiOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgIHByb3BlcnRpZXM6IHt7DQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGF0b21pYy1pbnN0YWxsID0gInRydWUiOw0KPiArwqDC
oMKgwqDCoMKgwqDCoMKgIH19Ow0KPiArwqDCoCB9fQ0KPiArwqDCoCAiIiINCj4gKw0KPiArwqDC
oCBkLnNldFZhcignU1dVX0JPT1RMT0FERVJfRklMRV9OT0RFJywgc3d1X2ViZ191cGRhdGVfbm9k
ZSkNCj4gK8KgwqAgZWJnX3VwZGF0ZSA9IGQuZ2V0VmFyKCdTV1VfRUJHX1VQREFURScpIG9yICIi
DQo+ICvCoMKgIGlmIGViZ191cGRhdGU6DQo+ICvCoMKgwqDCoCBkLmFwcGVuZFZhcignU1dVX0ZJ
TEVfTk9ERVMnLCAiLCIgKyBzd3VfZWJnX3VwZGF0ZV9ub2RlKQ0KPiArwqDCoCBkLmFwcGVuZFZh
cignU1dVX0FERElUSU9OQUxfRklMRVMnLCAiICIgKyBlZmlfYm9vdF9sb2FkZXJfZmlsZSkNCj4g
K30NCj4gZGlmZiAtLWdpdCBhL2NsYXNzZXMvc3d1cGRhdGUuYmJjbGFzcyBiL2NsYXNzZXMvc3d1
cGRhdGUuYmJjbGFzcw0KPiBpbmRleCA4ZjEyMTVkLi40MDNiZGVmIDEwMDY0NA0KPiAtLS0gYS9j
bGFzc2VzL3N3dXBkYXRlLmJiY2xhc3MNCj4gKysrIGIvY2xhc3Nlcy9zd3VwZGF0ZS5iYmNsYXNz
DQo+IEBAIC0xMSw3ICsxMSw2IEBADQo+IMKgIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTUlU
DQo+IMKgDQo+IMKgaW5oZXJpdCB0ZW1wbGF0ZQ0KPiAtaW5oZXJpdCBlZmlib290Z3VhcmQNCj4g
wqANCj4gwqBTV1VfUk9PVEZTX1RZUEUgPz0gInNxdWFzaGZzIg0KPiDCoFNXVV9ST09URlNfTkFN
RSA/PSAiJHtJTUFHRV9GVUxMTkFNRX0iDQo+IEBAIC02MCwxMSArNTksNiBAQCBJTUFHRV9URU1Q
TEFURV9WQVJTOnN3dSA9ICIgXA0KPiDCoMKgwqDCoCBTV1VfQk9PVExPQURFUl9GSUxFX05PREUg
XA0KPiDCoMKgwqDCoCAiDQo+IMKgDQo+IC0jIEFkZCB0aGUgYm9vdGxvYWRlciBmaWxlDQo+IC1k
ZWYgZWZpX2Jvb3Rsb2FkZXJfbmFtZShkKToNCj4gLcKgwqDCoCBlZmlfYXJjaCA9IGRpc3Ryb190
b19lZmlfYXJjaChkKQ0KPiAtwqDCoMKgIHJldHVybiAiYm9vdHt9LmVmaSIuZm9ybWF0KGVmaV9h
cmNoKQ0KPiAtDQo+IMKgIyBUQVJHRVRfSU1BR0VfVVVJRCBuZWVkcyB0byBiZSBnZW5lcmF0ZWQg
YmVmb3JlIGNvbXBsZXRpbmcgdGhlDQo+IHRlbXBsYXRlDQo+IMKgYWRkdGFzayBkb190cmFuc2Zv
cm1fdGVtcGxhdGUgYWZ0ZXIgZG9fZ2VuZXJhdGVfaW1hZ2VfdXVpZA0KPiDCoA0KPiBAQCAtOTks
MzAgKzkzLDYgQEAgcHl0aG9uIGFkZF9zd3VfY29tcHJlc3Npb24oKXsNCj4gwqDCoMKgwqDCoMKg
wqDCoCBkLnNldFZhcignU1dVX0NPTVBSRVNTSU9OX05PREUnLCAnJykNCj4gwqB9DQo+IMKgDQo+
IC1TV1VfRVhURU5EX1NXX0RFU0NSSVBUSU9OICs9ICJhZGRfZWJnX3VwZGF0ZSINCj4gLXB5dGhv
biBhZGRfZWJnX3VwZGF0ZSgpew0KPiAtwqDCoCBlZmlfYm9vdF9sb2FkZXJfZmlsZSA9IGVmaV9i
b290bG9hZGVyX25hbWUoZCkNCj4gLcKgwqAgZWZpX2Jvb3RfZGV2aWNlID0gZC5nZXRWYXIoJ1NX
VV9FRklfQk9PVF9ERVZJQ0UnKQ0KPiAtwqDCoCBzd3VfZWJnX3VwZGF0ZV9ub2RlID0gZiIiIg0K
PiAtwqDCoCB7ew0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgIGZpbGVuYW1lID0gIntlZmlfYm9vdF9s
b2FkZXJfZmlsZX0iOw0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgIHBhdGggPSAiRUZJL0JPT1Qve2Vm
aV9ib290X2xvYWRlcl9maWxlfSI7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqAgZGV2aWNlID0gIntl
ZmlfYm9vdF9kZXZpY2V9IjsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoCBmaWxlc3lzdGVtID0gInZm
YXQiOw0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgIHNoYTI1NiA9ICJ7ZWZpX2Jvb3RfbG9hZGVyX2Zp
bGV9LXNoYTI1NiI7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqAgcHJvcGVydGllczoge3sNCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXRvbWljLWluc3RhbGwgPSAidHJ1ZSI7DQo+IC3C
oMKgwqDCoMKgwqDCoMKgwqAgfX07DQo+IC3CoMKgIH19DQo+IC3CoMKgICIiIg0KPiAtDQo+IC3C
oMKgIGQuc2V0VmFyKCdTV1VfQk9PVExPQURFUl9GSUxFX05PREUnLCBzd3VfZWJnX3VwZGF0ZV9u
b2RlKQ0KPiAtwqDCoCBlYmdfdXBkYXRlID0gZC5nZXRWYXIoJ1NXVV9FQkdfVVBEQVRFJykgb3Ig
IiINCj4gLcKgwqAgaWYgZWJnX3VwZGF0ZToNCj4gLcKgwqDCoMKgIGQuYXBwZW5kVmFyKCdTV1Vf
RklMRV9OT0RFUycsICIsIiArIHN3dV9lYmdfdXBkYXRlX25vZGUpDQo+IC3CoMKgIGQuYXBwZW5k
VmFyKCdTV1VfQURESVRJT05BTF9GSUxFUycsICIgIiArIGVmaV9ib290X2xvYWRlcl9maWxlKQ0K
PiAtfQ0KPiAtDQo+IMKgIyBjb252ZXJ0IGJldHdlZW4gc3d1cGRhdGUgY29tcHJlc3NvciBuYW1l
IGFuZCBpbWFnZXR5cGUgZXh0ZW5zaW9uDQo+IMKgZGVmIGdldF9zd3VfY29tcHJlc3Npb25fdHlw
ZShkKToNCj4gwqDCoMKgwqAgc3d1X2N0ID0gZC5nZXRWYXIoJ1NXVV9DT01QUkVTU0lPTl9UWVBF
JykNCg0KLS0gDQpTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQpMaW51eCBFeHBlcnQgQ2VudGVyDQoN
Cg0K

