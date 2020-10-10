Return-Path: <SRS0=HQEV=DR=lists.cip-project.org=bounce+64572+5517+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AFCC43457
	for <cip-dev@archiver.kernel.org>; Sat, 10 Oct 2020 23:16:02 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0505E2078B
	for <cip-dev@archiver.kernel.org>; Sat, 10 Oct 2020 23:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bUhhepVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0505E2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5517+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 4W7MYY4521723x60OPH93kiS; Sat, 10 Oct 2020 16:15:57 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.7278.1602371748251561451
 for <cip-dev@lists.cip-project.org>;
 Sat, 10 Oct 2020 16:15:49 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 09ANFNLL025570; Sun, 11 Oct 2020 08:15:23 +0900
X-Iguazu-Qid: 34trJE3d6xoY1jDjIf
X-Iguazu-QSIG: v=2; s=0; t=1602371722; q=34trJE3d6xoY1jDjIf; m=cXJCxVN6d2hejtA6Ia6KwhzvBoQN6NDLi3JXRmQiyQk=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1512) id 09ANFJrO039341;
	Sun, 11 Oct 2020 08:15:21 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 09ANFJd2020178;
	Sun, 11 Oct 2020 08:15:19 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 09ANFIhv015738;
	Sun, 11 Oct 2020 08:15:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAxNlHzJxlWsmmFDk/ZS8M96XbExY7Wb72tPFA7pLByZDFIeUmzSWN7i6FA7T3jURfRwkkGQB0cakq+9XmoiRHKirHkimWu8yarnO4kvba7nN8VDp+7JRck/eehERzMOzpIrrLQq/KQXT5jddXljAwtJe55M7puzwbBdVhLFD1yDsFIfGa0liTfJq7q9tCIWd+GHE/17QRsMSCRAFvL0zJHH0c36k2xm+IVdIRpcwCueieEF8cjd29VHyMrIUZ+kvoWygoc7iFjXi2U2ZM0Ku2nBCF1kH+OBvz+id/KyQrXh5hwZF0kQB5j9ESp4BzuklJh5ntqzYRxPyErAYRjH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icCTf+YyJ8Kf4rvj5OVeyHHnGpmWTZP9F166ndti7jo=;
 b=i1QJHktwltrP/rkAsHk6ZGFf/1gHd1oXPZkvdMJjklBlWrz9gYSCK4tDQVV+wFUdTIDgcx32rRheOXQzWu2Qb2kBwYpuZ9R4tmMFp7XGSwJm+g9g8dcSzLuVXNDpMw8j6ocA/UQPFAJmgiYvD12ZKhTSXibX7xb9p50qy8afVGVHgfgnR69DVA1Y64CIIhono5YESW/8bLBf93aQt+qCdLZXz1YIt6xyB8O/k9SZkUEZlaFHaPSCC554BCo8/v0jo3/hdo+rtBPHnJab2mlSdhdo0VI4US7nPR4PpquQtPAPYfHMF/c0nkTzdWPVHGvAn/4/4cHpogKAay+2ly8HVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <wens@csie.org>, <masashi.kudo@cybertrust.co.jp>,
        <ben.hutchings@codethink.co.uk>, <Chris.Paterson2@renesas.com>,
        <SZ.Lin@moxa.com>
