Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D507FC05027
	for <webhook@archiver.kernel.org>; Mon,  6 Feb 2023 10:59:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.50772.1675681179287071040
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Feb 2023 02:59:40 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.153, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 316AxaFX010904; Mon, 6 Feb 2023 19:59:36 +0900
X-Iguazu-Qid: 34tIWUr8qQaYQIYPsu
X-Iguazu-QSIG: v=2; s=0; t=1675681176; q=34tIWUr8qQaYQIYPsu; m=py/Mt1bHTdvAbh2Xrqd3xCOUTUYF2foxtWiE0q8YnbM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1510) id 316AxYv2009893
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 6 Feb 2023 19:59:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bM7VlG/fbOTZHX5d/5EUFjShzRJ+coa6qUifvJf/yVHzc6eptl2VFt6a7eJYv2tv3vJbn6/8Z03GpEPGrRLYxPyt7aEkPccom2cSCGZm7WBqHOgMFaR3z+cnO2O80vgp4mOvLtSF6+tLST26VGCnDhaYeswXzT+QUiDE96mXOYVGLc7rSF5BHXbj/i9Ce8Cwi4o/CNxazDs+A9loIuKlzn3LISdV8yQG/pAqTGUXDhiZ9lXhJkLP/8rKYUIEpP8lv9CmAkcc2gJPKRr/VITMY3BswLC/P/xabqq0pZ8LClbIWBVCerIA6ibixXRS/ERGmI0peXzR50ieA9ZfKNqj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InNFsJ5DblGDKwaXHRkzuETkxFdS+HpGouB5+F5tj/k=;
 b=ZdabDwYDBS648wnSLy68AZn3wcu+ejpEz2/MFsrRVQhtKiTVdr3+GfRsYXJ/FR1u54dyaiv3SQ1VtNHwEtMOG80sD0T1MaATz5KP4iQ43LfusAUaNfFhCVTS5busew0XI83/SZihPcbEXwbpElB9eGL8nzZ0eTSZUQsJRcWdjcmP416CPE9xFfnFlpRmZWEcY/nKTOjSW0+7epiY8BALOly3h+ay33ENvyo/xHmY+Dw30pBv1SctpSY37sNq+E8p3dXYoM433YJBCCeasvMaryrFcGzp6i9Cvo4i4LuSHWQskF3jjwH07oTA+BfTn3MHLsV7ztFtlj2CxB1SrSM2dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: RE: [cip-dev] How to overwrite IMAGE_FSTYPES variable in
 loacal.conf using placement of kas file wic-targz-img.yml
Thread-Topic: RE: [cip-dev] How to overwrite IMAGE_FSTYPES variable in
 loacal.conf using placement of kas file wic-targz-img.yml
Thread-Index: Adk1lJkhdAoAy8u6THaeGpMSmHwfvAAe0fKAAAebvqAALX97gADNIjSg
Date: Mon, 6 Feb 2023 10:59:31 +0000
X-TSB-HOP2: ON
Message-ID: <OSYPR01MB5542F4E3BF06B3924FA818E3A4DA9@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <OSYPR01MB5542AD9EF2424FAEB3FE588AA4D09@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <a45a8fa0-af8e-4f3c-ab11-c6e5bb771cc1@siemens.com>
 <OSYPR01MB55424BC4715306ECD35D5396A4D19@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <c9c2cbef-4d93-e93e-75d7-644142c781f6@siemens.com>
