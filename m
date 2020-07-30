Return-Path: <SRS0=GGOo=BJ=lists.cip-project.org=bounce+64572+5063+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C39C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 08:39:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29CE5204EA
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 08:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="lyuzGfST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CE5204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5063+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id O20lYY4521723xNsw4QV99rt; Thu, 30 Jul 2020 01:39:41 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web12.4281.1596098379762726738
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jul 2020 01:39:41 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 06U8dXUw022323; Thu, 30 Jul 2020 17:39:33 +0900
X-Iguazu-Qid: 2wHHsainSNnMTe7UOI
X-Iguazu-QSIG: v=2; s=0; t=1596098373; q=2wHHsainSNnMTe7UOI; m=bO8nCNdfSDxN7Yzn/NW166UExojil2Q/BI0jvenB5/Q=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1111) id 06U8dWRX018739;
	Thu, 30 Jul 2020 17:39:33 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 06U8dWUk009753;
	Thu, 30 Jul 2020 17:39:32 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 06U8dW32005153;
	Thu, 30 Jul 2020 17:39:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5kiC9NtUUE6jMUhMZbCXsPvYQ+xvbZK8hzVR9Un9Iafzo0tjBQG/jA8j/LYRM+hCR9d6L0M0Df/Ftd8hjSWBQbiaSNf4o7grefjVLiEQfHm9946rsjstWTUqERfdjcaIhmBqxVuY7kwFdRKxc3xuowDhbf7ZiVE6jgoGnt9SUf9/jQWGwv0aRQbiZ0wVAKWVdOohIlMPriMULJhzQ1RdfjKMxRlyqXE8ViktRNDzRY3xP5tqzHSh8ecOJanZaHOWcby/HOdj9mzZV6axtv9MI6w700gy50OubpnkEQBQA/k7oSBVV1CnhrF/0uF5OQZv4dZSXcvdkH1GMCQHZW8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2uiJK1miB+PBnwSx/QgxJ+tpaAcRCWPPn2TMhhjs+0=;
 b=ZCUCWsldEaJj76HA/rfWWw9Bu6EnAtxuaKTLFDVaUc/FR5EMvgRriOLQNcvAoE9bmbjLSiGA76hsPX36Hrkp3a+S5bTG/w7SXOdNq7o2MTXRKWyMYZJQvqJ0S63tp+XtpzCvPftE2KzMmBwItQ8wMYXaKOkbro+XVtzr9rb++2zg0MzPaMC++54gxJvidabiVTXN4GM3O15y5baSh4Tb9VjQJzHH4hO/HvyDl9E0DBJFc2deagMFUMC54DI/18CWc6kdZrrG242cETYOADM/dKMi7B3bJiUswrYUMreJ1e01tVQk66Be/AVz1i1Oj0WfDbUFAJe3WtaABhNdYq1pWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Akihiro Suzuki" <akihiro27.suzuki@toshiba.co.jp>
