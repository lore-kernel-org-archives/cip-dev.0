Return-Path: <SRS0=PcrM=DP=lists.cip-project.org=bounce+64572+5514+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75796C433E7
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 09:43:01 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A0312177B
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 09:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="sCryV8uA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0312177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5514+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ZA9AYY4521723xNShIjH8v5b; Thu, 08 Oct 2020 02:42:59 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.134])
 by mx.groups.io with SMTP id smtpd.web11.8244.1602150177290657579
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Oct 2020 02:42:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZN2j9xokdh+hvR2AzRiaDuxchtcubQS2bCyTGWsZ2Ov8+t4fnd73uGo6jJ9SDIZYyIagbzcl2BVkC6kOpsRr1bz601kYuVHLDTmlBjQjEgSVVjOF2kpmV0wsPqIotpc/wDmeWX15mTGnVbFP3+IdOPKxLI9xrRsgNjvxMVsEnaTt7EUdv7vBpePn0Q/QMaHbRKIhIfqCz5zYaO/ko1Nye0KLRFUwVavf6fB2FENUm3sST9pYl16ujYN2tetABksYNp5AD4Gd/qbP2/iy5eC2KqczGF0BEm0oxJEPaCwuIls2HafcgvNXowLK+ZtL6ku6TBCh3TWFUK2AQnqVG6rs6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGnMmEttyOADCOQKl3uvQ2POoyaNq3LYLQKxoQffUb8=;
 b=PHV91OnhglQqEtjQKaoeWiFfGLA7IjC8EhYo63LXnnmNbC8QaQ7zcd/zeNExxbk+g1owFyKhgZ4hL1Rz3pbBE+6wzqDoeEfAdonxaL/3/fZf9z3PslOYuJaAxpSga8RBjvhi72FE+oaTtsq08lnjkpdkLrxbOprhky7Qxm1dbP4xzXMmQWws8KLnNBYXeFShTDKRJRoUQpKbb8YlbPJpotrM9DEPJE0agZ4XebdnMixkgFFEB/WNwuhhM3yFCEnXJ0zqNqEEaONK/xXwRM/bL1JZ0zRLvzj1XjjUspI/f+RS9kMr+XYebTht9sarUbwf7jNN6ocIxEtfzgZAP4O1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY1PR01MB1851.jpnprd01.prod.outlook.com (2603:1096:403:2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Thu, 8 Oct
 2020 09:42:51 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe%2]) with mapi id 15.20.3455.024; Thu, 8 Oct 2020
 09:42:51 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>
Subject: [cip-dev] Backporting of security patches for Intel i40e drivers required?
Thread-Topic: Backporting of security patches for Intel i40e drivers required?
Thread-Index: AdadV2Jnu1CNqzkrSoynC++LmpFHXA==
Date: Thu, 8 Oct 2020 09:42:51 +0000
Message-ID: 
 <TY2PR01MB49721EDA34600391409FFB07A00B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 983f2f9b-7f1d-4bea-4480-08d86b6e8611
x-ms-traffictypediagnostic: TY1PR01MB1851:
x-microsoft-antispam-prvs: 
 <TY1PR01MB1851A664522D501DDC1CCD34A00B0@TY1PR01MB1851.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 90TScamFCPNd8TbOP3Rj22we8W28/kf9wwNQ0WFje2qdrG3/f6fw2VMdROaIXggfFa7RoSQjCsnAoBjxLk+4YqtKgxRc7pkEBuDG54XsdaFP1EygntUAzaZJL9kHz4vDNQa/GMYslZ/5zp4OFrE94wDNEpJKKxi9vQ1vFm3NqIhz/aNwS1IrEw2YlV4x+58JEg5igBqZw37W+3ItE+vshtaJWzneGnDQMCM1K2p/3+ygJ4iN4wQNksbkrwReOdp03c8prSe9FZ4K5gRdDHvtaizZQqA1Vh6TgGLj6NC08T+u2wZuq6viXQjR2xV/BIyMEOt84mgQT8QXFYFVDll5MshxPHiLGa76U6WJCYLL7DcAqv6oN1MJWt9a2ZpmVfQvuuwK3o9tigC6dUJPKDziwg==
