Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA790ECAAD5
	for <webhook@archiver.kernel.org>; Mon, 12 Sep 2022 09:45:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.5587.1662975938030699321
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Sep 2022 02:45:39 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 28C9jZhg002552;
 Mon, 12 Sep 2022 18:45:35 +0900
X-Iguazu-Qid: 34tMLsHDlH6qNXL9xG
X-Iguazu-QSIG: v=2; s=0; t=1662975927; q=34tMLsHDlH6qNXL9xG;
 m=F+XtfWYkc4D19IbcX1DR7gE8mpm3kYvzpR7bcdZZUOs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1510) id 28C9jRCu023214
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 12 Sep 2022 18:45:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xj05z7YAuwrdJ7bh4lzDRLQ6EZ0F7ctg5jhrMTNF7l3Vp1iSv2FbwbhRI4A5dtEaDMKrufEjTb0WE9Eu0db1YYesTzHcrF2mLJfn0DxBTmUmbyNP3LIMtU9lJQdANO2OJCG++j4GbhzEBDysF/el8xz4YzIXBSBS9Sbc9rC7LLeQBEFS+1LL1WnClGK6u9KPSBQYba8MKEYdwCi/TRPEa4md9peFlgcuxN/geaGbm4YZtN8+Oa5JnECh80OYII4MMVr3BVXN1vYh0DfIhwgUQY06neEhZIv6fv+CYDk7djJQSZKy1BqCWMpQ4RNMV7DIPIQ420OSfZ4Ms/xzKfiG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6E3A42U/8faLil+6JloreIOc1tNapVaVlgprvp0iFM=;
 b=HxDnT6qwDNis+ultaGD0GfrUgMd3JvuyqFUDeXk4DqENgsnJW3JU6PnBD9D2x4x0VYECuWVEEQ1/aXM23qUF5pyZCqXNbrOnxa11UoRdXiFuXRpnvqf1nzGAQPbhCybbhbHzYqB/iK2/fGrTQjJ723jN2cdxM4Kl49jSv2MI5U5O4UWF/HFXXhH5UDyiKqwJwFDD2yHQV6nz2daIlid20UIetQoBPuhmPBKGJW9VTUEug3hxOq54oaDn5AldpRqL/8wR0cGX5rH8I0n5PTVRQBdv4iejs3G4/VDKwxMBNtetIgBc1IRIDfr72QQUmT1iZ/f13P2ffNHgW0PTyZsjqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <Shivanand.Kunijadar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>,
        <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>
Subject: RE: [cip-dev] [isar-cip-core] README.swupdate.md: Add steps to verify
 SWUpdate on BBB
Thread-Topic: [cip-dev] [isar-cip-core] README.swupdate.md: Add steps to
 verify SWUpdate on BBB
Thread-Index: AQHYxFDS22gQ6oH7LkCg4k2HbDMlYa3XXfgAgAPt1gCAAENboA==
Date: Mon, 12 Sep 2022 09:45:20 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB82955072AD25CAD2FB206490E1449@TYCPR01MB8295.jpnprd01.prod.outlook.com>
References: <20220909132535.3671-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <d98e57e9-2219-6e09-582c-b465e9295193@siemens.com>
 <TYAPR01MB615442B769A2DE090F3AEB71C7449@TYAPR01MB6154.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB615442B769A2DE090F3AEB71C7449@TYAPR01MB6154.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8295:EE_|TYWPR01MB10290:EE_
