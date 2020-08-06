Return-Path: <SRS0=MCzR=BQ=lists.cip-project.org=bounce+64572+5103+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EB2C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  6 Aug 2020 02:43:06 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95ED21744
	for <cip-dev@archiver.kernel.org>; Thu,  6 Aug 2020 02:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="hwR2hYVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95ED21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5103+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Ypc4YY4521723x2ChLNWLOLw; Wed, 05 Aug 2020 19:43:05 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.5342.1596681782918428716
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Aug 2020 19:43:04 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 0762gvMT021131; Thu, 6 Aug 2020 11:42:57 +0900
X-Iguazu-Qid: 34tMSeeoSPTBbpoNgy
X-Iguazu-QSIG: v=2; s=0; t=1596681777; q=34tMSeeoSPTBbpoNgy; m=lSb+7h3Ouq9uvCXddF1GES6DNITnci2XK3/aTyh6DKw=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1513) id 0762guWH006362;
	Thu, 6 Aug 2020 11:42:56 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0762guun016615;
	Thu, 6 Aug 2020 11:42:56 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0762guPH026007;
	Thu, 6 Aug 2020 11:42:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/dox4E+pcqGGMitKBgeDo65VPN20XXCAMpaINWUVVn4tAVuPjLHWz+VazOYQBe3Q1a9/puPsKJ2/iFFs7/fV5p18+ToMy1FGS4buPyC/oSvY7M3sNCMIAcim6SyXjtpULCUyTrSmsS/a6xQylYMEV4H96kOfbJVNoD1yZ8n6TGC6D+bsOBBMygvDlVLoWfhnz7EoOdWrLSebeZZKZiOpGPI16qk/qnshEUIHJJWAHGKCjXj/NQQ+sh7DA7uCs9DQJc1A+hNpqMyq/DmllhPK9a1bdk45iesYluBOMDUgj6qsvga9jxSQPTl/5MEGuZdXu39jil1B26jpSko3otkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEz/wt8WUQVlbnImTi+PeQZW8D+JXlCskURcUQS3new=;
 b=UsoT+TNM4XXcRUaB3+5c38vkUfFsoeRc7fyRjNdUB1EoBf8DX0utQkvgS6nJvqEE+UJwaiMebYIp1ALnDqgKiHvs5Rg5BnDAz1NeaAm4noF0NwVJW9k2xusQiZ+xWQP4uOCQhKLUazVG6C8mc7Mi+ZNBCNT5quCdJpEQZnBh0FNcBbWxZjDZ+4Y6kppi9BWMa6nQK1jFWyIly2p0SrAL155kKpmDF1jEDZ2oSbFXzONx0QYb9IA7mwtyQZERRVm6S7gmxQqWq1m1P9n0f2cQIZsa9k4ecpK0DMhcWYs+1X2U8XPuZbhWAp9iRglVoFUsoLXeBidl2hpIPVU2DfYEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Akihiro Suzuki" <akihiro27.suzuki@toshiba.co.jp>
