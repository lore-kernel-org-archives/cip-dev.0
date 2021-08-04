Return-Path: <SRS0=xAn+=M3=lists.cip-project.org=bounce+64572+6655+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2CFC4338F
	for <cip-dev@archiver.kernel.org>; Wed,  4 Aug 2021 22:37:42 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6795B61008
	for <cip-dev@archiver.kernel.org>; Wed,  4 Aug 2021 22:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6795B61008
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0ZFXYY4521723xWHLoXMYXy1; Wed, 04 Aug 2021 15:37:40 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.54])
 by mx.groups.io with SMTP id smtpd.web12.1457.1628116658141169061
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Aug 2021 15:37:39 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id FHfd25044A;
	Thu,  5 Aug 2021 07:31:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nW/9aokS+mhrd/3PAeHPl1fA+IIsqQAkk4kcnNNEC3ji2yVlybIcx9kme7SE2Yt3H9PV7Khqzxs+Xwq+hk3S0BeHwr9cBJGopz0WFxE0R0jlgk3BgFl2Q85iKBMDcTCXKaBrETUHxPQW2Dwi9IwveeOf2UI7RD+0TFICRJKhHiLKrcJEjTSJWzGDjZJF9TuxFwOah/ZZG+ebDh+KLLFeeZq0+Oc2EssadxUzP3VE9pEhqdxBLriyPhnf4rh6kRyveefR0x1v1iP3zuhq8Ub9eY/JzKQCRwOaBF6J4+uQSxDYKLtSfI29lz7OHO1TOiCTUdgHjJWn6iUwyj39VMH5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7Lu3ayjxZyVw6b5HdJnV3GuJl/q+Ome++3W3+EmyRk=;
 b=L8Wxoao214iYFYwS4d73P6HatDYbkvuByS3twDf+3vmkmNnL3QjJ0hAU5GVRmmoc7A8JC4kEwtqwhxRgJYWw4RALpWINj14CeAQXP26ayUp5Of9i4p+jXDOAlqk+31R4d4BM1ArJ889MxDYIpOPMykoS2pYgOmYPwXddmB5DvU/6lF7MKBa8wkJ0SVTV1y8XyGsQsDaegMp8VZ5dy4/vT3mKQ+Dr1lVi/ozhJlwS48SI8a+YB/vkuyTgXgN3EklMwpAavqTyeNnhRzJRT5W9m8ds3HphKU9jWD3mhxuXDOU6EWMM1yNi6Dx8SoOw/6gbN4WIVSF+cz9AzQgahswB4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYCPR01MB6445.jpnprd01.prod.outlook.com (2603:1096:400:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Wed, 4 Aug
 2021 22:31:24 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913%4]) with mapi id 15.20.4394.017; Wed, 4 Aug 2021
 22:31:24 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: CIP IRC weekly meeting today on libera.chat
Thread-Index: AdeJgFdV8AKdhtA3RFK6gwc2hMtFAw==
Date: Thu,  5 Aug 2021 07:37:32 +0900
Message-ID: 
 <TY2PR01MB4972503FA6AE6F0FE4A7625BA0F19@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94ac38e4-b7f8-4dea-5d3a-08d957979770
