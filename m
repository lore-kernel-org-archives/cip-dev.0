Return-Path: <SRS0=74x+=E7=lists.cip-project.org=bounce+64572+5869+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B00FC5519F
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 06:49:50 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81327206E0
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 06:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="fcUN+KXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81327206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5869+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zkA4YY4521723xF0bjkEo8xG; Tue, 24 Nov 2020 22:49:48 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web08.3429.1606286987918504825
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 22:49:48 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 0AP6njPe024875; Wed, 25 Nov 2020 15:49:46 +0900
X-Iguazu-Qid: 2wHH70gJgfOO7gOuTT
X-Iguazu-QSIG: v=2; s=0; t=1606286985; q=2wHH70gJgfOO7gOuTT; m=7Y9Mb0l4XfWAVmS9v0n/CTr7FnLzq2nEnvnONUytk50=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1111) id 0AP6njJ2002771;
	Wed, 25 Nov 2020 15:49:45 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0AP6nisZ029671
	for <cip-dev@lists.cip-project.org>; Wed, 25 Nov 2020 15:49:44 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 0AP6niGq022030
	for <cip-dev@lists.cip-project.org>; Wed, 25 Nov 2020 15:49:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjjW0eio8cW67pmoKmU3MBwVqW8tRftKnD9ZI6KMXnqOpq/Z1fJVVSBXh25Y2TzRUgiGE2kgCBVdXYBvT6DiowO4vwv1l95ehIC19To9jwWAFMWJkyoZQEDRaAw7zvDywFhOCS+CTP4NRzPsoY4/yz2oYX/Gv0FWPNqRP6iqK6iF3HcTZivqRX7nTTgS6JS7F7X2uVOnu8E69HwdpFxdutndvsHICVwWP6aap+o+X+tXj4so9LJVLpgBB4b2UpSGHPr8QtkgnaUNkIp0kS9QNjNzCDpQwN806k5RLryKnkBsD1AeMO/s4QkpJkcn/G5+F9nRyO8n4eeJb7RMfFoJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgsTQgOJ9nYXCAgGTTQ49IvJBHDu/9ujHoxuZNfHpBo=;
 b=YZM0/FrNwjAseBTN/upC9d8UhcHxi35CaYpoLE/KqNxYJdNzxcFyiaxcemrT7lk39MMKKaIcWjAHnktI5OBL8WaT+IwHiwa15RPpJ5BKjn6ZgFSu82uPtKjfttEyF2s14Jr29HpiiVPV3y0rDxy/H/PJPiqzuVblyfKEtD2AqsXwgljGW3Sns7G3xF7A0NpHiIY3xdbYyJVlzl4uyxBIitzOBKHM12EGo+Wjv6+DqGgwUtw0aRPbDfX1MBy0gpoGZoeJJGrE5+LRr44RJlAuZ2I5rO05FCcg9514TKQMBfIefGVf8v+M6eNZJ3wPfEo04S8/gWsTvx76soDjFVODwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Joining CIP from Codethink
