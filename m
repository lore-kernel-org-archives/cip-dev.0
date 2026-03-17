Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36B8FD8764
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 12:45:29 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.74888.1773751527857860308
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 05:45:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=G5LVDD5p;
 spf=pass (domain: siemens.com, ip: 52.101.72.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8LaCMNzCI6GdzFJCOvtGfOBlt01ceSIprImexZwYjuTmKEd8fYAwRnjW5RQUeL5vWOe9vwLIw2kqtGsvR1AouxakwO6cnk4wbBPX4oAF61gW7RM15yuwBaAh78MzrJaxNSJO3iZt9ki2YONelog/a2WrXiAUSrd+1ybdBl+4bpVL2H+WxQ5XEZDa4eWbjtzzRTgZbj2w6STdI10Nn0nSCp4rh4djUb9RHdGniVHIeqI0axAHNA8HivAgcl6VYSlJjuXIHJ8Z9tLQAs1lnDvK6f8ryrDL7CI9sRmn+5KuYtKs1iLB9i+AxfoiMFwOdSPLVVDkVAuxABV8WZHmKeBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARPrQQGdBYfscvCn/3acbVt/VoDmMzwlP/KSsMIhoio=;
 b=PPomqe7M2YCG13YZekSEsWwwUaA2qZ3seyG5dOF38GHc3ExgZHF4vhOw8S86zrtFbelQhbuV1qeauIlg+SQccVPf26ZhHXihc42Bj65RelCLYMxkvdwF7BX01P5gs27LOnKo1XeKDd1npaqbvrqu1owLWtcXQEdXsmebzddfOpCpIqVuIYKqPB1LGMl0g1BuZenDrwTQq4Lo9/Dc9h9crq+QNaerNY7lI4FHCDBhPZY7t7zI+BrCEB+/VoiOzlbiBVd4fBqJtOTzdKIdOpVBhGs176JtqcvvnoS3676riYnnVrVEa/RPGCItqtOhR7M5piSC48LnXbIIpKitqUuvbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARPrQQGdBYfscvCn/3acbVt/VoDmMzwlP/KSsMIhoio=;
 b=G5LVDD5prDtvruxDNPmhvrlJv0qDoyy99Y/jhNq0h1L4GdLstPdn1oqpu2E7ramvJUMUK2WYC7RJczxWqEzbAvZM6dcACZfjnO4sTqmGBXWjEFgwrTPRjhcoROTVFTPA2zcTxtay/rKSlDQeVn9snrBuNgnmRCYNVEx4syVJeVT/lm1qP2G+LJhTnj8C3sLb/ooMW+/vsNiGRLrNC68AfC2MUwKC7sDnorDiPCFKi0DZLF9RL/N02mCJjhFj5OrI5EKNCFg2MzDfTGqiMvB75jn49bcw9lSwZRIPk8xTT2vkVYe+uYYtFRsS02wUwjbrS3Bpxp+7Xcvs3afEgw5FoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB9914.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:601::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 12:45:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 12:45:23 +0000
Message-ID: <e4efbbe6-81c8-405a-a434-2a7c0b39eb3a@siemens.com>
Date: Tue, 17 Mar 2026 13:45:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] typo in pam security customizations
To: "Berge, Matthijs ten" <M.tenBerge@awl.nl>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <DU2PR01MB8493DC648C797E2B7514B19DE741A@DU2PR01MB8493.eurprd01.prod.exchangelabs.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <DU2PR01MB8493DC648C797E2B7514B19DE741A@DU2PR01MB8493.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P195CA0027.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB9914:EE_
X-MS-Office365-Filtering-Correlation-Id: 9451dc17-eeeb-491c-765d-08de84230e6b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	oxZtvUiaYTcH7Po/imWoKwd50pouO3sfEa9SdLf4MTmuUXYn46QoeYXE8IYJlLXc1gQ90JxrzIr5ASwTBbiviYrKg8q04I5fK00vjbi0tODvDeNfx35FIB/HtbysISOAvgaKqz6x2zns2TEW8fDSZNvkSoAKv+PylhrzRiILapHYnBI9LxnoxlNYNFLLGyOC+qKzRp6SPXjupriFRoH6HdIIZlhTb+ILHszDHOAvIjP0VITAK1f3gc/mmGwfSVEpx6RXVuC6FRT+XswLFYQih8smEN1ZPI8vg1Ns1ZKhlaSQVMEIWfruAT3kUORCLqWKvXabBLY32iYKkT3c9DKXIt0/BE86e9QV6tN944jynrSlqZI44iWqBXIzUjnuxjCcM9udHXoL5veMFYoqJv5hHkY3bblZZO3ggt8UDa1wiZF/hLz2Fze9UTMyUrfLRds5TooCyQ2enr//CBcRYGt+hbT+yGJdmaq98eStLRNFEpoXb6gSw8cZogHdswcpv9g6zyA+zzqKHknaHDLcUrMJrUmg+nU4xKUKnl7R1lgnL1QkqjvLvUQoMdTRLIoLW0BkV5/K11BbzUly45IBn62tKAePX9DXLj5Am68yQj4QrBpFP4kt5mCkTYx7noWEIcQeFEKfct8M+/n70TJvjjT5bOclugr6LG0Kbpymvd4R75IAenrZ/lhPnoV/Vo3VlSNPAvfa5rIW4lUvOddnK7AuKPS6FCz/t5yu1nafqaeZmVA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TXQvV01lNGlFRFBFU09vc1VHVGRnOXc1Tk1VZjNWYmhrOEw5UzhsUmEzc1NN?=
 =?utf-8?B?WDEvdUxsbXNTYjBlN0dJQ0Z6Mnd2NGRhV2EvdlZQcFlVUlNoWS9KYlVPK0lH?=
 =?utf-8?B?ZHBERW8zWWhkVzMzNHpIWkZhaW1sY296N2xFWVkxa3FWOUlxN1A2eVhzellh?=
 =?utf-8?B?SHFzNGMvZXpZV1JINVVNOG83WitON1VGd0tCdC9nUE4rOVNNS2R4V0tVNzhB?=
 =?utf-8?B?L0FWbGRqSG04MXR5K3VSMSt0T2VPM1pnYjRYK3hFUHJEVkxLcWdlVURwVkFE?=
 =?utf-8?B?UXpVSUhKUmxmS3crb0dyVW80OTBNMFVqU2lWcWt4NFVNeFpweXowS0VDbUsy?=
 =?utf-8?B?dXpWd1BXbGl2Ky8zbGRuZ2dWVjRTWUN3bDR0TEYxZUhPSFAwQTZhb1ZHVkNX?=
 =?utf-8?B?WVgxTDA4UmdMTy9OT05wSEN5Z0Vkc1JwbGxyZEhNV29qeHJoWHNPdDNTSlhU?=
 =?utf-8?B?R0FUY2VjdEYyN3hJNHFhVy9MK2lTR1ZuNmtNMEw1SjE3RTRRTml4Qk8vOU1r?=
 =?utf-8?B?dEdHZ0lic1luN3FqVEZTZ2NJWkVxZEo5R3ZPVWhSZ01qSzV5bS83Sll4cnZI?=
 =?utf-8?B?cUI0K0dGZ016K2ZyM3BMRHVhM01sUldxRjNrOXI4R0VqZWJnKzlWUVBMNU9K?=
 =?utf-8?B?c3hEVlV1SzcwVVZWckE0VTN2dnRGS1JZeVliRHFxOFJwb1pubVhiMjJZd3Er?=
 =?utf-8?B?WmdlUHBnV2lpMS9abkd5clUzSmZVOGdOYU9vVm1QM1VwY3RRUG45QXZETVZG?=
 =?utf-8?B?VHFkNWtJUTJOd3R3ZnlweGF0b0JDVlJubzZDS1FrUXN3ckhrNk8zYTlrNTQ2?=
 =?utf-8?B?bUJUN3ZBNGVJV2F6RWZCRWRDU2tSdXF2bHExNVRDS1FFcGlNYjlpbHpzTm1w?=
 =?utf-8?B?ZFJMQlQ5MTdKRXUrQ3hodHp6Q0hTZi9MbG1vTkZrQkU5SytBZGFaOTR1bFRM?=
 =?utf-8?B?cDBtQ1J6SHM5eURDV2wxTVdMbnhtNzcyaWp2QUN4NUxyU3JBWTV3MEFyRjRr?=
 =?utf-8?B?NEc1dHByRUlLWmw4c1BrVlZPYzJ4V2VuNGJDY0lHWDF2eDhYVUx6eEVPWkVL?=
 =?utf-8?B?UVlXR3BnTm1oeng4d3lPSUZQMVdhdlBLdldXTm5tTTgxbTJ2RFVsWkxzdHhT?=
 =?utf-8?B?eDQvSTR1WkxQNlEweHpjNUtZelhsMlQ3MDhjWWIrWU1pc2wvcTFwN3JrOVRx?=
 =?utf-8?B?bWpxMWl0eHF3R0dWaVVjWEJRMmh2emhpdHlvb1AxRXUrS2ZpakFzQnhTRHRH?=
 =?utf-8?B?Wm5vREpYZnU0Vkdac2hzSHFLNHlkLzNSeHVSdi9ZZmJQT0ZUeU83MHg4RE5Y?=
 =?utf-8?B?STRpVFFyazhocU5NTit2bDh6TjNyYTZjVEluSnpHbW8yRlN0MkY5aVJLclpE?=
 =?utf-8?B?WTdqZGRBOTBIaXNHSnpkeDlJckNmZCsyTEtXdTEwYXl6bldxUFIxY3BObkk0?=
 =?utf-8?B?Y3NkRzRkUVc4MjUwSHJQSVk3bjZyZUNiTnh2K2g2QlZaWTlua1JYMVNjVmdJ?=
 =?utf-8?B?VFUyRnkxZEI1UERMRzNvMnNNMzJmakhNaC9hWXA2ZEFmTTA1bHpNVFM3dVFY?=
 =?utf-8?B?cGNONDJmb0NXWUJDdjB0blZkSEx3aSs1Z1BsU2FJaTZaeHdUa2hPWExNczFP?=
 =?utf-8?B?ajhlMlZXYnFrbE5jbUM5aVlQK1E0V3c4dHpjNUhFK0Vwc0pWWHRkNENRVE5q?=
 =?utf-8?B?cDYvU1VqTkdEakRYSGhuVEdYajdqMXFLRlZOMUJCRnppRU1RVVY3RGNLcUhP?=
 =?utf-8?B?MUhldnVvT3hnRi9pNVJwYmVINGo2UjdaSWdKOENHd1BubkVHOG00Y1hVbU50?=
 =?utf-8?B?Ly9NZ3BKVkpMY1g2TnZKV2pCdDkyRUN3dXI4RWV1cDdrQkN0SHIyTXpUY3NX?=
 =?utf-8?B?bVk5YjlCbjl3dEtvbFJTUjVSdlhtQVpXWkJhelBPNFkwc05jakIrc0h6KzI3?=
 =?utf-8?B?Ry83UUdZKzNZM1BLWDU1UUNaY2QvSVd2T1l5cTU1dmlxS2kxQWFRNlpHcDB4?=
 =?utf-8?B?aFZ4MS96Tm9XaVNNYUhZSlN5Z3RJVFQwbXZhRm1WRTBKL0NJVXpDbDEvTkNF?=
 =?utf-8?B?bjJCSWxzcXNtNUF6SHpoK1NiMSs1MGNnMVRsTWJrN2JjMnVXeEVSbjgrVVBa?=
 =?utf-8?B?Y1FCQUpHQVJUb2tyT0tMeEc3eTd5UXlnVmQwc0RKeGVHNXFpZUhvSkFUN2pm?=
 =?utf-8?B?UHNqajBnMk9TYXlETndhTGt3ZVVuNk1PVTN5SWRaRHlBUVZoWkk5b1BVdm0r?=
 =?utf-8?B?UWo4OTlNcUNXYjdudjJ0M25OaTNXZ0FtSjNya2lFeHp6amVNUXFEWHhRbEkr?=
 =?utf-8?B?bWtEaGpwS0R1LzBpVkF3eTJlakJIeTZRQWpnQ1F6cFRwRkJITGFkQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9451dc17-eeeb-491c-765d-08de84230e6b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 12:45:23.5437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCxjRxkj4sQLJqmXB3QIPJoD4kEuzxwl3ORQfAziEFVbXax6rdzoHRuiO1yE3xM70dSJ0h8csxcnzoBcdKkFtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB9914
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 12:45:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22488

On 17.03.26 08:22, Berge, Matthijs ten wrote:
> Dear maintainers,
> 
> Line 42 of recipes-core/security-customizations/files/postinst contains a stray ".so" after pam_faillock.so, which causes the following syslog error message when doing a console login:
> 
> login[...]: pam_faillock(login:auth): Unknown option: .so
> 
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/next/recipes-core/security-customizations/files/postinst?ref_type=heads#L42
> 
> (Sorry I can't use git email patch format yet)
> 
> Kind regards,
> 
> Matthijs ten Berge

Thanks, good catch! I'll write a fix in a minute.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

