Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F8CC52D7C
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 11:25:44 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.85])
 by mx.groups.io with SMTP id smtpd.web10.44000.1723461940374348408
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Aug 2024 04:25:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wDqWtBzS;
 spf=pass (domain: siemens.com, ip: 40.107.105.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+qvrbW4giCAv51WbkEk8XVZ9mRLOXM5jx29gZSoV1TP4hB/g7YhaL1/LdEYDymcy1A2+sB38BP+Tdb1EdYfZZv3DjHTnJqBD/hhVYZRT4Hfnu2+mSLEqhyCnEKviHLd31PdrfrYBMMDdFJujmxtjInphAJJVLvaOtOfp1WmuBQoRIhC18gC60jy8WI9ule0HeNiuBEAXaTKOo3LA3+8cXnUT9G4wDmECUkERuIffMsACNXBg57XQ3AbXPqpjEnBCe246Cd5Q8Vk7UoNdNRtxasydX/YpAD433OBGASgrUMh9ZTDiag3jX1a6F21aTU3nje/kp59ZCHm6z7nROFjLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwVgN71XKY1qV7SvFZ/kY+wR6/Dj7ryBDHnqv2pnTIU=;
 b=M57+RjwOd6rNcte+tN+uNt0jK883zo/qDADDDW7p0NiN5R/PVvXVHVtyT6Jv/Lg86TZSJw+ECmoA5UWXHryEmDjXG6OpCW7PWjZszySboRBLxxpbSmJD51wN2QzBEBBdqnXKNccPOyWmjvHy/lZ42rpo6KcSsVZEGQ8aBHXaF3DPUCttTqJsWb0WiZA1oI6iQ9T2iamQbNX3i8ZCIt1+qlhzosOR5leslsQg8r8WVfXKd9hJW7FH8Z7LDekZim3du5CZRauB+79ZL69rV94CTdrOoMhpH5h7pnmqTOYZ5FcKTRHBFNUx7WCJ4e0p0Eth+Pc1cc6wnVxLotyEF/YZKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwVgN71XKY1qV7SvFZ/kY+wR6/Dj7ryBDHnqv2pnTIU=;
 b=wDqWtBzSw7tBkRCc3bo7BTdvHZkT6Og92S9Z6affmsT1K+1kJxhOX7hXDSdMUkwkCDkGbbWZdHpUytFPrGpUjoczFZxLdGu0ZUbV6prHo0897t94ucx0KUTG68qbHitUKCbtYkq8OeZzjYSW5O5sKZvWe6V4J2JZYrr6UBg/bZ37I6NTWX/ERCu7LoTlHoRQ/hb4boHpMrvn55d/3eAU4KzarmddoeC3P2zjWfodJAa90NR8I2Gzd+ygQik4qoYEXH8aat0ll937Rb2SG2LbO/8dC0IGK1TABoWZqTVM2TwSTliRxgfrHwpMuF7tnVDdu9/9KatD4OKEsuOVWrZhrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6361.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:537::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 11:25:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 11:25:37 +0000
Message-ID: <a2be4fef-a4f4-4cec-a293-e7ed25946653@siemens.com>
Date: Mon, 12 Aug 2024 13:25:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v2 0/3] Updates to sync with latest
 debian-cve-checker
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240812111605.1246549-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240812111605.1246549-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d4ae0a-d471-402d-7867-08dcbac17d66
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QlI5aWhmU3BYazZUWG1zcE12aU9qckpWanhSTVNudUVsVFFydjBSdFlrcTc2?=
 =?utf-8?B?MFc1dHV4WnNJOEFhS3p4YlRZVFhaTzJ0QlY4WFczSUUzY0lSbzIzR2JPVmRx?=
 =?utf-8?B?TDN1U2p5Wml0WUE2UWcxQ2QyZWl0azA0eHJISHVFRTZVQ2xyT1VkRDBhNWVO?=
 =?utf-8?B?RG5mN29BSjJkTEdMNGRhQ0YwQkRFTXZxbXJtRDVLazUxTzR4RzA2bEpQRUZN?=
 =?utf-8?B?cU5OZ0hUdm5sdVk1ZXFOa3ZHUXhiREtyREplRmdJb2ZSdWlyTldFWHoxMTBx?=
 =?utf-8?B?YXhPbVBHYi9SbnFaNHR4ek5sdVowb3FpK043L1M3K1dyT3daRkRFSk0zU3Nn?=
 =?utf-8?B?TUxoMEl3K1JJdmhsUWN0L1lDOW56eG1Lbm1OMVZWTzFnVXdwbDlZeHBGa252?=
 =?utf-8?B?TzdGNU94YlNPSTVJZXFZRmxreEJuN0UwUU5sbHpKYzB2SmFKaW1vRHlLWHNT?=
 =?utf-8?B?SFVZa1VaUVNOdmYxK2FkWHhFZU16Qytoa0NYZXNrTXdLTUpEL1llOUliY3FP?=
 =?utf-8?B?VElxbzBnVXluWjhXYW5LeUdqZFg3WHVHaXR3OHJnVU96RW4vem1RbGRxbmdj?=
 =?utf-8?B?aTVBM0xteWFLMCs1T1NPU1ZCMlh5Z0FDMldJTTdnbjJnRDQwbEdZUndsN0d0?=
 =?utf-8?B?Ly82SWN6K1lPellMSU1HVUFjRUxpVXFGVlJKRTFjUzNYcjFRRkpVa0NSTGlT?=
 =?utf-8?B?M1ZiUndVMndSaGZsWFRBa2hQREF5c0xYRVBmTHVXbUNWbGJIMHhnYS83anBL?=
 =?utf-8?B?dnlncjhYMXQwVjhXUUpvcGZtT1BIaFo0OHUvSVk2eGNJVGRGQVd3TkFkZDMr?=
 =?utf-8?B?WUR1MU9jK2hwWTBqd2pEa0R2YVVoM3o2TlBhcnQrbVI3eWlaNTV3bmlIUzBr?=
 =?utf-8?B?WHg1L3VmcTN5a0pPaFhjZFJwVWp3NWdLVS9HUlV6Sk1hUWw3dkg2d1RKQmpY?=
 =?utf-8?B?ak81TUY2LzhlQXFGMTByVFI4bGhqVWtuNnJGdTVHZkVlV1JZSW9oWUJNL1JD?=
 =?utf-8?B?UW5Md1lJQzFGUno0QUd4azBXZkMwcWFxaS9VMW9OWHU1R2tkcHNRckRlS0U0?=
 =?utf-8?B?NjhkVDl5OWZubHhoMGVubFdnQUZvTWg4aWtVNGIwTVJsdm1WWTVINDc5NHpa?=
 =?utf-8?B?ajF0NjFMblJjNU5HYU00U05SaXlzUEJaOG5SSUhYNm5SbFlCVkR1VnhvdlZo?=
 =?utf-8?B?dmVHZWI5Z2MzMC9CNGFUTG9XdzBxZ3V2WVM5Rm1XMVpQSVl5dEZSSjdrcWND?=
 =?utf-8?B?NXcvYXZxdnVYMmVWeWgrOFFxUjFyNWtrTDg5SFRjdzB1dXh0YVNxWXN5SmtS?=
 =?utf-8?B?aE9JTkdFd28rMng0S3JJZWxWRE5Ka2huMW9RTzJiekllM0l2VDVqZDc2cVFk?=
 =?utf-8?B?S3ByUGlJQ1VlN3oxb29pOEZiSG9QQjBqM0l4ZGh6MXErUDRsdHNuZzBna2tm?=
 =?utf-8?B?U3RyRWxtTXBKS3pLU2FnKzRBdjJ5SWIwWmRRNHhsN3JIZWRUVVh4QUlkZDYz?=
 =?utf-8?B?MmtoeDFkRk1Ka0pDYzYvZFhid2tPeElIb1pHSUxzWHRQVEp6WlZFRUZ1OHgv?=
 =?utf-8?B?c0Rqb2NxUjh4ZUN1Z1RIMkdkYTd3Tkd3RmZ3NUVoUVVqWWxEVVA3OXpYbjdF?=
 =?utf-8?B?c08vOUppZkpibDQ0dElVTXBDdGMvdmRKZkJoQzdWNFg1UXRPY3ZleklFT0dh?=
 =?utf-8?B?dHJRTmUvbkw1NzZIYzRDOEdRYkk0eFZmWUNPZFFKU2lITUppcEdKS2E1YjJz?=
 =?utf-8?B?T1k5d0VSUGhyeElvRk5zLytuNkh2RU5hdU83cm9EYjFnZ3g2ZWRPZWlXMWNm?=
 =?utf-8?B?ZThOc3FObmtmUDdTaWNJdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WXRBWkhzMlR3ZlhUVjVqYVU2UmdDM3NEYmd6U1QwZEk2ZFNxTExzRVZrdk9q?=
 =?utf-8?B?YUpaTDEzakg1QXcvb2o4MndoUE42aHNicXZzSnVmVFU2M0RSeTIweHBlZkhB?=
 =?utf-8?B?dUhIWWxCWWtGb2R5L0F5U0JSMTIvOThBV0N1NkhNRWFlVFFOa0h6TVEwY29y?=
 =?utf-8?B?ZGV6akhXY1hIU0swZGlDTUJVclYraWRBMVgwU3ZnUlNQb1hFVWZIYVdOQlVi?=
 =?utf-8?B?T1dOUXFuMkdQcEh1UUo1TUNKYVozcmlhbFNJOXhoSnJ2TDh3MEpZamFkdDZq?=
 =?utf-8?B?VCtKMko3N0t5WlVaMUVSRHpIVVp6bUo5VFY1SXdSZnFRRlNoUDZuTUNnNzh1?=
 =?utf-8?B?a0ZlT3hJMitLdkJwYkVqOWZrelRvd2owT3BlV3MzdEkyRDJwbWJZdjBFMk1N?=
 =?utf-8?B?MzBQMHd2eGZ3Q25UeFdUU1h5K3A1U1lVQWs0Z2FCOHY1dWtFNTE2c0cydm5v?=
 =?utf-8?B?RFRYd0JpbWFGNlVheDE5S2xSRXc4cWNpVyt3aW1wSzZiUmExYzRYcTIybEVr?=
 =?utf-8?B?Ty9malB5MDNCSnU4Q1N2dm9jNzUzdmVpNFdPRG1HeUlrRFdZYjlnYW9GcEJ5?=
 =?utf-8?B?OXA0eXJiVlQwMWpyeXpwMU9tdjEvZ1hzY2xuM0FsSzl2MmEzWGwydVhISkZZ?=
 =?utf-8?B?SlpjbkpRVlM2Mk5KeUlSaDRac0tlNzhUSDlhOHJnTFNFOTRSQnViS2JuK0gr?=
 =?utf-8?B?V080Q3c3QmQ0bjVBTG9DcG16eE1aSThnVFgrVUhTMm5XdWVtV29kQ2QvOHV3?=
 =?utf-8?B?SVpYVWhSMGlsenhibWtMUGdOYkVkVHdmVE5RRUUyUFBXYUZWWFJZTHRJSEZW?=
 =?utf-8?B?blZDS0tPdTY4bVVPMHQ2TW5YMmtjYmVBZ3VNTCsyZlZYKzk2cGRKMlhrMzc3?=
 =?utf-8?B?WEJ2QXZBaXBmRDdjeVR5V1FxbFU0L25FYUxSeFNCOFNyUDlXakxsRjVDa21P?=
 =?utf-8?B?T0UrUC92L3hjNEFlb2ZLaWlhWFpTRXN3citnMDdDTVhMMTlzUW1TQ1dIRzM5?=
 =?utf-8?B?K3pXcFJQVGZXVVg0L0tmT1ZjaCtGZHJoSFVpK05RL004Q2Znb1RtTDZML0Ft?=
 =?utf-8?B?SXgrYjVzNnFkWUlCMWI2RnpZS1g4dU90UEoySG1qWEhuTCtneUc5RHZ6WUZS?=
 =?utf-8?B?U1V5ZkRXNEhPWXc1ODlLeG45eHVMZlFsU1c4ZnQ3ay9qNEx4RncvdVFrQ2F5?=
 =?utf-8?B?OVQ0UThnTHJOS0p5by9UZUZ3YVNoOEpxUWczT2JROVdBNEpBN2ovNStiKzI0?=
 =?utf-8?B?dUhTa2dyaEtxcG1WM1dERWtHY0xqT1hXbnVtUWtMeVB6UTdiamx1N0dvMGND?=
 =?utf-8?B?aXJOdWsxdTB5QUx4bFd4YWRmTzhVTEExbDkyZDVPaXFZU2JWcjZEUm5lWm5w?=
 =?utf-8?B?bWF3cGprS1BmSHpZZ1ptTkdJdGRYVGVxdDRlbkl1SHhyMXIzalQvM0VQaUI1?=
 =?utf-8?B?WHhadW5INitndDh6TkF1NmJWeUZINGI0aTNDRm9qN2VUd2ZUTjVDMnNYZVJH?=
 =?utf-8?B?RjcyQ0pRMk1lTWttS0xVZjBMU285TERGZDY0R0xYU3FLV3pGNCtqRy85dysz?=
 =?utf-8?B?c0ZyK0JLV0dKVWRsWUZWcUhHbjdjU1RsdkgzM1JiSUxkVzV2TFM2enF5VkFs?=
 =?utf-8?B?d3RycGpadVZoRDA4YmVrMnQ5aENqdytvZU1IamNxYlZ5NlJ1dVVMQndvelVF?=
 =?utf-8?B?em8rTExGcjBJMmRvQk05SjJ4V0wvVHZINFFBVnZ1VzVaMG5lcnJNQkQvc0Fi?=
 =?utf-8?B?M0s3dDBKYjVnM0ZKemxEaUxaa0duVFRlNUV4OEtCSWIrbitHOTJHc0NsOTcv?=
 =?utf-8?B?V0c4RHM4amNsbE1id01hNUpPQW9oV2FiMFZsc2tqQmdRMkFLakt5YXNxU2xi?=
 =?utf-8?B?bEtoaTFHSnQyWjErNmpPdUNxVmwxUTZzSVJjRDU2OE15RlJ4eHdTY1phcGdI?=
 =?utf-8?B?WUh0Tll6M09pd281V0dvREY1SUtBTVdQK2FxMFBXaGdxOHZCSmhxbUt6Vkdq?=
 =?utf-8?B?Wi9NZFl6all2RHlhRDE0UUJJcVlwMitWekRXVUFTMytjTFI1Z1ZQMGtMdURZ?=
 =?utf-8?B?cjI4SVFQSkRiekM0K1gvUE02YkJLTUd3NURnWEpsaDNxWVRTVnlnRmZMWVNM?=
 =?utf-8?Q?y2pf0doscOhTYrpzyKXxnrwD1?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d4ae0a-d471-402d-7867-08dcbac17d66
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 11:25:37.6154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6ebohaWkwcnFRUrEPA39kE5we6SBuvkNaSWFmBVBEIzaqfiYxvjbGMWpw6W5tJdzjRV6/GRZ9u8wRsBoo4vEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6361
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Aug 2024 11:25:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16781

On 12.08.24 13:16, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> This series of patches update the latest image reference for
> debian-cve-checker after being moved under cip-project. Suite
> information is included in the name of dpkg status files uploaded
> for various targets.
> 
> sai ashrith sathujoda (3):
>   scripts/run-cve-checks.sh: Extract suite from dpkg status file name
>   scripts/deploy-cip-core.sh: Include release name in dpkg status
>     filename
>   .gitlab-ci.yml: Update debian-cve-checker image reference
> 
>  .gitlab-ci.yml             | 2 +-
>  scripts/deploy-cip-core.sh | 6 ++++++
>  scripts/run-cve-checks.sh  | 3 ++-
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


