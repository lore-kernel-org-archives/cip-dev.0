Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C073EC982FA
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 11:20:08 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4808.1790162400713331231
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Sep 2026 04:20:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ntT9+Cni;
 spf=pass (domain: siemens.com, ip: 52.101.70.41, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mK95YG58gIimUIVQgHHUr66ak+SfoapaybxggXdEa9cJP/HUMbojjOEkfha8b5tUhJoVNoQF3rqYPuwwxW6BRasX0I+84ie4tMVKOBK3KyWzvTpB/UcPrYk77jeL8ZjCpHH/Ydt75/MkTlpUMpDEpwe/T+zW5ajPp95LPCXfrMs9gpCVIuWIuNjq6p36gub7LCFdpedBXJq/3jfJDfji9T7NYf9o4H4+hNeytIwgJNo6rD2IYOOvK8lDEHYbvRsjdXjG0bSpjfshKDHiPP7XxkHzobFSUcolVwrGl5qKhKhi9Iu1kiQwf8NOPjWKiLJtYg2VvreHO10R4eQHuoaOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azfu42ER5AxW7rP+UP31K/jN1Q7JSjZuO8NhgEx5skI=;
 b=YqHcq8AXoDOhdTQKeHSlLXO29k5S8MYdCDhUXmPmUrVQjHC/oUYqxXEIpQ10ygXtTT8od+8oCOsfVzNRk73l5+8yospRnOZlCfD8cMomHlfMF+rR2qpxG+RR9EeLIPzcDV5wDKHIS5M19H/cJaWxVyDvbp9xDjVvAtTdAoNo6ulnhZypO5QOJzpLCMZwobkqAdYTAeN+Ez0kv8kDZr9rixf6opjwzvv5kzTH/az9+HMC55ENXn6LN7Kdb9/fTB91c7vhRgGIEWGdWX1h+1XL7f+QDngHp+VYBCkTN2V4buljjcF9HUx4yU4TBUxVdWBW6lDH4c/i0eQtW73B4ptJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azfu42ER5AxW7rP+UP31K/jN1Q7JSjZuO8NhgEx5skI=;
 b=ntT9+CnibdWCc8QmGCbESdzBoSZ1Ep6SqbWyNMWyXMQTSed+PGtcfl9eBuOsQneX4Py/SQAygCT7mBpLNo7L2Gopu6SIpAEJ4kpib03XEsVDGlvdMKA/yte1T3qmySQdL/UL6BFJqeviIX+/j22IqxkMuw7oP336bTT9dpWh6xngnVxmsGpZAXlZCk8NDVBT2DZYr94ZNd/1PfUHbHQf6k+zHAlvVMvhIAPI+5yKFSMlrSLCOGyCIIIxSEFVXZoMycGizaOPXaDhYG3TCWfLsmNPGJXCivwfEweOgoPydtm/brMw/MaVJVogr9r39FzIeMevwzm2KKvKOgdffc9t9w==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by GV1PR10MB6123.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 11:19:56 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 11:19:55 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "Shivanand.Kunijadar@toshiba-tsip.com"
	<Shivanand.Kunijadar@toshiba-tsip.com>, "kazuhiro.hayashi.f74@mail.toshiba"
	<kazuhiro.hayashi.f74@mail.toshiba>, "kumar.dinesh.h95@mail.toshiba"
	<kumar.dinesh.h95@mail.toshiba>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v2.2 2/2] Fix file timestamps are
 not reproducible for EFI certificates
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v2.2 2/2] Fix file timestamps
 are not reproducible for EFI certificates
Thread-Index: AQHdSqG5qQUWcSmo0ECdF+ur9MFV5rba4xEAgAEh34CAAAC3gA==
Date: Wed, 23 Sep 2026 11:19:55 +0000
Message-ID: <c23d1f7314691cec28ccb7e6c431ec8f7f04af2c.camel@siemens.com>
References: <20260922145022.167894-1-felix.moessbauer@siemens.com>
		 <20260922145022.167894-2-felix.moessbauer@siemens.com>
		 <0a6317c3-cf7f-4ba8-824f-b6e806f79d70@siemens.com>
	 <18D7EF142A312622.2356414@lists.cip-project.org>
