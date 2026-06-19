Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79700CD98FA
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 11:38:30 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40609.1781869102418306255
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Jun 2026 04:38:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dblU0+h9;
 spf=pass (domain: siemens.com, ip: 40.107.162.1, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wx+qq636a4vtFHSPuWqjt6D7NFOSXDkb7V8ANNH4cojhrJF6Wol4eSYJuCObKL1rAI7THB2cAra5vBnTEmWdrbmB5GnOzNk+8K54tXiV9MH1062eU9zTrEl+kMKfcR71QJJAao5OM3149t29qGhI9XrfSpPPAK5+YHdyFmiiDeMrRjYy0LJon4KSawzj4GjwiSrE6WXgrWPi96abPQ95PVOQlwLPeGtIvPTQV8XlQg8Q8LiuEZHp0EOg6satBCwkhcsQMB6JeC9Qw1CeBRj1oBPoKZFHAdI/cIOLnghrJ39G+YfgIye+8DFtepQ5ozS8U6uJ76fXkifedADiwf0V7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrUG7dPHvz+pbmcRJsBBHv5im1me5w2fK2Hhh9fhF7E=;
 b=Yo3uXrDGXPkqgVvVmcZ2IQ7097FAzoUxIJc0wzuqvYyKi01RLLyVij17xb5yKni9ekXtAzmLlI1NxZXqg5AT2bmOwu/s3qfa60byCT9gYR7ZAzxfIcy3rJ6uxZeS9xawh8O1E/L2xAzAj34uwWP8Q08puekpXu1qfwEAZMySC/KruWw9mBGIJ57bVRXp6PnAsLTk2MHboeZg5JYoG5rgu9GCKrz3IS3CYg3B28Ckt+cg/DESEM4bIN7PGYJTKG8QkoAAztRx7Oq2XKTRSxI3FKldSeIb9QPdHj+pZ2af8Bu+wF9c8K/B1xU1ntPGt5TLowLmHQy0CXlbeZDRSGcNiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrUG7dPHvz+pbmcRJsBBHv5im1me5w2fK2Hhh9fhF7E=;
 b=dblU0+h9XKa1+YpDcWdg2qmk0XZLaICwjojJ2q/eeW5t1Vc71btVmtks/yxm/i76MJc1DuIwWEJZ0hA7xImLAo1hQJIe7uC+nFsMx/dzHBKyqMUjvZu2GDef/dI8bDvd/G8oOz4W9OJOvC592Nr+1yk3YMqJO5ukJv3rd34EczrMLFxyK3gcVpn0Ey5dvq4Twy8ay2uoKbXcKU/NCIuUdrjW6FgpBIwJUadQ+xNDGYBh9mo1gd2jAjkixKjdosleSMvGLeaH5aAcd57+J12QdJwAiirZiRN5EIfmhRwqGHj2ngfq9mFOntSEKqLblvi801ynYMov9RoRmiFrXmoioA==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by AS1PR10MB5261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 11:38:14 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%5]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 11:38:14 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Storm, Christian" <christian.storm@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "Kowalsky, Clara" <clara.kowalsky@siemens.com>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core] switch user in swupdate suricatta daemon
