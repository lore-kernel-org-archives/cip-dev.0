Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F1CECAAD8
	for <webhook@archiver.kernel.org>; Tue, 20 Sep 2022 10:49:17 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.52])
 by mx.groups.io with SMTP id smtpd.web10.10239.1663670946566474833
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Sep 2022 03:49:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cfaKCsoj;
 spf=pass (domain: siemens.com, ip: 40.107.14.52,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaDoCka0Xx4Q2gvkrDPkqZMpDUwTr4EKS/XB1Vnh8JUA941//AO/3q4SG9lZiAIMtvuPlhMjBfvVECGsjZU65YtodeaOnvFyHibeYHAppX0ReD8DlcfCrazfvbRAyuKw7VMZE2CNx6jfld6eYKA97+w8ihtkFh28bnlwOwuz43sQnVc+zBk0JWuOYc6I42oqNNh4osh0ZSQKFLRf1Du37PFC0a7NTCC+VKZNCcHa09kiZBhBGdUgjEyDm0U243dVD/0KiSuUecKTVbcdsYqhF8y3t7sj7dqJyHzEfRS+JBsmure9FD+IcjiFbV98iIY9qvS8BfT61QNXRjKNmTElNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmtxUZh5GLChMVZqCya+cABK7swIrccV+zFAdNIrggM=;
 b=PXJxCstDFLrtuqFDQgIAIx8k30S2KxfRR8i7auhypt1hOSctMeXuOsKKI+VPjPLM2h7CzrgGOiR+VfK6mEb/Pc25OW154OdzV9zWBLoeYDbw1I0NX/BBvkINcSWQZZ67Yc+qToh7uBkLXrbQhZCoryNnM8WTYVsgJW7A5qSw+TJo1AT2UpWXg3x+wMcE5VQlGV5Aa0F/tNkuFEsgzRVoqyNbs5ltquf+3GFL0zZ598Sg/5sdeVrmYxo57L/LM3AYvrtkoPNGjxbnUNMMG6Ca442QJlSUR8W24OJJMOkFG3SfibzOUb3tVhV3s7mzFF5+6K3NwdZvtnbWwKcM0RcFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmtxUZh5GLChMVZqCya+cABK7swIrccV+zFAdNIrggM=;
 b=cfaKCsojeSDZtU0MWAAO9Pt8HGTBWUTgBHvXOcwVNUKOtx2qqC/07JjOYJDkWkReVXF+8ulPqdyExZNFdUdH+FGbib0fCFZWUk/HLLA4YF81eKt3iHFXeHae4RQHKJi0HjaR3DlX7b+W+1r1cExXkd9lwRdRIoFdAT71U4OxCmySEG/94FdgswyMCs78qJskHOA6ZGYuYXuk5OCJR2kKwIUCcaTq1/YyPKrH1Lro99OvEIx7Xwo26kfR5a0SB/PawuTko6pDG6W9LgmAku2swrQ6Opb/0Jdh639GGOn4XRTKlae+XqWqWGw5ECSrGE6BmxajgjxEnt5Mw/+lQDPHiQ==
Received: from OS6P279CA0147.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3a::20)
 by DU0PR10MB6900.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:467::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 10:49:03 +0000
