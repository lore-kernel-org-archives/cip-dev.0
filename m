Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC4C7EE23
	for <webhook@archiver.kernel.org>; Mon, 12 Jun 2023 07:06:21 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.88])
 by mx.groups.io with SMTP id smtpd.web11.52898.1686553577657361088
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Jun 2023 00:06:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dGkJ64yb;
 spf=pass (domain: siemens.com, ip: 40.107.13.88, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHK5yiCeintoeGQddeU/NUApYqEMTUC4+fJlPe3FePPAWCC+R6pA0y6cRx7Fh3C0yT6nlMYRXJxqdmOeYSdsyr/cWe2zxBdYFEAg6oM+NF1QXWnwkzAZ0ZyFFLMizA7T3k/pL9bXUA9u+JOtYM57Bb7vTlkedI2SpSR+ZgnXs5q9iug8bYA7vKdVnAFooH/llEzWfDdwOOwa2gbhfoYIzY99y1QYhdCpmJRwSLGsbu1r5pcuMeqregOaYeO056pls4ayuzM988xpPXFLPxV32FInmTJhLK06ANzNFNx1Da5BMMG/Nl4HOB8TXYx57Yk3RKi/8Tiht12xmarxMzqlVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUwpmWDlNlfvds8WXCfkmp6d0DunN7BMXiUz4IuromA=;
 b=YIUOp1IEei3wSjxTKgBuQydx1iNVTC5EJwx1mBoGbiJkl7rqDlmIabv3GG4Hn5px8HMPsxRLUDC9ib8aNOAwSNpgIhU76r93vt1gwNusw9wDTV7ajF3MSq8AElSpmh+AYn2Vlzk5Kb0VaiUMuRlAB5R03LJ6CD+dfgvTWNWH++U3LEXwZ1wcThsvAUrE2cU9XnP5WmwzsccWBmijs8EMpRB9vK7LaXXL4PzyEK7UQ0J4HXBLK+U4mlXgVyCs787fv3zanoiiE5pRnAzZyj4QcvgiDtNm5UQRmL5weRMlT8IScnvJqJbo/QN8lDpbhiSr71TlOjmbY9eQHJohPRWvyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUwpmWDlNlfvds8WXCfkmp6d0DunN7BMXiUz4IuromA=;
 b=dGkJ64ybUs3+6a4KDt5DARKrJ6trWZyD68xYq8Oh+MXZGJrBvT8IqmqyATmPSIWRbRYcUXBTqJYnjsLRN+beTNgxUfx+mqoiY8vz/UrkP8xlKWInA6goiAD5L9gnKdzcowyNTcRMgStgUsQ7oNPYdg1WxYtL1UDBzRsqmVL16/RsajsqyBNCp36lBg/kpoJM6gZ8nyLeG6EXagJL111kTk1u22QdRKANFB2RiAp/2pSRapDvXqj/jKWSGaE7+yD2pXcawgzQqW3gg+bJLirba0OhLIJnu2CCD9/+DF0/iBq/v2i2rOWA0Ng+WYMNjhbmgDy2DakDyrnTnVsbo7hMew==
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by PA4PR10MB5636.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:265::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 07:06:14 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5ef9:5d41:24df:3f99]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5ef9:5d41:24df:3f99%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 07:06:13 +0000
From: "Schultschik, Sven" <sven.schultschik@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH] edk2-standalonemm-rpmb: Update to
 edk2-stable202305
Thread-Topic: [isar-cip-core][PATCH] edk2-standalonemm-rpmb: Update to
 edk2-stable202305
