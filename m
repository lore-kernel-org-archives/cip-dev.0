Return-Path: <SRS0=crN1=IC=lists.cip-project.org=bounce+64572+6206+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83E2C433DB
	for <cip-dev@archiver.kernel.org>; Thu,  4 Mar 2021 02:03:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F2565056
	for <cip-dev@archiver.kernel.org>; Thu,  4 Mar 2021 02:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F2565056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6206+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MjJoYY4521723xp9yPkL4Z7F; Wed, 03 Mar 2021 18:03:05 -0800
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.53])
 by mx.groups.io with SMTP id smtpd.web08.1034.1614823383324792009
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Mar 2021 18:03:04 -0800
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id EK5L21220A;
	Thu,  4 Mar 2021 10:57:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVgI3blXwlrtpa4pQnwYKSkjjDR7YOpJfge+Ddicvo6x3pFXaM57FPnJr9xwy/xYLznvlQj/LiKmoUg+iiklE3OJu3+MyKxiID23OHf3yWpaP5UazIt+pVvxKWvRCx/pUcR4Z6oZsppkzKCD/OrBJ0pEIQfN9nDXEEeWNM26J2DOS9+Zru8BH+sxdARRH1XkDAnawVtUbEQUBIUz6bO8pG9o0JBVHIwRsrTxikV314cWDgXFJQDTzis3AHa4k16D0in8k4NMO35C1D2QIPxongHt6htisSdNpyPHK4LVI/yL6wW8FKNhifcG8PjTdc+CH4c+YnCnWiGxlu3tBUc3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r04W0A/4SWF3uUWo8jO8bCvt85ZQCOfa6CKGEjdVcls=;
 b=O8O2O6frcLDYRCxVWbZ71Co05O5Fkk/7jCif1oeCi8FuSyU9G+T553zZOl4AlIesKruypJNS/9iesGtM/IfxHhPdLnEu2UDMbCcTAcVexQjc6hU3FmibvFGZjAbfFKkr0LY0nD5Z2xo9NAs/1t9DStiX+yayIX38l679Gyivr3zBk06ysEtzL6iENUd1tfd3VPiJ8Y7MX4QwSNz4l9Fm7nWkg4nnO9f1+Di+GY0uz+6RuhR8ZhiQ+B1zh5VBS+6NRtRsOKCW0BgZhqk6xoNgYJFoa4gEuIwiBZIzGgjQ4PeGR4gS7MDfmC4GU5pay22sJNWwDuQxhwxyaNFiccGbqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYXPR01MB1695.jpnprd01.prod.outlook.com (2603:1096:403:f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 4 Mar
 2021 01:56:55 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325%7]) with mapi id 15.20.3912.017; Thu, 4 Mar 2021
 01:56:55 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdcQmYEPEy3OeMlZQxGAGMRFX3eXqw==
Date: Thu,  4 Mar 2021 11:03:00 +0900
Message-ID: 
 <TY2PR01MB4972C8CDE610293B2488776AA0979@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1a81427-f433-41a7-7d07-08d8deb0ca13
