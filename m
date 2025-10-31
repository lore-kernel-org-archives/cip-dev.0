Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51943CCF9EB
	for <webhook@archiver.kernel.org>; Fri, 31 Oct 2025 05:58:15 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com (BN1PR04CU002.outbound.protection.outlook.com [52.101.56.62])
 by mx.groups.io with SMTP id smtpd.web11.8352.1761890291584893650
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Oct 2025 22:58:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=selector1 header.b=vj6+unBt;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 52.101.56.62, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwfadkRqEjNAx5xPLk5+avEInXWQ/Oufp4WavG0AlHqUNUdBRhrdoNQebM38JdfT3LqrL4/VWpqbjGKtvW88Ng/oBALi3sopOKoVDPdQYLL1dYqKP92/NHQFEisC358OQy+FYNOtRXSsfRtsMIv/V9sh+mS9iMWwCfCN8pBeB1gb5gyE+W/iouKxy4elZ+CKx8yPOfg+S/9TpxB/azIFrfKYdSmqh4XDVtNjnCemprv2SV/n1RDx+5mnEy4NdiLUdjy9XNhpbpQsSb0bbtSKBnUjh4HiTa8IFJyl0yzO6da6vpd248qztRkOtdL+fXDDJfUgA4uw6N2CEPIgXDy9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lK9JJKJJZERGPZP9E+rQOikA+MHsws2p1Km3fYeNERE=;
 b=icgEThffJTFY+qKTDPAnD21eP6P2lR7ucMIZLp0WR7QFK0wB0SrCb2Ksp57cxivxGiESZ0ddDnaE4/uLlD4JGX041aafBCOoS5y+tXT+cD5fsZ64kN9/d26ljh8niRDfBhpLW/TdUGg/RlJ3lbvz6mTD4rccyjm5xfx5G/DYlAasbpvzy9z5PP1QflnNAyjy/5bqHO008LRkcYYGsyqaw3DoKx7ZLuALw5vydbTyrbrYbKc8NLOLy4x3BmL3yMmIkF8eVDSJllfZ7Rsocmz6+d2i6c0M/Y8ytzbWW6FuKF7yHtZJ+NUB4svB7iIWSFN7Wo+LKaT37+E+U5k7uLrFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.cip-project.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK9JJKJJZERGPZP9E+rQOikA+MHsws2p1Km3fYeNERE=;
 b=vj6+unBtYR2RbsITPLvK5yOIJ3J8odnznTFDxZdd0wzYdwMrmv6R3zPTC0Y+ySx2W2LX/iBw32Yt0dEqCr+YibManqR+cqa3kUjkLQq8nb+71spoi980o9h0dmZoIh/ihkIHIztwdXZHPnti3ZWL9Dmtf7yYb9yK+czOWZGBhbk=
