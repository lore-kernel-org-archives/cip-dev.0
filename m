Return-Path: <SRS0=lksD=DC=lists.cip-project.org=bounce+64572+5476+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0EBC4363D
	for <cip-dev@archiver.kernel.org>; Fri, 25 Sep 2020 04:30:12 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC8F21775
	for <cip-dev@archiver.kernel.org>; Fri, 25 Sep 2020 04:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="wwJ31ub2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC8F21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5476+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Fi9cYY4521723xtaZHkfLnSm; Thu, 24 Sep 2020 21:30:10 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.351.1601008207752194422
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2020 21:30:09 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 08P4Ttsb028080; Fri, 25 Sep 2020 13:29:56 +0900
X-Iguazu-Qid: 34trFrx2q28R5DZUqT
X-Iguazu-QSIG: v=2; s=0; t=1601008195; q=34trFrx2q28R5DZUqT; m=9PMFFB6zwtpQok12sGwBOhn1Hv3/rZ5Ym29t46UX+XI=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1512) id 08P4TscC006104;
	Fri, 25 Sep 2020 13:29:54 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 08P4TrWW029942;
	Fri, 25 Sep 2020 13:29:53 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 08P4TrlJ025138;
	Fri, 25 Sep 2020 13:29:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGhnXrHa15B7z486gG6+q98QwH5OBC6bNEeLrnHkmbTHR6lNVfXDo7l4YN0zkUReXIZeAJiDlmvkclOGqCMUFyA6Xe/qA67fFeElT5eq35mQZ5un0uco2GUNK5hElaUhZ1ySnz0gc/4wgLKKFb6Yrb8dhgSqUrt0wQdvLJMhKDbO2zEL8P/XRxG9fPi9ME32DOgfzqzjZz9P696BAfmd3qffTy/k9Zmgawj95tNEWBhI8DO8NC214hbUE3F7EGwNUXUK5VbxKiIs1Y6ydzQJj4jfO0ugNZAyz2lv8I+nQOhsw16pMIaesY3g0inqObQVCWKfXf+JSKG0w9eC9WdYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lZYsHOYpui8jQGvUpR2nZZhJOOc8XYG6iOISFLEo7Y=;
 b=JTOvL/TXfU3mNF6kt9Pzd5HLzHUBCNPzpQ2M7iQAi5Dy3btqLxRlPUk3ccYcwFLja5/8Nxt9hkQ/ScY4HfHeSMuQkmdIg1reihkua1NseGU/zIfG9YYenC9Yo0ohrOZwBSUuCx1bK+mj2aahFZj9BKQ+phSMonkmeFZLPxbeW30AXDZJHdxwO38GL8xUA2lyjUl8orD3eAPfZrAconQdmkJXlKkm/e0ojbbky92woPucchw6b8Sry4oCnsqviqxBzegzCX+YB/7lPCsjH4CtMOn1ut3y7JP+qTNFZlp9SneyxExZ33y/S/b7Kf8LsjOf2+qZw7FiFuLtdEDFmMFTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <ben.hutchings@codethink.co.uk>
