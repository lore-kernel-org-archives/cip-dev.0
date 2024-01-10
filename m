Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB04CC4707B
	for <webhook@archiver.kernel.org>; Wed, 10 Jan 2024 20:02:47 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.42])
 by mx.groups.io with SMTP id smtpd.web10.3526.1704916710373148028
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Jan 2024 11:58:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=grBVbYOo;
 spf=pass (domain: siemens.com, ip: 40.107.247.42, mailfrom: gokhan.cetin@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUJ21tmsWQVP/CZ5wDhISUE5TjPKsxNCs5n70v0pufmFEm6KbR8a4Gwt0myyi9jfrIZTnFJp6IX/KaD/os1W6jnrBm8TN6w6pR4NPed33R4RV1811VpJHofYERtLbMsjtw70rlVrcyIR0au7mwTRBSknDkyY3vzb5dbzKyZypVcUxmt4J/PZEpOV9U6nreVEWWjzgpgUt8pxGyjmBTwYrV/1t7nzhXWvoL/rIHfdgqDIjNklA0XTu7jN+cC4+M9sOld4l2slIBXCniH2kp3OeBHzF0jRfxOReMY5sDnl25j7rCWCZ6xYH5p4lW3yXgOoIlfYy/PIuxflrXirzed6qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IAIAiZumMkomTfufYzULKeKu1i/2WIf3VRQy9FIsuA=;
 b=nm/0rYD8fxcrM4w1spmAsSEXzfnmfhqvqdr18ukobATpSXss16xpRTkSrKGbtuB7de7fFWNwskJbXDFX3Tj3H2KMpbfUmqe3C3P2oCyFTbsn71KtMJcW0lUv0bL1ZsPT7OGUqshn47O9W3E44TC+rtzklAkQu6OYyqpt5NjaOAwbzmMtjSXOe/Dgh3dJdir7OHkG8OKOIZBR1PzK86+kQ96qsGUQmI9BlAPhe/51ljMuWcJiTDjtQkBfpJWHomzKlmBJO3QiR8HImZSQZzkO93q4O8TVpFyNl8Re/kMB7WznbB4hCv3yXanC1yReOIEK2rSQTa24kmr5fPYxhr4ORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IAIAiZumMkomTfufYzULKeKu1i/2WIf3VRQy9FIsuA=;
 b=grBVbYOon0o1yjwlXdMaG4iBiw4+0lZrZyPQAMOEjE729R1+ErhHQ72smvv7ItR7wYeaRaRZXSstWdcUMohzC8Y5rWUcj86zDXvW4a9+AtrXHO++WAVslvf5QsuVu6+j7vrEyUY1KNXAvNeQzVMSZX3/yyql7tDNsvLLLiqO9TJ/P4zvfZNvsQ+wziAFArpC1DzMwmPbHVwO9TEzC7qjm4VfK0iocsF85IgOCupzf9GAXYVxEo9BLc7uNqPgSLTUSuWURmAn7rIpKEW4+P2A4mpwJ72p/JzuJ/Y/QEJY7BNWNr/pOQQ+3/Mi3UEYcJ0I83+qbnsT1sRR4RATEfbDhA==
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27a::6)
 by DU0PR10MB5897.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Wed, 10 Jan
 2024 19:58:26 +0000
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1d27:5dfc:9d95:798]) by PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1d27:5dfc:9d95:798%3]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 19:58:24 +0000
From: "Cetin, Gokhan" <gokhan.cetin@siemens.com>
To: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH v2] initramfs-crypt-hook: Add required kernel modules for upstream kernel
Thread-Topic: [isar-cip-core][PATCH v2] initramfs-crypt-hook: Add required
 kernel modules for upstream kernel
Thread-Index: AdpD10I5brgI2MPbReKS7nA0qt3gowACn8KAAAZ9FXA=
Date: Wed, 10 Jan 2024 19:58:24 +0000
Message-ID: 
 <PRAPR10MB54221B45AFE5B9B87A21314B80692@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
References: 
 <PRAPR10MB542260589618B60AAA1B6B1E80692@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
 <2d27dee9-fd70-44a6-a8ad-bd31c0f2f735@siemens.com>