Thread-Topic: [cip-dev] Joining CIP from Codethink
Thread-Index: AQHWvCB7uICtVhi+HECct+B/1oZiEanYdb2w
Date: Wed, 25 Nov 2020 06:49:43 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983DF238FC07EBDF1025C5C92FA0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <9bd054d9-3b0e-d339-2d3f-7471ebc5421d@codethink.co.uk>
In-Reply-To: <9bd054d9-3b0e-d339-2d3f-7471ebc5421d@codethink.co.uk>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 123e111c-f443-4095-6dfe-08d8910e4a45
x-ms-traffictypediagnostic: OSBPR01MB2870:
x-microsoft-antispam-prvs: <OSBPR01MB28700B033DDD096056A1241292FA0@OSBPR01MB2870.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Cz0BSR+xNbso+BRMf6AabokT5nQ7JBIGwQpJGo8iSVnjVkcczqhVYX0a1LWdMpJ+g1J2yC7Jsb2UeZd2GjJApfCn7xq1MSgw5MxTN/OrC3cIDTuZhz955cJsev3RSifIdVo3svWb7Tw+K3Kx4rB4VZX45uwzP6ZqUfAN7Z7zG/RS5grYZ32Euu7LH7ogEI2QQAzTr8snsSSpvqlGsVTzk7kj7u3vnporMPq++2NQ8ngzkrORlBMX1AJC8JNf1ZxQBIrMcZ4jcwPlmmAzm+G7Dgzo6Gb2EPcqBp7Z/w2c8qYEp3YJXhrPSWjlNe2kSLj1
x-ms-exchange-antispam-messagedata: =?utf-8?B?bjd4bmpXTFBVa0ZTWFd0Vk5ydkd6Sk41UHhBeXJUaCtkQ04vSGZoaENBYitQ?=
 =?utf-8?B?VkJXM3pFNFlEZTA1aWl3WjlROUJndlNmdFFhVFlEQzU4NlJtVTFHc2ozcTJz?=
 =?utf-8?B?cGRKTU03RTUvR1FKUko0WEkxUHhyM2dvYUhIa0trZ2c3US9ablhTQ3JWRWRa?=
 =?utf-8?B?b0I4MnlSb1VPbVgwYXBPNzJpRWQwckttMDF3WmJSWlFoRU0vYkhiUXRCOTVr?=
 =?utf-8?B?UDQ4MkVOMlhXSEI1RmQvcE16SVR2V1V6Q0ljNytIZ0psZVNmQmxYeGxXbTRu?=
 =?utf-8?B?UHF2ZVYxZXllTWlHeG9uRk9reWNLeDZSajI5RVFRMmkzV2Y3SjRiaXZLdGxV?=
 =?utf-8?B?VHFaU2JJZFQzWGtUMC9HYzh6cXhoblJlcDh4V2tNbFdpM0VkNm5JM1Z2M3k0?=
 =?utf-8?B?QjY1d0gyVUZWYk9oZTF3SzNLZEJkbi83cTh4Rlg1MGJyd0ZGQmJINzM4MmE3?=
 =?utf-8?B?UzZ6RGxDOHRCNlNLd1Q4YUpIUkRsWWwxbXFDVjQ5Q2NPcjZiUlVkY2NoQzM3?=
 =?utf-8?B?WFkrK0NlRXR0d2huaVk3d3p3OWo2a2dOSTFyQXFUUlYzUmxRR215a1F3VmRh?=
 =?utf-8?B?d1lFREZNS09ZV293NkNhVGlvVGxITmJjV0N1RzBINlBNZGZ3c1FRWkZCa0VP?=
 =?utf-8?B?Zk4yc3I4ak51NlArK0l4UHIvRURSYWlhYnFRVDBMcmZOVGRqRTVuMS9lZDZO?=
 =?utf-8?B?czlseUxDTTIyUkpscHJwWC9heENpSVk5UzRGZDNaUFN4OWNXT1BiVzExcWtM?=
 =?utf-8?B?bVdISitZaEtJNHlzOG03R1FRRzVXcXVFTDZwV3BSZkgwVUFZY3hablZ2cUJh?=
 =?utf-8?B?UkZRN1dHV2pwcjN3QU13M0xQSzYrQ1g3aForMFg4Um1nOTlvenk3ZDVrd0VL?=
 =?utf-8?B?RTlIdHdPNld1WWhzd3JpZmtpN1FLK2lWaFBVMHNwSnhLL3Y4ZUF1RmFSQk5L?=
 =?utf-8?B?K29NVnRXNGRCajRJMStiZlJCWWo5SVllOTh2em5sRWFnMEVQMk5KZjM5dFlF?=
 =?utf-8?B?akp6a05OQzdIckQ3ZEw2TDlGTmxadEE1ZWR4Znl1WmZvcmRET2NJczB3ckxR?=
 =?utf-8?B?QjFyOGtHR29FMU9iQWkwcjZYakxBSkwzOGhXY1YzOEx4THZab0Vnb1pPQWV3?=
 =?utf-8?B?NE1wR21rdXV3MGF0azlvNktTRDlPMlZGWnNXNWFhY1VLek9RTHpBWk1rN3Zr?=
 =?utf-8?B?ZG9oVGJXRE1DZjhoTGNoMlBuZjQvUGlYZStoQThsRFhDcFZONEZ6ZUl5UTlM?=
 =?utf-8?B?UlEzeU1xQXBGTXk2UEl3bS94bmJUUlhVamZDNnBSTStnclU2cXJRelVDaFZ1?=
 =?utf-8?Q?+hCVqonyTYRTQ=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123e111c-f443-4095-6dfe-08d8910e4a45
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 06:49:43.3779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /sj02I1HhzacKSZbHVlySpxYjtrRjeWCHHTR1Sv4e+BQlh8uY0I1cRSuaB7nFXaPsPBHBdad9cfQVJENnZZro0hYud2Fmhasx4qtQY2bCi673UNM4Hbbt/hOgLLHjyIT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2870
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uPKDl4Ol5u1kiZFjAEs94NvQx4520388AA=
Content-Type: multipart/mixed; boundary="qeNAWxDYaSoBjSY0zIgB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606286988;
 bh=/4pQ+Yr8yxPSUvwsjOuh3YGac6JZT9i5c2nyFOZA41A=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=fcUN+KXJ+BPdYkxtdZcYytuyFlCDKrLbbshCCWWrHYmnnRV6C0KuADfb1mf9013E4E6
 TXCUoEuNs1RCA05s4ru7h4DVlh31RAfhdabK5yVuROK4G7HCurBFz7u7S0VgnUvxaCOHY
 GDTIiSoUN51xNjlGfVja6HEWIDHYCNY9Vqk=