CC: <cip-dev@lists.cip-project.org>
Subject: Fw: [cip-dev] improve show-description results
Thread-Topic: [cip-dev] improve show-description results
Thread-Index: AQHWkvBqx9/hRAKtNkikrGptx2c68ql4woXi
Date: Fri, 25 Sep 2020 04:29:51 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2053E88297084B0A7C265B58D0360@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <1637EAD4F9798B33.26834@lists.cip-project.org>
In-Reply-To: <1637EAD4F9798B33.26834@lists.cip-project.org>
Accept-Language: en-US
X-MS-Has-Attach: yes
x-originating-ip: [124.211.28.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35f1b462-193b-428e-b734-08d8610ba544
x-ms-traffictypediagnostic: OSBPR01MB4456:
x-microsoft-antispam-prvs: <OSBPR01MB4456A2C1AE1ED0F40CDD3E50D0360@OSBPR01MB4456.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iDLEjSE/rULct/MRRugaLnN3hSnJGQn1u9zFkIJ3p9a+zqk1tjYC6xfvMl9RXvtbutk+XhrcWQnqJW268g7uboj0NcsFFPBUQjPVk98Br+YL6ErG6njzaAuYQTWZ7CGoKr7PG2R+E+PMnvNR6RqnACRbutbJ8bJ+J7C0V9pAVxbR0HTmBelEcDuNdKBBmV0QrqDw/QdJgYImf9ArXt8i6QPKH4B5MmCZpKsTDMT14hqJRNl3G0DWlDNHArdNbdN+0d2yV4SlBVcCVp3lssc8BHeCVIq7LigPHKb9DrR7r0xIsmBicIVYakmIq8f4bYaUhFAVKJRLlq7CHi7v1uOc0WneK29uhet/hgXsoeI82aFxGot0ACcg4s+9Y0nWlF6S
x-ms-exchange-antispam-messagedata: 2SvkXxeN7Hd7LQuv5+S99C1fNgpKr9k52aRSfT6wUZr5dLR0EUVTDoWW/uMsvxGB+z2bD4ql6utDEahHi22Zq5xY99BVeOlN/zji0MUt74il7QOXaJs014Y7tNUQXMB4nuTzJRiVRejYgukw/G9Kkr2eYvfFrHN29PllEXVayHNfH2BfIhvpPPmtoZf15sXsWvRIuvhr9bCKfcoQR0wOF3n4ZHtT7ychXq2k975J2n+kKNLexZeS7rxD2Nnm/S9IbFY1skEa6PysTz9Rw2Aqp1RYKVir00OP4vKFy73Ud75d9Rd2S1I1G/VtmTaTEgZEH0W1xUvFClq2TahsZKGb/a3lbcFPWJ/I4J9VKuZg7aY+oMaxDP+hsK+v02RjXgIr/BLO6eiktR6EjIQt/RDvEV9gs22sv/WaqU0h9FaUag/ufTi2KceYjkfQ6SEmIHjO7wdrfSiXdVj5nwn9HxvI6D5/6aBPg+jQYENZjrgdH0G1YFPFKTfyY7lLQ8jk8o/Nwgyvwo7K9kHnwUd2EIOWr1Q6+oDVEXQMnt1efQRBMhh+lXFkK0/6L7GiBF6G9qK7KwCiOQRb1zCR7gFRw2BT7UHuD5+VVN+rTeehx/PV2CA7H38Ew3+PqPj205qZhklA1s3EMhYPHLMO7kK/iIsLkw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f1b462-193b-428e-b734-08d8610ba544
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2020 04:29:51.7514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7XlA/rcQ1M4VufwXzqLkD3aov7+NgyYM1gaiwb+zzBmBPY8PixjftMEFtLnZpxLPEAvecQU5HOVa8C3qmMe0oOoCzPSvzrSbuQJqLqcfGfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4456
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5tSiFPB8RIuP5cVr10QkpfZNx4520388AA=
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_002_OSBPR01MB2053E88297084B0A7C265B58D0360OSBPR01MB2053jpnp_"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601008210;
 bh=FobVlza9sPekj0bcKiZxroDRaH1Sb7ePgSr6r6UrLE4=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=wwJ31ub2o9e237fvOVkn8DA46ZJiy8l1IAkkGFrSwK+gZ2cG+V4fxbqCC60mD5SthpB
 zOvd9zkykUwD8Sa0MhtX4ULeWuyq/jEouXzRlMlg7O9Py0uFeZ0E1REk9h0Wvcx03ZjKW
 VL9Y171db1kaDJ/kDQ+0m3DRui22jWhW7o0=

--_002_OSBPR01MB2053E88297084B0A7C265B58D0360OSBPR01MB2053jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Sorry Ben, it seems that I misspelled your e-mail address.=0A=
I sent  3 patches for cip-kernel-sec to cip-dev.=0A=
=0A=
Kind regards,=0A=
Daniel=0A=
=0A=
________________________________________=0A=
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>=0A=
Sent: Friday, September 25, 2020 12:59 PM=0A=
To: sz.lin@moxa.com; ben.hutchings@codethink.co.u; wens@csie.org=0A=
Cc: cip-dev@lists.cip-project.org=0A=
Subject: [cip-dev] improve show-description results=0A=
=0A=
I had this in the backlog for a long time. These=0A=
patches, improve the way CVEs' descriptions are displayed=0A=
when calling scripts/report_affected.py with the option=0A=
--show-description` enabled.=0A=
=0A=
[1/3] report_affected: word-wrap for the 'description'=0A=
[2/3] report_affected: Delete extra blank lines=0A=
[3/3] issues: fill in the description field of=0A=
=0A=
Thanks,=0A=
Daniel=0A=
=0A=

--_002_OSBPR01MB2053E88297084B0A7C265B58D0360OSBPR01MB2053jpnp_
Content-Type: text/plain; name="ATT00001.txt"
Content-Description: ATT00001.txt
Content-Disposition: attachment; filename="ATT00001.txt"; size=423;
	creation-date="Fri, 25 Sep 2020 04:00:32 GMT";
	modification-date="Fri, 25 Sep 2020 04:00:32 GMT"
Content-ID: <B1A84CC14755B64C83241C5795483C15@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64

DQotPS09LT0tPS09LT0tPS09LT0tPS09LQ0KTGlua3M6IFlvdSByZWNlaXZlIGFsbCBtZXNzYWdl
cyBzZW50IHRvIHRoaXMgZ3JvdXAuDQpWaWV3L1JlcGx5IE9ubGluZSAoIzU0NzIpOiBodHRwczov
L2xpc3RzLmNpcC1wcm9qZWN0Lm9yZy9nL2NpcC1kZXYvbWVzc2FnZS81NDcyDQpNdXRlIFRoaXMg
VG9waWM6IGh0dHBzOi8vbGlzdHMuY2lwLXByb2plY3Qub3JnL210Lzc3MDczMDM5LzEwNTA2OTAN
Ckdyb3VwIE93bmVyOiBjaXAtZGV2K293bmVyQGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KVW5zdWJz
Y3JpYmU6IGh0dHBzOi8vbGlzdHMuY2lwLXByb2plY3Qub3JnL2cvY2lwLWRldi9sZWF2ZS84MTI5
MDU5LzUzNjEzMDA0NS94eXp6eSBbZGFuaWVsLnNhbmdvcnJpbkB0b3NoaWJhLmNvLmpwXQ0KLT0t
PS09LT0tPS09LT0tPS09LT0tPS0NCg0K

--_002_OSBPR01MB2053E88297084B0A7C265B58D0360OSBPR01MB2053jpnp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5476): https://lists.cip-project.org/g/cip-dev/message=
/5476
Mute This Topic: https://lists.cip-project.org/mt/77073393/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--_002_OSBPR01MB2053E88297084B0A7C265B58D0360OSBPR01MB2053jpnp_--
