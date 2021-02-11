Return-Path: <SRS0=6m8J=HN=lists.cip-project.org=bounce+64572+6166+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC45C433E6
	for <cip-dev@archiver.kernel.org>; Thu, 11 Feb 2021 01:03:27 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC6564EC9
	for <cip-dev@archiver.kernel.org>; Thu, 11 Feb 2021 01:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC6564EC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6166+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BwNPYY4521723x71NsOoAA0a; Wed, 10 Feb 2021 17:03:25 -0800
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.53])
 by mx.groups.io with SMTP id smtpd.web09.2403.1613005403130359646
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Feb 2021 17:03:24 -0800
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id LJ6O31145A;
	Thu, 11 Feb 2021 09:58:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asu9y4CTpKdOJU8Hc2EbC0oe4g1pWeGMisxsJMPCGo869uaw3dMCbVbeLkzPIymzjCQYVrKcF7dz9EsOQ67jSluHwalShjzNGSpsJ3MXWpQ4eahc8+ljPb54d9tdz05xHT/M8Nh8BjN9IhupX7FcOzR/coQRqpiKHhKMUj5SPugeMpEeH9wCnVOmzXltnM9ff1+qrYjz/Itq4/Gao0eRYAcSWT+VvGOsorvRgJy4qWvJ0Y7OuCcF7n3K3zyEi4eCE7J7QXXyq7qsPt4sQDfS7LMZCiuQIPXZrhHxTPO6Qenea+lR4m9B25bDbGC9qCurKRiVm5JYSguAjKEctrUgpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvoIx6+kM1eDMpUrs6ZOfdu08zOfnUvxloW/0pqmZKY=;
 b=SdSLdWI3Ko/mKOMvKoZe0NHSXT4rZMb0uPmaEvOP7IFVdkuJCmJ5jKwD6vIi0n9k2GBRF/KSkwiqyJe9FVs9wN6UqLh/gXQfkhCZgBmUywK149AbNivS7g3hJaYAFI8tZwLvmAlKJ3E6t4QD/cuIi6aTZubqqLxL7RRJsm34E/EttOKn8lD4L1vOAfXvClfBPuY6G1naAQI0/qfWblYxFcGkW4yF7Moh6DMv54SBbEWkslN9OOhmLLjqhkFkxyNrSvYoW9x7lMZyaYjx5Nv1TpqJmdigTHcxOyfFpoX70cKbOtzYlH2xLParNJoAWpJG92jdcEZCEl/6j5bP3j7TpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB2560.jpnprd01.prod.outlook.com (2603:1096:404:8d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Thu, 11 Feb
 2021 00:58:09 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325%7]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 00:58:09 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdcAEM5xU8yiklH9RyqQBeyotJkafw==
Date: Thu, 11 Feb 2021 10:03:19 +0900
Message-ID: 
 <TY2PR01MB4972B6A2FC89273767335506A08C9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75ae8d17-57d3-4e11-cf28-08d8ce2819b7
