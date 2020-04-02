Return-Path: <SRS0=EZCl=5S=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44F6C43331
	for <cip-dev@archiver.kernel.org>; Thu,  2 Apr 2020 08:19:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6843E208E0
	for <cip-dev@archiver.kernel.org>; Thu,  2 Apr 2020 08:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6843E208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 26B3F86DDE;
	Thu,  2 Apr 2020 08:19:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 41riPIDEAW9m; Thu,  2 Apr 2020 08:19:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 300D186ADD;
	Thu,  2 Apr 2020 08:19:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18718C07FF;
	Thu,  2 Apr 2020 08:19:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58477C07FF
 for <cip-dev@lists.cip-project.org>; Thu,  2 Apr 2020 08:19:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 475C286F54
 for <cip-dev@lists.cip-project.org>; Thu,  2 Apr 2020 08:19:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8o7e3ZeCjSnQ for <cip-dev@lists.cip-project.org>;
 Thu,  2 Apr 2020 08:19:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mo-csw.securemx.jp (mo-csw1115.securemx.jp [210.130.202.157])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4087986F3B
 for <cip-dev@lists.cip-project.org>; Thu,  2 Apr 2020 08:19:32 +0000 (UTC)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 0328JRfO031476;
 Thu, 2 Apr 2020 17:19:27 +0900
