Return-Path: <SRS0=ijMp=BJ=lists.cip-project.org=bounce+64572+5057+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EDEC433DF
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 01:56:52 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE8FF2083E
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 01:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="KuTERCoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8FF2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5057+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 4u4yYY4521723xf9y2JokRmn; Wed, 29 Jul 2020 18:56:52 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.107])
 by mx.groups.io with SMTP id smtpd.web11.5659.1596074209928255110
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jul 2020 18:56:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccvfZxHfL8YQ7NAGkFg4o2PpsbN69kO/F4AhWdVAg9QgJAShhbL2KWvM9pRXT8gMRpmI7tlH/TVb+NPQxG09LsDVWsVQkH6QebtrDgW38i4Q+YKwyyC7QqffD6jc1MZ9Hgcn15CcnQIAFoIifWt4wlaSrki13Nfuo2ONiol9PoHRa+BCKljSikMMoI83+dlBHL0/EPTMgLzdskIbFdt8U89ISJ6Ob290ly44PYoQwmLCErezqIgDieYG7vl5l3vTFG4k3oHgjFI8k166fdYYD8yyxBBtaTgVdUtShKdMHIUXpCUHHasXKwHkmb8l7+LuWo98u80eHucCR7ByChIT5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDcnpq+5ao2X7OBgLj4ClEA8NRVrNSenvOAFxvBHz3A=;
 b=Ui0LvPMFkCpQSf5FnHqJnSkPHE8E8RNVBF+8Ii5m/9MOyGZ+ODx/7hkLPcIdNfPT3lELRqUhoVqSCibs6qDhxD5OEgwFxzDFW23T+xBg6Jyn7PanDKFhoGHVe2FW8Di4m4aAiwsmGoevSRtvvY9jVTNbOLBSa9V+gwBvCpIG0MWs/uQsiLfW30DkFE6Z/c35ElVknBNMTIVfru2ZemThqHSoNqqVh8wDDTyTZyQQKSgM/qNOkwQL6oTOYcO68B9MQHDbGS2He6jB1SaO9Hw05ZNEqvtS37PCjQ7S9izrk+cz1viQUxPMU3oBzfW3KJKSAvFUaJHMAn7oz15rOZQoCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB3148.jpnprd01.prod.outlook.com (2603:1096:404:77::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Thu, 30 Jul
 2020 01:56:43 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20%3]) with mapi id 15.20.3216.033; Thu, 30 Jul 2020
 01:56:42 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdZmFKJ294ZreUmzR2eGB/pCjYQSbw==
Date: Thu, 30 Jul 2020 01:56:42 +0000
Message-ID: 
 <TY2PR01MB49720968B08C56B3122950A5A0710@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 530dc09c-59eb-4472-aff8-08d8342bcebe
x-ms-traffictypediagnostic: TY2PR01MB3148:
x-microsoft-antispam-prvs: 
 <TY2PR01MB3148436AC5C67E4B2AF6C207A0710@TY2PR01MB3148.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 Lubd6yeZRej86Bf2MnJXSY7ZKBfmWblWUZSPjBfHqQDyAX9DBWKw3aMJeaRl1Fp06VsXZw4XJKju8KjWU3N9sk64tPrx44quNGFiqqXf+RnVnlvuTcK8dbALLN9IUvPWae1ERAdjSPoObJZ7LgWGYPvUYYXFrPVgSa7KLjKuHPZ+Ia/UsmRlx7gaXO31+B8WyFsgW2s3opkPxAylJt1lSV9SkwOw6HCUwa+Q1SpCL1kvZjF9nJjL93QwFtazQEn9rfpB++bD5jKgxTLmHpWOH3nHIw4+PjS3pKL6l6sUqSfTrkXj+hbtf+9eAStQJvqyMP5pVtuLe+g1Jal5xheIpoHI6Ekiq7bf951M+Jb6Sd+acuFsa3KtGLkHTdouXTYA1j24O5VoV505UEoxttpa1Q==
x-ms-exchange-antispam-messagedata: 
 nHpQI/unfNU8IYIS4IQ2Tf5f+GtbaPL6NyD0UjoTrsKj7zJaoxHI+saF/Hc3BGDVfkFeqftOyB/OYrsxr0uMjlaLk+KWBmFh16VTtSxU6l98Q7n+AWMCV9yeERcg/qtlLabfb4SfL9Ia9qZhqgs5XtYK7hN0WYgO8A0AY8730OHHAG+sXND2DUY4pKk0p56lWb4zom4QeZr2rMzVpuznFaVVqPMpuqC26WXwddwVsWlAh7qUpXFgfegOON8TUL3y8kNyXCFnAfoqw6BNVTH8Yc3ZNLKCApplOiiSSWsa/aW+MiIRgy1gY5bwzCE0fSHw0nxBvQAyvx9a1FMWbhFk6gjdtS6AlMJg5adG9wamrUBmJ5rF2CzVIbaNw31B36B5VUEn5FjjJSl5LqahmZbzW6rRNRMKpYnN5XgjSmVyMIZeaFYkZo05k8MKE9VZR+kj+QDHtm5T6rddjkLdEWLfNyon38/ic7XiOcF+RWeX4OLsvXh0Gjx6TepIGnKEXEAa
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530dc09c-59eb-4472-aff8-08d8342bcebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 01:56:42.8577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fH3Rdf4kc0A3Zi2NX8wgCJQBfA6uPRGLX4d+yJR1/MEhLoYnUEiWOreNu1xvSxBwb0taTuHYYoYyVrDiJu6usFBhJ6gKbPIyBk8k28JlQ+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3148
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: I11jOQU1UPXNAErenhqNxYjQx4520388AA=
Content-Type: multipart/mixed; boundary="TQxCOVvA0v8Hg6BNcyU7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596074212;
 bh=1Q6E64wr93SLFXhVuCyYwmpn76+GEynnqQZl5CtxQnU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=KuTERCoA1u3M5ao1XobE2YP/OhECNa8LF1S6XqaHufNRXnW6h8MC8oLsT07mSlRJI8c
 8ZygO/gfL9tv293eX6xK22JcgIywCJ0y50ckt9XFVEandb17qQltkTmRCpYAZRHSKOd5+
 fys38NnnA9V8sTYJFhmU4hoNIdbEuY03+80=

--TQxCOVvA0v8Hg6BNcyU7
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D7&day=3D30&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://lore.kernel.org/cip-dev/OSAPR01MB23857705B82D0D163B5E5211B7770@OSAP=
R01MB2385.jpnprd01.prod.outlook.com/T/#m873e67bf005078f86fe9f659682614def4a=
448a6

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Post LTP results to KernelCI - patersonc=20
  3. Email Kernel team/cip-dev about patchwork usage - patersonc
Old AI "Issues to be fixed for swupdate "copyright correction and salsa CI =
testing" - iwamatsu" was taken care by SZ-san and was closed last week.

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


--TQxCOVvA0v8Hg6BNcyU7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5057): https://lists.cip-project.org/g/cip-dev/message=
/5057
Mute This Topic: https://lists.cip-project.org/mt/75878882/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--TQxCOVvA0v8Hg6BNcyU7--