x-ms-traffictypediagnostic: TYCPR01MB6445:
x-microsoft-antispam-prvs: 
 <TYCPR01MB64459520971071C790132BB6A0F19@TYCPR01MB6445.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 
 sF9egi1Pf8gvgiXOlGarxLStYNSIeeSX9PXNU73CPSRYbdXq/4KluTqsPin8r6S7oYYA1E8MK2cvX9jxrwmnpEDqiwPGQmpOGJuoN61o8kHyNS0RON+j/avOaLT6kA5U+j0TU0ySWGMAzREpNA6HReDfO3BZnlmPNHSvPyWSB8TPUZPyhXTW8JPisfxGEFIfMeAJ3LVNAYSN/dc9bG5XvNDGBjP3hm8NgQ1aVPtsYgPqGKsnIEJ/cTmAKLOGByw4FgsTs2gu0ieurh9hdguuciSYhM6Xn7X9M3idwhi1b/rQYQ7KQOgCeJs0SdZkyYYWPBb1nDVIimgteQ5Xj15op2wuoZQQuodEu2q3X9BhNBsAIiMpOjtmH2+ZF91FA1MzHHzX9x9ndRY4p2u5nBuzuTZZNsKGkerOQkCkQa1E0Js+6i1AyDy5FVXsjvgi/XfL3XyBa0UuN5gpYree7P49PzLLGOdkO/K2kZ4KRCK3MYv3LJuHaZyWbE6dSa0otgWiQZOy3+ydwe69dNA+XRaFklBRuavoiadXrX6m27i6ppDSaWrBLN6hfNzQxalExzBSxEVVdbUjhyJqIQxhp4AJBg2QdqGUtNks2/YMlgSlDhaDGdd2ltN9aucT/ZSeohHddb5Xc+KTIYsYlcJKjAJR0Cpf/Tvgk5J++OTH5+VXlNZS9ySWT6VdR3tTqA3l54oYfrHLNzOvioKDBjixKO8n6nBXv5dEHJD0mLKVRqCUvV0sA/912cReC5ID54N1g9OUt0xZMS75rm0czgkaZq3gNj298HHCpbjJ3E/yxGs7+cEDYQUggm+z6bGpkhVNaupTfIu7jXOWAgfZIUHEUEAh7dpn8w1AJ/rMm6/0+Qw8J18=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?b2lYcWplRTBZcGZ5SUJ3eGhWNng1QlZydGt2OGtVWUZMditRWkFvcG1v?=
 =?iso-2022-jp?B?d2hOM0hGMWZLSE05NG9TQTVEakpGUDY5TEgvelVuT2V4ZEh2bDJFbHhL?=
 =?iso-2022-jp?B?ZTd4V0orWUFObTAyVXNoaG1iZCtINFQrYmJ1NSt5VUtUUmZUakcyRnUy?=
 =?iso-2022-jp?B?LzhUd1pZK0ZHYld3eE4wOHNVUnB6M0dpOXM1Mll5Z0hKOXEvaXp3ekxO?=
 =?iso-2022-jp?B?SU9ENU9lamZoWmp2clJpblp3OWRNMW01bjdibElYcnlFM2NvenM3bUVr?=
 =?iso-2022-jp?B?cGJqaDFMcW41NWRvd1VJdTBiU0R0ZFYxQkVnUjJITzRMMmdxbk93a0tV?=
 =?iso-2022-jp?B?ZWY5QUFVSjZoQ0poc1lDTWJlcEVvRUVYSTVoaXNLaDJTeXoxUmZNVjNa?=
 =?iso-2022-jp?B?QkF1djJOa3BMUlcrQlZLcTgvYlZvNEpCejJtYUhOK2dXMzY1UFVjeFZI?=
 =?iso-2022-jp?B?Y09OdWpJc1ozT2hOYXZkU2YybFUzMG14TU1MYm5VVUNMN08xbkhVa1JS?=
 =?iso-2022-jp?B?Q0lBbFYzU0JtUDVuWWpqVkNONS9YYkxjZW85SXM0T1FpUjNSdG1EK1V3?=
 =?iso-2022-jp?B?T1VPM3ZucXhaOHJ4VlE0SGFrN08yK1N1ZWpNeU03b2gvUWk4OVZwak9H?=
 =?iso-2022-jp?B?ampORFhzTVd5UnZ5NVZUYzdDWGdCcmt5amF6eUY4M0lTQWNwZFVBZ1Js?=
 =?iso-2022-jp?B?djl5WWdGRXI4dXJqUGlqU0VSL0NCbWR0em4xd0RKSkdpdnA1Y05oVkhj?=
 =?iso-2022-jp?B?WWh2Yjc5VG9rUnZDTEc0SURPSnl1cjFqRjYyNStHUEtzMEFCRm9YQkpS?=
 =?iso-2022-jp?B?dDdOcDJpYjhka3BsQXo2UUtPNlFsK29sZlZtYlQ5eG5uVlhpNWpXeHBD?=
 =?iso-2022-jp?B?SDJaNW1hZlQ5OEFBUGNEbDUxVFBuZ1RyR0ovekdJRGdRRTJwR1lvczEv?=
 =?iso-2022-jp?B?ZjFwVHRhL24xb1RGMVovOTBLaTVBWTVkQnRTcjhudkUzTkhzK0pyc08r?=
 =?iso-2022-jp?B?bU45UVRjSmRPMytqOUdicUxTTEI3bnZuOWZuc1BDd1BWVUh3dWlGK2Fv?=
 =?iso-2022-jp?B?TEVYVTE0MHM3ejJwUEZFWWVUNDFXOFo1K3hVVFZIaVZIMGhkMldES0R4?=
 =?iso-2022-jp?B?WFhHbmxjd25UZmwyUlJkc3Q1RHh2eXNLQmRDZEI4N2tHUlJrSElGQzZD?=
 =?iso-2022-jp?B?VFhjYjJ5ZzhRSnh0VUZLVk9vQTM2WWpaZ25BSENrVDNNcmxndWk5dy92?=
 =?iso-2022-jp?B?alg4bE8xT0RrdDREUVpWcVNGclVHellmSm9TQmhUN2FsRlZFUHJkdCtE?=
 =?iso-2022-jp?B?ODM5VWJPalFUaEx6cmdTME9GNEUrMnc4REw0cWRwZGR5WWx6VmFrV1FU?=
 =?iso-2022-jp?B?TThyYW1UeWdnM0FkYkI4QVFLVXlPUTdBdFBKNzJ3dGlXOGJnV1ViNzla?=
 =?iso-2022-jp?B?Ym9kZDdhVHE0QXdiOXJoU0hoWUlJaDJFZjd1MUxPMkxxaFgwYlJ0ZDNZ?=
 =?iso-2022-jp?B?UnkvUGFHaC8wY001Vnc5aitqeXY0WjVpNGF1ZkJtQnRsRW1pcFI3K0px?=
 =?iso-2022-jp?B?QlRZMTNVMW5YalRrWkt5ZmRVWUd6NFgwYlRsb0p5SWIrVG9pWmRHV0Mz?=
 =?iso-2022-jp?B?Q3NnNXJsNTRXS1g1eEFYR00rZXo5d1libnpFN2dCeCsrRDVIV3c3T3Nz?=
 =?iso-2022-jp?B?UkF1WjNlY1VaQ3lML2ZoZUZqblRBcEYxKzVjMk9rbGtscldka2hXOUt2?=
 =?iso-2022-jp?B?cWdFMjZZTEhuRkhoZ2FOa0NYdDNuN1hNNXh0ZnZKV21IclA0WE1ZbEF0?=
 =?iso-2022-jp?B?SEZiTzNQd1hvMEpYdllNdzBRbTRWSDNENU9MUHJpOFpPUlBIa092TWRh?=
 =?iso-2022-jp?B?dHE2OTIxWkF6ZjVPbXh4ZjdEdHJxVTVTdHM2VWkwN3ExdDJwTG5iaE9O?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ac38e4-b7f8-4dea-5d3a-08d957979770
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 22:31:24.1437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K+FuMF93Y71fW5Tr/j8HBZetUsKvKHLJO+emCWmJ8guIVvuof/35tk5sJafRgzZOAuTrDzxrauooyd0SCkiac7DgjK3XUSplTByt83Gk+VI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6445
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: LvyDn7VbQsdEJUiZqBHMQKvzx4520388AA=
Content-Type: multipart/mixed; boundary="ggE8ZUxR9uQkBeJ5yOfE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628116660;
 bh=z4fZcA8ga/FVvl1aE/kfZ06JQzjKZdEGWESispBy9WU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=HH5XVQfpUfSgxRI2dI64QRbVvTntUF7WjLYnaEEiJi55UIGUkPbkprI8mJS9ezLjFYt
 hpDEc6kQzUjRAdPPB5Oj/dGbdZF46PQKvUc/cWCr34eEDktiy6Tfc/Fj6hVXjwyF+qA4n
 0dTMIQHkkpQ13iCIYKZYoF+kl0bQrRnPfWM=

--ggE8ZUxR9uQkBeJ5yOfE
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

Please note that we already moved from Freenode to libera.chat, and our cha=
nnel is the following:
	irc:irc.libera.chat:6667/cip

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D8&day=3D5&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p=
5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00


Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/07/cip.2021-07-29-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu & alicef
  2. Do some experiment to lower burdens on CI - patersonc

* Kernel maintenance updates
* Kernel testing
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

--ggE8ZUxR9uQkBeJ5yOfE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6655): https://lists.cip-project.org/g/cip-dev/message=
/6655
Mute This Topic: https://lists.cip-project.org/mt/84673602/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ggE8ZUxR9uQkBeJ5yOfE--
