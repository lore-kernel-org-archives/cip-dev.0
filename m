Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E1DC00140
	for <webhook@archiver.kernel.org>; Wed, 10 Aug 2022 11:52:05 +0000 (UTC)
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (EUR02-HE1-obe.outbound.protection.outlook.com [40.107.1.63])
 by mx.groups.io with SMTP id smtpd.web09.4798.1660132322161345174
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Aug 2022 04:52:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MaNqW0aV;
 spf=pass (domain: siemens.com, ip: 40.107.1.63,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NODH+ptagiUyKwsuEFrMTtOpUqRrEeqIINlSrzq0yDv8H9qQRTLlc+mz8GJhTvM/qmSLxOYN45YDJPpqxJfavwQNI+S557NMjhwrDpXyftRkcaghH2k/cT2Tsm5iPv2JL9SVHY0mJkgTpnXgTT1nzUujSNa5erneSiV0o/46brJ2Ff93pMkBEbWs8tEW3D64LULhGKqYpywJf6r4pZVLtcr6tOiCvD8fp6lfm6a65EPB7h1ScDitxpp+XOoan62pWKC/35YruqObBZ9f2d+ymev9e+yKt9oPYgYYLEjRFyDkFLQQnrb4h+0aPnmqWLyTBrgQqFWjkjefld9CnVzNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+9yYaeZjxGs7g2jXoNlkwmLT1x4NQzb9dd5anvIYFU=;
 b=YhdggTqhqz7Brq+o6+sKUQEKeSj9V/O7V2vY58ekSldclybloo+C8fFTr+oMZT8ZVQ7apAdMxyb60weLKijMBjn2FSScwtAaAK0j1lxcvvNO1yfM/OPFq3oafObetXtW5keQuS+Fj+HhyB+tVQNrLPgCAWA+Qjz9w03nDx1qUvC0z8AnKReqthH/bXjTfli6I+/kHd5MLQyg9kyq0xnkK5UtHaUrPS1QDy5xxfsc567cCfsBRjp+CgyRuuCe4cLlPW+/Gp6v3M/0YNcGqM0f4+aRbXoSh04WFJMBANHWqw7lrcCf3PKmIS70Pf03ZfVWERAsoqopxERNB9jgviGCbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+9yYaeZjxGs7g2jXoNlkwmLT1x4NQzb9dd5anvIYFU=;
 b=MaNqW0aVnVsJoUyxhHyBFOxGTrLypJQyyZ/VLP4UGL6EtKUbY5dHoqQ0xTYF7HkW21mgmfZbbe/8E+AsL1oHte/TIcg5Dh0HG5MsrGPSdUKuH4mXwS9RFzaZop4boFA0D+Cqht0HCgFpON4LHv2ldi9eaK/e6p8S/7e5vqtGt0CzEpnbsdSD9pHenZAsmh+SWVNJCWtI9nQjhykMwhLyOO1lJ59kxhlUbtZkRitTwALZgQPxIhakuDcZgVjuX0ywqKAd1zc7sELlecA608SSnBGtICXUlqqjgil0Pvvf/AcrIrfFL9PNL5Ogm0kVPwEMSQSMHQ1xTsC5jYPBqK6MXw==
Received: from DB6PR0801CA0044.eurprd08.prod.outlook.com (2603:10a6:4:2b::12)
 by DB8PR10MB3928.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Wed, 10 Aug
 2022 11:51:59 +0000
Received: from DB5EUR01FT061.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:2b:cafe::81) by DB6PR0801CA0044.outlook.office365.com
 (2603:10a6:4:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Wed, 10 Aug 2022 11:51:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT061.mail.protection.outlook.com (10.152.5.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Wed, 10 Aug 2022 11:51:58 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 10 Aug 2022 13:51:58 +0200
Received: from [167.87.13.241] (167.87.13.241) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 10 Aug 2022 13:51:54 +0200
Message-ID: <b0622133-62a4-8488-43a5-9a102239f37b@siemens.com>
Date: Wed, 10 Aug 2022 13:51:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 0/3] clean up kas/opt
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220809104100.469265-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220809104100.469265-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.13.241]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.795400-8.000000
X-TMASE-MatchedRID: 8xNMUprDHac5QaOxwNGfvo9bHfxDWoibNtywwIf5ksXW4Mz461fsHEKJ
	5iyNYGPpR/IzlV+CMbaJ7cxjte/SmKVNzeXRGlTjf3m9ZmRc/ZGVuYyDbQINTseuFL5UpINxF4r
	8H5YrEqwwUbkkPpbdyywX5/37Wt75utZareK/raXlrMxKuk0/OLBAQLqGlKivv5rsfD7H2pnLvf
	c3C6SWwrcIt210bWgIYG32ZLukpVN6ipWzVkuu8DN360kR9zHUXHEPHmpuRH05f9Xw/xqKXVkMv
	WAuahr8+gD2vYtOFhgqtq5d3cxkNYm64L5jDeG7Z/DiOGBFN8mhzIKcUX6gse4uZw2QhxanaGyU
	zytHBX4=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.795400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 9DDC02344FCAB47390B0B9FBECEFFB4A364824310C05AECCA010584B40F3DE5E2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 145904d6-ac3f-4aca-36b8-08da7ac6bb13
