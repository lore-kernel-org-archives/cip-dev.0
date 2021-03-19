Return-Path: <SRS0=tD1Z=IR=lists.cip-project.org=bounce+64572+6299+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B231C4332E
	for <cip-dev@archiver.kernel.org>; Fri, 19 Mar 2021 07:22:26 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD3764F6F
	for <cip-dev@archiver.kernel.org>; Fri, 19 Mar 2021 07:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD3764F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6299+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xD3zYY4521723xxlkD1qYZbO; Fri, 19 Mar 2021 00:22:25 -0700
X-Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.62])
 by mx.groups.io with SMTP id smtpd.web11.2981.1616138544251719258
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Mar 2021 00:22:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0TDE6oPZBfqkpef/34zofnI7vZBXqjBDbOckxy+HVRpeSb17TkbNADFG5texZ/5CaJ4HkRyjVc33Y9xlVqqZIotQ7OAYZTHggCqAikEvUT0WN8v0KfAaoZr3fBkdcewqF3MvJUErp8IvfoTlyB7Xqn1PMzeLTdUOAgAW3VwRydHI03OuXQX/AcqGXfJOOW/atgg/keh1w9ifOvdUZifffWDez+NQNtxZXZ+IRFmNpCUB8nJfY+CHHgVVyDLhOSEE9LNFJEnz4a3O5MEAxOgk60QEZx1omi4xp2nddILOXYP9NzO2F8XCmRy27a2yxIMUXHJqE+uPTNagCl0LP5fYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCt1oAEX2YhyQTkQWQKj7nGHi9lKLatssLcd+80/qLA=;
 b=L0SviEeXDiaUI9bGkGCARODGTnGLzuwOilJ4X1tMmTMIwlwADA/hORMp7AGQ4eUkkNpyVSu6Er6C7vbnQlyD+kXK993x93/tUtFSx0zgpecGIEszjggqZTGnlclCfY9keRVPFA/7I98LIn/KEYIN3LxpebaHX6Lpvb03/+xTK6Zfey3tQ7AkG/uU89D8BGSKGKbNobn7GPgONGsvCnq3tJ5el987iXxvA3atVR/jz43smiI8NUk2Rb/R66wX8UW/cRJB5JYsqv5nAu8WhtuczJ3L1c6+EL9Z1RNoF2ptB/LwruEqgVPfsLSmK8WDIoXVgkDRxTQtK4aopRU/2/pt3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
X-Received: from AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d7::22)
 by AM9PR10MB4183.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 07:22:20 +0000
X-Received: from AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58ad:30dc:511a:964]) by AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58ad:30dc:511a:964%7]) with mapi id 15.20.3933.033; Fri, 19 Mar 2021
 07:22:20 +0000