Thread-Topic: [isar-cip-core] switch user in swupdate suricatta daemon
Thread-Index: AQHc/+AdPAJGX7YatUWmpUueOJuTsg==
Date: Fri, 19 Jun 2026 11:38:14 +0000
Message-ID: <dc698ef3e64c793fdf42c79d41cf5e8b215ddd91.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|AS1PR10MB5261:EE_
x-ms-office365-filtering-correlation-id: 038a5d8f-4092-4d99-de4d-08decdf73faa
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|55112099003|56012099006|38070700021|18002099003;
x-microsoft-antispam-message-info: 
 9obzfp1E4i6lgXgL+GccoqwYgN7+hSOtpDtc51HbFkhdNPJ6DuORLh4+iQt51RT4LJk7g6Qm/lnKL5tsI4aeC/wIkYGVkPGOi8KoSmZCsIc7EoZKsb1Z+QXhLOR9a3vReS18X1BCx75g3rR8FV5wiPH/dj10/l27VhOrYJPqBUBZ3XdHJjnuhjGYlNQ4a+6+9bft+vevAXdxEU5EBTzb2RwS42UI2RtAdy901gwuUsbLRILbHksw8t5tvaHt6azBHZOtxcvVGcDz8gDl7tuxLGQneoH0Vov6BQ7+V7+IWlBMk+WqPNdzFvzJhotflJ414VIkPQrmh4uBdxdKPnkthuVRY99v3XHstjMqDPGpibIFU+HXgDCfDK5VSelxz9C4yihR0YIcP903k9lvkHdv7pEJoiABWlgcFAgTwYWD08te8vyvurY+vDhCLsYwk/bkgCxgq0YsbYRIB83E++JerLS2H9SZWTMRgt51ZityBKwBz9mjdYwQTBys5H9R9bqQggbdfuNXDOuRYRsJW+/Zq/DinUe4auinptkVTdSaDf9NG+9gGuWf1WsdtmG8Y0sSVOHPFyHHluvpOxBoiuw0D0bHSLyLZOQJBuORDCh+Wjd4p2pC4HtejglkMCY9HzuQOyV9shb7WsFY9W1wwZAlebUXGDzWPsFAQ2I+tWLSYU4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(55112099003)(56012099006)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bEZPNThjWGpQMzh4STRXK0gzWmd3S3BFb0VwRnU1eGNxakJwUmZDY1NaMGNC?=
 =?utf-8?B?elNET0l1YnVyQXU5MklCR0I3OXV3ZTV5SnFtQ0FZVU1oSnZvK2IwTVFLazBE?=
 =?utf-8?B?OTBIejFXVU1KNGg0bDBjbzJsWnVSWVBvdnk2amo3Q0p2RVdhSDF5ZWd6ZTh2?=
 =?utf-8?B?WUo2MWxDZ0p0ZEs4clVXcEdmc2dRaEFFNFFnczJsQ2RDZEs2UG9YWHdka2FS?=
 =?utf-8?B?TmhDaHc3R090YW1wbCtIdTFBb2JoS2cxbGlYZ0o4UG55ME5vR2JwcHRrWmZW?=
 =?utf-8?B?UUFzc2hHNGFnZ2J6d2xpRW1zRFlMS1NPeGNZTnk4TkErZEFrZkIwTXVsaWow?=
 =?utf-8?B?OGRLVTg0OGFZOE1BVDBKYnh6VTh3NTBHZ0lrL0gxSlJEKzJybmdiMkdGRnM0?=
 =?utf-8?B?N3dnZVkxOFNBSkZmdXQyN3NPWmRPQTN1UGtDd25MZkUwYkRjcWtET0NtK05k?=
 =?utf-8?B?enlFc0xPZFBPbXF1eHhpSGNFNXZaeWhkazlkdWRTNkVYbWN1NjNDSUg5Y3kz?=
 =?utf-8?B?dzlFWlRBUlM4THpCbHBFLzZ3R24wVzJDSlMxWmtOZm13VEg1L3FBZHdRMVZi?=
 =?utf-8?B?ZndSQkNid3NFbXBjckxudG50MmphS3Q3M08zenJVVEVrc3FDanZ6TmVxS3l5?=
 =?utf-8?B?VWRXL1RKSXdpTkFHUzFyQkFHUDlvNG03ZXA1ekFNSTAraTJOTFByUlFacmFJ?=
 =?utf-8?B?Yk00QlVBMzAwM0NhTHV4RGN2Yit5VG1TV2dHVzZEenM1SDdGNkYyKzI1Qkt2?=
 =?utf-8?B?cjQvSmJlNko4Tmx6c2Z6YlkzSTZMME45M21NZUI0OVorV09iWFY0aDlxalM2?=
 =?utf-8?B?VDhPeWR5cHlkVHkwMXBCMlB0ZjIycllFN3FKVENkRVk5VFczdTJpM2JTZHE2?=
 =?utf-8?B?VjhpckJiN3ZWVDNaVThoNnNxUFhVM1JtYURXRUhHNnJJY2h2MVQxVGZGVDVN?=
 =?utf-8?B?M3R4NWQvMUU5OCtqNWRQTjhTUWpaNXVmbkNoSENzVzVsNzFUdjZRdWIvQisv?=
 =?utf-8?B?bkNEeTdQQ2VFaXc3bTBBdmVFL1ZzRENtQUIxREk5MUZOMTdTa2NEU1lUS1R5?=
 =?utf-8?B?V1pFWTVaQUJOVStJUmdWTW11SEJYQ3Q0cm5IRjNpNUJQMGdta0lnYzZTYmVo?=
 =?utf-8?B?bVJObjhTc1JvdC8xNHBYVUczTW5OQVlpMDhKQkJMWi9BdVQyRTVtT3d0N1JV?=
 =?utf-8?B?TGs0Sm9Sc1RmN1FjS3ltT1l4TTJTR0NVRUM4ZW92b1d3YXF6ZmFwQ0EvL2Ew?=
 =?utf-8?B?SFdJU1IrVDFleDY3MEQ1RXBFRWVEeVJiZGs1dWhCamVXazdYN2VNNTdMcS9m?=
 =?utf-8?B?a3puVTIyWWpqZmszL2VlR3lNRFJHYXI1LytRNC9OZ1hxc1lwbmg2NlcvVEN3?=
 =?utf-8?B?WkNiUVRhQ0Jidk9nMGo5OHh3RU05ODRpd0NQai9odDF0Ym00d0FzMDhMZGtm?=
 =?utf-8?B?MWY4NVYwZ3VvNFBXWTV3Ryt6NHZvQ1c0OG1nQ2dCb1VBWHhtdUs2OEdlemQ3?=
 =?utf-8?B?eDlNcWM4ejZtWDVFNHhSaW5paGJuUUpOanBHU3grTUFWbi9uMjBGdTJPdmNi?=
 =?utf-8?B?SnpVUE14LzJnMlVMVjArcUwwcjg3QkZFQnh3NU9rNDVweXU4T0dzZTA4L0Nw?=
 =?utf-8?B?WXJyaW8rUmlKQ0tDbGtmdkErRjRtampCSTJndHJqV2Z3Z3R4RWVydm1SdjVJ?=
 =?utf-8?B?ZGhtbFljM0JKQ0t6ckF1N1NBenJya0c4c2I4M2lqVWdDclcwNC8zMXVlWHJN?=
 =?utf-8?B?MitpUjVyWXoxTGZCRlQzeFpqMGpZWGlnL1J4MmptdXBXb2NhaVF1UTV1ckJZ?=
 =?utf-8?B?Z3ZqK3M1VktZMmVPOEIzZDZvcmswSWYyMEVyRzRyYXFtMCtjMXoxdk9mWFRa?=
 =?utf-8?B?OUxxWUFUOW1HSFBmOWZvdGY1YnFud1FOSy9MNEJEMEN1ZVBoUGxHN1gySHM1?=
 =?utf-8?B?VEo5UXFWVDE2bDJmWnk4Mm45dTVOSVY3QXJTUmhzVURMTUJrUU5iTXhYS04z?=
 =?utf-8?B?R0tVcXB6VW1sbVdsY01yRlYydzN2Y3k0aUlKRzd2S3MyRGJhNVo4YWk5Tmha?=
 =?utf-8?B?TTQ4Y3krU3NLVm1aNTJoa0QyWGRORkdWelc1MjZ4K3hibzhZSEF6dHVYNmNV?=
 =?utf-8?B?OGdWQlh1cnA4ODBudnF0aDNtdkFReml1SWo5NFQwVXhvUDFxVzR5MnFnS0dF?=
 =?utf-8?B?dUQ1bWVKSjlZTENxbC93Tlp6bWZGODg3bVBJVEdrRGtLSkNVZkJNS3hYSUt1?=
 =?utf-8?B?aFhPcklSZ0NBZ0tUTTRORlNaMkZJQ0tlRjEvME1LVnRQelgwTG1kODREckc3?=
 =?utf-8?B?WTBHQm1lT0MveW9CZWFxNWpRWEZzMjRaaHh3dUdBU3VKbzBaQVVHZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A844698E45F214D92D9887FBC164B46@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 038a5d8f-4092-4d99-de4d-08decdf73faa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 11:38:14.1742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qL0yFAbD/ZJqrMbJIsIUk25eZYCup+4hTpIc+ZVCtutX0oi37/QhZiUJ6vjXGR3EkWl9BASA7SpygO5kzDPh0cC33S/HMbBzq51dHA56D/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5261
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jun 2026 11:38:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23232

