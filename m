Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392C6C433F5
	for <webhook@archiver.kernel.org>; Mon, 20 Dec 2021 09:03:33 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.93])
 by mx.groups.io with SMTP id smtpd.web10.3343.1639991011021321066
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Dec 2021 01:03:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=mnwwZ8jz;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.93,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4Umbl7sBNPaEvwFPbMAj/d80LkIN4KFvMyKxMm8wLc8m7wcZf2pXsuj+D9ewAzt23mNLz54DnjQhPwnN68tlKmM3dkz6x1tsBN5/L6fduOM9WInSqE8t/2yrapy0cq7MCp1V85VI1BOsKQ8Dl9FzTZm+RkfiziqRgcsRske1X6kawGB9K+KQmdUQAEtKPQroVZsF+ybrzy/1KOOkM4AJzWE/29Q3kteN51oS9BEwiWrvfPsKYrVNM35b3QRBxkb3mzbcOIyeirzA/z/5o058Jgcz749+fZxEVNRs9PgGVhZ4fDfyAw/0VZyQX/h/OxAkDSOgJhskMiJzwZoeI6a/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/C30brTbfjAMiRIAzFPh0U0seUm0fZj0NUwW199FGM=;
 b=DfFGMOxnwBk+kqhvP/YFGsj/WCXMjrNSsp5Lo9Yg1NWwHnKb6TiVs73Z38AXrwqpAmmQGLVVdykdXFBcAHGcA6+yk82EU9/aezp96ywROgeBKQbuBzTAD9/OnnyJCd617nazEC21IXy/ra+9lyP9PilS3l0RVLaV5I7+ZTMGWCV3Gza7IWLQq8W2SUWyllMUY+0jzEyWlPBEhUtS93WxP/V3YnLA+LTL9JJ6ybQD9oF0zvHtXYAHyvGeJLvCTGTynpRp2G+LidLdrxAePRrHLWtrp0HMrPUlJ5djdIQ4kD0rDMAa/Qt+SMwzJaPfY02CG5trIX997KQfUPuBuxLkng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/C30brTbfjAMiRIAzFPh0U0seUm0fZj0NUwW199FGM=;
 b=mnwwZ8jzXKJZ8SEXIbv68jUfPcqhNcOYa8EBSlUs5i7kXLBoxSsOWEWRf8JAqgcxigDV2ZvCF+foI+a3Pew09MlQFwx/zCVtWzcm4nMcc57bEK0RxRy2nKUd88BEiccVHsLGDP2ayPcbw/Y7nrgz8CyQSiboqla88tlY3YwuTRk=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSBPR01MB2101.jpnprd01.prod.outlook.com (2603:1096:603:26::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 20 Dec
 2021 09:03:27 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e%4]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 09:03:26 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip 00/24] Add CPG and initial DTS/I for
 Renesas RZ/G2L SoC + SMARC EVK
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 00/24] Add CPG and initial DTS/I for
 Renesas RZ/G2L SoC + SMARC EVK
Thread-Index: AQHX9VyOwyDcO4RDcUuc5e9hLdrVOKw7Fd1A
Date: Mon, 20 Dec 2021 09:03:26 +0000
Message-ID: 
 <OSZPR01MB70190F38692E1973FAE60B3EAA7B9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: 
 <TYAPR01MB625257A29259B7C8D6ADFAA5927B9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB625257A29259B7C8D6ADFAA5927B9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b05bdb9c-2031-49c3-b65e-08d9c39795c1