X-MS-TrafficTypeDiagnostic: DB8PR10MB3928:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AbBgR+/n4+QMB0PFGLQJnOsk5EyA8+J+bJsDa3v8ACwASjQ/NS4QHkFkbpdmr+vQ61U/n1NTlHUVg+JegLL/xS3o2eZB7X6+8MUiV84/3Fg0Yl4X18xX0kOpr9VYWC+5LsQ9mXkXrG4+RtH59HDi3AnWTGEBLe+YWsPmQjMWaSZv83mXch0mmcMRYCIA8VxeOrI9byZU9aM0ak98xyRV7w8sAd8bMgtxOozqzxb7WJkOLLpj+H9RZ/eLIWlyIcjhj/bVKXuILmWOSXJT1gv2+5YtWnJwNh8AwAmDbBKKnZmZPwUlqjBzvEVp448HZUzk9FS3+hRVZvuhcADCI1NSPRp5e6WB72iD5tl8iClrfkbia3P7jn0sqw6K2jfrYR6w8JfuFp9cL2H8HBkeAJZF9hcHBhoHYjiGBnytH0h5wk+lRxJrFdtVphp7cj+/UdrGbSe/R5P81jGqPL5CfjjTBW+FQo7GDQxj3Tx1BCcRXhbefXtWJBrD12EC4c1WWGUu8zfyavWh6okQqIJgwZjwzfCMOAjTY5AWa9kb+LmUmxcxNg3bBPTkKbIfq6uronEVLXwzR4m5DVQVh36TwpLqF3ZZck5prmHSz0MeTDOyWU3ugIDQnTEfRjynFqX6GIEgI/4OBRfD4HD60CDmH5BPAK4svXjlXA95DpYbEeNQ5ZmwfGgu6vEWWZmjfRp6hBs1ceM/FU7Pbu9jBDAS9fArKebMQ+3zoevdlwIAhJ/3aTExHvN4RBAsFOq04qefrJGAe3vHayjdz7Kf7p+l0yZX2IMlgM0+hxP2GC/Wzh8nU4TfWbWTbdhE8993/WT17tnzmGyd8Iyud4Fq3m+nYdDdyw+4BHHKpK3+JSVvsnVmaxNV2z+YIFArrb6MBInJzHu8ShRPU/KTvveAQiedNxFtGA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(40470700004)(36840700001)(46966006)(31696002)(41300700001)(6666004)(26005)(86362001)(82740400003)(336012)(40460700003)(83380400001)(356005)(47076005)(186003)(16526019)(956004)(8936002)(53546011)(36860700001)(81166007)(2616005)(31686004)(5660300002)(82960400001)(70586007)(2906002)(70206006)(8676002)(40480700001)(316002)(6706004)(110136005)(44832011)(16576012)(36756003)(478600001)(82310400005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 11:51:58.6277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 145904d6-ac3f-4aca-36b8-08da7ac6bb13
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT061.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3928
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Aug 2022 11:52:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9150

On 09.08.22 12:40, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Remove the kas option for efibootguard as it cannot build a image.
> Move the package installation for swupdate to the include.
> 
> Changes V2:
>  - Readd WICVARS(KERNEL_IMAGE INITRD_IMAGE DTB_FILES)
>  - Fix setting WKS_FILE for ebg_swu
> 
> Changes V3:
>  - Fix assignment of WKS_FILE
>    - use weak assignment in conf/distro/cip-core-common.inc
> 
> Changes V4:
>  - Move `firmware-binaries` to kas/opt/ebg-swu
>  - kas/opt/ebg-secure-boot-snakeoil now depends on ebg-swu
>  - add DEBIAN_CONFLICTS between initramfs-verity-hook and initramfs-abrootfs-hook
>    as the system stucks in a reboot loop if both are installed.
> 
> Quirin Gylstorff (3):
>   kas: Remove efibootguard.yml
>   kas/opt/swupdate: Move the package installation to swupdate.inc
>   initramfs-*-hook: Add DEBIAN_CONFLICTS
> 
>  conf/distro/cip-core-common.inc               |  2 +-
>  kas/opt/ebg-secure-boot-snakeoil.yml          | 11 ++----
>  kas/opt/ebg-swu.yml                           | 17 ++++++--
>  kas/opt/efibootguard.yml                      | 39 -------------------
>  kas/opt/swupdate.yml                          |  4 --
>  recipes-core/images/efibootguard.inc          | 19 +++++++++
>  recipes-core/images/swupdate.inc              |  3 ++
>  .../initramfs-abrootfs-hook_0.1.bb            |  1 +
>  .../initramfs-verity-hook_0.1.bb              |  1 +
>  9 files changed, 42 insertions(+), 55 deletions(-)
>  delete mode 100644 kas/opt/efibootguard.yml
>  create mode 100644 recipes-core/images/efibootguard.inc
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

