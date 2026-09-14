Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BE8C88E64
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 06:59:57 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14476.1789369188081550005
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Sep 2026 23:59:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=C31rI3iW;
 spf=pass (domain: siemens.com, ip: 52.101.72.13, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQtWJv4CJXqZBRT1mKSmwTgrOU++VjIMHmxLfwd4oCY4skIs5Hq7mEgzjrxdnTUpn1k1lk0ZkoizkhbDp7V7S3cJf6ReVY+4UD8YPKosyJu49YdNJDOfjSdK3Yp3LU+yIFLhxHQv6mAHrkPmIzcpLVcIfq1SZH5As/p8q4f3ULgYPGlMXrdeiFi6hFM8KteLnIbr2m1NSOyt18p24q4sk0gTaRyRM6y0hgKZKnKP1mvUFNHIhnhmJ2GV3xeFaexAFixHD8ZwONcYNtCQobcDHPhY+PhGnpXlsyyuh20mMb7DuHdhnv3cFzJXsTC/qblkGTvE5Id0FTLV34GUievwyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOEvphgrww6JTA9I53VlxKgAeSQTCP9Uy4yQwFFJ99M=;
 b=KU1HhtnvEVzu4AI4strRoI6+qCO3NfLs0v28gcnPPJEyludHzQNJoRmNX/71/ggI10x6mn3tmZy4KzhGqcfrzX/SwIfR56FvtKWs43MFirMoI7FRCz6TyjFrxyYycuBNFaiJt0uj50HpLlTVDVLrzzmRUm1e0s6jOtB/UxiqUR+DfFk04BalLniM9EqAtT1ino4ab08qWrtG01CgqYp6cbf5Y2DH2EGfrgmmipNMsUuyPv+ain8a9OM6xBxja5I8V7hNQdsqTzqgTGUG7aWtdncuZ4dOkbuNTZKHSF2nIG5I/caHIIi9Ko1zv9XUJFxpdsUzSXHdBx+7Jbx52u44kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOEvphgrww6JTA9I53VlxKgAeSQTCP9Uy4yQwFFJ99M=;
 b=C31rI3iWX8pZOsoKWm4olbdcFEoUECOEVNgY1yweQjo66UuwnOyOxfa8kDGAe0x+7wly+GVuWFOwIzhY2Q+kh1ZJz2SeO9vzlGsTyboETYTEzlCA7EW0ewSExYrztHH54QxyeKARh+A8hMDvIDFxLo/0PIQpgeAA6oSVLsbKX8Gv8WHlb2skbePqDwvftFfAsvhNOM7/nEcfuV9BhxXoWAop0TRREgNrH83Py5AXV+AiufQvz2KCM2wD1PfVRvHNP19xpMTGAFk1FBVzylrWLID5G1dQ/qJny0kcjlqstCyiuRQ/bxaUlOXk2r+T0gB7wvQHy6z8FLzgrzMPv9kvFA==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by MI9PR10MB992304.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 06:59:44 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 06:59:44 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: Sai Sree Kartheek Adivi <s-adivi@ti.com>, "Gylstorff, Quirin"
	<quirin.gylstorff@siemens.com>, "Heinisch, Alexander"
	<alexander.heinisch@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v2 1/7] secure-boot-efi-keys: Add
 recipe to create EFI certificates
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v2 1/7] secure-boot-efi-keys:
 Add recipe to create EFI certificates
Thread-Index: AQHdNW6IN7DeltmgKEaCyASn8Dv3jrbNwmKA
Date: Mon, 14 Sep 2026 06:59:43 +0000
Message-ID: <6f0cc5409fe4c6e5d1b8e8907c2ba2091ae90f8e.camel@siemens.com>
References: <cover.1787757655.git.jan.kiszka@siemens.com>
	 <121612bb4bd7cf2f08c83f39d439d7382f0667ee.1787757655.git.jan.kiszka@siemens.com>
In-Reply-To: 
 <121612bb4bd7cf2f08c83f39d439d7382f0667ee.1787757655.git.jan.kiszka@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|MI9PR10MB992304:EE_
