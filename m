Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842A3C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 00:09:52 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.46])
 by mx.groups.io with SMTP id smtpd.web10.64279.1701907790874951930
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Dec 2023 16:09:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=a8vEuRut;
 spf=pass (domain: siemens.com, ip: 40.107.21.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUWcoBdvtzv1z/aFkEXMhg0Uelz7V7Z0wYyhyXwPd+wvyRec6zRITvs5HJ8E3KBD6Kv6vkT3J7MSJXgI/EMBmDGTVPZxjS9n2eDRUq/YB5Pq5ZU3mE4dxlwI4c9NltTL+WZ4zGr5KYuUCiXNAU+TubrCNkcxqkUbQUXo/Q5YslvGxaP18T3Koujit8fxa991wNI2rDH5+JV6hwe9DiAV55Jft0gJU6f/IOZFgqvs3qYxv8EbLhNhFuctYR+u+kvx/q1HATrn2ckqBjlZkIueC/XKACJClLkG6mewjXEqcn0Y/uxID70OG/REJkLKM5w8Bt0w0w3lLbmytivM03wi0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=megBXcw7PsV4CWzJ02OfS9WmSEhpROdSoDoxh0g2XEY=;
 b=FzwDAQqLTu+Ogfd4N+9LQNcyla+A/M7sdxEbndByhukuF46tfmUDtcnEjJz7wGdOJJeC40MkNO5T1lpd0EwUU3pe37QVLVouf8HnVNv7e9FqTrdChUyqytgFkuVV2kbKSvbCx14c87PCsfEuGggb/FKNdhNa5Y55WPr4MBF5R6V3lnTmInVukgx+S4SZ1x5sAwDyKiomy+z8xYn6XRk8yprCd77P5PN52H7/3lDQKl4X4fjm9wjEGtDQkMn4TntBzMaOyFH8amb6UyUaNzlT1MqQGGdVarN1oIx3Q5I4UoOYFfmIV4CHu093Ip9BCJ+DidPts3VqikGOCZIOVunZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=megBXcw7PsV4CWzJ02OfS9WmSEhpROdSoDoxh0g2XEY=;
 b=a8vEuRutt30nYR98XPN7XH+HDAE1etyQe6bY3PFaqWBJlCSXISdu3BfiCwZOgM05G9JZqSJQ1wnwYjFNhnedXIW3B8gB9gZ4nrEH7xci3n/SzkvBWTMzT69je/QCwpNqE9LiO+j5foWR5YUu50AWTvDwL268Yoaaj4Hb8O1Miyj2yrVmgSuME1c5zvDD2Ke+zfErJGGL7Zw6RS98vYPHr6gCx1NaCBVUDmR1VFPDY2xhgAWOC98bCloXrfsYZfsjtm/cPjdXeJzqCwhjrQTpYjgWjHfPff261HSs+9c/EsC8PE+KOf14Npk08p7CZ4GGGWhlKWlPKRHJ8616p459dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 00:09:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 00:09:47 +0000
Message-ID: <2be59100-035e-4008-9b41-a7758f811b0b@siemens.com>
Date: Thu, 7 Dec 2023 09:09:41 +0900
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 0/2] Add Bootloader to Update binary
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20231206143528.1900797-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231206143528.1900797-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0111.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3174:EE_
X-MS-Office365-Filtering-Correlation-Id: 975a9d23-8106-465a-92d2-08dbf6b8d261
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kiasaA7zEp7Ltz4RScq3AMdH6G1sPULbFq9Wt4+XdWxvQbzcaNrZLXYWWaPy9VPjBOzMjSigqnhiugRBc8SyML6UmbAO24L4MRW9SlPL0ChSIrkUobVHxrokV7M55opK7MQtVsIxfDNJx31TYgE3Y67A5NnsXGr/b8rtT25Y/rgX2VYMr5ap3vMFuyZW+RJDyajsI+kLt637dLKmwFVwxeINwnyaW3SMh0mZuVEuZpT72QQKQb5y0QO1cMhwWG0ceqsO0B5fWPfUp8UeOCiQ8rA6Q5UgRFU62PTpkgh3qPc72u9sjxy0A/upLE/+LECIGKVt1zH/0ZLinGFLVdXbXI33Pd/s2KfabTdHY4WNaATS9464JJV6kcemOs1/ukC4ZBDIqeDOKh4I3LwByTWln/oa2Nz2gq4cKKCcdB/0F/aot+sYt5SgHeHipwj/kFuXMndjqZQXQ1jV+0IZeKItVJjt72rusDJ6lOjvz3jZBRkr4w7Ld/vH8vTo8T3uFPq6DNySZ5t2Z1OOLiadBLeSIS001h3Ozc62eoejelSyeC09+itzcKeXwScZOYwbAU99OL2Zhd0m+BYgTrOH/0zYcMEtJg2wGGgKeTyFejYIQuLeTSdtdqBYogO5W2KEnxQ68Gh2erkZUqjegrSxHl0uCg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(31686004)(8936002)(82960400001)(31696002)(8676002)(316002)(6666004)(86362001)(66476007)(66556008)(66946007)(6486002)(4744005)(5660300002)(15650500001)(44832011)(53546011)(6512007)(478600001)(6506007)(2616005)(2906002)(83380400001)(41300700001)(36756003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Vnd4K1EzUnFPZXFaV0IzV2Vlb0UxY1dueTFCQSs2K0l1eWJ6dU5xS1dpVXVr?=
 =?utf-8?B?MHRLZnA4cHE0dkVkTkhIVklNWUl3UHBpV0tBbS91SGtoVVVaeXlJbG81VmRp?=
 =?utf-8?B?VHVmRTU3M1FmdHZ2TnAzVmM1RWN3UWh4YTNZcTMybTFKVkgwWHBWU0xrOUVu?=
 =?utf-8?B?RW05VWVvNFhnMWVEeEQ1dHZNVUdBSnRJK0JPQVpHc2cyZ1hJYURHcGtjdXM1?=
 =?utf-8?B?UXBIbFlBVWVYMkd0OEFEU0dqYjFNV1dDRUF0WDZHZVBzQVV3ZDZhVGg2cG8r?=
 =?utf-8?B?QStRYnNrcUNlRU9lMkdEU0w2YU1CL0ErYXlqeG5tL3JuS2ZJMHVoNU03VEll?=
 =?utf-8?B?YjhrYitBa0ZCSXBxMTZIN2ZhWDlvWXEyT3IrMkNEeHVGSE5WNk1WMjNFVXZy?=
 =?utf-8?B?UWZtUldxWFY4YmdYUzhZY29KZWt6c3pJbWp4SGQ0RG1OaEpLbWlyaUdtYnJm?=
 =?utf-8?B?R1pxcmMxOUdMMUJ6aXBOZDVRYkpkYW96dWhTUGZtU2lZUkJwSVJlNXZFTXVp?=
 =?utf-8?B?OXVYK2RDRjhCdXRDYTdSMEZpUnNBWjBlbWxqaFp2SGdKME1SVitaZm1makF5?=
 =?utf-8?B?QTA0Y0UrcFpRSHhhdnZ3bGE5eU9jRXY5UUpxRS90ak03YUFhNUhMLzBZU0JX?=
 =?utf-8?B?NEtjZk5sSzRNN01MSWRQakFlZHZLUko5RmRXK1NLYmlGNEhCNi8vc0tDNGtZ?=
 =?utf-8?B?Yi83UVRmTHFzaW44OW8rODdWalMrTHFxdmtLdWpNZjEyR2tqWHBIeFlzTW1Y?=
 =?utf-8?B?NDNYejBEWHZRSlV0bUcyS0l0ZVJUdzZhb3ZVUForWGh3Ky8vR1VhTDY5RlRp?=
 =?utf-8?B?d1V0eS9yd0hGV0pFSEdHRm9sYlpBUVZlMlE1dVFpVDdyQkpmWSs0MERvU1ZN?=
 =?utf-8?B?WUdmeVVTOHFCR2YyYW1IVVNncGovSEw4WmVPcG91SjZvZlJwam1aM3drdENi?=
 =?utf-8?B?STFIN3RaSEJFeFJmYlNmV2Z3MS9Hdmc2aWZwNU54bVA0aTcwTnYwbE5xNXVp?=
 =?utf-8?B?SDVmUjlFSlFnWkFYSVZNS2pxTG9sR1U4ZXFYcy9VU2p4cVg2bGUva1U1Z0ZB?=
 =?utf-8?B?YThFSVpPNHNacXZyalhmQ2lHMGZwU0p0d2NtUHp1ekNDZWhNemVWa0tOQkVz?=
 =?utf-8?B?bEg3L2JWc0Z4Y3pSQi9lTVRPaUlpeitkTm1GYzFwL05Rb1JHSGRpK0NEY1Jz?=
 =?utf-8?B?NzJTTmcxcnBWWEd1MlFtOXFYY0RVc2JXYjkzejdtNEZXNDZGcmp3RzE0UTJl?=
 =?utf-8?B?TzBRRERmQnlobmJlWjY2RXFQWDBXb2ZwNGx3VUkrYjhiaGlTNlhYazdoS2RB?=
 =?utf-8?B?eWJhN2g4bDBPVEs0UksxV1FWekdJTWZubmJDTUlxZHkyWk1kNjBpeFoyMFVx?=
 =?utf-8?B?ZVNkckpYWFIySmdVSTVmMy9RZ0tJOGl1NzBESXdnZ0RVQWE5dVVNRDEzVVBa?=
 =?utf-8?B?RE0wZTZIU2J2VlBkVlpVMUoyTzgrTXFIL1g1ekZxeTIzRktlTnF0RFJiUVNr?=
 =?utf-8?B?QUZ5Q21jbUpqemRoOTVTdXRyU2w0dFpVNmhLRkEwektwaHpTUzVDTzhieDFi?=
 =?utf-8?B?ZUtxRmRDZVZGYkl1MmNJMzloK0NQV1JVeVVUN0hTNGVranFSSkFZMVFYM3NM?=
 =?utf-8?B?eFJ0aldoc2ZHR3MyMDlPcS82WEZnNzhpNnUyOWFDS1lMNFVhejVQQXVacENw?=
 =?utf-8?B?ZFY3Ykdpb3hzTFQ4dWo2dEN4SEowM2ZCODVBQWJxQ3NJY1ZrUXRmRXk0Ujk4?=
 =?utf-8?B?U2g4c1FiMzB3amdDWTgyV2NLQmJHaEllVnN6UWQyRWVPOUJpU2ZGZ1E4MFJE?=
 =?utf-8?B?R0lkTE95RFBCUS8yUFNlOEs2TXhuWXkyNDRBQndaRFQyYnk4bFIwaitic3hX?=
 =?utf-8?B?bGJjZ2xiRVBVSkkxU1lnYVc2alhxR05OUTZhZjE3ZjlzcG1JUE1CZWVKUC9R?=
 =?utf-8?B?UGNoN0JuWGZYamdvU3c4bEJVeHF4MGgxNnFuNWFtSVpXblB3K1BMZkk5Z0hF?=
 =?utf-8?B?YlJEQ05CWTYyS1BwbFdqalJpRTN4bnhBTVNGYWFSNGFCeTFUOFVKRzdvNVpQ?=
 =?utf-8?B?QTZIMnNGZXdqQjZhbHhRUFc4K1Zoc1ZKSWFGZ2RDdGdrTitNc1NZR1FQU2l0?=
 =?utf-8?B?RUVVcU5DRlBzUmx2OHFzblNmbFMxaU9DVGNWeFVubkNhcEF6MkZJMDExSFRx?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975a9d23-8106-465a-92d2-08dbf6b8d261
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 00:09:47.0870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRRTgq1KleePk/ZNiaCh6CvTT9kRc3luJ+Ga3rHdj1ACQjs2OLXkZF1K2isnjJpqPCd7o9w+gBnB0dSbOoq9Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3174
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 00:09:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13803

On 06.12.23 22:33, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This series adds the, possible signed, efibootguard binaries to the deploy dir
> and adds them to swu file and sw-description to update the bootloader.
> 
> The new entry contains following information.
>     {
>             filename = "boot${SWU_EFI_ARCH}.efi"
>             path = "EFI/BOOT/boot${SWU_EFI_ARCH}.efi";
>             device = "/dev/disk/by-uuid/4321-DCBA";
>             filesystem = "vfat";
>             sha256 = "boot${SWU_EFI_ARCH}.efi-sha256";
>     });
> 
> Should we always update the bootloader or should this be a optional
> addition to the swu?
> 

This should not be the default as the EFI Boot Guard is a single point
of failure. Updating it should only ever be considered if the
consequences of not doing that would be worse than the risk of leaving
devices bricked behind.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


