Return-Path: <SRS0=jLpY=7R=lists.cip-project.org=bounce+64572+4694+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F47C433DF
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 06:58:21 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01592072E
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 06:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="b2Dru7Iw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01592072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4694+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id CPqOYY4521723xxIWkNeHc6F; Wed, 03 Jun 2020 23:58:21 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.8828.1591253900473783228
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 23:58:20 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 0546wFCF028681; Thu, 4 Jun 2020 15:58:15 +0900
X-Iguazu-Qid: 2wHHWzHtPoMvWfrfsd
X-Iguazu-QSIG: v=2; s=0; t=1591253894; q=2wHHWzHtPoMvWfrfsd; m=evM2L0NLBi1Lp4iOfayFThoJd5Xxc0XIJsFNwqWXpBM=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1111) id 0546wEwi002340;
	Thu, 4 Jun 2020 15:58:14 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0546wEvd021908;
	Thu, 4 Jun 2020 15:58:14 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 0546wDxP000988;
	Thu, 4 Jun 2020 15:58:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3dH83lPtachX40ZU0wYon3FOyv7cBqtjd8cEq1yXe99ojvL4MFpAFh7S04hAXv+5QCZGn4E2Pa8AlzyJTrm44IdFBXXu303g0YK5Y9f6QgOrNdoYoT7wrgsueHLlubDi3Ev/6WdtIznzgZIY8DcLE7k3QSOB7+KyVqnHxoR5bBfNu/3rZ4bAs9dzfw/U5RToKFXKhAeNTeLvYbWKHDP+lUsqVzjQ9pFhCmX7lFdafeKVvhcErgXPp70fK4cC0DWsippReKhXqmFu8QeIMRzNxQLZatit9UQS9WSIX+io7GUDBiZX3ILcC2hXbhMQPjYl4/vP/lSqKLTLxgr02LrAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiBPmlzrXeoBh4Hpfn7rI+IokkOhtMBw73bT2bJpn70=;
 b=YrKIOk0jOy/WAfXaAOhtGdzlDfOK63r1dpVwDiq6zsVBDy7jtAezNIf9NNpz7hpiDFEgldfaFx3cI0YNLOKDx1vdUBKTp/YJ8/WOgAuYAXV9z0OHONG8BvvOz4HNLgcyFRGOmG3sgTbGPAOLK+cwY22y8LT65wHe6lqCeYjmbS70n/0j46qlX0z/V6/j6QbVqnJhltvAz4LSIuust9sA/FpkdKMWfZQ16wBzExdrNXOjxrx/JOTdaz2Ae4aRIXxgo14JzDIlHNfSeAx9J3f4UbW1oArcJTu1jQHZ3YC+3CuD4JSgYzfjpPCtUrM+9H1jJYGQhq/q8vhznqSqaXdsPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Akihiro Suzuki" <akihiro27.suzuki@toshiba.co.jp>