Received: from PH8PR20CA0020.namprd20.prod.outlook.com (2603:10b6:510:23c::21)
 by BY5PR10MB4369.namprd10.prod.outlook.com (2603:10b6:a03:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 05:58:08 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::98) by PH8PR20CA0020.outlook.office365.com
 (2603:10b6:510:23c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 05:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 05:58:07 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 00:58:00 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 00:58:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 00:58:00 -0500
Received: from [172.24.233.117] (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59V5vwTO3378989;
	Fri, 31 Oct 2025 00:57:59 -0500
Message-ID: <d4ce7d05-a971-476f-8f93-bba25ba549e4@ti.com>
Date: Fri, 31 Oct 2025 11:27:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 0/4] Add support for TI AM62Px
 Platform
To: <jan.kiszka@siemens.com>
References: <20250722101551.1727649-1-s-adivi@ti.com>
 <a525b452-76cb-40e3-a9aa-8f31c181ad39@siemens.com>
Content-Language: en-US
CC: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <a525b452-76cb-40e3-a9aa-8f31c181ad39@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|BY5PR10MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 133ffbce-bf87-41e9-b54c-08de18427738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|34020700016|1800799024|376014|36860700013|82310400026|4022899009;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZHFTeGU1Lyt0b3NGODRSUDFBZ3YzMUVyYndzR3NaRHU4MWtnUUwvWEF4L1Yr?=
 =?utf-8?B?VDBNNldUb3J4OHFuUUUyOWcrbFU0eVdNTzFPay8wd1FZRERSNDhZNUVvQlFH?=
 =?utf-8?B?OG02OTNybXpaRktlNkYrQnJsSUNuMU1wOE03WGxFVUxBR0FjUThZZlVpbURz?=
 =?utf-8?B?RTRNZVlDNURwM0ZmUWZmMFpFUk9mYUFLZzZPV0ZySzJmcFF6V2VONTVsT0RP?=
 =?utf-8?B?WWp2aW12RDlPMFNrQnVlOXUvR0hqeHFrak5EQmVmQlRqS05STk55bFM3RndC?=
 =?utf-8?B?ZmRMd1lKT0djQnBEanA2cnQ1OGMxR3k1U3d0anZNajBwbTEyZDBCekZBdWFj?=
 =?utf-8?B?U2dpcHhtdzg3U1N2RGxqUXgzZEVYSkVocGJiZkJUd2JxekozcjdRa01rb3FG?=
 =?utf-8?B?MG5DSDdEYndWNCtuMjAvNlhRVFlCb1p3TG5YV2s3K0Z6WFpxNldQUHZCZkUr?=
 =?utf-8?B?dTJxRUF6QmI5ellqTS9YSTNJcVoza3JERFA3NEtSUzFJeXp4SWw1US96TXk4?=
 =?utf-8?B?TlpmbFkzSWZ6RTlOeDFoVU5LbVNpVmxIWjJKUituL3FwTmcvUUJUQWRWZzFR?=
 =?utf-8?B?Q0k4SHdtL0pKM2QzV2pKSy8yOGNQenBudC91NG1CZEptdEVEbDcyN2JqTDEw?=
 =?utf-8?B?cGVYaHk3dllsRHlueXAraitrWmdIbHl4enREZ3QwT0FUYzJhb01zdkFueU9i?=
 =?utf-8?B?dHpQVlFKYUxUcSs5WENYRThWRUMyRkplNkxiNy91UDZFZEtQL3poWWFaNWtL?=
 =?utf-8?B?TWNvSnpsR2F6Znd1dVo5SUpjYXJtL2Q2NjBGc2NuY2VtRDRrWlBwL2tjaklK?=
 =?utf-8?B?YzFZa0tKTTNycWx5Q2RIZmlLYjJRdmhuSG1nM2dtM29pUDNvV2hJV0RrSUlW?=
 =?utf-8?B?dE1hY1hpVVkvTHpOMXE4S0luMU55dUlTcWhtZUZneUcwZVpiZTB6ZkhnSS9y?=
 =?utf-8?B?SEtkbkwrYUx4TDJkbVlBRGNhQXF2UGlXWTV2WnkvRlQvYWRlTER6aStnaUtj?=
 =?utf-8?B?TDlvbzJEUjFvV3VBOFNkSE9WQ2ZXdHZjS28yV1orek04aXhaRFNKNDlybHVO?=
 =?utf-8?B?WHltS3J4VlpTb2ZmN2xvNlVKdkZXWnEwSm1pbjVTdGt6MGs0bnhkQ1FFR0NU?=
 =?utf-8?B?Vmd3dGV0QWVQTnBOaEdNZXJ4T1JuZ1A4YzFteWx5ajRHTGl0ZHVMRElvSkkv?=
 =?utf-8?B?anNldzlFTWlodDBCNEMrOEYwNlpBaWIwT1JRVG9xTDExZ1p5RHF4Zk1OdU1C?=
 =?utf-8?B?TldIcHM4czR1dnpIS1N3T3RiWHB5RUFIOHBoVThram9FclVGdzd1eHlsY21h?=
 =?utf-8?B?cnI4dU9oZFkvV2FwYVNOMEwxZ2c0cXkvejZlQUpsYmVidHpFbEFKM1B0cXhM?=
 =?utf-8?B?NDRmVzV5a3lNTmcvMUkxa0tEVmJuN2k1aUZhNUJYZnUzOXZjS2I4ZGRKUmky?=
 =?utf-8?B?OHlad1d3VFRkcmg1WkFYUFJhMUhnVzJWOG9nU0xTamcxN1lOR2UvSzI3ZnFw?=
 =?utf-8?B?M3IzYnFHTkd5MWE0Yk9JejFOSVIvNWZCVzdmcGcxTExZM2M3MXdWM1g4UlJI?=
 =?utf-8?B?aERvU1hlU3lOa1ZvVWFOQXlGcno0UFd3djBuZUFpSU04QjRkdEsvT2Rya3Bt?=
 =?utf-8?B?dGpQTzZGMlRKT1pVcDgycXc5UVlxbHhDZFMrb25FSlRXZ05abnY5b0FvNGJx?=
 =?utf-8?B?MG8raFFSQkJTeDZYWDB4emJVMXUrTkpCTCtRc0wvTjlGZTAvd3IyWUZpb0Rz?=
 =?utf-8?B?STdPaTdnaWxEMWpJeXV0M3J4L2trMUtmS0IzYTd0WXhFSDYwVDF1cnpSemFL?=
 =?utf-8?B?bG0rS0VlM2tJdzZsTzd0V0hhcDB3SnJpYmcxbGd1Rmh3cHl5aVhsQ3VseGNl?=
 =?utf-8?B?MnljV2xWV3RuMjZ2S1JPdDl4VUczdjYvVkFpK0JlNWF2OHk4c3JJUEdIYmV2?=
 =?utf-8?B?Z1pkMU9reUpMRDNYUkFJYjV4dEhJakZaQmQ1cVpnZkZkaks2NWMwWVBQamIx?=
 =?utf-8?Q?abruC97tJ4hZpaWS6JVUWpSfjkyICU=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(34020700016)(1800799024)(376014)(36860700013)(82310400026)(4022899009);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 05:58:07.9430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 133ffbce-bf87-41e9-b54c-08de18427738
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4369
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Oct 2025 05:58:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20289



On 10/21/25 18:44, Jan Kiszka via lists.cip-project.org wrote:
> Hi Sai,
> 
> On 22.07.25 12:15, Sai Sree Kartheek Adivi wrote:
>> This patch series enables support for TI AM62Px SK Platform.
>>
>> This series depends on the following.
>> 1. cip-kernel-config merge-reqest:
>> https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_requests/134
>> 2. kernel patch to add microsoft,ftpm node:
>> https://lists.cip-project.org/g/cip-dev/message/19570
>>
>> Sai Sree Kartheek Adivi (4):
>>    Add support for TI AM62Px SK platform
>>    ti-am62px-sk: Enable SWUpdate support
>>    ti-am62px-sk: Add support for secureboot
>>    ti-am62px-sk: enable data encryption
>>
> 
> What is the state of this series? Could you rebase over currrent head,
> or do you need anything from my wip branch?

Hi Jan, I missed this mail. I've rebased over the current head and also 
cherry picked some of the patches that you have on your wip branch.

I see that now you've posted your wip patches. So should I just wait for 
them to get merged before posting my series as my series depends on some 
of your commits?

BTW, here is my latest updated branch.
https://gitlab.com/sskartheekadivi/isar-cip-core/-/tree/upstream-v3

I'd be glad if you can help review the last commit in this tree as 
without that I'm seeing build issues.

> 
> Jan
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#20211): https://lists.cip-project.org/g/cip-dev/message/20211
> Mute This Topic: https://lists.cip-project.org/mt/114283966/6838297
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [s-adivi@ti.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


