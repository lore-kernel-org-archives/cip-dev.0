Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D593E784A6
	for <webhook@archiver.kernel.org>; Sun,  1 Oct 2023 23:47:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.71099.1696204035366556458
 for <cip-dev@lists.cip-project.org>;
 Sun, 01 Oct 2023 16:47:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 391NlCCl3923736; Mon, 2 Oct 2023 08:47:12 +0900
X-Iguazu-Qid: 2rWh9TRRTCeYBW9cEl
X-Iguazu-QSIG: v=2; s=0; t=1696204031; q=2rWh9TRRTCeYBW9cEl; m=61DuX6Vp6UVnCRXkqaeAnM6C7Ljpx1kmVKyHODN8uuo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 391Nl96R1482032
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 2 Oct 2023 08:47:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4Rt6Fec2vJMbncPzDR1g/H2XZBJ4gqRpsmtP8f7qsAZWj1qhgsm0ITJzdXnnCkTpufYY6gybh+U0kY6+CXBh0uqIcGFiAjNuS2TctH8GLOhS571BDPmlH0mM7jhHSFGBV0q0mQ1by5RfjtJij2MxoKLhPAq7S9hMAe0jCOIoSKD/cnV7Yeue4hY/MeRBiHst0oU9txOWzUTw8gRS7MoT3puDQGgtZbqkE11WDql4p1acurazTSkOoMumdX0Y/ybfG9KTRtsxC3ncT9C5UO70S/YU2xaQGKtGVYHNaq2LzZzQ/wWviGoRkXRJrkW9F6yogE73uNUCAgiUfwmYYijIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n21tT+wEZQlG5bb8UC0W29mJctepS2Uq7DvS+mdq+e8=;
 b=MyQl+5j9diB3HcHCY8ud/L6PQlQcLYyLi5pZK44Iy9jNDQMLkKzhUygNfLngTSigubeU6O3xJFph8qxXzcNw2/ZbSM9UNL2e9NcYK8BPCz510YsKCVYGXzVkjhhOATnRupJVvXWp1OJDb9h3EygisF8I3Z/79c2q2BtnRZHysXppq+cspNvrpEBdr6zdxHnAoppPH3RHpiGVZ1lRK3Z2qvX5wbDY+QADsfUE1w9r2TqF0AxSUq1fKMpKINNTJjIPNa/f4o91yLVskGLM1ijbnyTPelDyroxkY8KA3iNhjGDFz7ZBdnJohAR+aYJYVAUpHQ/u2ee7Ebigynj9mbGCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <iwamatsu@nigauri.org>, <minmin@plathome.co.jp>
Subject: RE: [cip-dev] [isar-cip-core][PATCH] Add support Plat'Home OpenBlocks
 IoT VX2
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] Add support Plat'Home
 OpenBlocks IoT VX2
Thread-Index: AQHZ1Wf5/CLWZkRDa0OLNZTE4Lk26K//SywAgAAaeyCAF+S8QIACp9MAgBvk4SA=
Date: Sun, 1 Oct 2023 23:47:06 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB11245B2B585370AFFC3C2E88F92C6A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <20230823021713.87089-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <e42fde0d-023d-4e03-a081-0d471172c6f2@siemens.com>
 <TYWPR01MB9420D3C6042C375FB255DE1292E0A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <TYWPR01MB94205EE74FE50218B3F3001B92F1A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <bd108908-8c22-4eeb-9a60-f386e300a2a9@siemens.com>