x-ms-traffictypediagnostic: TYAPR01MB2560:
x-microsoft-antispam-prvs: 
 <TYAPR01MB2560DA976FB2277776B2AD59A08C9@TYAPR01MB2560.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 o1fO97IlgRaPEhSozQM14bOpYjWuvQErb5XSgrhGk4/FA9TDjbtvscFqNFFfrhmFoQcjq6lNvgZGWKkenWIhUc0QuZYqC8/PHe4JBNIG672/4NFdFXH9IHIarjLLwfZGBT1/n0QdZigxXCZ66JG78dUCZsux3myyDvmkjX92IksofYDznP6o0bG7Mt0eRNvgfdxiYWVLQepFXZR2kT/n0XWmKbbV6DjbqwrEiLxleQnTHiUNRjeJYCwEoJ5Pm6eFyB4OTN8xI+rSDMYutCW/aYRPp21Maz8ycOHzAueGNSyGtnp/mN79iQV2G3Yif+hWG1NtC2xIh4HQInBc0WMAQ3d04VsV0KxqfF2IvJ0JDqWDyxJASVES7JKmiEUzuGu5aeM2Zhyazp2vbUvbSmortZ+gmply5buFfRkffLKYRLCaVYqT4uk6iZjTv5XmaUy0jCiDG4ig2jv3P99cvh7Z7F1qemV0rVx9WWqzyJAP8rzgElBbhkdZN5YlJNYv9KXgdfHr6vqvrZ7/jK+TBC2IOfxlBYPIQ0m6Vp9iC8foVXjWThDkySR7HDvndMI81qBPIVQbUFGcMLQQvEPZnX8z8ee21IW/R22FMh/58vSFaic=
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?VzZLTktsZUdDOEpPbUtibDdzNGJmVi9BeTVXVWd4U1Z0dUQ1UUtlMmVu?=
 =?iso-2022-jp?B?aDdVNjFCK3lYUlFEdFpVckxTdjdiT0VSeWR1SHk1TUhuOWdVRmRpY0xv?=
 =?iso-2022-jp?B?bURiRnYxNldQZENoVzJYbWh5VGpRM0NqbFU0SzRWeXBjc1NkMURXQkwr?=
 =?iso-2022-jp?B?R0d5bWhaQ3JxWHpFL1lRUzBSMWh4Nk5Xdk1PeG5CQlZIZWszZTF4K2RT?=
 =?iso-2022-jp?B?d2Z0L1ZQdjJ6NlJiRUFJcmpLZ1laQ1VRaDlEZWRXd1NONGVURFdBTDEy?=
 =?iso-2022-jp?B?V1NqY2s5bVZOV0s3QzBpUFgvbTBHNSswdjJ6aTIvN1lwYStyR0tLQmcw?=
 =?iso-2022-jp?B?VjducUttUzlhOFovcnR1dDY2KzNrYXZIN3BkbHh0czQ2WmRldWZFbTZV?=
 =?iso-2022-jp?B?WjJIZEVsakFkemRhRmxZeW9sM3BSbS9jMGF0TmxSK1hMbFpJd05zK1pR?=
 =?iso-2022-jp?B?RXhobnFHTm5UWkFJWmdoSk8wc0pCYmh5RG02TVc2b0FFUHBSdDBHRnFW?=
 =?iso-2022-jp?B?M3RFWHlxaWxnbm5jNkxBcXJISklBV1J0SzRQL3ZvZnIwWkhWK2gyQ1ND?=
 =?iso-2022-jp?B?RStjdXF3WEdsSXA2aG5mWGxaWHlqMGZxTzkrai9LVnJ5bFJ3SmtqRnBJ?=
 =?iso-2022-jp?B?VU5SWVZOdFd2UTgyOG0wblpWVXovWTVrZ1RyUldmWHRRaE4xUVV3UTBF?=
 =?iso-2022-jp?B?QThXOTNyTEVWbVRjU2ZFSU9DNGxCK2N5MVJDOTJuWHBTa3dOck1DZUtM?=
 =?iso-2022-jp?B?UHI3d3BaZVcvTFY2VnNlbUwyTkxtdFBTTXYrSFNiOHprazAva05TTENs?=
 =?iso-2022-jp?B?MjFtWjg5d1NGdEVTWVJWMU9YUXpTWHh0VVhZM3g2VmJHYU15ODBJQmRs?=
 =?iso-2022-jp?B?cEYvUFdEM1dEYVNEQXE5U3dYaUxNNHFmVE1RczlONWpSN2MvK2ZtSkwx?=
 =?iso-2022-jp?B?aytMbUdlREM3WWw5YmxuN3hWZmZnUzFTTG5oa2orbGZ6dlNDTmdxc040?=
 =?iso-2022-jp?B?THBBSnMvVTQ0d05JWVFVN1dRQjk2a3Y5VytYdklLV2JwU3I4c3B2bGtN?=
 =?iso-2022-jp?B?bU9CNG5jaThvYXFLL052UWxkVkJJc1ovOStSZXpZdGFqMEVub1JtOHRz?=
 =?iso-2022-jp?B?S2NkRllSWDNIRDNrZUhRb1ZEV3hINExXalEzZHYvUjltWDJhZFJHbkxz?=
 =?iso-2022-jp?B?cmNsb1RTcGg3RkU4bjVxMUVqMldELzBjQjZ2ditRZW5KUjhxZmF3VDFB?=
 =?iso-2022-jp?B?eFZhbjY5RERwRlNocFF0WTdDRXFIU1g4cDF6YVJjUUltSGxCQ05EcG5k?=
 =?iso-2022-jp?B?d3p1alQvc3RlaEs4V2NuS1VCNjRtakY4dEowb3YycTh3cGhSL1RRbzUr?=
 =?iso-2022-jp?B?TDlyaFUvQVpsWHVHMnpxTXM2TFkrd211TzZvZE1LN3pGcHE5RUhjMDl3?=
 =?iso-2022-jp?B?VmVZbldSQjAwb1JqdGJySU1SM2t0amtvczMvbUhkaEdGdGgzdEUyVFZn?=
 =?iso-2022-jp?B?NjhoejVld2lQM3UvYUdPTHl2T1VLd1FTbWZMclhYanphMVlwSDIyc0lY?=
 =?iso-2022-jp?B?UE1JN2ZyZDBlc1VSN1BjN0I4ZU0zWjcvUW4wTGF6RVArZk5CZmFkL21Z?=
 =?iso-2022-jp?B?TzhldHc0bklySDNBbWZwQ3lsWk15Si9YUWVPVWY1TnNQdnU0SENiSEMr?=
 =?iso-2022-jp?B?cmcxUkxubThacXRTd1NJNHpyWnZvNGNwb2Vpd0ZuUjVQZnZvbi92TlJN?=
 =?iso-2022-jp?B?Vlg4SHZOTVI3OWZUWGZacGJwOXZLMGx5cW8zOEM0VStadzR5NnBUTHRm?=
 =?iso-2022-jp?B?TXpzbEJVM2JVT3lnV29IdWdzYUJuUm5HNGo5a0pEZTNHOGVscXE1YU9z?=
 =?iso-2022-jp?B?UFF0Vi9ybzVHK3VTcEMrQVJQd0NBazlEM2ZRV0tPYlJUMlFGdVVzbmE2?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ae8d17-57d3-4e11-cf28-08d8ce2819b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 00:58:09.7545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ab6Nj+Xreup6DM8cHXnwdm82xj4MNxkobuPjR57uKqnWCb9OqmgghYpntcswhEp98Ba9XQTjMRizH3AXe4f4Z6N3uamH+zUcyETS0cT/CKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2560
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wFw28xmsUTbLS2Fp6T1x21O7x4520388AA=
Content-Type: multipart/mixed; boundary="GAcxNmzt2Usqb7E0lAFr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613005405;
 bh=3odwhMYiznjkAqiCtpvyOn76IYPpKUAU8YhiYvy4G6Q=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=rWYmC9S1/z22pThPWdRsVSQgJG6SjdhWlk8NQZ3a7+/Ofxx0f0eH7iUggMqCppl5zgD
 d7p5NCsONMkSiqeYR2TS6jO8DFk7AHBW/SS4xby5s3w2UsBGEBxTqCd6butyJJiIwH9cu
 B92yRgLA9JU2r3goLwqV5bLx5Nbzd904AXk=

--GAcxNmzt2Usqb7E0lAFr
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D2&day=3D11&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
01:00	04:00	9:00	10:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/02/cip.2021-02-04-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc
  3. Check hitachi_omap defconfigs wrt CVE-2020-27820 [drm/nouveau UAF] - H=
itachi-team
  4. Track the CVE-2021-3347 patch status - Kernel Team

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


--GAcxNmzt2Usqb7E0lAFr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6166): https://lists.cip-project.org/g/cip-dev/message=
/6166
Mute This Topic: https://lists.cip-project.org/mt/80547932/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--GAcxNmzt2Usqb7E0lAFr--
