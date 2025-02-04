Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121EFC02194
	for <webhook@archiver.kernel.org>; Tue,  4 Feb 2025 13:42:28 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.44])
 by mx.groups.io with SMTP id smtpd.web11.116062.1738676538347568499
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Feb 2025 05:42:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uCuizb/+;
 spf=pass (domain: siemens.com, ip: 52.101.66.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XncbBqRbHHhXX/q0S7ooQVoAQJ5O92MdZ5d8TkJ2AXoZtVNUEUcyX8lRAdlycSh4zRgas+lJz5AHyIPnrb+4aH8HbdfjThi6TwrJ1pWBXj0mgBqBJgOwUu3rG1cagysBaHJKVVdan44+Adw1NLXwGA+LuMQ4a6/wCulV7+DeccGVIn86uJGdfFr4SwClBtsHxS0UoDMRWDkGFPYTgP8i+XVKu608+mHJh2iczI8GMAtc0FG9+mTXvou4eJ/+fo8TWRgBRoxmfK3eWMHs1dIaIR/VM6G6UDfVa2ac6+HJipD8i/BacRBq9jZ0OZUrwZVAu5e3E+L8e0YM4dqBc92VVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEh3zRFUuNI+rFxuGD0WNYI3PVxH1rbInMYUtt4Go5s=;
 b=rjJoxDIBgRlHpUUf7aYMV6Ljw+nkdiGVPCSZpfo+aLYGQ3VD1LdNi0YbGtn+ldMpmV6be2Qaz6ELRb6wRw7IV0pkQRxu5NYsa7V5wyvrhjAK1+wwQym6/GpVJftRa0t16xFj4C2KmLKPx4/0kOfud6G8Ith9VGUokrunYM6U2z/fADlOuBh5q2HYUgYM1eos0xMpJ/AYg9rtYsyV0HWvqo7yYyodN0E/WRdGknK8FBxLd8Yg53Eiq5OMnF7uGIfk/1c01MOo7ifhH2k3Hm4jlyt48dAtOzm3bg0PtYVvL3rAUC850li7H3EYcmv8kcg4iML2M4K9LVxqP0pofIW7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEh3zRFUuNI+rFxuGD0WNYI3PVxH1rbInMYUtt4Go5s=;
 b=uCuizb/+eqU215XgZmMahXwJPk6LSQrFi/E2sb/YXFHQ7jLBo+cUpLMeOVNJOdE8AUXpOuBzvHoX2fZTFYJ4+MsczlARb+2EV1JXCyhO4sRTS7/acw7hN+bdYVsibGdlvSkqHqNhLEW/F23NJ5oEMXGmdgDH7GSY1HoqDxXVxT2gzVHQLkfVmAjBiDndHBM3L3PVoAgTBIwf9kVUAqd39TT5RVZHRIwGKy/DjdAYFCbC/NDldZE0xSDd3W1cCP2bzDhtQ/SDQ8GBRlALHISQOL8e2Pt9uVWNrggfqLtx9fLvY0LHnQkt6NxXMIJ4aXT9rOh9gyUql6f1mTzaeKXPkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7284.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Tue, 4 Feb
 2025 13:42:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.009; Tue, 4 Feb 2025
 13:42:13 +0000
Message-ID: <d80d4b9b-9142-4d9a-b022-b9a1f8fde0a9@siemens.com>
Date: Tue, 4 Feb 2025 14:42:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] initramfs-crypt-hook: Optimize disk
 encryption in combination with expansion of last partition
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20250122142811.106525-1-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250122142811.106525-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 5afdf502-c34b-4dd1-17f3-08dd4521bb52
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bCswU0k1Q1ZjdEtQeWpyaDZKa0xLMnUzOVVzT2FJVGN4eGZ6enJNVnRxQnZy?=
 =?utf-8?B?OWQwaFE4MUV4dmNzc0JRQmZmT1ZDZEE3bk9Cekt4REhlMVpDeG5lVVFqME5J?=
 =?utf-8?B?dzN6dklIMUtpdmdVSjVvUU5FeGJVcEgxR1FhazZldHZtNEVad0UxYXZLYWJ3?=
 =?utf-8?B?bXlXcDlpc3RxODhwckxZRyt0WW9BNHlzdW9qOEN2VUhUbmdSM2xqUXlyVXIw?=
 =?utf-8?B?akpCWng4cm9LWlRWNmhCVmFyOHFCOTJHenp3TXBPQ2cxWXJ6djhYSFhiRUNw?=
 =?utf-8?B?WmIvN2pIM0h6UE5GVGJKa0F1WmNiZUI0eE5XMyt2TGFvOC9NdElCVlYzaFI2?=
 =?utf-8?B?QW16VFFERkNabXlHcTVwR2xHaUo0cytWZ3BHR3dXWGVpdlFZV1R6bVQ3clJx?=
 =?utf-8?B?OGFnL1l1bjhxYjlxNmxJOHpQaTk0WWtCU2RqSEhPeWtWVTdKSnZSUEFCQ1kz?=
 =?utf-8?B?VkUrdTdmSUFLS3lJZ29SOXpRcnVpa2QvcDFaUjhnd0JTbCtyTVFBSXJNRlR5?=
 =?utf-8?B?RnBtdDJvc2ducWhIUlp2eHlHd0pEb2FWUnVvelptcUYxaThEazVmWDFHaU05?=
 =?utf-8?B?WnNVL3pWV2l3V3ZqVW53RHVuQ1VJLytUY29ybUh1M2JHQk5GZklHMW9kYXN5?=
 =?utf-8?B?cEUxSE1MMGhqNk9IRGJkU0p0aHQ4WXhIOTIwd2VucVdXM25QcWFUL1c4WDc4?=
 =?utf-8?B?RlpDTncxSEpGS2pWU1o2KzcrMTZvR0MvWmZoN0dOS0FoYTFKOUNlRlN6WXdY?=
 =?utf-8?B?T0ZUdExUVERQUEZGZmlSam43RDNmOHV4VW5LRTN2VUZaZVNTRHI4WSsxVU9G?=
 =?utf-8?B?MFlhM2JNLzJBeEhwT0d6anpVb0xXUk9aWGxGV3lZbTI5bnNibzM1TVNtTnZo?=
 =?utf-8?B?TEpianY1T01wQktGZTEzODNoR2U2eDFBYjJzWndBaEZEZEhuSFpMMkVZclY5?=
 =?utf-8?B?NmJRT1VweS9LV2ttRlZpWGZyZTU5NVFsY2lzTUxqMityT3dEMjhSaHFMVytD?=
 =?utf-8?B?RHFEakl1dGx5ajBuZHhwc0pYV2plTnhNcUxNcERoYkw5di9oMjcvV1lZTit3?=
 =?utf-8?B?djdBYnJnSnBPMGdDNUVNWGFZNkNWQWFDYVY0Q2NpVCs3TERwYjN3cmZRQlRu?=
 =?utf-8?B?amJCc0lGOE5ncE9nbGluKytOYkEwYXFHUzlDNEVXMkRzdGVWelA5K3VMT05x?=
 =?utf-8?B?NGFiUVZ2US9Ia0lmY05rYXMrM1B3NVV5UmhHSFNKNGJpTXhYTDVwVnY4TklW?=
 =?utf-8?B?S0ZOMWVWOStuUjM0SjRWSkpHVmphRkt0UTM1UElxT3F4Z0dKUTF3cEtOUW1i?=
 =?utf-8?B?aVVYRndTa0Y1Tk5FeklhaHlqQVlUL2x1RnBncXVtaGRESHE3R0QyVSt2NzNa?=
 =?utf-8?B?Q3dDWnRGeGdiOXc3Y2hEWSt0aExsVUphWFpIN1oyd3FwWXY4WFZrbTF3SUpH?=
 =?utf-8?B?azNWaXpFQ09tNjN6Uk9pb0tVZkc5Z1EzNnA4dzBRTjRzK0NxVmU2U1hHbklI?=
 =?utf-8?B?UXhaeWt4QXJQdWdIbDEzV1dFanpuTlZrb0Fnd1R2TDFWbWZ3dklJMm9US0dG?=
 =?utf-8?B?andlLytvWEU4MVgzcjU1aERiU2FQVTRSdy9kRXU2dlRrdVJRQk8yK3FKQW03?=
 =?utf-8?B?aVpJTXY1czZ6OGhTODlLSVM4NDdvaGhWSGxqQnFkTGcyaVdjMDk3OE83cTd6?=
 =?utf-8?B?LzgzZFc1VFFSZDZWNWJ3RjVmbUUvT0Zody9Yb1FzSnJIaGkrUjZXZzNneGJj?=
 =?utf-8?B?SVBhcVNocEtzOEkvV3I2LzNUc3BLT0piVlM4NzdLSVJJU05ZRmFSV2Y0Rndw?=
 =?utf-8?B?dmhJY2taa2E1UGxFdlVIaFpGSEdrd0F0YVBGdVVoQW9ETEhCa2VPUUlEZ1gr?=
 =?utf-8?Q?0iTdM3b7J/43h?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?REFlN0ZxeUxmQUV5MndvOTE0cUMvOVhGSWdZTVUraEdZUW9uL050WVdBb3c2?=
 =?utf-8?B?aURqWDYvTkR0S0dibHNaZjVrTVZRcTdXZTJmTXpwa2JYeEsyUFpQQmowdllE?=
 =?utf-8?B?NTJQaXJjeGRIamJZZEhtMnlTUk5BQnNzK255TE5ybTJMOGlYN3ZlQ2krTU8r?=
 =?utf-8?B?T0J0c3ZQVkdJaHZBZks2KzBET2l0czFSdUEzWG1nd1BycU1BaUdQempDM0ox?=
 =?utf-8?B?cm1HT0dqWTlKRHFDWFJWTXQ0ekZDZmszMFNGcno5ME5yclhLdDBvODljd1BZ?=
 =?utf-8?B?WW9BdW1Zc3VOK2NNTUk4bTVhMFVTZEs3SDVkbWdQQzlvc09qcENHQmorUTU0?=
 =?utf-8?B?WDFudXRhTlBpQTNkTjNkM0dWWTQzNU5VYUFzSmtkTEVFVWJPa3ZKOGJIbE9U?=
 =?utf-8?B?M2Y5dGYvcmhrNVNsTWF2L2IvZTQwYiswS1ArL3NTRkFoUVh5ZnZ3SE5QeWN6?=
 =?utf-8?B?b3E4K2FjZ3ovYklYL2Nvb1loUFlyejI2QTBSUVJIaktnWFpDSlFHL0JxSysz?=
 =?utf-8?B?L2hFMENBN2lPemhBbHFSVlFyMzlleW1EYm9PZ2dwOUJhTDYxV01HQkhNN24y?=
 =?utf-8?B?dzBkL1lEV2JJWXB3NjZWd2RzQVRFdGh6YmMyVDNTQ3hDVlFoQXB1SUJoWDV5?=
 =?utf-8?B?em9EOGZUTmhaL0xqNnJMQ2QwdHE0NnpqUXpONXpQaGI5WGlySHludC9samcy?=
 =?utf-8?B?dHZVQllSd3c5KzhBWmo2OU5iWU5ZMzI2cVd1NVg3TForanpaTS9penBTNzUv?=
 =?utf-8?B?cnVjUVZ5eVU0ZjNGUVJ5ZWJvYVBkQlVZaFc5Z0Q3UUlUdTFXNytVNzNZNk9h?=
 =?utf-8?B?NmVIRHE3eUhTRlFST05pZm9ZT0R0RGdxK3RxSUIzVjdsakQ0UlcySVNyOHJR?=
 =?utf-8?B?NW4xR3lHVk8yRjY0V2dJZUQ3amczdTlXb0NTQUNlcUJiVVFnZ0x2MXcwMWFD?=
 =?utf-8?B?d243L3RueFNLbVlqWUV0R3paUGNGVU14TzFIaVBIRWxYM2hCWkJCNm9iS3ha?=
 =?utf-8?B?cld0ajBqNEd5Y1pYNm5kVXcwRVNIcmE2ckFERXBQbk5SSlhSZ3NIWHpIV3Ar?=
 =?utf-8?B?VGcvWEtvU1R0aVlkcE5ibHZOY2RVZlc4eGpUU0lUUHorelpvdnE3L2RIRnNV?=
 =?utf-8?B?Y1VXd1R1TmdSUEtrUWgwcFhNeEREanNWWUhwOGpYbGN3WFZvcE9WclFuNlJo?=
 =?utf-8?B?dU90Q1FVNzNBbTUyN1F0bUsxTng0TTVPMithaUJLVTZZOU5jOUl0eVRHRFlr?=
 =?utf-8?B?clZhYnVoWnRIc1pjcmV3VW80M05lQXBMMkhEV2JGK2tCQkNqQ1hrRm94QVhj?=
 =?utf-8?B?OG9xQzBCT080cVJkcFl6ZUQyR2JHcEJWd1VFWEVsa2JIazlwNWxnbGdpRnVk?=
 =?utf-8?B?dHlyTllWZDNhT2JRV2h3WWdmWitCMkYvdm9HWGVyUlRVYXoyM0o3NGJ6TVRK?=
 =?utf-8?B?ZUpPbWlpVVBVVTMrZGFJN1MzUjdVTkRaT1dBeVgxUDRhd3dVUTV2UEVZN215?=
 =?utf-8?B?MkZISXVMN3FuQTdiZGovMUJ5aUVvdXhKbHdVUTJBUGVub1U1SnNZTmc1ZDhr?=
 =?utf-8?B?YnFVYjBDdFFQUVpjMEhKRG5qc2hjbG9LUWhCYi80L1JBaldBY0E4ZHdyM2RU?=
 =?utf-8?B?WXBDL2YvNEhSTUM2SzQvejVpdXNFd2p0eFU4alloUWlxWTNkWTRwZjR1d0dB?=
 =?utf-8?B?TFVQcmRJWEc0MGlVUlBLSGs5cFFjdDNLU05TbHArdU5VQ0VrWWtpS2k0bFk2?=
 =?utf-8?B?aHM2K2ErRTFJUkxXM2pFT3BlU1NGZi9RYWdMYzBNTDAvcW1iMXBCVGV1UmRR?=
 =?utf-8?B?VmFDT2N1cTR1YUk0SWdjVEdLZ01ob2Nja0dMV29tZzdUVFBJSzNsZ000UkVt?=
 =?utf-8?B?R1NmMWVnQTdHYUxmUGFOcTROMmhCMWVaVi9xT0laUy9pcFl0MnZuL3JEM0tQ?=
 =?utf-8?B?SGF6aVFiWW9KOWFQS0pERXRNaHJQc21Hd3Q4VGFSTmlGaTUzYnJxTU1DbkZ1?=
 =?utf-8?B?b3d3aDBIc3pjUzNtUHRQTjhzSGsrYkNIWXVuaUEvY2RVL01ucHdJQ05hTSsv?=
 =?utf-8?B?bm02ZTBqMlNubFFMUWhqWFI1YkF6UXJtRVQzUXdwSjlqdUV2dDhDS0hNRkZw?=
 =?utf-8?B?cmZJby9SYU9sRmxaSDlwYW9RZDdoWHlmVTJhcVVPN0kvY2pldStTbkQzMk90?=
 =?utf-8?B?enY1ajNUd09vVGlzaDMxdTAyWHAza1RUUXcwTW9rS29yN0tGQ3JsenU0SG5j?=
 =?utf-8?B?ZHEyOEl2MU5KL0Z3dml6akdJK1ZBPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afdf502-c34b-4dd1-17f3-08dd4521bb52
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:42:13.7129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQrcUswSNCnpIqYsJIQCelJJBA7qAES+0p3RtEi3iEDvx8POZB2TYLppl6L+G4zAvIczle4DSMhkIlyYN1G2XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7284
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Feb 2025 13:42:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17750