x-ms-office365-filtering-correlation-id: 79b913a4-ede2-4c8b-c765-08da94a381f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 VASxR/UnMxcsCpojmCk1MHcIzoP2GvhN8hGjLlbwtz8hz/F4/Px3X3bO/+fNkIktHAtY62iveblN727R3bETYkdCiuDKmnPFTijrEzGV5i9vNHmwy4PceXas9QuHrwBC7NksLYwL4oDYS1B+/zbTsgW/ieSZ7W6QERt1nqHSTFVGvszRw6mk+WXkqXjuC0hekrKVJLENHuQEaCBuxow/sIykBlUIEYVAOjQ/TGZDqMWWRorBGKsFAuWKWXnx78xGWXN4cA6l+3GLre5wMOtOJgA2PyMXbYwPdkUwne+cb77EhvkwBeqPixvpQqF1/JhuJvVc8gmltSZ6TemKh3D+gqlCCrzduE7AEqzHrT3rCe4yHP5UGVzdvtDCsZtPNNA4/mE9WcXUxrY8sBdjAfPfQs8oOowxH2ciy9mLL0hDTeTTyx+vWinqds0KbfhefLSq/9aljUqVQYnv4hhB9xG6cwct1YZyMmnyORneWtyqFZH/rXhC7tXM4/mhkAmog+16Lif4yHS2RnGG2s3m+mtO9QbwhcsZLiZT8GXnfKLTqYm9mLKgZiC+FTc6vxDt8Uzz5jKZeqErmCI98bOgWXUNs2TlW1XjzjZQ/w707IrMGvDaHCvAAGPzN9MHl6QeEHUNHHdYBn8r2uMRf8uI7TbJh4YMC9G3HBUw/HuDBCLEnhRxJ0fi7Zd3VgSbaX6UWW/4ruFTjimAnqJux0GXnC+4hNAUqHAWzUKQUDTs+PCxWDXl8myfwm7jyVqxQemCmjen1B6I1ewRF2DJe09UR1kjUdt8QOLX6IaUbdqtSxLpACk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8295.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(71200400001)(7696005)(41300700001)(6506007)(9686003)(53546011)(26005)(478600001)(83380400001)(107886003)(186003)(15650500001)(52536014)(8936002)(5660300002)(55016003)(2906002)(110136005)(316002)(66476007)(66946007)(66446008)(4326008)(76116006)(64756008)(38100700002)(66556008)(86362001)(8676002)(38070700005)(122000001)(33656002)(47845001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K05sZlkvSWEwTjBDVlJIMnZtak5lZW1QVEFESFI1WTIxNlF6N0UxTVYrK0RN?=
 =?utf-8?B?a0dHVXM0NW02KzdkVWFsV1FYNDg2MWVVdlgzNUtERUY1aE90TmVhZGNwczNl?=
 =?utf-8?B?QlFpMkpNM2Y2cHB5ZlRXSWw0UFFSejJMZzdMTkR0OFZCTmI2QUd3bUh0NGdF?=
 =?utf-8?B?emxzVjFNcnJCeEZnUldZRTdmbFhJOGttVTZuTkRZWE16bXJRTHlTSWY2Zzcy?=
 =?utf-8?B?clYxdHdxOTRZaE5peEE3dnR5UGZQbkdyeCtWeHdpVmNsdllqSTdpTVQwQ1JB?=
 =?utf-8?B?L0RkckFjYnd6YytkUHlrajBsZTgvNGhhS3ZDUkh4S21PWTRsVzRYRkFoZTc1?=
 =?utf-8?B?SFloODhGQVBBVlRIdzFxWDd1eG5JeUU0cUN0MzRMSGVycHVSdGhHdExsMDBo?=
 =?utf-8?B?cVdtVXQ2bEROTjVyZHY4N3NxV0t2Q092a0JVSkY2TlVNNTFURThIYzRKZ1pi?=
 =?utf-8?B?QVd3UGtXZkxwKzdlQ1JWdTdIWEg0VTY3V1dJcHA2WW43azUyOVhkM2xtSHVZ?=
 =?utf-8?B?QlkybC9iMm14TGhMcnI3aGQrSlBqMTBMdjlkTDJOYnpoR0lzTmdBWkwvbTU1?=
 =?utf-8?B?NkdVYThRUUZ3Mis5dTdFS1RlNklhL0c0bkkrUVJlNWs4amxwaHZnbVdYQUJm?=
 =?utf-8?B?ZTBMWjhvdXFHeHFEYmY1dk04SEhUT25jK3lwb1RleHpqaXhMTFZWUit6WVcy?=
 =?utf-8?B?Nm1xMnREcHBLTzhYQVZiS2xyK1Z0Q1R0S1hNaG5NbG96Z21kbHkrQTh5RDBQ?=
 =?utf-8?B?YlBjZDJONzZsOWYrNjBMRkxDTUxVSmVoUExrM0FZVHdNNVhrUnhMR1VkRWhE?=
 =?utf-8?B?VnU5NStGYjdna3AxNGdMZlNiWkI2TUx4TG43Rkx6Rm12SFRNaytWUFk4TlZn?=
 =?utf-8?B?cy9NeUNEY3dlYytTQlBOVFNPOUlYbzVrcVREV3NxTWdueEErM1lyUFovdTNE?=
 =?utf-8?B?STg2dk5xWjNHK2NUTjBhcWpwaGIxNHRmZW5Gb1NjS2xMNStMUnJaTmJPVW03?=
 =?utf-8?B?TzFTb3JXcDcraHpEcGNtY1c2YjZnN09QcXIzUE1jZ0RwcDVFSlZVeWtXM2lU?=
 =?utf-8?B?ci80RC81eGI4aEVxNHY3NUpZOFVCY01obC94YnhyNDN2THBlNXVqNGhUbkFq?=
 =?utf-8?B?a2hXNHRKRks5VktNZ0F2VE5hVi9WWTkwNWhBeTJKak05TTV5ZEZkT09lenc5?=
 =?utf-8?B?VmRFTTlvQU52RnhNVkdjZVhNUWpUZnZ5ekxxQnU2YVZIR1JydWNLODA2V1NU?=
 =?utf-8?B?OXNzd1ZlY2tNTTdXY3ZObHNadmpxbTRVUXpNNFF1WTJLSDNRV1ZFNW9UR0tB?=
 =?utf-8?B?NGlUbnI0Smx6VVo0Rlp5Yk12QmgyS2liMkw5Z2lKcjZhMFV3YjA5ekFpVVdt?=
 =?utf-8?B?aEhXeVJ3RDdQSDJ3SnRMVTRtUEdvK3l1QUJaVGpoOERKZEpHdGJWVlNwZnFO?=
 =?utf-8?B?MFNkd0ZVbG1TNVdaUnVrWStOTjZISmozMVV0RXQ0djc3cWVpT292ODNlRzhJ?=
 =?utf-8?B?M2hGOGdIQVVqWkRNa3JLbHcwUHJCUWpka25Mc3dGOEJaMXpNbVFVMTlPTHh4?=
 =?utf-8?B?eTExdmpzNjdqTHJCa05ZZ1JrK09CS2VuNVh1RCtYUFE0Z0djNW12cnZIKzh5?=
 =?utf-8?B?b0NpWGVUTmc1TnBDMXBOK3dJb2J2cCtSc2VybnpRUGt5SUVGcFcvK01vRXNI?=
 =?utf-8?B?RkdSYlJvUkxDYXY2TkJlalpBVnRkWVBoYW5ieDQ3bEdtRC9SdFVWZ0s5WlNw?=
 =?utf-8?B?Y05wQTRjNTRsRnNDb1VxYUV2dmIzS2dOeC9jZHdScXo1YU84NUhZczJsQ1Rz?=
 =?utf-8?B?aUpmb3ZHTnNpK1NyeERycUVwWlkyRFBLU2hhc29hU1laekVSM1oxV2dBTjZN?=
 =?utf-8?B?QUhvMzkyK1RGNWw1MFRmWVZQd1AyVEppNU41TFZ0UnBiSDhScEFqeFBXSXpy?=
 =?utf-8?B?NHJrdGF4WnRhSm9vMlorYlB0R2NHK01sWlJBMkhxSFJMbjVab2lkOTVRYXdr?=
 =?utf-8?B?Y0tsRzVGTEtUL0hRS3ZGSUVZN3I2RWhDM2dmM2NoUkx3eUpoZFl0Qm8vME1D?=
 =?utf-8?B?T2NzanMzUDg4RlFBZmFSR3ZuazlKeHloeFI3akJ2Q3NkSGRlU1RqVHVGNWVQ?=
 =?utf-8?B?bWE5UDlMcjNCRS9sR3FjUVpYREVBSXNveGg5UUJSODVXY1NuZ0FYaTBmYTVy?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8295.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 79b913a4-ede2-4c8b-c765-08da94a381f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 09:45:20.6826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 N3689Qp3VjHvrsdRyqI8/wNVOxyzk/eVgwd/l/2KjAOY/fEy8+h5IzJNjn0ZKOvI9rx+P/HMBCtAuPxtKYwD2CKivb0ZF9Vyzzfiqj6LJFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10290
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Sep 2022 09:45:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9488

SGVsbG8gU2hpdmEtc2FuLA0KDQo+IA0KPiBIZWxsbyBKYW4sDQo+IA0KPiBUaGFuayB5b3UgZm9y
IHRoZSBzdWdnZXN0aW9uLiBJIHRoaW5rIHRoZSBhcHByb2FjaCB5b3UgbWVudGlvbmVkIGlzIG1v
cmUgZGV2ZWxvcGVyIGZyaWVuZGx5IGNvbXBhcmVkIHRvIG1pbmUuDQo+IGhvd2V2ZXIsIEkgd291
bGQgbGlrZSBrZWVwIGJvdGgsIGxldCB1c2VyIHNlbGVjdCB0aGUgcHJlZmVyYWJsZSBvcHRpb24u
IElzIGl0IG9rPw0KDQpJIHRoaW5rIHRoZSBkb2N1bWVudCBzaG91bGQgYmUgc2hvcnRlciAmIHNp
bXBsZXIgYW5kIGZvY3VzIG9uIFNXVXBkYXRlIHRlc3RpbmcuDQpJZiB0aGUgbmV0d29yayBzZXR0
aW5ncyBzdGVwIGlzIGp1c3QgZm9yICJzY3AiLCBpdCdzIGJldHRlciB0byByZXBsYWNlIGl0IGJ5
IGFub3RoZXIgc2ltcGxlIHdheS4NCg0KQmVzdCByZWdhcmRzLA0KS2F6dQ0KDQo+IA0KPiBUaGFu
a3MgJiBSZWdhcmRzDQo+IFNoaXZhbmFuZCBLDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmc+IE9uIEJlaGFsZiBPZiBKYW4gS2lzemthDQo+IFNlbnQ6IEZyaWRh
eSwgU2VwdGVtYmVyIDksIDIwMjIgMTE6MTEgUE0NCj4gVG86IGt1bmlqYWRhciBzaGl2YW5hbmQo
77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8U2hpdmFuYW5kLkt1bmlqYWRhckB0b3No
aWJhLXRzaXAuY29tPjsNCj4gY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gQ2M6IGRp
bmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gua3VtYXJA
dG9zaGliYS10c2lwLmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDilqHvvLPvvLcN
Cj4g77yj4pev77yh77yj77y0KSA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4NCj4g
U3ViamVjdDogUmU6IFtjaXAtZGV2XSBbaXNhci1jaXAtY29yZV0gUkVBRE1FLnN3dXBkYXRlLm1k
OiBBZGQgc3RlcHMgdG8gdmVyaWZ5IFNXVXBkYXRlIG9uIEJCQg0KPiANCj4gT24gMDkuMDkuMjIg
MTU6MjUsIFNoaXZhbmFuZC5LdW5pamFkYXJAdG9zaGliYS10c2lwLmNvbSB3cm90ZToNCj4gPiBG
cm9tOiBTaGl2YW5hbmQgS3VuaWphZGFyIDxTaGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEtdHNp
cC5jb20+DQo+ID4NCj4gPiBNb3N0IG9mIHRoZSBzdGVwcyBhcmUgc2ltaWxhciBmb3IgYm90aCBx
ZW11LWFtZDY0IGFuZCBCQkIgdGFyZ2V0cy4NCj4gPiBBZGQgcmVmZXJlbmNlIGxpbmsgd2hlcmV2
ZXIgcmVxdWlyZWQgaW5zdGVhZCBvZiByZXBlYXRpbmcgc3RlcHMuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBTaGl2YW5hbmQgS3VuaWphZGFyDQo+ID4gPFNoaXZhbmFuZC5LdW5pamFkYXJAdG9z
aGliYS10c2lwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZG9jL1JFQURNRS5zd3VwZGF0ZS5tZCB8IDUy
DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZG9j
L1JFQURNRS5zd3VwZGF0ZS5tZCBiL2RvYy9SRUFETUUuc3d1cGRhdGUubWQgaW5kZXgNCj4gPiAx
YjI0MmEyLi43MjY5MGQ2IDEwMDY0NA0KPiA+IC0tLSBhL2RvYy9SRUFETUUuc3d1cGRhdGUubWQN
Cj4gPiArKysgYi9kb2MvUkVBRE1FLnN3dXBkYXRlLm1kDQo+ID4gQEAgLTMyLDYgKzMyLDggQEAg
Q29weQ0KPiA+IGBjaXAtY29yZS1pbWFnZS1jaXAtY29yZS1idWxsc2V5ZS1xZW11LWFtZDY0LnN3
dWAgZmlsZSBmcm9tIGB0bXBgIGZvbGRlciBpbiAgaG9zdCQgc2NwIC1QIDIyMjIyDQo+IC90bXAv
Y2lwLWNvcmUtaW1hZ2UtY2lwLWNvcmUtYnVsbHNleWUtcWVtdS1hbWQ2NC5zd3Ugcm9vdEBsb2Nh
bGhvc3Q6DQo+ID4gIGBgYA0KPiA+DQo+ID4gKyMjIFNXVXBkYXRlIHZlcmlmaWNhdGlvbg0KPiA+
ICsNCj4gPiAgQ2hlY2sgd2hpY2ggcGFydGl0aW9uIGlzIGJvb3RlZCwgZS5nLiB3aXRoIGxzYmxr
Og0KPiA+ICBgYGANCj4gPiAgcm9vdEBkZW1vOn4jIGxzYmxrDQo+ID4gQEAgLTIxNSwzICsyMTcs
NTMgQEAgdXNlciB2YXJpYWJsZXM6DQo+ID4NCj4gPg0KPiA+ICBgYGANCj4gPiArDQo+ID4gKyMg
QnVpbGRpbmcgYW5kIHRlc3RpbmcgdGhlIENJUCBDb3JlIGltYWdlIGZvciBCQkINCj4gPiArDQo+
ID4gK0ZvbGxvdyB0aGUgc3RlcHMgbWVudGlvbmVkIGluIHRoZSBzZWN0aW9uIFtCdWlsZGluZyBh
bmQgdGVzdGluZyB0aGUgQ0lQIENvcmUNCj4gaW1hZ2VdKFJFQURNRS5zd3VwZGF0ZS5tZCNidWls
ZGluZy1hbmQtdGVzdGluZy10aGUtY2lwLWNvcmUtaW1hZ2UpIGZvciBjcmVhdGluZyBpbWFnZXMg
YW5kIC5zd3UgZmlsZXMuDQo+ID4gKy0gUmVwbGFjZSBxZW11LWFtZDY0LnltbCBrYXMgZmlsZSB3
aXRoIEJCQiBib2FyZCBzcGVjaWZpYyBmaWxlIGkuZQ0KPiA+ICtiYmIueW1sDQo+ID4gKy0gLnN3
dSBmaWxlIHdpbGwgYmUgZ2VuZXJhdGVkIGluIHRoZSBmb2xsb3dpbmcgZm9sZGVyDQo+ID4gK2J1
aWxkL3RtcC9kZXBsb3kvaW1hZ2VzL2JiYi8NCj4gPiArDQo+ID4gK0ZsYXNoIHRoZSBCZWFnbGVC
b25lIEJsYWNrIGltYWdlIGludG8gU0RjYXJkIGBgYCBob3N0JCBkZA0KPiA+ICtpZj1idWlsZC90
bXAvZGVwbG95L2ltYWdlcy9iYmIvY2lwLWNvcmUtaW1hZ2UtY2lwLWNvcmUtYnVsbHNleWUtYmJi
LndpYyBcDQo+ID4gKyAgIG9mPS9kZXYvPG1lZGl1bS1kZXZpY2U+IGJzPTFNIHN0YXR1cz1wcm9n
cmVzcyBgYGANCj4gPiArDQo+ID4gK1ByZXBhcmUgdGhlIGhhcmR3YXJlIGNvbm5lY3Rpb25zDQo+
ID4gKw0KPiA+ICstIENvbm5lY3QgYSBzZXJpYWwgcG9ydCBjYWJsZSBiZXR3ZWVuIGhvc3QgUEMg
YW5kIEJCQg0KPiA+ICstIENvbm5lY3QgYW4gRXRoZXJuZXQgY2FibGUgYmV0d2VlbiBob3N0IFBD
IGFuZCBCQkINCj4gPiArDQo+ID4gK0luc2VydCBTRCBjYXJkIHRvIEJCQiwgaG9sZCBTMiBidXR0
b24gd2hpbGUgYXBwbHlpbmcgcG93ZXIgc3VwcHkgdG8gQkJCLg0KPiANCj4gdHlwbzogc3VwcGx5
DQo+IA0KPiA+ICtPbmNlIHRoZSBzeXN0ZW0gaXMgdXAsIGV4ZWN1dGUgYmVsb3cgY29tbWFuZCB0
byBjb25maWd1cmUgc3RhdGljIElQDQo+ID4gK2FkZHJlc3MgdG8gQkJCDQo+ID4gKw0KPiA+ICtg
YGANCj4gPiArcm9vdEBkZW1vOn4jIGNhdCA8PEVPRiA+PiAvZXRjL25ldHdvcmsvaW50ZXJmYWNl
cyBhdXRvIGV0aDAgaWZhY2UNCj4gPiArZXRoMCBpbmV0IHN0YXRpYw0KPiA+ICsgIGFkZHJlc3Mg
MTkyLjE2OC4yLjINCj4gPiArICBuZXRtYXNrIDI1NS4yNTUuMjU1LjANCj4gPiArICBuZXR3b3Jr
IDE5Mi4xNjguMi4wDQo+ID4gKyAgYnJvYWRjYXN0IDE5Mi4xNjguMi4yNTUNCj4gPiArRU9GDQo+
ID4gK3Jvb3RAZGVtbzp+IyAvZXRjL2luaXQuZC9uZXR3b3JraW5nIHJlc3RhcnQgYGBgDQo+ID4g
Kw0KPiA+ICtJbiBob3N0IFBDLCBjb25maWd1cmUgYmVsb3cgc2V0dGluZ3MgZm9yIEV0aGVybmV0
IElQdjQuDQo+ID4gKw0KPiA+ICstIElQIGFkZHJlc3M6IDE5Mi4xNjguMi4xDQo+ID4gKy0gU3Vi
bmV0IG1hc2s6IDI1NS4yNTUuMjU1LjANCj4gPiArDQo+ID4gK0V4ZWN1dGUgYmVsb3cgY29tbWFu
ZCB0byBjb25maXJtIDE5Mi4xNjguMi4xIGlzIGFjY2Vzc2libGUgZnJvbSBCQkIuDQo+ID4gK2Bg
YA0KPiA+ICtyb290QGRlbW86fiMgcGluZyAxOTIuMTY4LjIuMQ0KPiA+ICtgYGANCj4gPiArDQo+
ID4gK0NvcHkgLnN3dSBmaWxlIGZyb20gYHRtcGAgZm9sZGVyIHRvIEJCQiBmcm9tIGhvc3QgUEMg
dXNpbmcgYmVsb3cgY29tbWFuZC4NCj4gPiArDQo+ID4gK2BgYA0KPiA+ICtob3N0JCBzY3AgdG1w
L2NpcC1jb3JlLWltYWdlLWNpcC1jb3JlLWJ1bGxzZXllLWJiYi5zd3UNCj4gPiArcm9vdEAxOTIu
MTY4LjIuMjovcm9vdC8gYGBgDQo+ID4gKw0KPiA+ICtGb3IgdmVyaWZ5aW5nIHN3dXBkYXRlIG9u
IEJCQiB1c2UgdGhlIHNhbWUgc3RlcHMgYXMgbWVudGlvbmVkIGluIGFib3ZlIFtTV1VwZGF0ZQ0K
PiBWZXJpZmljYXRpb25dKFJFQURNRS5zd3VwZGF0ZS5tZCNzd3VwZGF0ZS12ZXJpZmljYXRpb24p
Lg0KPiANCj4gSG93IEkgdGVzdGVkIChpbiB0aGUgYWJzZW5jZSBvZiBhIHRlc3QgbmV0d29yayBh
dCB0aGF0IHRpbWUpOg0KPiAtIG1vdW50IHRoZSBmbGFzaGVkIFNELWNhcmQgb24gdGhlIGhvc3QN
Cj4gLSBjcCB0aGUgRElGRkVSRU5UIHN3dSBpbnRvIDxtbnQ+L3Jvb3QvDQo+IC0gYm9vdCB0aGUg
dGFyZ2V0IGFuZCBydW4gc3d1cGRhdGUgLWkgL3Jvb3QvPGltYWdlPi5zd3UNCj4gDQo+IEkgdGhp
bmsgdGhhdCBpcyBzaW1wbGVyIGlmIHRoZXJlIGlzIG5vIGNvbW1vbiBuZXR3b3JrIHdpdGggZGhj
cCBpbiByZWFjaC4NCj4gDQo+IEphbg0KPiANCj4gLS0NCj4gU2llbWVucyBBRywgVGVjaG5vbG9n
eQ0KPiBDb21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51eA0K


