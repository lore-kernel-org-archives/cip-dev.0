Return-Path: <SRS0=K/mb=5E=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672E1C4332D
	for <cip-dev@archiver.kernel.org>; Thu, 19 Mar 2020 08:17:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1973320663
	for <cip-dev@archiver.kernel.org>; Thu, 19 Mar 2020 08:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1973320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DCCE6204BC;
	Thu, 19 Mar 2020 08:17:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pJJ-NzL6-xub; Thu, 19 Mar 2020 08:17:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D72BB203C9;
	Thu, 19 Mar 2020 08:17:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCE86C07FF;
	Thu, 19 Mar 2020 08:17:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9B50C07FF
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 08:17:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D579F87FF7
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 08:17:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a9mhpoi4lwF4 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Mar 2020 08:17:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mo-csw.securemx.jp (mo-csw1114.securemx.jp [210.130.202.156])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DEEF488263
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 08:17:49 +0000 (UTC)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 02J8HhO5017167;
 Thu, 19 Mar 2020 17:17:44 +0900
X-Iguazu-Qid: 2wHH6kkKp4bzzIiGKA
X-Iguazu-QSIG: v=2; s=0; t=1584605863; q=2wHH6kkKp4bzzIiGKA;
 m=URKfCrwq/GlDe4t+Ske77vY+J4xufoXgBbm8GHwymlk=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
 by relay.securemx.jp (mx-mr1112) id 02J8HhcT002094;
 Thu, 19 Mar 2020 17:17:43 +0900