In-Reply-To: <2d27dee9-fd70-44a6-a8ad-bd31c0f2f735@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=6fe9d2f3-f0de-45f3-8a44-8da8a32b93ec;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-01-10T19:32:12Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAPR10MB5422:EE_|DU0PR10MB5897:EE_
x-ms-office365-filtering-correlation-id: 2425ba30-89de-4c27-e150-08dc12168136
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 MIqyktL/kb1D7/zLximjdZpASNfHasy92528yPvqkPuSQFnLbfWZ94yusToyhUifGIUuX8jsIV3XDqx8nPqTHSvXhUWKfLdIe0rDuvi/a7CXt5I7AvSi2d3A80Mxjpx9GBviC5Yq9e0ay5tXkLKV9oe+4B4hoMvGU8S5mJhK+LLpV9LgeKCCHjBkU7mZ4ONfxbFZAvtupaDybZLO4plkg+mVjS5B1Md/gYt0A1yzfzVUSkfbOLbcmzZuceyBD0t9exbz4HLDviN+SVX/vhQSB7E8kjAmyFKI8uYgttwraY/mb/GnojuOtMBCYJSg5v/dIqaj2PrT+U7rLq4z7JySpfEhH9ZGM5hhyN3LPUopFxh3nufxDufzdGZWDYa16OijHSVMlFFxV/W9DcvZTJffBNU+3KsDp0HpPgOoTTgfbRvtyeQxDOB7vKEBNYYY+MXPK+D032fGP8WBLPREJ5lJvXqp/obPnFX8gbyR/JCmKDtoqfxqkl/ZtYVqUakX9qMmQ77bAAb+KoPQk5TvfvpLNVTC7W0BXgopO1xscV91TSunL/hsveBALKNqoakjjJyR9wNvZloRkYajQGx9AGCjSZV2Fo8F8smYwJ4I7SlKuk0PWZl3U0i3TiWfQTmip+pA
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(53546011)(26005)(38100700002)(71200400001)(9686003)(478600001)(7696005)(6506007)(64756008)(2906002)(66556008)(107886003)(83380400001)(5660300002)(4326008)(66476007)(316002)(76116006)(8676002)(8936002)(66446008)(52536014)(110136005)(38070700009)(66946007)(122000001)(33656002)(86362001)(82960400001)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WWdrcjg4WE1hZ1FBT3FHdDk0aEpjTlJPSnMyTGhiZ2ZzRlZoeURKUXFJZGZC?=
 =?utf-8?B?WW5UZEVBVTRkaVNPb2p0UzZHK0l3QmFjOEl6L2dxV3YxeXI1cC9TUTRrek5D?=
 =?utf-8?B?ZTZCeU9xVDVWRENyS3lDcTZ3VjNGSXFjK1BmTzJGS255M0xud1A4NzgrL3pT?=
 =?utf-8?B?QWZ1WU5rcG1VSjZscGg3cTRnYlpDRkhod3hQSGhZUWZPZUJEY0VUclBUZkpH?=
 =?utf-8?B?cEk2M3ZtNTY5K1VVRUxsL1NnK1NjUmh5YktBNXUrOWNJWHhkdmFDTko4V3dS?=
 =?utf-8?B?NXdtMWlzQ0lNaXZzMGgzdnNIanBFWCtYcWhtZDIvNTVyKzI4RU9BUHNqWVNs?=
 =?utf-8?B?MlE5UXRGVEtiSHBpa0Vuank0U2tVUytseUZ0OTM5NHBSdGM0R3BhYnZaUHZz?=
 =?utf-8?B?aCtWc24vNDZjYnJLcG9WN2poY2IzMWY2NDMxK3lNQVdmZFRWSkdEU3dQVWZV?=
 =?utf-8?B?TmNhYjVzeGRzMVF5WUN1Wk05bGZ4SVhjb0phOGV4eTh6NDBVbFBQNEY2U0t5?=
 =?utf-8?B?aWUxbzArNmtONjltdDNJSGZsWVdheERpekVYdWowdy92bVFudERxMDBQNUZ5?=
 =?utf-8?B?T1VTVUNySFJ1cXczS0VTZG54YndGZXdHSEE4Nk9FS1FaYldVYXQvZU1lZEhR?=
 =?utf-8?B?NWFiTEFmMFdFZzdMV1l4Rnd2Q2JTYW5CZUV4Zkc3WFBWYVlxeUd3MkZHMkt5?=
 =?utf-8?B?RlBsSlk0TEUxMUtJMVZ6VTlVTHRKenREVTY2akk5YXRkRllya002RDBQY0NY?=
 =?utf-8?B?cTBBeXBneTJocTJSRmRCTVdDekNXT2FqWS9HakpzY0RsU2JTaDZmb0t6ZFIr?=
 =?utf-8?B?RjhKT2NYYnZvZDRuSU1JdHM1dUpoS1RnRWFNK3dnK2VIYkhqV2QyWGRuQlVQ?=
 =?utf-8?B?NmxNd3RONktlR2pXMkZocGYzMi90NXBaSU9HUUg3N3dYUnNybTVmYTZZTnNJ?=
 =?utf-8?B?cFFqZEY4TUVpZWFDZEVPMTdMRCt2eWFha2ZNOFB6MGM4TklYVEdoeit3bXNl?=
 =?utf-8?B?QVJjak4vQkpUcTB0QUJ5cVFId01XaEtTUlhvQWxsdnNaQ0lpcFE2WGl2cmNm?=
 =?utf-8?B?RTN1a3J0UkdHU0p0OFRZeThsM3BiSTdXRmFtWlVHRVpyL20xbC9NTWRBNTJ5?=
 =?utf-8?B?RHpyR21XVGJTbWhzN3VCWWNBMGNKWk1vbnZiVllCY2pndGtoYlkwTUxlZlZQ?=
 =?utf-8?B?QnhtMjh6L3JpY0phb1Uwb3pncllxWVczSDdqVnBrdmJKa0RIdzRhK0NPYUYr?=
 =?utf-8?B?d3hnWWxETlN6bGtSQk41NWw4bE1rMHV5dEk5V2JvaE55L1VzTkxPdDZtbDlJ?=
 =?utf-8?B?UXFaY3p5R05pbGE1YXhMMEg5UHFrRGhnblpSOFh2TE5PTHRoZVlLK2pyZFZs?=
 =?utf-8?B?TUY5NFdrTHQwSkU5Y1QzQnh5VjV1RGlyMFNTQ095emlBK1pIN2tzd25INEtv?=
 =?utf-8?B?K1Ezc0l5bmhxbkJZcjNaa2xVQjdxOXA0dzlXOTg5NVpYOVpKQjdsZDQzOHF5?=
 =?utf-8?B?UTNwRXdlUXZraWZHNmpHcDhISVFtOTBic0JlaEZoYzlFbms0bHFlQjNMQmJS?=
 =?utf-8?B?VlJFVElxQ0IxeWh1bVNSN2RtWUhlR2duNkJLUUdPL0crVmhwSjI1M1ZSbzZr?=
 =?utf-8?B?YURtL3c1QXBwMmFsbXdZNmd3azcvZkRkdGp4N3hJK1NQK05Dei9kT0gvblRu?=
 =?utf-8?B?bThlaDJIR2VDSFZBUFJCRzF6MlJ2bnJGbEx0VE5XanJJYkltaFFrTGlvdi9w?=
 =?utf-8?B?UmY5STNTZk9PTU5NZHJHeVRxNEN6YnRWVThYV01XbGI2WG1ScFRrcURhVjJv?=
 =?utf-8?B?b3A4Sm8veTIwak1FVkt1M3lvS3RIQVpxMVBUY2Z2dUxIOHlORlhjK01LenRv?=
 =?utf-8?B?ODlaMWllQ3dYTWhWOW85M1pFSi9mNkh6YzVSSEsxaDhjeHp0ZThRUTIrR3M0?=
 =?utf-8?B?Q3JTQTB5MEFOK29lVDVyTnNNdVM5NzAxYXpXSk9JcWdLOG5lVmozdE02UzZV?=
 =?utf-8?B?MHdoNGJMWUZrMk43bnppYThYaXA1QW9XajQzdDRiR3FXOFFLVG9lNmNuUnps?=
 =?utf-8?B?UkYrMXZVU0RESXFLMEdxdVFKMFg3NWlmNGp3OXEra1lwTGdBSWh1YnJxK3hV?=
 =?utf-8?Q?nHsUmchpxagtdBLkWIXW1npFn?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2425ba30-89de-4c27-e150-08dc12168136
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 19:58:24.5784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RFU5rEx2XNfMAYu0ZsPQ24ty/88bU7HHJ5bcCIkBjHwPiAhvgimhSlsqbLGWpuMN5RB7bomY3S3Kc70X409nsLsfmm+4ClhV3ZYZH42wH4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5897
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Jan 2024 20:02:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14326

