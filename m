Return-Path: <SRS0=+L99=7K=lists.cip-project.org=bounce+64572+4650+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A6EC433E0
	for <cip-dev@archiver.kernel.org>; Thu, 28 May 2020 01:27:00 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E3C20888
	for <cip-dev@archiver.kernel.org>; Thu, 28 May 2020 01:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="WczC7HAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E3C20888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4650+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id mI0zYY4521723xF0bEY3CxJ0; Wed, 27 May 2020 18:26:59 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.98])
 by mx.groups.io with SMTP id smtpd.web10.3767.1590629216400079074
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2020 18:26:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5sFpY5IMYjVPiylHYc6AgeCXmr9movnMfSS4wx0QJREmuXlEPULp0vTPnNPovOAw5/T2nhPY0RMtCenDEKk7m47OKfx2lt6+Dyg652sp38uh6ss1Tx/BELb2A+jDwP74Jto4kO+ONyxcX8En8nr+fW4Fq18gmlTRJMK6Z/EiYM0dxYmTbW/tOQhSUuDpgJYRl7jGXtyxgQU8QTImf9X4YipWU1AsHl/M8X0+ov/gbo+lP5Gd0dghOVd7taIkD7cLzuOTKkt1RO7tBHo4aitQ415zAZLG/2d6ep7/a0iznkT8jYumvlH2USnRbQQWj+L4B+Asz1UWb1ktB4JbFrG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkL32hd6Pg17LjBYhSxfu22VU21FwsRAPgKZrlCGWtM=;
 b=OScIIJmU4izHhu91jpNir5ufARCnIc2UGzis6MvszA0dEYZLPB5AcF7Q+7Zl2cjpEYcfgj3L2ajFr3VQvBefLYxJUh85oRyUbzEIyPf6AcwMeHyduyO0ErbdGef2/msRLOOwhb1dMpDOK9Gocqa+ABL91ZkkNwq47NFsLyZbJIC+Ygc/ShoPQXYGCI4VT5UnFZVrCKIk8pShTT8arj6XPQA2e41dNQEPIu55fmiY56fjiReS+ZKP755hk0fZq3YklOLewp6hyZ6H8j9BAiCMCBsKyoxr9An24nnCwzNPOH89FEitAhy+Hwa9MqbOSf71VLKBkK/+ccxLd20Q4Lv7fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB2970.jpnprd01.prod.outlook.com (2603:1096:404:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 28 May
 2020 01:26:53 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 01:26:53 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdY0jvYzuGDOlIqVQZeyrV3GhU1ENw==
Date: Thu, 28 May 2020 01:26:53 +0000
Message-ID: 
 <TY2PR01MB4972E9BF651CDDFB910C0043A08E0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7546689b-98c1-45ca-fc07-08d802a63448
x-ms-traffictypediagnostic: TY2PR01MB2970:
x-microsoft-antispam-prvs: 
 <TY2PR01MB29705AC5041AD6B949AF3A75A08E0@TY2PR01MB2970.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 MPlVtUVk3HuKCJajugWbPiYJtZ+lHACqwOSMS16s0GUQn6qshbNhmZBZX+gS6WHDnvSCoHFErWgGXd9HsVTM+4y5K5iQQwd6nh85xjBTmUZQ4b6QjKmMDu+5V8qzis5wBvFvdNt2+wu6yZbCN5KaGM1T6VrY6lGv2NQbwAjJaenuuph3M/erDO+ejJyFqwyrL9iPgFhkYWNjqr5alxvbh3WXU0j0PHXAiIn/JQZ9tD7LM78Pcjmq48bKCaT2rVfd7ZNjai/Vnbu8nmcIMRJCg8PE/Mih1VrfokSTP4JEWoXiRhTxY46CGt3C1QMMoMSUgNonprj5YC7/qvwYU/wFuRF+9YiTqfEy1dienhD5//uJhxYVyVPE0VCtRTfPl8Sx5utuyBm5TIkt3kvcwUn7fg==
x-ms-exchange-antispam-messagedata: 
 TtEdk/9AHd3VaZHBlitk/DN9FLOedyn2ucfL1decH54vj71cZrQzR2EXCAYEp3rYW5d/WU7n7qyvr9NMOpYuALCP/RRIIN/mFTouMtFf6qD8mgw//4RgSUpfl3okFpR021a3nJ5nwkImvNRs4nWj5vEQxy+DvL+PQIDMqVZOUy0kgMc20uZuZVlYWwtnFvSuwoyBfvNsSudk+a3pszLK01Fl285vKHP+6QUsvM291pMZvRn5KKeMaSSPA/GhHNLdJLXPqWUMIPdRWcJh/gIApJ5RWqZiCYeRWZxvmPYxL2fj0Y/924WQ/3h2o6LsHRt7PjUm/AbgSx+brdPi4wj6SfwSd90a4r1keRMXMD1xJ2Q1AZDDH/R9daqDgCyu9Zpfn1C8AIfKGJKmadKmLR0aIvGykcBQZue1n9xa238ZYrHkumgBNsBwylc2bgIfKmUDUhQLmmdEuOaBOCY8lGd7gfaNiz3yCTHT+4vYbH3OtKkHni8c23LsCy20fS/tW7ot
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7546689b-98c1-45ca-fc07-08d802a63448
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 01:26:53.6610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ltHY7+bVM9nPY43bMPiqWcdqcykZZf58sTfGov6X1bOIOvVuPC6j9qBzSHtiv0tfiJHLcNx21ezTSe+QUW94Kifq3OVzvdub6oOBjCwN9qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2970
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: o29ai5YWhO358GUE8nwjdUfix4520388AA=
Content-Type: multipart/mixed; boundary="KbgcvTRqBU0ocA4y2A4N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1590629219;
 bh=HMrjCWP+WQ3SxJTZu6xYa0hYb9Wy5dtmGkjarzbh9dg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=WczC7HAMKGNDxZMP/YMTkKCprf8jqXeNOdhvWYM7b1PBfwW1d0Cub0+wo8d4yEZ+9vl
 EJqhkdqRAsJon8mfsP08qsWzS1ti50YdFP4FE3ma14rs5AIkjW81DSpey243PaEOtNmbM
 H91kw4QyKYPiy2PGCImmb8zxDNIoPe1jhCs=

--KbgcvTRqBU0ocA4y2A4N
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D5&day=3D28&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/05/cip.2020-05-21-09.00.log.=
html

Agenda:
Starting this week, "CIP Core" session is not covered in IRC meetings.
We will invite the Core team as needed basis.

* Action item
 1. Combine root filesystem with kselftest binary - iwamatsu=20
 2. Strengthen sustainable process to backport patches from Mainline/LTS - =
Kernel Team
 3. Upload a guideline for reference hardware platform addition - masashi91=
0
 4. Post LTP results to KernelCI - patersonc=20
 5. Ask board owners to review reference platform configs to optimize backp=
orting - masashi910=20

* Kernel maintenance updates
* Kernel testing
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

--KbgcvTRqBU0ocA4y2A4N
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4650): https://lists.cip-project.org/g/cip-dev/message=
/4650
Mute This Topic: https://lists.cip-project.org/mt/74513780/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--KbgcvTRqBU0ocA4y2A4N--