x-ms-office365-filtering-correlation-id: 19c8e747-9b10-4b93-7d0f-08df122dc194
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|38070700021|6133799003|3023799007|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003|55112099003;
x-microsoft-antispam-message-info: 
 h5Yve6pqTUQsW+MvshBK0IT7oBs9mQhVrpNBKOGK10oa6/0bxW0yHwsgr3iIEaUt1btCB8UGrRtuqPCjijaAuVxMGsqYuLrSoMhz0gbZFEu2zLGKtV/QGPaep7j1SotTzzjDZori2lbUWGCcDyI6a2NOV2+QvxIZlzk60y+0QhAWmozilMyyPp3NkxgBh/IXY/0TIPZGtKBGLx9JRuhdqzzeZTRf2lzQ9QNzwZ8isnW5K2rQe3dMWN1oZ21Z8g0m3MDVuiSkhxyKoCRQiIFAaqPzSduMuJl08pBII4w0zPoqzJN6bpw0Aewz2RYkVh+8Xd1Jql+07Nl9HXqDnCjG2yVNLvvdVoc33pBwP7LdqBXf9lGM/s6/tMhxwwXPAJK1cpfu5Pf52mQRNL1VEYcrRue+YFanScqDRG44+nX8buQLWE0TJrxfKPKr97aXgiZ2OxerMCA0jAVOtV+0oah2AWlPvhrr3JEdh/8hLUGz3fV/XycsQohfR+VNUY7NospgLMa46Q3g5xATh7IwitlXp9looOwvna/O/8isukfJ8pRwwNLmYwA1b1B1NgejFobrQoevf27nlw7oQ0/QeLFeKoreIs93V8+11zm2ucF4sWz7cNrZhDPCWgX69BT8yU+ic9AUm3iR9EaAvcjpL1UN2ilTBFrP9deMiYZrC/HU8aQzNw0C4F84Lgt9B407sGIYvTsrbzX06PD1vKIJOnqv3VebxwmVE1u+lPYFZDIHGsw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(6133799003)(3023799007)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?M05tbVEvYThJbFBpZEk2Z3krVDhEc2JMMTMyRnBGUGp4cElVSUJuWFc0UlA0?=
 =?utf-8?B?NDFFR2Y4dlpValVKUW1ERzNsRWF6WU83cW1URHpzMXNIdm9NU1hnc0dubVVC?=
 =?utf-8?B?V0t5YUlJOFMxU01sZk1TVWtiTEE4b1RITGpmaHN4dEw3Z3ZOUGFwZXZYeEZM?=
 =?utf-8?B?MHp2MFcwTmNMZmtPMy80MEsrWkNRbU0vbjJ6V21kOXY4aEFkTGMvakQ1T0w4?=
 =?utf-8?B?N1dFcGswdlhxN3FpU0pFUVJyR0J1YnY4M0VxZ2dCWWp1aG84QTdWOU1GSCtX?=
 =?utf-8?B?N0EyZGVFN1cvL2J6NlVxNVNHU0FZU2hjWDkwWW1yQ3JGSFMzNnRvSHBlYkQ5?=
 =?utf-8?B?bU5kaUxwcVJvcWdRc1NNMjg3NVp3czVnRjVHWjhMcVlZMkJ3clRJKzZsTExG?=
 =?utf-8?B?ZUlIMU9PSmtLeHhQcUZZMDNqNE1aMXVsT1k3ZWZ5NiszKzd5emxLK09TR0JK?=
 =?utf-8?B?ZHJHLzJCa0pkNlFxWElLWFRYVUNnTUw4MGNpME91OVhJbU9KdkVoT0E5YWdn?=
 =?utf-8?B?cmdnNzlaajNnMUw2Y3lRNFB1SnMxVDdqNG5hTm5mQk9PbkxnVlpXcXh4RlNt?=
 =?utf-8?B?U0xBZ01FYXl1cEcyek9qdnhCLzlGOE0vaVhyTUtVRmpNN1RzbUx5eXNRSEk3?=
 =?utf-8?B?VVlzQkZsODVKWmZYNnhjcm9MN2krcStqUUJKdTR2MDZHSDVFOG1aNDBURlBS?=
 =?utf-8?B?RlNFTU1yZzlTSHNMQkdWTHFNbjJSeTBRZUlKZE9KQThVOW9FZHZUdGs4ck5t?=
 =?utf-8?B?L21rRVp1dy9rTmhlSjBqbnk3R3Yvb3VmNDNEMVViaHN2cTJWTkZndTlSNEs1?=
 =?utf-8?B?V3dHZE8yRVNhYmNFbXVvOHhtNU1aam50bXVpRDRvYXFReHkxVkRpdlBVcUUw?=
 =?utf-8?B?NUNjaU9ORUF3S0RyWEt1eVU2K3pMaVN3eHFQdVBUMUoyam80M0ZnWUdJb3oz?=
 =?utf-8?B?eGlEQ2h0VXVpcEtOVzRBUHNDeCt0N2J0K2VwK0VUU2k1K2NkN1N0LzRCc21n?=
 =?utf-8?B?SFoweEI3UGlxOHZvcXZiUEpTSjNKcm1rM2YxdUIyM25zZVF0OVBjLzBwYUxy?=
 =?utf-8?B?NEJSQmM0aXI1K2JYSkQ2NlJJK0JKcDZKM1RoZEtkKzF6dVp4UzRvNzFaTjV4?=
 =?utf-8?B?VSszZ3FqY2hCVWxWbWw1c0FhdU1ZN1Y5VHdOQVRXNHZEdkdJMUVBa25CSTRB?=
 =?utf-8?B?UjEzN0ZjdzAxa2lGWU9TUHlpcE5SVU1RclZiTDZMMkJFdEtzM3JwVWdyNmNL?=
 =?utf-8?B?MEk5WndoK2pmOC93eWVrN2wrRG9QdzQ0bHpkcmNwMWhyYVN3UTY5ZHcrQ29E?=
 =?utf-8?B?LzVlVHV5SDBPMjR1dHhncnNHQ1ExdUZlM1czandrRWlXUUdKb05FZFVaTzBN?=
 =?utf-8?B?QVVKbEVCQW9WQXYvYjgxTjVQeERuRk5hSkZDc055b2g0WU4rcHMyKzFxekxO?=
 =?utf-8?B?emcrcmlrN0ZWY3hrWlY4T1lFeXZ1MFNsTEFBbmoycjErT2dTSDIweEtwVjFK?=
 =?utf-8?B?UGllanFiYWw1VUhVeUZnd1hYSmpCQWJKaUFhWThMSk5XQ1pHM3UweWtWT3Y3?=
 =?utf-8?B?WGRlRjVnOFVZU0crLzRCeTlCRUZ1U2hsVXVybllIcDBERGpiRGtQelJvZXYw?=
 =?utf-8?B?eHpJV1ltcU9sZjA0ZVM3emtydzdVcFh2clpmb3RBMFZSVWdMTnZWYmtFT1Yz?=
 =?utf-8?B?Z0I4d3M3TTBYL0FpZ1hQdC8yaGVUb0toYWpLWFh6RXlmYmQwV1VydFQyZWRF?=
 =?utf-8?B?cEc4ZktYK2w3U3lybmNIQ3RERUNXQ0NsdC9xR05kZHQ4bFFkZXhVelBKdEt1?=
 =?utf-8?B?YlRFQmtjVk1TNVgvRjZSQ3l6dGtlWXY3MHJRYzZTRTMzTGUvUklGQmxDQW0v?=
 =?utf-8?B?dVU3clh2Wmg4bURpSmJwa3JwVDFKQTY3b0Y3OHVvaXQvcG9HOXNWZ0FrdHp6?=
 =?utf-8?B?alZYeVNkQSsvUmdiNnkzbTVPRDk0Sjh5Vml6emIwejZsZFBIZmhZTVRoeitL?=
 =?utf-8?B?ejdlTTNLbXIyd1Q5aFgxbFhsUUJUOFFrYmVuQ2gzeGRXeGY4ZGh5VGZPS1g1?=
 =?utf-8?B?NFhCd3VBWi80cFZnNERvRGpHeEx6NENnQ0hHVkQ1d2h5R2FYYTNRMENtamxC?=
 =?utf-8?B?NWJ5V2RqRzVGMGhPL3hpeFQwMEJkblhuN3huY3B4cGZ5UUFYWFUva2dCbHVK?=
 =?utf-8?B?UElVSDZldnh0ZlZ6am8zbnl6bktmaVhYYnRJQW4zbk9RSW1zb00zQWYyeTcy?=
 =?utf-8?B?eVBMV0JhQ0FLZjJEenZ6RjNUS2lxOFJVdnhWaFhRRmFNWjhEZVZhakdBWjlq?=
 =?utf-8?B?bU5EQjBiazNjN0xGVnBJVHpYam5JSk9qblNKTVBHRjEwT2IzTUp5Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D01529EBD2B03347A375518764C6F11C@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c8e747-9b10-4b93-7d0f-08df122dc194
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 06:59:44.0072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDqgAd785UH64w3ZfhG2ztXtekKmK4zr3B095w8lwUty3gBfldC/wCaz2vN6/DS+pJRMSrqhiX7zZiT4EMFyQaWsAtgmA5XRf9mVZu7+AuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR10MB992304
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Sep 2026 06:59:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24168

