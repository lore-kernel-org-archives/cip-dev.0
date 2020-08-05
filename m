Return-Path: <SRS0=s/Fx=BP=lists.cip-project.org=bounce+64572+5102+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185CFC433DF
	for <cip-dev@archiver.kernel.org>; Wed,  5 Aug 2020 23:51:23 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A9C21D95
	for <cip-dev@archiver.kernel.org>; Wed,  5 Aug 2020 23:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pvT9yefe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A9C21D95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5102+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id R6T7YY4521723xDQYD3YRDeQ; Wed, 05 Aug 2020 16:51:21 -0700
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.134])
 by mx.groups.io with SMTP id smtpd.web10.2713.1596671479359660514
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Aug 2020 16:51:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdErq+XfSiSgf7ZaU/WuoWuM8sVxNLSW/36pu2SOaoRG4uO11zInuKdg33/eBe+xkMCoFhjm2n3SNXSHimOqWLAokHqbelHNtWn2MMFszQJ0rm8Pa3O+pXai8IMJAryD9PiD93Z9s1/1z4ftwqrW2QLqCOA8A0IyFnObta/J6UlJNN2NuZSaqQtURQ+n1Du6DFWRx+uF5Cl/+FltPAAqknPC8YVePOa3mIqkg7s0FLMSRYAXzHwcTG2ZcqUwrZMFdorA9EkBjYJdq76Aab9oy3t0BfH0+rKzh6qM6VjvSd7P9S6NflMRV251pcvqDJWw/+5HVJtL+wEgpRjx9cQwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPz1XXxpDb0yuR/+urrMrd/W06nrOw5ymHsoSo/3s8c=;
 b=nLkphRDnFNqWT9pD3Sl4BFf53qmtcme1h5eBveTF5W9Kx1GKZQCsDtDAtop+P/4dfw5N6pCzFOVEPrBQyd4m3k/9SiOuXd0u0UaHOk+WU39PtvM+V/SS9FYY0U/42lOnNFOnNiDS5dS5STCtvI1vcgUBESIuYG3OENciv3xH5uPU7EykhE/z8YC4klRgoPn1o3WRj5wWi600OGjBK06i1hengZQYbJqJdEouxvb1EO+hV2mR4UVGCRzoLjXFYb/PmDgJ3PXjFqECOTxA6X4yXF+fBt/FzKB6dTddl2zbrrbQiWq+WMzuBIYJy25YiDnJVDE1X19YKqVozyL7dnKG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB4810.jpnprd01.prod.outlook.com (2603:1096:404:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Wed, 5 Aug
 2020 23:51:10 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20%3]) with mapi id 15.20.3261.019; Wed, 5 Aug 2020
 23:51:10 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdZrg0gU8V9oy5dKRZSf58YyOjpD/w==
Date: Wed, 5 Aug 2020 23:51:10 +0000
Message-ID: 
 <TY2PR01MB497285E1CEF6341915A14DF1A04B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f56a5ba0-3692-499c-5226-08d8399a6ddf
x-ms-traffictypediagnostic: TY2PR01MB4810:
x-microsoft-antispam-prvs: 
 <TY2PR01MB4810DBDF1588DBE6BE9F17BDA04B0@TY2PR01MB4810.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 m7+VrECXmV76sPGeavD5XvdIpApKxnxZP/Ldk8JA2r84M29H7xBORaAhnyCam+/wX+GI/oek8uFwNh+81ukoGxq//Or8OqtAKPNC25VIiq/UvY3ekgSUIbob/Wd4vMhAwQbniB5Yr0l/Qbhq2m64k1oECIS6yKslp/7f7EaC61JRO6A13ByV6fUG50kwX+wcjGHzZ8OsSarrRIS0pCFLkXdLF7KDAieVPMHfslOJP0Vv4IgJSfw+f7xatanH2kGnYN4gmornKf63spQqBGNq/C4ibM/ad72D0RrV4Qw9UWWu+eceH4Q842oo82GxhQRDGaD68j+Q39w/MzeDJmYp0pZZVzdgkhe0xMOUe1fVstt+Ff8wjgpeatts7+rlXiqh0RMz6aD3EtVMXduwtDmIuQ==
x-ms-exchange-antispam-messagedata: 
 +QrjzQQri5SQG1jaUwEsmdGRLUrwsPalhz8VVzLr4/BY1j3vezr8qxXKNoXcTU1WNHD2xH3vjS4mEnJGxaL5lLUCt2T4CDTb/bVciVTvWLj1WswEbQ4QPnqHdBUp8radA6tMTxvqokvbkR26NOig4KVg/qTiTirOZSViRjFwB6GxvQ4jkZKQDyB5bm1oRlJ9aDTHDuy0ZRFLt39BUtqLxllKyZnprS+GSKHyDw8JTOgDyMlXkjzjlAHLA3gwvP9FbkAfB96rYHr/SSC8umLWaaXZt3950kQYqu1jwagUhAxyYBWMEBjVkxvNs1TqAqa9GW2kBQJFNAxaVfrEeuv+A6fLnLLgmRzSlI6tFK62xpCGmY69myu8urCK5zIohqJ2uayG4KPXPcSaoL5UP0tH5RR0QDEZaFQZyrhhNpjnyl08ibK6ubKu2dL+p/NdmTftlUsTPp1wqgb0PEEZd7eW6B8pFgzaQwRjhyL0RaOahLKnqitYfX45B0Kz56U3xy26FlK3wfuZsoGLVTQI/DlwDPXqEJmyeN8E3mkXtwzb3y1/NhW2MfRkY4UwC+zxa9IaNoLNeuMAyiSVgiT32/7IJq7q3VNC5AHtYN5Knom5KsNd/vBo8rbsd2aB9VILQr2bIkO/qrAk3C4k4uE5JjcXag==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56a5ba0-3692-499c-5226-08d8399a6ddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 23:51:10.2974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ZtSydaeP1SP+QQ8u3xAZGnN3JJX4RAcpLz31KIJTk5FQVMUKLV7PsGLI9okPq5jEXlSKe48/6Vxy/SPVOq37SKznKp2XNUrqClLh3ypwBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4810
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UM1KzMpxeDj0NX2nfqx2BZ1ox4520388AA=
Content-Type: multipart/mixed; boundary="D3XhcRzbl3bDUkIr7LfL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596671481;
 bh=kz+uhERSePWosh1ekM/sR6x6etZl3eon1xCeK17xa/o=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=pvT9yefeBbdPfjT/hSkmQeHT30UR6G9Yw01wSe0yVsY+eUDCZDGL5eG0zICsoO8sNHc
 3G0uf2bReN6zw+khOpZ0UqJtXGJyn0Kc2M0518wN3nXYAOcldSoJCoqF3CmaVXQWNg+JQ
 sPJ807J+H/wcotmDOpTWCGbFCX92UjJCm08=

--D3XhcRzbl3bDUkIr7LfL
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D8&day=3D6&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p=
5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/07/cip.2020-07-30-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Post LTP results to KernelCI - patersonc=20

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

--D3XhcRzbl3bDUkIr7LfL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5102): https://lists.cip-project.org/g/cip-dev/message=
/5102
Mute This Topic: https://lists.cip-project.org/mt/76018886/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--D3XhcRzbl3bDUkIr7LfL--
