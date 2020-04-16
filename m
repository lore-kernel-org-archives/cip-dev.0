Return-Path: <SRS0=eb2+=6A=lists.cip-project.org=bounce+64572+4580+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2918C2BA2B
	for <cip-dev@archiver.kernel.org>; Thu, 16 Apr 2020 07:28:46 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F1F2206D5
	for <cip-dev@archiver.kernel.org>; Thu, 16 Apr 2020 07:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ovon9YJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1F2206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4580+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id culcYY4521723x75PLqE4zGt; Thu, 16 Apr 2020 00:28:45 -0700
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.105])
 by mx.groups.io with SMTP id smtpd.web12.2176.1587022124024419377
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2020 00:28:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZY9vplcLDbx0rr01nMGeTOyUjeI/Zs00Mzh8fnyGWKbNn/RxHoTNmmYrYwctbQMdpRkvjU1xxlR1VlFxT1p4cRJ07NjVuktc2d33QggjlL/ePzFfLnrbaMIo+Pf0XBn+wV/X2uwmicSoKguXDBNACMg8ie/yut4EwGIi/t8Lb0gFcuC0dkvpSZW2PXv1y/7V9Xq5sgR0FzTMWegrwVh6NDCLa4VLYhdQEi2a0fSpZ+2x3Ra2iq+hgx4LAHBqoQG9QzxrA/dDIWOO8MoyVxh/qlRzHdTziNSIdBPDj7KlfzshJ7YaTAcEu5lSExbQSlzObETFGwWfhuKrENkm/RjMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrEDRi7ps4W4HysA5l5xZJGy+cfDeY+FsRkt4cENrxU=;
 b=YTLiM+mtsRCUXYWortJuxGRPqmDGbXghb4j30z6JbUStsGN+Ja40vFH5Rtb2M/WLCKYZaxGzUXePVdpdbfKT5EeryjbPZ7YpEiesar7dCqeS14/z6WbkvdGcGAQZ3Q2MouZFwr9YKoa4MZJwidOkC4sUQR8kTcCp3HOHtCfWTwee3FBXkAXEDZZFSuJEtbv1IU5TNHnMYdfYQQG6pXvozUVFMmDsQkj9VF32m1VuCqb6mb+90SvJbn9sfVyA/ryjRK3JNSbrxNv/ihiVAB11mwDctDGwuDVlyeCD/l9WBuyxDMpeUcZz4qVa0BOuMU4qxUJPpT8NbAp0Nehx78fmbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (20.179.172.148) by
 TY2PR01MB5226.jpnprd01.prod.outlook.com (20.179.171.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Thu, 16 Apr 2020 07:28:33 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc%7]) with mapi id 15.20.2878.023; Thu, 16 Apr 2020
 07:28:33 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <punit1.agrawal@toshiba.co.jp>
CC: <cip-dev@lists.cip-project.org>, <daniel.sangorrin@toshiba.co.jp>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: [cip-dev] CIP IRC weekly meeting today
Thread-Index: AdYTkwPVJpEHHN+iQmCdazHKo4mwewALLf9aAAAym1A=
Date: Thu, 16 Apr 2020 07:28:33 +0000
Message-ID: 
 <TY2PR01MB4972F6510FB603A6253CCAC6A0D80@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB497244C4E5B3D48167AFF5ADA0D80@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <87r1wnuc8f.fsf@kokedama.swc.toshiba.co.jp>
In-Reply-To: <87r1wnuc8f.fsf@kokedama.swc.toshiba.co.jp>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 961397d0-82ed-43e8-87e7-08d7e1d7c4d8
x-ms-traffictypediagnostic: TY2PR01MB5226:
x-microsoft-antispam-prvs: 
 <TY2PR01MB5226011B3F5D929C6FFD83F9A0D80@TY2PR01MB5226.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 0F30u+3G16Jki7zfs2U9+mQqd/r3UqOTxm9JR3cTg5jbnR8ifdTs73H21YxuqxePeOW7WJYrqXtck4c+cBysLk16FB2YudXgbYFOzPAexQ7Cn83M1jV4iXy23fRMDpl+OyEtt71dWfyH5LhUZBh3UxuWTfnc2pAFNj9Qp1imxDh8ILnn1jIeSRNuQAMGsgtlHMfAgLjz4Swq88olQt8Qr4ikfHfTgL0vME1bhCeyOjC4dxQTMcyZusSxL+NfqOBtqjK4IlZPs0hLVVCcnKU3062IDzheT5EaHW9puRA7KujL7L4D3NsHuDIpf5MYCh3jZe7ii9bHaeStoaLgJslkUaXIwyv0STOtJt9bWm/YqWlRSIyioxqOMh1Lsd6UtXdn7qN7hgHBfSbLTibtNmZ23K5gA6MENsw98xrefbFEYQMwTx31T551NNJ7LvU6xZUX
x-ms-exchange-antispam-messagedata: 
 YHW5O4cQ6TsZrOuOk/9tW6mnnu4dmxEVpX1Su3KLCW/rleTZocIRPNc8LWYBgSRiYpD4zMcwLwp2wwFgtlIHwnSztIpyrNQBQr40PbfSFhYHWzypkwwtc+F6Hhxf/yjYi+krFkvojP/Fz0bB3UfAuw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 961397d0-82ed-43e8-87e7-08d7e1d7c4d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 07:28:33.1028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ZL1wrRXAY0G60llUMb2y/eAd+PIg4jGoA/JNJE0cR0aP+tSOkN+teOaaMjyLiJfQ92fLcaxTBCv9R+BsvTiqNPrWHmFStWrwEWBXskA3vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5226
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: lhHr6UuW1kvTVOVjWSRkASznx4520388AA=
Content-Type: multipart/mixed; boundary="UjFv1sAKEicK4Ke3eRY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587022125;
 bh=8oBoMC4nZFHEuGfKzx+yVNBkFGPihUwSby8/7Ial/fY=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ovon9YJYdY4w80eit+WPye18m7OxK/TREN3OrQB5AM2a/TbdnWcPmCBemTwNhPbAb1z
 zLrZYao/iDyq6Kys6kAqRhzQEXEntl+xoIKwBSsm5ak1MTPoJxvFzg3+XIt+M8XUwfRVW
 D0Za0HVD+RFQIrcPdTurYdbbG+AYYDDhXXs=

--UjFv1sAKEicK4Ke3eRY5
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Punit-san,

Thanks for letting me know the status. See you next week!

Best regards,
--
M. Kudo

-----Original Message-----
From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>=20
Sent: Thursday, April 16, 2020 4:22 PM
To: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!!=1B(BOSS=1B$B;v6H?d?J<<!K=1B(B <masashi=
.kudo@cybertrust.co.jp>
Cc: cip-dev@lists.cip-project.org; Daniel Sangorrin <daniel.sangorrin@toshi=
ba.co.jp>
Subject: Re: [cip-dev] CIP IRC weekly meeting today

Hi Kudo-san,

I won't be able to attend the meeting today. Some updates below -

"masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp> writes:

[...]

> * CIP Core

- Discussion around projected EOL for CIP core support on cip-dev. Based
  on the comments in the TSC I will update the proposal to YYYY-MM
  format.
- Daniel to take over CIP Core activities going forward

Thanks,
Punit

[...]


--UjFv1sAKEicK4Ke3eRY5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4580): https://lists.cip-project.org/g/cip-dev/message=
/4580
Mute This Topic: https://lists.cip-project.org/mt/73047683/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--UjFv1sAKEicK4Ke3eRY5--
