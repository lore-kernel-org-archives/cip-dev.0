Return-Path: <SRS0=owfH=IJ=lists.cip-project.org=bounce+64572+6273+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ED3C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 11 Mar 2021 08:07:09 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44FB864EAE
	for <cip-dev@archiver.kernel.org>; Thu, 11 Mar 2021 08:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FB864EAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6273+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Im2ZYY4521723xd58V27rNzJ; Thu, 11 Mar 2021 00:07:07 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web08.3182.1615450024627292947
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Mar 2021 00:07:06 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 12B871IP025457; Thu, 11 Mar 2021 17:07:01 +0900
X-Iguazu-Qid: 2wHHt48KCh6yRLUclB
X-Iguazu-QSIG: v=2; s=0; t=1615450021; q=2wHHt48KCh6yRLUclB; m=WH6SknfllB9+VqOzXHutFibrH21iFFRu9zi938KKB9M=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1112) id 12B870Pk036244
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 11 Mar 2021 17:07:00 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 28BAB1000E5
	for <cip-dev@lists.cip-project.org>; Thu, 11 Mar 2021 17:07:00 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 12B86xrP030407
	for <cip-dev@lists.cip-project.org>; Thu, 11 Mar 2021 17:07:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfniJajtV1vCBFBBSGi/lnioSIO4SJlqrXqVLuUKUVszs0w8TSvMaqfaIOlKF6tq/qHbSfWJAFM41QUmR+3w6P5XgMonxboXb/Zs3f1wyOtxP1rKPYkiVlGpUeGncjCZyBEJs3jJKCYYDOkE0hJAH1zxhWDBp247C/DMQISHJFjpg5e5cbfMZ3j9DDWMcFRYpW0G88g+m3aXTR58ICdJMjqqkCIxrwkRqWb7w9O7yp4zOpYvEA/qf2cp1ElX7hFY5ZaiiJk6vWlaUzo66SAu+cUKtlLNrzo6/yio2W3G5WUesz33DA/SYtbIDEwxkv17t28E/n4iZcbNOv2s3laFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySg03V/cL4NFyVmXzJ34+fCJNh4mS6RiHsnR+M6UmNs=;
 b=WS/bpEuKstwHZ3hinJARMJDGaEqSfCP+616iOC6z9hCj6LYB16KBzBuUstJczkaSrYaoaJukObRfOzYYAb/Av1TBcTTwal8ZDgDRGeUsBhIkuWchEOdL0Ki6Y/wbhbeSJY6Qr6GyMipesySlQbucnO65Hu21/oG+D6eXc+A9+3yjWfIeI1EJga4Adh7+xlohtqLcWiOhkQ19x4bFRlLyUUosH7x+Z4CQsJZ3hiNYNnFdGTkKvjBertcT0slvBkkPCYlqnxb2N74YmL08uK5pCJvgR62t8CA/dALYl/BJLNUp7bAS/1iQw9PnFRJPLe4Ds5rR9tkNDMdgG8TUbSeBQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdcWC9geH3PVZlYMSnSakK31ZVNvwgAP6l0w
