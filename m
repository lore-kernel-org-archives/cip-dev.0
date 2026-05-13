Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99530CD37AC
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 02:15:46 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com (BN1PR04CU002.outbound.protection.outlook.com [52.101.56.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8462.1778681127549771921
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 May 2026 07:05:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=selector1 header.b=UvgaR37J;
 spf=pass (domain: ti.com, ip: 52.101.56.53, mailfrom: bb@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfIt+KsPj9s/VMVz0CB3GZkFED0m497ChzT4jRiS5Y3nnUo7/cckt26+WGgchkplhMMFDy32DIEsdJ/8L4bVosPBOO9r2aLZLI8KQiZZ9IQf+wVPJqwauJaCHP3ceKZjY4Ee8NT6pXaPbnb0y30NJml4QGCktAtdUA8EFz2Y//cseQO3BcJ/Dc0H2hzIRECSm5BMBROzZKi0rtfeKFT4fQzFtsOllcjxqZ7n8jGwwjVpv0dmLFsI6iSKXgQL5gki7VDWKIMVeWsqwYiuMT46lZdGKKEVYXxhx7CplmsrSeqdUanDC8rhyfo7gaQkMXQ26DaIwaMlsDQBucfA/ZppcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYaUipLfQxVWwHIeuA+u819YnNdHpPdYEzS/7wTgkkc=;
 b=o4pjN5D6CLZUIzOMy7Td7S9aHIp6YX9Y1egQSvfa1ZWkZ0VDwqJpGhoujIDCPf+5mNUZMQ376SqfsCJp+Mu+JKcmHH/jBNW1s3nbrxEOWjX76wHUcqJ+irHq+/vjtohEMgf5OiHnB49GdXJwdOhcREWEFAUkdvWUZf7SQ3Ku2pTJHs+NFYmbZTyVIyjzCc68MgnanaA04VjsmQhM7JDDAF5oF1fLqmr+GMRMLJOCuZx3c8/mzmVcvDe17KUN7bPuibY3AfMZOU4sd9EzOGWEqEw8YNlsWyQpRHjW7R8/46CIsikGbFCulUf3IQAsrF9PvPAHgBYDgDkyNAUozNUhUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYaUipLfQxVWwHIeuA+u819YnNdHpPdYEzS/7wTgkkc=;
 b=UvgaR37JBcI3fvNw0pAEIM3kr50jBuxUofNZIloPfcx1if1ViP6ChkZHdbHHRH366I3RKLDhBGZWX9QzdtyGFDeyvTUYB/SnhAYJ4yzA1nV1KV0MEQOFRlwJ+6zAYsBn/HVy5wk0WHMXB3PxGEuhgolfr5MlH8vbsbBgNIZdq9s=
Received: from PH8P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::12)
 by CH3PR10MB7861.namprd10.prod.outlook.com (2603:10b6:610:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 13:51:05 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::65) by PH8P221CA0009.outlook.office365.com
 (2603:10b6:510:2d8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 13:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 13:51:04 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 08:51:04 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 08:51:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 13 May 2026 08:51:03 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64DDp33M3826518;
	Wed, 13 May 2026 08:51:03 -0500
Date: Wed, 13 May 2026 08:51:03 -0500
From: Bryan Brattlof <bb@ti.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <stable@vger.kernel.org>, Daniel Wagner <daniel.wagner@monom.org>, "Jan
 Kiszka" <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>,
	<nobuhiro.iwamatsu.x90@mail.toshiba>, <pavel@nabladev.com>, Russell King
	<rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 0/4] ARM: stable backports
Message-ID: <20260513135103.tt5tqzcxrgjefewr@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260511135357.2786242-1-bigeasy@linutronix.de>
MIME-Version: 1.0
In-Reply-To: <20260511135357.2786242-1-bigeasy@linutronix.de>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|CH3PR10MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: 3224cd94-7f8d-495f-c836-08deb0f6ad0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
 Z3O+pVQALer0U7ciQeMV3m+F70OMJ3mXBJNW+2HFfSYzL8IYSTTLM7fq5mVONR8U36xcQlf9iSQ59XVh2XuUA9Ct5eJ0A1Fdow1rXNqgxeFGK9gQ+oTjGZUGZfCml0t4JNnKIvocezzvKPtPr05qLPx145BEnVTO7cquHR3/uvH3fD7rpJTzHAah0BPEskzTB04YG/j27Fc8o1Sjzi7YzAiBA31GrtRU/4Br5rEl9ZrPKkxPTsxylRY+2yfNNO/2rzAjoE8YVNoStsd34Vq/89XzUX9YBmXpbWpuEs/He6y5H0SBqdey9SP6A6FDm2m9vNZKHdMHLPWiE8/dOz3yCIYPuoz8Lh1utBQ7lRF9mpBzPYPHba+iIC4OktHbsdLGXpO4wIBnEPZVWb5gg6TSHdCm+z6r11LHHXhMhK9UkOxxRVjZSuZoPPYuyMQTwwJePjTr3cFMq4LDS8gvSEbvcGvE3FGVOAD9CSG2rE9AYYESGDOovfSsyhX3t6wKjIynFwQA4NfgDXFwzeoqCNaqTupA5x5SzGbtq5V2ncKD26OJz+HC/8dygifnJfM0ksEs/JQmMxwsDb7Q80QQz8exLwF/tvzQL1VGpUua50gp55LWMtBCaWwNHaka7NTMTqpfSOIodnil9R90Tdx4vnHJ+xk/c6edET2jWB1gxLSCxiHjMYJb3pYpBpf56d+FGuAnKQFqNDzGZN212DMHfKzH6SaZvba5zt1FfoyiFAMeE4s=
X-Forefront-Antispam-Report: 
 CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 wFTbYzEtqdKEW/vBv3dB4cOpFAUaQ197XRYkgtapUajDNcnUGhZA40skGB9j+xFB2SbS1XD8vGdWVW8mYQcTU0pmEr6HTnhUe0SVRwYh3PJmItXMvVR1q3qVLiYnrWYyGxAzh0DTTxmq0ckDsVSUaCNtB6To9P5iiGLgKgN3+ECwXl7fdOdf9AoRkVe4gkQ/lcS1IbGiERdlxFPXH0XkKrSw9Wt6vubSn5il1BlN+PZKNN4blU5a0aEa0JH9EJL3LBEnJTGREyrLL3v4F0yuWW+XGQkkDjAkMWQggO9FNSac3qKP5SkA93Jnf8IiBoTDeS5FWdJT2cbnF+FjFcJeAE3vZfm+X8d5Du+bN0ejFNqx9y9WYbhPTagVDPkpwB5MdD93DDOXWDb4XfTmOTIOg32qwhJkgf4SHR/S79Et8zbINQQxX6pTR6THpQAOV8dT
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:51:04.4058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3224cd94-7f8d-495f-c836-08deb0f6ad0c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
 CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7861
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 02:15:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22932

Thank you Sebastian!

On May 11, 2026 thus sayeth Sebastian Andrzej Siewior:
> This is a backport of ARM related fixes. This applies cleanly to v6.18
> and v6.12. I have an updated batch for v6.6 and v6.1 because this does
> not apply cleanly.
> 
> #1 and #2 are prerequisites for #3.
> 
> Can't tell the origin of #3 (fix hash_name() fault). It might be there
> since the begin of time.
> 
> #4 (fix branch predictor hardening) fixes commit f5fe12b1eaee2 ("ARM:
> spectre-v2: harden user aborts in kernel space") which is v4.20-rc2.
> 
> If there are no objections I would post the v6.6 version once this is
> accepted and then rebase the PREEMPT_RT bits on top of this.
> 
> Russell King (Oracle) (4):
>   ARM: group is_permission_fault() with is_translation_fault()
>   ARM: allow __do_kernel_fault() to report execution of memory faults
>   ARM: fix hash_name() fault
>   ARM: fix branch predictor hardening
> 
>  arch/arm/mm/alignment.c |   6 ++-
>  arch/arm/mm/fault.c     | 100 ++++++++++++++++++++++++++++++----------
>  2 files changed, 80 insertions(+), 26 deletions(-)

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

