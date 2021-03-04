Return-Path: <SRS0=SU+E=IC=lists.cip-project.org=bounce+64572+6208+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1192CC433DB
	for <cip-dev@archiver.kernel.org>; Thu,  4 Mar 2021 06:57:57 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5386164EE3
	for <cip-dev@archiver.kernel.org>; Thu,  4 Mar 2021 06:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5386164EE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6208+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id oCgaYY4521723xKVM6kQKXvS; Wed, 03 Mar 2021 22:57:55 -0800
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.134])
 by mx.groups.io with SMTP id smtpd.web08.3369.1614841074452655157
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Mar 2021 22:57:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tlhu3Eov2e9MZy/rLAf46P+z8Yu0oadPM7p0Ixt2RASqgra/GIYMkOzj/P8ZhbPYzEcMq9naDLKylhQKKVGZfSprUQp1PTLW7Ph6Xg0PAa5V6Fh8bnDF1UaPo7OJGyctBJhNP48ieb75yHOVmUAc/Nx15vjNep6TdofZajnebz/o9spI18WLa8m/UjtYQHK+DIWU6CtQ4GUTGlIFLFsfVpC5/9h7cX09bs8zTnlRgu1ovLTp1AjpOy3NnC1lAPpkmQVQ+XJaHhcYTs/wq0/er2NPcdDK8Y00SPo9cfcvtAs1dQRKPf7k1yevFrCTcOteZhgUW8fGgPUonzDdnR5Exg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blyakKQX4A9xr7+XCqOy53qkfgemKGUSyJzBVG1I4JM=;
 b=GDxe2pVFWy3PBOVfu+2jR6Wbox3zfr12AtL4qqvyFgqGrl9VwL14pWKBYjvNkb3kTpg4zt0oLxeW6y7Ha+0BwsoNI/AN/KhttdW1vKHEcB45bwfj0alRxxt891961q8OKSQObORbEVF5DEtjXreFjyNts+DYAL9rkxDpKLzoFGo4GNulklqtl4DFki0XBYudU56etwQUUz0OwYknKmhe09ccTH0eXSklZFHqkozVaH8j2doV0cZoIgWVCSaX/Io30qEYZ0jea/H1G4h7jwUrZdMnLpNcy1La+oyE2cHr/rM2v3spQX5od2prCD8OrLgNvsOa4AwHGa3u7OAgn+g8OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from TYBPR01MB5374.jpnprd01.prod.outlook.com (2603:1096:404:802d::7)
 by TY2PR01MB2332.jpnprd01.prod.outlook.com (2603:1096:404:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 06:57:50 +0000
X-Received: from TYBPR01MB5374.jpnprd01.prod.outlook.com
 ([fe80::14a:9d34:bc2e:e00d]) by TYBPR01MB5374.jpnprd01.prod.outlook.com
 ([fe80::14a:9d34:bc2e:e00d%9]) with mapi id 15.20.3912.019; Thu, 4 Mar 2021
 06:57:50 +0000
From: "Kento Yoshida" <kento.yoshida.wz@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdcQmYEPEy3OeMlZQxGAGMRFX3eXqwAKebsw
Date: Thu, 4 Mar 2021 06:57:50 +0000
Message-ID: 
 <TYBPR01MB53741643B50EE8F1F536753EDF979@TYBPR01MB5374.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB4972C8CDE610293B2488776AA0979@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY2PR01MB4972C8CDE610293B2488776AA0979@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.50.44.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e35dabe8-ba11-448c-4334-08d8dedad376
x-ms-traffictypediagnostic: TY2PR01MB2332:
x-microsoft-antispam-prvs: 
 <TY2PR01MB2332EB254E24B607A6CDE9DEDF979@TY2PR01MB2332.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 RPXVkkGx8gM873/Axh5oIvsL2ke7LWBe2ZEzePjd2YSSTs4bkqwMK45OfnfzySXqgg6e2WMUBfmySBqcA9zfIyyMJlXFek6me7fgTjMJq3FYerJec4evLatTDYM4HsEQmnz/flRtUTOjwg5OV0kyokKmpxpDDR+1aOEDTBdG85dUYinBMWsdIT4ezUSYGRE3btWy3n/DEj1/YEV50c73anbNkmS86L7OYwjtF7y3QTfhmPkxlqbmMlCSWg5fn7IuLmAHMwUEWlh0HQoRQ88ps6rV0S9ArdTLRJADDR9srbZ+ALdm9JmiCy7V8bGagAEQiS3Kb7+Td5wY2xApXlElvMa64HgSnxtqHukFZlSSPbm9GxuNz7oVgJosUqxVhTbbo7h2/gwS4YX/aS1FD9DM42mFpz8h7v44FV2pO64ESPny5iFw34gXYt5Up0xPaX1HLSgzWr62WSJ9BBh/dc+inbYp00g1dIpdF3Qp/slUYF9U5iipRnkLBwm9VhW54JqPTRsV3GwOdv6l1QVkWkbDkLYg2RvjxKugVxtQ5I8arsG5ZUaSpKlWqKJ1hpRRvglUOkW3+g7SLuUJx6tkHNLnGKVZPivGNEDibYmma92icIo=
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?12QBFFlbnFSZrnq100QH/zpzO0n0paaeod5jljeUIWGCE8MS+/uAewSvAu6/?=
 =?us-ascii?Q?vUFTm993rjmmEP77sWxAasGRvxGnfVr9cHUr0l517prfN6HrUzJyljgeV2pi?=
 =?us-ascii?Q?EUclymX44YSmfoCYf0Bi6q8gZIk3vT6y5Epw9f9m6/PBtESOpaO7taMKmo35?=
 =?us-ascii?Q?3ls0FvKa7QUGeqgMvbJiFrpdTtNg0Bx1EuobgYkpiTd7R/OZ9v4rrnTMXcOq?=
 =?us-ascii?Q?3cdJbXMJxu1UMv0yOKojXqtiIJMy6H45c5Gulv+hXWZpG7S6RAmmV2GzAXfW?=
 =?us-ascii?Q?lbq6A7S4xPag4p4aShtqJtnDZq/eZd/ONA/OWuhkYbGmuWOAah6nYwY3kO2f?=
 =?us-ascii?Q?V46MuakTQmsYae8fXnsqe6n71LhFmQkYixpwjMBl7YSVsOkaaHjPknfg3svF?=
 =?us-ascii?Q?vJG33c5P6vNw0wweJOYCN3rPWQAri7RzWDbABuGtGix8u0Ho2LB1+jsFQ5Bd?=
 =?us-ascii?Q?VD1tsK1/lvUO944yEnwJjeaH2r07hXfYiNgj6SiVtneTaLJum6wiCUihoLkg?=
 =?us-ascii?Q?jV5TeVZ8FkVjtSHxZ/ETixy8bEQQJDlElKoknVjIyoI/yENRuwjd0baOgtEH?=
 =?us-ascii?Q?6ArUvBgguTa9/E0QzOLik3Q3H5vdtVeC1/7DBDeNeNOHGmW6KJSGwERW90Mu?=
 =?us-ascii?Q?BymL15PCfRtsWXNfWDWwR8ruqmZipiCXzAA3aSXh4D4m3i34lxvV7h7JhRjD?=
 =?us-ascii?Q?vC8fP2i/hVphm+dbZN2FuBBtzdQtS1MorrnmsPBRynCvY29W3IBLQjWZHka6?=
 =?us-ascii?Q?q1hTTk0niAtblx+znxt4bNjgouKjCfzYY/XzLq8eW49hyQHLd3Om6SVuwHwY?=
 =?us-ascii?Q?iUeV3203ZypfFYmdISV/Aih158azqYbzvVFSZ7EGzNNvFCz7hPwltv7XRVgq?=
 =?us-ascii?Q?fnoh7k4Z9qLVezhulLNEvfiCyghj724DNgXLfIoppXCjEk9jyQ0Gg8Y/vx21?=
 =?us-ascii?Q?t2eMSurxfMTsyidIY4x8vi7f9na/MPqH+QvMdzG4RjGEqyCnUxThG5tI/4no?=
 =?us-ascii?Q?Xxs9+D3RWtzkkQlQEvcudnPo6bK+DrUVIjqxT+SMOzc2JPdvBUgMD5LM29mj?=
 =?us-ascii?Q?4GfAdzvpX48tmMaag4J4mDbGDyVF2yWx5iF8Fwp9RhaxgV/8te2CLlUHMv6h?=
 =?us-ascii?Q?b9UwPBxFqzLQIOPzZkCjGVrqHSsQ3tone7YvZiE9rfnoEBTdNRW/+gGPnHUn?=
 =?us-ascii?Q?35WmjYOJaQ/Epup55w/vv9G6KQr1eM1jw9Yv13Zph1TsPVjT/V447bw4g8Ne?=
 =?us-ascii?Q?dMAzmlAcKgXyQoUHuV0Tyg/YDzjFO/20p17rki5x2PXXtCImzrb9aZI+pCMx?=
 =?us-ascii?Q?Aas=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5374.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35dabe8-ba11-448c-4334-08d8dedad376
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 06:57:50.4008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UTl0bZ/T5ebAMv3Jw5OFFjvQXBYA2s3RGfa0hESUl2RuP2fUzmh4KR6JNgRufZJO/DkrAIReEE4ZVJyzWBStEzUVQcuPCU9xv56yWpo5di8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2332
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KAUyebDqKRyAR3Y7BvjdW3ZOx4520388AA=
Content-Type: multipart/mixed; boundary="XUdP3p2wr7XM1GnDfren"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614841075;
 bh=oFIuHMB/AfeeVLu1VY0iOt3P432Xj1ICh5Id8PV3gVs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ZvGdwYNxsClTWTZ33NCl65jy+y7F2WzA810KK6cGuqCmRuOUuqSp4jXQGMJDWqYW7xE
 fhraT6VRrhnjponE8xc12hUwWdXyoSKQ+mQYidFltdXgVfFu16YheV+Xeo+UfyIYMuMoE
 qf2fs6EgF80UGZNWsdzkTd+76lftGXFtarw=

--XUdP3p2wr7XM1GnDfren
Content-Language: ja-JP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Kudo-san,

I can't attend today's IRC meeting due to schedule conflict. I didn't have =
any major update this week.

Regards,
Kent

>-----Original Message-----
>From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beh=
alf Of
>masashi.kudo@cybertrust.co.jp via lists.cip-project.org
>Sent: Thursday, March 4, 2021 11:03 AM
>To: cip-dev@lists.cip-project.org
>Subject: [cip-dev] CIP IRC weekly meeting today
>
>Hi all,
>
>Kindly be reminded to attend the weekly meeting through IRC to discuss tec=
hnical
>topics with CIP kernel today.
>
>*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 start=
ing
>from the first week of Apr. according to TSC meeting*
>https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.ti=
mea
>nddate.com%2Fworldclock%2Fmeetingdetails.html%3Fyear%3D2021%26month%
>3D3%26day%3D4%26hour%3D9%26min%3D0%26sec%3D0%26p1%3D224%26p
>2%3D179%26p3%3D136%26p4%3D37%26p5%3D241%26p6%3D248&amp;data
>=3D04%7C01%7Ckento.yoshida.wz%40renesas.com%7C962ffbe689db4e886d9e08d
>8deb1a75d%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6375042
>01892283984%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
>V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DBaCbHw85Fy
>5%2FCnUOWPMwt9oyHfK99ATCQ3nkceA4bUM%3D&amp;reserved=3D0
>
>USWest	USEast	UK	DE	TW	JP
>01:00	04:00	9:00	10:00	17:00	18:00
>
>Channel:
>* irc:chat.freenode.net:6667/cip
>
>Last meeting minutes:
>https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Firclog=
s.base
>rock.org%2Fmeetings%2Fcip%2F2021%2F02%2Fcip.2021-02-25-09.00.log.html&
>amp;data=3D04%7C01%7Ckento.yoshida.wz%40renesas.com%7C962ffbe689db4e88
>6d9e08d8deb1a75d%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C
>637504201892288961%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
>AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D5Z0I
>qIH8z%2BCPCauvxifHbXeQp%2BpEER4CuIkT2S1829M%3D&amp;reserved=3D0
>
>* Action item
>  1. Combine root filesystem with kselftest binary - iwamatsu
>  2. Do some experiment to lower burdens on CI - patersonc
>  3. Check hitachi_omap defconfigs wrt CVE-2020-27820 [drm/nouveau UAF] -
>Hitachi-team
>
>* Kernel maintenance updates
>* Kernel testing
>* CIP Security
>* AOB
>
>The meeting will take 30 min, although it can be extended to an hour if it=
 makes
>sense and those involved in the topics can stay. Otherwise, the topic will=
 be taken
>offline or in the next meeting.
>
>Best regards,
>--
>M. Kudo
>Cybertrust Japan Co., Ltd.

--XUdP3p2wr7XM1GnDfren
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6208): https://lists.cip-project.org/g/cip-dev/message=
/6208
Mute This Topic: https://lists.cip-project.org/mt/81068407/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--XUdP3p2wr7XM1GnDfren--
