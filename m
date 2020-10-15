Return-Path: <SRS0=ptAD=DW=lists.cip-project.org=bounce+64572+5579+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E8FC43457
	for <cip-dev@archiver.kernel.org>; Thu, 15 Oct 2020 00:20:46 +0000 (UTC)
X-Greylist: delayed 180 seconds by postgrey-1.34 at mail.kernel.org; Thu, 15 Oct 2020 00:20:45 UTC
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="niYkrCRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77611221FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5579+4520388+8129055@lists.cip-project.org
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77611221FF
	for <cip-dev@archiver.kernel.org>; Thu, 15 Oct 2020 00:20:45 +0000 (UTC)
X-Received: by 127.0.0.2 with SMTP id Rgy9YY4521723xAjZbH7doOH; Wed, 14 Oct 2020 17:20:45 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.112])
 by mx.groups.io with SMTP id smtpd.web10.1864.1602721063652479313
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Oct 2020 17:17:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYSklXI+iBcG7QK6bqn4rPdR80/vzTsu8qhCMCLL5S4wjRFwaFeY9Be2w5s3WtDi3kjAnhxUfJ5Ttzbr7/XIU/8/CVJcgMju1lCrKXPXJD3TBZI12HJ4M5mqzKPWvhjyforZr0BYLMk2+2fH4T35EtGlrOmzi0wx8pfPQhKq9JToJTW0hCGmjVVAgg1uzrBD+eN8KF4GIHuEsZVOdCBB7SVRNixHVQGTxPaDo26hXrrdDiBeMaHdmAtFWJzPfvUseEtu2+r3jvtGcAXPTVxVBOyijhuglmFLBXcCuw51dw0UrjZLnJW2JRLvyISBTNR4IFGt8sYuBg408cy8QAEM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+CVSxMCdLqLVdOkEK0nmzzgKaRsoInUD6iauV67k50=;
 b=BsDHXlPw70LG502YqoXNKoBiv/aQE+CJOY47Jb1Xfi2smraDRFhoB6kDZOVc3CAJMUlhHxKOCsp47gkYAeapdMp2mHL636ES3p8H+2YzIIfj4QneFR3kD1EZgEVM9gZOc4jJ9/zSxr/O7urIR+jNAMw269PMsojC8tZsmm0R+vdKVjv9ED/olEqAYSxlK6uThpAZdcTlgoGAk4iUHfisOKdyfhbctRJdE88X36+tPSZNz4sH1VlWbeM2tbs9TCCPy+RnNRk7goqxui/J4wnWA0sSeaLUhvRRcWFcH+GThrjXWDMv0C4HN8+mBGi3PW8wIuTB9ACPr+3XuFoS17ZAkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYBPR01MB5392.jpnprd01.prod.outlook.com (2603:1096:404:8028::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Thu, 15 Oct
 2020 00:17:41 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe%2]) with mapi id 15.20.3477.020; Thu, 15 Oct 2020
 00:17:41 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdaiiIom1B8C+XSnS0ufMF09IAc6fg==
Date: Thu, 15 Oct 2020 00:17:40 +0000
Message-ID: 
 <TY2PR01MB497222C958E67F0B305102EBA0020@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ae3e60d-a8e7-419e-e5a4-08d8709fbae9
x-ms-traffictypediagnostic: TYBPR01MB5392:
x-microsoft-antispam-prvs: 
 <TYBPR01MB539203BFCF6C2792DC1F5C78A0020@TYBPR01MB5392.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 W8pY+aVlUQ/S2QxIql2iAM15dtSoge0Dh2jKkglTH4nZGeTe5l3nqSGhJdQMS6ed689IliwGtvNtq0CmG0WeN54q037i4CevZKFfHVo0jsFFM3H8kq00VfI6k7e6CTc01GtFcOLzNEULm1cxx2n6dzmc718v5tG3TpS9azSIy79M/PBbVs3GzOPd02TjCmPv7/11JCkKfY/fSWds1YrZN3VZ0Kum7A5pdlN2YxgBPBMb8Ixpq2vi3lMpqPtTXhblCDRThhZW4nVNA1S1TXbU5T+uu2GtTT+oQplhlgnLsjH5aA6jmf9RmacEx0c9TW+3tTc66aUKRlZhIMO3eJ47yAnSAqKLawevA+mfZhvi75QxGfrH0XbwzxN5MdCaZvCrRe4M8QomtqxnT49O/oQn/g==
x-ms-exchange-antispam-messagedata: 
 Zm6QGa/+EbE3kwxQI4CcVhRwacYfxVZOH8E0PfzjXYH1447btXcNv3KqTccmtMFZ3ADDlsq32dcX3bQtMUvNQUSpeEMvaPOCCPmxj4m/LjcRrHN62yf4VbNcF3g+cuHWwn2zX7hOKgcdN8XT2nU1up72Mtw0fL0HH8SjbLTb2CIqBObtLuLyUoH73Dbfnf537wzmjxmuNA4Qa+CO5vjwF2f7CvKEOmPtycSWCgkFcFAfqJ5eKJ0rdLsKsu7eOqrA9vjYGCCax3LuXpmSBUbbMMpCdTRNOGfJU8JvbOrwGhFmz28Bhz9A7EH0j32BcBvtcB2sBP05LRViFkJZvNsxcTgRYImp2kFNhpz3ypDOmdamZTGVVjiUNbLehvUvlVSH2e1LD6yrt5edQZH7ZrIT2jeyMpz+l7EkK3bvLO1lfpNEYwkrvftz7+SY3x77FrBvEFj21w66LaPy+cRZQJoy0VwJLOCS5BsD6DsLw0UymcA4C16fQhloV7rqISWAzQLQ7rGQy4oMAoOruKk9fs4vT9PD6QG8Hz5SC7zP2n4Rw19YgRcXCG6C83AnewyCmPJhjbQWNbIRlzHCi4DuhQlZMqjyzUsYaUcxu+1hZyV6d0JWKjYn13lA1My/029aHk/wsrJPOC9iEF4hc8frHZQzEg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae3e60d-a8e7-419e-e5a4-08d8709fbae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 00:17:41.0077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XMAh78dnnIppLY+y/CYQ05hXkTwV4qVT3w6uZYrMBwu12XnO9LY1tw5oy3uP1AqcgOt749px3inN5E6DFiOX9PrCEOfqxEBt4VrAKDumbpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5392
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: f2l9WKkTe1oXFkJDRgzgThYGx4520388AA=
Content-Type: multipart/mixed; boundary="ajUdrozFXoeTx9wvfUes"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602721245;
 bh=db1r3u3qsJXFOzLNwep42WFOo6oaaF/fVtivXIPCZgk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=niYkrCRYAaXtMstDu+aab3crUZGkQnoCnCpJZqCm5h/S70P8sTUTwmzSfCBiOM94K/I
 Pqhj4Hw4Qj1W4Epl9HTZ+8KGEfszuRXZZn17z2nwosxVpZCp7i1/Xrvez1l/YEKUNbR25
 esHQsb2QEx1OZVxBIgRzX/o5PxBnVE54Vdk=

--ajUdrozFXoeTx9wvfUes
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D10&day=3D15&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/10/cip.2020-10-08-09.00.log.=
html

Agenda:

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Check whether CVE-2019-0145, CVE-2019-0147, CVE-2019-0148 needs to be =
backported to 4.4 - masashi910

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

--ajUdrozFXoeTx9wvfUes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5579): https://lists.cip-project.org/g/cip-dev/message=
/5579
Mute This Topic: https://lists.cip-project.org/mt/77518628/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ajUdrozFXoeTx9wvfUes--
