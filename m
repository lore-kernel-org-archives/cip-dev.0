Return-Path: <Amy_Fong@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1115BC433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 14:09:52 +0000 (UTC)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web09.32090.1641823790413510681
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 06:09:50 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: amy_fong@mentor.com)
IronPort-SDR: 
 sHR5UYX5wOTIq3L4mFea025cNO3YAadi6Wizh02ul2WQHcYDIFh8v5GiiV6O2sxuAZmmfLE+FX
 MKa0xd4rTNUdJADIGmHzcn7CHdtx3i3bYeHwnY2xFq1SYD3wlB26LDyPGokcwpdfx3nyT+dfVW
 1quv5XHbeBJmndkcasLPJLBa1SFOPGN1UuWa16mQfGO8h7+H59caZo8zsBd25DyqyvF9rsPazu
 ZGs0r5ZkkzdvX/FnEIpQxiwlCfi2Jhn7oc5bx17l1NSywiV2a5yjlFW+/8X9YZFKswdUkfwAk8
 0BI5bs4DhFtQuQyE/KzCKNyo
X-IronPort-AV: E=Sophos;i="5.88,277,1635235200";
   d="scan'208";a="70569523"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 10 Jan 2022 06:09:49 -0800
IronPort-SDR: 
 6Y8zm4ldWoN+NNcJDb3xzAgYG0F5f+gcsvcBPCeVtbgnEq1gsgVoKu5XN0TVzaBAYNN7+owJy2
 a+o43CB4jZUv7okBvgtF5VbA8IV7PS7k8ko3drjr7eVJZUEf/rScbtacTN9Q4I1VPtnUbjXJrj
 f1aB2pRF+smkuIHTGoYxGdpfVMzFpS48P0YDjdNluMqEJ+aXYKrKgas9iCRi90SEOukSgyj8Wx
 F5phDWi57qytVJ8HmJWO4I5R6piKzveOy5XZ+0GHfM2X4qre5HBUKUuy26ZrqOEhRuCk8frIyG
 Z8c=
Date: Mon, 10 Jan 2022 09:09:44 -0500
From: Amy Fong <Amy_Fong@mentor.com>
To: <cip-dev@lists.cip-project.org>, <nobuhiro1.iwamatsu@toshiba.co.jp>,
	<pavel@denx.de>
Subject: [PATCH 4.19.y-cip 0/6] Backport netfilter: nf_tables: autoload
 modules from the abort path
Message-ID: <Ydw+KNoB8couatmg@cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: svr-orw-mbx-10.mgc.mentorg.com (147.34.90.210) To
 svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 14:09:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7427

The following series backports netfilter: nf_tables: autoload modules from abort path
which fixes the bug mentioned in the following:

   https://syzkaller.appspot.com/bug?extid=437bf61d165c87bd40fb


----

BUG: corrupted list in __nf_tables_abort
Status: fixed on 2020/03/17 22:09
Reported-by: syzbot+437bf61d165c87bd40fb@syzkaller.appspotmail.com
Fix commit: eb014de4fd41 netfilter: nf_tables: autoload modules from the abort path
First crash: 717d, last: 710d

Cause bisection: introduced by (bisect log) :
commit ec7470b834fe7b5d7eff11b6677f5d7fdf5e9a91
Author: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Mon Jan 13 17:09:58 2020 +0000

  netfilter: nf_tables: store transaction list locally while requesting module

Crash: KASAN: use-after-free Read in __nf_tables_abort (log)
Repro: C syz .config

Fix bisection: fixed by (bisect log) :
commit 34682110abc50ffea7e002b0c2fd7ea9e0000ccc
Author: Max Chou <max.chou@realtek.com>
Date: Wed Nov 27 03:01:07 2019 +0000

  Bluetooth: btusb: Edit the logical value for Realtek Bluetooth reset