--qeNAWxDYaSoBjSY0zIgB
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgU3VkaXAsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0
Lm9yZ10gT24gQmVoYWxmIE9mIFN1ZGlwIE11a2hlcmplZQ0KPiBTZW50OiBNb25kYXksIE5vdmVt
YmVyIDE2LCAyMDIwIDEwOjU3IFBNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9y
Zw0KPiBTdWJqZWN0OiBbY2lwLWRldl0gSm9pbmluZyBDSVAgZnJvbSBDb2RldGhpbmsNCj4gDQo+
IEhpIEFsbCwNCj4gDQo+IEkgYW0gc3RhcnRpbmcgd2l0aCBDSVAgYW5kIHdpbGwgYmUgdHJ5aW5n
IHRvIGRvIHdoYXQgQmVuIHVzZWQgdG8gZG8uDQo+IFRob3VnaCBtYW55IG9mIG15IGNvbGxlYWd1
ZXMgYW5kIGV4LWNvbGxlYWd1ZXMgaGF2ZSB3b3JrZWQgd2l0aCBDSVAsDQo+IHRoaXMgd2lsbCBi
ZSBteSBmaXJzdCB0aW1lIGRpcmVjdGx5IHdvcmtpbmcgd2l0aCBDSVAgYW5kIGV4Y2l0ZWQgd2l0
aA0KPiB0aGUgY2hhbmNlIHRvIGNvbnRyaWJ1dGUgdG8gdGhlIHN1cGVyLWxvbmctdGVybSBMaW51
eCBLZXJuZWwuDQoNCldlbGNvbWUhIQ0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=

--qeNAWxDYaSoBjSY0zIgB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5869): https://lists.cip-project.org/g/cip-dev/message=
/5869
Mute This Topic: https://lists.cip-project.org/mt/78291887/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--qeNAWxDYaSoBjSY0zIgB--