Subject: [cip-dev] Release v4.19.150-cip36 and v4.4.238-cip50
Thread-Topic: Release v4.19.150-cip36 and v4.4.238-cip50
Thread-Index: AdafWc5GA5+QuYxGRpq3IUf6U/DXNQ==
Date: Sat, 10 Oct 2020 23:15:15 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983CF3798AC042FF922F43392090@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41002fcc-7d7a-4ab2-3349-08d86d7258f6
x-ms-traffictypediagnostic: OSBPR01MB5237:
x-microsoft-antispam-prvs: <OSBPR01MB523763F4AD00794DCAA3356F92090@OSBPR01MB5237.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ESmvIAoHIdPa4/Asi2aU5ji7WChG7E+7MvQVTjxwePkLQsX5I2M0hkAGr6SYZ2dCko+fpPVL09UWhRG1zDMQwdBSW2HIzO/7yUQ5pD0CPRlNxKTux1XUcJoWne31Je4U/UXSoTHP7R23gm//nGqhpEXwFc0FkRBU0sOk/cZkZmJT0P6Sez+bI6LW+29oWCGZ5YRnaUHufPtvgWrFEZKjE/5Xzufsa2hhnHNzVhxNuPO7UBsC/O+bp4m9rT68/xrhAD62n9O5DckAcMA83z2ZSGfJVfQvGBUSLvDjcG5TCNs0DEzb5VCRlgj7ZANg1Zvogw4q8Y6cE2TBQEpgrPVEzKOmbRxYr3Uf8jkBNwFGFX/U1N5dsRpqMLB8gKPAB6qOOAi03Vx8knNWnsHf7lafVA==
x-ms-exchange-antispam-messagedata: XL0kf2meYVxgKQ1mrkohCkWyG8QApIRUqua+FBdt6YMUc1gRVMG2EasdAnbTYL4Ysto+heetNGGS+SbstCndc1ZzWR4jp0in/JItgCH57rcIIjCb/G0jWfOKD5AdTbk0xV9cfBBNAQO03bSOFIrAyWK5SeZOD05yjXa4QrTo4gPb6s/4FUaQc4HDR+KoM7Ayn6iNMGFDYxm98Y947+9ao53Upi/7/+3JsKqzaZMOJK8REO2v2o5LLaCPVrcRuUmYU4pD8dRB/Jc+fSgSGMOE29ZEfP1SHlHlzvgrGXIOJs8F90CO61Fny8x6xzQsBaN/ybWKe6sEleWSmMHKcmEPCj/wSXjNtiil2OYxTYq3+uPFNYophKdVTZKEQ6sm4PV8g711qBr8KGAB6YZsT/0aBhys4edWXrdJ4Edt6x2tbNoOWw7bP/a29Ul+vfQ1O0aUWErjz94IqBabJxw1rfQ2e/0I05bstqOv608aCDPXRPZxCBRjayRTGrM2CPrOwUMjV84hopB8DTdT/DTM2JjvvQFVQoc9xLjeUpRZMTkfyMN64a31Jqae2i5a3qDeFJpmlCwMpEODSVkNedsAlFw7jN0E4lEk8p1iUhTMKx9oTXV6F9yUSNyuZwcnWonuVsHfidR9UnMltgYQ5DnqHXYo4A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41002fcc-7d7a-4ab2-3349-08d86d7258f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2020 23:15:15.8205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6J+xTT34r/4dpnCBuolKhOgnkyaKLm0FllI1XhfN0UKvBsvvYS86aWollJ19+T3o/e9vjQGHn9eRj3N/g6szlKvomirkkfkGtettBz0HCt0GRqwsfbLRdnzN/sYIAXRy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5237
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3GkFgM3HhVeennRSM1uWPL7cx4520388AA=
Content-Type: multipart/mixed; boundary="sYozAy898Q3v3FAB4csj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602371757;
 bh=4kySK5Rw5pPXm6+wTey/1nyDSyxnBzz2GnoAM1G2f+E=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=bUhhepVaaGWHaa/TeVzp4VOhQjZD5IFCi5qs/APgXdoxnO3gfSytCi4v1uyGrAXOhG9
 rMe4GO84ndNOA3+xvec+LsvlSHzfpNeOF6Dg2Yrfzks1QLqJvr1p9/XyO3fepPGaLTnKT
 u4qHFHUgQvM0XkE9yO6e3EqHJIKJIRY0u7A=

