Return-Path: <SRS0=EBUd=CF=lists.cip-project.org=bounce+64572+5274+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A28C433E1
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 05:04:21 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4662C2177B
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 05:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="gH0R0xBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4662C2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5274+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LPCAYY4521723xy4OQHbuS1b; Wed, 26 Aug 2020 22:04:19 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.12199.1598504657296077855
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2020 22:04:18 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 07R54Aen004224; Thu, 27 Aug 2020 14:04:11 +0900
X-Iguazu-Qid: 2wGrPVRPQPvwGnhNj9
X-Iguazu-QSIG: v=2; s=0; t=1598504650; q=2wGrPVRPQPvwGnhNj9; m=QcNWDpp+OCLhUx9i+6MpcPOrTEVbShneJYOV2OB75xA=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1110) id 07R549nj026986;
	Thu, 27 Aug 2020 14:04:10 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 07R549We005144;
	Thu, 27 Aug 2020 14:04:09 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 07R549i2030801;
	Thu, 27 Aug 2020 14:04:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfsY7Y3Qs6mhKj7NehxkziAk9vm0Uq4cc+8EEdNUpJBq361ikjvuzga0jMhoEi5mcW5BjxIzsX/499Uy/iGZZwUARm5o/G+n+Yr2pu2B2M2BsaPAjtmFAo0mseuOTK0lV+kuD3ku90rd2Rfl2+FUGKd96yIXy3fKhlaXm/wyP715cZW3nwZCV6WCrOLFH2iYvyIl4gaQoraZNuCIc0NYVehGHf8QhiooyUrExaROvGomTFrzmNGCUX4g/Thes0HRrROtp2PRHX0090UXw9jCjeTf+SKjPsYdhAiED3RkqeCwqbaVZd+kIa9lJJQnyi+L/3YM+98S5bI9JWkydz+3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50Py5VPg/SqyuVpctgxInDdLDOomWrNdCJ+zep9Nm1A=;
 b=U5PycnxoV1eCVV6DqcRL00jkU4FtK2juLtYTJ8xJvN4qqPDx/P6ttVksHydRvR2wIeyOoMDvdus4/ciEq3yGLItfwYoKTJdBDUronMFZ42VuhgBwReYLqlmvt3UtpcmXxORPTbF3Sjh7NUbXitM8YOocEN9K+AY+xprkWgUJ17avF9O0AnSir0f8dqZ7RtrRKURq+d+Pp5G7iVcHGkGdn8xth8AH5e4I9pyza4ScE14S6l8G5pwJq6Db22jYbOFLEm5vscwmD5fsZXwCx2p6ulxWdy7ewmAT6r7rY1ZDjSkZQbWyM2gU2nzBL4vcNgnE60ggijZz3xakMwkMYBDPsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Akihiro Suzuki" <akihiro27.suzuki@toshiba.co.jp>
