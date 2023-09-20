Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F39CE79AB
	for <webhook@archiver.kernel.org>; Wed, 20 Sep 2023 08:35:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.32565.1695198922944978857
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Sep 2023 01:35:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 38K8Y44u691340; Wed, 20 Sep 2023 17:34:04 +0900
X-Iguazu-Qid: 2yAaLCv84A4uLJQrQX
X-Iguazu-QSIG: v=2; s=0; t=1695198844; q=2yAaLCv84A4uLJQrQX; m=E5EaWILDhglSz3PW6yArzL5JFJOp7xRp84MdRcZm1SY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 38K8Y2Df3747646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 20 Sep 2023 17:34:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7jKVeG4oa6vGXDt489kp8zP3R+FnHNIjg8kAY/CIEBQcthsBtn59K4XNtlOKWem3WsvSsCYL7xhewnYe6kfb7hA5hMuq6oV4YdqGC08ZcNGu+LbT8ksxPvWCq3NAB4u8Zy95y4U4lHWKhLeKXy3RdUQa21M3mXchSIHgli6sMakbUx0RKyfYdRuGXewWeKjDaYAcjXRYgrgqKryvX6xugoPMFKdH6XzQctHqR5zYwXouoSL2NW2Jvglwz4tKlbN/AkjOHA5Dp3VCurRQy3KQt6fwIU+JZoD/QA1QQZKniTZfCEFGPaIihhaJ3D3/RndUw7icjtl8zqn70Ri4dzIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ch557Dry90nFxPeXJjzzhJIGwiBpK8QVuJMw+kj7KMQ=;
 b=SaYeYmyn9oykEDTmFjOl6+wLlkFfq5gBOKuUnfJC0Se2YqCRcihpHPHggTfiCvUPkJSS1v4j4xMtGEvwR0fBIbLwHymMtSBv+cbdYdiZ3qu1QHNwf2gagUrYL8ClkIhg5zlAEnSSXOQ2K0R2Po5Wb3g8VbEHaUZp1us/XKlqGzcfndj/+AdJSEXE0DPLjZwtyCHzXY2B9mpf907HSbyMZNtwrJVdMJX935vpGM50zmCQSfprMj1auSBRUnUUJcbg9piIffm/mDny1O/Jf6k7ZjPxmYy3mdaqFIrxu4O1b4ahV2F5VFNEJMvrKxZyL9UmGfhnY2aKh1dEamaoCavHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>,
        <Chris.Paterson2@renesas.com>
Subject: RE: [cip-dev] [ANNOUNCE] Release v5.10.194-cip39
Thread-Topic: [cip-dev] [ANNOUNCE] Release v5.10.194-cip39
Thread-Index: Adnq8bl7whuogWpjQ6GDs4st3ouSugAkxliAAABYEQAABbGSoA==
Date: Wed, 20 Sep 2023 08:34:00 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942009F12C0F5B1ACFBBC36A92F9A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: 
 <TYWPR01MB9420C4F2D1A4D50470E0E5CA92FAA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <0de9f4af-bf37-4bf8-bf5c-28b2b6d7fda9@siemens.com>
 <9f3cfa5f-d448-4df3-a2df-d7d20af9b120@siemens.com>
