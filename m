Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2788C5478C
	for <webhook@archiver.kernel.org>; Mon,  4 Mar 2024 13:39:19 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.69])
 by mx.groups.io with SMTP id smtpd.web11.98433.1709559532416398129
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Mar 2024 05:38:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=PX4yTcxk;
 spf=pass (domain: siemens.com, ip: 40.107.20.69, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecYXJz4b6z28uUeIB5li+dw4yik0pOEoqkEKQeMiAN0Q4UMHMFgnED6ImYkFN5Tlll0PBfasY7qql7aimc8Lu4iJIHrMAIQkaNXb48O5g+LIHZRuE471kR0f9jGE/ikMbEPk+8Kylr1GBuAC04pf0tHXRgKP+SOWsXbb+3y5nX2RX1qW+HZN5U8X4ZZZNhkMVg2iEz/h5uC2sfemgVWSghDcAYS1jmmOSAbnyg8elZfX3XWuGO1v/NRpSzBBt4nVUxRzVqbItybGruL5j7VVni9gKtdu6RghMI/FrDuDAWuzoMZR7n3h9Xbt878KaqjD7I0m7gmnCC2uiVFAVaDSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRasZp49SoyBh4A2MAQ5zk5i2L4AP3LsveQ9YjV1OpM=;
 b=HiB/5/eFVez4Iw7MAdpHFALgfFBOQ4TJOq6CcMVTcoEDOdTiBaMwmpnBe3/YSbKfonzHYQz2e8JXtedHdi0N/E2rXCBrF7BnOXEAvSFz1dvOsR8wKXwis1YTbrlcigdPif0Koqonydgeg/n0sxGL2qVqZwlPDt138/SS3C//zp8rSW73bzMQXnlMIxvd9WNToFgV3b4CP/1a5hv72isqV04wJFMBE+gRUvkKlLUD9HPEM3G2F1agJHkFW/T2dlwCjCR/X+fMziBoaJiSLcrmwCCpAUQ6fWTkQeCO0mUHjEbLDdTS/7tK3KXmT9bw/+Llv7BLMEqdL0tMhzmY2Z2bqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRasZp49SoyBh4A2MAQ5zk5i2L4AP3LsveQ9YjV1OpM=;
 b=PX4yTcxkb9M8URDrBQJBT/JxRwz0xXpWkGeXiu3OEkoE4aJROf/+70c4PZsULXcK6QVAzlC/1QxsOJPyYo5DDz6EXJHfCcoTE02efWZx+KxvgGseCK30suOAPEIehvDL5SymSWPe1lDl+7L/EFF6GfKNNnontzAzKmjnlh7ottke66enCUAfIpvORJ2pK9FoV5muDkWTMW6DYbNTX6XGpZILlT5T/NLAycVnLL+0mAETiQMwfZ8EEjQh1ORhqSgeG9K8rfiwnuKlTcXCpexALHxMn/sUft9gCcKQkWcoe0ogKsTqCkv6Sz6wbaISm4nSbqdOr49A0IsPG8115CySjA==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AS2PR10MB7981.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:559::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 13:38:49 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e0b3:537d:ebe2:c0a3]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e0b3:537d:ebe2:c0a3%4]) with mapi id 15.20.7316.039; Mon, 4 Mar 2024
 13:38:49 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/4] sign-swu-cms: check if key and cert are valid
Thread-Topic: [cip-dev][isar-cip-core][PATCH 2/4] sign-swu-cms: check if key
 and cert are valid
Thread-Index: AQHabhxAOylPHxybxUacxw5qn3GM+LEnllkA
Date: Mon, 4 Mar 2024 13:38:49 +0000
Message-ID: <4e1380b9ad7829e2d4376a4d4a793fa1416fceb2.camel@siemens.com>
References: <20240304101054.864948-1-Quirin.Gylstorff@siemens.com>
	 <20240304101054.864948-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240304101054.864948-3-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AS2PR10MB7981:EE_