PiBPbiAxLzEwLzI0IDE2OjEzLCBDZXRpbiwgR29raGFuIChBRFYgRCBFVSBUUiBDJkUpIHdyb3Rl
Og0KPiA+DQo+ID4gVGhpcyBhZGRzIG5lY2Vzc2FyeSBjcnlwdCBtb2R1bGVzIGFuZCBsb29wIGRl
dmljZSBpbiBjYXNlIHRoZXkgYXJlIG5vdA0KPiA+IGxvYWRlZCBhdCBlYXJseSBib290IGFzIGRl
ZmF1bHQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHb2toYW4gQ2V0aW4gPGdva2hhbi5jZXRp
bkBzaWVtZW5zLmNvbT4NCj4gPiAtLS0NCj4gPiAgIC4uLi9maWxlcy9lbmNyeXB0X3BhcnRpdGlv
bi5jbGV2aXMuaG9vayAgICAgICAgICAgICAgICAgICAgfCA1ICsrKy0tDQo+ID4gICAuLi4vZmls
ZXMvZW5jcnlwdF9wYXJ0aXRpb24uY2xldmlzLnNjcmlwdCAgICAgICAgICAgICAgICAgIHwgNyAr
KysrKysrDQo+ID4gICAuLi4vZmlsZXMvZW5jcnlwdF9wYXJ0aXRpb24uc3lzdGVtZC5ob29rICAg
ICAgICAgICAgICAgICAgIHwgNyArKysrKy0tDQo+ID4gICAuLi4vZmlsZXMvZW5jcnlwdF9wYXJ0
aXRpb24uc3lzdGVtZC5zY3JpcHQgICAgICAgICAgICAgICAgIHwgNyArKysrKysrDQo+ID4gICA0
IGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0DQo+ID4gYS9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtaG9v
ay9maWxlcy9lbmNyeXB0X3BhcnRpdGlvbi5jbGV2aQ0KPiA+IHMuaG9vaw0KPiA+IGIvcmVjaXBl
cy1pbml0cmFtZnMvaW5pdHJhbWZzLWNyeXB0LWhvb2svZmlsZXMvZW5jcnlwdF9wYXJ0aXRpb24u
Y2xldmkNCj4gPiBzLmhvb2sNCj4gPiBpbmRleCAzN2IzNzNjLi5iY2ZlODg1IDEwMDc1NQ0KPiA+
IC0tLQ0KPiA+IGEvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWNyeXB0LWhvb2svZmlsZXMv
ZW5jcnlwdF9wYXJ0aXRpb24uY2xldmkNCj4gPiBzLmhvb2sNCj4gPiArKysgYi9yZWNpcGVzLWlu
aXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtaG9vay9maWxlcy9lbmNyeXB0X3BhcnRpdGlvbi5jDQo+
ID4gKysrIGxldmlzLmhvb2sNCj4gPiBAQCAtMzQsOCArMzQsOSBAQCBtYW51YWxfYWRkX21vZHVs
ZXMgdHBtX2NyYg0KPiA+ICAgbWFudWFsX2FkZF9tb2R1bGVzIGRtX21vZA0KPiA+ICAgbWFudWFs
X2FkZF9tb2R1bGVzIGRtX2NyeXB0DQo+ID4NCj4gPiAtIyBhZGQgY3J5cHRvIG1vZHVsZXMgZm9y
IGRlYmlhbiB1cHN0cmVhbSBrZXJuZWwgLW1hbnVhbF9hZGRfbW9kdWxlcw0KPiA+IGFlc25pLWlu
dGVsDQo+IA0KPiBPbiB3aGljaCBIYXJkd2FyZSBkaWQgeW91IHRlc3Q/IElmIGkgcmVtZW1iZXIg
Y29ycmVjdGx5IGFzbmktaW50ZWwgd2FzDQo+IG5lY2Vzc2FyeSBmb3IgdGhlIGlwYzIyN2UuDQo+
IA0KPiBSZXFhcmRzDQo+IFF1aXJpbg0KDQpIaSBRdWlyaW4sDQoNClRoZSBpbml0aWFsIGZpbmRp
bmdzIHdlcmUgbGlrZSB0aGlzLCBidXQgd2UgcmVhbGl6ZWQgdGhhdCBpbnN0ZWFkIG9mIGFlc25p
LWludGVsLCB0aGVzZSAzIGNyeXB0byBtb2R1bGVzIHdlcmUgc3VmZmljaWVudCBhbmQgbW9yZSBn
ZW5lcmljLg0KV2UgdGVzdGVkIGl0IG9uIHNldmVyYWwgZGlmZmVyZW50IChub24tU2llbWVucy1J
UEMgeWV0KSB4ODYgYmFzZWQgZGV2aWNlcy4gQWxzbyBxZW11IGFuZCB2aXJzaCBhbHNvIGNvbmZp
cm0gdGhpcyBiZWhhdmlvci4NCg0KQmVzdCwNCkdva2hhbg0K

