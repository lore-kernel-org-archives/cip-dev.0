Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E718EB64D9
	for <webhook@archiver.kernel.org>; Wed, 12 Jul 2023 05:11:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.773.1689138687926779879
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Jul 2023 22:11:28 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 36C5BPAC2764634; Wed, 12 Jul 2023 14:11:25 +0900
X-Iguazu-Qid: 2yAbeDFf7zHK2QWfZ7
X-Iguazu-QSIG: v=2; s=0; t=1689138685; q=2yAbeDFf7zHK2QWfZ7; m=noC73s2Pt9VNaYjbbR+FR+LQyNzPmF83LOk91HJluEU=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 36C5BOLQ437979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 12 Jul 2023 14:11:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2Tcm2dPmirQJey/D1VbqM1WMam8yGIVvyy8PjrlxWYdTmLzQOksdkah6FYcGSB3AJCJBtyLzI8d5XZZU4uwsVbtzoWCGH9TA4fsKnKKCfg6gCcgMXWpkyZuAGcZjBj2N9n8yM+MI7gKGb4CMO5q7bcnz2dpHssi4egKdRaGroXNv/BMWm7UVbqL5HWEeo717YchAY9Ws6ZZ6aa60s16yRjH8J/UPXf5d7y5xGds7a+ikLSLJqt+38iAbfIU94Pu5XcRq3/i80uZ+u9hXyYHDt2BnSHw1j+gYqPsZCKYU4R1qU7X0Rgo7kUxVnBfK9zir+4pD+oOxcawwGJn/zN2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSU1Uv3l63Mv+YEA7wgV06dVwtht4I4tmusCMN3ZU7Q=;
 b=Nv3rVHt14rgcCt+MCgnNJRbbBpbgBelLz0gEx3QDSK3Je4KzjEJ4qYjkTRAP5h2GiK+ilMedDvQAmGQ3u38LNnIctJ5F9wmP9Dp1l4wcPnYmWarpauvfr7kjNH0sL9fsAB9jSB58QSEvTjdvgin/LTD+FdyuF9veDrYpDeScYzmXFbvgtfbbvbg34MZicjMLpTJyjPedFDWOFp8wUGtOB1r9gHImPvl9L+50Qem+GivtCAEQ/2/Tu0TKfbNfAjoUxLeNFioCey3BBv/Zp3rgVW5e+kaXMxngvGSzt/8myXTD/NDI4d6cbi7y6nYsa5wQNfSSmEX5Gtg2JtKnhPbVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core] Kconfig: Add additional features to
 security image
Thread-Topic: [cip-dev] [isar-cip-core] Kconfig: Add additional features to
 security image
Thread-Index: AQHZs/0AYTyG8SATTUaPlTeN5VVh9q+0vCYAgADY5oA=
Date: Wed, 12 Jul 2023 05:11:22 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSAPR01MB49455B886FB98BD977456C36C236A@OSAPR01MB4945.jpnprd01.prod.outlook.com>
References: <20230711133838.437045-1-Sai.Sathujoda@toshiba-tsip.com>
 <36842105-2853-624d-eec2-98e81108acd3@siemens.com>
