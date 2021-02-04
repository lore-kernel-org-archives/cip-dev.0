Return-Path: <SRS0=wRoS=HG=lists.cip-project.org=bounce+64572+6163+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7881C433E6
	for <cip-dev@archiver.kernel.org>; Thu,  4 Feb 2021 07:57:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2FA664F4D
	for <cip-dev@archiver.kernel.org>; Thu,  4 Feb 2021 07:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FA664F4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6163+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YWH0YY4521723xxsixuGliPE; Wed, 03 Feb 2021 23:57:10 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web08.4791.1612425428186562162
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Feb 2021 23:57:09 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 1147v6kq031626; Thu, 4 Feb 2021 16:57:06 +0900
X-Iguazu-Qid: 34tKPbYPQ4fDzqtZqz
X-Iguazu-QSIG: v=2; s=0; t=1612425425; q=34tKPbYPQ4fDzqtZqz; m=Zwa4Uux2CCQgmJR3KEgtJb4ADB195tXwJzRuuIbevtA=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1513) id 1147v5aJ007458;
	Thu, 4 Feb 2021 16:57:05 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 1147v58C022587
	for <cip-dev@lists.cip-project.org>; Thu, 4 Feb 2021 16:57:05 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 1147v477024205
	for <cip-dev@lists.cip-project.org>; Thu, 4 Feb 2021 16:57:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHme5nVu36foIKZ8lob4+YMDiYmkngUQXDK+XdfwWK2t2mntLEmgLhHa2f+9g5uamWA8HHipVrdnLgTrqR803nQkPYPUceIFuaiGQ5QBfjw4tWiW+C+BrgFry/jcYGwyYywX4DHvyftQR7obU2zwBBNreuVR/2/2nAgxk/9nqLf8J0b7itq7QSGnRCdK9QXxJ+AtSa1u/EjbZA8qyXPTLAzGvzEWJOU4Ysbs6B6fbDP03d5f6ckEixOmrKquLhtXurwK9nSMIEyF57uJqybEeM8QqlL5GGlh6X1atoW6DPdRBGuhEvV+96Nu+/DvG7gc/YRrZuw2kNc9JOEwdihnzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4ftmUtRlntq5RdhwiAI+ODJ/JZ19TSM8/yetMkwuCY=;
 b=Cp3zLWp+3KxUY6X12lJL0RcWD2V0LJbWomK7u2O67xj163pmDVcoxdun4A6xoSSD7Zi8WOpueLNqFzMen+v/D3YmbkRIDWDtkB6pHCD7IsW2X/qAg+v3ETjf02BG9SwjLU9RWucLcoHzKrg77drrSQgk9dGuopGY7kGEEJMn23klvFjX/1mIydVKQvQ4Q8YlEVpLn8IZZ+7mWOmCDtlDnwMGRkVlC39cZefSNJI7IIsm3X+JIiAtVvEvSjti3qDguveRCFgAESRnax0MIlwyZ6XScGCZBbD3sOyQSaoNWqYEzF5/9uS1LEi7+Dno6RETjqjivSm9bbOUKzv7QBq88A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: Adb6iENxGVhTb0feTA+r2jFv1+nRRAAQr0cQ