Thread-Index: AQHZm4G7SvJsueZ44EKv3eCWNHKEha+GwbiA
Date: Mon, 12 Jun 2023 07:06:13 +0000
Message-ID: <675e564ceea29602adc93422357f9824c0497269.camel@siemens.com>
References: <e2c82aaf-5c90-778b-d324-630e5d846871@siemens.com>
In-Reply-To: <e2c82aaf-5c90-778b-d324-630e5d846871@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5037:EE_|PA4PR10MB5636:EE_
x-ms-office365-filtering-correlation-id: d8e8ed44-15da-4ad5-ec60-08db6b138251
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 uQS3vZckAavgZYDpQ1Redzbf+VJlFrpBFmmXI2TJ1cLfzQ1+UtPBMAiAxvv4yt7B7TbtSM3sLZHqOfRqdCwVj4blsIkI2DvPVGUTRsff365EEfuyWkFP/GyXQLRNO1kyhjF+NTV31YnJyqkGNGHSPF31C7zB/DMmhTe/VQ2MWtn7aZGR0cDXXxOQUaZC+kWfmFVSIc52q6nVzRdoQoR/Eb3Ot51dMvoFbAwHQg8ho/BGodeontYF+6PFsi1aLP9Ny83D2picuRRRPVwZptifV6dlAiqxbFAvBoldTxtCTfiXyS9cTGSfjYDLcbB6Jrj1B6FlMeyjl5BUncGc3SQWZm2D7xacRa5J3OUrlj8Mt46CqIij9ZRsoXiQFEKaHmCB3Mv1gpNIyn/zrtKLCnufZNrqjnUdOUeVasYSyrlUE23HKVfmZHBdI/S5dqgoT3HicW3oq0lJYXsOu+5Ab4zJSw/Pos1xnUIVYcZGV0AL/gF4cnPmiIGwRbNH0B0b4nTKiBqHdXnIUg+uhXxhZ/GVa6HB+t7GXL+f9eaAKjB0nBDI++zfE3F4F5mXWDmnImte/MH/4B+lNH/j6t/Ruy7nx/nPmuaWNgV10orRAXqy5IZC72OB/RaZ0mfgt7W83OFl
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(86362001)(6486002)(316002)(8676002)(41300700001)(82960400001)(5660300002)(6512007)(38100700002)(122000001)(6506007)(71200400001)(8936002)(38070700005)(66446008)(36756003)(66476007)(66556008)(64756008)(66946007)(76116006)(91956017)(478600001)(6636002)(186003)(4744005)(2906002)(2616005)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?d3ZYWVk2MWJ6VmpQUTRqSXFBSnhucmVMTXFaZmdUckxJVDlnMFlHSGNIQWRG?=
 =?utf-8?B?NDR0d0ljUGdLR0k0V0c2aU55NHVwRlBBaEZxdTNTZTdnU3NBdlQzY2JDanRJ?=
 =?utf-8?B?WlpGdGF4ZnVRdU5iVlBhMzdnbXNTaEVFNENiUnlKNy9VaHVFMzBpbkZKbCtE?=
 =?utf-8?B?UVU4VVIzSmlWamtWZndUdFhQTEJISHZyYTdwVDlkVGdObVBNRkpWZmEzaDJu?=
 =?utf-8?B?cWpoblIrMk9vOWVuMDN4OE1VV0lFWEp1WnZrUjFZTWdUZS9JWG9heTBPSGdq?=
 =?utf-8?B?M090VnBGK0xBWUpzeFJ4UE1HWFZjczJVR3ZBZXVNVEgwVjJJMDU5YWxpM3JJ?=
 =?utf-8?B?aUw0anQxeDU3a2RzOFd1KzBuZTNHUHp6czgrcHNjTHUyNlp1U3M2Nm8vL0VP?=
 =?utf-8?B?QUtBQm4zVTZJUEMwcnpOU2t6TWh0eXJHOVlCVHArMVIxTERqL2c2ZjJNRk0z?=
 =?utf-8?B?SmZQK09yTE5weC9GTmtpdGt1TVZVUEFVNlFQRy8vbHJMNUpiY0JLMWFLOUh6?=
 =?utf-8?B?VmZQTkcyemFhaXJXUiszSndJeFBIbTRRdy9SS3hNbmFab3pMeDY2NVZwcUhV?=
 =?utf-8?B?QTBPdXNvdEV3cERYckR6Z1JzakE4RFZLY2tDNzQ3ZmNadUpWVnNMVE9wTloz?=
 =?utf-8?B?YmlCbHRUYkUxOEFobXQwajgzTzV1elpDNG9YdVRrVVJIZlZWQ0sybkJhZVBz?=
 =?utf-8?B?U1ZFSzAyU0Nubk94WmNGMDc1dzBRZnRtM1hzb1dqWC9idzZETzJmOXVZaVNt?=
 =?utf-8?B?bms5eFU0dUFsYWJiYldpL2FwWFlFaFpjcWlUVi9iWkt3eXdTbjVZamhXY0hF?=
 =?utf-8?B?TmhJUkV0ZXV1Y0VKZmNqOGgwd29QVko5cEVpNjN1c3RLaXRHM29hM3h6N0Rj?=
 =?utf-8?B?QUhIQWVNaEdhN2EwUGR5bk1Pam5meFd2YVMvQkt1VU5GT29hbEhMUUw5ck8r?=
 =?utf-8?B?ZWVmK3prQWp1Yi96djl4MWhVYzhWVGxqelowRnVMc0cxZ3AxWXQxN1ZBUTRZ?=
 =?utf-8?B?SVpJb0tybmZsYmJtZ1VJM2wrcWNaY2Ntc2FVRzlnUUU2djBVRTBtYnppbGsv?=
 =?utf-8?B?MXZFbE52eGZqM3dhMG1GWFNIekpKN0h0L001RExGc3RJZ2l1MmZrSDNaY01B?=
 =?utf-8?B?VnRPZE9PcndlanRGMW9EcENJbU44MnRYLy9FakFuS1FkMEk1YjdaRVRXdU03?=
 =?utf-8?B?bmExTytZQ3ZIQU0yT1k4cEZYSFVzeFZRKzJWMFdxMUtESEhGU1hqNTU3R0My?=
 =?utf-8?B?OW5CNHQydWd2M3VyMXViOHRIMnJRZjh3UDZiTCsrRVFlNXVvSm5mRG1Mek9Y?=
 =?utf-8?B?aU5wcjNkZzFMaFVVekJld3VKR1pLelRpSWtFUUxXeWNONGEwK25LZUxWdXMw?=
 =?utf-8?B?clpFeGVLaUMxQmpBSnNPbjVLRGJaVzdjbk5lSStINWRQL1NBQ2IrZlRvWkxq?=
 =?utf-8?B?bU12ampzeUlrcUxKWDNldUpxUFdHYlhiVjRjSGdvNzl3Qzc4SmR5SU1NT2dH?=
 =?utf-8?B?ZWxublNtNmlBeTM3KzlOWnBBUnR0VlBnb2tkaHJ6QStJcEttQnZrbmd5WDE5?=
 =?utf-8?B?MWY5S3YzbXpTZU1ZY09RMGFxdEgvUUw3VTdXMHVDei9OSDFvUWFlYnVBWWEy?=
 =?utf-8?B?WHBPQW1KMzRvanlBcnpab00xY2syUllhd3JQUGE2UmVWekpzSis4Y0c5NDdH?=
 =?utf-8?B?WDdUVVFrUVdpUVVBNzFPZ3hkWEhETUxJUzhFUWJXcTQraWlsb3hSUGZDVVJh?=
 =?utf-8?B?NEZoclFIdVRnN25sMTFDYmF6STlUTzkvbFZmcFlZRUl2d25VdjFTU3JEOHlp?=
 =?utf-8?B?SlFWT21DaURRVGtDM0FFUFJPSkxTanBxMWhYS2xZR0I2cWtyeW1aWG1kemF6?=
 =?utf-8?B?eVQ2LyttbXYrSW1DbDRvQXl2dERROThIb2lKTVhDc1VmeWtmTGFqU3ZLcHpV?=
 =?utf-8?B?NG5wb0JYR3g5MzJ5cktjWHNZSE1mdXVReVh5MG4yY1RvS3lML1JWK0FreUla?=
 =?utf-8?B?dm43SEFKTUxXWXFnL08rbGk5WEJHZzJBTVZVZFRXVWVZYXVmV3RmQlQ0NVhw?=
 =?utf-8?B?ZU8vU05qQkV3c0dYS2FteWgwdDMvQmljUEdRM1h5b2dKdm9RNmdPSVJYYURY?=
 =?utf-8?B?dDRIUEFhdVNGS2sxNDdKMmNnR0JFNllBWis4K2piSXZBQ0tYbnE1Um1VRUx5?=
 =?utf-8?B?V1g0eTVqWDlZckhQTXgwekszUThUWkVqcWdoZlNQWlFLNUhEd0FMKzVMOGJJ?=
 =?utf-8?B?YStZMlhYZ0RXNVB1d3p4d2pnZ1hnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <001ECA59EDD7BD4D8BAEDEE476939885@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e8ed44-15da-4ad5-ec60-08db6b138251
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 07:06:13.7676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1uiY2gu7jyXt08dUEAAXvBoMDv8KdVTmL39V8+7xMKkYRV130b8aAI6oGckKjjd55+nldalHhzUoNwAEcK6+NOq2r/Uyxp6T5r5oEZcajvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5636
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Jun 2023 07:06:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11970

