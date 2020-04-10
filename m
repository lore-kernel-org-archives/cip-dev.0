Return-Path: <SRS0=U/Bs=52=lists.cip-project.org=bounce+64572+4577+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF72C2D0EC
	for <cip-dev@archiver.kernel.org>; Fri, 10 Apr 2020 23:22:54 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F443207FF
	for <cip-dev@archiver.kernel.org>; Fri, 10 Apr 2020 23:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="vY2eGUXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F443207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4577+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2OCDYY4521723xHVdbHVQH9h; Fri, 10 Apr 2020 16:22:52 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.258.1586560971180436790
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Apr 2020 16:22:52 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 03ANMLZP027284; Sat, 11 Apr 2020 08:22:22 +0900
X-Iguazu-Qid: 2wHHmtTgl9Lz3UEBGa
X-Iguazu-QSIG: v=2; s=0; t=1586560941; q=2wHHmtTgl9Lz3UEBGa; m=0yQsvzRbqr4AO+5mVFdrve7ySmcup9fSbYLlGgr1CGM=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1112) id 03ANMIOo019237;
	Sat, 11 Apr 2020 08:22:19 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 03ANMIbZ017552;
	Sat, 11 Apr 2020 08:22:18 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 03ANMHdC026833;
	Sat, 11 Apr 2020 08:22:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YP0lx6oGZm6SpuTQQ1687ccUzYsIBNPbfUVlT9ymsiWKx5Tmpvd88Glf2Cc/Mcm6J5d+TThxX5ZOTN3bEn3U7xDJ7FZtImZ7mnPRvjm9M569iN13Edi+sSHuaTzDXkuBAh2DsuoyArUVmOMxHpEP0R9l+sIhpul7cAjPi6tPjLHnlQmgh0NZ+oFLppldIyrar+1ZRiLT8RnFxXGD21ANbA8/3wYR32BE9JH3Zu7lESfbOZdpCa/TuHQb830i/h4+g4TlY1swjJMo/J3dEnpOgX6sH9Mp29dM/eltwVrHNQ/jp1dsYMhZ8BW3tViqgweq9l5xqYvzrGd7e3r88+xymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2P9dK5O1knIw9DrrcwJBk3MQSIPglyIM/M9CLW1F5l8=;
 b=juiOJDSUZoVm+be0pX1Hn8VPX/a7okDnIkOC7zzh8+P0JiX1IQvO69pKB944Z4MRnoVTVX4c6BvunSr3I8j5Sx3pjC9mUoiIfbqHCiBAPjTjA3wLBzu16aZ++kTkgnY289lkb7eEZTGrTSbDji6JSZoRPPoSpeR34mVY3XCgphmwNAyWb+a7I8cZ4Fs8RaG3MxpitYyOYEv1yt8AbNmfT4mX7iKukVJ9Su2b2VjMlry8pKCAsKRNO/vYLxwakEbPf+ItYF26FWwNGzhqmGLU2RmI+QcH/7VgDni667TD3L6190/p80FIhUuqCtdNIRnqS5qMGps5u8yMNQcswUznBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <Chris.Paterson2@renesas.com>,
        <ben.hutchings@codethink.co.uk>, <SZ.Lin@moxa.com>, <wens@csie.org>,
        <masashi.kudo@cybertrust.co.jp>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.114-cip24 and v4.4.218-cip44