In-Reply-To: <18D7EF142A312622.2356414@lists.cip-project.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|GV1PR10MB6123:EE_
x-ms-office365-filtering-correlation-id: 81f01d53-4485-4d7d-9daa-08df196498ae
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|11063799006|4143699003|38070700021|6133799003|55112099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 DiO7xV+slGUW4Kll7RLhNKimvTwJRvWX9PRdKiuWfeLttRGrVkGlXDsyQ69yGLNwgSXTr1OO5/FPWOH8uxFxThxGggDHje/1VH37UGgwYH3lzalskRFhe23+8xIyLF5LaggqXG26qgOi7h5aevIj+yJ3u7d3k5XhpYCC20RYkbqSC3ZqvqHOtGlCHfnCewiIyzcJWe2IWITCoNNXWLo3OySElyr2/WdfrYeOmMqq8R4n0lq7qdziEtPdiIdGthSpXho+YIE1Hdi1YeKLKoxZQAZ2GXqtQRGQuxFKOuz867zmv3JJJD+1QjH3/gtPSDbioah+E/2jYjtUCLf/hND0iJUiJeei+DvcZHQqBBXk16JqxfTcJ2DbkAXT6Z51+xzmBgU4s7NZSPKg4sJAmYjoSdTmL/R+1a3VGIEj5zT2GZh4fd/PVbbkU0fZOcchksrOtLKHUlnoXavFBhiBNKSb04WJd14Jei3goZuulALudsb5i5TIhvI/5aiRjMb8AcCgXEZzhqBT4cDuw4Rx7FNR5WIVo1zgV/BYTE63+6iWRcoIKmtX8IUsUQPvGwFpaKsRNNyVNQl8bKVwGvsyiWqZpjKUYtQmmrHVB3NxShzIEzAd1HPWuWULSzZ+9SMIYYrpgyM4wnJZN/WWSr1QCL3umCSPSW3V1rxIcMTE8F2dNlE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(38070700021)(6133799003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cGpTRDBMdm1aUmlYM2dMRGxVSnZOU0FSbnJuM3IvTlpoZjMvemVYa2NsNVB1?=
 =?utf-8?B?MGswLzVnWUdrSVg4WFFvS0VGa2VtU3V6ZW9SVGs0Zk1uRWk3OEtGKzh0Mm85?=
 =?utf-8?B?L1hBRG93bmtZNDQvdHB4M3AvdnhIU2VzVk1YUTlsQ0o4UGk2eFNjQjFvVHVC?=
 =?utf-8?B?TU1jQmtPaGQ1V0tpMURSYkpCRkhWNUN1TW56c2ZlczRPOUdjZjRJbXlUR3NP?=
 =?utf-8?B?RE94Y1hnUWhjZURBZnBocnFYL1djVEFDRVpRYTRxdXlXUFhOdzFWdkhQaS91?=
 =?utf-8?B?TFJZMmN0RDh4UHdONGttMjBDVms0K1dXcmR1VzJMeVFjVFhxQjd0cXBjTFhj?=
 =?utf-8?B?SnFSY2dpbWlMclFScm5mZ3JnenRtTzhmblJNMTVOdGQ5ZjgzWFgwZUJaZWZU?=
 =?utf-8?B?MmJqb0tiNDd3eGtwQ3h2eVJ0aElMcWw3cXJpM2M3dUNpb0lhaG1xRE9oSWpx?=
 =?utf-8?B?VURsUHhRY2hNelB5YlNNV1FYWHluVldLeE5iN3VEbGZUclk4L08wOS9GY20y?=
 =?utf-8?B?RkExMVlha0crK3ZocTJwSmIxWURZMEhQYzhjbmhWaW5xd29KVTlWNm9XMGdI?=
 =?utf-8?B?NDJkR0RBbnN0SWY1NWtpcTdaUi9NSHYyUzdDL0lySHl6blIrQWorVEtyQ1VU?=
 =?utf-8?B?d0trY2Vlck9ndThOU1VBTWxxZUprejl0QStST2JVQ1pGMkNWR2VoK2NRaWk3?=
 =?utf-8?B?S1E3d3BsZUdMNFVnSkd0STN6UFlQQitUWWE2dkc5cEtzUXFKNk5yaEhVNllI?=
 =?utf-8?B?aUhoUUd1RGNFU2pzMHg1VkVzcXduWkNsc2xXL25mSmZ3V2QvK1hqcE1zSDNT?=
 =?utf-8?B?K1UrZC8wTmJUMGFoRzZydWNmNW1sU1dsN0p3SWtBdnVaMmQ1T3k1V0paT3Zu?=
 =?utf-8?B?Y0FIMjYyQ0NmUDNzbmtsZExmUytYWWZWS3kxMkYvWWNURGJUNVlvbi8rLzlN?=
 =?utf-8?B?Y1Jqd3kzbUhzbWtUYWlmZ1BGUUYxQnNoemo1TlJSOThaTGoxckFPZGM0MEth?=
 =?utf-8?B?RzVacFNnWnVXM3k5dC9qL0pqT200U1FPQ3JGSStXM1dtTzlpd3krMlZicm1U?=
 =?utf-8?B?NGx0dnc0b2toZmRLa3JDZkhJdXZRT09DbGtzNmZqV2ZzZ21KREZ6bW9ZVUxM?=
 =?utf-8?B?Mnh6SVFHd1JqNW54OVN0dUY2QVJMb0NmUnBOZ1Btamx4YkpSTHBRWDN2bEZC?=
 =?utf-8?B?b1VGVGZRcmNkd1ZsRnN0ZnViR2QwTXhNSnFSb1h4emU5bWt5WnRaSXRJdGVh?=
 =?utf-8?B?V013dy9zOElXL2xMY2FYaXFuY21IK2NQSjhnbXYwUlcxdHVGcGlQRFdrZEhu?=
 =?utf-8?B?bjRCY0UvWlM1enhycC9PV3d3bnkyd1pyL1hURVIwQndLUUZaUXNVdEFnQXI1?=
 =?utf-8?B?dmk3OVZyUDdJLzFDbDBDa01IZmpMY0llQlpCTGh2Q2I2VjZtY204bjB4STEz?=
 =?utf-8?B?NlpnNmlIbXh6Q0dhYzZZdVpEWk9rT0tBYS9wL2M3UVJZbDNCelFsWGxoSVM2?=
 =?utf-8?B?WG1yZEJ1dytVbFNPSkdKRVlheDd2SjlYTVQ2SEF4TmVqMHRMNmpnMFhyWkZS?=
 =?utf-8?B?dnJPK3IzamhBUUVZQXlVTEs0NXJqc25nbzdNaExHeGkwM3hQYkxrTjYyR2Vy?=
 =?utf-8?B?S0VqQjk1a3VaU1FyY00rK2lzUGVETU9DRXk3S0wreHdOYXNrRWlHNGxxNWVv?=
 =?utf-8?B?WXRqK2R0SUtFYk9xNlpIMXExNkRqV1RUSnA3MGREMm1LNkRXaW96a253M2N1?=
 =?utf-8?B?UWhZOGZuVjA4L0J2VThwcHA4VEgvUnZxV1VXa05JL201dUZjQUNZMlpyQklT?=
 =?utf-8?B?TG8ydCtyaXlJWk9rK0h1TDY3RkRwUGlFSzV3ZzduNWlqaXdtY0VzTUlpNmtP?=
 =?utf-8?B?cXpFZGI4Y1h0TG0vUXg2UkhhU1FmK1lQcnA0OElBYytjdllLOGNRdHBhNk94?=
 =?utf-8?B?NloveTJWOXB5NzNEU0Rkbjk2YVVjUjRpWUEzM0I0MjhCbzg0MVgrVjNtbTJI?=
 =?utf-8?B?clRmRW85SVNQbEwyaFpYTFZGUTFhV1NUczFzeW02dFBVbFVUYzl2a3gzNktk?=
 =?utf-8?B?T1R2Ry9oeWM5WHBWVjBXQkxoNHF5ZkdKOE94REY0QnpxeFVnVnduRytBU0JN?=
 =?utf-8?B?MnE1QTVhTGErYW5wQmZ0d1BoN0xsNGxvV3ZIZDQ1NXUvU1piYW5iNVZrMTJn?=
 =?utf-8?B?cXJTMWtYUW5sVnhjK1pBWjdPcjNJNkNmNzV6RHcyYWhwSnBlSStLSWtyRFhM?=
 =?utf-8?B?MzkvVGtNemZUeitIYzZHME9EV255UElsSG9abjVuSlpEVmx4QUVGbnRoNHRE?=
 =?utf-8?B?VnpyVndmZlNDZ1ZoR0oxak5TbDJhaC9McGFMMGxrWmxUcmprUUpnZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9E9B674A2BE314FB19CF52C6A9A323C@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f01d53-4485-4d7d-9daa-08df196498ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 11:19:55.8669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RCxyR2xP53aGgYLrGc6v4Iiynq7ewsY0ohvIbJpIkzSNCNBguYyR/fbpL/rWG0I9mnCZ7Lxo0lsMmtXX/2XTLZf+XIjkNAf/vRTPD5CPUDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6123
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Sep 2026 11:20:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24274

T24gV2VkLCAyMDI2LTA5LTIzIGF0IDExOjE3ICswMDAwLCBGZWxpeCBNb2Vzc2JhdWVyIHZpYSBs
aXN0cy5jaXAtCnByb2plY3Qub3JnIHdyb3RlOgo+IE9uIFR1ZSwgMjAyNi0wOS0yMiBhdCAxOTo1
OSArMDIwMCwgSmFuIEtpc3prYSB3cm90ZToKPiA+IE9uIDIyLjA5LjI2IDE2OjUwLCBGZWxpeCBN
b2Vzc2JhdWVyIHdyb3RlOgo+ID4gPiBGcm9tOiBTaGl2YW5hbmQgS3VuaWphZGFyIDxTaGl2YW5h
bmQuS3VuaWphZGFyQHRvc2hpYmEtdHNpcC5jb20+Cj4gPiA+IAo+ID4gPiBDbG9zZXMgaHR0cHM6
Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS93b3JrX2l0
ZW1zLzE2Mgo+ID4gPiAKPiA+ID4gW0ZlbGl4OiBsZXQgZGNoIHRpbWVzdGFtcCBkZXBlbmQgb24g
U0RFLCBwaW4gdGltZXpvbmUgdG8gVVRDIHdoZW4KPiA+ID4gc2lnbmluZywgcGFzcyB0aW1lc3Rh
bXAgaW4gY29ycmVjdCBmb3JtYXQgdG8gc2lnbi1lZmktc2lnLWxpc3RdCj4gPiA+IAo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBTaGl2YW5hbmQgS3VuaWphZGFyIDxTaGl2YW5hbmQuS3VuaWphZGFyQHRv
c2hpYmEtdHNpcC5jb20+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IE1vZXNzYmF1ZXIgPGZl
bGl4Lm1vZXNzYmF1ZXJAc2llbWVucy5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgLi4uL3NlY3VyZS1i
b290LWVmaS1jZXJ0cy9zaW5nbGUta2V5LXRvLWVmaS1jZXJ0c18wLjEuYmIgICAgICAgIHwgMiAr
Kwo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+ID4gPiAKPiA+ID4gZGlm
ZiAtLWdpdCBhL3JlY2lwZXMtZGV2dG9vbHMvc2VjdXJlLWJvb3QtZWZpLWNlcnRzL3NpbmdsZS1r
ZXktdG8tZWZpLWNlcnRzXzAuMS5iYiBiL3JlY2lwZXMtZGV2dG9vbHMvc2VjdXJlLWJvb3QtZWZp
LWNlcnRzL3NpbmdsZS1rZXktdG8tZWZpLWNlcnRzXzAuMS5iYgo+ID4gPiBpbmRleCBiMTRkNmNj
Li5kZmIwZmY5IDEwMDY0NAo+ID4gPiAtLS0gYS9yZWNpcGVzLWRldnRvb2xzL3NlY3VyZS1ib290
LWVmaS1jZXJ0cy9zaW5nbGUta2V5LXRvLWVmaS1jZXJ0c18wLjEuYmIKPiA+ID4gKysrIGIvcmVj
aXBlcy1kZXZ0b29scy9zZWN1cmUtYm9vdC1lZmktY2VydHMvc2luZ2xlLWtleS10by1lZmktY2Vy
dHNfMC4xLmJiCj4gPiA+IEBAIC0yOCw2ICsyOCw4IEBAIFNFQ1VSRV9CT09UX1RJTUVTVEFNUCA9
ICIke0B0aW1lLnN0cmZ0aW1lKCclWS0lbS0lZCAlSDolTTolUycsIHRpbWUuZ210aW1lKGludChk
Cj4gPiA+ICAKPiA+ID4gIERQS0dfQVJDSCA9ICJhbGwiCj4gPiA+ICAKPiA+ID4gK2luaGVyaXQg
c2VjdXJlLWJvb3QtdGltZXN0YW1wCj4gPiA+ICsKPiA+ID4gIGRvX3ByZXBhcmVfYnVpbGQoKSB7
Cj4gPiA+ICAgICAgYmJub3RlICJVc2UgdGltZXN0YW1wICR7U0VDVVJFX0JPT1RfVElNRVNUQU1Q
fSBVVEMgZm9yIHNpZ25pbmcgRUZJIGNlcnRpZmljYXRlcyIKPiA+ID4gICAgICBkZWJfZGViaWFu
aXplCj4gPiAKPiA+IE5vdyB3ZSB3aWxsIGhhdmUgdGhlIG5vdGUgaXNzdWVkIHR3aWNlLCBubz/C
oAo+ID4gCj4gCj4gWWVzLCBidXQgYXMgdGhpcyBtZXNzYWdlIGlzIHByb3ZpZGVkIGJ5IHRoZSBj
bGFzcywgdGhlIGFjdHVhbCB2YWx1ZXMKPiBjb3VsZCBiZSBkaWZmZXJlbnQgKGluIGNhc2UgYSBy
ZWNpcGUgZXhwbGljaXRseSBzZXRzIHRoZSBTREUpLiBBbnl3YXlzLAo+IEknbGwganVzdCBkcm9w
IHRoZSBtZXNzYWdlLgoKT3VjaC4uLiBub3cgSSBnb3Qgd2hhdCB5b3UgbWVhbnQuIFRoYXQncyBh
IHJlYmFzZSBpc3N1ZS4gV2lsbCBmaXggaXQgaW4KdGhlIHYzLgoKRmVsaXgKCj4gCj4gPiBBbHNv
LCBTRUNVUkVfQk9PVF9USU1FU1RBTVAKPiA+IGlzIGNhbGN1bGF0ZWQgcmVkdW5kYW50bHkuCj4g
Cj4gWWVzLCBzYW1lIGFyZ3VtZW50IGFuZCBpdCBpcyBjaGVhcC4gSSdsbCBrZWVwIGl0Lgo+IAo+
ID4gCj4gPiBQbGVhc2Ugc3VibWl0IGEgdjMgc2VyaWVzIHdoaWNoIGFjdHVhbGx5IHJlcGxhY2Vz
IHRoZSBwYXRjaCBJIGFscmVhZHkKPiA+IG1lcmdlZC4KPiAKPiBPay4KPiAKPiBGZWxpeAo+IAo+
ID4gCj4gPiBKYW4KPiA+IAo+ID4gLS0gCj4gPiBTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVj
aG5vbG9naWVzCj4gPiBMaW51eCBFeHBlcnQgQ2VudGVyCg==

