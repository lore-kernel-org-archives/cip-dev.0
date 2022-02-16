Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B94C433F5
	for <webhook@archiver.kernel.org>; Wed, 16 Feb 2022 13:46:32 +0000 (UTC)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (EUR03-VE1-obe.outbound.protection.outlook.com [40.107.5.87])
 by mx.groups.io with SMTP id smtpd.web09.11857.1645019190372880455
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Feb 2022 05:46:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=k1Oo2Ewd;
 spf=pass (domain: siemens.com, ip: 40.107.5.87,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRXggJl9JGXpO8lRoS7ywBYpDs0ileTZ5UXlY+owrcBRf+7fN1ejonb/cuVeAsPVfHm4PWlarZB3U0/kePsSNE0+FtqbNM7Il73VhCYZGaCKp4wcb88zH6AC6PXb08ylQKZ6CQnIxuiQoV+DPkVZVPmJfY4gXa2NyHumUM32SogVcYzsv8AuY0+9LbJONbLF0RWc8fdExBrjZ4nw3Dxl9+qe81rotjiC6lR8OYs/VjuKFREnTQldWy/VDPVklReogdd4BXBJx2S3SlgXcvDLCXbLJy6Oi//6rNegTpReaEwEuK6Z5X7hx/LmUPNGQZD5iaT5nLqbLEO2M+dYjFdnng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uV5nGCDcCcYP6XNa/pEWlkVNz6Dg8UMBYB1I5ls3HLo=;
 b=Cj+DgOssph7RgtEkpJd7185XyM9gIlQeDcr17exE56PXw0lbv7XLxruqfvUCE8LZi8XjF+xBDqyR3BDxgwX5zpFF/KWuhA+DlQnu6FXeHkA0k5/33lOljE4YS8QaSYb/5PKNQRdzNviZqODRg18LWLVZe6R0lhoZCYXuAXQYJdoXUMCKwzTd2HMV4oXRGh5j+OYsDXUObBYqAQvMBhs1+am4I9UwYsTLpSeAF6112KmKg3uJIZqL2SYrgMCBcIuIBLeqwH8/NDGXtlIVjO+nzHCx12MPHZF+MpGirhMxf4M4GJxM1mQdXnnVFwFEw8aR79Ns8eaQepdoL39ORxxwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV5nGCDcCcYP6XNa/pEWlkVNz6Dg8UMBYB1I5ls3HLo=;
 b=k1Oo2EwdmTV609sLIx+oqnMF4atzmiNqa5tfzEccwBBYzpCdw1tsTIKRn9wvLxSUEYztnH9MN3JB/RPpSnJoS0dfA/P4fbzJNVtWcQMS3jE7eWOsDp3mcE/FvDvpqTDGwCfgmIhsvOH+L/rs4aPMMelUAjP62bWQed7OUVmvmnumYe6+yLmGFfj+sSWdAq9WLXJh1Mai6TD43lmtCPdtCObggnjlFHpis1PD35UD39tkupUJwZLNlItDzDqNkK3FMDYaZmhncu6HV1q+rkUSTvosesSkAA/v9lRvCscU2ZYwLzeAmRBxG8lrDWdqWy2UgwgEBDlGchUxd0uIDQ2sGA==
Received: from DB6PR0601CA0045.eurprd06.prod.outlook.com (2603:10a6:4:17::31)
 by DB9PR10MB4794.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 13:46:27 +0000
Received: from DB5EUR01FT009.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:17:cafe::de) by DB6PR0601CA0045.outlook.office365.com
 (2603:10a6:4:17::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Wed, 16 Feb 2022 13:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT009.mail.protection.outlook.com (10.152.4.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 13:46:26 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 16 Feb 2022 14:46:26 +0100
Received: from [139.22.138.23] (139.22.138.23) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 16 Feb 2022 14:46:25 +0100
Message-ID: <337dd7d1-7e8b-7f6e-d094-fc33c0939283@siemens.com>
Date: Wed, 16 Feb 2022 14:46:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [cip-dev][isar-cip-core][PATCH 0/2] Update ISAR layer
Content-Language: en-US
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220216130317.3018990-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220216130317.3018990-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.138.23]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 510c5f8a-d51b-4cb9-7054-08d9f152ba9d
X-MS-TrafficTypeDiagnostic: DB9PR10MB4794:EE_
X-Microsoft-Antispam-PRVS: 
	<DB9PR10MB4794281A0DDEA58853D8D94895359@DB9PR10MB4794.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EPR7t+/W3sggXgE0PV5ZT8DBr+gV6Ul2AeqBwyiEHI8A5hRtxbuix9GDzxqcsOmOUiMxCeol66nyclW9rH9dOnFJFB7acp1hhsnoyDeBD3dfD1nGKDjK/qcbjfNvJtBbgD295OQ1n3AWNbnWT9VSUmLOOHo3eigCjbLcY8H8pF9MOVy/ZgtTnIn4J5kGPlrHR3cc1qFff0TiMasY2X78ar+Ar8Z1dbft0inwJtkCQ32R/QvDVoXtKuUQbOxkordf9fS9geApVBmtFhZis6Avu3a0y8XkVofh6/F5FiDnv363FGtbNvZd2TmNrfMoGPBn36ticcDux/p3BJAmQzocjfXPxdl7eNrXyW36wcgDkiswEw92fwEhRH9rsRucOohC7Xu4Uywn/vqBLXPPn3ME2s9mM4JFLrY7JQFm6CYJdUSXeRrQl3TlEKWTv4Q+rnHs9NnE6+J0duW4PVS9SM7LxPKsrOkx0uRm5rtNGlTKusqZBVMs5dmFf1Cb+YXZbfdGNYEndCd4zEYbQBxu8LTmiDzPwAgxTXX89K9pdKCnndhxhuJOjP4EnekpGuF5wT5dp7g9xa1Bdt6QMmk/W44QTXlVJ7yviawgS+/PdpUyeEMYmKHzuBck6GsfBvbuRkVG/maI4MAGZ/Z50rYIHWX0nrw3LqGJ8GmhXa+hqjnduD0y3629eq3UXGLlWpmczX9EU/VYvr6x5DhQZClrthArFPVdPekVlRda7DdwCfjkkCqKLVs1dZ/bHWAMwU6VtW/JyvRK/274PBUWLFrVlsa36g==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(16576012)(70586007)(6706004)(316002)(8936002)(110136005)(356005)(8676002)(70206006)(508600001)(31696002)(86362001)(31686004)(36756003)(82960400001)(81166007)(956004)(47076005)(36860700001)(26005)(16526019)(336012)(53546011)(186003)(2616005)(2906002)(44832011)(5660300002)(40460700003)(83380400001)(82310400004)(15650500001)(4744005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 13:46:26.9346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 510c5f8a-d51b-4cb9-7054-08d9f152ba9d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT009.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4794
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Feb 2022 13:46:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7621

On 16.02.22 14:03, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This Updates the ISAR revision cf3f18a649ff42726677a58b224b9bb58ea4ba46
> and converts the swupdate recipes to the usage of DEB_BUILD_PROFILES
> 
> Quirin Gylstorff (2):
>   Update ISAR to next
>   swupdate: Convert to DEB_BUILD_PROFILES
> 
>  kas-cip.yml                                          |  2 +-
>  recipes-core/swupdate/swupdate.inc                   | 12 ++----------
>  .../swupdate/swupdate_2021.11-1+debian-gbp.bb        | 11 ++++-------
>  3 files changed, 7 insertions(+), 18 deletions(-)
> 

I think I will have to fold patch 1 and 2 - otherwise swupdate will
break after applying patch 1, no?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

