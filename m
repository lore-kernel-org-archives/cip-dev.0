Return-Path: <SRS0=g60j=GY=lists.cip-project.org=bounce+64572+6121+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D3AC433E0
	for <cip-dev@archiver.kernel.org>; Thu, 21 Jan 2021 01:22:49 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 661A623888
	for <cip-dev@archiver.kernel.org>; Thu, 21 Jan 2021 01:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661A623888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6121+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nKvFYY4521723x4VrePMBFAr; Wed, 20 Jan 2021 17:22:47 -0800
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.125])
 by mx.groups.io with SMTP id smtpd.web11.800.1611192166154965475
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Jan 2021 17:22:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVWq1ajvvQnzcXE2nJA0/AisYqOH3JnWMaq2JCgv3oUtSxgb2q5dD7Ao3nVuDIJFkhQ19ZpdtvxBy5tVdyGZEmsFr1FcP0mwsQaKzFiTr5ft/b3PMbvrZbfySjsuyp23BZyGoBblk2aVX5S7E2RANEegkIVHXM1fnU3WzIc4jtFmUGXebgPw2YcmAH4zeVBAgzOqRb+QbvMZ9oq+Bk3Veqfhm2etP9JDB+kN0V8Kns1DhVgRwDz0f1ozzyPxac1biY+byqBBy3ZqWRjx2V7X/rBWol7kk9wkculn3kmrPyW+QQboYSrbs6cQ3nnUpTeLMnTQzIfnnyJ4BAL3bSi5Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZTE22fAzfpu7B22A6uDV5AL87qgBZnTy5uCVgfcjek=;
 b=giWqKyI/E1lW8lKQksTtrYY0Kwu/zqsUC2RrIeAe0daN5idkrvPRrj0dBWvntP4dlWiZoTWKy38+IVaisbxq9GVZjHPxWZiqP2hB2QjbAHeywp/69FhR17NWwtK5Y0k4LeGFWaxAMqUTUomPiZKQLdGGz0aVV50Y99SwdFE5CYfr0spPbGyJMk6w+uX7JKeGO73vWDajeV1jxcoYdRDal26ds4GYSDAgytoPVcDMj4KAnkGizP83xO+Lb3news0DvP3OUbLY2GhOzuLHGVpZHwrKOGcT2E7lzvisbL7wsUKKK52JMK4C0sqy4qxqru5o9G1GXS9OtixOqhYpMqguJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB4396.jpnprd01.prod.outlook.com (2603:1096:404:113::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Thu, 21 Jan
 2021 01:22:38 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::a980:35c2:4282:b23f]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::a980:35c2:4282:b23f%4]) with mapi id 15.20.3763.015; Thu, 21 Jan 2021
 01:22:38 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: Adbvk9JVW1w2dVc9QxSCh5YNHy+VaA==
Date: Thu, 21 Jan 2021 01:22:37 +0000
Message-ID: 
 <TY2PR01MB497266C89234AEF0BB171F6FA0A10@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d6aad69-39af-4be3-22a8-08d8bdab0a30