x-ms-traffictypediagnostic: OSBPR01MB2101:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB2101910925615697E72874C2AA7B9@OSBPR01MB2101.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 F0608aRvuatN6AydQTD9yht5AUzrNovsNBglu9RXYI8g9UjlofMVk/kP6fSawgLw2xxc1E3LItnDSS8lKdxnwTxi5anGCz+pIthsQlcjBbkIBeKq5eZkm/BkVtjuJ//kOIxgdOzeFn+0M60JT9Qg4gLOwVwWh7V40ucx8y5111bz8Tn5WVqzYZyxdmMwNiwQb7Jx4zfzgtQt9oY8YJAq7fpIiNQ4BzIXIjp0DBt6a/aj50I1HiVrffbRojviiM/amqgLgki7KTD1EJr9AWOBJiMbtpM/WdbK3IN6lL4jQerj7IHu3ftUf1/Sa0uLOp7HuG970Vv2yW5FYr1iFQoyBqHiZ+qMHTszQBsiP+iXKAAcDnFAnhZGtnX8tuen0bEfnVTJpaMZXsSqkpBIOL6wdNDfiSnpZUkUIiSQJTg2Uadf1GOgWukOq1gaxFZazGwxeEaFa9SAhZ6zfPGwiN0OJD73PVKFM2f+Uqn3CJFmFu3EyRRsDZaWHTd5xs0/HIxzG8KXRv7f8xy5t+NNFtZbTlncAo9giTn1ehsi+haDwtbfG6s1C/yKmJhU6WopxKtb6NgEYC6hPoVp0dQnMArAw7qDeMYdThFDTcmsKl1DWRz0idfMEGY5may5N3Zh1gE48FdQ4O4dHYfhWWNuWuENA571YgAJaHu2L6yqRgFGWIiKXCAFkUr0wlEa64ZkM/9isItSTCPapIctN94YCzfLSOowqe5HYe+yadhhGRtLGLLc/BzvfYQbaH8FANOqU2FFLfSVSK05snWGALWBzWrXit8vht/G3MUWMG17hiRg3LA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(122000001)(8936002)(38100700002)(26005)(107886003)(508600001)(186003)(5660300002)(33656002)(86362001)(52536014)(53546011)(55016003)(2906002)(83380400001)(76116006)(66476007)(4326008)(66446008)(66556008)(966005)(8676002)(64756008)(110136005)(316002)(9686003)(7696005)(38070700005)(71200400001)(66946007)(45080400002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SmM0OFpWUyt0eHg5R1JJVCt1ZTBYQjlSZmFabzVkeTFZWTNpY0pxdUROazY2?=
 =?utf-8?B?aWUxRjhjck9KU1NVNTArM0d4Uy9lL281aTVLRHZaTklDRk1QN0RYNjl6NkJM?=
 =?utf-8?B?Sm5wR1hOdDIrbyswek9ZUDdDWHM3QXFHbGtqVW5JSlo1bGpUbHMyamxBRVNY?=
 =?utf-8?B?NjVFYzNRM3JadDlsNzdSUTdpWHJ6bXd5UTdXdDA5SmVnUzJVbnN0bXhhRzU1?=
 =?utf-8?B?TmNDNmJFRmRzeGpDdU5jM3hrSjdMc0trcjc5aEtZQjZZek53cXRFYzZ3Ujgz?=
 =?utf-8?B?b3AzVUFKOVdkVzJuS3djMlNDbDRBb1FrZlkyQUxZL0Y3SmZhUWkwY2RuQmNQ?=
 =?utf-8?B?NDhGQ1RPd3dMYkRUdUY4cUpJK2N0azFDYXd5a1JMc09WVWFGbHBRb2dNSGxV?=
 =?utf-8?B?dHZVdkZ3MDQ0YjZzcjk2OGhvYTJFdklRSU5ETjNPWmZaUEV2NFRTeTJqOVpj?=
 =?utf-8?B?Y25UMTBnampxcy9SRG0rekJKTmF4aTlmMXd3VTNTYUxTMWZIaDZCOFZGSnFQ?=
 =?utf-8?B?WkZGQ2hRdDZHSHZTd2Q1VitvTmpHOWlGbyt3RVJqMzhRT3NBYWQvN04wTGxB?=
 =?utf-8?B?d0xoMlNjczJqQTEzTW5WVnFzenovUHFaTEU1MXo1S1Q2L1RGa09SYjFxRFRY?=
 =?utf-8?B?bERhTHZPLzZ2SE9iQ3FLR2MxN0lkeDRqWHdNcnU4K2VHbkNUT3NtdlkwcG5m?=
 =?utf-8?B?bUsxQlMyWUo5a1R3Vkc3ZlZIMllGa2ZDRE1hL3Rwa01qd1JWcjg2SDJpSFNT?=
 =?utf-8?B?d1ozVjNDRUxJQ2sxRVVPdmMyaDhhVnFpTDJmcnFnZFlvQ0FzaU1rNVZ2K3ll?=
 =?utf-8?B?TXJZTTYyTnB0aVhwODFtbjFFNEpwYVZ0Ri9ZVUFLZ3d2bjdGRFhkeFhWem9i?=
 =?utf-8?B?WXVTQkNSa1U2NjZqL3VMN05hTElqUGprdWRyK0tNV3RZVWVKWmdYWk9ObzZT?=
 =?utf-8?B?VjA4a25rS2Z1VHhISEZRTkVMNUc5TmxNakRmZVpzUHVzYm5ncC8yREsrK1lL?=
 =?utf-8?B?N3RvTVUra0Nmem1vU2t1QndJWkJlWVRXenRiSVJod3VZS1I5dHp6T2psWlhI?=
 =?utf-8?B?TmhMUzczWnNiTlM0V0Uya0I4ckJTSzZ1SzdEWFRGa0N0aDBjWjJFUWhqNzdV?=
 =?utf-8?B?WHJ2dWpwQkx6ZkhqYzkrQUp1SlJiOVgxTGpmcXhkZURuekRlY1hUeDR1MzRy?=
 =?utf-8?B?a3Zwa1NZYXhmWThHNmROelJodXRSakxrTU8rUU45YTJLMEJzb3pETERDOE9M?=
 =?utf-8?B?NHZzTEVrRzRrdXlSZExvZkVPZFhiN0Z4SmNxZ2NYcXRORGR4NUc0SnhIOHZa?=
 =?utf-8?B?K2xtVWl4UStKUUFmQ0o4dHZUcHczcklUdTFKWVBaRzdUU2l5ZzVYbUNPT2M2?=
 =?utf-8?B?OEthc3pFOEovcXlRblBzMk5wWE9mNGl1RnNTOHFmTWdCQTh2MnlyZjJFWFRK?=
 =?utf-8?B?T05xcG41Q21pWGw5RTJFTlhyM3lwSStSVHlVOXZJTDczbHYxYytGVkE2MDIr?=
 =?utf-8?B?R1RXWkdxc3huK0ZETVV2ZDRwYjNIZTFxdW5tZUZLYno4Mmp6TjRoQzlFdEd3?=
 =?utf-8?B?ZXFWSWNyNXh4SDlSTXZNaHpTSUJwMm9nMTA3KzBlSVpQRE11VFIvNjFkeHdu?=
 =?utf-8?B?bXFBKzcrZU1uSWZPd21XTDFkdnNmdG1GRU1FdWFrNnpha3RVNTRqV0V1UVhZ?=
 =?utf-8?B?aDZ0ZlB5NDVjc1J0c2N6QjY3T0lYSXBtT3ZxcEdHRTV6R2taOEdFMTB0R3Uz?=
 =?utf-8?B?QXBxMjg0VnV3cEQwMmxYMmJnK0VwWmRROGVDTWNzTU9ZNTRiZUJEQThaNWhB?=
 =?utf-8?B?ZzMyOWZaRWErUHpORXNDWldEb2xKYkVxRzZKMjgrK2VFSDFab2Q2TDRZcVFN?=
 =?utf-8?B?ZENFUlF4ZmhYWnluQmU4QU84a1diOFEwcG50K1lKTG5NbGxvOWt1UHM1czdk?=
 =?utf-8?B?bHBZdkdqSDJleFJrZlUxRTBZOE5XRmcySjhmdDhOREhPcFl5WjdrazRhZ2tL?=
 =?utf-8?B?c0l4Tmc1dW5IZENXWnM4S0NOcWMveDVZeVhQM1NJVGd2WWR4ejcwcjVFbldJ?=
 =?utf-8?B?aGc2VDRBVXIxRTVTTGFEcXNYeXV5Yy9zeVU1eHRiSFdvb2lablpDSFhxSnd5?=
 =?utf-8?B?YkJkaEJnVVpod2pMTHRvMlZVT3JTemNHMTNKT1p3eUZXaGxqUHl4OEtUbWVQ?=
 =?utf-8?B?bjM5WE81YXFtUXo2U05IZmJmY1d0bnR1b3g3bk45SHU4Vk9TMENKdTNBNFo0?=
 =?utf-8?B?QVd1Q1B4QUpXUnlDeEk1ZXJjREtVNmJVcVYwSTlSMVlHNko1Y29qQ043blRZ?=
 =?utf-8?B?cW1QSkVtUzdXL09Vc2lFOTVaWVBBeE55RW9KelBCaGhIa1VyZG5Wdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b05bdb9c-2031-49c3-b65e-08d9c39795c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 09:03:26.8520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 +0PgnnzPZ4cvJc2n2RwRf2ZbOIE5AM9eU4Mr/r7GkCBIulzGQQHU6GgIzMQbwmvOGhdej4502hdGZ2IRjrJbQQAR39F9pEC8nPdMHeixMvB7flb0pLpBMsQqL+YW65G+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2101
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Dec 2021 09:03:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7195

