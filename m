Return-Path: <SRS0=DFcd=ET=lists.cip-project.org=bounce+64572+5798+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3243C4742C
	for <cip-dev@archiver.kernel.org>; Fri, 13 Nov 2020 10:46:10 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99C120678
	for <cip-dev@archiver.kernel.org>; Fri, 13 Nov 2020 10:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Eko8lR1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99C120678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5798+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id O1hSYY4521723xLjF161UuDm; Fri, 13 Nov 2020 02:46:09 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.2601.1605264367264770546
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Nov 2020 02:46:08 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 0ADAk5Er008354; Fri, 13 Nov 2020 19:46:05 +0900
X-Iguazu-Qid: 34treOZZE5pUjeT9Sb
X-Iguazu-QSIG: v=2; s=0; t=1605264364; q=34treOZZE5pUjeT9Sb; m=5PSYYM9tDEX6Kh5BPVNdwZkXJlKhXgeKYTD8tJLfZQA=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1512) id 0ADAk4DX035839;
	Fri, 13 Nov 2020 19:46:04 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0ADAk4eF023709
	for <cip-dev@lists.cip-project.org>; Fri, 13 Nov 2020 19:46:04 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0ADAk3Bj024790
	for <cip-dev@lists.cip-project.org>; Fri, 13 Nov 2020 19:46:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na3tcR3U840PqgHWg3IlPX4EsJWyJhNhKGoTXO1uuQekbrAEtUwbgAI7lFpYZ4KXDbUp2SlXjq1ZeHXkCCWkzTVPH38oJTDI1gt6ZTkOHikOmqjUWcyJupKvr7ODJNh7/st4n/rWocYUBh7PONQrGHQGZ2Qgr6OnNEO3QKQ5Q1SPVgwb4UeyTT61MhgB8OULAcYAy8c6PcZpCx6L5kNkEoHnGGwIFLqPtoKWb+0bvTuDY+LTf5TE5EVGz8zYWJxGCx8x1uajKvhn8zI/3ZQxOF6tbUg1Vv04RCw3MEML87TmnP85BlFaLfJ6mwlVJxKg9s7siAo3CJz/xraeeMzmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtsHbkWa6PqV/fscDxioOuyKWYL0I53gBHLWULbxDUw=;
 b=f6i2kpG8OmuBVrWMEW2Faru5gGmhgQPY+u9C1cWxOJXmlWe966hVCkK4Jd2awtgTm4A1VEOmLzPZDxPQbtJpj/eA9AdxEwx35kCRgmeFocu6M6O4IUMo3lbLbDmDvnCs1Sw9EUByO8IeR/uEwn6GkZFNQ4YHz6bJXXt69h9vd+s9E2vxDJ/tQLbSrO2tqYe3iRid2hfxNAOAl+8TJGuLgPwISVquKGCa79Fv0vTAq69IQJ7RaaMWeOcUovs7qRzelGwiRLdkJuwhMeKIyIUNyemro7Z6ZaKQcOZ70r2z49W41kO3mM9S64nss9MKCHSocBf+OLJcK7kcs3JagWf57Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Leaving Codethink and CIP
