Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B31C7618E
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 17:57:13 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.74])
 by mx.groups.io with SMTP id smtpd.web11.19511.1682099825453844702
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 10:57:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KRcPHXgY;
 spf=pass (domain: siemens.com, ip: 40.107.247.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRcdKDfI1fmfHmL3hEp9Z2LTnM402hDG5HM3ih9TSfwbUMNtZAzESHjCg9AYotQ9CnForF4ugg8TApKqPkp73afm8LOMpV7Nx+Y8WvHXN51ju7bqCv28ehTMX3FpMxTiyA58QqZ+pZ4HMHU584ubr0jpBYJJL1rlJiL2VjQNqJjnB1rTkP7j4kZRCZ+BkL+k2HKRMf2A8J1kxaWXniLbLc5EgRhnZOy4jh0hzmQYzKi2Q1jbbQfW6kUBYa1V7Kzw6d0QNaaRwWGPo3R8nuHZ2nc5xz2Sra+ZT/YhnKxcN1wLB3C+brOnMeCv5yFz8Vok1I0dh5RdR61OkTDAmmFGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eat4seKHBLHIKaysvBVbW8TZ1LzmFyr55c5gOnSrHA4=;
 b=jNfRRCvnXUmzu6HFm+ZGmGQkXkoY7bZcr5n4RLC/DmK2Ckhp/sbHaQR8yFfJcDLu4Awg78VBlYQQ1lAl4YEc2wAFlDhvB86rt/PncBJTrxnGwYJmg2t000z4TppLulFrKoa85bKXEoKVFNUT2Esu6IDHLOYHHsAzLy05B1ayBoQ9xDzn8dmK7Ykq1S8xkpJAn1iAyMxGb9NG9dxfHb3XhDM0IVZUXzLDmgn4zAEJpmK7qQASyh0yMYA8ibRgtfVGDvWE+zx0MlhRmIQFrbkhFFNI9IFENtFRcdrO14IK9sxNxJ+XDfGZCAB+fYq0tWj8ymI8CPV/aYplmvdN2vmE+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eat4seKHBLHIKaysvBVbW8TZ1LzmFyr55c5gOnSrHA4=;
 b=KRcPHXgYgGgN5tsSgoFBa7fAHAcw36HIADq9bjBVI5+tYSM/9Xn/tizh5emx1ILCYJyBV8JR/2naA2xRDoWvcEdSS1pVugmy/9ZagUk4AveV/oFanDg4tgYTQKD/TkiGoLxSvuSHJx3kkL4XUYrKvp7UGXAVGIhdV+eFnsNIstds1Eqa6hNPG3L0UftTgDvk7oozUfqjTPPIlRKS7ypVHunISaUTQphN/15TtXTyNxxGHa2yOGSyjrWFmvZjuWZxKSjp2UZQpKlgYynLPqN9UtYO7LUdbM3VRNvX1RvYWN1/BbLksFjIvoiVACC43cyO0HKJ7wuj23Wzfp/TG0UBZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5205.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:287::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11; Fri, 21 Apr
 2023 17:57:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.021; Fri, 21 Apr 2023
 17:57:02 +0000
Message-ID: <f4ec927f-5d19-48e3-84ec-b8dea9b5c13e@siemens.com>
Date: Fri, 21 Apr 2023 19:56:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v4] efibootguard: use debian
 folder from salsa
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20230421141330.3905234-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230421141330.3905234-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0158.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c24ae3-99bf-4ea8-46e0-08db4291cee8
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kmJDHCqUgyM4nIG1gOmvJcEIKgiMVAmBxITZ9XX6ZUPLO2opA6bfyQbzyKaeYd8fwbiAHLBwr2B5k4TQGm2LRGCCRwE/F9GSSmoFhSbWiCcTVMQHuxVYVnTUd9eLa6OS1BczRtS4yysjuI3EJbEOk/kbexmh/WBGxBTJCyRCJQ9fZngpunXifa6CX3+5HrUIQszDHirzv4tvlAnoFxZFbgKBI8MCoEX+rHKTeNk87TsLVnDY7u/m6iVjMcY8tkXGpEgEQUPDBmvic/HizeGRSTiWq4UdMOI1JsjnXCc9R831PgSzta6cTzE57RchTtXPiLonrzaPVyUmcC8AHoVwauDWXxZpZaZGreXCUX9KUjT5zhkXHQGjSklyDeqlq2ml5YBYj4fU8J1iVU8PawHeU7p0bhyymkPlzBVLIGsm3iuEhb/GS5ETRUy7wk/ON2hNkpPXf09afHR9gxxWb+flkqy2TVHvClOagg6/ZPyOIBK16pwzUtsYw0EOvfyQEn6TsASFH55sZx07JIcX+kII4fAaAc7v+F4aNoKLyoCdINW0Uwce8FDSuUgdkSAPY/vrhQIGAHp17ia9dyKhor6VOyMLRAOayvWAkJMWB68NfFolOYl0qIu8JB4EbCw//j6nF8C6FQ+xvSeNE3WvDLZlmA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(186003)(6506007)(6512007)(53546011)(26005)(31686004)(2616005)(966005)(6486002)(6666004)(5660300002)(41300700001)(8676002)(8936002)(38100700002)(82960400001)(86362001)(316002)(31696002)(478600001)(66946007)(36756003)(66556008)(66476007)(4744005)(44832011)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dyszU3QxNERYbElZKzNQYjh1NC81THM5Mi9tcERJT2h5TFpLS3RoTEpicnE0?=
 =?utf-8?B?cENMWWVVODVySXpKZlYzS1Y4ZGpGMlhjZXIvOU5TKzB2MTVNekZaaHJuNFg2?=
 =?utf-8?B?WEpRMFlEaXYyT0VIaGhDRXg1aUpTZlpXaVB5T3NzZjBoamwxVS9sWmVpdGZa?=
 =?utf-8?B?SFZwRFBBNzcvVVlETTJGRTF2a3QwcFV5L0RRNnBEQjhad29yWHdIR1U3S2xP?=
 =?utf-8?B?WkQvSTlaRkJ3ODR2Y2p6UGt2a2xGTyt0OFRHMDVzeXhZTVYxMG9oQ0dTN1Y0?=
 =?utf-8?B?THJLNE9Bb3FyZ0dxNWtldXFRSWVXUXY1SXdkRGF1T2FTdVgyQTd0RFdVQ2NO?=
 =?utf-8?B?T1hyVC9xZWMraFNwWnBITS9rOVd2bDIwN0N3bkVaREJlUWhmUHg1eVV0bTZ5?=
 =?utf-8?B?Zkh1b08xVTNDZUJqaVBUWFU2Ynp0d2d3akdYRWtLL1Q2STZWUVNFV1NhS1hW?=
 =?utf-8?B?ZUE2T2F2OG1NTmNiMzZGa1E2L0x2eGlvU1FkTmphc20wQlN6MS91SVUrUWRz?=
 =?utf-8?B?U09xbGxqOStBaUgyYy9hTjJMN21DUzB5aDRrYm1MV1Z5cGFDUXJOaDRQYXZI?=
 =?utf-8?B?VmtkVFI1YkFXRndDdmdYdGVCcEFsVU9nTXBueDZDa1Q4amZ4emJtREIvUlRz?=
 =?utf-8?B?OXVxSHY2TkZyUHlnZ0RZcG1KZGpleWNqcXBJL2RFY2VJdVhaL3dueVBiTHBW?=
 =?utf-8?B?bERmVjl5djlLVWprNWdzUUZLQjFFaTN6SXNITVVyWUZKSkRjOEpnMDRINVps?=
 =?utf-8?B?dUhpTkNXUmVvWHdQaXQyV09RWGNseHF2QzhHZjVidFczWGVqUlp2Mk5WQ3BE?=
 =?utf-8?B?ZzV6SW1aWmdHVHNnWDR4LytUdGkvd2FkaUhma28xcUU0a2k1KzN3NlNYY2Fx?=
 =?utf-8?B?Y1pqbFlXbkRhanFGMUJqdVFwMi9JZ3A0QitIRWZOdzBmMWFrL3BzU1Q0WFY5?=
 =?utf-8?B?bk9rVWdSYjJBWFI5SUc4bm9pMVlJUmE2b3lTcU1kUnZpMGNMRFFnOTNqZTJi?=
 =?utf-8?B?TGVlY3FMQ0JWN1V6bEFOeWdxMndxdVpzQnZaRm50bGc0RmVNUUtwbmlsRmxz?=
 =?utf-8?B?WlptOTluMzhRaXhaU29JVWpKcFhDK2hQVWpGKzZIMUI3SENmdUNiRHcwR1JK?=
 =?utf-8?B?cm9WUFJrdHBEMk5OUHk5MUo1Q2tWSGhuZk1zRFhhNW1hRUpQS3drblA4OFlK?=
 =?utf-8?B?UVRVaE9meHR4QmxwMDNiQTlJb2JVazh5d1pUVFVTYjNEUmF1ZngyK0xOVzYv?=
 =?utf-8?B?SG1IWSs1MDNNWmhsOHZJbWFTQUIwNDBVYTV6bmFUWkpJUkIrQ3AyVmVLalFm?=
 =?utf-8?B?cXMzTVlYRlFCbFdsRjVSNFhyMGthUEl4Zm10RXNWUFY2YVlkRTNodTArMGo2?=
 =?utf-8?B?YXpjNGt3UmgvQ3Bhb2pLSHpKaW1mOFNPSS9hZWxtYWJBZlFaWEhZdkhtYitG?=
 =?utf-8?B?SEwzMjVuOVExc3pBVmlPZlJyZW5XWk5CZFBITm1RUGt5VGo2L0RmNFRvT0gz?=
 =?utf-8?B?Zzh5UDFkZnZYOUZqNFQ1Ynp1WkEvaU11MXdzZExaamlGMjB6RmR6ODFQaXIx?=
 =?utf-8?B?RndzMWhlSE5pU2pNdkZvT3RUa1FBdG1wbWxUaWl0ckp3SkxOZWtMV2RGaVkr?=
 =?utf-8?B?N3FVZTNvbFRab3cycmt6Y1MvcE15a3VrWkd5WDZlcHJxc1luQlZ3ay9GSFht?=
 =?utf-8?B?ZjZKeFhRY0FpamFraWtNYVZZSGNRRmJPOWtjeTZZaGRNd0ZGaVFlNG1YNlhQ?=
 =?utf-8?B?d0RDZzRCNEEyMkh3bE9JVXdSZVdmS2h3YllDeTB2ekJoRFBRbUlpcEY4Zjhu?=
 =?utf-8?B?UkhnN3JCOGxOdWxaZzlSZVMraExtcnZBc0pHSkd4ZzJoWDZ2QWRNY0YwSjE1?=
 =?utf-8?B?NlZBdWwxUUJtNmt6VUdjSE1aZytpb0tXYlp2aWNzZjJPcUF5dENwelVEZ2d2?=
 =?utf-8?B?cDlwRVZnT3FraHVFb0VlNnlldnk1a1hPWGZSakxZdzhpUFdOR3lTci9ueEhN?=
 =?utf-8?B?TktYOHJZeWxaWDkyc3JMbWZHenRHRUVuMWpZNWNocGFGTy9BMmtCUzJpbEpm?=
 =?utf-8?B?Ulpsd1RzUjZkeVhQMkZOeU5JWHNtOTFEdVV4M0VmYUtOb2RvOGdRUldzeWEv?=
 =?utf-8?Q?TB0a+XC82+LlxQb9wnAKJyArs?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c24ae3-99bf-4ea8-46e0-08db4291cee8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 17:57:01.4336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXShI0UrDElfOn+nAsVouYXetELvspTnZrjhj+upvL0vhQIWjytfWE4JGnVLkPadMNoqxcn9sdB2BT4m6wg5oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5205
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 17:57:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11326

On 21.04.23 16:13, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> To avoid package name conflicts between cip-core and Debian upstream
> use the debian folder from upstream to build efibootguard.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v4:
>  - readd patch 0002-d-control-remove-native-from-python3-shtab.patch to
>    allow build for qemu-arm64 and qemu-arm. see https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/844580247

Is that patch also upstream relevant? Or is that only needed for older
bullseye/buster?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