SGkgTm9idWhpcm8vUGF2ZWwuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2pl
Y3Qub3JnPiBPbiBCZWhhbGYgT2YgTm9idWhpcm8gSXdhbWF0c3UgdmlhDQo+IGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZw0KPiBTZW50OiAyMCBEZWNlbWJlciAyMDIxIDA0OjQ3DQo+IFRvOiBwYXZlbEBk
ZW54LmRlDQo+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgQmlqdSBEYXMgPGJp
anUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtQQVRD
SCA1LjEwLnktY2lwIDAwLzI0XSBBZGQgQ1BHIGFuZCBpbml0aWFsIERUUy9JIGZvciBSZW5lc2Fz
IFJaL0cyTCBTb0MgKw0KPiBTTUFSQyBFVksNCj4gDQo+IEhpIGFsbCwNCj4gDQo+ID4gVGhhbmsg
eW91LiBJIGNoZWNrZWQgdGhlIHNlcmllcyBhbmQgb25seSBmb3VuZCBzb21lIGRldGFpbHMgKHNv
bWUgb2YNCj4gPiB0aGVtIHdlcmUgZml4ZWQgbGF0ZXIgaW4gdGhlIHNlcmllcykuIEkgYmVsaWV2
ZSB3ZSBjYW4gYXBwbHkgaXQuDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogUGF2ZWwgTWFjaGVrIDxw
YXZlbEBkZW54LmRlPg0KPiANCj4gSSBwdXNoZWQgdGhpcyBzZXJpZXMuDQo+IA0KVGhhbmsgeW91
IGZvciB0aGUgcmV2aWV3IGFuZCBhY2NlcHRhbmNlIG9mIHRoZSBzZXJpZXMuDQoNCkNoZWVycywN
ClByYWJoYWthcg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gICBOb2J1aGlybw0KPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IOW3ruWHuuS6ujogUGF2ZWwgTWFjaGVr
DQo+IOmAgeS/oTogMjAyMSAxMiDmnIggMTcg5pelICjph5Hmm5zml6UpIDE5OjM5DQo+IOWum+WF
iDogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPv
vLQpDQo+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgcGF2ZWxAZGVueC5kZTsg
YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20NCj4g5Lu25ZCNOiBSZTogW2NpcC1kZXZdIFtQQVRD
SCA1LjEwLnktY2lwIDAwLzI0XSBBZGQgQ1BHIGFuZCBpbml0aWFsIERUUy9JIGZvciBSZW5lc2Fz
IFJaL0cyTCBTb0MgKyBTTUFSQw0KPiBFVksNCj4gDQo+IA0KPiBIaSENCj4gDQo+ID4gPiBUaGlz
IHBhdGNoIHNlcmllcyBhZGRzIHRoZSBmb2xsb3dpbmc6DQo+ID4gPiAqIFNlcmlhbCBzdXBwb3J0
DQo+ID4gPiAqIENsb2NrIHN1cHBvcnQNCj4gPiA+ICogSW5pdGlhbCBSWi9HMkwgU29DIERUU0kN
Cj4gPiA+wqDCoCAtIENQVQ0KPiA+ID7CoMKgIC0gQ1BHDQo+ID4gPsKgwqAgLSBHSUMNCj4gPiA+
ICogSW5pdGlhbCBkZXZpY2UgdHJlZSBmb3IgUlovRzJMIFNNQVJDIEVWSw0KPiA+ID7CoMKgIC0g
bWVtb3J5DQo+ID4gPsKgwqAgLSBFeHRlcm5hbCBpbnB1dCBjbG9jaw0KPiA+ID7CoMKgIC0gU0NJ
Rg0KPiA+ID4NCj4gPiA+IEFsbCB0aGUgcGF0Y2hlcyBoYXZlIGJlZW4gY2hlcnJ5IHBpY2tlZCBm
cm9tIDUuMTYtcmM1LiBGb3IgdGVzdGluZw0KPiA+ID4gcHVycG9zZSBNUiBbMF0gY2FuIGJlIHVz
ZWQuDQo+ID4NCj4gPiBJIHdpbGwgY2hlY2sgdGhpcyBzZXJpZXMsIGFuZCBJIGFtIGFsc28gY2hl
Y2tpbmcgdGhlIGJ1aWxkLg0KPiA+DQo+ID4gPiBodHRwczovL2pwbjAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaQ0KPiA+ID4gdGxhYi5jb20l
MkZjaXAtcHJvamVjdCUyRmNpcC1rZXJuZWwlMkZsaW51eC1jaXAlMkYtJTJGcGlwZWxpbmVzJTJG
NDMNCj4gPiA+IDE2NjMxNDAmYW1wO2RhdGE9MDQlN0MwMSU3Q3ByYWJoYWthci5tYWhhZGV2LWxh
ZC5yaiU0MGJwLnJlbmVzYXMuY29tDQo+ID4gPiAlN0MwMjM2NTc3NDcxZTQ0YmVkNTRiNDA4ZDlj
MzczZDAzNyU3QzUzZDgyNTcxZGExOTQ3ZTQ5Y2I0NjI1YTE2NmE0YQ0KPiA+ID4gMmElN0MwJTdD
MCU3QzYzNzc1NTcyNDQ1NDI3MjkxNiU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1D
NHcNCj4gPiA+IExqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJ
Nk1uMCUzRCU3QzMwMDAmYW1wO3NkDQo+ID4gPiBhdGE9UWk0VDBWNUZQVENNRjV0RTVEMUclMkJn
a1U1elRrVE5VNE1EeHR3QzlZeThFJTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiBUaGFuayB5b3Uu
IEkgY2hlY2tlZCB0aGUgc2VyaWVzIGFuZCBvbmx5IGZvdW5kIHNvbWUgZGV0YWlscyAoc29tZSBv
ZiB0aGVtIHdlcmUgZml4ZWQgbGF0ZXIgaW4gdGhlDQo+IHNlcmllcykuIEkgYmVsaWV2ZSB3ZSBj
YW4gYXBwbHkgaXQuDQo+IA0KPiBSZXZpZXdlZC1ieTogUGF2ZWwgTWFjaGVrIDxwYXZlbEBkZW54
LmRlPg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgUGF2ZWwNCj4gLS0NCj4gREVOWCBTb2Z0d2FyZSBFbmdpbmVl
cmluZyBHbWJILMKgwqDCoMKgwqAgTWFuYWdpbmcgRGlyZWN0b3I6IFdvbGZnYW5nIERlbmsgSFJC
IDE2NTIzNSBNdW5pY2gsIE9mZmljZToNCj4gS2lyY2hlbnN0ci41LCBELTgyMTk0IEdyb2ViZW56
ZWxsLCBHZXJtYW55DQo+IA0KDQo=