From: "Michael Adler" <michael.adler@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Michael Adler <michael.adler@siemens.com>
Subject: [cip-dev] [PATCH 1/1] Secureboot: Disable initramfs debug shell
Date: Fri, 19 Mar 2021 08:20:36 +0100
Message-ID: <20210319072036.16091-2-michael.adler@siemens.com>
In-Reply-To: <20210319072036.16091-1-michael.adler@siemens.com>
References: <20210319072036.16091-1-michael.adler@siemens.com>
X-Originating-IP: [93.104.75.247]
X-ClientProxiedBy: AM4PR05CA0001.eurprd05.prod.outlook.com (2603:10a6:205::14)
 To AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d7::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-Received: from localhost (93.104.75.247) by AM4PR05CA0001.eurprd05.prod.outlook.com (2603:10a6:205::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 07:22:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe4c861e-726a-480a-fa24-08d8eaa7bb61
X-MS-TrafficTypeDiagnostic: AM9PR10MB4183:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<AM9PR10MB41830231FC083303E38785B1E8689@AM9PR10MB4183.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 
	UV5SQ0nTaSM68Kim1bp1TSjPw6U7Q34e81a2bHhhtQqYrOtdTKrGtxzj1uw3KXBzCVRseCQfbiLIMpurCsdNR7lFo/V4BCxVZFwHM5q9LNjpGLFAF6fYxy1WLg60ub/Id5qjuSr4564hD4kC7ixnyBPb0gn2raY+dFmGGppjBZP+nmzSKU7ZC3aa1VtTeqsZrnEnxnw6hnOdBbStLVt5kwOorgG7UwQV51EgEsYzOK6ztxDLIhq+Lr45FeVJWFWz6MaXGQ7V6yZ4uKbdfQcMBqzlaiRlEiMYNEhqdzJxSZlZ1XItOEK++UCBy23fWA775g51x3B7vkvCY53v2Ja7U924jsQTYitXBS6WJ4qYmuMmJ2NWTo0j3yQg0PuFg8ewKOabKT9f3csBk5sWIieNsUkz2eYpNnueZhDplRs3ZNcgWPL0SFVr1ub/5R67SPSMTDkx6liBb8QpZ+9eQuiFZmxidipD2GRVvPq+zzW2f38fL0xZWQ3+Sxm0Kt5+VfEQbbFQWmnPjRJXAmmxwKmwUbuX6ffZm7wbF7alYNjbBm9Ptian5ibhELm8KOIPuXsCJfQ0GK5rgFYjTjJgwg7pFYEw5TTvsjIWP2XHBdXRxlpNEVz0G4zUHPFbMmSMDus74Aok/IHkLMrnHhs3jLGdxM5CvWm7eBW89e1hOkg3CyiHgD+Chho/CKd2GVyYmiKPnQlcn87iDwucs6y/ZODM2/EwLXQM1ASnoNr/UcBsgSQ=
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?eVL6zmAZbMA/GfOpjIMC1vaG3Xpd/x+L+BnKJf7BXcE9zYlr0v1lbKiqvEIZ?=
 =?us-ascii?Q?4nemenbFOJMAE2CM7HwAgUWP32MVvUqs5t3H/nzOn0Pbicz9cjldecbmbLP1?=
 =?us-ascii?Q?D3QM3zEMLGf+/WsZZ6dyxn2wj6qEqrJYkDVxzTGs+6AvaBdM0vBsz/e2XS1T?=
 =?us-ascii?Q?kvuzfVPiQUuQKAmAI1raJa5eG2kj6ykfPO9dmZeON1NGnxpRmk+TvVNP50iu?=
 =?us-ascii?Q?8sLsw2v/2LZCTmbpRn0gHjHs03WMBcXL73zSVxNUWFMQiEDevuiy5a4MVoDE?=
 =?us-ascii?Q?1KJqXjeOPv68YDEuuo4XgjQhCWm6tNSNE9n4SHqlb9tqH3qt8E8sp2h30jhV?=
 =?us-ascii?Q?lfpE3zpgiTFucf+9HOhmVTXxKYDwSD7FzY+xBSqAwZ5B7nuH36nibAI0DZMV?=
 =?us-ascii?Q?zSuH5PdyAjwevyniKvkfkgYlrICfI81/n47V7uvZN2BrhpQ+9uuJrWQ5MPFc?=
 =?us-ascii?Q?NfDtR/XNg85OhLV+iHh+eHbKw3qNR29U4ATSL1ryAtNXOPv8yS9sda4LHkV2?=
 =?us-ascii?Q?7OQ6PT8kj+BnzA/DlPmpT/5wyFB16qjaeNAM6KHP6m+bkDrM/3UUlKcawhE/?=
 =?us-ascii?Q?tDsT/Vy3lOQXeW/y42C8bgn1bcdmrSV9uYEh0QF7fUhbS4iK3lIis3uXwx+s?=
 =?us-ascii?Q?Bj6gndy+77gio4yNT7SLBwAFvefRPm2ZOCQxTaiEky7IHDkiw/dhGUzVr/3W?=
 =?us-ascii?Q?o/5uYsCRmL9Y2/mb1pW+wO8B8PsA7lOlzS80cYvHABOXg5JSaVOWWxJ8we/k?=
 =?us-ascii?Q?/iSmJzsQ6PJ2cLYu/be5XkrNA4Hq4o9900h3O3a9m9mdIxz/Hahf4HyvF6qU?=
 =?us-ascii?Q?d2p/zY7S/VAdfViHXcQCvb77bSXjsL+hYpJl5JYMbsYFJmBHxAp171e67l5s?=
 =?us-ascii?Q?gUSGN/YDojJH6FPetW3VeMksSVgURfBlpVJ5/35GrxCHX6FmRVUmWwZp/yNn?=
 =?us-ascii?Q?OKLU9ip6MWqdI48gfrG6hZhIluXv2YoTSoDgEqXW0rIcPUarTaKWdkUaj8rX?=
 =?us-ascii?Q?qOzgZlDsR23gB1lbRxuym7FkFNzvF+gsmC5DWft1QcBJORQtfgUoYx2kPmor?=
 =?us-ascii?Q?f68Ap0YxNoQTFg8OvAmdbAF6eQcB9AzvrKhK/YZe5wG+H6PNyje5XtOIfGov?=
 =?us-ascii?Q?4HyQwJvfKQE269ezBbtz3ckgp7w5vFa7h564TIncS6CbuBLtKt7sKaeWDemz?=
 =?us-ascii?Q?h9vESfXZUynDdrRwlBlsaIGDPkSymTkb9BYY1Yk8ceDzPR/uaxMajixU7/io?=
 =?us-ascii?Q?WDjSuJGx2py0eGExH4ulskPJ910TX1WftItv384uIaGGr5WIYvpkmRfHZyEw?=
 =?us-ascii?Q?feMToaG748boKi7vToCjKoYl?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4c861e-726a-480a-fa24-08d8eaa7bb61
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 07:22:20.0811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmgoBFrC6czE4P0TWK0oC6/TJfg4cy6pAG9Vlp3yCFAd9pS24hd5lrxGMIW2mzmYa5z8TX3kvK5zGRAzxAIrYo/nLksnoxGnfqsu6JNWWTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4183
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GiNq0fki6jEOLmnUP7ka6tBYx4520388AA=
Content-Type: multipart/mixed; boundary="3RiTOsIxIaSrUjG3IynP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616138545;
 bh=RQgbofWB3jPt6CcGLHt9tljnfZCTsysTZhhM6POHWIE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=rKWfKLeUvuJbT243cOX6JrKRI87VXMT+VYoPOF3zDGzBhKtpkD9sxLooJbabuWS+20o
 0XGynfACDuWljOkghmIyiyq/ARQMupXXgnUD3p5t7dQJovqPqTue/bVxIKy7JST36wSNb
 sxaxK43ldaBisXp5ZmWr9AqvAtJ4WUiWa6A=

--3RiTOsIxIaSrUjG3IynP
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

This closes a loophole introduced by the initramfs debug shell which is
enabled by default:

"The initramfs-tools package includes a debug shell in the initrds it
generates. If for example the initrd is unable to mount your root file
system, you will be dropped into this debug shell which has basic
commands available to help trace the problem and possibly fix it." [1]

[1] https://www.debian.org/releases/buster/amd64/release-notes/ch-upgrading=
.en.html#recovery-initrd

Signed-off-by: Michael Adler <michael.adler@siemens.com>
---
 wic/qemu-amd64-efibootguard-secureboot.wks | 2 ++
 wic/qemu-amd64-efibootguard.wks            | 2 ++
 wic/simatic-ipc227e-efibootguard.wks       | 2 ++
 wic/swupdate-partition.inc                 | 2 --
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks b/wic/qemu-amd64-ef=
ibootguard-secureboot.wks
index 9ccf501..ff351db 100644
--- a/wic/qemu-amd64-efibootguard-secureboot.wks
+++ b/wic/qemu-amd64-efibootguard-secureboot.wks
@@ -7,3 +7,5 @@ part --source efibootguard-boot --ondisk sda --size 32M --e=
xtra-space 0 --overhe
 part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --=
overhead-factor 1 --label BOOT1 --align 1024 --part-type=3D0700 --sourcepar=
ams "revision=3D1,unified-kernel=3Dy,signwith=3D/usr/bin/sign_secure_image.=
sh"
=20
 include swupdate-partition.inc
+
+bootloader --ptable gpt --append=3D"console=3Dtty0 console=3DttyS0,115200 =
rootwait earlyprintk panic=3D0"
diff --git a/wic/qemu-amd64-efibootguard.wks b/wic/qemu-amd64-efibootguard.=
wks
index a9a8446..6653068 100644
--- a/wic/qemu-amd64-efibootguard.wks
+++ b/wic/qemu-amd64-efibootguard.wks
@@ -2,3 +2,5 @@
 # long-description: Disk image for qemu-amd64 with EFI Boot Guard and SWUp=
date
 include ebg-sysparts.inc
 include swupdate-partition.inc
+
+bootloader --ptable gpt --append=3D"console=3Dtty0 console=3DttyS0,115200 =
rootwait earlyprintk"
diff --git a/wic/simatic-ipc227e-efibootguard.wks b/wic/simatic-ipc227e-efi=
bootguard.wks
index 74446d3..f6191bc 100644
--- a/wic/simatic-ipc227e-efibootguard.wks
+++ b/wic/simatic-ipc227e-efibootguard.wks
@@ -3,3 +3,5 @@
=20
 include ebg-sysparts.inc
 include swupdate-partition.inc
+
+bootloader --ptable gpt --append=3D"console=3Dtty0 console=3DttyS0,115200 =
rootwait earlyprintk"
diff --git a/wic/swupdate-partition.inc b/wic/swupdate-partition.inc
index 15fbe80..7bec9d7 100644
--- a/wic/swupdate-partition.inc
+++ b/wic/swupdate-partition.inc
@@ -1,4 +1,2 @@
 part --source rootfs --uuid "fedcba98-7654-3210-cafe-5e0710000001" --size =
1000M   --extra-space 128M --overhead-factor 1 --label systema --align 1024=
 --fstype=3Dext4
 part  --source rootfs --uuid "fedcba98-7654-3210-cafe-5e0710000002" --size=
 1000M   --extra-space 128M --overhead-factor 1 --label systemb --align 102=
4 --fstype=3Dext4
-
-bootloader --ptable gpt --append=3D"console=3Dtty0 console=3DttyS0,115200 =
rootwait earlyprintk"
--=20
2.31.0


--3RiTOsIxIaSrUjG3IynP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6299): https://lists.cip-project.org/g/cip-dev/message=
/6299
Mute This Topic: https://lists.cip-project.org/mt/81450090/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--3RiTOsIxIaSrUjG3IynP--