On 22.01.25 15:28, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> In the current implementation (since: 284175c3) disk expansion logic
> is done before the actual disk encryption.
> 
> This results in reencrypting the full expanded size of the disk, instead
> of only reencrypting the sections containing the actual data. This results
> in a drastic increase of time (approx 20x on our systems ) needed for reencryption!
> 
> Since relevant disk contents are only available in the sections of the disk
> available before the expansion, it is sufficient to reencrypt them only.
> 
> This patch changes order of encryption and disk expansion resulting in
> faster encryption (since only the necessary parts are encrypted).
> The resize operation does not reencrypt the added disk parts but just
> extends the LUKS container (cryptsetup resize) to reflect the maximum
> available disk space.
> 
> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
> ---
> 
> Changes v2:
> - Reuse get_fstype from mkinitramfs scripts/functions. 
>   Therefore, we could also get rid of mounting the partition
> - Dropped support for btrfs (compared to v1) since crypt hook
>   does not support btrfs anyways
> 
>  .../files/local-top-complete                  | 28 ++++++++++++++++---
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 8adc4e5..0146f58 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -153,6 +153,26 @@ expand_partition() {
>  	# Inform the kernel about the partitioning change
>  	partx -u "${last_part}"
>  
> +	last_part_device_name=${last_part#\/dev/}
> +
> +	mapping_name=$(cat /sys/class/block/"$last_part_device_name"/holders/*/dm/name)
> +	cryptsetup resize "$mapping_name"
> +	last_part_mapped=/dev/mapper/"$mapping_name"
> +	fs_type=$(get_fstype ${last_part_mapped})
> +
> +	case ${fs_type} in
> +	ext*)
> +
> +		# Do not fail resize2fs if no mtab entry is found, e.g.,
> +		# when using systemd mount units.
> +		export EXT2FS_NO_MTAB_OK=1

Why do we need this here but not during shrinking in
reencrypt_existing_partition?

> +		resize2fs "${last_part_mapped}"
> +		;;
> +	*)
> +		log_warning_msg "Unrecognized filesystem type ${fs_type} - no resize performed"

By now, we need support for btrfs here as well.

> +		;;
> +	esac
> +
>  	log_end_msg
>  }
>  
> @@ -215,10 +235,6 @@ for partition_set in $partition_sets; do
>  		echo "ROOT=$decrypted_part" >/conf/param.conf
>  	fi
>  
> -	if [ "$partition_expand" = "expand" ]; then
> -		expand_partition $part_device
> -	fi
> -
>  	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
>  			| grep -q "luks2"; then
>  		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
> @@ -259,6 +275,10 @@ for partition_set in $partition_sets; do
>  	esac
>  
>  	finalize_tpm2_encryption "$part_device"
> +
> +	if [ "$partition_expand" = "expand" ]; then
> +		expand_partition $part_device
> +	fi
>  done
>  
>  if [ -n "$watchdog_pid" ]; then

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

