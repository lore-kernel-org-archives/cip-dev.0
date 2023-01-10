Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F10C54EBC
	for <webhook@archiver.kernel.org>; Tue, 10 Jan 2023 16:39:16 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.41])
 by mx.groups.io with SMTP id smtpd.web11.109038.1673368752738866541
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Jan 2023 08:39:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cvBsZviE;
 spf=pass (domain: siemens.com, ip: 40.107.8.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIdQS0r76PJIhPOnSPmkfU4i3jX+FyCbuHAYi6KUPdPQJIXn72kX+c2lkPpv/00AAzjcjQ5lebe6HGxEHW02PKld8aG5XDCgh4j8xmlfWjo4Iemf1x22jKa9qdiy3nP//AIko3iQF3A0XadP7cFXtUqIUjY8y0RPXqmFY6uAmc/thP+X/vm7mg5hWfZOnbVKJTD+iGISEAw/i+4DTgodaVmVuthTh52/lHyOt9STglcxe/b2Lb7pMa0qDvSQ3nA47uVD6YDYSHpNYE2Gm3/gQnZzO2j7GkBiLuLZgqsR0JerPuBVqCV74FPSmyyJ9ETRHWYf4xAiCx3ClRvcLIpE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMsTqiSpAcimnjIDOaPepGtWqELqj1RAtyF1vHHvr2s=;
 b=ZX4HVEbWhH26C+NbpI/52kX4cgJ/mB1Wh6lbcdqkebv9myH+u5tAaQGdw3tzg2nDnpTSQmVHFLbLJpF3qvV0KzfEtn7GmFwvbIu8fkKsWeZH7sQruoiNhzY/9KVMpozgNzM7RyfaAtLLUa+02/7JhJzpjoBqlgezAv0AubW/7oiBQ3OE9ouSHFtbNejbLQlddaYSorvcl8PnTDm2Z0RVqfbRaXfpbPSpI1D+W/2hLLJ/ppwWk2tF1W6BkELr/PkdKzN4u9TxF+91ZNFjPwg+qeFKiukhzOVu82vWfpyFjBURUM3Z1h8ESNikQ8woNVY7bNbNQ5nBoOyQ87dUQSsW4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMsTqiSpAcimnjIDOaPepGtWqELqj1RAtyF1vHHvr2s=;
 b=cvBsZviEG7nH9GVAJrslQ/d4WOFVwDx8M0+Bab7e37ghjSTPaLRiB02/mkGF3WuuY7gn+yGAFTF7CQf/zsWYvQEhkqzqHSJZK58mEPOtNwgJTHoM9TGHMOp9Id69OtRH2YGWD0YrUVo7cEoHZr7hxFaSUrdERPwJm+u2LeODaSnwfpWBwI0gpN5L6254nHZ/JXsCfCLXjxIh+0fbbtOYGp1Wu5u4W4AZE5sMecxTaEzt+CSnbNTk5MoGB13sFbkxprbpHu60VMQpzJuR4sKf3DcG7BTpUeQfnVsusbqgypnrTYAcmm5j/lis6pV69H6gY5yX79Mrp+sI3g9j1b8ZuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6695.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:39:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%6]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 16:39:09 +0000
