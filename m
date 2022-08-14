Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F9CC25B06
	for <webhook@archiver.kernel.org>; Sun, 14 Aug 2022 09:36:33 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.78])
 by mx.groups.io with SMTP id smtpd.web09.3522.1660469785478564817
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Aug 2022 02:36:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qsL7bghQ;
 spf=pass (domain: siemens.com, ip: 40.107.7.78,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abDkNdtc55qhZPJxOufmLtcvGJAOkX2+2ANZONXw+ukjZ/T1rTDav63mk2PrYUc4ptSxD78PKER7B+d3PVwg07njJcpcmClBN6iAdUO1q0Rkv3+Q6MIJBxAh7YaML/JpUtxK0EggINbBoaLH9Nc9KO40V7ecOg/i0HTQzMejHtQVgVHnLivkVVMVWQqtui9x/3c7w5HXB+vfQfigvnezslqX/6zJjXneuvmA9SGuzBa1R3eccujZIXmfjMLVsAqEhX9PXOAm05IU7g4NVhp0NfzYwDIGZ+YA0z0P6KudqHJffbv4FeILtVYbgXqkE/1DZyZI03jDl7tsSrpQVwFsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvZGtLTLU2dKeFnAdMj6moAvSy0TuNzvC54nrbyUqow=;
 b=bWHaaZxkr4jMSwiLgZ2nnwohj7dw5RN/rkfrinkta6vGwgD4Ru1ap8t4DqdOOQO5gT9ipFBTp7N/0rE956DRS7JqxH8nlkffXH+iDcE+zHTAIj5nDgLkbNNg0ObTE5vbNHFkZJM9jcPNK9o5dDWVxEArr0coDgOS2HUob34E4iHjKzk21JOOw5VGHTxbsER6dySfYvc7LRyD4SvbHA+0JAm2G+NOvDyEo/Cwd9ac7yafvIBH7+F0b5lGHdTaoQGWQhW3xA5bc7V3/J5jItSfwJKH0CEh45G2JNP6A79Y17OFAeDMmmc4M5jLIKdJNcPLidSUf4vJDK8i4RzSBvB++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvZGtLTLU2dKeFnAdMj6moAvSy0TuNzvC54nrbyUqow=;
 b=qsL7bghQcnh1/OE9yJ4NTrE2LgHpqArNpqE64FpMUdhyjF5AgTE6YbcBw/fcbrgo8IwG6Iv9uqvkisc930pVCLBsSzaYb9L1GwwJH7EPlgQ0Qnx8o6YIHIe0UrgD8pQ9/Sl54BHSynI6sRdErfY5ByNm6LuwBLq66sEvrcH12CkIMUVvWxZldV3vZVzHS4AK9hqV9GlS0PS6EkdX7wFyFh5CnudIrhAt4zbYvVrOhsqcCK0n7TlQ6onJQBu0y6KNyQTD8h67lyB+QQDBdnj7Xd7FrgDeTf8j+3pGu2R140x60lHXqnZtsUw8Bv9kbetnKYZuaZqRz4u15C7d0B830Q==
Received: from AM6PR0502CA0062.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::39) by VI1PR1001MB1390.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:e6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Sun, 14 Aug
 2022 09:36:21 +0000
