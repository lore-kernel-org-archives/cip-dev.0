Return-Path: <SRS0=Qx7a=DP=lists.cip-project.org=bounce+64572+5505+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0672C4363D
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 02:40:14 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B7320B1F
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 02:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="kccAiJGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B7320B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5505+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vCLfYY4521723xfsPRQgfeFi; Wed, 07 Oct 2020 19:40:12 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.110])
 by mx.groups.io with SMTP id smtpd.web12.3148.1602124811844579225
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Oct 2020 19:40:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2A2aLNeXl5btLz0CkueQgPTMJS8tmEzzeCbCJUesGALdI8lH3F6J131S9mqwTxQKaKKjqkybT3l+9o4B2XpnMYXK6rmUqq8vsdXRz+o3oGadrJn/f0/98e6/DNFT7MdE/bapDTf4qWvJ2lCa04H9O6dxTPgLQw4+OgQjnQxqS5cDU7QhjTT6Nt6W+relvDI/eRZ0odHC/AjJdmSS5onk6rtiHixIjOCjMI5fe8pCQ4SuviueaOlkOTHlXEp4YaIY7/Xp/iXRH43rUFjbdn4+11cmPJUjK+P2m2kRn1axRKav2HwacRFTdPFVv5aHszt3ISlc95O62kW3Pq3i+rj4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7TsNWJn9eIjuu9r0mK48lrjxNgibZb/1qDpDvBvxu8=;
 b=n01GtMEmnAFptrZnJBG2b0qUdo/u2NofXWoXBjjzA+u1feM3bWsnGbJqV2wuYPVMpir+LEwNbrQ9eShxlyMakbQmIO9mNkZsQKT2xoPekBflqJOX3bbd6W4LINSJf86wdmc89fn+ixg9aSr35S2nH8GQYDuuSHoQ2sYQljyKOei35ENNu0AvU0+2qIX7D6rOaldXzf7uZcMpYtduyubXa+whN1LvlzTUhPRkh1uguf95nUbVaDlvtMg5Y9inFfXKwj1lIorJ1N76UlVHy7mYQrS2pMSapBLbp/oyirsqvlX9TTOUMfTmMvS+a1Kxv4JAuPlId/nVr1Jn5d5iectrTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSYPR01MB5366.jpnprd01.prod.outlook.com (2603:1096:604:84::10)
 by OSAPR01MB1747.jpnprd01.prod.outlook.com (2603:1096:603:31::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.40; Thu, 8 Oct
 2020 02:40:08 +0000
X-Received: from OSYPR01MB5366.jpnprd01.prod.outlook.com
 ([fe80::e48d:8a10:109:4872]) by OSYPR01MB5366.jpnprd01.prod.outlook.com
 ([fe80::e48d:8a10:109:4872%9]) with mapi id 15.20.3433.046; Thu, 8 Oct 2020
 02:40:08 +0000
From: "Kento Yoshida" <kento.yoshida.wz@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdadDdEK75ALNrT6TDiJMlv9gfwWTwAC2YAQ
Date: Thu, 8 Oct 2020 02:40:08 +0000
Message-ID: 
 <OSYPR01MB536623991788E9690E6A4AAADF0B0@OSYPR01MB5366.jpnprd01.prod.outlook.com>
References: 
 <OSBPR01MB4967B53707E24AB20B083FA0A00B0@OSBPR01MB4967.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB4967B53707E24AB20B083FA0A00B0@OSBPR01MB4967.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [150.249.226.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a0a98ffa-06e0-4faf-38f8-08d86b3378c4
x-ms-traffictypediagnostic: OSAPR01MB1747:
x-microsoft-antispam-prvs: 
 <OSAPR01MB17477142C4595A60162B5518DF0B0@OSAPR01MB1747.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 6b90rfGkZ5mW+pn7j+lDTSMKk244Z3iZ5yElzw2M0p+5XMEdm8mxBb5oJCXSkoVpGTacunTB7lSVR/4svvIsEBduY3LtvRGjjj/FtLNYhIXBlZIAiOm38IlWdHk24Ywp1NyTVshOp62C3pCUzU9fjQQRqJ+OBt237kdyK0tJ5Y6scOSiua3x7aE7FsvCpvXApmBPaSxwpKseAsrt5Kssmu/P9OB3KVf81kQ+7P065ZfrBu4YW586Ynh8wYADO7YXrarar98RkXZ6T9sUZy7oAAS05UgAbB4p9AKqYRbEbGtEWS4zcbmIcsIXZs1hKgKCjwFXlNTuyIrHn7TO7IDBmEyOtV2noY/P9yzNUyW397wmw5+gnKULo/chNkcPP1qSptpEkuKX83jdPvlhXxMm7w==
x-ms-exchange-antispam-messagedata: 
 ADN8QcIEBb/08seTW6DkwhnHtL3DerLsRUzYDwW8UpVZAAXv8AVmqIXdtwauI96Clxh9bHwQAl6tmtKn7qfTDcREEyorBENxA0Rb1HdhN7pQtJ1okM2lsEAzR4QOb99ttYUiGKWnYQJqgvVNQalb/fy+cUcPFDQLDrvEnT8ItcEhyc1LqMRS1hlX0QCp+GRvlmNOTa3rYvxCs8aLOh8lp8nr0r5HXGHbA186d5JlElpVa/4oD8oPUSGJbWqN+jV7+tV3RpA1v8nnRJQSYR26j0JEamhIdxplI4qabylVTCOLmwWX6mPnOxil6wP/Yb2DkM7FWinvz9siih7QTwBuw8gk00vwbi7ajC4dxuXI0Oxt3xKIO77IIt7KoBIWof1qOPllhYLYqeyUr2ATEE0dW5z8k+cvL5fe/7rxCmJ0u4zUS770IRBWZ1ZNJ4b3KL/JH6Po3hrJ/87sitV+4Ok31KI/ygeJ+jsVgt2aAoyLG/bniESakEH8+NDMoUiIe8kw16HOfzd8b5AL14k5zXTxhPrattQ2RSYBO8xDccSEbsmfSoqYxZbOEfcEYRAqr2Vi4vkv8qRxYjYuU5K5mHuQKkBKJgM0ijcqrx5IhnE/uVXav2PU4Y1JA53CdC40LLKDk+hFCD8zn99m/KneVNKzLg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5366.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a98ffa-06e0-4faf-38f8-08d86b3378c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 02:40:08.5579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hiW581X1hLEPHQi0msr2YoQvjR04R3xe+jiV+b4A3zF7nK0EDASJmz7ntO8zbiEKgkYys6sbjz+MJ3GNCCqWQf0FXkIuvOFhfAM013v7Yyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1747
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: AdHV6MmUOGigta4NsmcGyvM7x4520388AA=
Content-Type: multipart/mixed; boundary="pItwPCkL0LZw7hOmmYSn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602124812;
 bh=R7nzFxOCulTM8KjEHJ34YF4vrzS9BuZ8fJDrOgBDgHQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=kccAiJGsWiCRw3qSbbhBycy5vbfKIGxUE2Y8TsP0RiBTD7a5ObmstRmsg698KM/rn1+
 5I89IkQz6TC8VqqeS2JV70Fzjt4n3hRzUwBbbsDWF1+29eqbs+8tpp9eEglEU2PXwhlts
 p50PFhsP59Rwp5+vVjh4t0+ZhV4me6bWxEY=

--pItwPCkL0LZw7hOmmYSn
Content-Language: ja-JP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Kudo-san and all,

I'll be absent today.

And, I'll report here as an alternative to attendance.
Both minor updates were once reported, but since they are protracted, I wil=
l summarize again here.

Major updates:
 There is no major update this week.

Minor updates:
 1. Gap assessment for the development process (IEC 62443-4-1):
  The report from the certification body, whether development process for O=
SS meets to the IEC 62443-4-1 standard, is delayed.
  But, perhaps we can get it the end of this week.
  And then, we'll plan to share the documents on the development process th=
at reflects the feedback from the report.
 2. Gap assessment for security features of security packages we suggested =
(IEC 62443-4-2):
  We started review security features of security packages we suggested to =
add as CIP core packages.
  The completion date is scheduled by the end of December.
  After this, we'll continue to proceed our suggestion, now it's pended.

Regards,
Kent

>-----Original Message-----
>From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beh=
alf Of
>masashi.kudo@cybertrust.co.jp via lists.cip-project.org
>Sent: Thursday, October 8, 2020 9:57 AM
>To: cip-dev@lists.cip-project.org
>Subject: [cip-dev] CIP IRC weekly meeting today
>
>Hi all,
>
>Kindly be reminded to attend the weekly meeting through IRC to discuss tec=
hnical
>topics with CIP kernel today.
>
>*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 start=
ing
>from the first week of Apr. according to TSC meeting*
>https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mon=
t
>h=3D10&day=3D8&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D24
>1&p6=3D248
>
>USWest	USEast	UK	DE	TW	JP
>02:00	05:00	10:00	11:00	17:00	18:00
>
>Channel:
>* irc:chat.freenode.net:6667/cip
>
>Last meeting minutes:
>https://irclogs.baserock.org/meetings/cip/2020/10/cip.2020-10-01-09.00.log=
.htm
>l
>
>Agenda:
>
>* Action item
>  1. Combine root filesystem with kselftest binary - iwamatsu
>  2. Check whether CVE-2020-25284 needs to be backported to 4.4-rt
>      ->  Delete rbd ( Ceph block device ) from 4.4-rt x86 config - iwamat=
su
>      ->  Done, so will be closed today.
>
>* Kernel maintenance updates
>* Kernel testing
>* Software update
>* CIP Security
>* AOB
>
>The meeting will take 30 min, although it can be extended to an hour if it=
 makes
>sense and those involved in the topics can stay. Otherwise, the topic will=
 be taken
>offline or in the next meeting.
>
>Best regards,
>--
>M. Kudo
>Cybertrust Japan Co., Ltd.


--pItwPCkL0LZw7hOmmYSn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5505): https://lists.cip-project.org/g/cip-dev/message=
/5505
Mute This Topic: https://lists.cip-project.org/mt/77375242/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--pItwPCkL0LZw7hOmmYSn--