To: <masashi.kudo@cybertrust.co.jp>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdY6GUi8/ClWh3wURD+LTAYT5PTP1AAI9fBQ
Date: Thu, 4 Jun 2020 06:58:12 +0000
X-TSB-HOP: ON
Message-ID: <OSYPR01MB533454C9EC8FE8E3BC0E3DF5D9890@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <TY2PR01MB4972DC5057F16D60C18E2B99A0890@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB4972DC5057F16D60C18E2B99A0890@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8140932-b375-475a-e294-08d80854a5a5
x-ms-traffictypediagnostic: OSYPR01MB5366:
x-microsoft-antispam-prvs: <OSYPR01MB53667B2E1B5C28D53AD2A37ED9890@OSYPR01MB5366.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zuAOhZUXU/mKFUt/DbivD/OfvqpCm+R0L7/xeXudaCtSu3y2W/dBiA32txBrfLhouxBktr1lTtSzgmkCY7Ln1Kix6tnjXlyUp7JtT7kTd825RGure+XcAyonTBtFeUlxjC8DkQWE9Rcgh2zEa1Mh1yRI7ls25tWzsnLV5YsdNelnZsaqyjqlu50zzZxwEf1YT+srv3YFIJJcQoE51V8khoXpdVEjyljBAfxRRxwXrKZK1O1qzg+kU52/re1kzfPzLi5dO4JnD6fNzeDOGG68UOUZzuDZjy+BdC3d2sWohbD3OrSLkol2TxFikTmejsTy+QBs7Ur8nnRdxkVJOgr0CLYkonoF+7RsFsShQrXg0LVevXrYFPeU0Y20z6WCsrKn9i2pfhRh3aAZVm+48jhjWQ==
x-ms-exchange-antispam-messagedata: H4GkXGwN1ha0tWKsrD1JgzQ3Eb1tITLf+A2N8mWOmLqw/SeQF4GDrUK2g4PrzbUQjm7HJB/0BfZMb+G/eo+F3QqL8mp69yncGnof/v7OUNP5eyvBPazDpRaxwZxRyD5MuHKkU10zMXkyWeU7fHsi7YxdpxE/PwC023EFRjgBHV7D5oJThAC3n+9rq/DcBXWn0CcKrDD4yVxwML5b9krXN/U6b4+BT+I6Agn0pR6zWCAKqPRhXZSd1IcQDhn+aKBmcA8CHc7V09YL+wzrp6e4scT4YHf/7sLonUQRABtystzR7PL0iyG5ZaitESt7YUs2ralpiXhCj1oI/uVwSllof2rHikYdR1cjfLRezJe/BRZDvX+g3sIelFmfrG7kiaeLrm7Qiu5sTsDn+JJa9x8ZUyoDFntwbptXZV8/aBKrj8nGezXYTyqizF/jUM7KKkHR/TIPRPY7TVuM31fYmfsHhnhYxA3+Qgx1y5WiU2CST9U=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b8140932-b375-475a-e294-08d80854a5a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 06:58:12.1804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L7N/fWIKaPiCrkvBqbLLmav35i7HeTopkNzYP/yqAgLw7Cv54uzGdp/1bEnFnnDCbjr9W5AFl7eOqswiJ9CjQLPSRw1nLjdSoeUVFZCNBDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5366
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: CNcvM6NoDc2hGFPAYI2LCUoSx4520388AA=
Content-Type: multipart/mixed; boundary="uAjrcUhVe3sdH8d5IXnE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591253901;
 bh=h1BeUtLErL9LLusrfNwlfMTFEWtvcUZac/H0GNj/hT0=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=b2Dru7IwqIzvS6xeLPZCsAxLa5lCg6UAmgoFtrzUS90IIUEmg8u0EXBDiCqpJu/K2qi
 At/7/re6pDYnPiHudRTlhdZDv6vYrUvFEM0Jf6KTaghSMAYDUqvvGHuckl7i+mFg+3blw
 /YrBhs+7v5wbMpg1l8dT4+OtVnFcONalAcY=

--uAjrcUhVe3sdH8d5IXnE
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Kudo-san,

Sorry, I got a plan today. So I'll be absent today's IRC meeting.
SW Updates WG doesn't have any updates since last week.

Best regards,
Suzuki

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of masashi.kudo@cybertrust.co.jp
Sent: Thursday, June 4, 2020 11:39 AM
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] CIP IRC weekly meeting today

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mont=
h=3D6&day=3D4&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&p=
5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
02:00	05:00	10:00	11:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/05/cip.2020-05-28-09.00.log.=
html

Agenda:

* Action item
  1.  Combine root filesystem with kselftest binary - iwamatsu=20
  2.  Strengthen sustainable process to backport patches from Mainline/LTS =
- Kernel Team
  3.  Upload a guideline for reference hardware platform addition - masashi=
910
  4.  Post LTP results to KernelCI - patersonc=20
  5.  Ask board owners to review reference platform configs to optimize bac=
kporting - masashi910
  6.  Check CVE and Patch: NFS client (CVE-2020-10742)  - Pavel-san
  7.  Check CVE and Patch, Bluetooth BAIS attack (CVE-2020-10135) - Iwamats=
u-san

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

--uAjrcUhVe3sdH8d5IXnE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4694): https://lists.cip-project.org/g/cip-dev/message=
/4694
Mute This Topic: https://lists.cip-project.org/mt/74664504/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--uAjrcUhVe3sdH8d5IXnE--