In-Reply-To: <9f3cfa5f-d448-4df3-a2df-d7d20af9b120@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB11385:EE_
x-ms-office365-filtering-correlation-id: d95e7b89-212e-498d-f52e-08dbb9b456d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7oZ4kkVy5ifqjkhk0RPEA6cCHj29eGsN0zeROZNUlxzH7W99g+5AGejKMu49b/i4wOJUgx7ci5K60K8LesNcAv6eWnB3MJRkEPVPrDFp0U6JnkRn12OaMtGFYMAo3bvUrlIPJ4qMgxgTruCWgpWNESbLepSnIax0w4V2m83sRrIEiPbQ2GyXHIlzF/eqWbJ+pblisC7DMuLEAJUtGeNv1KWnmnA9OO4S3tU9hlMP72aD07L4yauw72wt6eTrNV7CqXibw7NV6ETN/Ba9hhRUYOrI99fsv8INeHS68LoPokeyGiEmUCKqOp/Gipm0Y/Ycpi7yBhamxjH2IlFezzY+NdTcHIpX7WIdm7GsQ5XH/Oq17APmYA2FFkmdmC28ivJLac/tYKCTJJK2JMHS9tUA5zW9FaLeBzaFEuSOTHw1igd3h8rn/jRZlcuWllnjkn94y9jLeYjxDDC4WQ4WwjQh22Hk4jcFDkif09LIwJYpIsezNW70zPal1WTwV0uy85cBYK2+DJMxhh9u+WMfLX8jmc/jaRZOV7/7I1ss0CF1AejKRPgq7TihmwPgbqnv8hQnAIiPgHcZJDWTALD+sZKZ1dSt8eToTrJQ8PhGDFe+AjE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199024)(186009)(1800799009)(7696005)(9686003)(71200400001)(55016003)(86362001)(33656002)(38070700005)(38100700002)(122000001)(2906002)(4744005)(966005)(6506007)(478600001)(4326008)(6916009)(5660300002)(52536014)(316002)(41300700001)(66476007)(8676002)(66556008)(66946007)(8936002)(66446008)(64756008)(54906003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cXNWUEpkd2tyUGxvQm1qZlk3Z1NFMXdjL3huSlFxalFxMjkwdkZPa2ZQajZ4?=
 =?utf-8?B?SVRZNUx1R3M3RFhTVUJySVZIYVloMGx5SUltZFNPd0Y0aWNrTmd0REl5Y1li?=
 =?utf-8?B?WDFiVzh0TmFiUnIySlN5YkR4em1yME9BTXVWRWZaTTJCODhZSExtNkZvcnVq?=
 =?utf-8?B?T1RWTWlNc29oa1JyekppK0dRYVR6Y21zUG10UHpVeWJBUDhSRWc1Y2l3VlhN?=
 =?utf-8?B?MEQrL0NuRUhSSnNSZ2l5ZGU5bUJPMjhSazZ2U2IvS2tzZ2lHYjZIK0pWbWFP?=
 =?utf-8?B?d0NuTzdXSmZnYzRKNEdDdHdOalR4UHpRQ2JLTUVRcDEzQ3JwK09WMDFVQ3Bj?=
 =?utf-8?B?SUlTSkFNWERGOWF2bHEwb1RwblRneVQ3MHBGeVMwY2RSWHhramMwMTZhS0x0?=
 =?utf-8?B?cnkrenhoMHFkYURsTEZJU3NaOHRrY1JoR3c2TlJDemNjMXBaVU1pa3dUSTBt?=
 =?utf-8?B?cGJVU2ljMkFhVkJkbW1jRmNmR09USkt0bGVaRUY2ZjkwblZKSFhteFJ6V0k0?=
 =?utf-8?B?eFNHbTB3ODhoMytwejcrU2lySktVQm1SU3hoY3Z2QU9TSDlqN3FMS2F0emg4?=
 =?utf-8?B?VGwySDhPeWRiaHhDVzFMZHFnUXFwSlJVaWVqeXBlTEdqRlordmg3eE1qTjVv?=
 =?utf-8?B?S3UxQW1udXdudXJKUEFoMTN3diszc3hjamkzS05ZR3VMT2pkNE92RkVEZXVt?=
 =?utf-8?B?emQvT0U0QWZleGRydEJUWUlEdmJIb3k5azdyeXBWR3ZZRTRURDJUczBRb2pI?=
 =?utf-8?B?VThESSszUzk3OHdXbUhUTjZ5SjdXc2huaGtRdFlJbys5cjljSEtTL3crTmR1?=
 =?utf-8?B?UkoxaGw0RmF3MUtxNnR2UDBTRGswemd5RUF2eWhFdUx6U2RmSnNFWWVQOG1r?=
 =?utf-8?B?b0VNM3VxZzZYTnIvOWZiTHJTbXhIUEViUFNianFjNUI4OW5Ub2g2YXNpZ1NT?=
 =?utf-8?B?OEtnVXdONEpTUGg1RGhBVS9aVEJyTGdlY2RoL0d2UGRHWnhmVHFPN1lSOFhy?=
 =?utf-8?B?cW9jWE9xbzVkUjIrdEVKYVd2Y21aelhvdk03YUlPTHhDenRmTUJ4UThjczFk?=
 =?utf-8?B?OE9HOFEyVjRiVzA5dlNwb0kwRFh3QVVwRFFTOUxLYjFKa0trYjFuZ2NERnN0?=
 =?utf-8?B?cVA1TzBOZ0FZRUl3S3pVZnI5ejc5NzB5N1l3VUszRjZ2K3U4Tks5cHBuQkZ6?=
 =?utf-8?B?ZXdrK0NySkdSTDVaSlRsVWI3TXAxaWNzdkpxT1FsQ2MwUjFYaWFkUTNtMzBo?=
 =?utf-8?B?UEwrRGdrNldCUUYxeE1TUXZZVzdLaHl4QmRHbUt6VHlXb0M0VjhMOXVaeFdV?=
 =?utf-8?B?Z1NDK2JCNXFnZFNNWG5rVEJQMnFZU1ZtS2ZXSkZMc1VsWGVvZlpXRFJmMlBJ?=
 =?utf-8?B?c3J1YmNPOXgvUEZkWnlHWm5WZVcrUFFPUi90TTRUMVd4NGszZkthaE4xRE9h?=
 =?utf-8?B?UjVycDFxZE9OOEVobVpnRUNBTG01QkVLOTV6RGNnQnE1d1BWN0plM0pza0I3?=
 =?utf-8?B?M0RpOGpOL05zaGxheHYxTmFFQWRzWTQxdVR2VDFjUkFEbStLMTRvRS9rUFVJ?=
 =?utf-8?B?N0xERDd3TEl6MFo2QUQvNHRodkRNZ3N0WElDdmw3R09TZzMxWXFOOHZTejdR?=
 =?utf-8?B?US82TGRsS2pTWUZFMjlMdy9pOU5UQkgxSWdUUjVqMUpZUjhTU2FnWEtOdUpE?=
 =?utf-8?B?SzU3RVU0a1B0a2RGcDAzMTI2MmhKZE9xRndLRVUrWldOdVcyeWlkVkN3UW9a?=
 =?utf-8?B?QzJRL2dpMUpUNndoZUs4b2Nlc2pSL3N0UWRad3RoTlNKZG1UcWlFdkpFNEZR?=
 =?utf-8?B?WUowUmlGbUxOU29WNjBScmJ5NEh2OFV3RUJkVHJDeXNNazBUdEJRTC9RQXVm?=
 =?utf-8?B?cGp6dEVacmhKc1pLbjR0Q3lrVHdKVVBzTWNLSFFmcWdQSnMxYWtOQjI5bExw?=
 =?utf-8?B?NDZoWFlvN21oLzdTSkd6OHJiUzVHb2F5OGhMZ1ZCdDdxbm5ncGRpak16elFm?=
 =?utf-8?B?NDhnYVJQQUc5T0tobTZGa29IcjBlWE1xSmszM3ZDUktVNUk3NDV5b0ZNdnNB?=
 =?utf-8?B?THBqNzZncXJubUhvc0Mra0tDU3huenlGMURqQ0FDdTJZMVBqZzdTZkg1WXR1?=
 =?utf-8?B?UnBWUEl3b0xzTWFydnlIWHV2YVpSSUFEK3FTai85VFVLK0IvbmJUQmgvS3Z6?=
 =?utf-8?B?cmhkZHRhL2Irb0F0R29nd0FZSDBkWHRIWnU2UkVrbHV5TTVjODlHL21MZDFZ?=
 =?utf-8?B?bUpTWS9JenBEbytiMUR1UzJIZmdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95e7b89-212e-498d-f52e-08dbb9b456d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 08:34:00.5369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ta4xS4DjNGC6+BdzWE2Oj3N69c76ONP4GIsl+a4dDH4TQv+fEErlE5q2kGHBWMKEcNcGfI5QOIdi+NNnSSPiWoIcKdeVnWX5aeBcX7+UsMX0I05rNNRQjHcr7g9tRj0y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11385
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Sep 2023 08:35:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13181

SGksDQoNCj4gPiBQbGVhc2UgZG9uJ3QgZm9yZ2V0IHRvIGZlZWQNCj4gPiBodHRwczovL2Nkbi5r
ZXJuZWwub3JnL3B1Yi9saW51eC9rZXJuZWwvcHJvamVjdHMvY2lwLy4gSSdtIHNlZWluZyBtb3Jl
DQo+ID4gcmVsZWFzZXMgdGhlcmUsIGJ1dCBub3QgeWV0IDUuMTAsIGFuZCB0aGVyZSBhcmUgbW9y
ZSBnYXBzLiBXZSByZWFsbHkNCj4gPiBuZWVkIHRvIHN3aXRjaCBvdXIgQ0lzIHRvIHRoaXMgc291
cmNlIEFTQVAuDQo+ID4NCj4gDQo+IEp1c3QgcmVmcmVzaGVkDQo+IGh0dHBzOi8vbWlycm9ycy5l
ZGdlLmtlcm5lbC5vcmcvcHViL2xpbnV4L2tlcm5lbC9wcm9qZWN0cy9jaXAvLCBhbmQgaXQgc2Vl
bXMNCj4gYSBtYXNzIHVwbG9hZCBpcyBvbiBpdHMgd2F5IC0gdGhhbmtzIGEgbG90IQ0KPiANCj4g
Tm93IHRoYXQgdGhlIGZvbGRlciBpcyBmaWxsaW5nOiBTaG91bGQgYW5kIGNhbiB3ZSBzdHJ1Y3R1
cmUgaXQgaW4gc3ViZGlycw0KPiBhY2NvcmRpbmcgdG8gdGhlIG1ham9yIGtlcm5lbCB2ZXJzaW9u
cz8NCg0KSW5kZWVkLCBJJ2xsIGludmVzdGlnYXRlIGFib3V0IGl0Lg0KDQpCZXN0IHJlZ2FyZHMs
DQogIE5vYnVoaXJvDQo=


