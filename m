Return-Path: <SRS0=p99j=AM=lists.cip-project.org=bounce+64572+4878+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93D2C433E1
	for <cip-dev@archiver.kernel.org>; Wed,  1 Jul 2020 22:53:40 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525722082F
	for <cip-dev@archiver.kernel.org>; Wed,  1 Jul 2020 22:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="X91Q3v4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525722082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4878+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rOH3YY4521723xx4cYQ2EJno; Wed, 01 Jul 2020 15:53:39 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.121])
 by mx.groups.io with SMTP id smtpd.web10.300.1593644018142592860
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Jul 2020 15:53:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMWeF7ATO8Zc8d9bWOTUt/bXDsRhZzDqkhReSP/fLz6ZXBcJox7ykzcan+PpHrCOqjUD504oQYpZU85viy63bIW1KEwTCdN8EsHd72kY/QODpwqd55kS4/gsa+RMIw/SXaTj7AjZJWiVBzg8LEVctt7y8bl/p248hZqqhSILDzDCR5Rmywd2vgLuikX4MjTGJ7AXqc6FHXA6PTzEhyjEZhcrKMKejaECUuYD4C2BIHnh8MoxTsg/3su4wdPF0kUn93Gd7fBrMxaB8z3Z7wDHPSAOPSjpbKx8w8za2pnQbrVn2O+5oQOzZ2qYFgf1R7yWKxzgqxlpgQ52kXpqTYfNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeJJCjOBM4MzWtnlb4HjaMKEJzkrgxfSN4TIVKvHbVs=;
 b=PjbKeAX4HAAjYfVqWmh84kAJLurwTsNF7T790AhXRfZrnK8E4tejkmV91t/7Cdj7TVc06Iafz5NSCe1uBmtpVyk2a9AJ3JLlkw8qmN3/BdnDdqSKnwGBBDVNnwlwxcSGiL9jG5WdIlK3tH1+nXk1+JnMEj6XFvi8RcdDntw7SXHfGnycENrUQ3RdDfs8yxg8EJ5evoyiEG8lyu6229siE9o1flJ2n6bavsfH2jtmwD533XWcb5T4Ezr7/WuV7tiKsmlyPjx6M25uPjpIgV+aKNUl6sd/gC1u/pcOD4yTYwYKU5H/tg3jn2y84DzYS/YyNWPykBu7wTSTjX2TvZT8kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB1936.jpnprd01.prod.outlook.com (2603:1096:404:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 1 Jul
 2020 22:53:32 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20%3]) with mapi id 15.20.3131.033; Wed, 1 Jul 2020
 22:53:32 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdZP+jmloosxvgoUTESSo9C2ia6xIQ==
Date: Wed, 1 Jul 2020 22:53:32 +0000
Message-ID: 
 <TY2PR01MB4972E7064886814AAF9B745EA06C0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4a2aed3f-b722-4ab9-ed2b-08d81e11945e
x-ms-traffictypediagnostic: TYAPR01MB1936:
x-microsoft-antispam-prvs: 
 <TYAPR01MB193648DE0BFAC5EC58537713A06C0@TYAPR01MB1936.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 FYNq1Y8xyyPgrvpJsUwEIK9jzIrSGAv3ECWyigSQvwtBGUfk2+E/Q6GHd1U7tLupM4f+YNvW+20rGhBk8mezj7QIUCB9HvQmkSv6hnAT/xWdlIE+BEY97IxIsZDeaRwD2xvf500Ndg3VccU9QEi0OA5AMhM7o8ZlXjHXjhVZsOdhpnDDRRefUPAM2I37D1jJcrLwzgof0H0EcAeq3HfGlDHy+59t88z2sGAjOdsuC/wNMTIaPAW2etC840KA8+B5I+fZj9lnYBtpgnPwXdGJH27BHZm1zx0J7vD1tCpnyLi4ZMMLrYFjHLUZgnZdX8zx8OILVOwRscFIQOMVTFn0+/92sff0m6yUh2puzl1wm0d5VtRSukv4xHvY9+mVN2jhdaHDFP9VuAA3aVLz34DuKA==
x-ms-exchange-antispam-messagedata: 
 /LFXplhZtMdPNtHtHKcbsyJKz2S7+dTxsOtaVyhMmrGFdLbYnHBQAVNgxUmmUxyzdYtUYd5DoDFX2lJEVBHbbT25gnGNLH7MHutV5IW9wgF8Iw4rOyDUrmnf37OSiFkssAf+/8+JHAsMFNj3S3y7dVfVZljDh/CvaKYjLnDU9AXaW5pxwdxVxh7YL9+Gx2L7kNp2/2zWtyJFc7v2wtfRrGhly1MUjRJbXE1ilTV4CuwZNcQB+s0Noayb8KyaZws9A66dogQEPKTmrYufCMbd/ctZ6bSHJg1+t8VUoyuXN2HtukgF4clDM3jCRivKlyHYdAOBkiln/l0BKB4paqYyRLEsQXC5vshfr7mWEiDT26CtE1RUWMnZLeoJJdEXc3IDCf2yWaINMIaKqDJ0XqCRLm8TrmZ408xBf2fMsySZzLV00+Y7CWIK4qk/PwJ3VMnqVVNGV8AXz1/Ya1tK0LrDwbIxRgWC7OFyka0Mf4bPHG7wsCIShuCYU75uTOUVuTgl
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2aed3f-b722-4ab9-ed2b-08d81e11945e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 22:53:32.5171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jdB90cyRtiFiLV55uYrLrkspfAl5vMYluzDhsJ0sD0jOWF0Zkc90fJCH1FXhoInBG4jdxBLWnobW4aZDH9iPZIMK9/IEFDPoyQ0WQ73+VW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB1936
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7RlHAEeIcmZsIlcTp3sdqGvVx4520388AA=
Content-Type: multipart/mixed; boundary="UJtmBuy2mgrwikeEL7Uk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593644019;
 bh=nvGRlw9sm3/gZCIcd9eOm0uQC1hut9ZRApaWqYx7rrY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=X91Q3v4JzRYCvJHjh0zdZHUAghMTWMvmuCC5GRFxts5t2OBlErffi3/a2fc3enm+H/e
 RmiKcgbLlTibP0EHzBATB/jqGKhkUOm7Df6lOVZ5VxpBZvbOyk0TDHWxdMHQop+CIhl9f
 ezJALL5l4fPUD06KSrZNEQ9oZMGIKHPhUWw=

--UJtmBuy2mgrwikeEL7Uk
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D7&day=3D2&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p=
5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/06/cip.2020-06-25-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Post LTP results to KernelCI - patersonc=20
  3. Issues to be fixed for swupdate "copyright correction and salsa CI tes=
ting" - iwamatsu

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

--UJtmBuy2mgrwikeEL7Uk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4878): https://lists.cip-project.org/g/cip-dev/message=
/4878
Mute This Topic: https://lists.cip-project.org/mt/75247269/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--UJtmBuy2mgrwikeEL7Uk--