Date: Thu, 11 Mar 2021 08:06:57 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298354E658F643F8FFAEC21D92909@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <TY2PR01MB4972C6B8D65CB31065A6043EA0909@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB4972C6B8D65CB31065A6043EA0909@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e0fcc3f-552a-4750-5ded-08d8e464a490
x-ms-traffictypediagnostic: OS0PR01MB5666:
x-microsoft-antispam-prvs: <OS0PR01MB5666BF030B6632F8F8A0F36692909@OS0PR01MB5666.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dP0ngGP4OWn2jFt7VlfChU1zoV6meGzrR7Uao2h6h6jZjE4latc04kkjbDjkokViwHT5u8EHrtgnCkCYI4r4gGu6aOWEMopgqF6/MGw7D/+p+5Rp8P2i7YN/rb2EaU/jGZ940OcXyG6XpemZ8c4t+go2luRqGTnpLhC2Ya30MV1UvkniHwlLG3TPEDDCc/fm8hGZSfvGG0mYCMAwY1aQV8bClSx6AuPtiKJ/B//4XNvDwmMjLx5iCMDjLnoZ5XWzhtVy5aEPVxfN9wW62AH3XTbJVO7HGyEBxCFI7fFRRD6pAZfmbyDdJFrnyTj/VqbOF6hAHyoRbdPx+YCWbpq2tFMBIPk17IiKGM5GzBuX47GPF0Jt6XAkLZvFQ8OsnIT+w/RzJkA0zLKW6GNvuwVrB2M/fWJkvB9cQQ83N/5BwyHwzQXXH8L4S2ScNU62TErPkCJhXOzfXX2lwAEuUmeTFgWWFiIMw+2utBZQo7UA6Y6Fg+eZ3w8XwwwtaK3szlGYtjL5DysvmvxL7kRWY19ZVsPYgMG3iIVlnXkKjSPV29Cabvb+blpLgNgsS0Dp9Sdt9lQoi7aUzIr2Hq6pxoB2XaNB3oQYnts9KGUuNoa/ZP4=
x-ms-exchange-antispam-messagedata: =?utf-8?B?MDZjMDVwWTg1N09jQTZDM2g2U0d6cEhOWkNPWXplWStTaEZjNkNvNU50Vmlm?=
 =?utf-8?B?eDdRL1YrNjU5VGtHbm55NkxlemFRV2szWWR4d3IvZWZvM25lN1Rxc1oyMDlD?=
 =?utf-8?B?ZkVKQzQ5M0Z3eVFQeW5FeG04dk5vbmh3dDJXZldaTDdsR1lZc1h3Z2xUNHpI?=
 =?utf-8?B?c3JqTEhVaTJzMDg2M05OZ3N3TURGVWVlU3RCOHpHTFh2cktWOXhPK3pxMHVG?=
 =?utf-8?B?ZUc5RHBjOFhjSDBGR0NnQkNxMXdPNVc0SkNydlg1dkU3b2xHMWFObldUMmk2?=
 =?utf-8?B?cC8rYlNRMFErTDh1TnBqdGxwK09wOTFVQlRyUVFEM21ma0RJTEIwY1MyKzhO?=
 =?utf-8?B?Njk5SWU5cUF0eWhkQnNjYVV2cy94YmZpWXIrN3dHdkY1NjBITzhGYXVTMDZx?=
 =?utf-8?B?SERYQlQ5VkhiK0RZRTdWNFhHZ0FTRDN5Z1VIRmk2aHJ6TW5qR29nalNzOXRh?=
 =?utf-8?B?VW54cmpaU1I1VnpDOXg2bzJFQmhIYXFmU1JtVDFQeExrSXZvNnM2bERYZ3Fw?=
 =?utf-8?B?L1Q2WW4rWm9FaHFiL0xFZHhFMWxRV1dqR0U0QlUwbFB5b2FnSytKZ3RDSERZ?=
 =?utf-8?B?SFgrc2trZWFJa3pzRjNPWHYyZ2Y4VlQxNDFQYkdDbmdWSUplSFlXeHhQOXJI?=
 =?utf-8?B?ZFNyTG12WmZGazhZS1RUczF4OHprS1JvSmYxbjUxVndLTmV3c01rWnhFSnVl?=
 =?utf-8?B?MUFqNk4vcm5MVVNESDk5aHYxZnBkTWJMZGMwQng5WXk4Wlg3ME9aN1k1dElK?=
 =?utf-8?B?b1F4ekZOdkFIYnRhZTVLTVgraTRqUlIzTWYyaXNQaHZ0TGZsWTBuc2VoM1JQ?=
 =?utf-8?B?VkROL1B1WU9lNEpqUFFyVlM1ejF3MW9POFBXc3RDZ3U2VjhvVzlxdXhhZElm?=
 =?utf-8?B?Qis4eGlmR3d3MWw1QlJuNllRR1ZFRmpmbGIyODZnd1hrNDdtT0FVSmM2M1g4?=
 =?utf-8?B?bVNwdFJ1aFhHdGx0cGxlRFNDNDRaY1paN0tjM1dJN3ZydXBpTUxZYlJHZjZR?=
 =?utf-8?B?ZGpQUUw0SlE4aGZxM1RPSUd0ZUJ3a1lVaHg4L2pRSWdKMlYvU3p2NkxGU3Q5?=
 =?utf-8?B?SHBwOFgvRU92QnJCam9lQTVCU1FSUlJBdHBvNEVGOXMxcitXRVdQYUN0cnht?=
 =?utf-8?B?RVdPN1RGN0NSUVBzMHk1d29qdmxYcFU4UHk5OUZpVC9KNVJleC9pUCtVM0xn?=
 =?utf-8?B?a1pFTDgvOUJnS2tUNStzRjVKMW8vMjRDQWprMG9DOFByWjFJME9EOHBVeW5i?=
 =?utf-8?B?Slc5WDNrY0VxQVpVT00zT3NuRUFBZXJ1dGJyc0lESjlIWGhqeVNLNmRnVlVu?=
 =?utf-8?B?S1pXWFFsYUlUOW8zRDdRTUFCN0RCS05UcWhXOUljT1dvTGE4K2NzK2k0MVdu?=
 =?utf-8?B?MHdTQ1FPQ0NkZU5JdVIyN3VWSWY5N1pyS1JXd1g3NktwRlE2QVo1V0dEQTFa?=
 =?utf-8?B?MVhwTW9FY1piM3IwZDdsTUx3bENtaWNCRFVqNXlYMm4yTkdvSmFBY2JNNy90?=
 =?utf-8?B?NWNXSHkxMjZiaHlXS0tQVmdIaWo0UXI3VTFRSGpDVi9WNTBzbUxnalFwTnZL?=
 =?utf-8?B?MzBzVXdDMzF5NmY0RXpJNld6ZUZ6djJPaXVNWDZwSk45LzI3NGpuOFFwQUpT?=
 =?utf-8?B?Sm5rR1JjR0pXMnFkbFcyRSs5SmVCWVFCaHJTWVpicUp5VWNSckNvaGllL2Y0?=
 =?utf-8?B?bnQydlVIM1N4T3FPeHpkYUVlWFlEOGtoUzdCcW5DelFIVE44c0xsOS85VUF4?=
 =?utf-8?Q?d0pwU3xlki/uExYlUA=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0fcc3f-552a-4750-5ded-08d8e464a490
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 08:06:58.1152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ogSCD0u2xOdloUJlUcMInrvSP63qNyxwutF6pmVXCCYYNBxp7YgNEsKm3fa5nC6ju3VHErljozgp0XwIXgiP4Qd7C5G/LqTuV8Mp0WXDrB+UV0x/khCuyTuTSjuN8oL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5666
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: OSiJBNWt0NWehZtES2qP4NjEx4520388AA=
Content-Type: multipart/mixed; boundary="x2sg7Iw36cfagVkjx3H2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615450027;
 bh=2wjFiu+k9VDJpswfVCXEEBLtmU1Lzh04eL89/PGdzBc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ig5dQ0Y/boVwBbhhEl+K4zesKJM18jGDqzA5c/+IIcUoG8gaAPr6jgnxW0jsvKyVs/U
 DN9/2Zc+qJM8ldXg3Wg0/UeU/XuDCOsLnTMeLE9w4VuB8+Ps94v20EAhlQhXPRTnwbD6b
 6BtkC/T6Pmq1Nly3i7JFFiNXbf4F2e3+iDI=