--sYozAy898Q3v3FAB4csj
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjE1
MC1jaXAzNiBhbmQgdjQuNC4yMzgtY2lwNTAuDQpUaGUgbGludXgtNC4xOS55LWNpcCB0cmVlIGhh
cyBiZWVuIHVwZGF0ZWQgYmFzZSB2ZXJzaW9uIHRvIHY0LjE5LjE1MCwgYW5kIHRoZQ0KbGludXgt
NC40LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBiYXNlIHZlcnNpb24gdG8gdjQuNC4yMzgg
d2l0aCBhdWRpbyBzdXBwb3J0DQpmb3IgaXdnMjFkLXE3IGJvYXJkLg0KQW5kIHRoaXMgcmVsZWFz
ZSBpbmNsdWRlcyBhIHBhdGNoIGZvciByYXZiICg3Nzk3MmI1NWZiOWQ6IFJldmVydCAicmF2Yjog
Rml4ZWQgdG8NCmJlIGFibGUgdG8gdW5sb2FkIG1vZHVsZXMiICkuIFRoaXMgZml4ZWQgdGhlIGV0
aGVybmV0IGlzc3VlIG9mIFJlbmVzYXMNClNvQ3MgdGVtcG9yYXJpbHkuDQoNCllvdSBjYW4gZ2V0
IHRoaXMgcmVsZWFzZSB2aWEgdGhlIGdpdCB0cmVlIGF0Og0KDQogIHY0LjE5LjE1MC1jaXAzNjoN
CiAgICByZXBvc2l0b3J5Og0KICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvY2lwL2xpbnV4LWNpcC5naXQNCiAgICBicmFuY2g6DQogICAgICBsaW51
eC00LjE5LnktY2lwDQogICAgY29tbWl0IGhhc2g6DQogICAgICA5NDZjZDZjODM0NjYxZmE5N2M4
ZGM5MTRjOTVmYzhhOTBhMTExNjc2DQogICAgYWRkZWQgY29tbWl0czoNCiAgICAgIENJUDogQnVt
cCB2ZXJzaW9uIHN1ZmZpeCB0byAtY2lwMzYgYWZ0ZXIgbWVyZ2UgZnJvbSBzdGFibGUgd2l0aCBy
YXZiIGZpeA0KICAgICAgUmV2ZXJ0ICJyYXZiOiBGaXhlZCB0byBiZSBhYmxlIHRvIHVubG9hZCBt
b2R1bGVzIg0KDQogIHY0LjQuMjM4LWNpcDUwOg0KICAgIHJlcG9zaXRvcnk6DQogICAgICBodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jaXAvbGludXgtY2lw
LmdpdA0KICAgIGJyYW5jaDoNCiAgICAgIGxpbnV4LTQuNC55LWNpcA0KICAgIGNvbW1pdCBoYXNo
Og0KICAgICAgZTIxZjZhMzEyOGJlYjczMTQ0OTAzMGQ3NjI0OWRiNjBkMzgwYjhkZA0KICAgIGFk
ZGVkIGNvbW1pdHM6DQogICAgICBDSVA6IEJ1bXAgdmVyc2lvbiBzdWZmaXggdG8gLWNpcDUwIGFm
dGVyIG1lcmdlIGZyb20gc3RhYmxlIHdpdGggcmF2YiBmaXgNCiAgICAgIFJldmVydCAicmF2Yjog
Rml4ZWQgdG8gYmUgYWJsZSB0byB1bmxvYWQgbW9kdWxlcyINCiAgICAgIEFSTTogZHRzOiByOGE3
NzQyLWl3ZzIxZC1xNzogU291bmQgRE1BIHN1cHBvcnQgdmlhIERWQyBvbiBEVFMNCiAgICAgIEFS
TTogZHRzOiByOGE3NzQyLWl3ZzIxZC1xNzogRW5hYmxlIFNHVEw1MDAwIGF1ZGlvIGNvZGVjDQog
ICAgICBBUk06IGR0czogcjhhNzc0MjogQWRkIGF1ZGlvIHN1cHBvcnQNCiAgICAgIGR0LWJpbmRp
bmdzOiBBU29DOiByZW5lc2FzLHJzbmQ6IEFkZCByOGE3NzQyIHN1cHBvcnQNCg0KQmVzdCByZWdh
cmRzLA0KICAgTm9idWhpcm8NCg==

--sYozAy898Q3v3FAB4csj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5517): https://lists.cip-project.org/g/cip-dev/message=
/5517
Mute This Topic: https://lists.cip-project.org/mt/77432774/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--sYozAy898Q3v3FAB4csj--