Received: from VE1EUR01FT100.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::39) by AM6PR0502CA0062.outlook.office365.com
 (2603:10a6:20b:56::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Sun, 14 Aug 2022 09:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT100.mail.protection.outlook.com (10.152.3.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Sun, 14 Aug 2022 09:36:20 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Sun, 14 Aug 2022 11:36:20 +0200
Received: from [139.21.17.200] (139.21.17.200) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Sun, 14 Aug 2022 11:36:19 +0200
Message-ID: <0e4afc58-75e6-ee10-5bb1-5c286768692a@siemens.com>
Date: Sun, 14 Aug 2022 12:36:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 0/3] clean up kas/opt
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220812095112.632930-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220812095112.632930-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.17.200]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.936100-8.000000
X-TMASE-MatchedRID: kxpaLTp5p645QaOxwNGfvo9bHfxDWoibNtywwIf5ksXW4Mz461fsHEKJ
	5iyNYGPpR/IzlV+CMbaJ7cxjte/SmKVNzeXRGlTjf3m9ZmRc/ZGVuYyDbQINTseuFL5UpINxF4r
	8H5YrEqwwUbkkPpbdyywX5/37Wt75utZareK/raVi1z02mY0EETevDqHvVdDbUYXhMajr0x4usz
	U67KeD16MQi364g884lSG36bKvRcyNA7k11Cii69r76sIjgnDNle+q6k7Q/cwvzLls7HTfGctDH
	w9RrCNbmyiLZetSf8nJ4y0wP1A6AAOkBnb8H8GWt7DW3B48kkHdB/CxWTRRu25FeHtsUoHurceK
	w1R3FmspYyPWnrPBeRqx9Sz61yM46vqKJkwHnOrFhXMjdQIJpg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.936100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 85AC7988F594D1F5FD04C4B58B27428B28A079A1E3ED2A926E7EE7D5E204D84B2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cd2b8df-1b8e-48a0-c245-08da7dd87223
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1390:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	veu1BQALW7i1bNMKubDhPDHKDO27vpe4+Ls9EEuipaoUdB8ajTRvjWcVCeJnr2ljoC50OSh7TLEkST82EHvdevH9lrH/liu2mXUqUWBI/B+5S9qRgbWyDnHkkXKCChqCNyt/+6m+/98T5/GFvcnE2rq4UqhnswQaW+u7TpLXawS+Qz5y0ASkDXuytINhbFTEksldhU19QyCG8kNFy3mC/WOmxw+uAkOVkKMKd8mNfHOYxOy8W4wN9PZ5QjXFfWD/FbnPpHvRtijwuPtLY0W44jLg+DGtLAKaR1LHSJXZwUA9bpSPyPSNcZV6GOigJ7w7u185VsC2nSssgQusjuUQLZE/v39GLCr2S8PxbTjlohquQkMvyH7Whj+zVKGD/txqFkFCMGQQ5R2o/t/+Qw6xhgSozpKtZ618JNQzYF3QnKbJ9FBl88/1gSAuiGnsl6WWzQ7YHo5F5Js+SfzzTmM+PUArMW104lNJSkZm0sWvpcRrDBt+QWJlpyFp48Rud/Shjt+0VqguJJTQrrVY3oAJ2/uALoIhAT+SxaglYnhEouGGDemf+/wst5eeJ0YA2iBzG54p8b5RZykmXUkNZnKQeh8OjSQwyrKgdl/iVIyYiOXJpKcTLKbRzjanmC9xSm+eH+gXh20PmZ621bxZFwV/YQaX8E3kpyNEH3eEMhgetm13P9eMJrgQsd2bdEJz0C2PRXODxpibZmZ+ESMJO9S6GK0MQ41cU4quMgOyY+AZGqrmzvIfUPx7X1YJPAJALB4CyQ42wsWPJUoghhJYv1rLlcLuPY8HNILHokrFEEabKuqiKvvG0hg+ZeRzxGSZn0SmvhZJ5ROa15y3PbyHoBpgtn4FRlicRRwL28VlyG34Bsoljls7tvzbpZHCLtjVP6pVjO/6Du6vshQiShmVqlQ2Zw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(46966006)(40470700004)(36840700001)(36860700001)(40460700003)(356005)(81166007)(31696002)(86362001)(82960400001)(82740400003)(316002)(6706004)(110136005)(16576012)(5660300002)(8936002)(44832011)(8676002)(70586007)(70206006)(2906002)(82310400005)(336012)(186003)(53546011)(956004)(2616005)(83380400001)(47076005)(16526019)(40480700001)(26005)(478600001)(41300700001)(36756003)(31686004)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 09:36:20.7161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3cd2b8df-1b8e-48a0-c245-08da7dd87223
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT100.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1390
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Aug 2022 09:36:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9205

On 12.08.22 12:51, Quirin Gylstorff wrote:
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
> Changes V5:
>  - Fix set WKS_FILE in case by using default instead of weak assignment
>  - reoder patches
>  - rebase onto 29d3546 origin/next
> 
> 
> Quirin Gylstorff (3):
>   initramfs-*-hook: Add DEBIAN_CONFLICTS
>   kas/opt/swupdate: Move the package installation to swupdate.inc
>   kas: Remove efibootguard.yml
> 
>  kas/opt/ebg-secure-boot-snakeoil.yml          | 11 ++----
>  kas/opt/ebg-swu.yml                           | 18 +++++++--
>  kas/opt/efibootguard.yml                      | 39 -------------------
>  kas/opt/swupdate.yml                          |  4 --
>  recipes-core/images/efibootguard.inc          | 18 +++++++++
>  recipes-core/images/swupdate.inc              |  3 ++
>  .../initramfs-abrootfs-hook_0.1.bb            |  1 +
>  .../initramfs-verity-hook_0.1.bb              |  1 +
>  8 files changed, 41 insertions(+), 54 deletions(-)
>  delete mode 100644 kas/opt/efibootguard.yml
>  create mode 100644 recipes-core/images/efibootguard.inc
> 

Thanks, applied. This time, the pipeline stayed green ;).

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