In-Reply-To: <36842105-2853-624d-eec2-98e81108acd3@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB4945:EE_|TY3PR01MB11528:EE_
x-ms-office365-filtering-correlation-id: 01f36beb-44b5-43e9-4e38-08db82966f25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 pzz8M4wFheddN/ItQX/4Qc7eEnOy2ZhER6+cm0+bhSRCEpPyy5YwXLUq0R9zWK7QkSytJDBnOC0Rso+sw688u/bEBoPUbCDVKXz/cRw1TU7cHdUZfo7Y/731WY45qAGvoEFMiLFOp6RMAKblOLivRv5F99NaGSpxUdeW1trxR7C5L/F3cEuE4cvVCnw7Roai5ViTXMyVl4N4r5RA/ZqydWh2QTd84rl9SJwfCMt+1I1r6smrPqz8QmwvAmLwyOfYmmBTHJY6yTtm4W5OobrAaWF+f2Ks7iXeI1N+Y/TjVppoxRTZXUyhpbvZKhlQE9ksBe1Nts8ErK/Dd86mm9XLkHxYcT1dtVG7lJt0ilS9MGN4FUS+jqKOl80fto0GsALlrTXSrtzNgPd+1FrphEu9GtAJP6E+vnVwlO5wQJCBt71+d+473+TJdnEnEBYdM4DUigrUdUpw5IgiSI6wjc10rcirxsyqKmx6AmzMw5aJZ8fWkA0eVL3hWcoX4X4bvFpxIJRwDTJ/mS1qahriPeIHKy0dpG8mNM6zoBjbQbrbZJFiANp39G1zryueatCFi3Kxm1NSJAu8S39uSekR0918IeRUuEhUA7OTZqAaqhQRhYo3SE7xHNOo/60weDjPzM1k
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4945.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(4326008)(66946007)(76116006)(6916009)(66556008)(66476007)(66446008)(64756008)(71200400001)(7696005)(33656002)(9686003)(83380400001)(85182001)(54906003)(478600001)(186003)(122000001)(86362001)(38070700005)(53546011)(6506007)(38100700002)(107886003)(55016003)(15650500001)(41300700001)(8676002)(8936002)(52536014)(5660300002)(316002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?M1Z6UmxMTC9ITm84MUM0VU44Nm5EcVpxU1BiV0dxZDFiWDd2S0JWR1RvbW55?=
 =?utf-8?B?Vk5MWnliRVBPV3QrbVNXMWlyaTI4SXd6MnhsU0JINmJ5eFRGZDRIdml4YlI5?=
 =?utf-8?B?c2xFeElDR29idG5XWEpnbnhnT2NHT3hRVXBXTU13elNaeGsvV2JhZ1MzTFox?=
 =?utf-8?B?Z25CS0t2VEhVRHNyNnB5dHZGR2NEcFRTUEU0YWtZMG04czJHazhvV28zaVpY?=
 =?utf-8?B?bjNESzFZMnp0dWV3Rkh5b2dRd2wvOWJOa1UvdWVkNGoxYkpZTzFoMEFabCt2?=
 =?utf-8?B?SGF4NXRJYStWTDB1RWgveE5lYXN4MmdvTHovd0JKOTF1NkduNUVSWmFLRm5W?=
 =?utf-8?B?VVJtcTAvTWJzbkZSdm9QQlVXUUgrWUN2UE1McWtHY2QxU044NnpZYkVWd2xi?=
 =?utf-8?B?WGJ0eGMwYVg0cktYNGN5M1NyNmkyRWhEWnNmU3RqTjVONzQzckkyQmFJVE1h?=
 =?utf-8?B?RXozNEFYa090M2RKZ0RLNlYydEpYdCtzaDlxSkx3WGFxZGZkbi9UMm92NHh0?=
 =?utf-8?B?WnIwL1NCbENrOXlna0ZGbndobHpDT0FaVmtWeU1tZWpPWGc3dEowQ2loanVL?=
 =?utf-8?B?VXh5Q1FOK1pQdldUWjA2WXNTZkZYRStmRWhlSzYzcTd3RnFvWkZ6WGMzZnI1?=
 =?utf-8?B?S0lmWHJHQzFqdEFnMEhobmRNSmllMGR3Z2dOcjR3UTNRaTZiMUcwcUhmQjVt?=
 =?utf-8?B?d0VSNjh1TW5kV3g1Z0xGemV5NEJCbDUvOW1CUU9RNmlyMHRENEJQQmdxa1JQ?=
 =?utf-8?B?YTZEbkY3dFBPRzhINWdOMFhWdVg4NVV3ZEhnSnVlWU9CL1RGaThNL3gvaHR1?=
 =?utf-8?B?QVBXbDh3Vm9OUWZwYTY5WCtHVjFrU2F0TUdmeWMvc2dERWlFb1F5VkcwVXQ0?=
 =?utf-8?B?MmpNc1FCRW1McUY3UVNXVFR1ZDF2QUdRYW5manNTL2ovZUVuTGorRGNGSzRN?=
 =?utf-8?B?ckRJbkg0dEJ4Zm1aRDRVblhvdFppbWQwS0txdFA4cEFVUTgwbHhQTVVqeDNQ?=
 =?utf-8?B?OXovTUZjU21yVzVBQUsyYkorejVpaHJMVXE1M3ZNMVVKTzRROXI2TGVvWk9q?=
 =?utf-8?B?NFN0ZldyNGg5Y2NaTEl2em93aWQwemtiT2x1TmdhY1pOSXpLMjZCSWlscnhD?=
 =?utf-8?B?eDFkT1M5UENGbHoxclhIekNnMHR6ZXFUMFptSVJHMEJpZ2I5WHEzYmdFSEJT?=
 =?utf-8?B?WE91eVczaG9qN1I3T1ZhNndzWlB6UyszYUxTMmVLTTE5TTIvTU1jYXg1dmxC?=
 =?utf-8?B?VVJmSVRKd2Jlb0ZkSDVadkNuaG9hOWphcnFyQWF4UkpIcEF3Um55RGIyZmFP?=
 =?utf-8?B?ZldwWEJEblVJY1ZMN2dnMldjcjZLeVRIeWhUcGtqcjhFc1BhQlhMcUZJNkFX?=
 =?utf-8?B?MTQvUXB2SmVLRnZzR0s1ODU3SStaLzE3c3pveHZ2aHFycTlTTk9wKzFYV3Jt?=
 =?utf-8?B?T0VvTzBFRVU2bzBlKzZ0NmZMVE1IYzMzM09reTJjZGJhcVkyQnJlb1JmSXZX?=
 =?utf-8?B?SU9rOFlqdVJiTng2akJEY0EreXA0UlY0UStsQ3pkdHJReWhkam9qbVBUa3c0?=
 =?utf-8?B?MWMvTVNZck5ySjZkZW9UcEN3dCtwcllBRlFKU1hrbWh3NHFQYjFaWmpFbHZa?=
 =?utf-8?B?QzBWT0pWZlZRZjZscGRoZzY5NzZmRW5IZUd6bExZWXB4czE0ako1YllHZmdC?=
 =?utf-8?B?T0ZzU3I2Qm0vUjRCR0pWR3pyYjN5TkdsNkdxMkI5YWg4NDJhZjB6aEhXa1pU?=
 =?utf-8?B?UDJRczkrMUVyNTRBVlJZS1FrbmpDenNML0VkYlN3OWR1Q0xKcnJpeng3VjEr?=
 =?utf-8?B?U2xQL2dSMFhPQ2krMjBKVWwvSzZRZnNoMDg1eklyTDFzSnFRcnpaanVPZ3pr?=
 =?utf-8?B?Q24raU5ZU2M5dy9qRVNLMWJGcFRCMUNqTGZiYm84eUQzS1NvVVh5N3VTM1V6?=
 =?utf-8?B?aGlVQnFpMUNqV0pUeWtIMFgxSHBKRWhJbHAyMm1iU2FCKzFzdTJUSy9yYUtQ?=
 =?utf-8?B?a1htaFh1Rm0zQmJwdHB2RkVkZFdhMEsyWnl1WFZDWmlVM1U3MGErL21ZcTZS?=
 =?utf-8?B?VWpHMExtZDFPRzA5cUZMVmlyL0RNalI1NXduVzlKMmVUd2F5M3U3cEgra2Mz?=
 =?utf-8?B?WmNBdGFOajBNelRrRVNJWDk3MzhtNGo4c3JlbW5tQXRLUkh1OFlNZExveDVX?=
 =?utf-8?B?K01PV0JpQlZKbWwreFNrKy9SeGhNUzdNd2FaQVN3VXBMNTNUUFBEOTRDbklZ?=
 =?utf-8?B?U09Cb2s4NSt0czhZUm85bDdwbW1RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Uw/4/EqA7jRLBEey2YmN55TDcJsY4371IV01+Yyo2BilO7eZoJGYEc9G13eGLUvuVMmjqUcwVA5Kfr1jUbQYsByLV/g/Zw0fzhfdGwKrYcsShG0kOsQ6ddJX4bbDrkXheAVsZVH9NZ0hPM6/guwZlEQ9n5X64IS9ktb5pefS7TijHsLa4wIl32XV+WccOT/j0dkY6/Oaf1lMqQmbjOisJ+oC9vm+h4kVe/cc1V6T0Rftx9ki7b9QXCpOivHd1fQ3DRM5OOhYImMbMzoVmVgB3+E39XdVeWjO9zsp+iq+b5CVaA7cpjWyE2Yo6KMgk1AtvJmmTeOPDM4BwripWdT+Dpz+kp1iQ856PMUXQbbSmLVe0KRPPMdT2Won8HJLrgv8krzwZuMGI9kSse53U/+5j24ZVwcXY6ocsYAc4fUZAueRHRgipGLy+SASuE4qiMcVYhcH4z00V3iybpZ/Mk0BSut3+R000Iw+p4qwrY6YTQVIRujG2vGZsfZxQFWNoSUUMb4llKO900E6ruhr4xPxhTgqosBWO5wINzgMDywtKJB6uT/7WxSGCox5lUQ0Wx5FGfM5kihgwEUJ5RnIUKmrypdspHFRx8mDUzlpGbgTE8+YoWx5nKEjlQ2O8N0oxCrjH2U/ZZ3dSjkbkifG+WWUi8j/x3mf+I8WyUG/wFEsR++cDCnuDUnryFjVoNxG0NE07t2n6AMwlIkIiShMFPOT759woKwlW1gpcx3B5QDQ1IaMd2Rej5HDEL/PDwZmwmeqz4rpLezBR9Mb0JcYoGLbKg0JRdnIzDjyHMM8nddCEYtoYKLllVho63xDRItms154
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4945.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f36beb-44b5-43e9-4e38-08db82966f25
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 05:11:22.3859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uanOp/mGFJVBJ3M3MTrmb0YOGbfTg6QWLOPB0QdCkTwndLCijKIgVswPcBc8+CrZ3Wp2hlYleULI0uWVpIBy5oN9ilp+NrgKv7wmqQPA4Us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11528
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Jul 2023 05:11:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12325

SGkgSmFuLg0KDQpXZSBjaG9zZSB0aGlzIGFwcHJvYWNoIGJlY2F1c2UgdGhlIGthcy1tZW51IHdp
bGwgaGVscCB1c2VyIHRvIHVuZGVyc3RhbmQgd2hhdCBmZWF0dXJlcyBhcmUgaW5jbHVkZWQgaW4g
dGhlIGltYWdlIHdoZW4gc2VjdXJpdHkgZXh0ZW5zaW9ucyBpcyBzZWxlY3RlZC4gWW91ciBzdWdn
ZXN0aW9uIGlzIGFsc28gZ29vZC4NCg0KRG8geW91IHRoaW5rIHRoZXJlIGFyZSBhbnkgZHJhd2Jh
Y2tzIGluIG1vZGlmeWluZyBrYXMtbWVudSBhcHByb2FjaCwgSmFuLg0KDQpUaGFua3MgJiBSZWdh
cmRzLA0KU2FpIEFzaHJpdGggKFQgUyBJIFApDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmc+IE9uIEJlaGFsZiBPZiBKYW4gS2lzemthIHZpYSBsaXN0cy5jaXAtcHJvamVj
dC5vcmcNClNlbnQ6IFR1ZXNkYXksIEp1bHkgMTEsIDIwMjMgOTozOSBQTQ0KVG86IGFzaHJpdGgg
c2FpKO+8tO+8s++8qe+8sCkgPFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNvbT47IGNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQpDYzogZGluZXNoIGt1bWFyKO+8tO+8s++8qe+8sCBU
TUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29tPjsgaGF5YXNo
aSBrYXp1aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnvvKfilqHvvK3vvLDvvLPi
l4vvvK3vvLDvvJQpIDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPg0KU3ViamVjdDog
UmU6IFtjaXAtZGV2XSBbaXNhci1jaXAtY29yZV0gS2NvbmZpZzogQWRkIGFkZGl0aW9uYWwgZmVh
dHVyZXMgdG8gc2VjdXJpdHkgaW1hZ2UNCg0KT24gMTEuMDcuMjMgMTU6MzgsIFNhaS5TYXRodWpv
ZGFAdG9zaGliYS10c2lwLmNvbSB3cm90ZToNCj4gRnJvbTogU2FpIDxTYWkuU2F0aHVqb2RhQHRv
c2hpYmEtdHNpcC5jb20+DQo+IA0KPiBGcm9tIElFQyBjZXJ0aWZpY2F0aW9uIHBlcnNwZWN0aXZl
LCBhIHNlY3VyaXR5IGltYWdlIGlzIG5lZWRlZCB3aGljaCANCj4gaGFzIHRoZSBiZWxvdyBmZWF0
dXJlcyBhbG9uZyB3aXRoIHNlY3VyaXR5IGN1c3RvbWl6YXRpb25zLg0KPiAxLiBEYXRhIGVuY3J5
cHRpb24gKENSNC4xKQ0KPiAyLiBTZWN1cmUgYm9vdCAoRURSIDMuMTQpDQo+IDMuIFNXdXBkYXRl
IChORFIgMy4xMCkNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNhaSA8U2FpLlNhdGh1am9kYUB0b3No
aWJhLXRzaXAuY29tPg0KPiAtLS0NCj4gIEtjb25maWcgfCAzICsrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0tjb25maWcgYi9LY29uZmln
DQo+IGluZGV4IDk0ZTgwN2EuLmE5YzM0MjUgMTAwNjQ0DQo+IC0tLSBhL0tjb25maWcNCj4gKysr
IGIvS2NvbmZpZw0KPiBAQCAtMTcxLDYgKzE3MSw5IEBAIGNvbmZpZyBLQVNfSU5DTFVERV9JTUFH
RV9GT1JNQVQNCj4gIA0KPiAgY29uZmlnIElNQUdFX1NFQ1VSSVRZDQo+ICAJYm9vbCAiU2VjdXJp
dHkgZXh0ZW5zaW9ucyINCj4gKwlzZWxlY3QgSU1BR0VfREFUQV9FTkNSWVBUSU9ODQo+ICsJaGVs
cA0KPiArCSAgVGhpcyBlbmFibGVzIHNlY3VyaXR5IGN1c3RvbWl6YXRpb25zLCBkYXRhIGVuY3J5
cHRpb24sIFNlY3VyZWJvb3QgYW5kIFNXdXBkYXRlLCBhbGwgaW4gbmVlZCBmb3IgSUVDIGNlcnRp
ZmljYXRpb24gcGVyc3BlY3RpdmUuDQo+ICANCj4gIGNvbmZpZyBLQVNfSU5DTFVERV9TRUNVUklU
WQ0KPiAgCXN0cmluZw0KDQpJIHJhdGhlciB0aGluayBrYXMvb3B0L3NlY3VyaXR5LnltbCBzaG91
bGQgaW5jbHVkZSBrYXMvb3B0L2VuY3J5cHQtcGFydGl0aW9ucy55bWwgYW5kIGFueSBvdGhlciBr
YXMgb3B0aW9uIG5lZWRlZC4NCg0KSmFuDQoNCi0tDQpTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQpD
b21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51eA0KDQo=