X-Iguazu-Qid: 2wHI1scKEoaz2rTteD
X-Iguazu-QSIG: v=2; s=0; t=1585815567; q=2wHI1scKEoaz2rTteD;
 m=GoFuNVDOVz2YBt85go7sBWRpYeTWJbUPbyoPSxUqLfI=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
 by relay.securemx.jp (mx-mr1110) id 0328JQWI001429;
 Thu, 2 Apr 2020 17:19:26 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
 by imx12.toshiba.co.jp  with ESMTP id 0328JQg4013943;
 Thu, 2 Apr 2020 17:19:26 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
 by enc02.toshiba.co.jp  with ESMTP id 0328JQKt002829;
 Thu, 2 Apr 2020 17:19:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Du/lNejeiCji3dBC3IxNo0SZmzUq3yE4rD/Q5UCOceDQjvi3i54BmAAFtJ+ZFv6g+2S5LxpsEa2m9qcgfgDO/w343diCU96TWSN+QpZX2uuFl4sjcidhcaXULfmjMfK4WeqYjYpv97dRHsqu9F4g7phPib9TrXG5y0ilGhmA0SSvon/6taur3mqNxtub9UuU2FtbF4/Mv/RO13SzwRkcMOeB8fJW5pL17TgiDHeaQ8C2C4YSDlfDMnpte0gz77LbIkmdVh6QH6f2GMTLcAGwcpz8w84dDk4xZ+w31AJ+crZnnusuM8oGfxRwHKFFF9UP0DmbTX5YsFahgG8KjSJv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLaBk3kLh+nDvWiVA/a/S09T+NJPmX8hDsNTRGRlWeA=;
 b=Uu6J3Me0SzrxWBC8NQPOxCwccnyNJlCpGY3omNweGxiBQ/DSeaoXGVr2G7NCvw5I9JgsNfO6KZ0m1+GKJnnf1SO+U3v8x3Dad8X1jpI1IVhuKjUVpVyDv15p8T1A7hHzFYJGLvFBzx8DIMGvr3MUsZJeSLuGnKFk8yPxlhTHZmVN0wLhma3V6rWBeyJhdJYG+R268xOqhKMoLhJEyhPlO3G2a7zbq/28rFJwCcKcWvq0+fRKwit4faTiNuEJzHTo5rGxlhOPlRBeBcGpyTB/DHa+/SO0qodHM0btTg6MvkmvEmRh5R9VG8AvmA7xl7mTHMkYchFRfcjHc4lyt7fobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <masashi.kudo@cybertrust.co.jp>, <cip-dev@lists.cip-project.org>
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdYIhZVqicFEP+tqR9SIqW8yobQpWwAQWk8g
Date: Thu, 2 Apr 2020 08:19:24 +0000
X-TSB-HOP: ON
Message-ID: <OSAPR01MB36671AB755C81D301FF1773092C60@OSAPR01MB3667.jpnprd01.prod.outlook.com>
References: <TY2PR01MB49720341AA7BCA1D28EF8480A0C60@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB49720341AA7BCA1D28EF8480A0C60@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nobuhiro1.iwamatsu@toshiba.co.jp; 
x-originating-ip: [209.137.146.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37db49b8-4fac-4a4d-9faf-08d7d6de8dbe
x-ms-traffictypediagnostic: OSAPR01MB3873:
x-microsoft-antispam-prvs: <OSAPR01MB3873F01BE3F62019E56AE53E92C60@OSAPR01MB3873.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSAPR01MB3667.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(5660300002)(66446008)(33656002)(53546011)(86362001)(110136005)(6506007)(64756008)(26005)(81166006)(9686003)(8676002)(66946007)(2906002)(66476007)(316002)(55016002)(76116006)(66556008)(7696005)(478600001)(966005)(71200400001)(186003)(8936002)(81156014)(52536014);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bAm6cgRjojqzEz94xod2MPbV+ppc61LbLTYn33SXkqceHhvPCxmSQMexyX8otmBAuFjFw4oXdMupckNHpQksGxKTeeXyk6PszzaBgA54CDKx5H8bxmzhngYXksx+4bGxDhGngcvkaCvfgHGG8btnmpTggfsiOiTPOtOeARZr78hn3vJxAnInlm3sYK6OIcYrTZCrwZrsGEFBimadY3cHXEpEGqTFhXAVtx/ffe11QHlQjkNh7zRcHEwRtFSso4aidTRY1Az1OfokBn7aEHQxKCyOKzKtAtgzUot81zphpo8762x+rFLneNTt+wvevw0vDySbCVmG1H6RsGqsvHZZo6vq6SraQus2eMDBka+DUCmY7wpd35LgH5d9Vv8MWSjoaoNifIkqVVVnmBcPRnG3vFoPkQQNuxwUoo5RZHIW2IkXGN25T31+P/gMF8Taz8v23OkV00qryqMTrtMf70i+0MtpHlQZwQ+n8ekdnws+2uD6xbrgcau45rvz8Nx40vdiVp8T4dKMlofo1J0FxazKZg==
x-ms-exchange-antispam-messagedata: aih/xXmFgJs13IdLDMi9wBWoAK+Vw+E1ccjKZ6fMnvw8Dm2GCfT9mRzUlYooa0iWv4f8jsCHs2Kfi0OPfrxTVe3V9XW98RAdXDZVQT4JlsdNyBsI2tn19aZxETJIz/sbYdPrOurPUqPCVh+yuCoEbA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 37db49b8-4fac-4a4d-9faf-08d7d6de8dbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 08:19:24.4718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AjPlfkFi/4h0K472zjTVTnbTKvepESiBbVOJLipCyi1iL2DZ6ksXh8RNDiVRohXKR7qThSj1iptMqh38FRNNTjxz2HbXcEbS/wmWv6F004zJKKyEze7O+L95TMDnQ34b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3873
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Subject: Re: [cip-dev] CIP IRC weekly meeting today
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

Hi,

Sorry, I can not join IRC meeting today.

> -----Original Message-----
> From: cip-dev [mailto:cip-dev-bounces@lists.cip-project.org] On Behalf
> Of masashi.kudo@cybertrust.co.jp
> Sent: Thursday, April 2, 2020 9:30 AM
> To: cip-dev@lists.cip-project.org
> Subject: [cip-dev] CIP IRC weekly meeting today
> 
> Hi all,
> 
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today.
> 
> *Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00
> starting from the first week of Apr. according to TSC meeting*
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2020
> &month=4&day=2&hour=9&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&
> p6=248
> 
> USWest	USEast	UK	DE	TW	JP
> 02:00	05:00	10:00	11:00	17:00	18:00
> 
> Channel:
> * irc:chat.freenode.net:6667/cip
> 
> Last meeting minutes:
> https://irclogs.baserock.org/meetings/cip/2020/03/cip.2020-03-26-09.
> 00.log.html
> 
> Agenda:
> 
> * Action item
> 1. Combine root filesystem with kselftest binary - Iwamatsu-san 

No update.

2.
> Strengthen sustainable process to backport patches from Mainline/LTS -
> Kernel Team  2-1. Workflow for identifying important fixes, backporting,
> and reviewing them  2-2. Prepare the tools to be used for this workflow
> 2-3. Get practice in backporting patches 3. Upload a guideline for
> reference hardware platform addition - masashi910
> 
> * Kernel maintenance updates

No update. But I reviewed and checked other LTS kernel.

> * Kernel testing
> * CIP Core
> * Software update
> * CIP Security
> * AOB
> 
> The meeting will take 30 min, although it can be extended to an hour if
> it makes sense and those involved in the topics can stay. Otherwise, the
> topic will be taken offline or in the next meeting.
> 

Best regards,
  Nobuhiro
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
