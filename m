Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD92E7D247
	for <webhook@archiver.kernel.org>; Tue, 26 Sep 2023 07:42:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.13862.1695714110753233788
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Sep 2023 00:41:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 38Q7fm282640623; Tue, 26 Sep 2023 16:41:49 +0900
X-Iguazu-Qid: 2yAaOS3aFTPK0Bllhb
X-Iguazu-QSIG: v=2; s=0; t=1695714108; q=2yAaOS3aFTPK0Bllhb; m=+DyJgTIVfbhgKUQUMU5oMrxljkx/qv6eXicP0jmRYQs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 38Q7flji1349857
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Sep 2023 16:41:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZEvLjGb81tErbOC5JoyCgqIvME//AXtDyGgMJzox88A84OM14h71EiZTb+BrY7vP5WW+ttGRqsfmDqymEfzBOZnawDSIblAkIQEp70YqsgePvuQqF7FP0C+ogYyPjSDnHFy6zs9ZESKc892uSPbbJIV4cMvG/9ljON6bWzMwEZNNLea2c5qTs0ai2wotzFEx/ygrTnVgsHTTp/pgvFGPyXBXb8gtWcRxjkGlMquAb9x/ciuEJtRCj5UTKEskIdw59Wlqfwv7IaRwQMtHqvrDH5qedwhxkpEJOrLWjYQw0vIjWnenbR1Xcm2LsfyLNhVO1VIjpDwXysbO656JVCf5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu1PrP/SuIfnQ8hiK+jnXUpvnL8EEBGI3EE7t2JBGWo=;
 b=f9Gu8cfto5lUwLyO3sKoZcCTMFpfF+YUnYK6ZXueBocSkeZOg0gmrqRIfIX++CK7r1y9iG2wfDBNyX9H8weBXNkhcjayDraE72n6/4PLddz5UKoqx5EmYojympaR/2GyFO+UU7IGANXv4mm1nwUOY7ER/VxHi7Xu/z8Zc3JvjmbMQRRk4pdiiw156HHQnMpAsj0n05Dy0SqheKDTQz+tybKmgeCEpcyta/ocHfi/bbF0ed9bO+dMZ1IIoste940AFU9e5+pJTh4u0W1q58eyC72NKIhyILcE7KIyPdHr0znkZCCfembfgZrtD4KrvbjIp8sxZuAFPXWGaxzz0KtH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core v2 2/2] images: Add dosfstools as
 DEPENDENCY to all images
Thread-Topic: [cip-dev] [isar-cip-core v2 2/2] images: Add dosfstools as
 DEPENDENCY to all images
Thread-Index: AQHZ79GGhLKVE9lXv0qVxVfC45Iv2bArx3YAgACLvPCAAF5dAIAAAhpg
Date: Tue, 26 Sep 2023 07:41:44 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB5542F6668A8E93B4E2A1E290A4C3A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <51a07da1-b0a1-4a3b-b463-739e3ea208f2@siemens.com>
 <20230925165833.2696-3-venkata.pyla@toshiba-tsip.com>
 <ce684bce-a09d-4313-b231-132737797f21@siemens.com>
 <OSYPR01MB55424C7B8414E7DC51BA0B72A4C3A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <ccb993fd-4053-4d6c-96e2-1d182a9b765b@siemens.com>