To: <masashi.kudo@cybertrust.co.jp>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdZrg0gU8V9oy5dKRZSf58YyOjpD/wAFnoiA
Date: Thu, 6 Aug 2020 02:42:51 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB5340485186F49B5BE34524ADD9480@TYAPR01MB5340.jpnprd01.prod.outlook.com>
References: <TY2PR01MB497285E1CEF6341915A14DF1A04B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB497285E1CEF6341915A14DF1A04B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [124.211.28.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 684097c1-0f10-4c32-56b7-08d839b269ed
x-ms-traffictypediagnostic: TYAPR01MB2960:
x-microsoft-antispam-prvs: <TYAPR01MB2960F14AA6C228619AD2C9BAD9480@TYAPR01MB2960.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GYo8VokaBfg+5W3OwwMEy3QXRC+y9xCavazA2oJqhyzNCQ5KZdewRrJCv8kw/QBloo56soFBZP3/M0fyPvY3FCSQAOaKeY/eICtDd+ZViNNqUYfQBCtgdrAxjc3Vh4oWFv0u4pmDaTr8hGJ5gDAgEv9l729mf0EQaRf/d5VTKbu1hHspe3htZJiVsQcJqA/ymbFCqdWk4V2Ys4p0+UTyiizWIElikYYciCKErpAyGjWvrOocQ61Tlu7XEIC/j+KlBehskqfqkBP159sjNzNS7uXxi3EDnYeHcuNyo9SFk6rKbvkPw/H/0CV1FO5U4OF546ic10PLZuGKOoK3qQnj1HQphsrkAPXOIFe6J0flJuABgDWSfyW/su/ezUhYzn4fMy8iu1p9sHMfPahDDSOttA==
x-ms-exchange-antispam-messagedata: JOur05L2IRFDUrZ2vW521uCbTSQi8SbpKTkXbTNDs+EBIHUkAxczEbEOBoY21B57sNigNtjgb3DRGnLFg6BZsqwcFGbT5BAeIEQTZN9lRQ4JWDugG3LTQmhJlYPoEc4rRrjU7vsl3QQ3dv0Fkgj5gIjScrQMuj3tLYbDLl42QCsK7STSItzcbY85HvdYVbsHqvDwE4SmS4UJl+hXhYS+mIVafPkxSAwB3ctsjclnnqct+/IKiEadMCP1HQcrdWQNYnyw+G6yJIq6BdDO3adCYsEaCt1xzx2ILQanmV01JqDVanF1vHSuo/SXJZ5Qp1TJsMbhs6Rxo5nu21oYR9RF1R2R9Qc9RP9o5L/bAzD4u20aMzgr6TyBMar28vwcco4kBKuH1vvWca5bxSLbrmkMWl7iDD7F0N8TB8t/nDKzJzcM94gd7M+JwYfi4KfMDQs5mGLdNCMgahFB3kDQML2aUD5Ooa44pb+LmTYtrMtcMPo1KUdy1HLgmTSMy8ecYmDPANKp1asAww3MuvEwb5HH1nYq2uCXWuN7HkKGBHsH/FX2Wrwkyt9kkmQLBI+xy4HnkDh/OPTUKL0t1glNh20s/9FpCXoRhj9uE6eT1Ms+j5PZFaVvMGZIXwG+oNuSNU7Ul2xWcyKf8wPVvGGlIk6Aqg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5340.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684097c1-0f10-4c32-56b7-08d839b269ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 02:42:51.5953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDDSelj3vqVIOQv9DcdEQChlBo54MT+XQP5tBW/UQmYOhjdS4LBOthTSFB0vpNgDRRNK/6o7ES2qlREoAix7bgXkqgVKIh2G1zJpmeKxLbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2960
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: RBd423B72VH2Ewn63uaPuTQEx4520388AA=
Content-Type: multipart/mixed; boundary="Dh8I25meDK8fprshIX0g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596681785;
 bh=CEMYOKNOu99EpYyJswIKvR8IQqy403ko33ZjhTrqYIA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=hwR2hYVhajcUZrv9ZZkawW8tH/pPtuckvT3K+kRldU742ROT2WPLpJIgcS5wU59wA+o
 1khEazljupVW1d2QJoCjrGIxx0gGbgAmYquWi4D65iLe115XtyZnLhKgDl33+5FPIG+dJ
 T7UsblmYb7pXpTyGwMmdOPoka401plcW2Zk=

--Dh8I25meDK8fprshIX0g
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Kudo-san,

Sorry, I will be absent today's IRC meeting because I've got a plan already=
 today.
SW Updates WG don't have any updates this week.

Best regards,
Suzuki


-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of masashi.kudo@cybertrust.co.jp
Sent: Thursday, August 6, 2020 8:51 AM
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] CIP IRC weekly meeting today

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

--Dh8I25meDK8fprshIX0g
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5103): https://lists.cip-project.org/g/cip-dev/message=
/5103
Mute This Topic: https://lists.cip-project.org/mt/76018886/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Dh8I25meDK8fprshIX0g--
