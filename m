Return-Path: <SRS0=9RNL=AG=lists.cip-project.org=bounce+64572+4810+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CDFC433DF
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 01:54:19 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F207F2072E
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 01:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="CItP+NJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F207F2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4810+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YY7DYY4521723x9oL1SuaIpM; Wed, 24 Jun 2020 18:54:18 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.101])
 by mx.groups.io with SMTP id smtpd.web10.1792.1593050056634254501
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jun 2020 18:54:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxMPMSPl07xnJvxipCgcrGEkPmptPBA7Yp3S9zplMA0BLxQKUm+qlmul6TpqQ0t7Bs7zueI8dlNPv3lDA9T9RdU9kyqq0ahzz0YR+/MpsLmo8FUk0HBdYn8iN7B49xp3yVGnCYSW3JtGluoTWUYmwELQCYiyUyXca2L48E7NBN+F6X71Jt83cGDpVkWMw0rqEpzTfYZqqJKn/SLM1owo/VntdRmt+LvG0gF9ix7pY8UqOJgbpRJ0efjLtOgHTiuqtXpmMbm4qRVcm33Ew+8hFvtvPG8mlfojAnr4xggOrdi8W4sOBoFlqmPLlsaEEQ1S2RqKgpvQ+soQYQ7GtuxjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xB6ZoR5/DVtvbi6dYrha4kCQ5bPO/qOcEzGVNgLv6+s=;
 b=aN5yG2WSVM9v6Ev3iYF7ELFAKXSYXtZy0ps3qgnvBeJFmKQh27Rh6EKh84JDSB2p8Wd4zcb8O+TwL5b5p6bbZLwLbYUEWm9FRiXV2b73MnWUnnnTqdOR2Ob2CUJpv7wOGaM7Oj6e/6VydLj1Y08ss1MJenGE5T2+kJVvrj9OOIIA7CQ6wN3b7q4QR3t/FIaTJ7KlUxR7BF4s2FeMlU1TNllYZSuXND+2R9eRmHdC87iwqoV2mc+0gX1IoE2kcwpl3ZnlhuBNepV/11N2Mx59VoILqhYlzFleLJMUTS25JzIZCd7j4k2AI0p3x2//FzdOuJvX9BStqXAmEwEducaI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB4746.jpnprd01.prod.outlook.com (2603:1096:404:116::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 25 Jun
 2020 01:53:59 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.3109.027; Thu, 25 Jun 2020
 01:53:59 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdZKk31OU14dTGSGRCWdR+Bw6Hct+A==
Date: Thu, 25 Jun 2020 01:53:59 +0000
Message-ID: 
 <TY2PR01MB49729620B56F4A404F4E709AA0920@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db739c95-ba1b-4d3b-7a83-08d818aaa0c8
x-ms-traffictypediagnostic: TY2PR01MB4746:
x-microsoft-antispam-prvs: 
 <TY2PR01MB4746F4FFD2332D678E4E3CD1A0920@TY2PR01MB4746.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 uUY1qd7pV/PrawBXp91Qr+GYrxzMRl5PXR9r9TYncEjYG4U6cXNKDQ6euFNapeJ9Y1dl7dbYDTj4viSvH47UmneBZyA2UCBD6ia4UfX4dI8c4+DMdt9iFvwZKB5t/NnNmOmppA/f9BklL4L+fi3E6jnBEMOewAVuuhp+VWdfkXw2rSgTQ++1HGuoNtqhaGQov5D5xJaL+Ce9YOoQoP7KGxL7DeOHCpkcgV7LPQOqT3G0bXKDmE6ptlh3rf7HqFpIO1MubpU/CvrWh2muKYfQbrysQD2NGX9KzxiZMewOsa7xBgwfitf7OMHJ2XlF1yj2zr2XTY1m+Hk22m8ESK86hRwTc4oCzTB1tsIEDpcD8ZS3Z1uw7IQFc9wy1jOBqBirgqT+NVhLE/NB23V2HsUV9Q==
x-ms-exchange-antispam-messagedata: 
 R9jduxTnYYku4AbvwJA4w0T4P8Q/9VaxCvb87Bl39xuYvip7nxbrzh/5xi1dRjDQYaXH6wUSQz0GdYu1VCU4BlAAiI83CADLvPuQv/0jVhPkeGRJOLf8JtoauESIaI9BF1AorCfxs0s4x7O8S+v+96NaDFbGdyuzQdwMw1NDgmVRlujL4+iw9JTgNFflSFqOgAu45+ly/XQWCIN/MdvLq5e/JeIQn+KIT3n0jplMycm2jrkUtqY79DpUJ1faEoc0IlQEsrDFc5ZgCk7PSPojc5S4OTzqmqD7DtLtD3StB/NF/Tb7wiokZNk9LCl3HmvEuJS554eO95jZI1Driz1hQTv9VW1unBsGlNd7LuzO2JBxCTXOkt/tbfRGBGNql1vKd/Cjv0kIdMOCOCzTmdi5u7/puNY0bcZV0HM7agEMv+UmMcIh3EcMaNqwiC+G4pEMsoBde9oIZZlaxb0LA75fP9Drd8LccMrGZbYfqMgLB676gbwCAxfj0Yx5HtYr7QH1
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db739c95-ba1b-4d3b-7a83-08d818aaa0c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2020 01:53:59.2945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3akjQLTNE6xReGRtI1hsCSS5tXsI5b0nhHiDpXo2dnUWPnNUeKBKA3uV59QCJ7sCz2bhyYQSDwbwqTE3u5dhvnDgSot1j5FF76mnVyQvHw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4746
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: yej9LsmAZwtddrdA54lylmZCx4520388AA=
Content-Type: multipart/mixed; boundary="4cI6vzXAOBmBhrZNwJpW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593050058;
 bh=+d0h9Q6BLEuQqnF6/lXEOziZqXXdZLAVaVjQU8wlAIQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=CItP+NJ8GCsE/NUCzGAdiRa1SVFiuA8Qx07x14gsFtqy2Vm+295pZsqv91W/QzIP6kN
 WT+0+ymNeZVXGHJBWB4D41jLTla2jJFMLwEf8laAEKhLopESYfCYArIopzKbvzVfjzXnM
 urOvD98MTYbggW0Wyy2FgOc5CnyXNtVtU9c=

--4cI6vzXAOBmBhrZNwJpW
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D6&day=3D25&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/06/cip.2020-06-18-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Post LTP results to KernelCI - patersonc=20
  3. Ask board owners to review reference platform configs to optimize back=
porting - masashi910
  4. Check CVE and Patch, Bluetooth BAIS attack (CVE-2020-10135) - iwamatsu
  5. Issues to be fixed for swupdate "copyright correction and salsa CI tes=
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

--4cI6vzXAOBmBhrZNwJpW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4810): https://lists.cip-project.org/g/cip-dev/message=
/4810
Mute This Topic: https://lists.cip-project.org/mt/75095440/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--4cI6vzXAOBmBhrZNwJpW--
