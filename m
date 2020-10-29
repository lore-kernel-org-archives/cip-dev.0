Return-Path: <SRS0=c2gV=EE=lists.cip-project.org=bounce+64572+5686+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8F6C388F7
	for <cip-dev@archiver.kernel.org>; Thu, 29 Oct 2020 02:19:03 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A32B20720
	for <cip-dev@archiver.kernel.org>; Thu, 29 Oct 2020 02:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rjgoXCos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A32B20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5686+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id d0W5YY4521723xN0knYHGZus; Wed, 28 Oct 2020 19:18:56 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.108])
 by mx.groups.io with SMTP id smtpd.web11.2947.1603937934411046616
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Oct 2020 19:18:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7ehEdL4ge+sipdVNfk6Cfql9t6ZXv0ZP5c6uNug/lRqNELT8ZmcEwPaeh5pPEcu2quAq3Kpcs4Zj+eWBfGjuo1w/eHDOBYaUUSJJ+wnk5TS6dV/I5zhUVrBjtDNxH51khrRSSnYfh7HtBux2w9lkAb+kNiINpbRfM59IqpUqWGKE1/2Q43849/H4gDjOsXiF/yV26HsqSyOd0sb1ytFZvPtE7uZ2oNcfvFETt+0JG8BEEGuIfciTqSq8o7zvbKMl3UMr1x+VFTZBGOO+EwgRUCArChOS7lEujJ+4+Ke8piwU8S1wnFGqvZVFOeFbcKiO1b7+edriVPjeiDF92PzcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+iuZrEhoEQAFWzxO5iTD9+puLlAYCPtpHnOJZcJjXU=;
 b=PtYm772AYVUgPz7T2N8O6gjZmQwANmXKuv0QMoiiwAsMyZdj0Mt1rUxE5WDI+ilOWHfxu1Ejy90qpWf/LJD5+DZ+NTCw6wkqwW7do0yQuGyQB3FTEK43VIC1umnkIKSUB+6NVMZZ7QbCmtYsvHZHlEGc1TP1nVFseJp19zfx986hA60mbnPfwgKmtjzl3E/2A5sYJ6zE2XZZFgge4Ud0S2/tXILfw/Tsu3kwwo+/SOKvtLRWxWt6sZ9nZ3bpKN2FIuc6AHZlHW1FfvUbXCtuCuyaJzeLbHZhbUTUd4iIv53SLS0YcXKdCl24mNu58AZAPvpFIQ8v2OJr8PUS2/+Dlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB2813.jpnprd01.prod.outlook.com (2603:1096:404:8a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 29 Oct
 2020 02:18:47 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe%2]) with mapi id 15.20.3499.018; Thu, 29 Oct 2020
 02:18:47 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] No IRC meeting today
Thread-Topic: No IRC meeting today
Thread-Index: AdatmaZya+YbxQ2GSAmoTaLOyDYKew==
Date: Thu, 29 Oct 2020 02:18:47 +0000
Message-ID: 
 <TY2PR01MB4972453D3D8AA5081EA8D851A0140@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c31c76bf-f139-4f71-bede-08d87bb0f7f5
x-ms-traffictypediagnostic: TYAPR01MB2813:
x-microsoft-antispam-prvs: 
 <TYAPR01MB281392D705B0E39917F9DF3CA0140@TYAPR01MB2813.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 YhLonU7mw03HtWE2c9qgvrI3NCOU4kQqEG6AH6pbsZD04KncuPzf1kcOsvOSLbm8tcVHfmAhSFrZfdNjiKQWJX/OQyrW8HKitgP4AwF2Ybd+RP5Jd2epiPk/YQk/gg6s9R9lxoc0bpAVHpXe4+cjYjlJiQv60B4vq715sxtp2xCgUeVcQEp5HvVmUP1QEBuG0zbcLzr3tv7wbhC3bT16hd9M2i5zvkVa9NU3s1cBPQT74vjquTXNkjROMOuh0c6/snRqfB/07y3DZvGD7x6VOcakkixwsK4dTI70S9FzR075eSvdZoW4OP4y2fJKSMeeFAyXyiH3Yb3SIy7F4cwv7w==
x-ms-exchange-antispam-messagedata: 
 bfDhFCWnMtc3kiurW01vPZfh78WLF2T3thdIMpoSDUOwC830+D+aSWWVc70hPun5FFWk3DbnSJZhRWhjDLMWJ8jWR3FF03M1Worr9peHeFgHLMPxzAMMjG3nTN9ow/B7c7LyWKiINbW5+oC0Ze2+LtSUN7ardRzsK0IzITBWN4PZ0rr1nXXapT8M11KPJbIdIPltrnoh1hvylaOA3EzoqyX5TkgQM3qarCZAIyhM667vyK5iWiXZm21VNfiRa/3fDss/8vreozuqKuFG3hlLPpYPZaoyAYig9C2O4+tXV4VZ1n1o7oSZ5bzV2wms9yTBO0MKH2/L53RWu1FjRhHDbiuSvJVW8lRjAuY2vAq2f2nRFu+wZ3BiCyjU4O1gOr63q2kX5qyFvZEEztiP8cEbtyDIJek8kRms7buKt0XCogFAN4FCIsIyv2UsvGDcI24kQ40mnfajLuJnsT5rhEZn7SOFqepWc2jtckPW/cqX3j7Wps8zDL+eYf9tYw8dFugPFewRq9X2G3AZsNOc14AzEV8GUwY4Uz6Gy09DvrDzky4WABGVwn1nCsWWZSPPtpD+8RdE61VBHTEEVOYWDTdVZ9e7WlaQaizEFPDyNaqxoRcVGYT0CxXp5JhZNeh3oFQPGGCMpSXlRBIGkgefCRVzxQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31c76bf-f139-4f71-bede-08d87bb0f7f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 02:18:47.7053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJzbl4w4YCH4XiuqXRRJ3KQgtU8rBL8J6pgUFdmrPUXtmGMIm3bfcwgZChfXGLbiYNcdu3gZh5DisVQin67AtZQVYKHMC4XF1aDPZt/nsjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2813
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bEpa8D98TgXt7jxS26UBiVslx4520388AA=
Content-Type: multipart/mixed; boundary="vodM0xJHfLQylQRRfcAW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603937936;
 bh=D8Ch3XEDytQsKa1KOn7r0nqfSzqGKqHnz2yPYOQ8ssg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=rjgoXCos7sJjtD7QFulO7uEPRx/m03rYO+vHrdIS3Dw3WY/Kc0GzLa4kfTgb4zd9P4d
 f4REMTBq802510h/eovJwRwxvF9umTf6psgFMVRM0diei1KNhopA2JZf8Tz7XHYtgea+l
 KkzJjMsPuM+4DRv3HnUgeaA8gNIuK8Uh+/Q=

--vodM0xJHfLQylQRRfcAW
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi,

It is just a reminder.
As we discussed at the IRC meeting last week, there is no IRC meeting this =
week.

See you next week,
--
M. Kudo


--vodM0xJHfLQylQRRfcAW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5686): https://lists.cip-project.org/g/cip-dev/message=
/5686
Mute This Topic: https://lists.cip-project.org/mt/77879605/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--vodM0xJHfLQylQRRfcAW--