To: <masashi.kudo@cybertrust.co.jp>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdZmFKJ294ZreUmzR2eGB/pCjYQSbwAN0dgQ
Date: Thu, 30 Jul 2020 08:39:29 +0000
X-TSB-HOP: ON
Message-ID: <OSYPR01MB53340E7A5C5C3BC2B05AF484D9710@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <TY2PR01MB49720968B08C56B3122950A5A0710@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB49720968B08C56B3122950A5A0710@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5e51c62-1c27-47b3-9f53-08d834641370
x-ms-traffictypediagnostic: OSAPR01MB5105:
x-microsoft-antispam-prvs: <OSAPR01MB5105931475437C180E68E172D9710@OSAPR01MB5105.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pmE79jiu1X/yKdx6VBHMPsbPELIusbI9vfXLPbGvd6o9iBWWglfLlPS0/uY2+pxH7e+/QwWYfWq/rjuG2RewfmkC35HCKKFr9FO1FmLUrcK81gNr6GBsc3VvlF25UCjpDHIO0VTRL3Ut0VXik8EZrlIg/s8r/EJC63dMRli1W7//3wynqNoQ5jg65JnRE0mUa3VYPBc13D+/I+YkrWWZb/2DPR8eTkT63RxEbgLMkZjPG9b2LfPRowOrx180vPd+FJD27bnZiBY1w0ojeGg5HG+xUAiQGQpYgFnudaLcC7DRZfKsze/XFaL+mX/4uMBPIN7/Y7kuH8MYpREE8uL0UOANmvlJezaR9WbneczNXeKm1A6as2Jsa8Ok4bjryTJX5coG6hHMy2WWUhvTpvT/+w==
x-ms-exchange-antispam-messagedata: talxP2zHi2FbYg8QdfjXeP1VJBPNQud4RmYrzmwb+z0itxzc9/HBoSixs0preYcYefBA27KirAFKM0ux2AG1ISXZY3Ug9VizsrdyvOtpUpirwAG61rs6dKeaZRqq7Zr4f32QhCjJ9e0jcaeqYUflQo8DWaxnCFLGjiKlYlcRYAoCrzF166XoRZODggdUAfJLbPeKgj/b5JVoc3dHacIBEEV0wQxVwb1cQyss78nB3cYG0wkJUX3oqGBAZnXBB2Oi2WzWHsHBKYnzU+FbCII3Ut/uvx4oCXQtdEi2atNPmXwSf15wD9mAf5FlQGDCB2gaCQjH5HT9WfwyNPQgoZfx5xW8d63ijqszGmyfYm2JrWT28lZqUIAzcDk//1k5ndxhFF0LNG7OIpHAwp9eg94+8thPTTJIG9zg4Hij16GxdrPhHH48XlsY1vYBOXNi1VcslbBlbEnB3GHv9ZD6s/Onlulv3Txo+U5M6RN2JllcdyIJ/fSPqC9T7sheHg7WM5hxFtuRZpA4k5eGqqrcZKtBRBSYoomnmQK0biI1e5TmiI/XVvtLAs1ExhLgVNUVQCLBTh1dmTBFcbGJ/M6OsGKxaZWIgKGpwLYSoqYiTRfXmx5SnPgRyzlXAtlQHqq/tRajlcb8/4DOhPyjCuAHOR1rJw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5334.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e51c62-1c27-47b3-9f53-08d834641370
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 08:39:29.9481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bWu37nXm6O8I1ejQ3kBVvAoJrBIOxWKUDCfS7kz95oJtevxv+r6PTZ8ru63oYM+Tx7syUBYqChUeVApvftFbTv7MbaCvHwoOaRgp2dtiwds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5105
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PAYwSEvy8scQZ7egWJDrqxv0x4520388AA=
Content-Type: multipart/mixed; boundary="fXjMgigJ1UlwL1HUJN3l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596098381;
 bh=BIyupu+4NMMZjV8IB1sTv6SoXUYvM6ZXGo5AluuKV90=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=lyuzGfSTctNkAydPh3g2UT0nI2tL/jKk1gajk51aZACEHEyFQzTLqBDGCmJNNGTPSYQ
 ST2HEXHYJnVNrPumanExhbfX1IFivotdC2tbEut7yfqg2XKgjGb2yiKuJaJCTkB5LVXfH
 h/AIP1kbdT36GSQDIWiR0qGWaCkThX+ujgQ=

--fXjMgigJ1UlwL1HUJN3l
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Kudo-san,

I'm sorry I won't be able to join the IRC meeting today.
SW Updates WG still work on supporting HTTPS connection between SWUpdate an=
d hawkBit.
https://gitlab.com/cip-project/cip-sw-updates/cip-sw-updates-tasks/-/issues=
/8

Thanks,
Suzuki

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of masashi.kudo@cybertrust.co.jp
Sent: Thursday, July 30, 2020 10:57 AM
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] CIP IRC weekly meeting today

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


--fXjMgigJ1UlwL1HUJN3l
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5063): https://lists.cip-project.org/g/cip-dev/message=
/5063
Mute This Topic: https://lists.cip-project.org/mt/75878882/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--fXjMgigJ1UlwL1HUJN3l--