In-Reply-To: <c9c2cbef-4d93-e93e-75d7-644142c781f6@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|OSZPR01MB8718:EE_
x-ms-office365-filtering-correlation-id: 7b35b88d-7fb2-4d77-2453-08db083139b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gME+bTMxT/dsHenoLSyGiaNP3cLz3I7pT//SBqXyeFDgpbnBYjFYqOz1cr2a2wFKbgIM4cdC324gQuo9UsKjEMlTwcLECM3k6yT90Dcbf1+RPggiN3iGKRYPiHNUdoJZgXWayyNGfPJAY2NJZXS17cnCnRYVIaG/enNuREKhAUsqeelBPOldcDyPwVFH2c0YXJ0Vj+NBcwLrc2vwOcYRFvCebNo+En6tj/DQfn5r8AiLnIWpliluuI5e2Sv7JOdJ3FQYj+/hA4+TLRLU5AyactIyscifdeTknvfNQ9qSeOdHmeoNcleRBMuK8msG7dEJ+rnNsDrvIFu1mbhqCSv7HCX5KAFNE2A04i1g3LcxVRsMBS1PF7+0JS2S03pkeBQg8J7DjXmcMKAwMNaoK7r9b+U3+j1LE8Q9cqUN6Uq7wjCGW24BxvkG3U5kR9uMlCEOE1BQmeFCzDMeJQmnx/9U2sw2Z7qP+l5gyncJT6bUKME+prC9MkJOMU7+6i2KZFpbfqdNlIfpI3aAftV1Ym0HHAdYu9QwXJj3e71uW4+MPMxpCnCk/po5wICsZDm1GQ6TmOD++qZmeTDLgZTBLcOcRI//eMhdZKlRRedxdEIUm5/V/klhZCHGiSVer/I+IMvopVQ8148catSzPfZMgVxJKae0FyH4rV8VWcs7OaXDqeco3rzAivAGBJcK34FEWHz6pw8v5qTpLcbKLsnzJyf7OA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199018)(478600001)(52536014)(85182001)(33656002)(86362001)(41300700001)(76116006)(66476007)(66556008)(66446008)(64756008)(8676002)(66946007)(5660300002)(8936002)(4326008)(2906002)(38100700002)(38070700005)(122000001)(107886003)(316002)(7696005)(71200400001)(53546011)(54906003)(55016003)(110136005)(6506007)(186003)(9686003)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkdWVkdpeGwvaG51VkdSZEV0THJjcW1hUXd0LzBIV1FmVXR3dUh5d21Yck1L?=
 =?utf-8?B?WnUrQlpZV1BQZVdRSTgrMktpMndJNWxRSnJ3SGowdlZCY1FhYlFJUGJZRlFL?=
 =?utf-8?B?WWZqT294OE1aQ3c4bUFKa1pXK1B5YjZwaTBjWG11dm8zcERQWWd0SmhGWWdi?=
 =?utf-8?B?WHFXRWNRYUVBQkttUGFiMjZWS0ZLbXVsYjcxbldhYnlLb0p6M2psTnhrRzZv?=
 =?utf-8?B?QldsN2xsbTBrUkpJSUZCcXQxU3A5RnNhVFNWcnNWQ0gyMDRpQTF1Zy8xVnJ3?=
 =?utf-8?B?MkZUTFRYS3NaaWpDNEhoQWJHbGtEUzJKTU95UUZlZHRvczZ2ZlJqQmVCQi85?=
 =?utf-8?B?anpMU2g2TFpVYjlKT3dOaHJQWmVSR3dlRUViRFQwZkZucFlCdVpCQ2ppYkJ4?=
 =?utf-8?B?bnpTd1dCOWkrUnI5N3hLTHU2ZHBHK1FrRGFDa0UwU0R3ZkIrUzRPNWtQT1Ba?=
 =?utf-8?B?T0pqSXZHZmRIeERDSC9EZmI1a2FEZisvMW9jUVlacUt0a3FsMU8rTGZ6d3Rk?=
 =?utf-8?B?b1BzSWFKemlQb2pUWC9OQXdtUzB0RzlDSUNlS0RiMCtkMmluQXNXQnpkZ0R1?=
 =?utf-8?B?cGJ0dFYyQTc5cDRCdEZyNXB1WWVSMDM0aHFWbjZPcXd4MlQwMGhzQjFHbWQ3?=
 =?utf-8?B?MkNCRnlYT3lTcEgzMEwrdDlLWU1rZHFVTitVTzBZRUgzQm1IanhFWGxsRms3?=
 =?utf-8?B?VWhaQU1oWGhOcnFoK2E4TFp3T3crYXRqbTVGenJjRmQvVDNrcmZsVkJwTjNN?=
 =?utf-8?B?RUJlZzJ2MUIrUElZZm5hV1RGTFhPbldoSzNPTS8wNUFaclVRSDlJWGMwU0VV?=
 =?utf-8?B?UE5Wa3ZjNzEwN1A3Qm1POG9nNE9FUHJiYU9KZDI5ZjlzSzJDTFNPNFRCaVBw?=
 =?utf-8?B?TE5jL1g0LzNoN1RvRlFYMmk2SEx5Mm85UTJpYXFzSXhzOVo2djVMODl6Rzdx?=
 =?utf-8?B?WGcvNzcvTzlWWFUvZlVXZFNVU0NYbGlTVkF0QVlyc3R1bHo2Rkgxakoyazhw?=
 =?utf-8?B?OHNhRnRCclBoaFA4b3Q5Y1BRUjJFaUtUN0U5TVk2Tk0vdkpxUm5ZcXVpakJp?=
 =?utf-8?B?dkR5dG1UeUlZWFN0ZWFMRm42TDNDN3NBZXNIYWZQbGpESGU3TC9kcElUWm9Y?=
 =?utf-8?B?K0JIaXlHd0dqaDRBWXM3WUhqanlkMllZcUtNRElURG5TWGFRd2FhWnVXMERN?=
 =?utf-8?B?bG9JaGFYbS80bkJHbTFJV3ZuVVFleUxCSXV2SUlDRGZ0U1hsMEoyL0Z6MlNJ?=
 =?utf-8?B?bFZlNkZKTDg5L2kvcGpsbHFXaEFtMThCMythN2NzQ1RUditwVDF4KzR3SU9H?=
 =?utf-8?B?aFJiZ1dHS2VwMlgrMFU2dFptNkFySE0rTjNPbGRDOUxiSnNBQVc4bVB6VVND?=
 =?utf-8?B?MXNxa1F1eFhXRSs3eWh1VE8waFJ6ZnBPcnowaVpFT1VGQWhPOHI3b3hJalVo?=
 =?utf-8?B?OFVwYkhjelZGNUNudzJWdjZLeEcveVlwWkdDTXVLMmtkWGpLbnRGS2xUSXYx?=
 =?utf-8?B?N3kreXJLV3lPcThLeC84WWNBWi9hQ3lVbmVKSkFFZThFSWRkOFlLUStROFpa?=
 =?utf-8?B?TnRnczJoclNuRTU1d290Tm1LMU93cmptZGk3eXZWYWh1QlhobERSMUxNU2J6?=
 =?utf-8?B?cjdrYkxQaDJKaHBWcVFRT2NRZitGdUZpSW9QaHVxL003K1BZd01YUCtQd205?=
 =?utf-8?B?bWtZSFdlSkhMdUNRRWJJeFZlMnJJVDhzQThVMzB5RkZ5T3R1QWxsTkNjNm4r?=
 =?utf-8?B?R0VMUHpFT2c0WGlsc2RMSGlHa2Z5YUF1eS9kOW4yRVRpNU1QR3hxUUE1Zm9x?=
 =?utf-8?B?RE0wQzBvRzcxTFVpcGhjQzEvQ0tpaEd5eTRMaFo3NlkxeEZWSkpnTkNsZGZC?=
 =?utf-8?B?bklaQUFBbThjVk44NktybzkxcU5JVXEzcGpmTHIrRjRCRXcrSzYyUFZtTWRC?=
 =?utf-8?B?dFdzRUF5THd5ajVCeWpITitxQ2VPNFZaMTh4UGttS0tIWjdZc0ttcHZLazNt?=
 =?utf-8?B?Z1VHQ1UydnFvOSs1NnJVNmk2TkZpdjhsRGU0MFRHUDJjdjRSVVl6Z0xMc0lm?=
 =?utf-8?B?SnRTRllnZlFHMkVKNldmek0wSU1pSy9xMTJ3di9NTVM4NzdrWWx3NEt4ODdu?=
 =?utf-8?B?VFF2aDZlWUZUNnM1NFdEVGJUbkx4QnovMHh1ajdyenZCZVQwQldsQXpjNllE?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b35b88d-7fb2-4d77-2453-08db083139b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 10:59:31.7443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bR/D8IxFh02wL7ind3YucEDIRRpOrr20uW+tsasokDgWNhR1hyEfs4ygnXkFyP9Yj/tu5c7I8jG19v3CUwlSY+vUSV4UNsYsWJCKMpSCGZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8718
