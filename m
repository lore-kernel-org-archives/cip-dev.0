Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2DCC25B79
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 10:58:30 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.83])
 by mx.groups.io with SMTP id smtpd.web11.13195.1716548305346715081
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 May 2024 03:58:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JC3EEwOt;
 spf=pass (domain: siemens.com, ip: 40.107.15.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/ajFTTyww7ec2IHaLEuEkRja1mA/eaC+sK10lBwJpugTx9LAVrToy1AIhe/OBdTsKHrn8BhJ1+UZxF/bTVNTEVvd4msipSrsddDUAF/umN5zqaNv4DeY1tteBfLP4r/HmWdIJlTEDzKwDMC45V7sxTQvRSELxoH0lYzqYOOEEdt1gNFyje6H+sHsIlw7nvSfylcFynVdb3pIMzEY7rOnSFD4JAgUxynLwvCKl3p2QLhapDbdxgdF6w7LSzvHTk2nZyMFuSOjgDfeh/9YhV84EA3ezTgeky9Xp+StVe/MYCpdTtSnMlqpTgwomaGN7UjbYUSYle6M/B6acakQb6uBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gl37ChFGr6VHcU+S+zwyZOY0zg7nZ7sP5iljUAwVggA=;
 b=OJLmvuwyynwZUBtv3jWK6HmvsLWiyJm80iLWHNv/i9dimgdof5wAtF/Xl2klHP/xacvlQvZMpuR8M7w1itUjcXvPHYeS01OGLow6m92WEHQAb48x+XFhRuD8QgdkZc0EeGIGa2cRu6xHatA/GkdMAMLn+7IuV9jG58jeFAaPwe7Q5HQiVr6BFbU3H24A+zQNgggES8QwHZo+elaH7EAMDfFv8J6sDEp2JRMioqo0NCcGY7iISixgrsdeg4AkaIIdBCZP86pShoKyuw6iO3DjJOLYarkgREEAu5d6IL6//P7zA7cykfdzss6/8Pd7azJNgSwXn2ltE4rFeqAogDo7Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gl37ChFGr6VHcU+S+zwyZOY0zg7nZ7sP5iljUAwVggA=;
 b=JC3EEwOttxQHSHH6smtS3A1bmU80k+bpBmZy1k+0cWBIn5gmBP2xL2xEDU6OhCbNeQdfnZboPsnE47SwIwzVQ1QhMfxQl68+unTEy1aw9oRBOV6ZJoy9a2GixTgmEQmb9ASKznThKMewP3eTXaVKhkCHmQ0iMVUjJy3bFe2um6+g3Hk+6h8SdFNzHkDq2EnAVpCNGSsZuYGhAvGPJY8qQvqYKuSIj/nxG/uxnz8QZiV+qWoQvnLIRIGyoOqLR2AxJYbdFTcIPqKNIXnOh1cSvKBzBaSdapp8quPeCn9HECq5+yiqITDJNPUcUtwXvR2/E4qhXFFgmRTzg3kE/LsPaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8536.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 10:58:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 10:58:22 +0000
Message-ID: <929eccd1-fdb6-47ac-9b48-87eba36a203c@siemens.com>
Date: Fri, 24 May 2024 12:58:18 +0200
User-Agent: Mozilla Thunderbird
Subject: [isar-cip-core][PATCH v2 2/2] Generalize SIMATIC IPC227E
 configuration to a common x86 UEFI target
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <be7c406d-ee6c-4270-b9d7-52b6f24078c2@siemens.com>
 <ecae148c-1e87-4ba4-9e36-fbcd2d9e9ee8@siemens.com>
Content-Language: en-US
In-Reply-To: <ecae148c-1e87-4ba4-9e36-fbcd2d9e9ee8@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0422.namprd03.prod.outlook.com
 (2603:10b6:610:10e::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e0e9f1-9bad-498f-cee3-08dc7be06db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T25DWW1PTU9SU0Ywcml0M3hZKzBYY1JqSmZ6MnNjUkNUeUNFaHNYQzNnWlp4?=
 =?utf-8?B?Uks2MDRHdjB1SGdEWWdpOE54WnRndWloQnhHckZ5QXplUVA3aDZlNjZ1alZi?=
 =?utf-8?B?ZThVYVVOQkFaVFBrc1JPRkJiN0J3R3NOUVJhNk9URjM4c1o5eWRCVEUzZ081?=
 =?utf-8?B?d0lXMi9uZEVBWmFVaEF5ZG1JZkVlTWJqbHVkWXA2bDIxaWozVG9iU1dRbFVQ?=
 =?utf-8?B?UXJXVFk2eFc4Z0ZBYVN3cXp0MkE3WWNWYXBFRW04YithQTQxM1Z6V3RENS9x?=
 =?utf-8?B?NndqSmZMSnU0dU8xaWswU1RPMm8vcEJ3c0paZnNvU3E1eXErenp6SXdKTnk1?=
 =?utf-8?B?R05PbXRyczdzV0dRZSsyN3BsMFJGOUZ2aU1pOGRzbGNzM1NzRCtZeERkU3F3?=
 =?utf-8?B?SmFXSmhPTk5WRmZHUXdLeGRzTXgrbGdsblB1RkZ2Wks4ZmI5bEphZzUyQktu?=
 =?utf-8?B?K2ExWkQ0cyt1VjV3c3BZRGVqbFhuUXVaM3JEWFVVVCs2cjEzYkR4VlZDMkQz?=
 =?utf-8?B?SW1sZ1IzMEZsa2VVZzlrRUprOTh5K2x5N0gybVhERnVCcEhVbDFDcmVBR3NP?=
 =?utf-8?B?RXNveDgwS2d6WHplUGVQYThTMGpMclNSYzluSE5ZUnNYQVpBWndIak0zUnBT?=
 =?utf-8?B?T1hsRHk0WXEyOVB2b25GYTk4YXpGazRtY25ZV09wc0Jxck56WjVIMkJRTU1L?=
 =?utf-8?B?SXllbm1weFg2amM2U2RRQ3F1UUNMVVR4R3JQYURzSTdJQTlIU290SThIZHZC?=
 =?utf-8?B?NGFRdTl0dS9hVElpZzhwemlNZmdOSHFIU1JEWnVSdmo4bXRlQldvWjhqbTFa?=
 =?utf-8?B?VGhXZUpIQS9wUWtQK2VBWHlIVWdiallRU2FBN2VHaHJEUWJrZXZwOTBucnFJ?=
 =?utf-8?B?eFg2SkdsVk1NSDRhcVRpZXNDUVlxUlFyYmRIaE5PbGI5RXlGakJEZXlLUGRJ?=
 =?utf-8?B?VVAxWUFpZDE2bTdRdDhNc1ROM09ic2pHTWEySmdlUkN3WWg1QXhNd2hRTTRW?=
 =?utf-8?B?MzltL092ZDFINmpPbGg5UkIybUcyWWhzTGVqODZlNzVrbU51YzlnV05Sc1RH?=
 =?utf-8?B?TEQ0WjZZdVE3d1BpbnFzNmJJM1hvdSt0aWpKQkFSeHVOTXEraFlEWmhqNXd3?=
 =?utf-8?B?SHphZmQyZ01sWFBOMTlRL1BDSlhKNnpGaVpHWUZiaDJ4VHhkczh1UHNXS1Nv?=
 =?utf-8?B?Q2FaVDNyY0pMNENkMEN1VjZ1dGdncWxKYSs0bkRzSDdKTW9Bd3M1Y2VRelVO?=
 =?utf-8?B?QlVHTUU3YkVvQ1BYazliU1VqbnBTbSs5ai8yYXNOSm1VZ1hWazZYdXVRRjNz?=
 =?utf-8?B?ODZCSUVqbWV3MVZET3lGWmVTTU5SRmMvZXVFdjFjUTNNNTFoUGc4RWkvSk51?=
 =?utf-8?B?TkFZQUhHNnVUSDk0Zll4SER6aFFmdWdYY2k3eEhPMWtWaWloRVQvemp1N2xC?=
 =?utf-8?B?Rzl5ZTFGZXZyR2M5RGVFYTlJQnFMQ21kNDlwMlRpWjdnVXlTYVhNbmZDSnR1?=
 =?utf-8?B?b05hR1VBdkpPTm1XbitnSDAzbDFUeUJuUVh1U2M5by8zdGdGUzNCZjd3TEEz?=
 =?utf-8?B?N0JRbjJYcEJnSWRlc0Z4cGh2UGZuM0JKcHlzaXpyRFdwVkF2WjJqNy93Y1Ix?=
 =?utf-8?B?MHd4U2tjbGx2dWtRcE9ORjBWMC9FUWYwdmpBZzJrS0M3U3hZUGU0bmc3clhL?=
 =?utf-8?B?eUc3SEhzQXZxWjlOYXhVRnR6ZW1OUnhDak1nUWxUOUVaZjhFbjlkN0dnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YWphdVQrR3pnSEVsY0kwY2x6OG9MNDNsZCtaYzk1VEJvakh3TnVlQXNwZ2hQ?=
 =?utf-8?B?MDYxaDhzZml4UTYwbWJtbTRxS2RHaHRkUkh3ZEo2ZnBycThYRVgxV2N6MjFB?=
 =?utf-8?B?NDA1R09ZZ3I4NE9jY0FpRDhTcUk0S0VmaGMwb3pUSHVoT1Z0YVREUnN0MVpW?=
 =?utf-8?B?b2JDeUlFdUVYWHg5ZTNyK3kyTHRhUmdRRkE2RjA0Yk1aT25VQW1yQWpLRC84?=
 =?utf-8?B?dDFib2FjYStQY2tJZFBqMWlnaFFQVVNNbDcySjMwYlpZeUpsdjhrZmlabVVU?=
 =?utf-8?B?bWcxS3BHNjFTZFpHRUlTVUpuMnI2SFAyMzhxQ3FIRFBOcXo4NmpReVdiRWl1?=
 =?utf-8?B?YVlXTXljYjVOSS82OU9xMVlQT2IzVEN6Y2prRzJ1ak1oUzlCdmxGdmFlVmlJ?=
 =?utf-8?B?VEFvRmNxM1NOTDlQSWxpTU1sYTlCVEJmdzN4eERvVXJvb29JTWFTQzd6c0hi?=
 =?utf-8?B?aEVZaFY2VmF0VW11Q2JuSkJGNG12MVkrTUM5VEREdUFsYit0NDB5cDVzdmdu?=
 =?utf-8?B?K2FsdjRINW4yZXV0ektLWkptZ0c2ZmNNQUEwL0ozdlVNT2JRVlUrUlNuQldF?=
 =?utf-8?B?cmlTRGNEcm5KaWNLOWNPVmg3eVZsQnNxbHdLd3VtVTJSTGwvN0NRVnJTZno3?=
 =?utf-8?B?RW1QS014Q1VRWUlZUnB6bEg5RWVFeDdWbjVVcXZ3WkdxWjlrQmhINEVtSzh1?=
 =?utf-8?B?Q0hqdCtBN1RGSmw3MmFEemxNWXFNSlFabkNpL2NsdXRRSUNzZERrWXpVK0FT?=
 =?utf-8?B?VkpjQ29OUTFYUlhMMDQzcjVJQmRkblVoOVN2azBBdUVMMGRQTlR2OXpEWnlR?=
 =?utf-8?B?eU5HRzVVUnlpK2V6TEdibXdoK0N1Y3R0TEVwaWlCZjIrTlFzOE5lbEhVaWtk?=
 =?utf-8?B?SnQ4QVpncHNnYS9CYXV3VUxhYjZJN3hDTUpheC9PK29KRjNKSzN6T3R3RDdu?=
 =?utf-8?B?Q3lCTVdNT0ZGOEpVY25ZVncwUkM1NkI4dVRQNGZ3ZHlFdEJhOUtsVUtiK0tN?=
 =?utf-8?B?S3hIcThRbWU5MUpjaHNsUiswU0hBUnRoc3I5TUJuV0thd3gxMk95Zm1sdFJ3?=
 =?utf-8?B?S0ttYzJwTUtMYTVJbUkwVmNzR09BUFVzL045eHF4UHpTN2M5dDlmeEpGL3cw?=
 =?utf-8?B?MDZjczI0K05iSUhVNHlzWHdmZUtCQUN5VjZkOG54a2ovQUdST3hMY2swUHhI?=
 =?utf-8?B?b01Gb2dja0VqUkgzc0JwZ1ZMR05TNDQxNFo5Mld6WnkzUFhRRlpGclEzaFFD?=
 =?utf-8?B?SXU5aGZYSGY4cWE1aWlMdkxncnVrRzJhRkx4Q2xPcnQ2REhEbEFGb3hVV0J5?=
 =?utf-8?B?OEtONmR2REVxQ0gwQWNaUkRIdGdiR1hrYXNZNk5Jd1pUS1ZxKzdGUDIwY1dk?=
 =?utf-8?B?azVhMVh2d2hlUGNXUXQvR0Eva2lZWmhTN1RJTzZVKzZHc2NVcU4rVW1iTWdB?=
 =?utf-8?B?M2ozMWhlT1FXQ01FTjJiaGI0ZVFKMTVsN010cmhhWkc5SVNyUjMwcTRyVHZ1?=
 =?utf-8?B?eVhkYmJLOEx4anBGOWtLV1QwQVdJb2U1N29sQUVtSWZrSlY1U2hSQ2dMa3Jn?=
 =?utf-8?B?N2s5dnVsN0lYWkdkTkE4UTA2ckRrdDlUbHZMRHdmZ2dBUGVJQkptc0MzdCta?=
 =?utf-8?B?eENLc0g0bkgwMEN2dFBYbkdZK2lRc3V1ZU5FMnR2LzNZRlpMcnlNbkh3OUt3?=
 =?utf-8?B?cUlnNVhlTjVGZGxKMWpoTmNOZ3pQMGJxSDVpS2pCbEhLT3ZpVzJONGFIYmJR?=
 =?utf-8?B?dXVDVWtiU0Z5TmhUYjFEdmdyTUNGdG5GOWpIUGs4NURmVTZNMHZjNWFLWCt3?=
 =?utf-8?B?UWJtNlNUUEtZbHROQkQ0SEdSSS9QVWtOYm9UUXN1MFRzWmNSZ2haVjFKZmEv?=
 =?utf-8?B?TzhIMGREa0xpaWk1dGRBWVEzcWdtaTlkcXVVZFZZUXE1YUc4bmM5QUVOaVlH?=
 =?utf-8?B?dnNWOXVndUtYVW5MVEpHSTJCSzBOeGRFRTZ0STFvUXRPODd6RDZCZ2kxVlpD?=
 =?utf-8?B?NXJjMENteVBsbFJXWE8yclZzU3RwOTdBS1Mxc2VqNUx2TUZiUW52dm5HSGw2?=
 =?utf-8?B?NndEWEFFUGkxQm9Ed1FZeGV5Y1NiTU1TWGdEUUZnT1dyeWliY1M3aVBKUDZG?=
 =?utf-8?B?elF5ek05eFJKc2YzanY1MUdUSEZpaHZvRU1oV1RmcEJReWNBOXc4bGJLUHZz?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e0e9f1-9bad-498f-cee3-08dc7be06db0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 10:58:22.3980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSg5tA6UoX6WLOW276HMQdis238mgJENUsvmoyEm+SHmu52p+3m2sCZd+3w7IVzHhFrRC9Xk6jGtJ2ccMiWx5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8536
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 May 2024 10:58:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15944

From: Jan Kiszka <jan.kiszka@siemens.com>

Officially signals that this image is supposed to be usable on all our
physical x86 targets. QEMU remains special, even when using a UEFI disk
image as well, due to extra needs for the host.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Hmpf, too quick.

Changes in v2:
 - fix and cleanup efibootguard wic file reference

 .gitlab-ci.yml                                            | 8 ++++----
 Kconfig                                                   | 8 ++++----
 conf/machine/{simatic-ipc227e.conf => x86-uefi.conf}      | 0
 kas/board/{simatic-ipc227e.yml => x86-uefi.yml}           | 4 ++--
 wic/qemu-amd64-efibootguard.wks.in                        | 2 +-
 wic/simatic-ipc227e-efibootguard.wks.in                   | 1 -
 ...6-efibootguard.wks.in => x86-uefi-efibootguard.wks.in} | 0
 7 files changed, 11 insertions(+), 12 deletions(-)
 rename conf/machine/{simatic-ipc227e.conf => x86-uefi.conf} (100%)
 rename kas/board/{simatic-ipc227e.yml => x86-uefi.yml} (71%)
 delete mode 120000 wic/simatic-ipc227e-efibootguard.wks.in
 rename wic/{x86-efibootguard.wks.in => x86-uefi-efibootguard.wks.in} (100%)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4a397121..f3d05525 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -81,11 +81,11 @@ default:
     - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
 
 # base image
-build:simatic-ipc227e-base:
+build:x86-uefi-base:
   extends:
     - .build_base
   variables:
-    target: simatic-ipc227e
+    target: x86-uefi
 
 build:bbb-base:
   extends:
@@ -166,11 +166,11 @@ build:qemu-arm-base-kernelci:
     deploy_kernelci: enable
 
 # test
-build:simatic-ipc227e-test:
+build:x86-uefi-test:
   extends:
     - .build_base
   variables:
-    target: simatic-ipc227e
+    target: x86-uefi
     extension: test
 
 build:bbb-test:
diff --git a/Kconfig b/Kconfig
index 6e3ad3ea..334b5c66 100644
--- a/Kconfig
+++ b/Kconfig
@@ -39,8 +39,8 @@ config TARGET_QEMU_AMD64
 	bool "QEMU AMD64 (x86-64)"
 	select ARCH_AMD64
 
-config TARGET_SIMATIC_IPC227E
-	bool "Siemens SIMATIC IPC227E"
+config TARGET_X86_UEFI
+	bool "Generic x86 machine booting via UEFI"
 	select ARCH_AMD64
 
 config TARGET_QEMU_ARM64
@@ -72,7 +72,7 @@ endchoice
 config KAS_INCLUDE_BOARD
 	string
 	default "kas/board/qemu-amd64.yml" if TARGET_QEMU_AMD64
-	default "kas/board/simatic-ipc227e.yml" if TARGET_SIMATIC_IPC227E
+	default "kas/board/x86-uefi.yml" if TARGET_X86_UEFI
 	default "kas/board/qemu-arm64.yml" if TARGET_QEMU_ARM64
 	default "kas/board/hihope-rzg2m.yml" if TARGET_HIHOPE_RZG2M
 	default "kas/board/qemu-arm.yml" if TARGET_QEMU_ARM
@@ -173,7 +173,7 @@ if !KERNEL_4_4 && !KERNEL_4_19
 
 config IMAGE_SWUPDATE
 	bool "SWUpdate support for root partition"
-	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 && KERNEL_6_1 ) || TARGET_HIHOPE_RZG2M
+	depends on TARGET_QEMU_AMD64 || TARGET_X86_UEFI || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 && KERNEL_6_1 ) || TARGET_HIHOPE_RZG2M
 
 if IMAGE_SWUPDATE
 
diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/x86-uefi.conf
similarity index 100%
rename from conf/machine/simatic-ipc227e.conf
rename to conf/machine/x86-uefi.conf
diff --git a/kas/board/simatic-ipc227e.yml b/kas/board/x86-uefi.yml
similarity index 71%
rename from kas/board/simatic-ipc227e.yml
rename to kas/board/x86-uefi.yml
index cf27058f..056ca322 100644
--- a/kas/board/simatic-ipc227e.yml
+++ b/kas/board/x86-uefi.yml
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,4 +12,4 @@
 header:
   version: 14
 
-machine: simatic-ipc227e
+machine: x86-uefi
diff --git a/wic/qemu-amd64-efibootguard.wks.in b/wic/qemu-amd64-efibootguard.wks.in
index b3a73fa9..e93d7bf7 120000
--- a/wic/qemu-amd64-efibootguard.wks.in
+++ b/wic/qemu-amd64-efibootguard.wks.in
@@ -1 +1 @@
-x86-efibootguard.wks.in
\ No newline at end of file
+x86-uefi-efibootguard.wks.in
\ No newline at end of file
diff --git a/wic/simatic-ipc227e-efibootguard.wks.in b/wic/simatic-ipc227e-efibootguard.wks.in
deleted file mode 120000
index b3a73fa9..00000000
--- a/wic/simatic-ipc227e-efibootguard.wks.in
+++ /dev/null
@@ -1 +0,0 @@
-x86-efibootguard.wks.in
\ No newline at end of file
diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-uefi-efibootguard.wks.in
similarity index 100%
rename from wic/x86-efibootguard.wks.in
rename to wic/x86-uefi-efibootguard.wks.in
-- 
2.43.0