--x2sg7Iw36cfagVkjx3H2
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnIFttYWlsdG86Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5v
cmddIE9uIEJlaGFsZiBPZg0KPiBtYXNhc2hpLmt1ZG9AY3liZXJ0cnVzdC5jby5qcA0KPiBTZW50
OiBUaHVyc2RheSwgTWFyY2ggMTEsIDIwMjEgOToyMyBBTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmcNCj4gU3ViamVjdDogW2NpcC1kZXZdIENJUCBJUkMgd2Vla2x5IG1lZXRp
bmcgdG9kYXkNCj4gDQo+IEhpIGFsbCwNCj4gDQo+IEtpbmRseSBiZSByZW1pbmRlZCB0byBhdHRl
bmQgdGhlIHdlZWtseSBtZWV0aW5nIHRocm91Z2ggSVJDIHRvIGRpc2N1c3MgdGVjaG5pY2FsIHRv
cGljcyB3aXRoIENJUCBrZXJuZWwgdG9kYXkuDQoNClNvcnJ5LCBJIGNhbiBub3QgcGFydGljaXBh
dGUgdG9kYXkncyBJUkMgbWVldGluZyBmb3IgcGVyc29uYWwgcmVhc29uLg0KDQo+IA0KPiAqUGxl
YXNlIG5vdGUgdGhhdCB0aGUgSVJDIG1lZXRpbmcgd2FzIHJlc2NoZWR1bGVkIHRvIFVUQyAoR01U
KSAwOTowMCBzdGFydGluZyBmcm9tIHRoZSBmaXJzdCB3ZWVrIG9mIEFwci4gYWNjb3JkaW5nDQo+
IHRvIFRTQyBtZWV0aW5nKg0KPiBodHRwczovL3d3dy50aW1lYW5kZGF0ZS5jb20vd29ybGRjbG9j
ay9tZWV0aW5nZGV0YWlscy5odG1sP3llYXI9MjAyMSZtb250aD0zJmRheT0xMSZob3VyPTkmbWlu
PTAmc2VjPTAmcDE9MjI0JnAyPQ0KPiAxNzkmcDM9MTM2JnA0PTM3JnA1PTI0MSZwNj0yNDgNCj4g
DQo+IFVTV2VzdAlVU0Vhc3QJVUsJREUJVFcJSlANCj4gMDE6MDAJMDQ6MDAJOTowMAkxMDowMAkx
NzowMAkxODowMA0KPiANCj4gQ2hhbm5lbDoNCj4gKiBpcmM6Y2hhdC5mcmVlbm9kZS5uZXQ6NjY2
Ny9jaXANCj4gDQo+IExhc3QgbWVldGluZyBtaW51dGVzOg0KPiBodHRwczovL2lyY2xvZ3MuYmFz
ZXJvY2sub3JnL21lZXRpbmdzL2NpcC8yMDIxLzAzL2NpcC4yMDIxLTAzLTA0LTA5LjAwLmxvZy5o
dG1sDQo+IA0KPiAqIEFjdGlvbiBpdGVtDQo+ICAgMS4gQ29tYmluZSByb290IGZpbGVzeXN0ZW0g
d2l0aCBrc2VsZnRlc3QgYmluYXJ5IC0gaXdhbWF0c3UNCg0KTm8gdXBkYXRlLg0KDQo+ICAgMi4g
RG8gc29tZSBleHBlcmltZW50IHRvIGxvd2VyIGJ1cmRlbnMgb24gQ0kgLSBwYXRlcnNvbmMNCj4g
DQo+ICogS2VybmVsIG1haW50ZW5hbmNlIHVwZGF0ZXMNCg0KSSByZXZpZXdlZCA0LjQuMjYwLCA1
LjEwLjIxIGFuZCA1LjEwLjIyLg0KDQo+ICogS2VybmVsIHRlc3RpbmcNCj4gKiBDSVAgU2VjdXJp
dHkNCj4gKiBBT0INCj4gDQo+IFRoZSBtZWV0aW5nIHdpbGwgdGFrZSAzMCBtaW4sIGFsdGhvdWdo
IGl0IGNhbiBiZSBleHRlbmRlZCB0byBhbiBob3VyIGlmIGl0IG1ha2VzIHNlbnNlIGFuZCB0aG9z
ZSBpbnZvbHZlZCBpbiB0aGUgdG9waWNzDQo+IGNhbiBzdGF5LiBPdGhlcndpc2UsIHRoZSB0b3Bp
YyB3aWxsIGJlIHRha2VuIG9mZmxpbmUgb3IgaW4gdGhlIG5leHQgbWVldGluZy4NCj4gDQo+IEJl
c3QgcmVnYXJkcywNCg0KQmVzdCByZWdhcmRzLg0KICBOb2J1aGlybw0KDQo+IC0tDQo+IE0uIEt1
ZG8NCj4gQ3liZXJ0cnVzdCBKYXBhbiBDby4sIEx0ZC4NCg==

--x2sg7Iw36cfagVkjx3H2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6273): https://lists.cip-project.org/g/cip-dev/message=
/6273
Mute This Topic: https://lists.cip-project.org/mt/81242609/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--x2sg7Iw36cfagVkjx3H2--