T24gV2VkLCAyMDI2LTA4LTI2IGF0IDE3OjIwICswMjAwLCBKYW4gS2lzemthIHZpYSBsaXN0cy5j
aXAtcHJvamVjdC5vcmcKd3JvdGU6Cj4gRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVt
ZW5zLmNvbT4KPiAKPiBUaGlzIHJlY2lwZSBhbGxvd3MgdG8gZGVyaXZlIHRoZSBQSywgS0VLIGFu
ZCBkYiB2YWx1ZXMgZnJvbSBhIHNpbmdsZQo+IHNpZ25pbmcga2V5IGFzIHdlIGFyZSB1c2luZyBm
b3IgZGVtb25zdHJhdGlvbi90ZXN0aW5nIHB1cnBvc2VzIGFuZAo+IHNpbXBsZSBzY2VuYXJpb3Mu
IFRoZSByZWNpcGUgcHJvdmlkZXMgYWJzdHJhY3QgInNlY3VyZS1ib290LWVmaS1jZXJ0cyIKPiB3
aGljaCBjb3VsZCBhbHNvIGJlIG9mZmVyZWQgYnkgYW4gYWx0ZXJuYXRpdmUgcmVjaXBlL3BhY2th
Z2UgdGhhdCBwaWNrcwo+IHVwIGRpZmZlcmVudGx5IGdlbmVyYXRlZCBjZXJ0aWZpY2F0ZXMgYW5k
L29yIGEgcHJvcGVyIGhpZXJhcmNoeS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKYW4gS2lzemthIDxq
YW4ua2lzemthQHNpZW1lbnMuY29tPgo+IC0tLQo+ICAuLi4vc2luZ2xlLWtleS10by1lZmktY2Vy
dHNfMC4xLmJiICAgICAgICAgICAgfCA0MSArKysrKysrKysrKysrKysrKysrCj4gIDEgZmlsZSBj
aGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCByZWNpcGVzLWRl
dnRvb2xzL3NlY3VyZS1ib290LWVmaS1jZXJ0cy9zaW5nbGUta2V5LXRvLWVmaS1jZXJ0c18wLjEu
YmIKPiAKPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1kZXZ0b29scy9zZWN1cmUtYm9vdC1lZmktY2Vy
dHMvc2luZ2xlLWtleS10by1lZmktY2VydHNfMC4xLmJiIGIvcmVjaXBlcy1kZXZ0b29scy9zZWN1
cmUtYm9vdC1lZmktY2VydHMvc2luZ2xlLWtleS10by1lZmktY2VydHNfMC4xLmJiCj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMC4uMDFkMjcwNDEKPiAtLS0gL2Rldi9udWxs
Cj4gKysrIGIvcmVjaXBlcy1kZXZ0b29scy9zZWN1cmUtYm9vdC1lZmktY2VydHMvc2luZ2xlLWtl
eS10by1lZmktY2VydHNfMC4xLmJiCj4gQEAgLTAsMCArMSw0MSBAQAo+ICsjCj4gKyMgQ0lQIENv
cmUsIGdlbmVyaWMgcHJvZmlsZQo+ICsjCj4gKyMgQ29weXJpZ2h0IChjKSBTaWVtZW5zIEFHLCAy
MDI2Cj4gKyMKPiArIyBBdXRob3JzOgo+ICsjICBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1l
bnMuY29tPgo+ICsjCj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1JVAo+ICsjCj4gKwo+
ICtpbmhlcml0IGRwa2cKCkhpLCBwbGVhc2UgZWl0aGVyIHVzZSBkcGtnLXJhdywgb3Igc2V0IERQ
S0dfQVJDSCA9ICJhbGwiLCBhcwp0aGlzIHBhY2thZ2UgZG9lcyBub3QgZGVwZW5kIG9uIHRoZSBh
cmNoaXRlY3R1cmUgb2YgdGhlIHRhcmdldC4KCkZlbGl4Cgo+ICsKPiArTUFJTlRBSU5FUiA9ICJj
aXAtZGV2IDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4iCj4gK0RFU0NSSVBUSU9OID0g
IkdlbmVyYXRlIEVGSSBjZXJ0aWZpY2F0ZXMgZnJvbSBzaW5nbGUgc2VjdXJlIGJvb3Qga2V5Igo+
ICsKPiArUFJPVklERVMgKz0gInNlY3VyZS1ib290LWVmaS1jZXJ0cyIKPiArREVCSUFOX1BST1ZJ
REVTID0gInNlY3VyZS1ib290LWVmaS1jZXJ0cyIKPiArCj4gK0RFUEVORFMgPSAic2VjdXJlLWJv
b3Qtc2VjcmV0cyIKPiArREVCSUFOX0JVSUxEX0RFUEVORFMgLj0gIiwgc2VjdXJlLWJvb3Qtc2Vj
cmV0cywgZWZpdG9vbHMiCj4gKwo+ICtkb19wcmVwYXJlX2J1aWxkKCkgewo+ICsgICAgZGViX2Rl
Ymlhbml6ZQo+ICsKPiArICAgIGNhdCA8PEVPRiA+ICR7U30vZGViaWFuLyR7QlBOfS5pbnN0YWxs
Cj4gK2RiLmF1dGggdXNyL3NoYXJlL3NlY3VyZS1ib290LWVmaS1jZXJ0cwo+ICtLRUsuYXV0aCB1
c3Ivc2hhcmUvc2VjdXJlLWJvb3QtZWZpLWNlcnRzCj4gK1BLLmF1dGggdXNyL3NoYXJlL3NlY3Vy
ZS1ib290LWVmaS1jZXJ0cwo+ICtFT0YKPiArCj4gKyAgICBjYXQgPDxFT0YgPj4gJHtTfS9kZWJp
YW4vcnVsZXMKPiArCj4gK292ZXJyaWRlX2RoX2F1dG9fYnVpbGQ6Cj4gKwljZXJ0LXRvLWVmaS1z
aWctbGlzdCAvdXNyL3NoYXJlL3NlY3VyZS1ib290LXNlY3JldHMvc2VjdXJlLWJvb3QucGVtIFBL
LmVzbAo+ICsJc2lnbi1lZmktc2lnLWxpc3QgLWsgL3Vzci9zaGFyZS9zZWN1cmUtYm9vdC1zZWNy
ZXRzL3NlY3VyZS1ib290LmtleSBcCj4gKwkgICAgLWMgL3Vzci9zaGFyZS9zZWN1cmUtYm9vdC1z
ZWNyZXRzL3NlY3VyZS1ib290LnBlbSBQSyBQSy5lc2wgUEsuYXV0aAo+ICsJY3AgUEsuYXV0aCBL
RUsuYXV0aAo+ICsJY3AgUEsuYXV0aCBkYi5hdXRoCj4gK0VPRgo+ICt9Cj4gLS0gCj4gMi40Ny4z
Cg==

