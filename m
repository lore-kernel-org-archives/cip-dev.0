Return-Path: <SRS0=eOX7=63=lists.cip-project.org=bounce+64572+4620+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA69C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 13 May 2020 23:28:01 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A25FF20659
	for <cip-dev@archiver.kernel.org>; Wed, 13 May 2020 23:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="lPZLMOAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25FF20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4620+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Z5YgYY4521723xE3v693arcj; Wed, 13 May 2020 16:27:59 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.129])
 by mx.groups.io with SMTP id smtpd.web12.2575.1589412477217017968
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 May 2020 16:27:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyKdsOl0ED+KzFmECbPEanu/fqED05cWZ4jgiDKXMy5JBrljfyOnZrMnZwdc0mOtX1LLqOk5jMjV1hiFDs34jAmtKfPo7Ag0+wzuEpkuuwWPqlPGPOrpydazE39iz2BrFI9J2cdu5BtJ0Gi3iABumrEFHDARbo5g5Y+KCujFDgtmGil7DwzRHSgJE3/9qfQ4YgFpkZdHaWgQrltthMXMEX4P3Aj5grb5vUUWdQBkAXi//WLI9ZpCmVL8gEsGXRgKEguqt0/LeXLdhh8bgVQZQ4Y34AyBEizOHNZzvu3PWNgC43JR7myLaQlzHMPvl7uI62sRpsTA1uSEF/FbsLOw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VQhhCeS801HroJ3VgyWbIFV9PFbRYfWN2LtCDfgZNU=;
 b=d6k198P09y67CclC3AC7tbYChBKI6f+IddxsiGlkJjp9PgM8LVUrMhJTNY/vqrLQiKBxvr9NZMzyCma9EDnzaLFjOSvECX/A6Od30FxxN9zXBofgeYfa7iR4V2n7KTzNOiXFKHgqlNkkqfdmvhk7n8BE2d9vTJdKqpynjMpBUDXJINMZm9igaOKMSMRd9NcDxJI0Q+eKwpSq+b6V8mdsOoyZ763U9bjCgXW5UrN74WEvRFCTvGG4TcB4Jjd1ak0DXbVMykNZvOGF1dXDIx9sZPh0CjPN/wQ/p/FmfSwwOIS0gkpJt7iVIsi2QCx4+iXsrFrUhJkV9LO5eHgxWul/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (20.179.172.148) by
 TY2PR01MB4106.jpnprd01.prod.outlook.com (20.178.143.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.33; Wed, 13 May 2020 23:27:54 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 23:27:54 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdYpfd8VgZNK4+siSeOh4stLVy7t6w==
Date: Wed, 13 May 2020 23:27:54 +0000
Message-ID: 
 <TY2PR01MB4972739692AC6AF837F89BF4A0BF0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc5b06f7-bc08-4b73-44d4-08d7f7954330
x-ms-traffictypediagnostic: TY2PR01MB4106:
x-microsoft-antispam-prvs: 
 <TY2PR01MB4106ECDF0ABBA2177D977643A0BF0@TY2PR01MB4106.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 PqEVwEBtwsbTp2SgHa6NjSHe7gO8Q5U5aktai8jEtIUNfHOdnEx9M8xYg1f0cQ6y2gHkPlfxuhu11hNu7YPICBO4i+CqMCmRmhyH4DtFzrwySbqEiGMaQJH6uch5peBvW5GmTcy7hioNJa3hBBFR4uejaF5SNQ7/i/BP597/U7zdjnajm9paQhBEUhibMAUkJxfS9ej7zks2DIQhg6Xwjk+yCTEHVSowP/CJydetUyzZOs0Al0iXm4xTmCKFVncoqpetfJCVwfG6xUzOvNBSxgLpGCzVSk6YBtU7PBbLF2fJrGZchKBJeJjHFbNeTgnDcY9AXMPGlRoSUKHrAi9rPz+fYOiBttjByxAmBsKpktpwr2rpDR3jI6p1q0hK6M6sVu2CWuQFQF2EifVQHpWbGMJN6PTMVE2wpBhHDgnDKfb5UdKg7w7lm+MVII0xXRhgz67yqXEAHPtLlnmJ2xIQYQPYuXWpS6VL4VVrRPwjTBqrh04gYmcqx1/lQb1ZO73PR5yyjrI2UCT6FI6WoO7gAw==
x-ms-exchange-antispam-messagedata: 
 NaM3wX9ImIbV5cjqiVdW+GoswB/e92Mh6z0+hW+jjelbTaTTPcLH3nGsWST67dn7ogFK5H8TBJuVFseacbRBiLALbricqSBKHJYG4jN3tEg6Ahh0TPrFl3f2m1210Hw8kD/Po8ZUkeFN1T/G7rgtuhgBkLsujSZngrnlnZ/+/WxF0pVS0CtxeYKw0xldTmvBFNJsrDJxjQl/qArdyPE14U8jE7jfn2ksCPGxVy8erx+VN+P0pPPQit1aOqTVp0ncQ2UNQpaIQOmoDsFFGnnTGjmsORja89eQqipISBpuPYhXhHDfIDHTPkLSFXDV+WaiZKcuV75B7ocWTOndjJd9Fxcz57Wp/1Td61OUCKdKji3VIc5zd3xLKdgvPM6cefHZpdGDejg0hlNzBROyAexxiRWRACTCFqUNs64meQEP8nA8U8bp9kjU+tWqxQBGJy4E559UQ637xJD6y9My8yOt+MQsAYbXfLM4njgUfeSg7KZu5NJScVOIlHT3rTuCrnuU
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5b06f7-bc08-4b73-44d4-08d7f7954330
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 23:27:54.5179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpfOEsNeFT+bkk298Qm2DvR0uMa8LNnab02KPReo55S+M6bcJAmj6LvqUW9fhXqKHrb85wy4Qfte7Gz2JHeUlNfxfW9S9yXUK0ajfvIpuHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4106
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GQjgXiH44BbahacHf6FfATEax4520388AA=
Content-Type: multipart/mixed; boundary="qT8REEypn3JLnaTRHMeV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1589412479;
 bh=R0qW8iX4OYzrtJCBz+gPqMXEDlAqgUHiWwU84zHhgS4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=lPZLMOAI8j6Q90RPZAcginKWHc8zSpIpE6mk4F70UIObjqEwGBNTMikK7wmfRm4DV6c
 Zb9UBbmr++CEe7x+3Vx4r+Bd53GMDbFLOE4NjMyuCeydTFs6L+VqhmCn951KGXUxFHDUA
 DmOvNqNYsaBrSt/jvQESzGFa6wUeplyx9tU=

--qT8REEypn3JLnaTRHMeV
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D5&day=3D14&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/05/cip.2020-05-07-09.00.log.=
html

Agenda:

* Action item
1. Combine root filesystem with kselftest binary - Iwamatsu-san=20
2. Strengthen sustainable process to backport patches from Mainline/LTS - K=
ernel Team
3. Upload a guideline for reference hardware platform addition - masashi910
4. Propose a reduction of kernel repository mirrors to TSC  - masashi910
5. Post LTP results to KernelCI - patersonc=20

* Kernel maintenance updates
* Kernel testing
* CIP Core
* Software update
* CIP Security=20
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.


--qT8REEypn3JLnaTRHMeV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4620): https://lists.cip-project.org/g/cip-dev/message=
/4620
Mute This Topic: https://lists.cip-project.org/mt/74194672/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--qT8REEypn3JLnaTRHMeV--
