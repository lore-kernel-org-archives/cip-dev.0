Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9F3C54EE9
	for <webhook@archiver.kernel.org>; Tue, 13 Sep 2022 09:29:18 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.77])
 by mx.groups.io with SMTP id smtpd.web12.2709.1663061354072089751
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Sep 2022 02:29:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GWRpqitn;
 spf=pass (domain: siemens.com, ip: 40.107.22.77,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJCMQuyrHCuoKkJSMuNzq2WOCH0t5mxb7O6BCzjCxoydFWC8TGbeTCHLZExJ+67z/lLY9rvfNUKR4aCY0UzltAmPB+ruGVt5LN2iedNg2zq6jKmgMSHQdad6AtABO9yeqJ/ck0uOJiHiUs/KutAcRbwOdz3LsTzDPznX4GXeg+1wK4McpfGySmBohZ6iH48iIepHH0V7F5ONwinBkLrgh6flib8R201X26uXF0KxfkHWOcrqVJnYEkFcpGQFO8rlZaMS5uQ72yUNyxC+h7hDisuhtOH9klpuoxrp+270PwV9cDpg7NhPYyMpxfaL2RpsLP1mmBIWIb6E94nJVlCZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9d5LlreDmP67y50OECNruiFgYQDo0wLLQrMJVCKOzBU=;
 b=bK5ykSPhoZstd2PCtFEQaIRU2UoWL2sSnkXNQ9gynENh8RSKtlbw2jpLGEbhf6wevhjh5TDreleswTC/FYTWHfGb/y7sBM6QO/SrCaI3aLoCSO8OgJSFP3KXIczJ/IyAUrFWCQ09+npuoF4eZ6dESK2A3lLgQ8m4jLeLwOtKzn14GLe89+co2psoke1RKsIoRw0h5q3UvtyXSmJa/qQ/FNm5J3miNhgqEfxkaSHuO7r9QS8sd9YZgV4DS/3mniwJxMzI9/UdpPqepafCM23kh2jnpO5HfGCXpPmnapnk3b4hgWM2AeBx1BEQZ/XVO6GVmqpmnjZVhE5tmAzWZJQQHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=renesas.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d5LlreDmP67y50OECNruiFgYQDo0wLLQrMJVCKOzBU=;
 b=GWRpqitnQXUypIej9L5d7vRp2TUcJBEq/4EEm2EeYRwL1ngMXXkCXbR6I5zHP/S9JFGNjxggSe8UaYrzYfQgu+6WTXzbFqQL51sbB4+dkU5tHZLcWIBUied49w8lXy9GZnqbRe9DDoT/NQAVCrCbMo8eJeq1OCDfrzasaWoay/DqejEIsg5DZK2cutfYU6E3P1CDtFcIrasfOqWwqCsewV/vjI6pOLnEkzGo6fPQUeXxIyYGFHMGgAgluPyemjvjed8P/Zzs4ChcW7ATp1ZIasTfIJaQQVlek+yg+oLa3UOutQNswIqIFJcGLY4g2doZlSmZaOIc6JtTGeIDuzCVVA==
Received: from AS8P251CA0029.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:2f2::35)
 by PAWPR10MB7416.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Tue, 13 Sep
 2022 09:29:11 +0000