In-Reply-To: <bd108908-8c22-4eeb-9a60-f386e300a2a9@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TY3PR01MB10318:EE_
x-ms-office365-filtering-correlation-id: 012844d9-260d-4f0e-2942-08dbc2d8b890
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 3uwUA0UN7b+Qa4tiX1rgWYdYSu1sJWq7ss+vva8VHTPgi0YL/kFwqkkJI2ojhtI06q+hsa2VtYZ1XVJSZPGbXsO06+DlBdmpED2Cf4zhQHJHf5dHhVkGsR0vtnXYkWkyn4l2MBZJ6NKbMvxnTprONdbVb2nTnastV83Kkrw1ot0ky8+XTrCpH1qnnJ6uVZPmkcVh/ORLAkBR2CAeHw8LRe5cZwizvYBA+SeBi1I41zgq+LDeTimZ/Z8NaF0VQ1yjCvjqJojFDvjgXCuLcTjnZqZEkueHJn2cfZ3/ibieyTqu8UPRx+9ZdBwcIDYHZ7Q0BOWs0uU7B/W0h+QXxeFJfldRGRuwmbowm7xL6Eil74YQaWC80xwmMtmYEMWCL1yjuI6YFEtRXw3Fl9CbXBzue6igNLXXklasNqPHHe3KVGADB87HnuWGAo4DPqOO1a81xjW9z89tzwQWxgQcDmYcJ5qX3Xw1TXrYOJGH0cLitqNQrQzeeCPOrFACerKxLjFokaVyfV8KPO9CmdYxHokg0xAMNzTLAJSqi9+WJG1Vo23CalsqtWOnjaao9FUz5QMkwo3S6Fee6G6kzPcjENib+7KBZ7ez56IDl7cLDkTcAiOzpOeW7Bo6EeX7qKtcONtXJfix/GrDMr/yevYm4ZCzMQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(8936002)(52536014)(8676002)(5660300002)(316002)(66476007)(64756008)(76116006)(6916009)(2906002)(66556008)(478600001)(66446008)(7696005)(6506007)(9686003)(4744005)(66946007)(54906003)(4326008)(41300700001)(26005)(83380400001)(71200400001)(38100700002)(38070700005)(122000001)(33656002)(55016003)(86362001)(151773002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K3IzWXJBZ2M4UXFoTkRRQzdqajNoU3ZuOHYwU1lMazJNWUI1MmtqYzcvMjFo?=
 =?utf-8?B?MHFSZXJSckliYkZCYzZjWjVPR3ZwUHdPanM2NUZCZzRTTVNjQjdzdW8zcGxS?=
 =?utf-8?B?ZlFqWkxqaWNIdlJDcHNFeC94emhNMzBoaEN6cTdQaXZJbTNXaU1wTlM1KzZz?=
 =?utf-8?B?UmhhRncvQXlCeS9LV0lZbVp6ODJma004U0IzWFR0YUFBSTNTakdITkFPRFV3?=
 =?utf-8?B?V3BRU1NwcEpYV0o5cUR2eDhHa0dUVDMwZFQrVUVPMllnVUhIVDJsRkVtTWZL?=
 =?utf-8?B?bkVtalFXQzFaUm5LSHlkUTdBOUJybU5BQTZ3TVU3T243aFdrOXRxVzdEYWRY?=
 =?utf-8?B?S2tEZUQ2MDc2bXBVNDVtdlZTSnhiRm9FQUppZnBUOWJVUHJ5bWt2Q2c2R0tR?=
 =?utf-8?B?eUJoaGV2bXdoS3J1L1RUQmt3SVR6MWRya1BReUpqVmU5V21DNDlRSXJqcFh4?=
 =?utf-8?B?ejYyckltQzRoRGJtY3hUQ01XK3JiU0tkeHdjUU9kTnVkemdvdFJXVVNsekNT?=
 =?utf-8?B?cURzbkZCV0s2OG1NbWIzaGdhOVNFRU56N01VU1dFZlVHRkwrNzdFRFR6b3Vj?=
 =?utf-8?B?QWxFWmdpZGs2NjJFTkdESDUzS3k5N1NXRHpHdktRWEMydXZ5TFYwSjdZbWUy?=
 =?utf-8?B?WDZXa3owTjVVQTBtNEN6bmNDNWUzUDkwTndmanhOdTk0YjVwMWM4cVVDb0ti?=
 =?utf-8?B?eTVycnhxTzVudWl6L2VzRmRYOThUbmFIa01peWM3NFA2a0VtV2xMR21ycmNX?=
 =?utf-8?B?c1lMcnpCU3B4MGd3S2d4djlLVGd4ZzlSRTVxSW5zeGhoMklrdHhXbnNENUpN?=
 =?utf-8?B?Y2pYbVJJZ1R3N3FWenJHaVVaM1lyZFM2QTVXaXNPTlN0VGt6WE9RaUF5MThZ?=
 =?utf-8?B?WG0wOTJiREIvbWhSUHUvVUMvQUE4TzJvZVZvUUpCVnhrRVBUWVB3SGNuOFN1?=
 =?utf-8?B?dStHcHhpQUxVNmxxbXpYWDZodUgzenI4M0l3djd5M2dMOUhYY0Z2c2JjV2dM?=
 =?utf-8?B?ZlVPZmpuc3piVXFScFkwdzFXYVBYOC9wc1Z5TkcySWYyMGVWTDNZeVJsendR?=
 =?utf-8?B?Tk5oeE5pYmwrSzRPYWl5b2tlVTFheTFqMkJnakFEcHk5RWN6dWtuamFEaEFy?=
 =?utf-8?B?N3czOGpKcGtTczBrNHkxb3VieTlNUTJpZ1hRM3VnMTM0RWw1T1lEWFdpUFdL?=
 =?utf-8?B?TVo0Y1lCck9nU3N1OWxvQ0VzRW5wamwvckZKMUY1RHp0REZRcTFNRUlrbjZN?=
 =?utf-8?B?NTM1czZ6c21ZZ05zQ0VBRU9RTXdGWHFibzdFSFVmR2hVakdiWjR2N2NjU2dI?=
 =?utf-8?B?Z1FmVkdJOEhzcW5ZQmN4S0svNlNGR01kTEpwa3NzMGNyVmgxSWZucStGQm5i?=
 =?utf-8?B?ZktlQllTcG5JUUtGN0ovZ0plOUxOdmJHRlRtbkljd05HaDlUNDZSTzVldS85?=
 =?utf-8?B?aHlBMGpxdW1tTVpidUJCYWZtR3A1dHFkUE1ycHhQU2xkN1lUQmZSY28vQ251?=
 =?utf-8?B?RzFNL1VXMGpnUWlDL2JUR3lJQTl2MWlEdzQrd2tJVDFHTmJLN1J1d2pvSFhm?=
 =?utf-8?B?Y1h6Vlc3dEQ5RVBaclhGcGlqZC9id295b2FPbTBUbXpKS3pRRGRJendRYVFi?=
 =?utf-8?B?bGQwY3hWYUNaVHZiVjZXdzJ6KzVJZTRKVUhpOUxMSEY4Wk1UazVZVEJSK3lo?=
 =?utf-8?B?YVJGMktmZElzUVArL254WHk0cERINmZoaGhVU0NzV21YNEoyUVBVUWYrV1dv?=
 =?utf-8?B?aHpnK1dma1ZSNS9ROGlpWXdwU2Vzc2JJcDU2MTlYa3NvbW9iSTZaejBWV2Vq?=
 =?utf-8?B?bVRvOXdIUjdOQlRHMDN3by9pUzBvaG1pZDBudy9CbXJqaXpVaUVmTmlaZHdv?=
 =?utf-8?B?eCtzd3FSakpzVlBDVUhhS0s0Zlo4dnVGOU83Vk1kSGpyYVRWdW9kQTZ4Q2pI?=
 =?utf-8?B?YkVYV3N4Zy9KSkVDcG5RMGRoV3U2Z1RzQzdkWUUxbUY5VnQzN0JmckJUNEZp?=
 =?utf-8?B?ZmlKV3I4UWNHV3NJTDRPQkRhMnhpZHdZWGNvbGc3N2RscFlJNFBLUEoxazY5?=
 =?utf-8?B?d3AyY0NDY3BBclE2YUszcDU4bk00bm8yRVZvSXhRQnFSVkhEUGY5aGRFTVRV?=
 =?utf-8?B?dkZBNUlnRzJ4b2RpV2R4NFRRMnhOQ0hDTllXZlJLWllyeThtTFBBM1pqcG9J?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012844d9-260d-4f0e-2942-08dbc2d8b890
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2023 23:47:06.7773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGcMwju+T4BIN1Fh9xAvYFifxucL7yEjJWCFd8BDq7nMAgFu2V2KhRnpomIEgV4ABAnWgRC5FyPnP4AmRqp4slFWXDxjjALUAXppULQk5KdvBz486Nkp94/3iecLAykL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10318
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 01 Oct 2023 23:47:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13254

SGkgSmFuLA0KDQo+ID4+PiBJIHdvbmRlciBpZiB3ZSBzaG91bGQgKGFuZCBjb3VsZCkgY29uc29s
aWRhdGUgdGhlIHg4NiBjb25maWdzLiBPciANCj4gPj4+IGRvZXMgdGhpcyB0YXJnZXQgY29tZSB3
aXRoIGFueSBzcGVjaWFsdGllcz8NCj4gPj4NCj4gPj4gSSB0aGluayBpdCBjYW4gYmUgaW50ZWdy
YXRlZCBpZiB0aGUgc2VyaWFsIHBvcnQgYW5kIGJhdWQgcmF0ZSBhcmUgdGhlIHNhbWUuDQo+ID4+
IChUaGVyZSBtYXkgYmUgb3RoZXIgc2V0dGluZ3MgYXMgd2VsbC4pIEFuZCB0aGUgcGFydGl0aW9u
IHNjaGVtZSBpcyANCj4gPj4gYSByZWZlcmVuY2UsIHNvIEkgdGhpbmsgdGhlIHNhbWUgc2V0dGlu
Z3MgYXJlIGZpbmUuDQo+ID4+IFRoaXMgdGltZSBpcGMyMjdlIGFuZCB2eDIgaGFwcGVuZWQgdG8g
aGF2ZSB0aGUgc2FtZSBzZXR0aW5ncywgc28gDQo+ID4+IHRoZXkgZW5kZWQgdXAgaW4gdGhlIHNh
bWUgY29uZmlnIGZpbGUuDQo+ID4+DQo+ID4NCj4gPiBQaW5n77yfDQo+ID4NCj4gDQo+IFNvdW5k
ZWQgdG8gbWUgbGlrZSB5b3Ugd2FudGVkIHRvIHNlbmQgdjIsIGdpdmVuIHRoYXQgeW91IGNvbmZp
cm1lZCB3ZSANCj4gY2FuIGNvbnNvbGlkYXRlIHRoaW5ncy4gT3IgZGlkIEkgbWlzdW5kZXJzdGFu
ZCB0aGlzPw0KDQppcGMyMjdlIOOBqCB2eDIg44Gv57Wx5ZCI5Y+v6IO944Gn44GZ44CC44GX44GL
44GX44GT44KM44KJ44Gv5YG254S25LiA6Ie044GX44Gf44Gg44GR44Gq44Gu44Gn44CB6Kit5a6a
44Gv5Yil44Gr44GZ44KL44GT44Go44KS5o+Q5qGI44GX44G+44GZ44CCIA0KDQppcGMyMjdlIGFu
ZCB2eDIgY2FuIGJlIGludGVncmF0ZWQuDQpIb3dldmVyLCBzaW5jZSB0aGVzZSBhcmUganVzdCBh
IGNvaW5jaWRlbmNlLCBJIHN1Z2dlc3QgdGhhdCB3ZSBzZXQgdGhlbSBzZXBhcmF0ZWx5Lg0KDQpC
ZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=