x-ms-traffictypediagnostic: TY2PR01MB4396:
x-microsoft-antispam-prvs: 
 <TY2PR01MB439640D90730E9B91F1B047BA0A10@TY2PR01MB4396.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 MljzjAC6r3pyC7T8wcsD5RE0C1I47ABa1WxSmcQRO3Boc5XtAMiLR/i8cgxNVPcPeXrhhSY8OaQLiT+2BBVRONVC5XYlBfGCx2v+yPPj3w2w9BWjIAEwqdieXhPIiLRPqQbnm8yK2QvZEwMWpXB0w5vmqW3Yji3Tt/VYFODdirIV+MPEVuVwIW/3pSJLASb/dNC0zgvm6c/vUzkMFDOi07ahSxfPz9emPjJi+/CSc1evxQskZ3jYbUK7u/SWNGfg8THzPYDSff28+ABMGnFtsUMEtvPylzdF0d7YOT5QRc7jYdPgSSmfWb1NOecV/wh8k3O64CcaVLacGPlbgM1ILr8GApp194eD6/zWY1hKDO1VJrp06WUA8hpfnnEr5LmUXVnQZ0bXQrpiJjFNTKY158bdYpiyntQWuyHDn59c5FydweoKKMTjBrZmRtegoMqIme8GZwcPWzujwqQy0BIEEg==
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?blhQcTdWcnRaQmhyYW9hMlpnZjY5a3hyYkVMTDJHaElJU0diMlJyMzFx?=
 =?iso-2022-jp?B?enFwQjRpMi9HZ3FXQ29Ma2d6MG94QUpQeDN3cGVubzRJLzVUYXJTM01E?=
 =?iso-2022-jp?B?bk1jS0FNYk9YZStOSXdmWW5tbEdsMHBRMzUwK2dvMEVrWHFrcTZBSDdL?=
 =?iso-2022-jp?B?WlZJRzFpM0VYN0Z6bHFTS3VXaHlLd2MyUEgxVGk0d3hEQlA4MGlnbSt1?=
 =?iso-2022-jp?B?M0N2YWxLTmlodEVlbXAwVUpYUkJsZUZSbGEvRW9oR0xYSjdOOHpONGp4?=
 =?iso-2022-jp?B?VGg1anpVNUNPZThoaEp3R1lQYnU1aWE0eUlCTFhlL0FPaFgwUmtZN0F3?=
 =?iso-2022-jp?B?MFkrT1pjQTdOU1M3R3QzSkZuUGtaMUthaTUrd202ZGwyaFRsTWZRSHps?=
 =?iso-2022-jp?B?RGFpN0hDbm9KRDVFbjRBL3RMZEJzbjFxMXFsVHBUWng3K0J3dDNHcU1z?=
 =?iso-2022-jp?B?a3BJU29vVkk5c0hBUjJ5K0NUT3JGdDdsU3BTcExvcWlGSWI5dnpTeEpp?=
 =?iso-2022-jp?B?aWNtSlJTblYzSUhaYkhSN2k4dldhd3BJejRwOFI4RVVsUERTeHBjK3JF?=
 =?iso-2022-jp?B?RUhYRkQrTHpEKzFTci94N3Jad1Z5enJGeGdteGJ3WXIyMzk0ejR3WWVw?=
 =?iso-2022-jp?B?bHdjMkM4cWdBeGF5NlVEekE0VitDK2ZrWmluZVRpVWhHdmVuQmxoZDV2?=
 =?iso-2022-jp?B?NkxEem5mdHQ1cHY0VlNaUHNHcFAvcGxPdkJuKzJ1OWk5N1VzZTExR24v?=
 =?iso-2022-jp?B?Ym8zZEx3MjhNSkgxdHE3MHRIaXc5b0kzUmtrWnlRN3cvRmRRaDZUSjht?=
 =?iso-2022-jp?B?WGs3MlRzZnUyd3VNMDgxelQ0SnE0NDhqbTN1TzUvT2NNdHh2bldQUWcz?=
 =?iso-2022-jp?B?YTE1OEVVcjdYTjRjUVgxVTErQ1JUNGs0R1NtK3k5UktWZ2lMQkJWcGdI?=
 =?iso-2022-jp?B?b3VPaUppNkx4anpRQmozODF2b29PUkJ0UlNocXZSZVVJSHpMSlhTaGVN?=
 =?iso-2022-jp?B?U2RHbzc5dldKMDRZQzErRTNKMGpkUVphWktmK0xycm5JbWRnd01jdVQ2?=
 =?iso-2022-jp?B?ckFiQ0d2Wk81ZzVFa3BvajJKNktjUXpNYklzaTFaN0ltZkRUUDY1MjdC?=
 =?iso-2022-jp?B?aUlXZWNKUEZIYXRMMnhaVGRNZ01xZGVnNDJBRURwZzArdXQ3ZVRiMER3?=
 =?iso-2022-jp?B?cU1xbHZrakNSYk03aE5HeDJBdGRvb0FaYTAwaHF5enJhN1hrQ1ZucnJK?=
 =?iso-2022-jp?B?WFR4cldMNzBFQ09VbFFWUDY0R25IOVV6S2hkZ1ROcWd4NUxPb2Uvc2dI?=
 =?iso-2022-jp?B?MGloRi8razAvZWdLNDBodEluekJ2OGlVNU9GaWZTZ01BL2xmMFlSVmsr?=
 =?iso-2022-jp?B?UTlsTUdySUp3YWJSMitsWVg0NURleTVManpxMXdnaDlhQUNCRT0=?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6aad69-39af-4be3-22a8-08d8bdab0a30
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 01:22:38.0399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lyIwL7vZ5D20xPL4GzxSTxP5qaS+OfsYYXHBuoJ1MT2DlIi3/48XA0laiKsPY/KwmeE2danhvaZcx085m87jj85JIrdfTihTi/R2Pf+Wd9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4396
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WF1uQh6c8iUGBWZA7tvWAL8Jx4520388AA=
Content-Type: multipart/mixed; boundary="vlnNOxnZU2SCj3DG9ThD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611192167;
 bh=x9whQL1+dL35K/tjAO/Vh8nEyHSmJjDBvYnO/v165Ig=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ZG/0hYqrtWHQAeD8Jre6ea7EZ1BWUlXDJ9yzg/JZugOaS5R8oLUY1/mcDOrfE+lD0Xz
 F66e+2eyMJWZ+RyCtGtFNI/b6lPfaH/KTeIssqkyIhpcyklTvgNVoWIYOeq4U2Fu1Vk6Z
 ksxAjFGIZK4rPCsvbT5NsWJllRw3yr+rMV8=

--vlnNOxnZU2SCj3DG9ThD
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D1&day=3D21&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
01:00	04:00	9:00	10:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/01/cip.2021-01-14-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc
  3. Check hitachi_omap defconfigs wrt CVE-2020-27820 [drm/nouveau UAF] - H=
itachi-team
  4. Decide the timing to branch 5.10 to start CIP development - Kernel Tea=
m

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

--vlnNOxnZU2SCj3DG9ThD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6121): https://lists.cip-project.org/g/cip-dev/message=
/6121
Mute This Topic: https://lists.cip-project.org/mt/79994083/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--vlnNOxnZU2SCj3DG9ThD--
