Return-Path: <SRS0=j+5A=6H=lists.cip-project.org=bounce+64572+4598+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC031C2BA19
	for <cip-dev@archiver.kernel.org>; Thu, 23 Apr 2020 08:43:32 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 725C62076C
	for <cip-dev@archiver.kernel.org>; Thu, 23 Apr 2020 08:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="f3U+JA8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725C62076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4598+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AVu9YY4521723xWPjJenAITl; Thu, 23 Apr 2020 01:43:32 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.100])
 by mx.groups.io with SMTP id smtpd.web10.2714.1587631410062989639
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Apr 2020 01:43:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAauww8Iu7Zl+upc4pklKnFUFCrSrNOaljcV62PRKw2SZ1cFmMhLsnpPFEGIHReNkmaCGoxJA1FXM6KslswkzETEWakYcNQBAuTxZgGxWPs5VqAHB/BYy7laFLmRIyLgQUGUHn51okEZxWzGzrE6kqfyks3lwDg7hmg8So7t3M5jnex5HdJd7LsxWP0pA52B5x++bgu94yc3EggmAmqdELZ4ropdbmSCWsgCbNKelzJOI9VWrq01OL+Q9vthR4Jg3d8uG/QXKOYG/ZD0MNdEH3LNi5DmgbPlAc8CIC3pBJCej8aVcGhUUZ0lso7SWS8O5IL5AzhzV8hu8La8Li0OFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxpXqnKsWvJPxJB6Kt9hWKa0urxGENtDoznFCEs1iAA=;
 b=ABkn6SiXKWg4mX/nJXcILHp/6K/PyNyLXq0p4sS/T/k71dHM8+9bK+pmb7kJJUpgewRyBKDpD4IqIGgYjk2/NGPeP0yXgoN79S9R5LOOiuYBa/ErPG5tcpQWxeGAGBTwqtH9083mGFWzTQFO1SU3OxIKboBNSHr7HY7GamwlF8MA11xxslwmwCnx0mn9yMVAXjsnNKaoTNgfQlNTFtyPmprmzly3rxA2pFHu81v9/aD0BIoKsdCqBr+1GpcQwdamu27Ndw8pe6PlB0SlIEG8CZRIBxDQH0uwYs0EQXRKCBivRKfw8K7OsShb1aDVqbpkzevA+2q2uEO9/rO6uQaWlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (20.179.172.148) by
 TY2PR01MB5257.jpnprd01.prod.outlook.com (20.179.172.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13; Thu, 23 Apr 2020 08:43:22 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 08:43:22 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: [cip-dev] CIP IRC weekly meeting today
Thread-Index: AdYZAw/dNE7M/n10RWOLa0W5ttoGLAARwqNwAABDD7A=
Date: Thu, 23 Apr 2020 08:43:21 +0000
Message-ID: 
 <TY2PR01MB497236CB8C8152FD5FADF20BA0D30@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB4972C9832D1CE44EC15964F8A0D30@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <OSYPR01MB5334F4029238416971E73FA4D9D30@OSYPR01MB5334.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSYPR01MB5334F4029238416971E73FA4D9D30@OSYPR01MB5334.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3956d476-03de-4120-0176-08d7e762613d
x-ms-traffictypediagnostic: TY2PR01MB5257:
x-microsoft-antispam-prvs: 
 <TY2PR01MB525706D240CDAF911706604EA0D30@TY2PR01MB5257.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 uG/8IXhKtxi97CG7eakKmlZFWO8AiY6XuYGE620v8dxXVi9y9JKUiCHEi0w3SzVUzIjD+tj5jxgWVBPVa/8GPxzfCbMLI/Q8dSQ0D44rkzZiFZ2QY7R5l6qAcOk64Z6QspPvF/yoS2FmT7jY0J4pzpgM1KqONBejmr8xW1fze3WklXugpkyWFe5IXMsJguwyHCaC8o2ZcBdbFk4l5+g9Jz3cSPpwtCESn/SKK1/IWKe9VBL8D0rWa2+S26RmmfozX+NwCGLWH6jzhRK1nqvpig9tGttIH0zpA2gnTCUN66T7Wi+6YNo7IH6e8R7DPXX/Ok7sw7jwaruKvjj+zJCxcdSCUZUimoTgARl5loUXe3FnxMmn26/DM0fxVXdZPJ7j1n1xCjGqKm7JVUvtp2vPaIGoV5z1J5DCJX6mLczyPnvAdUgkGlFngQK03ub8sW1jjMV9v1i7DaTh2/hbKUbYgSNLeW2kdfq9B1x6ioW9jMAm/dbHl4PoRi6MKJicpt/zriEBY/npwtmRtJwvAxp9tw==
x-ms-exchange-antispam-messagedata: 
 CtUYtTbk6j6Gg2pwXobO4yGBWAlVQSKunI9XuTtimsyOg5o3m+6cWkNYYe9ocZPmg7EvZqhhUSa3VyRXazsamQ8n+eoYduU2NTtF6EwwEhBV0eEBINVflLIu+KySoFZ5m/8ZTcYX06N5Pn2Pz30okQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3956d476-03de-4120-0176-08d7e762613d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 08:43:21.9554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6oBt5G/F2JUJb9XyiuhZLz7vVAm9peXSdEWFfMs+wFhwCZBID4DbQ9JY37O9gCV0yXfnkVtm/Z61dTVXQogAoryNw8GNE3PLYfX1uguLPyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5257
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sdaBgh5KVuT79G9q1ZMko4Ozx4520388AA=
Content-Type: multipart/mixed; boundary="GxKjodXmRGZuMhQvrajU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587631412;
 bh=q9b/waJpdhIWbkdV17HB9PhwtHNGpzyWrx/7BtELvqc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=f3U+JA8a61jFJ4Ba/020wZ29YlZ27JIDkDk/ze/KSOiyF6d2iP/64V/F/KPipcicb3M
 ODzXWVBdJjUNvBLayBvAlOrh1s+rvZy6Qi/n3f+KMhivTl/URNBBA3+yK0EYHpuSnp+4O
 wnrxeux4gO128DZR7JaVzQoULxmJR4Vt0dc=

--GxKjodXmRGZuMhQvrajU
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Suzuki-san,

Thanks for sharing the status.=20

Best regards,
--
M. Kudo

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Akihiro Suzuki
Sent: Thursday, April 23, 2020 5:41 PM
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today

Hi Kudo-san and all,

Sorry, I've got a plan already today. So I'll be absent from today's IRC me=
eting.
SW Updates WG don't have any progress this week.

Best regards,
Suzuki


-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of masashi.kudo@cybertrust.co.jp
Sent: Thursday, April 23, 2020 9:07 AM
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] CIP IRC weekly meeting today

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D4&day=3D23&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/04/cip.2020-04-16-09.00.log.=
html

Agenda:

* Action item
1. Combine root filesystem with kselftest binary - Iwamatsu-san 2. Strength=
en sustainable process to backport patches from Mainline/LTS - Kernel Team =
 2-1. Workflow for identifying important fixes, backporting, and reviewing =
them  2-2. Prepare the tools to be used for this workflow  2-3. Get practic=
e in backporting patches 3. Upload a guideline for reference hardware platf=
orm addition - masashi910 4. Identify target boards and configs for RT kern=
el testing (4.4rt and 4.19rt) - masashi910

* Kernel maintenance updates
* Kernel testing
* CIP Core
* Software update
* CIP Security
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--GxKjodXmRGZuMhQvrajU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4598): https://lists.cip-project.org/g/cip-dev/message=
/4598
Mute This Topic: https://lists.cip-project.org/mt/73209616/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--GxKjodXmRGZuMhQvrajU--