To: <masashi.kudo@cybertrust.co.jp>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdZ8DTHOsyIx03xlQJKy1N+xqwWDuQAIc1Xw
Date: Thu, 27 Aug 2020 05:04:05 +0000
X-TSB-HOP: ON
Message-ID: <OSYPR01MB5334EDC2C47C6638FA4A83F9D9550@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <TY2PR01MB4972E3A628C466B108A02A7CA0550@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB4972E3A628C466B108A02A7CA0550@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6ad4b3d-1fe6-4e62-0587-08d84a469fa8
x-ms-traffictypediagnostic: OSBPR01MB3208:
x-microsoft-antispam-prvs: <OSBPR01MB3208510FF5DE755881282D35D9550@OSBPR01MB3208.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 51bSRka8ODlU1esqdgtSEVRiRvIDqVUXDKMP8Ze3DMcsS7Mb5WPg8CuB7Gi/tgsSiVEkrpz9+yl8ZB0k8lrYUTnrzu9RcFZ8Kn4lHp5da/XJiioXcx520zulmssUrSZMIf0jfnxkTlrfx0bVu/U7ZG+njOA2GrFoIGDnsoz9wiTTb5rDyIKSPrNtuDvPeAsVDTkJkTVt7LvpeMbRl8e3vEOnl53r0OHjnG8k9kfLsROD2hV3LF37fgrfM8ok3DIQFskwwrH1Fzo6oiNNG0IBqdVNKtcODIw557mAsEI2p1YgUL51KuC8KSwGKsnbDKaSZT8HgE4eSWMjq1kPLdqD/afiuXxwK1UHtJdseqNjwacoaZHd0CTCWfei9QQ0wlRj940lHC3j1sHqd/wpUOqbkA==
x-ms-exchange-antispam-messagedata: FiO/46zF6cF35jcfssXUCevG1q0RIYCxUGhtLwbdnjrnjXCLLsNgyeb6kO6Ko3wM5DgWsPRejguS0eGOl+qSippNczBZRfbJ3Ovaib6118Vt/2mYZBGhK0Q8nN5sVrtKEk2k79wwNsc4yfcYz7MvFck/S6mGKWVgAm/H2AecpUU0Ri7L86HbUis7clgmXwbAAcy/g44S3N9jZcwrFox2/SMU3Z2MzJ5Fmt7J6Z4KAxBdT6HjhflPpyHIum/8zQ4izv9eqpuKc0dxg3wqTAnShmKaqjH1MIRei5Gz7y2yLOdWqk1uEuSyUNg5Bf2eUOImGlKBKWblpajwRS/dYpOHlVbNE5/pZnkouPSxZoS+SHpSmXCW1PLRRW5RX1wKChQ06ik6iwRuSJYgcV51KpsIQWYcZ2UpBNkd9/EIvOIGPzJY+cVxMrhtOoJ8nQBYi0SLuqfRILl6mVUtrwWL7DJTNYE6Ze+FtgquR9N8oLNhnBirryXe8/Z3jKjowE/nGOdB4x8FU8Svw1yY0DD3nY4tJM7RKOlQw4Fe0B3CqdInPQgyEs6IHY3joY7hEw+LBXh1XDxTz/tPwYk/Y2EqPHWk7088CTnFgaVt8OUJ51aR5SBQFSYgtQNWhJGmY0KbkM9hTAnuY5OSmphmuMCPYUgBaw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5334.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ad4b3d-1fe6-4e62-0587-08d84a469fa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 05:04:05.9341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yaxqH0fERc+8CCOZ3le0aTSM6yrHr2S+dk+DQ4i9+pWeG2/1l23+98meLrnvnPCmAtOwweGfXhnIyClVqQDtrqKUxzbfsLYKPyRpQuoNph8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3208
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: vntHS4Ta23S2bcDr5amuo3zTx4520388AA=
Content-Type: multipart/mixed; boundary="tiMPaiDy8jEhMlY8r7D7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598504659;
 bh=MsTAsscHHb+hMd4SpZ2YkiSRxsrdKI+7f89gjLYV+30=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=gH0R0xBS2ZjmLlQ9vWKR9nopQNwKh7MZ6vojB5wNCngRYt74bFdZScJ4MOVa8vobicG
 QaO1pnBrxGbBJ2iZmtCOGu20dy5QN9DnOWWeLUHUrVi/SeIwi+DcAA74ZoHDhNpFk5pmb
 h60ZwweTNpnvWwIT+TPnvdjnGsS8kOn26dw=

--tiMPaiDy8jEhMlY8r7D7
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
> Sent: Thursday, August 27, 2020 9:59 AM
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
> month=3D8&day=3D27&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=
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
> https://irclogs.baserock.org/meetings/cip/2020/08/cip.2020-08-20-09.00.lo=
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
> The meeting will take 30 min, although it can be extended to an hour if i=
t makes
> sense and those involved in the topics can stay. Otherwise, the topic wil=
l be
> taken offline or in the next meeting.
>=20
> Best regards,
> --
> M. Kudo
> Cybertrust Japan Co., Ltd.


--tiMPaiDy8jEhMlY8r7D7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5274): https://lists.cip-project.org/g/cip-dev/message=
/5274
Mute This Topic: https://lists.cip-project.org/mt/76442001/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--tiMPaiDy8jEhMlY8r7D7--