Received: from HE1EUR01FT009.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:3a:cafe::1) by OS6P279CA0147.outlook.office365.com
 (2603:10a6:e10:3a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Tue, 20 Sep 2022 10:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT009.mail.protection.outlook.com (10.152.0.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 10:49:01 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 20 Sep 2022 12:48:59 +0200
Received: from [139.21.17.42] (139.21.17.42) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Tue, 20 Sep
 2022 12:48:59 +0200
Message-ID: <cdc059a4-d91e-58a5-0170-8a4c29d4ee79@siemens.com>
Date: Tue, 20 Sep 2022 12:48:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [isar-cip-core v3] README.swupdate.md: Add steps to verify
 SWUpdate on BBB
Content-Language: en-US
To: <Shivanand.Kunijadar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
References: <d98e57e9-2219-6e09-582c-b465e9295193@siemens.com>
 <20220920103646.25672-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220920103646.25672-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.17.42]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.442700-8.000000
X-TMASE-MatchedRID: 0sa3XW9m2I3O278aZjZxZ8c50LsMZjCp/k5m7D0YTS/x5KZMlKYS/ReK
	/B+WKxKs9/tYry8FJ+9fjqIZlM+knq3aC25avUuaplCaRSPAyU0PBdAcQklBEq6pwuq7tDp2giz
	NKnxrsXLfc2Xd6VJ+yq2LobuNU2ekROogZf1QZqaJFgYp6ABGFIHDqMX5R2gd5wXI1oONVuA/pO
	SL72dTfxzSdtho/k/DxM9DM4OIRza5m98AbXr6CqL4Z8WcjppKrCjYMeBjXjpv/kcFnp29GExUJ
	yPnqTyGdroFpVy5w+nr0WFAxQ6paMqYiGokmVrVIxY0ut844Mnni7ZGg7ZwKThk1eHxQ+sgkYC3
	rjkUXRKUAUfla+IhaLKXWmEvaG3ElyyR46PvItO2qNGaLuHnvk1+zyfzlN7ygxsfzkNRlfKx5am
	WK2anSPoLR4+zsDTteLhcSg9d5zHdsGWJwbpEIjwtrbwh9eNKpP4OmocSfQd8l3JQhxww4g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.442700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 952524C40B04609F34B5348E61BB5385E31EA16F56C1BCFB25A705B472E6536E2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT009:EE_|DU0PR10MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 24645ad7-0577-4ee0-0e42-08da9af5baf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ahCunu/de44+t+/cWdvBKAI44bPSQxmR471PEQdEpy3y8m3NDGB3xmQkXMCs6hgEJxT2TFL39gwwXqH0CeYqkCEByfIi+UkvuJAsn2Lz1IA3ISvy03QECRE72eoFr0I7SKx8XKYXE0RdJJoLXQn1fNC761klAemLbboVUr3/vQgN4arZrq7QT798f969N5TIb5R9R1z9RkAGnJq/QA0X5EbyRZzv9XHZ+CJAKsoTXUS94l7lD4yQb+i3hwctqdf3ED8ZWJroLGg0Mbm8cPEnZt2mkcrb14+BvThth1hfTTABEDSRObYTpP7U11xJyeDjRdwgs4QrjUfC7kZVzGq0un0+dF+N51Ne+OKg+HXVO4xoDMpp81th7cfkJyrboLFjsZpO3/8xYB4Q+bW1CVSbn6hyzyoER0E2R3x6jW6DXIfY28BTv17Jea+4VTVMlmOJLFe/G5lm7tHqXyhR2nh4djnUVrBvi/jX0FGkvIaBbYHxW4RouN66jHPbQJAPaSyH0X5C0RnHv61LIkUBRVYumBjq3jpgrvhurx1kIsrWuERwONcNmz7yr4dBFr3a/7MrD19JvkXkmnKd+xDYtkPgpKkudcBh2NC7YiijzBiAn+LGwANJjmIcODMAQWxiOLQocogoDdUws60Co1bT2wI2vKv+VtHYGIDNCTDUNzHkq0nceeTWnj590QtddtSPWKhBx/G6GndTBrjaBCqgQl6Kg39eEHwqWZbgW9HDLlBFDEq/nEff0sp0oUNVYsPqt2RDiNtD1XSB6M5Rjj6jchACVulhVT5FXr3ERPyqMuxO5Zr95c6kFpVtv0cWhB5QDBNV5hFAzHbq+ruNkucHfPNANYRP1K85um3K+h8RnaSDcGk=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(8676002)(70206006)(4326008)(70586007)(53546011)(83380400001)(36860700001)(2906002)(47076005)(956004)(41300700001)(2616005)(86362001)(6706004)(31696002)(110136005)(54906003)(16526019)(16576012)(336012)(356005)(186003)(82740400003)(316002)(82960400001)(36756003)(40480700001)(81166007)(82310400005)(44832011)(26005)(15650500001)(31686004)(8936002)(40460700003)(478600001)(5660300002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 10:49:01.9434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 24645ad7-0577-4ee0-0e42-08da9af5baf1
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT009.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6900
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Sep 2022 10:49:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9527

On 20.09.22 12:36, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> Most of the steps are similar for both qemu-amd64 and BBB targets.
> Add reference link wherever required instead of repeating steps.
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  doc/README.swupdate.md | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> index 1b242a2..97de777 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -32,6 +32,8 @@ Copy `cip-core-image-cip-core-bullseye-qemu-amd64.swu` file from `tmp` folder in
>  host$ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@localhost:
>  ```
>  
> +## SWUpdate verification
> +
>  Check which partition is booted, e.g. with lsblk:
>  ```
>  root@demo:~# lsblk
> @@ -215,3 +217,27 @@ user variables:
>  
>  
>  ```
> +
> +# Building and testing the CIP Core image for BBB
> +
> +Follow the steps mentioned in the section [Building and testing the CIP Core image](README.swupdate.md#building-and-testing-the-cip-core-image) for creating images and .swu files.
> +- Replace qemu-amd64.yml kas file with BBB board specific file i.e bbb.yml
> +- .swu file will be generated in the following folder build/tmp/deploy/images/bbb/
> +- Create Non-RT and RT Kernel images as mentioned in the section
> +
> +Flash the BeagleBone Black RT kernel image into SDcard
> +```
> +host$ dd if=build/tmp/deploy/images/bbb/cip-core-image-cip-core-bullseye-bbb.wic \
> +   of=/dev/<medium-device> bs=1M status=progress
> +```
> +
> +After flashing the BBB RT kernel image into SD card, mount the SD card on host PC and copy .swu file from `tmp` folder to root partition like below.
> +
> +```
> +host$ sudo cp tmp/cip-core-image-cip-core-bullseye-bbb.swu /<mnt>/home/root/
> +```
> +
> +Connect a serial port cable between host PC and BBB.
> +Insert SD card to BBB, hold S2 button while applying power supply to BBB.
> +
> +For verifying swupdate on BBB use the same steps as mentioned in above [SWUpdate Verification](README.swupdate.md#swupdate-verification).

Thanks, applied.

Jan
-- 
Siemens AG, Technology
Competence Center Embedded Linux


