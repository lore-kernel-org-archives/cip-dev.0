Return-Path: <SRS0=qG5w=4H=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23836C5ACC5
	for <cip-dev@archiver.kernel.org>; Wed, 19 Feb 2020 23:10:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD499208C4
	for <cip-dev@archiver.kernel.org>; Wed, 19 Feb 2020 23:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intra01.onmicrosoft.com header.i=@intra01.onmicrosoft.com header.b="kCgPy43w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD499208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 99494877DB;
	Wed, 19 Feb 2020 23:10:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eFCKNqQL5C9o; Wed, 19 Feb 2020 23:10:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 87334875DA;
	Wed, 19 Feb 2020 23:10:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61F64C013E;
	Wed, 19 Feb 2020 23:10:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C970C013E
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 23:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EA82D20113
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 23:10:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03r5ttOPuLHX for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 23:10:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410127.outbound.protection.outlook.com [40.107.141.127])
 by silver.osuosl.org (Postfix) with ESMTPS id B5E3020781
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 23:10:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CScaU4g4EYndSelBA9l9Nz94r+kUgiEy0FBWB3TyVCfN5HvuHbmpd4VyvbMWwKcRNDnKbC1Sg9dNpzUJGAnuinw0pquuiROxZPbPHphVdcrqk7G1ZYtfu3Xb3JHip6BoCryU9pmgO9/0Sf0I+io6ppGc/BiC3E0/+pN7c+O6qdM34QeLkTB2FG0pSnQlmJlXyq4vgqOUmNLewcmj/4ASO/KW5OAZ49OTSAGE4b8O5hYR+49qQrE1s07ZLb81J2u54GNkUWHZe/70m+zzMVJQniJu57bOAE1qHEOQ3QrCgsrEI3TBBu/bVQivOOmr9fUzQl7591Mg+gbEDwRCZjd2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+oGfSoWC+kt0mUKSfgumORZS+UatsJGrNfBzRY3yoc=;
 b=Nh0Ug8G+OozaQLHSG18D8WmQ4D1v7TNLPhr33EN0/CbpZmSDV6hGRxy46E8huKtq0arwPQO7+gpwXL9Pp+jq/haXVgmppD1dD/ylrWKRH1MGLFzCbb+Degwb0LFaT0vPOyP1f63I2UZ9a03CcGDL09UWt0ZoAgO1JS+9hRD/ur2XoovfJ/yhB3np5xXzwtVhvH74JDmQzvM6q+KcuR2EjTS7jzKlLMMgJBNb9+cR70g/joZmgF+rLW6/jZXQKdpIHk36HwD0rvAwjZOU0Vjd4C8NGPMVFb5xPKK58AOEhg6qM8efLn5GI5LOeQOA2K2etWF0pwxRpjzubLe9diDDPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+oGfSoWC+kt0mUKSfgumORZS+UatsJGrNfBzRY3yoc=;
 b=kCgPy43wULuOqA9GTQdOQWfJ32voak7T9+4AuLo8qemZDl/VihXLWG1LQkJePZPWIlTwhlbylMDCvFqjvIGrGFEZtgDELvwug/97G7sT3fm/nlQZlfG68igWKQUobUqm0LwsUeizd3KUaZqBYmo5VocRYmC6KEqoVarO1x+I9E0=
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com (52.133.160.148) by
 TY1PR01MB1817.jpnprd01.prod.outlook.com (52.133.162.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Wed, 19 Feb 2020 23:09:47 +0000
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::503f:3885:b1d9:a8c7]) by TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::503f:3885:b1d9:a8c7%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 23:09:47 +0000
From: <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdXneYZWp9c4G9wlRSKo+oznYJPNTg==
Date: Wed, 19 Feb 2020 23:09:47 +0000
Message-ID: <TY1PR01MB148173EAEA2696FD4BCC4CEEA0100@TY1PR01MB1481.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masashi.kudo@cybertrust.co.jp; 
x-originating-ip: [219.123.27.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c0660bdb-5ab5-4cd8-d46b-08d7b590d094
x-ms-traffictypediagnostic: TY1PR01MB1817:
x-microsoft-antispam-prvs: <TY1PR01MB1817640B122A5FB68437C2F6A0100@TY1PR01MB1817.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(199004)(189003)(6506007)(86362001)(2906002)(33656002)(55016002)(9686003)(316002)(85182001)(7696005)(26005)(186003)(8936002)(52536014)(6916009)(66556008)(76116006)(81166006)(81156014)(8676002)(66446008)(64756008)(66476007)(5660300002)(71200400001)(478600001)(966005)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TY1PR01MB1817;
 H:TY1PR01MB1481.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bDAZH/Bz1gMoFhYG/FvCoCN9wgS65jinT3DC6O40C24Hhhb/qZx61K0wDuPCNaaE8KN+aChcIbUPgcuXpSlSG2bJnKKJAp4Y/bABXMYsDeSAsse8xamH2LBuOuAheMax8B0Qdi4xd3+O1aO3+DRsyeUdi4h79eAGu+zHjaZv7a5LDUjmS9yVcTBFPY1WqlutWdd15i+LLqOWoKzN+tCkmgPjkWV78bh/TFd0jN78GFkz9lbtwkM4tr+brwaxXXc32prYIUH1L5IzfUvG7YC2vT8bTt3pBEeAF6SH01tmfgn6NfjgrvscPQwRST7nOQ5+aV8W3vhwRhvyQWd7cZlTYYIQXYTX5rubn67UTwIjgDT7mn5KWbXsAQgsiiCcQ+S5Bd/eCtkl0D59No3WRWtj7beaMMM0h1K/adcPhuQkc3rnE2FB9Fu5wpEjI/0eUpsC0A9TUoIxUwMj49Kk1mFK1ctw0zpP5arcyZWtCnGIlk38aF1payk+a5bXIq4mScZUwHFKaM7ySjD8NundE/bX0w==
x-ms-exchange-antispam-messagedata: rGXQNXtK0pDnF7xCVPkP9xLd6tqxGToCS6/nI+Dsgg3Io/qzZnoXn2Z+ntPvWzhZRL7yWYF6kGnWSA29H7DTM6mJcIqETKdggKzB2I56fFZX+cRXXn2p/ztNjyYsr4wuW4Eip/SFYBiivBBllVI5ZQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c0660bdb-5ab5-4cd8-d46b-08d7b590d094
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 23:09:47.5117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6qfrRiXyKPPZfbyXlJF7JCVOqQHYOu1KyvNpJG5jjtWZQsh3XyMnjARZ88P1cCeKgoBFR4ZmBhEhVSyiI5FyINpUdBDgvA1Nb3iNkrTMDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1817
Subject: [cip-dev] CIP IRC weekly meeting today
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss technical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starting from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=2019&month=11&day=28&hour=9&min=0&sec=0&p1=241&p2=137&p3=179&p4=136&p5=37&p6=248

US-West US-East   UK     DE     TW     JP
01:00    04:00   09:00   10:00   17:00   18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last week's meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/02/cip.2020-02-13-09.00.log.html

Agenda:

* Action item
1. Combine root filesystem with kselftest binary - Iwamatsu-san 
2. Document a process on how to add tests to the CIP test setup - patersonc 

* Kernel maintenance updates
* Kernel testing
* CIP Core
* Software update
* AOB
1. Cancellation of "F2F" meetings in Nuremberg
2. "F2F" Kernel Team Meeting is now Kernel Team "Call" which will be held as follows. 
TZ:	Tokyo	Taipei	Berlin	London	NY	LA
----------------------------------------------------------
Start:	21:00	20:00	13:00	12:00	07:00	04:00
End:	22:00	21:00	14:00	13:00	08:00 	05:00

The meeting will take 30 min, although it can be extended to an hour if it makes sense and those involved in the topics can stay. Otherwise, the topic will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