Thread-Topic: [ANNOUNCE] Release v4.19.114-cip24 and v4.4.218-cip44
Thread-Index: AdYPjlB3yj7O7RU9S4a5O/KeM7QHFQ==
Date: Fri, 10 Apr 2020 23:22:13 +0000
X-TSB-HOP: ON
Message-ID: <OSAPR01MB3667C864CD25722466FDD7BA92DE0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [209.137.146.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 849c0b4a-48bf-49f2-b522-08d7dda600c6
x-ms-traffictypediagnostic: OSAPR01MB2596:
x-microsoft-antispam-prvs: <OSAPR01MB25960EC9AFF449994DCC819D92DE0@OSAPR01MB2596.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FArPd97GW8Alcdn5r7tSXM7KaUKtysbR5+2ASrLns4qs1QZNrwcA6zNr2xhE7vzHilvKYN4n4xWP0viX/nqwnAwYjEPMjrLV5AnNi6UmsVYOZiavi73GDloujwe9s0PQnBXSBYesiyDHW2RgduG+IVdNQWClFru4F2BKxYdUVqZbDD3Wd8jZ9ib802BgPa3AvKqLHQqodLCnRhQr297T3D3rGZI7mUidDGNJoXabSPpZZKP6oVobX2Gtwe0+rkUEjA9B+jdKglwQKW45SYOf8jrVow5rqx4EXwCkzYm53I+xHHwKhSiArTA6QD55FQABrFQAh5Zcvr9mOPMhsSDVffnu/TWiS093AHdglhiT4NG8kow5hCM8W3OwWhou8gYAkaqJT9vOR96o5EKo4IBMkpy4m6nKqhbO2PNQaS4psOwFtbNqUaTQrAvgE6OlOifXA0Iawwomc3ijCyer1owxFJO7RKIfjABuazavS8HmgVRXgZPRhzyMeSCnKX9tyzlAcl2ylsw/QsFE2nSmdQELaw==
x-ms-exchange-antispam-messagedata: SxmeeynBKdtfbFwTLJtI34Yuv1gQmBPTWJRoGeUFdzW3O1lGpmDpR/FmFgy02MVfzsrTna+RzsF1OzDKOjHOGiTUejEykvAoWFBzLN0/oPBSZqHBGVuHyqlxQqSUAmFjhIjdQb6KGrvJRptLlQ8TLQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 849c0b4a-48bf-49f2-b522-08d7dda600c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 23:22:14.2157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmApryG+VXE54HWhdnKDtHYZ/YQL589hHZxrZtHY1kwW7U8rvx2f68Cj7JZ25hYd9LAtDd2OiL1h/mVECz5sncHucw9buk5TM7QnzqFWVFOlQSaDz2Tpk+/s1ALDPm5K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2596
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zsxNEcbAcIBpb9Nm30zpmxylx4520388AA=
Content-Type: multipart/mixed; boundary="be8JNrGVK5UviHpOcf68"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586560972;
 bh=qHOJA2sT9EbZduc4YqVlgAdCd2CTpTXScI2/zaBgpEU=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=vY2eGUXWJ8rd58V8UNcWDPdSJazWtGcMUvVKo585amJLOq2oqfBK8MY0u5VmTA0vT0p
 7Ml9QR9ip0C8wHYlm2TMuwuyn7A/yv+9mxe21N9gQ+/0w4AUBOsc0EGl2CP0rrW+K/54T
 QB7dFs5ELvsFy846Vt5tdU4O8rEniDXXNWs=

--be8JNrGVK5UviHpOcf68
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpDSVAga2VybmVsIHRlYW0gaGFzIHJlbGVhc2VkIExpbnV4IGtlcm5lbCB2NC4x
OS4xMTQtY2lwMjQgYW5kIHY0LjQuMjE4LWNpcDQ0Lg0KVGhlIGxpbnV4LTQuMTkueS1jaXAgdHJl
ZSBoYXMgYmVlbiB1cGRhdGVkIGJhc2UgdmVyc2lvbiBmcm9tIHY0LjE5LjExMyB0byB2NC4xOS4x
MTQsDQphbmQgbGludXgtNC40LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBiYXNlIHZlcnNp
b24gZnJvbSB2NC40LjIxNiB0byB2NC40LjIxOC4NCg0KWW91IGNhbiBnZXQgdGhpcyByZWxlYXNl
IHZpYSB0aGUgZ2l0IHRyZWUgYXQ6DQoNCiAgdjQuMTkuMTE0LWNpcDI0Og0KICAgIHJlcG9zaXRv
cnk6DQogICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9jaXAvbGludXgtY2lwLmdpdA0KICAgIGJyYW5jaDoNCiAgICAgIGxpbnV4LTQuMTkueS1jaXAN
CiAgICBjb21taXQgaGFzaDoNCiAgICAgIDczODllOWUxZDhmYzFlMGE0NTZhNWNmOGZlMzM2Yzc4
Mzg4ZDEwOGMNCiAgICBhZGRlZCBjb21taXRzOg0KICAgICAgQ0lQOiBCdW1wIHZlcnNpb24gc3Vm
Zml4IHRvIC1jaXAyNCBhZnRlciBtZXJnZSBmcm9tIHN0YWJsZQ0KDQogIHY0LjQuMjE4LWNpcDQ0
Og0KICAgIHJlcG9zaXRvcnk6DQogICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC9jaXAvbGludXgtY2lwLmdpdA0KICAgIGJyYW5jaDoNCiAgICAgIGxp
bnV4LTQuNC55LWNpcA0KICAgIGNvbW1pdCBoYXNoOg0KICAgICAgZTIxOWI4NDgxZWRkY2UzZjc2
YmMxZWZjNzBkNTYwNDM0ZDIzNWVmZA0KICAgIGFkZGVkIGNvbW1pdHM6DQogICAgICBDSVA6IEJ1
bXAgdmVyc2lvbiBzdWZmaXggdG8gLWNpcDQ0IGFmdGVyIG1lcmdlIGZyb20gc3RhYmxlDQoNCkJl
c3QgcmVnYXJkcywNCiAgIE5vYnVoaXJvDQo=

--be8JNrGVK5UviHpOcf68
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4577): https://lists.cip-project.org/g/cip-dev/message=
/4577
Mute This Topic: https://lists.cip-project.org/mt/72934122/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--be8JNrGVK5UviHpOcf68--
