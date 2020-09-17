Return-Path: <SRS0=rxqr=C2=lists.cip-project.org=bounce+64572+5460+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F425C2BBD1
	for <cip-dev@archiver.kernel.org>; Thu, 17 Sep 2020 06:58:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AEDA21973
	for <cip-dev@archiver.kernel.org>; Thu, 17 Sep 2020 06:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="khMKO9Sa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEDA21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5460+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id QO2oYY4521723x2RktVueRnk; Wed, 16 Sep 2020 23:58:40 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.9970.1600325918107361911
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Sep 2020 23:58:39 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 08H6wXj7003546; Thu, 17 Sep 2020 15:58:33 +0900
X-Iguazu-Qid: 34tMXyHqv8rqP22kOF
X-Iguazu-QSIG: v=2; s=0; t=1600325913; q=34tMXyHqv8rqP22kOF; m=5FmFd08bBKFo/g0OFDCKJ7t25pmoQfyNdkYrbnZrDno=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1511) id 08H6wW5n000738;
	Thu, 17 Sep 2020 15:58:32 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 08H6wWIK007720;
	Thu, 17 Sep 2020 15:58:32 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 08H6wWkU014681;
	Thu, 17 Sep 2020 15:58:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqqqt4UancBMbi2HyKqg34XA8j6fdWpUuocMZUCPHVnj9rri/0HgjoLzzsDZst9TuzjoTbACMFeEYPoJoClDlfGJPiNNbjo8uRB6vcz9EuqkkmjAez00ZxHEhgBGMAVB3+tPMW8rTs5oVLui83YLR7/U6AvSSrvRjNZ1XaHg8jEV5XCYXbSw7STdBq9y3tS1tf32x5vAn3xdCXtRySP+h8eaeXW/RnQVOGVF4B6+GIdOsKUMCpAVmrJWX5TWic3GrCa07gNzIxYtQb1CrMZZhnN6+1sS7QBcBLJF8CVxKw++YyhbRMMUaVw93f7f8tS7RQmDF+A8uKpi7RHH4XHPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LI16CSo2I7kP+qr/VF+Uu6RYgDXdyTMV9siYXHZSThM=;
 b=F6HtflhVSCBps8LG7qLD+xnYzLp/LydI3ehyTIY0UFSSfqVhuGfqA/VKgdCy1sqPzFThtryLvLWOWl5LleVXNbwdIYlX/sK/rPp1qzGzZRIAPp6ARtB6mNZv0qy0xSNG16G2bEhMa4NoZFsrdWN7YKfI6+lxpoQvUGB5sIyJlRgLu/8zYTgBisOX2ApzIULLqCRYMDQ0mA/Mk1OqHLamWfjEhnl6HljHqvGlqZ5PMd7ZVBju52BN94MqtvulwXgb6x5AQP3Z3XatjudH/Ju5ypDRtmJYE6jnxZHuaps+ERaRS+4QaZ799jfDdf6eJ9VwkElenYvrZMs9Tsucv/l0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Akihiro Suzuki" <akihiro27.suzuki@toshiba.co.jp>