In-Reply-To: <ccb993fd-4053-4d6c-96e2-1d182a9b765b@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|OSZPR01MB8545:EE_
x-ms-office365-filtering-correlation-id: e4ebe8b4-80fd-4aee-72ed-08dbbe6407fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 3/zocFNGMcDuP3ldIDwgbakemcr1gW9TNCduCFF7hEfTKoWp86Fnn79vizu2geglCcyeTEXUAjEf/CBUTy76reNXvzUSBiN96h8r7/lPXF47fPJwQns2NlzvxDLgwvxyvUpwEBQzhTCvRCBCdiXOx51eAAhJcRnrGR3NAs8t8c+dNI37v2k/kraIeIDVPQnR5ShS9qyk3yVTDzFi3lQhlfo21U0sDHS8u7rGEpZqy+KBbqBG7ElFFWbuvEl5gCPoTLizP/SRlo6uhQkZfIxKeRe1izPAFB5OkPmeZ2oy5p+n2wqpI5QSyd5ROKbesD5DHIkjpXcFYwF0M9mP1wYGh8lgs9gVyd5tDwfbkZ9hP7adtHd90Kh/v8tUCkeDlgMDWy+2tSgjCLOCMzvhvwe5DKN0fpTEk5NltSm/zy/xd0XMOvF7ydj+W9uoFR6vKC5x4QHanQfDItFJX0O9eRWUpXIlur3q5CjfFr8Zzp2laS3B3zRI+vVZqyfwy4FMCmP8mzq3bHtf5wA+OAkspmy3XMz1N6jAJxMkGzgeTZFKBA8QRHPu3CrzMrtnDtaaGw9brIAptS7nqkxkRmGSiL7IWfLVl1/mebCAf0gyna8Tw5RdL5Vx6Qx3a7HuBh+P/XjW
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(76116006)(55016003)(4326008)(107886003)(83380400001)(26005)(8936002)(8676002)(316002)(66556008)(52536014)(478600001)(41300700001)(110136005)(66946007)(66446008)(64756008)(54906003)(9686003)(55236004)(53546011)(5660300002)(2906002)(66476007)(71200400001)(6506007)(7696005)(122000001)(85182001)(33656002)(38100700002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QVlBR25hcVIvRmhSSTdJd2wxTldSNjU5OUtnZkViSHJFOUtWbjhsSXNBcW9Z?=
 =?utf-8?B?S1BZSGJZMjRnU1F5MDhXSzk5Q1dHNmdmNUdDWE1MZXd4blpvNDFlcjZ0WkMx?=
 =?utf-8?B?azBtRkZET040VFRtaTRlL2JSdkZmZ05IQ1ZKK01oeHo2SUgzbGZ4VlZzckx6?=
 =?utf-8?B?VTBrNjdYTklIMGdUZnVRdjlZZzVUOUx5NG93cGd0b0pqZUJTcml3YlRISlRK?=
 =?utf-8?B?R2YwUm9ycXVBcDZ1aHNVMXQ2SFA0eXM0Zi83T0grcjIrQzkvdVpvaFlBWHpv?=
 =?utf-8?B?WExzRjdLbHkxMWpBY1cxZ3Y0Z0czNnpLYXFGR1VLWTBWZmxEZUd5Y25QY3BD?=
 =?utf-8?B?ejNhZy9EUUJiMWVvd0d5ZWx1bmE2M2c2VnRZaHl3RkZGUlA2cnZzS2NVVDdk?=
 =?utf-8?B?SU10c255YU1SbklKM3owTTlxTHc4YzBPTmpoTnBDWm1MdzV5Tk1hMGFMQXp6?=
 =?utf-8?B?SVFHa2xaZW5CY3FMOUtjZjhXOHh2dFhPTlFKdDRjSklnVlo0SWFkcUgrb1ho?=
 =?utf-8?B?NUNFS1VIWk1MdWRHd05MSnJFOHZiTEtOZ09OUXloZVJQcnVrblVFSnVmNlk1?=
 =?utf-8?B?VU5zMGVVdDYxcHlCaGwzYWc2SlZDMThEamJQTlVzQnQ0TXk2WDREb2NHSnJ5?=
 =?utf-8?B?ZDJETm1md0UvdnlUaHc5c1hLSmhzUDBmV3JkenhuMDA2a0VWMFFkZ25KNUpM?=
 =?utf-8?B?UGhxK1lpYTF6elJDK3NzUzhKOWg2WjdjSWhjeExicy9rTzVhUHJXT2I1dDZC?=
 =?utf-8?B?a2p2QkFCRFZFcXorRTlLTWp0ZFp5VXVDREVwNG9VMnBVcCs1U0dDMm1mb2lT?=
 =?utf-8?B?TmFodXp0eFViWnB1N0lxM0hZVXRSRk9CT2VHQlhLdHA4MWVRMy94SHo5Mkd2?=
 =?utf-8?B?VlZNQk16Mnl5V1RIRFlCQXVJcDVtWmtBblhuNzJQOWRUYnRZcjNXMFpLT3lH?=
 =?utf-8?B?OVRiaUVSZVlFa253dTUwcG14aW9mT0F5V3B3YjIrdy9tVTJOTlZOdTkzd1Bp?=
 =?utf-8?B?Vk9GeDR3YzY3eDVDSEpNajN3NGJGakdGVjBjV1lKVnhUZ21yeXdQWkdSM3ZX?=
 =?utf-8?B?c3VIRFBqUXIxMGE1bW9RbmovcFFIZzBvb213a2VzNEF6dCtsSGFaajJBTk9w?=
 =?utf-8?B?SDZkNTAxeVhuNk9tL2drQUlJVFFsQTJIUFAzQzJEZ0R0Vm12YmwvQUJLdm5r?=
 =?utf-8?B?Q0Q4TnFLQmd4Mm1zRHIrNnFOYWJLV2lXTzZsdnNzVk9BaGQrZC9DbXBGQmR3?=
 =?utf-8?B?VXUxYlNpcnhZSjFac1hVcTRpeVF0dHRPa285SWJWa3lJWWRFRC8zRUhmYjhR?=
 =?utf-8?B?SjhIc1pybE8wTFNEb1M5cGpYZENwZXVFZEIrK3dIN1ltM0xGTjBEYTFXdDdk?=
 =?utf-8?B?YjUzd2paS08rdTVHb0p6M0YxSWhzbjZwc1ZoLzNBSSs1clpkcnEwQStsQ1Rr?=
 =?utf-8?B?Tkh2MkxzOEl5V3E1Rm5SeDFhRHVkekNla055enVYSzd4S05nNkxIVEhjNW4y?=
 =?utf-8?B?dHlMcE9OQnlxYWcrajZOSVpiZTNuRmpvRXB6YitYQ3FuR3dEMGJMbUo5Y2d1?=
 =?utf-8?B?alE5cmJKaStXSjN3V0QyWVVHWENMQmxVdmx1a0hWMStJRnZMdFlVOGdhZXJJ?=
 =?utf-8?B?d1ZSQjB6eXd2OVN3NVNBUk03V2diSlZLbi9zQk5uNDRVWGNNN01kWi9qY0pj?=
 =?utf-8?B?WWw2MTVCdGE2WmJKSllLVDJKQjh1eVNxUVZQbWdqaEhaRDRXWWk1bFBacUph?=
 =?utf-8?B?UEZndjBsWlpNaFlQbXpPWFNFcUp6djFieDFvODZwM1VVdkdyOWlYNXBRc1p2?=
 =?utf-8?B?RjMycFB6ZGZmekdGakFvSFVSTVdIdlhnMWtPbnVkVGFxMVZBY0E3TXpDUGFz?=
 =?utf-8?B?STRVTDVubTJqQWh1cXpQYURIdkluWEdtTC94L01OR0tCc2drWTRkNExxS2Fp?=
 =?utf-8?B?cEIwSEROU0k0Qkp4bVYrbDI4S2thOFVFL0thb3NEMFhkODRpNjNhTHFJWjRa?=
 =?utf-8?B?Z2RLbm9jcHIwSFhIaDk5RmNsdW1TME1pV0ZCUVB6RW5BQ2Z6eUpMUlhySWI1?=
 =?utf-8?B?UndCRU9PTzA2ZFJ2MW1reEdQcmJmZlBUNGs3WXk0aFNWV3BLRVhLeFdWVWVP?=
 =?utf-8?B?TEhOQ2xJM0FRYUZvV0RXNU5VWVdFeEdNakhBNTFxbVg0cHdZR1h1bHRxVWgz?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ebe8b4-80fd-4aee-72ed-08dbbe6407fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 07:41:44.2326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VpFTfgik7tmIOu5w3LGfL3s4NMSL8xOAhuYtRgPJzBECbjEMN5ST1aKVqS1FmMyOpbh+CKHFnjFY6SQ7YKbWJOIA4CQ4UfP5Bud2sFBKPVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8545
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Sep 2023 07:42:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13225

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8amFu
Lmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDI2LCAyMDIz
IDEyOjQxIFBNDQo+IFRvOiBweWxhIHZlbmthdGEo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0
aW5nKSA8VmVua2F0YS5QeWxhQHRvc2hpYmEtDQo+IHRzaXAuY29tPjsgY2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmcNCj4gQ2M6IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgVE1JRUMgT0RH
IFBvcnRpbmcpIDxkaW5lc2gua3VtYXJAdG9zaGliYS0NCj4gdHNpcC5jb20+OyBoYXlhc2hpIGth
enVoaXJvKOaelyDlkozlro8g77yk77yt77ylIOKXi++8pO+8qe+8p+KWoe+8re+8sO+8s+KXi++8
re+8sO+8lCkNCj4gPGthenVoaXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+DQo+IFN1YmplY3Q6
IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNvcmUgdjIgMi8yXSBpbWFnZXM6IEFkZCBkb3Nmc3Rv
b2xzIGFzDQo+IERFUEVOREVOQ1kgdG8gYWxsIGltYWdlcw0KPiANCj4gT24gMjYuMDkuMjMgMDM6
MzksIFZlbmthdGEuUHlsYUB0b3NoaWJhLXRzaXAuY29tIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPg0KPiA+PiBPbiBCZWhh
bGYgT2YgSmFuIEtpc3prYSB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+ID4+IFNlbnQ6IE1v
bmRheSwgU2VwdGVtYmVyIDI1LCAyMDIzIDEwOjQzIFBNDQo+ID4+IFRvOiBweWxhIHZlbmthdGEo
77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8VmVua2F0YS5QeWxhQHRvc2hpYmEtDQo+
ID4+IHRzaXAuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gPj4gQ2M6IGRp
bmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gua3VtYXJA
dG9zaGliYS0NCj4gPj4gdHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g77yk
77yt77ylIOKXi++8pO+8qe+8p+KWoe+8re+8sO+8s+KXi++8re+8sO+8lCkNCj4gPj4gPGthenVo
aXJvMy5oYXlhc2hpQHRvc2hpYmEuY28uanA+DQo+ID4+IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0g
W2lzYXItY2lwLWNvcmUgdjIgMi8yXSBpbWFnZXM6IEFkZCBkb3Nmc3Rvb2xzDQo+ID4+IGFzIERF
UEVOREVOQ1kgdG8gYWxsIGltYWdlcw0KPiA+Pg0KPiA+PiBPbiAyNS4wOS4yMyAxODo1OCwgdmVu
a2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20gd3JvdGU6DQo+ID4+PiBGcm9tOiB2ZW5rYXRhIHB5
bGEgPHZlbmthdGEucHlsYUB0b3NoaWJhLXRzaXAuY29tPg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1v
ZmYtYnk6IHZlbmthdGEgcHlsYSA8dmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20+DQo+ID4+
PiAtLS0NCj4gPj4+ICByZWNpcGVzLWNvcmUvaW1hZ2VzL2NpcC1jb3JlLWltYWdlLWtlcm5lbGNp
LmJiIHwgIDEgKw0KPiA+Pj4gcmVjaXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS1zZWN1
cml0eS5iYiB8ICAxICsNCj4gPj4+ICByZWNpcGVzLWNvcmUvaW1hZ2VzL2NpcC1jb3JlLWltYWdl
LmJiICAgICAgICAgIHwgIDEgKw0KPiA+Pj4gIHJlY2lwZXMtY29yZS9pbWFnZXMvY29tbW9uLWlt
YWdlLmluYyAgICAgICAgICAgfCAxMyArKysrKysrKysrKysrDQo+ID4+PiAgNCBmaWxlcyBjaGFu
Z2VkLCAxNiBpbnNlcnRpb25zKCspDQo+ID4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHJlY2lwZXMt
Y29yZS9pbWFnZXMvY29tbW9uLWltYWdlLmluYw0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9y
ZWNpcGVzLWNvcmUvaW1hZ2VzL2NpcC1jb3JlLWltYWdlLWtlcm5lbGNpLmJiDQo+ID4+PiBiL3Jl
Y2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1hZ2Uta2VybmVsY2kuYmINCj4gPj4+IGluZGV4
IDQ3OWMxNGMuLjhhNThlN2IgMTAwNjQ0DQo+ID4+PiAtLS0gYS9yZWNpcGVzLWNvcmUvaW1hZ2Vz
L2NpcC1jb3JlLWltYWdlLWtlcm5lbGNpLmJiDQo+ID4+PiArKysgYi9yZWNpcGVzLWNvcmUvaW1h
Z2VzL2NpcC1jb3JlLWltYWdlLWtlcm5lbGNpLmJiDQo+ID4+PiBAQCAtMTAsNiArMTAsNyBAQA0K
PiA+Pj4gICMNCj4gPj4+DQo+ID4+PiAgaW5oZXJpdCBpbWFnZQ0KPiA+Pj4gK3JlcXVpcmUgY29t
bW9uLWltYWdlLmluYw0KPiA+Pj4NCj4gPj4+ICBERVNDUklQVElPTiA9ICJDSVAgQ29yZSBpbWFn
ZSBmb3IgS2VybmVsQ0kiDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtY29yZS9p
bWFnZXMvY2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHkuYmINCj4gPj4+IGIvcmVjaXBlcy1jb3JlL2lt
YWdlcy9jaXAtY29yZS1pbWFnZS1zZWN1cml0eS5iYg0KPiA+Pj4gaW5kZXggMzQyMWNlNS4uZjEx
NDk3NCAxMDA2NDQNCj4gPj4+IC0tLSBhL3JlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1h
Z2Utc2VjdXJpdHkuYmINCj4gPj4+ICsrKyBiL3JlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUt
aW1hZ2Utc2VjdXJpdHkuYmINCj4gPj4+IEBAIC0xMCw2ICsxMCw3IEBADQo+ID4+PiAgIw0KPiA+
Pj4NCj4gPj4+ICBpbmhlcml0IGltYWdlDQo+ID4+PiArcmVxdWlyZSBjb21tb24taW1hZ2UuaW5j
DQo+ID4+Pg0KPiA+Pj4gIERFU0NSSVBUSU9OID0gIkNJUCBDb3JlIGltYWdlIGluY2x1ZGluZyBz
ZWN1cml0eSBwYWNrYWdlcyINCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3Jl
L2ltYWdlcy9jaXAtY29yZS1pbWFnZS5iYg0KPiA+Pj4gYi9yZWNpcGVzLWNvcmUvaW1hZ2VzL2Np
cC1jb3JlLWltYWdlLmJiDQo+ID4+PiBpbmRleCAwZWM3MjIwLi43MTFkM2QzIDEwMDY0NA0KPiA+
Pj4gLS0tIGEvcmVjaXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS5iYg0KPiA+Pj4gKysr
IGIvcmVjaXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS5iYg0KPiA+Pj4gQEAgLTEwLDYg
KzEwLDcgQEANCj4gPj4+ICAjDQo+ID4+Pg0KPiA+Pj4gIGluaGVyaXQgaW1hZ2UNCj4gPj4+ICty
ZXF1aXJlIGNvbW1vbi1pbWFnZS5pbmMNCj4gPj4+DQo+ID4+PiAgSVNBUl9SRUxFQVNFX0NNRCA9
ICJnaXQgLUMgJHtMQVlFUkRJUl9jaXAtY29yZX0gZGVzY3JpYmUgLS10YWdzDQo+ID4+PiAtLWRp
cnR5IC0tDQo+ID4+IGFsd2F5cyAtLW1hdGNoICd2WzAtOV0uWzAtOV0qJyINCj4gPj4+ICBERVND
UklQVElPTiA9ICJDSVAgQ29yZSBpbWFnZSINCj4gPj4+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWNv
cmUvaW1hZ2VzL2NvbW1vbi1pbWFnZS5pbmMNCj4gPj4+IGIvcmVjaXBlcy1jb3JlL2ltYWdlcy9j
b21tb24taW1hZ2UuaW5jDQo+ID4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+Pj4gaW5kZXgg
MDAwMDAwMC4uODYzZjgxNw0KPiA+Pj4gLS0tIC9kZXYvbnVsbA0KPiA+Pj4gKysrIGIvcmVjaXBl
cy1jb3JlL2ltYWdlcy9jb21tb24taW1hZ2UuaW5jDQo+ID4+PiBAQCAtMCwwICsxLDEzIEBADQo+
ID4+PiArIw0KPiA+Pj4gKyMgQ0lQIENvcmUsIGdlbmVyaWMgcHJvZmlsZQ0KPiA+Pj4gKyMNCj4g
Pj4+ICsjIENvcHlyaWdodCAoYykgVG9zaGliYSBDb3Jwb3JhdGlvbiAyMDIzICMgIyBBdXRob3Jz
Og0KPiA+Pj4gKyMgIFZlbmthdGEgUHlsYSA8dmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20+
ICMgIw0KPiA+Pj4gK1NQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBNSVQgIw0KPiA+Pj4gKw0KPiA+
Pj4gKyMgSW5zdGFsbCBpbiBidWlsZCBzeXN0ZW0gZm9yIGNyZWF0aW5nIHJlcHJvZHVjaWJsZSBE
T1MgZmlsZXN5c3RlbXMNCj4gPj4+ICtERVBFTkRTICs9ICJkb3Nmc3Rvb2xzIg0KPiA+Pg0KPiA+
PiBXaHkgdGhpcyBub3c/IFBhdGNoIDEgaXMgYWRkaW5nIGl0IGFzIElNQUdFU19CVUlMRF9ERVBT
LCBhbmQgdGhhdA0KPiA+PiBzaG91bGQgYmUgZW5vdWdoIGFzIHlvdSBjb3JyZWN0bHkgYW5hbHl6
ZWQuIERvIHdlIHdhbnQgdGhhdCBjaGFuZ2UNCj4gPj4gcmF0aGVyIGluIGNvbmYvZGlzdHJvL2Np
cC1jb3JlLWNvbW1vbi5pbmM/DQo+ID4NCj4gPiBJdCBpcyBub3QgcmVxdWlyZWQ7IEkgd2FzIGNv
bmZ1c2VkIHRoZW4gd2l0aCB5b3VyIGNvbW1lbnQgSSB0aG91Z2h0IHlvdSBhcmUNCj4gZXhwZWN0
aW5nIHRoaXMgY2hhbmdlIGZvciBzb21lIHJlYXNvbi4NCj4gPg0KPiA+IElmIHlvdSBhZ3JlZSB5
b3UgY2FuIGRpc2NhcmQgdGhlIFBhdGNoIDIuDQo+IA0KPiBPSywgYnV0IHRoZSBxdWVzdGlvbiBy
ZW1haW5zIG9uIHBhdGNoIDEgaWYgd2Ugb25seSB3YW50IHRvIGluY2x1ZGUgdGhlIHRvb2wgaW4N
Cj4gdGhlIHJlcHJvZHVjaWJsZSBtb2RlIG9yIHVuY29uZGl0aW9uYWxseS4gSW4gdGhlIGxhdHRl
ciBjYXNlLCBteSBzdWdnZXN0aW9uDQo+IGFib3ZlIHdvdWxkIGNvbWUgaW50byBwbGF5Lg0KDQpJ
IGRpZG7igJl0IHVuZGVyc3RhbmQgeW91ciBxdWVzdGlvbiBwcm9wZXJseSB0aGVuLCBJIGFtIHBh
c3RpbmcgeW91ciBjb21tZW50IGFnYWluIGFzIGJlbG93Lg0KDQo+PiArICAgIElNQUdFUl9CVUlM
RF9ERVBTICs9ICJkb3Nmc3Rvb2xzIg0KPiBUaGlzIHdpbGwgbGVhZCB0byBmdW5ueSBlZmZlY3Rz
IHdoZW4gYWxzbyB0aGUgaW1hZ2UgcmVxdWVzdHMgZG9zZnN0b29scyBhbmQgSE9TVF9BUkNILCB0
aHVzIFBBQ0tBR0VfQVJDSCA9PSBESVNUUk9fQVJDSDogSWYgdGhlIHBhY2thZ2UgaXMgYnVpbHQg
ZWFybHkgZW5vdWdoLCB0aGUgdGFyZ2V0IGltYWdlIHdpbGwgZ2V0IG91ciBjdXN0b20gdmVyc2lv
bi4gSWYgaXQgaXMgYnVpbHQgInRvbyBsYXRlIiwgdGhlIGRpc3RybyB2ZXJzaW9uIGlzIHVzZWQu
IEFsbCB0aGF0IHdvdWxkIGJlIG5vbi1yZXByb2R1Y2libGUuDQpXaGF0IGRvIHlvdSBtZWFuIGJ5
ICJpbWFnZSByZXF1ZXN0cyBkb3Nmc3Rvb2xzIGFuZCBIT1NUX0FSQ0giPyAtPiBkb3Nmc3Rvb2xz
IGlzIHJlcXVlc3RlZCB0byBpbnN0YWxsIGluIHRhcmdldCBpbWFnZT8NCklmIGl0IHNvLCBkbyB5
b3UgdGhpbmsgZG9zZnN0b29scyByZXF1ZXN0ZWQgZm9yIHRhcmdldCBpbWFnZSBNQVkgZ2V0IGl0
IGZyb20gRGViaWFuIGluc3RlYWQgZnJvbSBsb2NhbCBidWlsZD8gVGhhdCB3b3VsZCBtYWtlIGlt
YWdlIG5vbi1yZXByb2R1Y2libGUNCg0KRG8geW91IHRoaW5rIHdlIG5lZWQgYWRkIG1vcmUgc3Ry
aWN0ZXIgREVQRU5ERU5DWSBydWxlIHRoYXQgd2lsbCBpbnN0YWxsIGJlZm9yZSBpbWFnZSBpcyBn
ZXR0aW5nIGluc3RhbGxlZCBmcm9tIERpc3Rybw0KDQo+IA0KPiBKYW4NCj4gDQo+IC0tDQo+IFNp
ZW1lbnMgQUcsIFRlY2hub2xvZ3kNCj4gTGludXggRXhwZXJ0IENlbnRlcg0K