Date: Thu, 4 Feb 2021 07:57:00 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298320FA065FD9635EFD446592B39@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <TY2PR01MB497246230D4367AE668FE17CA0B49@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB497246230D4367AE668FE17CA0B49@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba5b9d99-b9ed-4ebc-75ff-08d8c8e273b4
x-ms-traffictypediagnostic: OS0PR01MB5505:
x-microsoft-antispam-prvs: <OS0PR01MB55053A2F9958B3D1ACBC5DE892B39@OS0PR01MB5505.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v34FTROUzLOPeiG4iQKzyu5rzPiXAq9Aj8fnk2FiQBA9av/yjJPHSrEBwYpCe6pQnrJYZ1T4IMELIklJn6t+Rms0YIgJfTYHfviamdLyPJmPdiXtynUuvTzr1E2o/vMAWKlM122vMaak9PGShC2OOw8wY0wNyN9/QWswLLq4bTUKFtl92zuCgpDK+c+AErTL1AC+8TMqtCiAanCZntvw59H73Uj4gq2osPibWJIaTz0nxx3YisW0MbthrpQOlFe69e7kttE+kkKLA8TFXPLQlWzotzpSeFQpxQRdF+UEZjpL0+2xcrGDdeu8Tq00zuhQxmwCguN0O7JJmj8+zc2Ca4owgpg91SfCMW0HSulaTlSoEJ2njFoAZ5u+nKoDVaIGagSEl7ezh81dP6qV+ivKNAHfwYqXy8KbluhEm44dp6O3jKpLY2yW/LkLDOg93cEibwZnETRDeekXdvuP567dOc/VmcBjnlV7l2GzTCQjlSu8OpTCL+RnSyGQNdIkznwHJV2zRcBhm2UQc+cSi+Q01ZhP9XAyq9snsomoHtWUoPXB6oLb7pskqoW0t4HgJZkeQCyAxpM0DZyNvdHm2AP+pvH7zO+Je83Cs2gwA9x8ZFQ=
x-ms-exchange-antispam-messagedata: =?utf-8?B?aWQvYjdJbVBPU25OWVhycjNaTFRVajFKOVoxd05wTXJtNm5LSCtBdjhqODRY?=
 =?utf-8?B?NlovZDVDMGphNkx4RC9SSTFiZitPL1dzY2QrSDRPMUZRb0QyTm4wcVJrRklW?=
 =?utf-8?B?VkpKMTByUC9ZTnNMN3FMaTJZK3p3L1lKYW1nRHRwcmhPQWQyNCtDY0JOSVdm?=
 =?utf-8?B?VEROMC84cGdYRFJCNHFucVVWYk51Q0FHbjM5b1FvRTcyQzU0MUN2c3BHUUtV?=
 =?utf-8?B?dHR1YWtjZm1EcURLU1hLWjd3Mk5jVVB4b2RCMm8zTEdkNW1SVDR1Nm9CbDh0?=
 =?utf-8?B?WTBCekJnV2RLbHdRbEhGdEhkOWVBck51YlVlMEUvMDd1SllVUEVleEpoK05i?=
 =?utf-8?B?ZmpJNU91MVdSSE0wV01ic1c3Z0JHSk1YMEMyUDZoalRxbVhKZUpMWUlEWEtI?=
 =?utf-8?B?cDNnKzZqdHh5NGl4bFJ2dWtsNC9vUUo4dGcwMndYa3dNWXdjMTAvMWtIZm8w?=
 =?utf-8?B?c2h0WUdjUmpHV3JDVDdUbGY0VlFIa1Qrc0lkWEU5T0pqRUxiRC8zcllnYnZ1?=
 =?utf-8?B?cndxNzhsck82VHFDYlZkQ2ozWmxyb0JmQkdMMmszVi9lNks5OWVxM2t6RGFM?=
 =?utf-8?B?NTZNNlJ4bHp5eVAyOTFkNmhRQlVKUURFclNnMWo1Uzk5QVp6Vmd3TTE4TnFG?=
 =?utf-8?B?T1drTVQwcG1SRUpoM25PSkw1MHFJV2RwN0FNQWJjcC83RHR5MmgzTWtLNFly?=
 =?utf-8?B?dVBMUjZNLy9saFdkNkZKZTZjZDc5VUhqMXlqemRhZ2EvV3VUa1FjZlFhWVJi?=
 =?utf-8?B?Z3Vhb2VHelNpK2ZJWFNIRHM5T1Z3VUw2djZuT3h6aTJmWkQ5L3g5Y3ZGeGMy?=
 =?utf-8?B?QXlkU0t0K0VPYVhHUG5FektqV2RvbjYrQ09tYXVPU0lod0tTeGYrS096UXdM?=
 =?utf-8?B?cW85TlhNcVR0YmNYOWRwVysza0srSGEwczlNQkNncU1DZlhrWndGLzAvc3Y4?=
 =?utf-8?B?SFNjVUJlSzB3aTFPM1huSnpOQmtkenNrWXYyd290RjkyNnROc0RmNitMbGZY?=
 =?utf-8?B?MzhkTU9aM0pxM24vaEFVQ2xHY0dPdU9yRFpIOUVkMjNHdWY0REJjVEdOZVJV?=
 =?utf-8?B?ZUxYaXR6UjhWSWZxS0YrNldkMEV0bXNEM0M2dU55YklaTWxXQUo1NFlxVDds?=
 =?utf-8?B?dkJCdVFpNnBtYlZKU1YvcUlXaysrZ3FvcmI1allxQ09XdW1YbzRPOHJwM0Y3?=
 =?utf-8?B?Zk9TTGkyN1pwcUphb0RWenRhVHFMUzh5YnU0dDRYVnBiZTY4REtCampYSlF4?=
 =?utf-8?B?dW9GK3FVckdFaXRTSlByTzZXekZQN1pYUmRqT0M3K2dvNVJ1RWlrYTZac2V1?=
 =?utf-8?B?S2FTdnB3cldvckVHY2xlRlZTUWIyVUZQdXU4a2ZrOEVWQWxsYzBuMkMxYXNL?=
 =?utf-8?B?b0VqOGJ1ZHRYcExjaGwvMXl6cjAya3ROVDQ5YVkxUWIzdVJOMWJRNUFweUNo?=
 =?utf-8?B?OUVHaVErL2VhbnhLV21Vcloxc0J2Znh1bHYvOTQ3QjdHM1U3b1k5VU9uSkwy?=
 =?utf-8?B?U2RHMTJJeTZzOW04MkxWclpRc0dYZG1VZFB5Z1NXWDhaTmduUHNnNVAyMU5G?=
 =?utf-8?B?MWlFTXpzVkdHakE1eGhJclU1K0xCMEZub1VUSXFuOUdPci9tcnp4cm9Rd1Bl?=
 =?utf-8?B?SFNwOGJZKzYrRjZBR0ttS2Q3S0hRT1FCQXkreG9OSXNnZ3Y5WkRJWjY3aytm?=
 =?utf-8?B?eDJyQzZaajRUcjNCQkhjbTUyN3VYNXBYOWNrdDB5dzRMM3FFS0R1Q2kxSVpH?=
 =?utf-8?Q?Hne/JAG40KLrkJqwqs=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5b9d99-b9ed-4ebc-75ff-08d8c8e273b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 07:57:00.1212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vm3F8J+7grvuhb6bOjmknMV2ExuI1za8RZqYjCxNHhkgsqrH9g7QN+KjKk/uf48aZ93sIVECUjC/F8iBux6KbJPRcbZRvQ+CQqk9Xdm3F8d1TB13z0uhVZqR9ajuwtfV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5505
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: njpJ93aIAjDN5zSwhyqdMdAux4520388AA=
Content-Type: multipart/mixed; boundary="QVsqnlpCKuZ81ujlumB6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1612425430;
 bh=XWPJcAIAtCrPVyRlTSI2tiXU/W/u5IWr8wWkQu5lXQM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ijfpl46GDMP2eLhCYNbZf+CjPVaSZicWH0bDBZ3RwyNBudYbN8aBJKlWK5dVmmIaHne
 2dbWfP4/H7ubHSXu2K4giSfaHB3cRNeFxLSF5lmC8Xetn2M+S8oKEN5Ftlm656P+Bfcnr
 nuUhGbIIaK8pOCWW48btD9yaWh0qJJBJ/wY=