Thread-Topic: [cip-dev] Leaving Codethink and CIP
Thread-Index: AQHWrK7pe6Fd/JIevUSURGP3w2BCnamtz3nA
Date: Fri, 13 Nov 2020 10:46:02 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983409F3B27EEB49D97425B92E60@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <35ba5a3c63dd41c15f1cf63e99ba01e99316bce4.camel@codethink.co.uk>
In-Reply-To: <35ba5a3c63dd41c15f1cf63e99ba01e99316bce4.camel@codethink.co.uk>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0d92bb5-6b73-41ed-b013-08d887c150c1
x-ms-traffictypediagnostic: OS0PR01MB5603:
x-microsoft-antispam-prvs: <OS0PR01MB560371C67CEE8A044DB9038692E60@OS0PR01MB5603.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bT4NJZhobviesm/PFtjVhLkn230NRUVmmdWr0I1RA+Yw8wMCz4zvDqaGtzRhrRJ1YVTh0ZWHjqM+zcQ33axs4sfQCRHdhtLHWRWdwW8l4zF2SuMyMoBcX4WC0/lgOpjxwRvFgqcDliBtPVI1NWa2ddBBFR8HrD0b5yG8gAGKevLyubch91tXng/805jpcwO6/GcAGikctd4BD9EXeE55Bv6rGAo4pZg6MKFKN3fGho2QEadXERtANORFjnsZRrRSXtj7wNSKHoLDpr18IXKzmv4NS95MXPYkXC4U5SzlbphaVO6cDvZpqyWVVrGj9FrH6PhRjA9knocBiss7slramQ==
x-ms-exchange-antispam-messagedata: RSexGKzQKZY67l7y6PQ1lV4rNBeMJlDtv86keJxw0Gj1wlN8X3YDq0o8ISgB5rJ/y7WD76msxpcl3NQIL+PX5oJCO6+uYEDZS917EZRpROopzfNkW1RMlQB6rcVjai7IuGGk1cWS+CGlkcq05Mf+buBXYz/24aqpfP6q4TaQUlD9xTbzpQmRjjc66QcglmAzzqv9tdQ4JJ8ZViBNYuGWL8rkRsQYBxhjWOwAEUxCBPTOWyXQoP7PcYJjX5AQlZ+3d1GDAI1uuoXXXq4fqUPrt6P0kSYrdtheTwI3t+oxoQdgCRZl98CJQIH52s3dxBEHRy+kYWtj7KTo4GG8abUSRG48I7Ximy9baOrWnOEzFM0Rno5KluEfkSDp/K+CDu7aff/YP8PFiFITOv+sfBU2tsEOHXGNn27bbaf1rxhbBczl+UgS92WwvyMeW40PnSQhDRoM+RNebp8X5niZ6HbCCctor0M5I78X53jq1fXNh+HoZ50unV0wYzMPkfYWG89c0AJwIyZp/d08UuiwndKql1JJ8EAp6j+leFsr73YhBgImqqvhPOewfSMrpNu8AmXAKJuTCZ2bP2V9+0zsF0EWqRaIntCq5MsSW6eOiIFoD0QgcfrHs3jDYyG87Tb0/cyITF/LF0DMJ2+t4FEepQ/CqWEN9PaiTLIPKOqIqW/SnZfKZxrkmSbxR+t6C3KmlNhN06EWC50JAgVSSkv3GQTZitP7d2iUjxtvp7gA+5uqJProxxKy4epUPglHkqVypVoywItuJPjgINfHCYIPsDBHrF6ukACW4xaW9JP7RlFxVjIUo94Vh+Z6LPp9EAqpc1OCGMpD9etrp/pakKP0wfQ+zZhpcRH94+nnZcP7APngPHZvNcHhBlakjVjcXPhwYoNXXzELWaSS6+1G03PtE+wVlQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d92bb5-6b73-41ed-b013-08d887c150c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 10:46:02.5764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6Ry3JLtQ+/Er/9p8Xzj9dNcC45mWbC1b5QG07kW2S9unk4vrdESbkpIOFn3ndM3Q8KxiCtTzsYInIr6C43kSQjbthR90TxByO5lieaz2b9kRulbZLhKOPLcrSsO7grN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5603
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XjECQ612DaEeJvhGjjnxYUgVx4520388AA=
Content-Type: multipart/mixed; boundary="GI9AbkAD3L8PH26bbCkC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605264369;
 bh=+SEAYkOXlENJSmCCgYYe/X+urEFcedoseaQiShMVvbM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Eko8lR1lESBLdVDuvRpBoh0BgxXdgEsy5NVVAfwlQUIhjE91QVPwnxuANeudk8cPODR
 yahGXLM0gd+WFEynkLrhrpKnclKte2MLCcvT34gzZTAxY6aBjfhVFxtRL+cfbJvRZkLfp
 9GSUJTJax+ZmhaTvJtsmADjqSsSi208VLdg=

--GI9AbkAD3L8PH26bbCkC
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIEJlbiBIdXRjaGluZ3MNCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDI4
LCAyMDIwIDc6MTcgQU0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1
YmplY3Q6IFtjaXAtZGV2XSBMZWF2aW5nIENvZGV0aGluayBhbmQgQ0lQDQo+IA0KPiBJIHdpbGwg
YmUgbGVhdmluZyBDb2RldGhpbmsgbmV4dCBtb250aCwgYW5kIHdpbGwgbm8gbG9uZ2VyIGJlIHdv
cmtpbmcNCj4gZGlyZWN0bHkgb24gQ0lQLiAgKFdpdGggbXkgRGViaWFuIGhhdCBvbiwgSSBtYXkg
c3RpbGwgc3VibWl0IG1lcmdlDQo+IHJlcXVlc3RzIHRvIHRoZSBjaXAta2VybmVsLXNlYyByZXBv
c2l0b3J5LikgIE15IGxhc3Qgd29ya2luZyBkYXkgaGVyZQ0KPiB3aWxsIGJlIDExIE5vdmVtYmVy
Lg0KPiANCj4gSSB3YW50IHRvIHRoYW5rIGV2ZXJ5b25lIHdobydzIHdvcmtlZCB0byBtYWtlIHN1
cGVyLWxvbmctdGVybSBMaW51eA0KPiBrZXJuZWwgbWFpbnRlbmFuY2UgcG9zc2libGUuICBDSVAg
aGFzIGEgZ3JlYXQga2VybmVsIHRlYW0gbm93IGFuZCBJJ20NCj4gY29uZmlkZW50IHRoYXQgeW91
J2xsIGNhcnJ5IG9uIGRvaW5nIGEgZmluZSBqb2Igd2l0aG91dCBtZS4NCg0KSSBhcHByZWNpYXRl
IHlvdXIgbGV0dGluZyBtZSBrbm93IGFib3V0IHlvdXIgcmVzaWduYXRpb24gZnJvbSBDb2RldGhp
bmsuDQpJJ20gc28gZ3JhdGVmdWwgZm9yIHlvdXIgc3VwcG9ydCBhbmQgYWR2aWNlLg0KDQpJIGJl
bGlldmUgd2Ugd2lsbCBtZWV0IGFnYWluIGF0IHRoZSBjb25mZXJlbmNlIHNvb24uDQpBbmQgd2lz
aCB5b3UgYSBoYXBweSBuZXcgam9iLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=

--GI9AbkAD3L8PH26bbCkC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5798): https://lists.cip-project.org/g/cip-dev/message=
/5798
Mute This Topic: https://lists.cip-project.org/mt/77850039/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--GI9AbkAD3L8PH26bbCkC--