x-ms-office365-filtering-correlation-id: 345ab5f1-2054-4a27-0a95-08dc3c506c4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 qsM7bXGHyTq9vwvpRSKHDHTmG5I85IDn9OwWX2XyNZomemUin4GUshnqLZRj5zv6eYr/zB05FcvjvP5tDmJK8f2gzFuLpTQ2OyViyKsICuzyTt1L9gDvRuxXRYtJzfLF2vWnJac5trNs26nNVkxmsGk0Cl5ZVx7uytuDr3ql6/rDqj6RzrUj7LNGY3UAVWPW8ILIBM1EdJdHfk6UryETqxj8TiY9zzpW6rBVza0H4CEIVz91Lw6UCvrmrKeraKh1Z4QdA2cI3Yajz2Dy6LxKw36q/8CzOg+GAenU1ZN65V65x5C4ZvfMCWCp6r1G3TQYPaD7XoWus2nCKoSjvf7xbGOZ3ry9OspBaihKHCCQUJfCPSM+HdDuXTa5NITLt2VjEdtyO723EaDa4Vrc20d8bAiM3+KMZVJI155XFcnw/nn3Y1CDzqmOvMa9B9+Om/bUTe9k46gr5IlfvqeTReF1kRTFP0ay4bu4JdbnMSUAC0A47FerVp7I+8wtxyzXXZYC8nRH9S8OphYhThc6H0PaUvn69Uerm13CGqmBbEsTq2P6XEK5EPcCVbwJVnwvMUBWmrWkGnKUTY7TM5Nh1CVZpdnQqu4DMKrbttlP7ZB8WCf2YoAVQk2UWhByKO4XXIxco0xg1ZhSwAIIOmg/wBb6b51C3uN7pew2BOAm+3FmyyNQkpwMLBojhcjw6snEHhg0mhq2R3GchihLNw0fC8VBUSabjbYhw8A2M7YlhnVGXUE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QkNUTExIVi9aRTlqbTlNNUtXdUM2bFg5SzZYMnJwVTdBYVVsTEt3WUFCWkpj?=
 =?utf-8?B?N240YU1IV2drZ3BaWWZSc0dSYTcrUDBQSkFGTVVSSTI2Z1hHRTVDSk4yYklt?=
 =?utf-8?B?V3lFTFBWdnI0enZ0ekhVeDdZNXIrVXFNbWlMTXAxM3R4UXhBN2prUGloTlhj?=
 =?utf-8?B?VmdZeHoyRFIxaktCRUl6VmJFRGVudTJzelVnT3RPdnIrTTdnTjhDVkJreUNY?=
 =?utf-8?B?Vlp6aWdwRGh5SDQzVFpTSXZucnFZQUp0cFprYVZpb2dUWW9WeWhSc2dUenJM?=
 =?utf-8?B?UG83YnRXb0NSYksycm5XZFQ2NzNMTExWaW9NN2g1RkRQTENaMnZGNHd5UWF6?=
 =?utf-8?B?SUZDWEMyOXhjUWorbTZuV1Q5YjYrZFVQWFloQUxnQzNucnFwZWg2Ky9tU1Er?=
 =?utf-8?B?UUlzZm1FUFlhZTNYN3BGSnJZUlZ0UVNnQ1JBUWdhK051N3lEdzViV24yWDVB?=
 =?utf-8?B?Zm1xd3g1U0hoQ285b1Nwell4SVRhMkw0VldiN2FmeW14STl4T1BXTTZYUTU5?=
 =?utf-8?B?c3QwQTYzNmJ1UmNYTklzRnI1aTlFck02VUcvYmJTU0dJY204MkxXcXRQWmhk?=
 =?utf-8?B?SnIxR25tL1ZhcCtYTTV0SDAyVU9TUFpxb1N1ZXlueUI5SWczSGdhUkFIRGhS?=
 =?utf-8?B?VDFZTWtHUDgrR1VZdjJreW9FM3pWQkY1TzV2WTN3eVZPdXJNblhZYzlaN0Rr?=
 =?utf-8?B?aEVpSEl6cHdna3NzMkxoTWVTcURqalROeG1qR0NybkdEM3hRenZvMWZjMDZI?=
 =?utf-8?B?T2xsVCtzeWVUWlIrYW5yWWNuU0w0eEY0YWNCMy9vUHV3K3NGMmIwYXh2aW1L?=
 =?utf-8?B?alQreXF5cUdUZVZ0anZ6OWtqNi9JSlZmZ2hPdVZoQjNZNUZ4WDN4ekRBWXc0?=
 =?utf-8?B?ZDIwNExhdjZvQ0xOZjI3UTJPbHVUakJFKzU2TkpBaFZMSDMvaTVvNS95aUps?=
 =?utf-8?B?dTlndS9mZ282OUtrVVJValpyd01rRnZac1RzZS9maEhaNUp1UThFbVZoenhR?=
 =?utf-8?B?cTlvbm1RbE9meEJWWm5EZkNWMnkybDdrUlBVRGJJcHdLMk9CS2k1M3RsUlkx?=
 =?utf-8?B?Qk9HMm16UU5GV29vWVp0bmZYOHc3NkVyd0ExMVkyckZzNHpBeTdLMUl4cFNp?=
 =?utf-8?B?dW9tNTNGeXFrSE92WGt2dXY2Z3hqZ3c4L2dGeUNXdVQxdjBHME5ZYy9WRnlr?=
 =?utf-8?B?NzRZbzcvc1VYZU11dm5DMThIaVlXNU9DSmo1ejZKWEEreDNTQzhKOUFQdnE4?=
 =?utf-8?B?RlFpWUZzZmpPNFR1MVBRQ090U1lMQXJwNlpEYXd5cHRHeDNUMkJSK3IrR1Ri?=
 =?utf-8?B?bFNKTG4vVnBDcFgwNHNnbTZoNEhZeDAwSDVOU3RRYnlQUUc5UDR3NHIzUWFV?=
 =?utf-8?B?T080V2QvMHo1TWNRS0oyc282V0cxSzU2TWlLZTd6TEsvaG15TUxhK3ZnVitX?=
 =?utf-8?B?YjZGQkxUSTlyMFc4RXVTWDFFNmc1UW96VjltTkxXT3VBT1RCTmdMQlVxbksz?=
 =?utf-8?B?SStReDlhN2xFL3hoYXEvN3dxOTNXN3p0djNGZkg4cFJTVUt3RDBSTTU3RFAz?=
 =?utf-8?B?WjBJZmxweDUyMFI4WG5DLzY1ZGorbE1COGExS3ZKZEJXWTBwQVYvWnhRdDlt?=
 =?utf-8?B?SUxNSVhnblZyUFdPM1k5VDJYMzFLUDk4Z0V0NjJXRDR2Rm8vTUV2bldtWFhV?=
 =?utf-8?B?WFNWZ1R2d2VOWHpvazkzNFJsVVZ3OGVmbWg4cEdaZG5hQ2ZvbHpZS1JBb2Q5?=
 =?utf-8?B?WkFWNlFjbHZrQS9KMjduTmRYYUMvTHAydlBBRkRjeXVoUmFkNnBCSGpLT3Vy?=
 =?utf-8?B?Z0ZneXZ2dVJ6MzJjbjB6RFZkdzNwcmxyOVIwZi9QLzlDMzN6dGY4WHZOSkx4?=
 =?utf-8?B?YmJlamRqQ2Z3QVpibmJhbHA0dWxZZlFOZlhOcUJpSXVLMitJMjNyS3FtTzJH?=
 =?utf-8?B?SlgxYmlmSlhFUHhYSDdvTUV4YWM3d0Q5K0YyblZYQ2FoeVRTalgrR0ZvSi9p?=
 =?utf-8?B?Y0xBb2xnN0FPUmExcXNoTnRoOHVMZTFFdmZFaXpGdEhIa25KZEQvYjhBa2Vt?=
 =?utf-8?B?T09EbnRhTUEzdDhKK2pLSXZOV1dkY2wzY01yYjA5ZDh5b0VZQjNRNFJqekhE?=
 =?utf-8?B?UkpOSSs4MGQ1SDlHVGRyZ2Q2UWlyMEljTTNkVVNaQlU0dlE5cnJ5WksvcExn?=
 =?utf-8?B?ZEkxZ29ha3hQYmQ4Qm5UUHJNS3RBKzQ2ODk5VHpYYVlGeWZ5ZmJ6ZWFwU0xi?=
 =?utf-8?B?T1pXWXgxcm00Q2Q2SUpuWTZNYlFnPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 345ab5f1-2054-4a27-0a95-08dc3c506c4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 13:38:49.1640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aXfg/B/0b0aG+xVAaEpNGBthcoMTU0YsiC7R/NkQf4cGePrK3oxavIhfGaYcUVAjHDQL6+YubGHLBiYh8McUZRagxXSzw6neNDJh06Clfqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7981
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C7E16A5D6386E49817C726D84BFEE8D@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Mar 2024 13:39:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15195