Message-ID: <308b3247-d201-317d-e3dc-ebf8edec817c@siemens.com>
Date: Tue, 10 Jan 2023 17:38:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] Create a generic initramfs
 overlay
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20230110120055.463166-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230110120055.463166-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:610:cd::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: a2bb281c-1fa0-4518-1e10-08daf3293246
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	abbpyY86HVvrzsKztDUFVNCehK5IaDvpgvWsrWq8mcWIfQnq5emna1o6aJivI/Iw3jyrGRmb4Do5LhnCsX9EZL/OTsAj7DzOtb0jOh7clcHAE0ObUXCYcIVOX3g1mQi+YFgB0D1AiXvcftvE92qmHCylLSuhg3SNkbWIZxwmF5gKtBDZimMsOdjMHA/y5aMQxP98d9qcrCsr0zcYx6RCbzj3eVqSsNSIbu/3uxV+E4WQhho2qKSPtL+AC4u8d+DLLlQUfVpSjkoudRNgyGaUY1EqgtTjC3mfp2GYJSKoGvZaLrMA+tkaWIUyDLRQNNDPMvPxLZScvulNFX9MHvtp1YOviq/4bq5D6uAkuvvu1nTJ1kx2XB0PLIkBPI1caSYY6KI8es57PzSsc0Rq3dXDrgAnushTHygT6fviOQZb+2CehGDsM77QVxevBtCy7mtJURdF2b4q7lhC/ksCLpoIqYkqAr/oVGUFRaaJWwdyszUWgjaw4iOdtY/HHk3Ij2lWn6S1hmfZg2J2QSxldJ3ej52MYm63fNgBaGhi5wFTlULLZob6D3bqdZAEIWURj/LeqlMq8cARqkD60aeb1jg+dwRCy00c3zFKiG2uZh/wKN/k+KMVh0xWgYllDp/Wv8k0BeErpnXbgb7AnRVjD/eQjktuQVt9GnU6s4wfNSUG5cyzQ6HA7gP8VSbhwYl7+MCEU1hJ6a6zLKgCtGj6Vn4EA7o5NAQLNMVSB6Q0I84XCWYSqhktQnB2+Q431pCPvNiE
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199015)(8936002)(2906002)(5660300002)(41300700001)(316002)(8676002)(66556008)(66476007)(66946007)(44832011)(6636002)(26005)(6512007)(2616005)(38100700002)(31686004)(86362001)(186003)(83380400001)(31696002)(36756003)(53546011)(478600001)(82960400001)(6506007)(6486002)(6666004)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OU1RSU9oSXR6OE5HQ1lQbkFndzhmWDNaK2hleEtMUHpXMWVZdG16SHhsY085?=
 =?utf-8?B?ZVdOMHF0dHZGY1FPY2FEV2VtU0JGRTRwSWtYUU1jOFcxSStnNFgwQm1MRFFk?=
 =?utf-8?B?RERYR1M4dVVaeUhkQm5qUmdHUWZBS1FGdjY3T0c2amUxU28rNkxxT3hlWVJW?=
 =?utf-8?B?elhXR2pPVEFFakFoZnJ3c09JOEk5endFNWs5Znhzb3B4UjlPU3ViYXc1OUhM?=
 =?utf-8?B?NFgxUGdmNEZrRldTei9Zb1YxR1Y4RXZjZGxKWVVSTFNBcm52L0gzZ0R6SDdL?=
 =?utf-8?B?TlVId09vWXlVdFl5MWJUMVBmQXkwQ2YzcHM2SDVDWmpBakRuSTNTNDFveGtU?=
 =?utf-8?B?b3NnYWtrQThMN3A5eEFuTkdObE9hS2oydFFrOGYwQkJOSEsrczZ1NHNhS0NR?=
 =?utf-8?B?RENwTmZLaEtPOVhNMUZQYVZKYWVyWGozbXN6V1BzUWREZVdtUlJvdUloczVE?=
 =?utf-8?B?Z3VIVVV1ZkgwTWQ1RHNxMWZWb01YdWVnTktYVFBrcno0ODBYRFF0bjc1Slo1?=
 =?utf-8?B?bDl2UForTzZ0enFndnVCN2xIYjJLK2pQa0Nqbm1lVGFBOFFidHlZVDVFYnBn?=
 =?utf-8?B?VTlVNnJFNUgvY09DMlY4dFBESFZTdDhlbDN3R1Jvdjd2STd3TlJSMEYxUFY2?=
 =?utf-8?B?NGxGb2orek9ITmRLa0lpTW44US9ua2FwZ1hzekdjdytEOENmTzdjejdQSHlo?=
 =?utf-8?B?cXZaMDFMVUhNQ0VVM1MwckZSMG1JOWN0SUhwOU5KUGlVUVdnK0QwakdhRHQ3?=
 =?utf-8?B?c0FXemVCTlBBNjMwSTFrTjJ2T1IvbnBlSjROazFSV0RtdzduRkFqeHppV0xa?=
 =?utf-8?B?SW1IT2dXMFgxUit3VCtkR244TExiTW90SlZhWmZKRXdpSXlKUVdQTEwyOVZS?=
 =?utf-8?B?citXSk81dkxaakY4Nkg3OUFnOFVQV2JaN3R3WWYxbUxVK1g2OEp6WU1WVURx?=
 =?utf-8?B?YVByL3NlMFJCNzZocDgveUNzb3RaR3lkSG5paVNJZ3lvMVF6NE5VQThUQ2ZL?=
 =?utf-8?B?a1I3cUFTYy9mcEV3M2FNU0ZVRUorMUpiOTg1OW1kMGFQdW5ZKzROakZUT3Bi?=
 =?utf-8?B?bVZmeUdjUFltOFc2WmNWSnBNSEY3empZdEluL0lLV2w5WmVLcy9DR1J2U3U5?=
 =?utf-8?B?R2sxcE1lTm12d1U2SkJ0SHZva1hqYURpRCtaMjUyZzJPb0FmZmt0T3RrYU5z?=
 =?utf-8?B?TWg3UFRUUEFiQlltenBPeC94VVlNdngvL2dpSExtUEIzTzBDV2kvbVVobGxF?=
 =?utf-8?B?NHBPMGkvbGRWUUFLTmM3UmFxaXpnS3NMdlJSbVJiWUlSMFRoSmhZQUVIdko5?=
 =?utf-8?B?MmhvYW9ScGM0bnJBZjVZTHBXekpCakFyZ3lrNnlvNXErZE5JUkwzb09Zemht?=
 =?utf-8?B?RGY4enJFRUhHM1VKVkRUS1FGV05nSnpNY0JObGVDSnBXZlh6cVJXUFNoQUd2?=
 =?utf-8?B?MncvMS8wR2NXWmNoYWVaOFJjLzlsUHJGMXlxejZSN1BmR2U2UjBoZmw1Wm9J?=
 =?utf-8?B?QWdpVEZDQ3llM3dsb1dtYVlubEcrY21yNHdiYy81NitrVDRYTFJhVCtjUTNk?=
 =?utf-8?B?c2EzamkrbXRRR2JYT2ZaZU9FS0pnbDNIYzE2R3d0L09WQVMzZmFveEowQU80?=
 =?utf-8?B?Z0pGVW9pQ3MwYVZpUjRhSnlIVk5zRXZmYTVsbGpZTG1WSWl3RE8zUmdYOVJT?=
 =?utf-8?B?OHZ0REZpZGY2NjBqNkE3WjljUDgwclo5MDlOZmpZY0xOR0lWblpOMU9WeG1t?=
 =?utf-8?B?TC94SFplUE1KWkM1bVVMSnIxRWhiL3ZTNC9KaWNWbDJQTG55VmZ3SStyeTVP?=
 =?utf-8?B?TVF3N1p4bWVmaEE3NllpbVpyckFmTlJDUnh3SmJwTk01RVFOSTZHNWg1eTAy?=
 =?utf-8?B?TmxuZnhqbWwzT0l0M1VubkxDeHZtWTJRZkpNVDMvV2VFdkJ5Z3FrbWJ5K2V2?=
 =?utf-8?B?UGRtM3B0OTB2dzZUWTk4RG45b29CUS95dVpxZFFjTkpTeDU4OXRMc0w0bVVV?=
 =?utf-8?B?V2l0Y0JsSHdqclhHeGxVQ001T0IxWXUrWC9jVFUvbzBkeU9obU5ZMkVaM0dk?=
 =?utf-8?B?eXFXRGJJMWJ0dkoraE9CajlFZ0hFYmZHT2tLWmp5NGRHUkJ1bHBJNU9iRGVk?=
 =?utf-8?B?Z0dtTElnRG9Bby9uemtVbG43MDN1d2N3UjJsSlFucGYyOTdyT0FmN0pzVDdU?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bb281c-1fa0-4518-1e10-08daf3293246
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:39:09.1354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPZa1eDED792Dw5GKd6eopagCFGycnWvj5kmQNqcCAkAUPuIDf9dd9KOq6Xh1IUGAkrlsL3a4dezT5q1oMQT1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6695
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Jan 2023 16:39:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10337

On 10.01.23 13:00, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows the user to generate multiple overlays in a given
> location.
> 
> The configuration used the following variables:
>  - INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL: Label of the partition to store the overlays
>  - INITRAMFS_OVERLAY_PATHS: space-separated list of overlay directories (lower overlay directories)
>  - INITRAMFS_OVERLAY_STORAGE_PATH: path on the storage partition where the upper directory is stored
> 
> e.g.:
> ```
> INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL ??= "var"
> INITRAMFS_OVERLAY_PATHS ??= "etc"
> INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
> ```
> This will create an overlay for `/etc` and store it in `/var/local/etc`.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Changes v2:
>  - INITRAMFS_OVERLAY_STORAGE_PATH contains the full path
>  - updated copyright
>  - formatting
>  - fix typos in commit message

Could you also explain why my other suggestions are not feasible or
reasonable? I would still prefer 2 over 3 variables, if possible.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


