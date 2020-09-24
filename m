Return-Path: <SRS0=gSso=DB=lists.cip-project.org=bounce+64572+5469+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F7DC4363D
	for <cip-dev@archiver.kernel.org>; Thu, 24 Sep 2020 02:42:24 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05822176B
	for <cip-dev@archiver.kernel.org>; Thu, 24 Sep 2020 02:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Gh2x1cqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05822176B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5469+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Q2YHYY4521723xcdADC5LeWo; Wed, 23 Sep 2020 19:42:23 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.7481.1600915340740734967
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Sep 2020 19:42:22 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 08O2gFXn007329; Thu, 24 Sep 2020 11:42:15 +0900
X-Iguazu-Qid: 34trqPsSBB3N5eNFkw
X-Iguazu-QSIG: v=2; s=0; t=1600915335; q=34trqPsSBB3N5eNFkw; m=InsYdYc1x5btnNyGmK7qu2o2ycv1wGOjih8Tn7Z3+Tg=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1512) id 08O2gEik028153;
	Thu, 24 Sep 2020 11:42:14 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 08O2gE2j021761;
	Thu, 24 Sep 2020 11:42:14 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 08O2gEmY013881;
	Thu, 24 Sep 2020 11:42:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZN+iUj/zo9O4tv5XO+pkI3YCWBU0JxAU5le8j+w/1WRBf+285HKZaoOM29rYqu32tJmNaRnsHOjiwSV/9/gxNPWpkrJyVjdxvZLvoG/qNmFygJVa0vpn9hm+eUaNo2COJZEpbwkurx+VHy1P6yY2Vwrpqqx/8GXaqVWTl/MIs6EIhbXBTeHJv6kqoq4ePPQrnYwTt1X/8ZJap23WuFwXR8MVS3Z6XOG9qhEY3nbcJTlCQpJUVbJDzvYxhTO1cr8gBb7Q1Zx+wT1o7edB42wuppdaol/f2zojZJrRx0myh9byhfyC8teItlo+Zoj2Npc0g26cT++x0BfCScnKDOpGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNCtZJgZuaOdB5BOBzJKDbIvY81wFl6AS1vJ/hEwTew=;
 b=D5kZRIWUUojdZsVeFpFEkeuNd5LQqBfnRDj7YhpMgBH41KxZhj+lAhUZ7WOf0RHqSzJXmp9HCWzu8zmjmah4SKPAA5RAecvaNgbWOMisuKi2VZPHj9qE+Ty3wdlyhbuzJxGR8XnKr9HV3od9vEBHqjgk23t4j1DGj9B7vTDf4gr9kQ/O81f9aP0/698u33ADj0hAhmN3GoFYU2cC/ocoSRZzcDtGwrpK7kb1JEhgpkaEr6+n4hYmY4Txuqxuewot8Fuh7R3KcmCtxsbmwOnVvg0VDTirkVR4coU81MqxYGZEX3/H912MiuanqRleFUtjHESASFz38vaAoZtMea5XZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Akihiro Suzuki" <akihiro27.suzuki@toshiba.co.jp>