--QVsqnlpCKuZ81ujlumB6
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkkgY2FuIG5vdCBwYXJ0aWNpcGF0ZSBJUkMgbWVldGluZyB0b2RheSBmb3IgcGVyc29u
YWwgcmVhc29uLg0KDQo+ICogQWN0aW9uIGl0ZW0NCj4gICAxLiBDb21iaW5lIHJvb3QgZmlsZXN5
c3RlbSB3aXRoIGtzZWxmdGVzdCBiaW5hcnkgLSBpd2FtYXRzdQ0KDQpObyBVcGRhdGUuDQoNCj4g
ICAyLiBEbyBzb21lIGV4cGVyaW1lbnQgdG8gbG93ZXIgYnVyZGVucyBvbiBDSSAtIHBhdGVyc29u
Yw0KPiAgIDMuIENoZWNrIGhpdGFjaGlfb21hcCBkZWZjb25maWdzIHdydCBDVkUtMjAyMC0yNzgy
MCBbZHJtL25vdXZlYXUgVUFGXSAtIEhpdGFjaGktdGVhbQ0KPiANCj4gKiBLZXJuZWwgbWFpbnRl
bmFuY2UgdXBkYXRlcw0KDQpJIHJldmlld2VkIDQuNC4yNTUuDQoNCj4gKiBLZXJuZWwgdGVzdGlu
Zw0KPiAqIENJUCBTZWN1cml0eQ0KPiAqIEFPQg0KDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhp
cm8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjaXAtZGV2QGxpc3Rz
LmNpcC1wcm9qZWN0Lm9yZyBbbWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnXSBP
biBCZWhhbGYgT2YNCj4gbWFzYXNoaS5rdWRvQGN5YmVydHJ1c3QuY28uanANCj4gU2VudDogVGh1
cnNkYXksIEZlYnJ1YXJ5IDQsIDIwMjEgOTowNCBBTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmcNCj4gU3ViamVjdDogW2NpcC1kZXZdIENJUCBJUkMgd2Vla2x5IG1lZXRpbmcg
dG9kYXkNCj4gDQo+IEhpIGFsbCwNCj4gDQo+IEtpbmRseSBiZSByZW1pbmRlZCB0byBhdHRlbmQg
dGhlIHdlZWtseSBtZWV0aW5nIHRocm91Z2ggSVJDIHRvIGRpc2N1c3MgdGVjaG5pY2FsIHRvcGlj
cyB3aXRoIENJUCBrZXJuZWwgdG9kYXkuDQo+IA0KPiAqUGxlYXNlIG5vdGUgdGhhdCB0aGUgSVJD
IG1lZXRpbmcgd2FzIHJlc2NoZWR1bGVkIHRvIFVUQyAoR01UKSAwOTowMCBzdGFydGluZyBmcm9t
IHRoZSBmaXJzdCB3ZWVrIG9mIEFwci4gYWNjb3JkaW5nDQo+IHRvIFRTQyBtZWV0aW5nKg0KPiBo
dHRwczovL3d3dy50aW1lYW5kZGF0ZS5jb20vd29ybGRjbG9jay9tZWV0aW5nZGV0YWlscy5odG1s
P3llYXI9MjAyMSZtb250aD0yJmRheT00JmhvdXI9OSZtaW49MCZzZWM9MCZwMT0yMjQmcDI9MQ0K
PiA3OSZwMz0xMzYmcDQ9MzcmcDU9MjQxJnA2PTI0OA0KPiANCj4gVVNXZXN0CVVTRWFzdAlVSwlE
RQlUVwlKUA0KPiAwMTowMAkwNDowMAk5OjAwCTEwOjAwCTE3OjAwCTE4OjAwDQo+IA0KPiBDaGFu
bmVsOg0KPiAqIGlyYzpjaGF0LmZyZWVub2RlLm5ldDo2NjY3L2NpcA0KPiANCj4gTGFzdCBtZWV0
aW5nIG1pbnV0ZXM6DQo+IGh0dHBzOi8vaXJjbG9ncy5iYXNlcm9jay5vcmcvbWVldGluZ3MvY2lw
LzIwMjEvMDEvY2lwLjIwMjEtMDEtMjgtMDkuMDAubG9nLmh0bWwNCj4gDQo+ICogQWN0aW9uIGl0
ZW0NCj4gICAxLiBDb21iaW5lIHJvb3QgZmlsZXN5c3RlbSB3aXRoIGtzZWxmdGVzdCBiaW5hcnkg
LSBpd2FtYXRzdQ0KPiAgIDIuIERvIHNvbWUgZXhwZXJpbWVudCB0byBsb3dlciBidXJkZW5zIG9u
IENJIC0gcGF0ZXJzb25jDQo+ICAgMy4gQ2hlY2sgaGl0YWNoaV9vbWFwIGRlZmNvbmZpZ3Mgd3J0
IENWRS0yMDIwLTI3ODIwIFtkcm0vbm91dmVhdSBVQUZdIC0gSGl0YWNoaS10ZWFtDQo+IA0KPiAq
IEtlcm5lbCBtYWludGVuYW5jZSB1cGRhdGVzDQo+ICogS2VybmVsIHRlc3RpbmcNCj4gKiBDSVAg
U2VjdXJpdHkNCj4gKiBBT0INCj4gDQo+IFRoZSBtZWV0aW5nIHdpbGwgdGFrZSAzMCBtaW4sIGFs
dGhvdWdoIGl0IGNhbiBiZSBleHRlbmRlZCB0byBhbiBob3VyIGlmIGl0IG1ha2VzIHNlbnNlIGFu
ZCB0aG9zZSBpbnZvbHZlZCBpbiB0aGUgdG9waWNzDQo+IGNhbiBzdGF5LiBPdGhlcndpc2UsIHRo
ZSB0b3BpYyB3aWxsIGJlIHRha2VuIG9mZmxpbmUgb3IgaW4gdGhlIG5leHQgbWVldGluZy4NCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gTS4gS3Vkbw0KPiBDeWJlcnRydXN0IEphcGFuIENv
LiwgTHRkLg0KDQo=

--QVsqnlpCKuZ81ujlumB6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6163): https://lists.cip-project.org/g/cip-dev/message=
/6163
Mute This Topic: https://lists.cip-project.org/mt/80368913/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--QVsqnlpCKuZ81ujlumB6--