RGVhciBjaXAtdXNlcnMsCgphcyBwYXJ0IG9mIGVmZm9ydHMgdG8gcHJvdmlkZSBhIGhhcmRlbmVk
IGJhc2UgaW1hZ2UsIEkgbm90aWNlZCB0aGF0IHRoZQpzd3VwZGF0ZSBzdXJpY2F0dGEgbW9kdWxl
IGlzIHJ1bm5pbmcgYXMgcm9vdC4gSGVuY2UsIGNvbW11bmljYXRpb24gd2l0aApleHRlcm5hbCBw
YXJ0aWVzIChsaWtlIHRoZSBhcnRpZmFjdCBkb3dubG9hZCkgYW5kIHN0b3Jpbmcgb2YgdGhlIC5z
d3UKZmlsZSBhcmUgcGVyZm9ybWVkIGFzIHJvb3QgYXMgd2VsbC4gVGhpcyBzaWduaWZpY2FudGx5
IGluY3JlYXNlcyB0aGUKYXR0YWNrIHN1cmZhY2UsIGFuZCBtYWtlcyB1cyB2dWxuZXJhYmxlIHRv
IHBhdGggdHJhdmVyc2FsIGJ1Z3MsIGxpa2UKZml4ZWQgaW4gWzFdLgoKc3d1cGRhdGUgYWxyZWFk
eSBzdXBwb3J0cyB0byBzd2l0Y2ggdGhlIHVzZXIgb2YgdGhlIHN1cmljYXR0YSBkYW1lb24sCmhv
d2V2ZXIgdGhpcyBtdXN0IGJlIGRvbmUgdmlhIHRoZSBzaW5nbGUgZ2xvYmFsIGNvbmZpZyBmaWxl
ICh0aGVyZSBhcmUKbm8gQ0xJIG9wdGlvbnMpOgoKCnN1cmljYXR0YSA6CnsKICAgIHVzZXJpZCA9
IDY1NTM0OyAgIC8qICJub2JvZHkiICAgKi8KICAgIGdyb3VwaWQgPSA8Pz8+OyAgICAvKiAic3d1
cGRhdGUiICovCn07CgpXaGlsZSB0aGlzIHdvcmtzLCBpdCBpcyB0cmlja3kgdG8gaW1wb3NzaWJs
ZSB0byBpbnRlZ3JhdGUgaW4gQ0lQLCBhcyB3ZQpoYXZlIHRvIGtub3cgdGhlIGdpZCBvZiB0aGUg
c3d1cGRhdGUgZ3JvdXAgdXBmcm9udCAtIHdoaWNoIHdlIG5laXRoZXIKa25vdyBmb3IgZXhpc3Rp
bmcgZGVwbG95bWVudHMsIG5vciBkbyB3ZSBzZXQgaXQgaW4gbmV3IG9uZXMuIElmIHRoZQpncm91
cCBpcyBjcmVhdGVkIGJ5IHN5c3RlbWQgYXQgc2VydmljZSBpbnZvY2F0aW9uIHRpbWUsIHdlIGhh
dmUgbm8KY2hhbmNlIHRvIGtub3cgaXQgYXQgYWxsLgoKV2UgY291bGQgdXNlIGEgZ2VuZXJhdG9y
IHRvIGNyZWF0ZSBhIGRlcml2ZWQgY29uZmlnIGZpbGUgdGhhdCBpcyBwYXNzZWQKdG8gc3d1cGRh
dGUsIGJ1dCBldmVuIHRoYXQgd291bGQgbm90IGhlbHAgaW4gdGhlIHN5c3RlbWQtY3JlYXRlcy1n
cm91cApjYXNlLgoKSG93IGFyZSBvdGhlcnMgZG9pbmcgdGhpcz8gRG8gSSBtaXNzIHNvbWV0aGlu
ZyBoZXJlPyBJZiBub3QsIEknbQpwbGFubmluZyB0byBzZW5kIGEgcGF0Y2ggdG8gc3d1cGRhdGUg
dG8gYWxsb3cgcGFzc2luZyB0aGUgaWRzIGVpdGhlcgp2aWEgQ0xJICh3aGVyZSB3ZSBjYW4gdXNl
ICQoaWQgLWcgc3d1cGRhdGUpIGR1cmluZyBpbnZvY2F0aW9uKSwgb3IgYWRkCmFuIG9wdGlvbiB0
byB0byBhbGxvdyBzZXR0aW5nIHRoZSB1c2VyIC8gZ3JvdXAgYnkgbmFtZS4KClsxXSBodHRwczov
L2dyb3Vwcy5nb29nbGUuY29tL2cvc3d1cGRhdGUvYy9uTUVCUktqc29WRS9tL05lbTRvWVlmQndB
SgoKQmVzdCByZWdhcmRzLApGZWxpeCBNb2Vzc2JhdWVyCgotLSAKU2llbWVucyBBRwpMaW51eCBF
eHBlcnQgQ2VudGVyCkZyaWVkcmljaC1MdWR3aWctQmF1ZXItU3RyLiAzCjg1NzQ4IEdhcmNoaW5n
LCBHZXJtYW55Cgo=

