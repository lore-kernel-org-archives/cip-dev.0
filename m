Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EFCC77B7D
	for <webhook@archiver.kernel.org>; Thu, 18 May 2023 07:58:15 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.104])
 by mx.groups.io with SMTP id smtpd.web10.12021.1684396690037703261
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 May 2023 00:58:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=mU5S9xCJ;
 spf=pass (domain: renesas.com, ip: 40.107.113.104, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CumN2teWEJ59vSseMvggo5n7JbGkFm64mF6L5PbzZ89hxENs+sC6SaV47iPbKKi4HRD0LzcoTsCz89b50LTLGU6HWIji9eJsz4Er4PTV+Q7ksUPRNeh9qjqUQSXncpqk+Db0J8z/9mf0o+ddpI6+9st8vxk6ib4XIDnrPpJ3RsSNw6KMTqILoI9oJ0iUEoRsx0L7znV9Z26jswzbLNCYjUjr6kNQMipehrO3ELaCDXv7dusbGTBvi6OlIrmrkyWwVEQxpDTQDTNX+r6LB3IEql/J7nXRGynSiE6cyOfmrsw1oNgpvJCb0NQ+Us06mHt6ziDas36LC/r40LkdjebUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYBj+suomVFYUDn+cmmKZg/lp3mlXNJ9YSBt6J8kwVU=;
 b=BZrg8D85+lHkd9OCL9KQZeCnIY32sxqHLQF/Rchbvj/Ysspb7zUnPzUoKqEiaos48xERSkGR1a52y3sXlbc5mgeLtftjDGXcy7vC0qIWgNWB86fFBOI534YZtefLjMoluysaUYnAEmvCWJghSgpgy7ihHUysv0PkfFZtz0s/9bOHW/ldT0xfh9fqZx1z5/dBEYEhzrCzGEzYwn3mScImJvriU8akX+M6QAVdqsYhGW3CxqoMhjQOI2jSoLvN90RLgxL8bSbtjIz2AAA5Pe7USe2NNOufJo7e1oE9ea2S5JU2gQJUp9NrgjxYuY3DDbHtpm1sHMdKyYdZVvhEjzfmDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYBj+suomVFYUDn+cmmKZg/lp3mlXNJ9YSBt6J8kwVU=;
 b=mU5S9xCJUHFVv/i9aqDpuT1Yv3KY0OdYv+F4iH7GQN303/s9O9311h24aPeH83pOhccDbAovMNE5x0ciSo8Ec8/rpdW7IuqgkJMcjK1+chXBGsSFWiEUCGEssH6szktxbLG1YU5EEdsQ1IcD4tGEsh5DdJW6LiRq2AxLiAKR1MY=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYWPR01MB12061.jpnprd01.prod.outlook.com (2603:1096:400:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18; Thu, 18 May
 2023 07:58:06 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79%4]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 07:58:05 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
Subject: RE: gitlab oddities again
Thread-Topic: gitlab oddities again
Thread-Index: AQHZiOIZHXANjR5SaEuRxwPAhM5fB69fqafw
Date: Thu, 18 May 2023 07:58:05 +0000
Message-ID: 
 <TY2PR01MB3788E34CCA47D8B89A993D23B77F9@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <08f9b5e5-e68d-7105-6e15-c742abb0c563@siemens.com>
In-Reply-To: <08f9b5e5-e68d-7105-6e15-c742abb0c563@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYWPR01MB12061:EE_
x-ms-office365-filtering-correlation-id: 81b60082-8e43-47f9-9e2b-08db57759cdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 bNm+iHDNkQVjZztdb0+y3oMvIs6wjxN8NX2HfF1g4IK7+N6u6YhkyznU3lRUeTcW2g740MsZGs258BBrvW2cV8ngsSEUOARdXQ3HZMeTDGiUcF8XD3fVhqylK0OnC2UubBL9HfEpbC7JmOWxl/EX2FOY89+ZIxsmkenQc7/ffGHgEQzRStadZt/l8z+kg7x8pC5nePrYFffhPb3fEEl7TxBphgfSimJ4/GAhGHphHNNwwbXlTOiyq2iYvVfmkYjiRwCEl2tTUSDi+Om36U+ipUOKiOTaBDe2CPaWFjScM2Pr+MTupFSvlJnG9yLtspPPjMhD+vArQaTeoqeVuF0+480/iOaYlKMHEpNZBdma2a9JkEoEipBOO9q1Tef9w8NKcGitTK+SkDlwlHiCFGDnFqnD8oF5x/8uXZXLLwbyOvc6ISU2teADmmEp396Iz7TwQhzsvq5tusjXrk7D40YGr/SR6XkL0SN9gIDL6W9Fc5HunD+puP9gwPwTTcj/f7x/AVF6rsVYQo6xvWmHPEtO6KHqUzQ/bLJm7qT0WD2jvBG9yhCOEUz7VZedcHD/HReX1e0ouGpwDTMHEK55dNn6c7YYP0K2KbKFhojgwg5TK3g=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(478600001)(186003)(8676002)(8936002)(2906002)(4744005)(316002)(41300700001)(6916009)(4326008)(33656002)(7116003)(86362001)(66476007)(76116006)(66556008)(55016003)(66946007)(64756008)(5660300002)(71200400001)(7696005)(66446008)(38070700005)(52536014)(9686003)(26005)(122000001)(6506007)(38100700002)(3480700007)(966005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aXJuYjZidnVlamh2aWJUaXJ1NW9Rei8vaDlsWWk5UllUUTR2dzEvRTI3WFgr?=
 =?utf-8?B?ZHh2M0ZKcEtiaDRhNnRUUzk1cFVRK3Bjb0tUUGxESU04WWxLMXA1SGs1TlVJ?=
 =?utf-8?B?RWtrQ3dXN0xHQmg1dEZMN3o3ZEpPYm1nL29XNFR6L3J1Z0tnWjRrR0QzQ08x?=
 =?utf-8?B?SW93MDRad01UVXJTWUIzK0hjbkxEV0NteSs4TzY5bklqS2lHVTFJa3lQdlZ0?=
 =?utf-8?B?WmQ0SEFXeGJJTXZuc2R6bUtUbTBQVmIyYkJWczlqSmVuL2JaWDkzdTBDa3RT?=
 =?utf-8?B?RXUxZDZScVV1TVc3YytybUpQcXVHK05VVnBtVFh4NkdaRG5TUVNjSWdOL1JV?=
 =?utf-8?B?b0ZLcUY4cVdWSW40VkdZdFI4cnErbDV2QWdhcHljNEFVY1oybk5jMmV1bUtW?=
 =?utf-8?B?aVlkM3Q3MUtkL1JiQm1nWWplMThWZmZtajNBS3BTUWpVNVJBaUtKRTVOOWVq?=
 =?utf-8?B?bk9aNklxN0hwNWdKVzR1bUEzZ21JaFI1emdHNEcxenJkblBGV2pmZVp4RmVO?=
 =?utf-8?B?T3hGcGxacU5Qd0tOb1Nua3BiMHI3a3JBMnM2SlJFUEU1OXBLVjhqUWNiNlVo?=
 =?utf-8?B?aGhRdFU4K21naUNIUDk0NGJqbkFOakU5Zy8zVWdLejZQcWE1MDZMQVpFQk50?=
 =?utf-8?B?SXk1Q3R4QXdydmdCaHJleUs1a0h3Q1FRMXdvTWhuajVjNHg3K0Rpam83elQ3?=
 =?utf-8?B?WEJzQzVvMFd6cjlxd0xVUkd0Rm1MZU9OekRUdDkyRFBhZXBlZ0wwSHdLREhV?=
 =?utf-8?B?TGpRVGd4c2lRMVBkUWlwRmFjRy8ydHY1T0lNdjRiS2J4VUhhdjNSUXVEVWlV?=
 =?utf-8?B?aGhVWnQ0a3J5ZmM0WWZnQmlQc29OQmp3TFBBNExzMjg1RC8rQ0docERHT1Jz?=
 =?utf-8?B?S3dTTWdFZWdubTBPY0VqUlIzd3hGL1MwN01STlBpWXdJbXROL1FSc0llazVh?=
 =?utf-8?B?RDV2Mzl3dndKUnhyM2wrakN3dyszTzB2SzhhcENGdWU0U2JkWmhpeXViMG1E?=
 =?utf-8?B?MEdUVCtETzVNZXVMemJucWR0NWU4Uml6aXBNaUE5MUJQZTBEblI5M1hsYXFn?=
 =?utf-8?B?bFBLWEdNTk4rbkp6RC82VFFLMC9rbzNLWGpRV1V3TFIwMG9La3o5bTlYQ1Yw?=
 =?utf-8?B?akYyR3Myc3NEZjJjaVBJSUNLZHhSSklrZmwwaVpYS1Bzem8xUEt5N1FDKzVW?=
 =?utf-8?B?RjdNREl6ZWtQWWpVd00vcEpvRVZTZW5peExyWG0yNnVaNG1SbWE2TnBGYzhZ?=
 =?utf-8?B?TzF0bEduZ1NSbStkSmU0TGZuS25IREN0eTcydjBGR2RvZlVNUE5ucitqQ1Vq?=
 =?utf-8?B?U2hPQnVld05RMEdLdlkyOENGQTNMSWQwQTc4Y3JMcmhDSVJLU2V1eEVHYnhI?=
 =?utf-8?B?YkhxYVpiQ3F3VWRnenE5ZnEvdHc3aXBXeUwxMVNnL0tGWUh2TG43M2NNYWQz?=
 =?utf-8?B?WmpSS3hFUWJUUmFIRmNjditwUXM4clFPTVk4MCswODRwem9NRTVyUkNlMDA3?=
 =?utf-8?B?VXBOYjhlam1YZzFXU3V4Z0xJbnh1dHhBb3puRWZSMGhETGxBU2k2WVdmRmFH?=
 =?utf-8?B?SGJWNEpsZXhoNEJvNGFZbEo3dzNMd28rdjBiS2lLYXlCZXhDZGowM3RpR0VR?=
 =?utf-8?B?b1dLRDZXVVAzUUdJazVVaDJ5dDhDRjA3VFBvRkw0ejA3YmZjV2dVYWgybWFB?=
 =?utf-8?B?Q3RhS1ZSQXg2dDJyL3U4cDd6MlF2R3owb1hySjBxRS9UbHNTWUlJV0FEejkz?=
 =?utf-8?B?TzRXRkYyVjhyYzJ3ZlJOSWtGa3VEdzV6TWhVSU9xN09GM29xZUsrSElOS0pC?=
 =?utf-8?B?NzFiZGh6TlQySnh0VGxPZEI3WGhhMyt6alpLRG9kRjh1bGRJRnk0K1hQeXk1?=
 =?utf-8?B?TXlza3lCZXhwc3psTXZYYzRKb1Z4dUJyRGl0SnNISGMxUlBRaVhpaWNpckpJ?=
 =?utf-8?B?QVZ4emN5dDdZczZ5b2NBSmthT0V5TVlWNFI0WHBDbFQyWCswV3lLUW80TGtz?=
 =?utf-8?B?YUtVU2UvTnFaYkVTQTEvZEN0ODJ1aDJ5Vk5TVlpKNHd3SlQ2bWk5L0ZyL2U0?=
 =?utf-8?B?ZTZhQzR4eFNkYVN6OUNRcmtZVk10K2lCZ0RPMTZGWWgrRjBnaDZCekorUFlv?=
 =?utf-8?B?bG9IdTJueGpZSzlhZ1BDR0Q2eUlYVUVBTEZ0R0xSTVAvYnd1bkdzcDJ0UlUr?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b60082-8e43-47f9-9e2b-08db57759cdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 07:58:05.7067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ri0+HvEFFJgQrWz9bz/CidOmMfO0Hdi+tYLO9iqKg+D8TnpuQjrx2i9qwWqTTkhtq4JW5WHx+KVwNugzIb+X4CCR4F25gp7Bj5UlDI4MuJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB12061
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 May 2023 07:58:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11511

SGVsbG8sDQoNCj4gRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4g
U2VudDogV2VkbmVzZGF5LCBNYXkgMTcsIDIwMjMgNjowOCBQTQ0KPiANCj4gSGkgQ2hyaXMsDQo+
IA0KPiByZW1vdGU6ICAgIFlvdXIgcHVzaCBoYXMgYmVlbiByZWplY3RlZCwgYmVjYXVzZSB0aGlz
IHJlcG9zaXRvcnkgaGFzDQo+IGV4Y2VlZGVkDQo+IHJlbW90ZTogICAgIGl0cyBzaXplIGxpbWl0
IG9mIDAgQnl0ZXMgYnkgMTQwIE1CLiBQbGVhc2UgY29udGFjdCB5b3VyIEdpdExhYg0KPiByZW1v
dGU6ICAgICAgICAgICAgICAgICAgIGFkbWluaXN0cmF0b3IgZm9yIG1vcmUgaW5mb3JtYXRpb24u
DQo+IA0KPiBBcmUgeW91IG91ciBhZG1pbj8gOkQgQnV0IHlvdSB0YWxrZWQgdG8gZ2l0bGFiIGxh
c3QgdGltZSwgcmlnaHQ/DQoNCkhhLiBJJ20gYW4gIm93bmVyIiwgc2FtZSBhcyBvdGhlcnMgaW4g
Q0lQIDopDQoNCkZvciBzb21lIHJlYXNvbiBHaXRMYWIgaGFzIG5vdyByZS1taXJyb3JlZCBhbGwg
b2YgdGhlIHRhZ3MgaW4gbGludXgtc3RhYmxlLXJjLCBldmVuIHRob3VnaCBpdCdzIG9ubHkgbWVh
bnQgdG8gYmUgcHVsbGluZyAicHJvdGVjdGVkIiBicmFuY2hlcy4NCkxvb2tzIGxpa2UgdGhpcyBp
cyBhIGtub3duIGlzc3VlOiBodHRwczovL2dpdGxhYi5jb20vZ2l0bGFiLW9yZy9naXRsYWIvLS9p
c3N1ZXMvMjQ4NzMNCg0KSSdsbCBleHBlcmltZW50IGFuZCBpZiBJIGNhbid0IGdldCBpdCBmaXhl
ZCBJJ2xsIGp1c3QgcmVtb3ZlIHRoZSBtaXJyb3IgYW5kIGdvIGJhY2sgdG8gdXNpbmcga2VybmVs
Lm9yZydzIHJlcG8uDQoNClJlZ2FyZHMsIENocmlzDQoNCj4gDQo+IElzIGFueW9uZSBlbHNlIHNl
ZWluZyB0aGF0IG9uIHB1c2hlcz8gVGhlIGlzc3VlIGlzIGN1cnJlbnRseSBoYXJtbGVzcyBhcw0K
PiBwdXNoaW5nIHN0aWxsIHdvcmtzLiBCdXQgdGhlcmUgbWlnaHQgYmUgbW9yZSBiZWhpbmQgaXQu
DQo+IA0KPiBKYW4NCg==

