Return-Path: <SRS0=U2ha=EZ=lists.cip-project.org=bounce+64572+5805+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E68C5519F
	for <cip-dev@archiver.kernel.org>; Thu, 19 Nov 2020 00:19:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47AD5246BB
	for <cip-dev@archiver.kernel.org>; Thu, 19 Nov 2020 00:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="gcMUgyUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AD5246BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5805+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0rM6YY4521723xf4a2djP49k; Wed, 18 Nov 2020 16:19:52 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.107])
 by mx.groups.io with SMTP id smtpd.web12.2338.1605745190799448022
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2020 16:19:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4O1HttsgF9MOXkcvvg5sJX3oldrSnK2EdHXWxqSq2GBFjNIonVlvz+RymN4c9g50g2Mt7crw8tcaNPA5qnGlkdvRJMdh/qwhxXEpIrXCspEGCW3s0JQLA0UGAIwfAnOOdefKLtfm9VVGCIqGqaiTGJaUSeq+mK2zGvev3N0YJobEDui3enSrR6Yt8l9rLc93rb45Idypx7mTUnD+fm6xCoZN8Nttbq8JERc+OU8PqFdGedmc/17supLTaJUKbnqLnv1IzmW2PrdopFgfpCjivIimpd1LKAYjEsHvLXISR5wrGA1Dptv9knAYQr1ScrlpUeuM9NXD7AI3XpxhuT5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74UO8xKoaJIKSxlqas3x3boUmtm0y3iw6tHuBYHLznw=;
 b=hQDyd1ZldhhWoToyxIT9wRtrLn28ix4fFLBHDUbd0luobSX/qdkZHR33cHSoasa5fIgjXBbMPrU+CGHbbF5+Vxq54kPrNOr8oNJ+18TUshCbUtI37nMD2BFA3AuqLqEKrw2B1YUNmw3EkrLjBZl3WZfcEZq4+n9Dra29TRBR3bWrgwlPt83H4P3uAnTgquOatT0nP1JSsVj5fH37UbCa2E4il0GG0k5vVs40MXxEC1SFnBIfonylVRCSAaVLqmtQwVv+q29eFZLyt5wGHXs7vUQB3leu9xxdO9p4HgHBZf/S9Vx/6snwa6GbZL+jeTeOr5tGNgi0dNVyAUqrKfS/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB2477.jpnprd01.prod.outlook.com (2603:1096:404:81::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Thu, 19 Nov
 2020 00:19:30 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe%2]) with mapi id 15.20.3589.022; Thu, 19 Nov 2020
 00:19:30 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: Ada+CY9Fxe+/1yZYSDWZKbr3HXyz7w==
Date: Thu, 19 Nov 2020 00:19:30 +0000
Message-ID: 
 <TY2PR01MB4972BCCD6681428DE908F4C2A0E00@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75aaa087-a3dc-4eb5-650f-08d88c20c887
x-ms-traffictypediagnostic: TYAPR01MB2477:
x-microsoft-antispam-prvs: 
 <TYAPR01MB24774D444E3F6F726F3F9A91A0E00@TYAPR01MB2477.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 c7I6qq0uaPuSKeVMfXejI+7EqoiLWd9hCdCbzXwvxwIZZPpPZohR7ufAd5IE3QW9I4e0C73oceJ0idnUyp2gCcvD8415zdo+IyLnV+qMjL/pit+MH/inRSg47qr3jjfrrq2FKHEQ6c/X/rBOothQeOI2F/U9JwztbPd9Uztfk5jF7FNVU+S2rLdEs3G17LJy9FgUld1dJ1dSfINhYA1xCGt2Pgd0AU3YlPWpXSj8o1CJ1aZ1VHKSA+BmqbERmIOqO5mFxJy3YTF2dedScFt26TK5NScggo/CGlIK5I5haHShj4toZvePzD/r+oTvJFrOOw+DIixs6aune452b/Jr5GhukOunfpoMwYwbdzmJCaylTW/ORms8bhrwxuYxcunsGbyMb69gCdL7g8OLag8U+A==
x-ms-exchange-antispam-messagedata: 
 jnydZn7BJLcKA4ZgZIKnE5EbeQR2CvPNSGna8d0nzkjOOKbz1sDkraa0ps9YcpLx8cACf4B2e0mL/2m4ylY33/+T4YVk0gunjgXIYJKaiwWcn1xybQysDYcSZkCs1edG4XrTBeVJbIBs7WhdJJSKmJ/d7lMiDX0FWu0mws4s02+YX1YKE9ydXIPbn1MvzUoFHJtPOmNQWMMd1bWdiWuOxsL6lZVtmlQRmuII2/Xx2CRaZOmsfrwME9YxBtvmW3KCtNbgxFPwKzLn7PrZyNcO6DOdxYj+87clmMnWxQtmlcuEN+WQYYd9BXOgCfIfI8YBVoRhBpYa0BH94M6Dk+Jk2//kS4X/JOUrmlZaT2UY240709zirUTvGb0cavPWvLGALPddjMIklRhDFR9uQjKfLvAJ0l6ZYxMLsn4BLJ83lDvkNYditvRkQMjsO8H5bWQ8lncJhT9ocLryAXeeDv/oWalwNKg8gVQZpxb1M2ao4sjJJQqWt8agLeUJPn5ypIU2jmz691CTSxJjogtWoehLH0uspqW/nO4GDqnNMomxfDhP8mgGEeCaVlTlRIHEVvvy2NBgzkg0wxGN2vY/3U3XrM7CAo6WVewWG9QEL1Qu2lTEEVe8272c6RIJjbsrV5xVxyBD0gfybS+suyM9zsPaPw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75aaa087-a3dc-4eb5-650f-08d88c20c887
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 00:19:30.2834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gyi0CJ03f7qdON/MmSjfxgWD8Utf7ZG+q2jifMSfehqs3c/yNfiW7qcPGfJqP6NGgx+KxBfwauxwoViT2smucrnR/4YhojegleH2G3SqNFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2477
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8nuQNhVULyaOKgepiSKRRDs7x4520388AA=
Content-Type: multipart/mixed; boundary="1vyHUr0vAYNPdcP5CM7I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605745192;
 bh=KXaCGDR6TkbtcLFSSoJF+YQuVLj1bm321Q3kXSc5BTs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=gcMUgyUowuo7r5j070SQRE2Uk8KY9S5UoZqLRix+zCNaeoXRt2yuRj3nF3gj1UMn3SM
 UYRI2neRo7qhOS/mSfD0RQsFPtqsE9YMCROPVXD738BEvBWU5B/2r/9ERi46ezNMh0dkA
 0lD71xBvO8zvopSFy0GM5yd1RVlO6+sundk=

--1vyHUr0vAYNPdcP5CM7I
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D11&day=3D19&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
01:00	04:00	9:00	10:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/11/cip.2020-11-12-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Check whether CVE-2019-0145, CVE-2019-0147, CVE-2019-0148 needs to be =
backported to 4.4 - Kernel Team

* Kernel maintenance updates
* Kernel testing
* CIP Security=20
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--1vyHUr0vAYNPdcP5CM7I
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5805): https://lists.cip-project.org/g/cip-dev/message=
/5805
Mute This Topic: https://lists.cip-project.org/mt/78354782/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--1vyHUr0vAYNPdcP5CM7I--