x-ms-traffictypediagnostic: TYXPR01MB1695:
x-microsoft-antispam-prvs: 
 <TYXPR01MB1695BB0C84D4E16AAC248EBDA0979@TYXPR01MB1695.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 fw5GJ2yRpkdQzDz1WcYa5Hn8LYljphxDLbFPo2jAcRy1OJEUSM39fDphK906IKP7J5RzqHwoPd7J5y8BPCUYN51SkqZTHPi+FaZeRW/z7KlbkkBxD5sWjtk3jNEdVzgLcPPm0SlOb2gjTxTblL2cEdveANcx/GSOS+76b6s1h3s9agiRE85rV52FYObSy2fwjvIxNvgUWizcp9ScyJzMX2uxESxRgJ9kdrNxr3iFiU318xoicDxPFh1EVP8Y/r91yewLl2ZNlGWWJcAskbm4GXQ0drv0TsjRV5vYBIqQ2fyrfNjwqrZghx4ucU810EfPTSlBG8+jTqfIdnvXkzU12SrEFfWvICUM0tJtOSOBfDuQBtgDLjxvV9tuCAYFNpXTi4hE/R0OCY3L2RmZk/7CwQi4N5vLPKj9tZF2J9l0Y8DrJOl7qDo32Yl2TEXP2RC5i28p19oRz1Yub79/7hzxzdaUpFcohHqfSqX/zU8Kbah3PLQJoqlbqdhEPG5Ibr+rQUGMHdVBbYZgDbV7B364nJTCN7e5VSD/AoFljkeIXN9IbBSWi99xsIeov09W5ApSYU5EyYaxb37cBji2lOXxlWHGpEBUV+XAcurCnboH7xU=
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?YiszV2dTdjkwbFV5d3ZKNWk1c0ZQRm5Xd25yby9KdytaUkFKUHVjd3l6?=
 =?iso-2022-jp?B?QmtwSXJsLzBzQWNVYXVjU1A5Qzd2M3Y3R252TGpNMlhXdk9pakhmd2Mv?=
 =?iso-2022-jp?B?Q1RHWXcwQWhYUmk0bEtjYzA4S3hqODNENzVTSVhaUGIxNWhZaU1seFI0?=
 =?iso-2022-jp?B?L2xESGNUTzVqZW5hY1hoTGxlbHliRWU0Z1pZT1RpWDRZaGQxcHYwemY1?=
 =?iso-2022-jp?B?ZkVpQXZJUFArTUhobjNVSnNSb0pHaGdpdzhsdUxsRzZKQ0pFVkt3K1Uw?=
 =?iso-2022-jp?B?RjJyQzFpMHFoY2ZRdXpqMVJrY0tsb1VzU2EvTi9CdERZNGhjZUFLTkNr?=
 =?iso-2022-jp?B?QlQ2a1ZFZkwwYzhCMGhnM0x4dDB0M0xicW1QS2RZQjV0cmxtRERIOHdI?=
 =?iso-2022-jp?B?UCtJMXBVRmhYZ09Rd2lIWWl0bHNSMjNZMUxDRENxaHplUC9PZkhLVDUv?=
 =?iso-2022-jp?B?cnRTMzQrQXFyL0IwUDRsMVgxMHB0RnVGSmpnRTNKWGNJcHUxUEdCS3Ay?=
 =?iso-2022-jp?B?dGFnK1N6dEhLU0ZrQ2ZLeTgzNHVUOURodUsrbDk0dGxPN2JKVUErSmNt?=
 =?iso-2022-jp?B?ODlVaW9vVkl1N0puL2hleVF5SlpwcWdUdERGMGQ3aVcwSWNPYkZJb3JM?=
 =?iso-2022-jp?B?K0dlaVdydjVHczRRVkRSM2QwOXFvS3l4L3B4UytnY3QzcnExaGY4K053?=
 =?iso-2022-jp?B?Ynl3Y0Zsc0poV3ZkNGIzaXhzdTFIcVQ5NnhjZjgvVnhmNFBuQ1dVNmNt?=
 =?iso-2022-jp?B?ZnAxblo2aVR2L24wYmpXMWJLWGI2MzgwejRDb3ZiTy9BaEpiRUVEMVBI?=
 =?iso-2022-jp?B?Y3Z5VTRibmF5N3hlYmg4VWgvclk3MkpGeU1HSW1qR3lzQllFVFBEelRv?=
 =?iso-2022-jp?B?c3dFMXBMV3R4U2hPdTc2bUFDa2FKYWVpNEpQd3JDaFZJc0g2MWZ3Ylhy?=
 =?iso-2022-jp?B?ZVFYdUtyanM5QnhVSmVJT202UkRYbmU2V3piYVoyR3pNV21lcVFHWXFI?=
 =?iso-2022-jp?B?MVhEY09sR2NhZHV0cUh6RWVXVkVXWkN3U3FiQkRJRW9kazBydW5lRlY3?=
 =?iso-2022-jp?B?VG00SVlSMG5JRVRJTlluak1zUjM5TTRuWitCT3RXS0piZ1lMRVEwYmJs?=
 =?iso-2022-jp?B?YlVKNUJicXgwS29TSFAvcmt6R3hUTm9yeUYyWTdubTE3ZGt5SGxhOEhj?=
 =?iso-2022-jp?B?aGgzWjY4TG8zT0hHLzhsNk1lYWIxcUNmdVJjSjMzZHpKbkg5VmU2dWpC?=
 =?iso-2022-jp?B?VHkzbDdab0tIZ3M2VlZWdGNIOVlkbnhyQWFnS01XUkZlY2xwby8yVHRC?=
 =?iso-2022-jp?B?aHFoZ05DdEdOZ2JDNlJubFlEWER3eitVSDNSOE91Sld5Y3dMR2ZyMTFk?=
 =?iso-2022-jp?B?RUM4UE51bUVhajVtWnpzMGlVUWhzQkZTNU84QW9pUzM3S1NrUXJLY29H?=
 =?iso-2022-jp?B?WkhDOXRvY0NTby91WkRrSUs0aTdMbUErL3d1QlAvR1NseFg5bFVFV3lv?=
 =?iso-2022-jp?B?a05XUndLQmloUmxpRUZUSnhMQkZNSnp2UFgwYWFwalBBVHgrU0cxR0xO?=
 =?iso-2022-jp?B?UXR1UDEycFJqdTcrVlhLa0ppME9Rc3FRQW9yMG9hS0VzZTdrYklXNHZx?=
 =?iso-2022-jp?B?TjlIZFhDL1Baa2kvZzdqaTdnbFVZV0dJaVhsTTVsV0NaUytSZFNCV01q?=
 =?iso-2022-jp?B?TnNGanBxTHoweHNRMmpIY1lyNUdIL2krK1FsRWEwc3VJRmg3MEZodE9l?=
 =?iso-2022-jp?B?UW5hYWU5ajNyYU1UODNBNUUxN3ROckxVOUFzRXJLa0FBMHhuMXJqNHMw?=
 =?iso-2022-jp?B?S3Z1VFlCQUphbWgveW1nS3hPYVJTY0ZNaHU2SkhmbVNPNTVueVAwN2F3?=
 =?iso-2022-jp?B?RzlkU3dIVU1Dc0diM1pveGZsb1l2bVRtUkxEa3QvRGJMMm90cG5UTS9W?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a81427-f433-41a7-7d07-08d8deb0ca13
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 01:56:55.8370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q38piHhm8PsoGAimuby+y636a7KTBSfraJLUJunsfWSH7U/NeAihi4pCJ4992GfDLW7p9y/Ig5lVGWinD0KGkGYgW0m1ZnqiquBLC84PbSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1695
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Q1ofXa44ce1Nnss9rx5e6ukDx4520388AA=
Content-Type: multipart/mixed; boundary="1BezmL83fR3SxiolP6zg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614823385;
 bh=xHjm5vbFQ96RLaN3DoMDHo/1C9TdlOXw6BEj3uaHfEE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Wk03TTjMwozBMkx2e5YBcaC5NY3C2DDZeLh0729webt8TZe8u5IO1wfA7aOZT303rOe
 3N7bTgjjmUFPy789QkxiOA8uS8T4lM51laK/+ZLUd/Q2Zb+caYThu9BH7OgHfRGtBtp5Z
 8UfMMov5za02GRYQvsLvkmcdjocgU/gjusM=

--1BezmL83fR3SxiolP6zg
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D3&day=3D4&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p=
5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
01:00	04:00	9:00	10:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/02/cip.2021-02-25-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc
  3. Check hitachi_omap defconfigs wrt CVE-2020-27820 [drm/nouveau UAF] - H=
itachi-team

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

--1BezmL83fR3SxiolP6zg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6206): https://lists.cip-project.org/g/cip-dev/message=
/6206
Mute This Topic: https://lists.cip-project.org/mt/81068407/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--1BezmL83fR3SxiolP6zg--