T24gTW9uLCAyMDI0LTAzLTA0IGF0IDExOjA4ICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhpcyBhdm9pZHMgYSBicm9rZW4gdXBkYXRlIGJpbmFyeS4NCg0KVGhhbmtzIQ0K
DQpUZXN0ZWQtYnk6IEZlbGl4IE1vZXNzYmF1ZXIgPGZlbGl4Lm1vZXNzYmF1ZXJAc2llbWVucy5j
b20+DQoNCkZlbGl4DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFF1aXJpbiBHeWxzdG9yZmYgPHF1
aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+DQo+IC0tLQ0KPiDCoC4uLi9zd3VwZGF0ZS1jZXJ0
aWZpY2F0ZXMvZmlsZXMvc2lnbi1zd3UtY21zwqAgfCAyOQ0KPiArKysrKysrKysrKysrKysrKy0t
DQo+IMKgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1kZXZ0b29scy9zd3VwZGF0ZS1jZXJ0aWZpY2F0ZXMv
ZmlsZXMvc2lnbi1zd3UtDQo+IGNtcyBiL3JlY2lwZXMtZGV2dG9vbHMvc3d1cGRhdGUtY2VydGlm
aWNhdGVzL2ZpbGVzL3NpZ24tc3d1LWNtcw0KPiBpbmRleCA3YmQwNGVmLi5kODQ0ZTAxIDEwMDY0
NA0KPiAtLS0gYS9yZWNpcGVzLWRldnRvb2xzL3N3dXBkYXRlLWNlcnRpZmljYXRlcy9maWxlcy9z
aWduLXN3dS1jbXMNCj4gKysrIGIvcmVjaXBlcy1kZXZ0b29scy9zd3VwZGF0ZS1jZXJ0aWZpY2F0
ZXMvZmlsZXMvc2lnbi1zd3UtY21zDQo+IEBAIC0xLDkgKzEsMzQgQEANCj4gwqAjIS9iaW4vc2gN
Cj4gwqBpbl9maWxlPSQxDQo+IMKgb3V0X2ZpbGU9JDINCj4gK2lua2V5PSIvdXNyL3NoYXJlL3N3
dXBkYXRlLXNpZ25pbmcvc3d1cGRhdGUtc2lnbi5rZXkiDQo+ICtjZXJ0PSIvdXNyL3NoYXJlL3N3
dXBkYXRlLXNpZ25pbmcvc3d1cGRhdGUtc2lnbi5jcnQiDQo+ICsNCj4gK2Vycm9yX21zZygpIHsN
Cj4gK8KgwqDCoMKgwqDCoMKgZWNobyAiJDEiIDE+JjINCj4gK8KgwqDCoMKgwqDCoMKgZXhpdCAx
DQo+ICt9DQo+ICsNCj4gK2lmICEgb3BlbnNzbCByc2EgLWNoZWNrIC1ub291dCAtaW4gIiRpbmtl
eSI7IHRoZW4NCj4gK8KgwqDCoMKgwqDCoMKgZXJyb3JfbXNnICJrZXkgJyRpbmtleScgaXMgbm90
IGEgcnNhIGtleSAiDQo+ICtmaQ0KPiArDQo+ICsjIGlmIG9wZW5zc2wgPiAzLjAgd2UgaGF2ZSB0
aGUgeDUwOSBjaGVjayBvcHRpb24NCj4gK2lmIG9wZW5zc2wgdmVyc2lvbiB8IGdyZXAgLXEgIjMu
WzAtOV0uWzAtOV0iOyB0aGVuDQo+ICvCoMKgwqDCoMKgwqDCoGlmICEgb3BlbnNzbCB4NTA5IC1j
aGVjayAtbm9vdXQgLWluICIkY2VydCI7IHRoZW4NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGVycm9yX21zZ8KgICJjZXJ0aWZpY2F0ZSAnJGNlcnQnIGlzIG5vdCBhIGNlcnRpZmlj
YXRlIg0KPiArwqDCoMKgwqDCoMKgwqBmaQ0KPiArZmkNCj4gKw0KPiAra2V5X21kNT0kKG9wZW5z
c2wgcnNhIC1tb2R1bHVzIC1ub291dCAtaW4gIiRpbmtleSIgfCBvcGVuc3NsIG1kNSkNCj4gK2Nl
cnRfbWQ1PSQob3BlbnNzbCB4NTA5IC1tb2R1bHVzIC1ub291dCAtaW4gIiRjZXJ0IiB8IG9wZW5z
c2wgbWQ1KQ0KPiAraWYgWyAiJGtleV9tZDUiICE9ICIkY2VydF9tZDUiIF07IHRoZW4NCj4gK8Kg
wqDCoMKgwqDCoMKgZXJyb3JfbXNnICJrZXkgJyRpbmtleScgZG9lcyBub3QgbWF0Y2ggY2VydGlm
aWNhdGUgJyRjZXJ0JyAiDQo+ICtmaQ0KPiArDQo+IMKgb3BlbnNzbCBjbXMgXA0KPiDCoMKgwqDC
oMKgwqDCoMKgLXNpZ24gLWluICIkaW5fZmlsZSIgXA0KPiDCoMKgwqDCoMKgwqDCoMKgLW91dCAi
JG91dF9maWxlIiBcDQo+IC3CoMKgwqDCoMKgwqDCoC1zaWduZXIgIi91c3Ivc2hhcmUvc3d1cGRh
dGUtc2lnbmluZy9zd3VwZGF0ZS1zaWduLmNydCIgXA0KPiAtwqDCoMKgwqDCoMKgwqAtaW5rZXkg
Ii91c3Ivc2hhcmUvc3d1cGRhdGUtc2lnbmluZy9zd3VwZGF0ZS1zaWduLmtleSIgXA0KPiArwqDC
oMKgwqDCoMKgwqAtc2lnbmVyICIkY2VydCIgXA0KPiArwqDCoMKgwqDCoMKgwqAtaW5rZXkgIiRp
bmtleSIgXA0KPiDCoMKgwqDCoMKgwqDCoMKgLW91dGZvcm0gREVSIC1ub2F0dHIgLWJpbmFyeQ0K
DQotLSANClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkxpbnV4IEV4cGVydCBDZW50ZXINCg0KDQo=