X-OriginatorOrg: toshiba-tsip.com
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Feb 2023 10:59:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10592

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogMDIgRmVicnVhcnkgMjAyMyAxNDoyNw0KPlRvOiBw
eWxhIHZlbmthdGEo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8VmVua2F0YS5QeWxh
QHRvc2hpYmEtDQo+dHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPkNj
OiBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1
bWFyQHRvc2hpYmEtDQo+dHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g4pah
77yz77y377yj4pev77yh77yj77y0KQ0KPjxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpw
Pg0KPlN1YmplY3Q6IFJlOiBSRTogW2NpcC1kZXZdIEhvdyB0byBvdmVyd3JpdGUgSU1BR0VfRlNU
WVBFUyB2YXJpYWJsZSBpbg0KPmxvYWNhbC5jb25mIHVzaW5nIHBsYWNlbWVudCBvZiBrYXMgZmls
ZSB3aWMtdGFyZ3otaW1nLnltbA0KPg0KPk9uIDAxLjAyLjIzIDEyOjM5LCBWZW5rYXRhLlB5bGFA
dG9zaGliYS10c2lwLmNvbSB3cm90ZToNCj4+DQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+Pj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnPg0KPj4+IE9uIEJlaGFsZiBPZiBKYW4gS2lzemthDQo+Pj4g
U2VudDogMDEgRmVicnVhcnkgMjAyMyAxMzowNg0KPj4+IFRvOiBweWxhIHZlbmthdGEo77y077yz
77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8VmVua2F0YS5QeWxhQHRvc2hpYmEtDQo+Pj4gdHNp
cC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPj4+IENjOiBkaW5lc2gga3Vt
YXIo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEt
DQo+Pj4gdHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g4pah77yz77y377yj
4pev77yh77yj77y0KQ0KPj4+IDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPg0KPj4+
IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0gSG93IHRvIG92ZXJ3cml0ZSBJTUFHRV9GU1RZUEVTIHZh
cmlhYmxlIGluDQo+Pj4gbG9hY2FsLmNvbmYgdXNpbmcgcGxhY2VtZW50IG9mIGthcyBmaWxlIHdp
Yy10YXJnei1pbWcueW1sDQo+Pj4NCj4+PiBPbiAzMS4wMS4yMyAxNzo1NSwgVmVua2F0YS5QeWxh
QHRvc2hpYmEtdHNpcC5jb20gd3JvdGU6DQo+Pj4+IEhpLA0KPj4+Pg0KPj4+PiBJIGFtIHRyeWlu
ZyB0byBvdmVyd3JpdGUgdGhlIElNQUdFX0ZTVFlQRVMgdmFyaWFibGUgd2l0aCB0aGUgdmFsdWVz
DQo+Pj4+IGluIHdpYy0NCj4+PiB0YXJnei1pbWcueW1sIGJ5IGtlZXBpbmcgYXQgdGhlIGVuZCBp
biBrYXMgZmlsZSBkZWZpbml0aW9uIGFzIHNob3duDQo+Pj4gaW4gYmVsb3cgY29tbWFuZCwgYnV0
IGl0IGlzIG5vdCBvdmVyd3JpdGluZy4NCj4+Pj4NCj4+Pj4gJCBrYXMtY29udGFpbmVyIGJ1aWxk
DQo+Pj4+IGthcy1jaXAueW1sOmthcy9vcHQvZWJnLXN3dS55bWw6a2FzL29wdC93aWMtdGFyZ3ot
aW1nLnltbA0KPj4+Pg0KPj4+PiBrYXMvb3B0L2ViZy1zd3UueW1sIGluY2x1ZGUgbG9jYWxfY29u
Zl9oZWFkZXIgYXMgYmVsb3cNCj4+Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4+Pj4gbG9jYWxfY29uZl9oZWFkZXI6DQo+Pj4+ICAgIC4uLg0KPj4+PiAgICAg
d2ljLXN3dTogfA0KPj4+PiAgICAgICAgICAuLi4NCj4+Pj4gICAgICAgICAgIElNQUdFX0ZTVFlQ
RVMgPSAid2ljIg0KPj4+PiAgICAgICAgICAuLi4NCj4+Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+Pj4NCj4+Pj4NCj4+Pj4ga2FzL29wdC93aWMtdGFyZ3ot
aW1nLnltbCBpbmNsdWRlIGxvY2FsX2NvbmZfaGVhZGVyIGFzIGJlbG93DQo+Pj4+IC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4+IGxvY2FsX2NvbmZfaGVhZGVy
Og0KPj4+PiAgICAuLi4NCj4+Pj4gICAgIGltYWdlLXR5cGU6IHwNCj4+Pj4gICAgICAgICAgLi4u
DQo+Pj4+ICAgICAgICAgICBJTUFHRV9GU1RZUEVTID0gIndpYyB0YXIuZ3oiDQo+Pj4+ICAgICAg
ICAgIC4uLg0KPj4+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
Pj4+Pg0KPj4+PiBGaW5hbCBjb25mL2xvY2FsLmNvbmYgZ2VuZXJhdGUgYXMgYmVsb3cNCj4+Pj4g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+Pj4gIyBpbWFnZS10
eXBlDQo+Pj4+IElNQUdFX0ZTVFlQRVMgPSAid2ljIHRhci5neiINCj4+Pj4NCj4+Pj4gLi4uDQo+
Pj4+DQo+Pj4+ICMgd2ljLXN3dQ0KPj4+PiBJTUFHRV9GU1RZUEVTID0gIndpYyINCj4+Pj4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+Pj4NCj4+Pj4NCj4+Pj4g
RXhwZWN0aW5nIGNvbmYvbG9jYWwuY29uZg0KPj4+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPj4+PiAjIHdpYy1zd3UNCj4+Pj4gSU1BR0VfRlNUWVBFUyA9ICJ3
aWMiDQo+Pj4+DQo+Pj4+IC4uLg0KPj4+Pg0KPj4+PiAjIGltYWdlLXR5cGUNCj4+Pj4gSU1BR0Vf
RlNUWVBFUyA9ICJ3aWMgdGFyLmd6Ig0KPj4+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPj4+Pg0KPj4+PiBUaGUgYWJvdmUgaXMgcG9zc2libGUgd2hlbiBJIHVz
ZSBuYW1lIHdpdGggaGlnaGVyIGluIGFscGhhYmV0aWNhbA0KPj4+PiBvcmRlciBsaWtlICd6aW1h
Z2UtdHlwZTonIGluIHRoZSB3aWMtdGFyZ3otaW1nLnltbA0KPj4+PiBrYXMvb3B0L3dpYy10YXJn
ei1pbWcueW1sIHdpdGgNCj4+Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4+Pj4gbG9jYWxfY29uZl9oZWFkZXI6DQo+Pj4+ICAgIC4uLg0KPj4+PiAgICAgemlt
YWdlLXR5cGU6IHwNCj4+Pj4gICAgICAgICAgLi4uDQo+Pj4+ICAgICAgICAgICBJTUFHRV9GU1RZ
UEVTID0gIndpYyB0YXIuZ3oiDQo+Pj4+ICAgICAgICAgIC4uLg0KPj4+PiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+Pg0KPj4+PiBJcyB0aGlzIHRoZSBvbmx5
IHNvbHV0aW9uIHRvIHNldCB0aGUgb3JkZXIgb2YgdGhlIHZhcmlhYmxlDQo+Pj4+IGFzc2lnbm1l
bnQgaW4NCj4+PiBsb2NhbF9jb25mX2hlYWRlcj8NCj4+Pj4NCj4+Pg0KPj4+IGxvY2FsLmNvbmYg
bm9kZXMgYXJlIGFscGhhYmV0aWNhbGx5IHNvcnRlZCBhcyB5b3UgYWxyZWFkeSBmb3VuZCBvdXQg
LQ0KPj4+IHdlIHNob3VsZCBwcm9iYWJseSBkb2N1bWVudCB0aGF0IGluIGthcy4gR2VuZXJhbGx5
IHNwb2tlbiwgeW91IGNhbg0KPj4+IG1ha2UgdXNlIG9mIHRoYXQgdG8gYWNoaWV2ZSBhcHBlbmQg
YmVoYXZpb3VyLCBvciB5b3Ugb3ZlcndyaXRlIHRoZQ0KPj4+IG9yaWdpbmFsIG5vZGUgeW91IGFy
ZSBjb21wZXRpbmcgd2l0aC4NCj4+Pg0KPj4+IEluIGNhc2Ugb2YgaXNhci1jaXAtY29yZSwgd2Ug
Y2FuIHJlYXJyYW5nZSBvciBrYXMgb3B0aW9uIGZpbGVzIHNvDQo+Pj4gdGhhdCB5b3VyIHVzZSBj
YXNlIGJlY29tZXMgcG9zc2libGUgKHRob3VnaCBJJ20gdW5zdXJlIGlmIGl0IG1ha2VzIGFueQ0K
PnNlbnNlOg0KPj4+IHRoZSBjb250ZW50IG9mIHRoZSB0YXIuZ3ogd2lsbCBiZSBvbmx5IGEgc3Vi
c2V0IG9mIHRoZSB3aWMgc3d1cGRhdGUgaW1hZ2UpLg0KPj4NCj4+IFRoYW5rcyBmb3IgY29uZmly
bWluZywNCj4+IEkgd2FudCB0byBjcmVhdGUgc3d1cGRhdGUgaW1hZ2UgdGhhdCBzaG91bGQgZ2Vu
ZXJhdGUgYm90aCB0YXIuZ3ogYW5kIHdpYw0KPmltYWdlIGFuZCB1c2UgdGFyLmd6IGZvciByZXBy
b2R1Y2liaWxpdHkgY2hlY2tzLg0KPj4NCj4+IEkgcHJvYmFibHkgaGF2ZSB0byBtb2RpZnkgdGhp
cyBmaWxlIGthcy9vcHQvc3d1cGRhdGUueW1sIHRvIGluY2x1ZGUgYm90aCBpbg0KPklNQUdFX0ZT
VFlQRVMgPSAid2ljIHRhci5neiIuDQo+Pg0KPg0KPlRvIGNsYXJpZnkgYWdhaW46IFdoYXQgSSBt
ZWFudCBpcyBlaXRoZXIgYWxpZ25pbmcgdGhlIG5vZGUgbmFtZXMgaW4gdGhlIGthcyBmaWxlcw0K
Pm9yIGNvbnZlcnRpbmcgd2ljLXRhcmd6LWltZy55bWwgdG8gdGFyZ3otaW1nLnltbCB3aXRoDQo+
SU1BR0VfRlNUWVBFU19hcHBlbmQuDQoNCkNoYW5naW5nIHRoZSBub2RlIG5hbWVzIHNob3VsZCB3
b3JrLCBidXQgSSBuZWVkIHRvIGdpdmUgaXJyZWxldmFudCBuYW1lIGp1c3QgdG8gaW5jcmVhc2Ug
dGhlIHNvcnRpbmcgb3JkZXIuDQpUaGUgb3RoZXIgYXBwcm9hY2ggaXMgdXNlICIgSU1BR0VfRlNU
WVBFU19hcHBlbmQiIGluIGFsbCB5YW1sIGZpbGVzIGxpa2UgInN3dXBkYXRlLnlhbWwiIGFuZCAi
dGFyZ3otaW1nLnltbCIgYmVjYXVzZSBpZiBvbmUgb2YgdGhlIHlhbWwgZmlsZSBoYXMgIklNQUdF
X0ZTVFlQRVMgPSAiIHdpbGwgcmVwbGFjZSB0aGUgb3RoZXIgaWYgaXQgY29tZXMgbGF0ZXIgaW4g
dGhlIHNvcnRpbmcgb3JkZXIuDQoNCj4NCj5CdXQgSSBkb24ndCBnZXQgeWV0IHdoeSByZXByb2R1
Y2liaWxpdHkgY2hlY2tpbmcgaXMgbGltaXRlZCB0byB0YXIuZ3ogb3V0cHV0cy4NCj5DYW4ndCBp
dCBiZSBydW4gYWdhaW5zdCB0aGUgY29tbW9uIGlucHV0LCBnaXZlbiB0aGF0IGl0IHdvcmtzIG9u
bHkgZm9yIHRoZQ0KPnJvb3RmcyBzbyBmYXI/DQoNCkN1cnJlbnRseSB3aWMgaXMgbm90IGNvbXBh
cmFibGUgd2l0aCBkaWZmb3Njb3BlLCBzbyBJIGFtIGNoZWNraW5nIG9ubHkgdGFyIGJhbGxzIGlu
IHJlcHJvZHVjaWJsZSBidWlsZC4NCg0KPg0KPkphbg0KPg0KPi0tDQo+U2llbWVucyBBRywgVGVj
aG5vbG9neQ0KPkNvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQo=