To: <masashi.kudo@cybertrust.co.jp>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdaSDc5NDwr+9dkBQiyt3ZfZmv1ZpAADlfqg
Date: Thu, 24 Sep 2020 02:42:10 +0000
X-TSB-HOP: ON
Message-ID: <OSYPR01MB533490B2CB7C0B3AB28F57CBD9390@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <TY2PR01MB4972CF1EA6B8B5A991132052A0390@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB4972CF1EA6B8B5A991132052A0390@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac630817-0a5c-4f3f-a79e-08d860336fce
x-ms-traffictypediagnostic: OSAPR01MB2387:
x-microsoft-antispam-prvs: <OSAPR01MB23877F06F6896F709602650BD9390@OSAPR01MB2387.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SJGkZxtlZA/yJjMLxc3DpGNCpCN0I/bOz6+AUYDDJ9rMVfzgpUKa47iSnSEp/N0eks+bPZaxDcvkUuC0A63CN97ajih5Wwtn3U/2PPLY8W81CGN/QlLxwu4Q7vUpDIKRvGRzitbj3z8c/mbQT8448Ycvzlc5I32kTvI4FYHvk8nIzRQUsipdk4l2HIxcYQas2mZ3S8f76ITN47YFZq5KdwFMWTXf2YVYtQUYFml+ZWYdMBtrPcRwy/Yn5DcLnO1WrDrGzRzCFI+jW/+yWzGsRSCSWPJBEuzUcWSqMaTSkzT7GEN25AkSpeFZ0LKorHoLtQy4GGnDQSjeO/L7MID//4NyogIg5qntDxrIGPRh9MpoC6WlCel4++xaorlHStGd8b+0ZsFWf42kz0LTcEtaOw==
x-ms-exchange-antispam-messagedata: yd3ES2sPZRQHEqBkuOGWviQZyRamKgSBtv8/V3D30zjNpLmRzTdYj0tclizQWnw0BAXHDmruhZ6ToAwclpx/wSI1tnID6NBJXTEoWyJj0jlL8anu0zat/xF8rkSz6unjxtUEqs4QX6jkZ+gC45VmjWX0XzUMeP5RG63Bq23AsNNqM7Wol4kjMO75rYKAnc0GAMGv1Xk/0UhZ94QLvF4jjQ3akgkvh9HQr85lRW7bfgLUAZVXGEEb4XW67BrUgO6jgnE0aMx9CWGPlmMb8js66tkO7Yy2XGZlpKFcYPslcQSDFceLcC88bf8W1oVqVFyfB2h1Lo16q/Ap3rv0IXb/qbYdbgzSUkkD+z41Kg20xZsd71/yRluaGCFNOfIeZjPV3qKi5oCXG1bRToUBrs8QHFePCkJKFNiasT+DaoemW7gLdbQg8rXzPQRbeZvwYjzNBGvWV2Z5Jfes3M2mJvDj8RqR/2tEFyYpoQqnANAs1VIOFKvJ/gHbw4evNCaUs8xMG+nJnhM9OiSvmVOCg7UZSsKwhUcWLlnK30ih+OYvBL4RprJHWO6LFmIOqwdoM95nH71nUukffWSw2v0QF0XEaT4enHA+Lo8uQh2Fe1ug3A+eJoUwtd3O2nvs2vU4upjyajtBEs4oxegOQUL3noaO+A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5334.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac630817-0a5c-4f3f-a79e-08d860336fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 02:42:10.7700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ecB3JllxGAL2wo20gkDrlAP5KsXHR27w4yP1Moxn/WBaPnM8EH26/wfOeehxQVNnWmMJsT3E2Ocv+LXMRDTnaJRI+86pTwk67bC4oLYmdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2387
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bqdOzclcFTQBwchazyzfQTDXx4520388AA=
Content-Type: multipart/mixed; boundary="9XM4yvikGjHjH9u9bryJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600915343;
 bh=XAgmaRNs1QgdTrCrSQ5HPf9o5r8glTFoqWMqf+EMrgo=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Gh2x1cqnW/qMjTeJi8DzMRdH6D2XXdV3Cddwe2eufrQ2E2ifC9jChEfjXCMBr8KhDdX
 E6K5I9TLexIORJh55YXnN0ymk7+qOjrXCnN3hyMNv2gYHXiEP4LFFQk7pLD3ihNQvPucc
 JM7MA7KTnEyh/CdIrJhhjkchE8m7UZy1Shg=

--9XM4yvikGjHjH9u9bryJ
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Kudo-san,

Sorry, I will be absent IRC meeting today.
SW Updates WG don't have any updates this week.

Thanks,
Suzuki

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of masashi.kudo@cybertrust.co.jp
> Sent: Thursday, September 24, 2020 9:59 AM
> To: cip-dev@lists.cip-project.org
> Subject: [cip-dev] CIP IRC weekly meeting today
>=20
> Hi all,
>=20
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today.
>=20
> *Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00
> starting from the first week of Apr. according to TSC meeting*
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&
> month=3D9&day=3D24&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=
=3D
> 37&p5=3D241&p6=3D248
>=20
> USWest	USEast	UK	DE	TW	JP
> 02:00	05:00	10:00	11:00	17:00	18:00
>=20
> Channel:
> * irc:chat.freenode.net:6667/cip
>=20
> Last meeting minutes:
> https://irclogs.baserock.org/meetings/cip/2020/09/cip.2020-09-17-09.00.lo=
g.
> html
>=20
> Agenda:
>=20
> * Action item
>   1. Combine root filesystem with kselftest binary - iwamatsu
>   2. Check whether CVE-2020-25284 needs to be backported to 4.4-rt -
> masashi910
>=20
> * Kernel maintenance updates
> * Kernel testing
> * Software update
> * CIP Security
> * AOB
>=20
> The meeting will take 30 min, although it can be extended to an hour if i=
t makes
> sense and those involved in the topics can stay. Otherwise, the topic wil=
l be
> taken offline or in the next meeting.
>=20
> Best regards,
> --
> M. Kudo
> Cybertrust Japan Co., Ltd.


--9XM4yvikGjHjH9u9bryJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5469): https://lists.cip-project.org/g/cip-dev/message=
/5469
Mute This Topic: https://lists.cip-project.org/mt/77048514/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--9XM4yvikGjHjH9u9bryJ--
