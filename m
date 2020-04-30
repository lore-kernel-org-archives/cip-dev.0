X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.98])
 by mx.groups.io with SMTP id smtpd.web12.1460.1588208198218114362
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Apr 2020 17:56:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intra01.onmicrosoft.com header.s=selector1-intra01-onmicrosoft-com header.b=LCZLzQhW;
 spf=pass (domain: cybertrust.co.jp, ip: 40.107.131.98, mailfrom: masashi.kudo@cybertrust.co.jp)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnJVAt1vvTuWsozKCr4VN4Xpe1sxrEAnx1kAPHBsEBWj8mZOoj6qKuC450fBJdJPYVZawrOCiI/4qgW4+ASfojmnWwpdES8w5PXX14wky1lTu904IydNiy5jDHULlIJIR95GvTC8LqADTN4ZUU00DRrhccDwcmyTK87MJRwJYXd+abaCpXac13RJ+kFJhO9n6NSaPi9pGFhArzuOKIX84LX0B7jMUXMcdTms1K9oBmR2QXIoRXJLAwyJGGI8nxBhGATY04cnwBvX/WOkwp9dyvsyhjeluc1S5rWRWcLx3JA9zEUe20EfAtLWvZsZNMzaRtHMAP+ekomLaaulWHi5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vImCg6V74tkIOjBJ2g9Oe000VePDb1aE9VAdhtoZjyw=;
 b=df6uS+608+K7gUBw4XS5t/kYrVzj5aKXtqUI/R5HYGvHNmFP8FwoolnhCVcNf18ZcMr6HBumCTDdyVaUYXyIiiNakwwE9cpW41qM3ScxGSMdAf4VpVqHvMzHQx6UiXGvfSHxzbyEutNoXMPLoujLYYCKDGoOE2Ey3lEXeTKikfK2E3qRe7KKNjL2ydRvuVHJy4Gziw2BErEUu9pq3KrJs9ETodxlf19GWmbsvu6mZPqh0nNLxBk6wWJhPlpBoLdja4Uaz58dWtteUwmxLDB/0FVjlTwjCdUQa4Hc3I4L+Z6LQXawqNbM9KNK544PVA/ZxxfzRjBTPPwT3AWCD9vvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vImCg6V74tkIOjBJ2g9Oe000VePDb1aE9VAdhtoZjyw=;
 b=LCZLzQhWK3VBWrQMxebPra9Be/v0FCLHSZ5C91lTkN4LnH0EfJZ+72jpiMu76tnLBwseOBsPDuUeBod6p7mk9VZNUITcUhKHUhY45GuaJOXKzKDZym+kevYVLSXwxXyHr+XOlsZhxXZL8EC3nR5SkBuxegXM3TQe8jAWH9B4A+Q=
Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (20.179.172.148) by
 TY2PR01MB4457.jpnprd01.prod.outlook.com (20.179.172.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20; Thu, 30 Apr 2020 00:56:31 +0000
Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 00:56:31 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdYeii420HEWkZLJTG+HNfuVKCzjng==
Date: Thu, 30 Apr 2020 00:56:31 +0000
Message-ID: 
 <TY2PR01MB497292B5ABFEA4BC5CC874F9A0AA0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.cip-project.org; dkim=none (message not signed)
 header.d=none;lists.cip-project.org; dmarc=none action=none
 header.from=cybertrust.co.jp;
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38d67109-193c-4468-998d-08d7eca15282
x-ms-traffictypediagnostic: TY2PR01MB4457:
x-microsoft-antispam-prvs: 
 <TY2PR01MB4457342B61CBE13DABD9C2F8A0AA0@TY2PR01MB4457.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0389EDA07F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 grp7Iw2ngVjw/VWLTfd2ykqsNsFXsG/CveutgfqE+oItaE/RLegqgCSvpO3rpmsf08zTVpfgZYF7p680xbD/7JrtMyMIFUaISIzXFgmbMSBHZ3bPnS1m6ocn4joQxZnLdgd45EeTue29DfNoyUOF7/c/e8yDddAnCSf83R+XfCDhHLX5y6GtasoRbrGSaFUvq533nlAIMnj5B13Hu3Ewx+BGLypimKvpuv31MItfeaUmn07OYGVLUrbCi/AOUbg7Zfs+iZ+lpkBGpZtukQFZWYsFWjKIHOW6JgTS+thGPjEWFoPTqDT3w11W0hf+FPZdR12wD76lKtUKGtGvMACd2/IgK3eOMq0WwRWsd+X5pn21/VZqyTLMdjAQba9wL7cpiL//f4OTqhOfjCND+3zJHf6ftQKeUPOfE1fgOAuSoxtY40Ebn6DvLXdlE6M6UFfjganp2GrO1Y/KYzt2trS2punHuCJLHqPVON/Jx12nYsnRzPWVljDU0b8RVyIot4QQ4DXydTvcU2r4SphXGFcWig==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4972.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(316002)(71200400001)(86362001)(966005)(2906002)(33656002)(52536014)(66556008)(64756008)(66446008)(66476007)(478600001)(66946007)(76116006)(8676002)(6506007)(55016002)(26005)(5660300002)(8936002)(186003)(7696005)(9686003)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 
 STFlxyx8YDu4sQBWm79ceujbs45x/i4+A427g6gUhJK+cfV6phC7Ka0liHJHVlZzaqA2HOg4bJunEwno15ZJc9vw5KAAGSI3PRFTwGdnY8DT9FYbLYrX5ybPdcqjzxb/9FL9DmpVQvN648704nlk2H5MJxl+60ezTlnbl9l2JVMApcrWgcbQ6AZX18ehiibrJEmWTQcAJsOtQtHQQ5azrvDMGhLsz7Xown9S8MYleSt1NTj/zhPTud0eGWzon6S9uqpaHy3ipkI9iMcn8CXQYqN3XTRFTYFdVs1tF3ff6TcVNTIDiI0CY+lacCOoJh4YIWpzfn4mqGLiMvGEorZF6fW/1ibqM+pLJgur3oJ2ES5PJIikURaj+KB3C/Ta524d+IpdgHG9xl0ZfCF/hING6mpHm+PK6BcD72sR3MzFc0Kjr31GycrqHYHUZns2tuyNeJLHu5V7dmnY8poFNIM2jlkxQd2fOKMkw+BsNKsPm2v9vSk9opLrspNTE98SPAn3A5xFjWfN1+y+XiE2J8JsrlE8jALuhpFv347OFlFzo2+w6Cf1aGGK5I7v1iHg47+ctkRoVZgFdzFtnUEWxlq4jON2bBN+3Qr/4XPFfAkPv4ACZoH5cBrHoc+dVUXC71sGM4jhHMtFrw+d3qz758vor5RBp+752yrfEguj4+yrmwNtRzjCNJvG2OAiDVYkT4l6xFRXElz2YMZztCJDnBLtbxsAs3NE/iOzi9y02knAsT1kYZyhn86OgoJIVTIIsBUJZGlWRmDgHSov3Rwv0NdgDVL/m6D4p9pEIXr7qthaDew=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d67109-193c-4468-998d-08d7eca15282
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 00:56:31.3805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+Gau49Zg2SGDwAUBRoLsbzUBE2UZmHZAkpyrEievLGUef8/70oK9XnuGiJpLB4Z05+79nQldPZ5HoPNLMxOTjSRfMb7riT6h0B8mxn8h2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4457
Content-Language: ja-JP
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D4&day=3D30&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/04/cip.2020-04-23-09.00.log.=
html

Agenda:

* Action item
1. Combine root filesystem with kselftest binary - Iwamatsu-san=20
2. Strengthen sustainable process to backport patches from Mainline/LTS - K=
ernel Team
3. Upload a guideline for reference hardware platform addition - masashi910

* Kernel maintenance updates
* Kernel testing
* CIP Core
* Software update
* CIP Security=20
* AOB
1. Some topics from TSC call

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.