Received: from VE1EUR01FT081.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:2f2:cafe::14) by AS8P251CA0029.outlook.office365.com
 (2603:10a6:20b:2f2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Tue, 13 Sep 2022 09:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT081.mail.protection.outlook.com (10.152.3.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 09:29:10 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 13 Sep 2022 11:29:09 +0200
Received: from [139.22.141.223] (139.22.141.223) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Tue, 13 Sep 2022 11:29:08 +0200
Message-ID: <c81d0188-9029-12fe-688e-df2c48a09c91@siemens.com>
Date: Tue, 13 Sep 2022 10:29:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [isar-cip-core] iwg20m: remove fixed PREFERRED_VERSION for
 linux_cip
Content-Language: en-US
To: Hung Tran <hung.tran.jy@renesas.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>
References: 
 <OS3PR01MB59767EDA1F2EA8ADD1569ED8C6449@OS3PR01MB5976.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <OS3PR01MB59767EDA1F2EA8ADD1569ED8C6449@OS3PR01MB5976.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.141.223]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.688300-8.000000
X-TMASE-MatchedRID: EhMq+2gclHs5QaOxwNGfvo9bHfxDWoibozvHRONZ7rd85pjA/x1xfo1j
	+mrGi/PFV2esrIBgS9B+Dha0AlenCU5fcl92Q2TweJs832DqeTx0yq4N5y479QPZZctd3P4BQon
	mLI1gY+lbCSrW8+l8cXQsX/Y6jlOJ1DUhSMXVuz3JEgNnnn4noGCuN6HSW3agbl4CKqupkMr0VP
	vT0zx0mIc9Jc7K8Zqmo8WMkQWv6iUD0yuKrQIMCDzvSj1BF/M7VnRXm1iHN1bEQdG7H66TyH4gK
	q42LRYk9K1igonwoC+TdlMhEXS2WI4GkALicfcI+CCecVGCMmV+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.688300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 3A2BCE4136E10048C63D629E61F127A5F26E2A9F427264CC9C25808E562228682000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT081:EE_|PAWPR10MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1e31e0-b3cb-4b3b-f957-08da956a69fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dQlg3OmKVzk1BcGY7SWMizL8qhpXtcN4/gVv2IOcLK9VKVGcuANyx6eAKDhKf3nf49AOhdb6fJkLuRy60PZ/e8bb4HdA9bU8OVKS7a5SkiFPbX/c+IywrQT0Zpxc7I8khvWIr76Dk+R6CrqnliZ5eOWQERJVvGsHiPN5V3oP7zRnj2orZkcWnWPf8pYRuDnaZwhgFGn/suwPQ6OmiVWvAait9pJuXL2hl/dA4yBO1PlkvVglrAChQ0Po4oYEriYU/vYAhhnDOGT4XS+OBo7idXzC+L7GWFchY91G+RnISZF5rIlFjEgYFdSOLoMroQ//5Yn+1Ei5usRF1wlvWFWqVBaT3sel8v+2KNeaWQfAf7WwkedIMoGSO4ixU1+2f/rOiAFY2+DmnqY5dWdNVaJkBJFV8saVl2Sa4JCymmSZSQG6ITUOSMU8UbTSlEDZGWCSULKcRSG/Qddj54NyTu3zrFHK8qjuWofcAtWkBd1ZrL/f8AsA0AGl4zxtvVtvlpK2mNxzxL+6WlNHQg6+3fLkzbAQAaaPi0SSNFnKFvwge0BhNMaXr/WhCyWucKopd4YIYfMVYfxVOY0KgAPR7tbJUVmENTLt8j2Yueov33CkwrWsjuYSHHAVtXC3HOxdaJx2gk5XPDzVlKHt88OjHft6U6Z/MvLgC+tOJ75ce9U4jOIRCFY7+Rq2B7xH/y0om9pMNYOfEdf8U60b1HxNGKE5/NmIXa+mtl5Kvc5A0k7M0cw4qCRxYtF1fyzrhMtVnSl2k+cvQAQ2kM1Tp8WdQm1VuStOZK4AMfY0sEqd9qD92JKJXqtwSYxS4b8OH6GXWovGfbuekkBdZdIB/9eboT+aDfosspn+esoAh3B7r6HLCQY=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(31696002)(8936002)(956004)(47076005)(4326008)(478600001)(70206006)(2906002)(44832011)(8676002)(36860700001)(336012)(82960400001)(40460700003)(316002)(186003)(110136005)(82310400005)(16526019)(86362001)(16576012)(6706004)(41300700001)(31686004)(36756003)(70586007)(82740400003)(356005)(2616005)(53546011)(83380400001)(40480700001)(81166007)(26005)(5660300002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 09:29:10.3137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2e1e31e0-b3cb-4b3b-f957-08da956a69fe
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT081.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7416
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Sep 2022 09:29:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9491

On 12.09.22 14:16, Hung Tran wrote:
> From: Hung Tran <hung.tran.jy@renesas.com>
> 
> iwg20m had PREFERRED_VERSION for linux_cip as 4.4.%
> Due to this setting, Gitlab CI always build linux_cip
> version 4.4 for any iwg20m build targets.
> 
> This setting is old, and not necessary anymore.
> Remove it to allow building suitable linux_cip versions for
> each build target (4.19 for buster and 5.10 for bullseye)
> 
> Signed-off-by: Hung Tran <hung.tran.jy@renesas.com>
> ---
>  conf/machine/iwg20m.conf | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/conf/machine/iwg20m.conf b/conf/machine/iwg20m.conf
> index d997a02..f5d5dda 100644
> --- a/conf/machine/iwg20m.conf
> +++ b/conf/machine/iwg20m.conf
> @@ -14,13 +14,9 @@ IMAGE_FSTYPES ?= "wic"
>  MACHINE_SERIAL = "ttySC0"
>  BAUDRATE_TTY = "115200"
>  
> -# kernel version
> -PREFERRED_VERSION_linux-cip ?= "4.4.%"
> -PREFERRED_VERSION_linux-cip-rt ?= "4.4.%"
> +# Setting for kernel and boot
>  USE_CIP_KERNEL_CONFIG = "1"
> -KERNEL_DEFCONFIG = "cip-kernel-config/4.4.y-cip/arm/renesas_shmobile_defconfig"
> -
> -# Boot partition files
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/renesas_shmobile_defconfig"
>  DTB_FILES = "r8a7743-iwg20d-q7-dbcm-ca.dtb"
>  KERNEL_IMAGE="zImage"
>  IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