To: <masashi.kudo@cybertrust.co.jp>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdaMkEoenc+64zJuQ2SouSfE5reZ2QAL294Q
Date: Thu, 17 Sep 2020 06:58:28 +0000
X-TSB-HOP: ON
Message-ID: <OSYPR01MB53340F547B25852EDB307A28D93E0@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <TY2PR01MB4972733139BD136E3DF656CCA03E0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB4972733139BD136E3DF656CCA03E0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 263b889a-c889-45ae-9503-08d85ad714d2
x-ms-traffictypediagnostic: OSAPR01MB1922:
x-microsoft-antispam-prvs: <OSAPR01MB1922A079D53B434DF9EC21D1D93E0@OSAPR01MB1922.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TtXpMPbAME/fqtzBrQ9fJJcNCh8xl6+n7qI2gTMNDVUu2EyZrjp2PKCCXsJlpJx5xT28ykljUYoWcesNmCdXBRVWiD55ki5ZAUYMg6fsyn3zBAByCgIWsoFbtnTnPUlBwmP17Fqt7l2KEu8BPHf51UV2pDxscJVzbcp4uTHOwY8rxvQXCC2sKvCSKlm2djWMMyOqMyNoAv4raz2mn+nMOwLzJfmvefXe5jezNAZ22N0ioOp5t7cJLWINv2e0xlpoJj3LxHZ5NU6wV7zzLeCiFt5jEEaJP4/8f1OOs8oX5XUZWDPUme5zP3nIaXJEMSCnDeU+BdJ6sVFvWEbigpq+cwMZeXgB4vt/8l4UINFI5iyRBb54O/4DWleCQaAAXNtGwVddog33vb5KxMBGn5/fbDkrQZ5bGqmgzbj5tcZy+6a1l7UGGCVHS4ZwmIXPTyIgUuenIyYnyA95Uq03SE+7wQ==
x-ms-exchange-antispam-messagedata: wlkxfCwRKNfuzvVWwwcNL0FjUraXXBCtzLQEe0Kh7WBWkEN1GWeDs+Tmd4KrLH+GiG3T95CEvddh2+MNPfeWF97Hxaqc9Am6AH76WsQudcuL59lD0Od5dkTnWsgP4TnSFL7ycDGoWCKtWbaeVs3FkZxKY9KsU+P9aGrEeHwQrI0GmaAzCxjkf3xalB9J7tDdZZHbl7gSXWBPQyrXAlapmKNKfo7hzcC2vX5Upga1puGUEhdyyWpAmxhb/oH4VAn9sPl8lecIG62+NXx54j75ViFSa2ESKLn/DlgtxUyLZJoiBSppyGu5d0Z+1Pj2nGx38XNomHUznD5R9JGJtxKMDdd4SCySON5GzissaPk8SWnn54Bq5fqP6vQkgAQ6ne/dCXaaqEIOTaVgCHQrhSx0uDPpLuY3pzFYtZOao9IC+NKn1gMF7/GeRXOznboaYpXnOBFYcDDk60aFE/EKDTBFMD8oCKBL/3BmLQTGVuLn2ObyN4IIVPB9fnxZwmfiv8PvkwURjiOSVs82QF0v4lkgLijcFq2StCmTvYI4EmxMTN5EIS5yWz06xdYNmiQZyKN9X0st+YFEJXCiJiUfnEzFn4Po62qMWT23N30zad2cuem1u0Q8IVevLXCo2J6ht06wRaBGBr4Dt8ORQ962jkI3lQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5334.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263b889a-c889-45ae-9503-08d85ad714d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 06:58:28.6051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6tMAiSm1r3TBPmpB2qrflxKKmPq/eGHMeOPiJ0ARIDiFDNp+AroR7siqX7H5yGNDjFWtvtGN7hYoHTG7xkVnKvP24DB2U/PZm9e6DYK7RE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1922
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: r1vxugl9CqSATq544u94L07rx4520388AA=
Content-Type: multipart/mixed; boundary="MEcRLOx1PPlk9r0Cr37o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600325920;
 bh=2+M1As9WY/C1i6+REPLh1dK/OoXsb7rDuBh5PshGurA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=khMKO9SagA259hkFr9h4AasrCsLcOsNVXIjdKItqD/ZcjlOvSJ63G8uzcZlSzwhCl3w
 E5T3IFPrJxeEdYzS7VyJsHfFf1S4SzQVcNj+Wt1mcQHIoYsEtOU/8wvyzBYKDTHLnZdte
 oa8Gfe0Tk3y2lSdW6mB6rBFbTL2+4F83fTk=

--MEcRLOx1PPlk9r0Cr37o
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Kudo-san,

Sorry, I will be absent today's IRC meeting because I've got a plan already=
 today.
SW Updates WG don't have any updates this week.

Thanks,
Suzuki

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of masashi.kudo@cybertrust.co.jp
> Sent: Thursday, September 17, 2020 10:21 AM
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
> month=3D9&day=3D17&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=
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
> https://irclogs.baserock.org/meetings/cip/2020/09/cip.2020-09-10-09.00.lo=
g.
> html
>=20
> Agenda:
>=20
> * Action item
>   1. Combine root filesystem with kselftest binary - iwamatsu
>   2. Post LTP results to KernelCI - patersonc
>=20
> * Kernel maintenance updates
> * Kernel testing
> * Software update
> * CIP Security
> * AOB
>=20
> Since there will be another meeting at 9:30GMT, the meeting will take les=
s than
> 30 min today.
> If some topics may take long, they will be taken offline or in the next m=
eeting.
>=20
> Best regards,
> --
> M. Kudo
> Cybertrust Japan Co., Ltd.

--MEcRLOx1PPlk9r0Cr37o
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5460): https://lists.cip-project.org/g/cip-dev/message=
/5460
Mute This Topic: https://lists.cip-project.org/mt/76901376/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--MEcRLOx1PPlk9r0Cr37o--