x-ms-exchange-antispam-messagedata: 
 pXqSSaEAiSn5OCEFKYiHYN9M4f8+gHiubJnOOBQV+vukarhq/AvAzKY6lsym2EP7MUQYpv1zEQdTOUdNzxhP4rNZiS8QRs3V1NiW9A6zCznvZ1Vw3Gx1h/fXOqbpr8TBi/Zylyztyj9SKkC3k5PmCiBGhyk+WqVu5e6b/vSltm2dxJWJ8v0FymhZhEk6BuQFB3WDRP6llpC26yEX/fgyQbaACeT/uElS6jERh5eUHdp8YDLSp96KUspJ7ywXtm80JyWGxN6hOHSMBi89+HGFTmWV37ldJOr4JrJs3wUpHvXD/gSLU4h0nWFeFhpYCFehfpY3SB9M5r1XgAjnl8CWR6l0PjWxg1sE53Lkgmmb+37LsgSHfXcjztwIClIzAoVo9S78EAq4PYKNMakmtNitL0UIisOV7BH4dqRji/f05xmZC/QeGKvWy1XzNwTUkvExj8uHNY/qf1/CXepSaLy9c/OuyjD2OfuSsvvAI3X12hLtT6d7HjagvFRiOBggPknBYOwmck/UD3yJBMV+ME5OBXGJtKlXD3Sf1hNd7ciAzqITfy+7S+zFXg6xpxZhLqVa83dQVqUSY7SKutVItKzk2esXh/hsY6dHiwwc4AoeOxqKy0blE5B5BErE0HuyWmE5CdjnziiaxgUWywnzMsa3Bg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983f2f9b-7f1d-4bea-4480-08d86b6e8611
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 09:42:51.1998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JOlEPyuyapLW3SN0nBM4r0y1QCnd8rFP6JxS5+iaxYxJ8m5ToW1sKSP+EXUCxwOcgBt/a89BO6M8//DV1l0aIKgfh43obGMvNGeEGMQfT8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1851
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: kQCukK8v5juwQjHAYXBBzQ2Lx4520388AA=
Content-Type: multipart/mixed; boundary="FfR7NUpeWwyztJHPZdWq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602150179;
 bh=nzxUqe6VVi2ACT0R1w0eAsfIV4cvLw5RaTmwhWiwBOo=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=sCryV8uAriairDKsCfkv6DMBTgCRxs0yU1i+T+CjRSm6+6jTOueOZ1nYnlOTeKJWeq3
 1M02dZSfmKzGRl6wxvPQb5JdSLtHRBbpSoX1uJkKfXblf9xmlZbIB00IJnu6xsHiNq8iZ
 8MWiNtIhSHioksx+8l0/mWQzwwXsr3GlQ6Q=

--FfR7NUpeWwyztJHPZdWq
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Jan-san, All,

At the IRC meeting today, we identified the following new CVEs are not in L=
TS4.4 yet.

- CVE-2019-0145, CVE-2019-0147, CVE-2019-0148 [net/i40e] - Fixed for mainli=
ne and 4.19+

These are for i40e driver for Intel.

The kernel team would like to know whether their backporting is needed or n=
ot.

For details of those CVE checking results, please see the following.
https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/-/merge_requests/7=
5/diffs

Regarding the discussion of the IRC meeting, please see the following.
https://irclogs.baserock.org/meetings/cip/2020/10/cip.2020-10-08-09.00.log.=
html

Best regards,
--
M. Kudo

--FfR7NUpeWwyztJHPZdWq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5514): https://lists.cip-project.org/g/cip-dev/message=
/5514
Mute This Topic: https://lists.cip-project.org/mt/77380165/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--FfR7NUpeWwyztJHPZdWq--