Received: from enc01.localdomain ([106.186.93.100])
 by imx2.toshiba.co.jp  with ESMTP id 02J8Y1jb013557;
 Thu, 19 Mar 2020 17:34:01 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
 by enc01.localdomain  with ESMTP id 02J8Hgou026025;
 Thu, 19 Mar 2020 17:17:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NS3lacNEJ90q3AyGbJDrtkmlPFxLaDBuZb5LWAkatKbPOoJojdG9zGRIrzcfRr523FW1AjWvA5YM1Ec7HrF4q4CVStyYWyCUbcv1inMC2TYvLDvK0YdpIB6ktZj/FzwadeT58N7pTIChrsbMcOCyWdLCt++31UsgPaIr8MIx+yge0IB9R2uOHSYjzP+c4uEExXWR6Suuy2ozd7e0UjCNuN7DTKVjafM04TfzqFR2ZR/89oEN40eqfwd/jb1xKMfR9+MmWr2C2bXbvgzWuJ7onLbAI4dz6FpqlcdtBbV/FsZbux5QUJdFdQGu+21Q69D3Btu9WHLAociIrz8RkvvX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VN/h+I3dQeV2U+Ls0Tlne6JGsJuGwm86iOUDecDIpT4=;
 b=lXwCAn+wn99ok/Yx9WUgUcavQCeycLSdMSwnHxuO1qV5LRlQNT3mrM9bSRSyOw3OM5qAuriuSuEHHIhL1AlW8qRlZAgU+YNYpUrmKza95vYSpXa3xQPm2M5GfxHJzJLU4LbAByceCWJt8OUG+M3XdYOuHc+qsXRPGzq1Zch11V4GpMMmSYi0lsvZ8k63pFu9HYbQjNksipq5nbllrl0fzvIROaClCFIP6tK+4mptPLgUBSpaLSQdwfgZcAvgcqq7f72yr0BILW421XIW+svM2BmkTLPFbVjc0t35aIMJwcfpVT5599J1xMVHnJEbWMxw2bt6lDGJ5P11PntFbC3E/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <masashi.kudo@cybertrust.co.jp>, <cip-dev@lists.cip-project.org>
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdX9dX2slHPoB7r7Sb+Plxao3vu0vgATX9EA
Date: Thu, 19 Mar 2020 08:17:06 +0000
X-TSB-HOP: ON
Message-ID: <OSAPR01MB3667CF267705F5E8A88BA0FC92F40@OSAPR01MB3667.jpnprd01.prod.outlook.com>
References: <TY1PR01MB1481511E8091785C5D10BAADA0F70@TY1PR01MB1481.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1481511E8091785C5D10BAADA0F70@TY1PR01MB1481.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nobuhiro1.iwamatsu@toshiba.co.jp; 
x-originating-ip: [209.137.146.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 216265f7-cf3f-4ffc-3128-08d7cbdde9d8
x-ms-traffictypediagnostic: OSAPR01MB3250:
x-microsoft-antispam-prvs: <OSAPR01MB325037A058AA7A5D27750EFA92F40@OSAPR01MB3250.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(199004)(110136005)(71200400001)(5660300002)(9686003)(33656002)(55016002)(52536014)(7696005)(6506007)(64756008)(8936002)(66476007)(66556008)(81166006)(86362001)(81156014)(8676002)(53546011)(66446008)(316002)(66946007)(76116006)(966005)(2906002)(186003)(26005)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:OSAPR01MB3250;
 H:OSAPR01MB3667.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GV8x5d+Vfwe4eRhflTUCdEFQEMrzC5OOM6Tb13gMmtAqsDAYerS+VKHdtRSJwnlDHiX68Aqh6/cRpZj7NnbHCtvUujpgjbWKGM0QerwsDznYufiwYmetokmFd5mq3hFEGFfmIMwhR1SrfpyCz7X7URavnOuYdu2lRskuoj34iVuAOou6F6vqk63zoDHUplBe5nNcZcvji/MfsmnUi3TXnxzhflRBtGCI4KlNBjzKymszG2m0n5vV1nOwRM0gehVSmUik088TfPtAa5eIz5H76AXPFmlRkUT6JLGYOLvvHcRfDVSxM/HqzKLgmw08LQJ+DAbkREOUgWJET/m8F7O0PHcfAx4e1o75YFFJ6SJRPRUqRzm7XSntoH6FNuvsY7uA0mo1JDsEAo5eNnQE+Tt+kmIQOXED5NgI6WL5f/Dff3NRPGuC4xWljlhBs7t9nErXtOid+DLdEzYTGSzbEFja4tKeR+IdsSGg5NNogAvDsX9xbyYJsIadHOPhGgHwAfusw4z68z0KdLk1CznZ9hU2Tw==
x-ms-exchange-antispam-messagedata: MTFL1UeOYY0WzVUGBFTeLg1c81GXO+tMw9AM6iFjE25qWWxACuLLUhPC7wAih/jg3R0HERosDjcpemJ+78XuFetjWyCYfYbeiN9LmSlkrWgpraAt+DM0ehjviSyLCx2SK1PsaXOLtES8x1/MYpq/XQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 216265f7-cf3f-4ffc-3128-08d7cbdde9d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 08:17:06.6335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qc8W5R/4O8MGX5lNVkNOF9Se//EWqJ5rim6SrsCVdWC/jNel2XxACmKz231930G/gr9satg/UV7SaXdHoKtndn45MRamakb3nwRuEwnX6pZHzvo3ZYhYlMmT+A1fsGoH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3250
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

Hi Kudo-san,

I can't attend IRC meetings today.

> -----Original Message-----
> From: cip-dev [mailto:cip-dev-bounces@lists.cip-project.org] On Behalf
> Of masashi.kudo@cybertrust.co.jp
> Sent: Thursday, March 19, 2020 7:36 AM
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
> &month=3&day=19&hour=9&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241
> &p6=248
> 
> US-West US-East   UK     DE     TW     JP
> 02:00    05:00   09:00   10:00   17:00   18:00
> 
> Channel:
> * irc:chat.freenode.net:6667/cip
> 
> Last meeting minutes:
> https://irclogs.baserock.org/meetings/cip/2020/03/cip.2020-03-12-09.
> 00.log.html
> 
> Agenda:
> 
> * Action item
> 1. Combine root filesystem with kselftest binary - Iwamatsu-san 

No update.

> 2. Assign the owner of "CIP kernel config" - masashi910 

Note; If no one is owner, I can do it.

3. Strengthen sustainable
> process to backport patches from Mainline/LTS - Kernel Team  3-1.
> Workflow for identifying important fixes, backporting, and reviewing them
> 3-2. Prepare the tools to be used for this workflow  3-3. Get practice
> in backporting patches 4. Upload a guideline for reference hardware
> platform addition - masashi910
> 
> * Kernel maintenance updates

I was late, I released new CIP kernels.
  https://lists.cip-project.org/pipermail/cip-dev/2020-March/004516.html

> * Kernel testing
> * CIP Core
> * Software update
> * AOB
> 1. Summer Time
> US summer time started on March 8. CEST starts on March 29.
> This IRC meeting starts at UTC (GMT) 09:00.
> 
> The meeting will take 30 min, although it can be extended to an hour if
> it makes sense and those involved in the topics can stay. Otherwise, the
> topic will be taken offline or in the next meeting.
> 
> Best regards,

Best regards,
  Nobuhiro

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