T24gU2F0LCAyMDIzLTA2LTEwIGF0IDExOjU1ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBG
cm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiANCj4gQnJpbmdzIG9u
ZSBuZXcgZGVwZW5kZW5jeTogTUlQSSBTeVMtVCwgYSB0cmFjaW5nIGluZnJhc3RydWN0dXJlLg0K
DQpJIGRvbid0IHRoaW5rIGl0IGlzIGEgcmVxdWlyZWQgZGVwZW5kZW5jeSBmb3Igc3RhbmRhbG9u
ZSBycG1iLiBEaWQgdGhlDQpidWlsZCBmYWlsIGJlY2F1c2Ugb2YgdGhlIG1pc3NpbmcgZGVwZW5k
ZW5jeT8gDQoNCj4gDQo+IA0KPiArU1JDX1VSSVttaXBpc3lzdC5zaGEyNTZzdW1dID0NCj4gIjlm
ZGEzYjlhNzgzNDNhYjJiZTZmMDZjZTYzOTY1MzZlN2UwNjVhYmFjMjliNDdjOGViMmU0MmNiYjRj
NGYwMGIiDQo+IMKgDQo+IMKgIyBhY2NvcmRpbmcgdG8gZWRrMiBzdWJtb2R1bGVzDQo+IMKgU1JD
UkVWLWJyb3RsaSA9ICJmNDE1M2EwOWY4N2NiYjljODI2ZDhmYzEyYzc0NjQyYmIyZDg3OWVhIg0K
PiArU1JDUkVWLW1pcGlzeXN0ID0gIjM3MGI1OTQ0YzA0NmJhYjA0M2RkOGIxMzM3MjdiMjEzNWFm
Nzc0N2EiDQo+IMKgDQo+IMKgDQo+ICvCoMKgwqAgcm0gLXJmICR7U30vZWRrMi9NZGVQa2cvTGli
cmFyeS9NaXBpU3lzVExpYi9taXBpc3lzdA0KPiArwqDCoMKgIGxuIC1zIC4uLy4uLy4uLy4uL3B1
YmxpYy1taXBpLXN5cy10LSR7U1JDUkVWLW1pcGlzeXN0fQ0KPiAke1N9L2VkazIvTWRlUGtnL0xp
YnJhcnkvTWlwaVN5c1RMaWIvbWlwaXN5c3QNCj4gKw0KPiDCoMKgwqDCoCBybSAtcmYgJHtTfS9l
ZGsyL0NyeXB0b1BrZy9MaWJyYXJ5L09wZW5zc2xMaWIvb3BlbnNzbA0KPiDCoMKgwqDCoCBsbiAt
cyAuLi8uLi8uLi8uLi9vcGVuc3NsLSR7UFYtb3BlbnNzbH0NCj4gJHtTfS9lZGsyL0NyeXB0b1Br
Zy9MaWJyYXJ5L09wZW5zc2xMaWIvb3BlbnNzbA0KPiDCoA0KDQoNCg0K

