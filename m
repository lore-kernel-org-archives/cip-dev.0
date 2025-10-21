Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB24CCD184
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 12:58:14 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.56])
 by mx.groups.io with SMTP id smtpd.web10.11052.1761051487701102627
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Oct 2025 05:58:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=b/XYvGjl;
 spf=pass (domain: siemens.com, ip: 52.101.84.56, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1UyMb9KIFPG1DFBEK6wuxdd2I60y2ft4+UOAzWWF+JiTIJ7ppw/eZt4MblQhsKqBRW64fRdpWCKwkrfW1vnER1IQQIWDW/NUTL3cm9M8bdGd/cedAIGoBFv5HIgUr+ddKZrnaqN4NWbyXynzoFQSQCCWzzR4tuPO3aLI+xo3YKsZUz6FfznIAP3pVkWWMUWr6zUyFA9k4tIBeKEGEcXv9fisk/otdp68sHJxkYdu3p8794lfK8gaELF5zp8sth+yh7aB406MsEdwXTR1u61JjmRmo1BWLcqz25bQdigzpAmUF7nSpthBg/Ox43mKGhwhTna9+ZmnWjeTdkw62EgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZTQCC5eA+s5u9uPUistML8jf8ce2kcisScQyhR262E=;
 b=uqtrItEdZ69JdQJum6QpgBeGv/+X6CoTcEwlEh5BPEVuX9pfV5rot5GB5eGpfU0ozk/q4lDO4fzaG5IWb03DtQWpvEvQPRjGhCUrwLY+wtruo95LGeBEQsceOg17GFfbhTcCau8Q7UnCv3Dx1p39Eww0D7xTAiTLDKmIYwAwwoxfxG9kALrITP2uD46PEl9/4MTzsTTDgipp6nnZgBu4+TRx4dOSjn97ptQ81IEO8w6bf6GgeUCYT8/cCVkLwPiWbBGwe+K0RyMw8+V82+JXCoT9DQxo5JPcleXdJMXh44B4VfTe0eNR5yW3wxAut6+E0MEUSduI96ykeyM3tI546g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZTQCC5eA+s5u9uPUistML8jf8ce2kcisScQyhR262E=;
 b=b/XYvGjlzu45S4nRCO8nQ6lI5gNKBmJV8jbohl/IxwYosxlfVBGOgENFRnqSNTeWfyCTplJah5nLDDpanP/jrm+8hrxtS6sidPPKwYr7Fjts8zWmKzu/5LK+My+4st9ShWRCEf/4w4GsUo8+PxefqkKco0V8x1zlM+O42jKhvE+nQLPbz42/zxvAEZIpj3tBHI5SiveSgJBY5faKJbjBw0Ua67SY5bLfmejcWtk2HztGrmmwajxT9C9nUdujq+tXq6+g8KHWx9Ucd8JM1dl/ZyawMiupVNcM4R7Y/7NIDrLi9vtITVwTe0f3mQzb6UBwd/5uniAUOFGasqO4gW6Y0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::16)
 by GVXPR10MB8897.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 12:56:20 +0000
Received: from GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8141:f914:455e:a790]) by GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8141:f914:455e:a790%3]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 12:56:20 +0000
Message-ID: <0f2a33fc-dcca-423e-a3f6-efc12a3a6d50@siemens.com>
Date: Tue, 21 Oct 2025 14:56:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v1 1/5] SWUpdate: Use self-built
 SWUpdate 2025.05 for trixie
To: cip-dev@lists.cip-project.org
References: <20251021125233.1528087-1-Adithya.Balakumar@toshiba-tsip.com>
 <20251021125233.1528087-2-Adithya.Balakumar@toshiba-tsip.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <20251021125233.1528087-2-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:610:b2::32) To GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR10MB6005:EE_|GVXPR10MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: 514a3a8c-150b-4bab-2d9e-08de10a13b6f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZVllYXczM2NQY0hmcXpCQUl2MlhnRlFLUCt3TnVCVlNVQkUxN1hHb0thSGY2?=
 =?utf-8?B?VDhFRnkwN3RjK1o2N3VJNi8vV1VjcHF4NDJpL0ZnOEFFVGhSWXpMeTRTbzh2?=
 =?utf-8?B?cWhQNVZKeE5zSkprdFFidTIwbGpWbXZGZ09ldFJTTnBiUmd6T3BDelA2UzFr?=
 =?utf-8?B?UUJTVmhZK0d6bEp5eUd5a29tRlBybXpKSmdUVWtmdU9iakdFNU1aaWM4TTY0?=
 =?utf-8?B?RHF4cGFNVEpJS2JZU2RZSnk2UEZINS9PbU1nUDU5RUNsUXZDdXpNSFlCV3ZV?=
 =?utf-8?B?WmJ0SzBxKys5Mm9ybVdlTlF2TWtLVmhDVnJFRHREbTlxbjJFZ0hodlRkVzB4?=
 =?utf-8?B?NmgwR1NhVlZlMkYza1AyMmhYZlhpRlNIamhFOUduSE82V0NwdkE1N0N3enhN?=
 =?utf-8?B?dDh3STd1dFlaSDk0VFJNVkxCb0ZEaDZTbGxON3FTSllhV0hxV3FYaitTbUVD?=
 =?utf-8?B?ejZQWFV3SExYTXdCTzd1cUt1QnpiNFZuT2pucUVOMmVLQ0lpV0YxbUNGZ05u?=
 =?utf-8?B?OUVCWjd0Q0Q0NmI4eEp0WHJoK2VWYkU4UlYzVGFKRVhOc3RzclYvNU9yeXlm?=
 =?utf-8?B?cThDdzFBQ2RRVWo5TUZuOExMRzgvSHNUVDVSanRmUjc5YmIrek5wZU1TUHF2?=
 =?utf-8?B?R1lnTGpPV0JldUpjaWl6RkNmaGlETmhJcG95RGoxU0lRWjh5WDcrQW8xTkYw?=
 =?utf-8?B?LzkyTmdBL01sMWxvM0RQYTkvVjhXWlR5TzhJemp2c0QyeThvbkpaY0x4M2F5?=
 =?utf-8?B?alVuS1NFaG0yODVCUkJZeE51UitUajFodFJVS0pNSkJFOHRCa2JBWjJDd0Ns?=
 =?utf-8?B?S1ZCUXdwZnJLcVV0RFpER3hRd3NEZ1JtdjVoM0RSSkNWN1RrTEE5YXdKSFNt?=
 =?utf-8?B?a3JyRVBUMXFsZDlWQUlCc1N3dUxtV1hqSDEvREM5UTZBUmJzT1hDTGYwZVBW?=
 =?utf-8?B?dnlOS3hTS2lab3F1cUh0RFdRRFdwYis1eEZPK1I4ZUtDUVBwQVhmL2FOMWlD?=
 =?utf-8?B?emxFc3RGYkRTR1ExaUdoa3BGWTY3VWdwbjhHZWJXL2g5RzEyOWVMSllhSGVi?=
 =?utf-8?B?VTY2MzZnZ29HWmxQN1lIRHg2MUp1QWdnZkczS3ZrdmpBSlRwcEo2UlRzUkwx?=
 =?utf-8?B?K0ZmcExUdXo0VWFya2FFRThjMXFBZ1FEMGU5UWI5T0Z6blRhbVVjeUNXaHVk?=
 =?utf-8?B?OVJ0YTlKL0tUWFU4SGQvUE1FdjBoZVJUWjVBdGQrQXhBejBIS1NtVEdTQnFS?=
 =?utf-8?B?VXp3R202cG9yZVBsd0ZBbHRPMVdwWWl4UHpBWnpya24zQUNVQ0E0RE93MXBE?=
 =?utf-8?B?cm5tUGRyL0pMbTJ5L2laUktXSkxqejhXcHhjK2lXV1JNd3AyeXNTWkswNjhu?=
 =?utf-8?B?N2VRRnNrMzNJbFByUTVzSHVyUTBQckVXNGs0RUFkSGNobDhRU2UwZjdyRDRH?=
 =?utf-8?B?cE52Sk1jaEFROTVwcGZNZkkzTlJjSlNWOUwwMHcySmpmaXd1RUJEWnowdENv?=
 =?utf-8?B?NUQxSXo2OUtXZDNkTDUzeWxkVmtrODBYejlZYVlLcCtTc0xnNUROeXphb0V4?=
 =?utf-8?B?MDNhclFFWUdiUEQ5MGQ4dFZ4dkMwRjM0RmYwaVZZaGhTZVZ1aDU0Mlh0Qkl4?=
 =?utf-8?B?WXBONUpkWVRTYnJKMW9BZTB6djV5bFVDSUxKQ0U2anZhQUNUZWROeUNBdnlM?=
 =?utf-8?B?djlEbmdlaVFlelFoNzZwZW9oc3Uva1VzMVhFallaejJHNXdMUGZIcmhmTUtX?=
 =?utf-8?B?WlRoS1dHYitJUzEyQS9KclBzNHV6clRJcUVvOU5Xd0gybWRDd3ZWTXNBaVdT?=
 =?utf-8?B?VWdFMCtMQVYySjY3d2lRbnd4RGJKQ0x1RnF1Z0M5eEtpU0VDV1dHQ21ZLzI0?=
 =?utf-8?B?TFdDZk5XdDdpQjN0SDZVa0h3Q3RHMDJWMTNuVThkZkpSMUE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MzdXRTNJejhucFdITFJ1YnJyWGFGRDJQcUxMcEhGd3VhV1RSSEZ5TE1GWnBJ?=
 =?utf-8?B?Z2NwVHFmU2lQekJSQXZSay8vajJoenNSYk83Ujk1SmVuZEZGdzdNQ3RvNElq?=
 =?utf-8?B?ME5GckdXVFRFR3h0dExCS25lSkN1cUtJVlI1NEM3UTNuZW1UYmdmUzJNYmhB?=
 =?utf-8?B?NTFpUzVnUHdPYmFiZ3JlSXB4cnRONkxUTlFNNnNXc0Z3M3JURXArVG53VkZL?=
 =?utf-8?B?V3VMNnYvQ3orQWk2MmhNcmlOUTkyYThnMzFNbVhQamN4ZjUwaUlsWEFmSVEz?=
 =?utf-8?B?c0wxaFprd0F5MFhYc3J6VXl3K1BoTk50WVNNVHdhSG50YS9tZXMxUVA1eHlE?=
 =?utf-8?B?Uy9CYW5aMzcxZG1tbXJUL1NXK25XSUNSdkM3aUVQM0RuRXdsaUUwSDk3TEpy?=
 =?utf-8?B?TnVBaGN1UjMwbWZVSHJJN3JneFF6Y2M2Z0xsV0RPMjNZYmpxdldCd0F0MTBX?=
 =?utf-8?B?MDRSUGs4STg5RXlyMVBLWm4yZHNObEM1VHVvMllITi92VnBJQzhoQXBlV3RG?=
 =?utf-8?B?Myt4TjNkWUJmV3I2cFl4QmZjdUV5Z1ZETjByNVZwT1NtQXhQeHlLV0xwRVg5?=
 =?utf-8?B?MFJSRzZHMWx6RDNRNElUbUVOSGpGUVN2Skx6TVdqeHJxVTZrM0t6NGZxNHdx?=
 =?utf-8?B?UnhhUi8vQ095SnhJRVpheUZ0MVNRNGpnc3FkREpadm5qTUdlc2lKQTYyWVJj?=
 =?utf-8?B?TGY4VzB3QldsU0dqa3dLeDVGa2xyTHNjRUpFcEpJTWFVRmJvSlRaa0xwbHcw?=
 =?utf-8?B?WkEzL3RVaG8xdzdYYldtMkFTdWtJVWtlSEhXOXRLNTErYjhKRWE1WU4zeVdB?=
 =?utf-8?B?aDltYUp6dzM2VVYrN09zWUV5VUlhNWg4UmJMa0RwZEp2dVcwN1pQeHgrTFgw?=
 =?utf-8?B?eGQxTCtqQk9GeHRKM3RTeW1sSVZSWVA4eERNdkF3cXRFVm5sZHVtV0hLVWdu?=
 =?utf-8?B?WHozd3g2VkNaVFhrY0VUOXpHRzg3WE5XUmZ3YlVzbEVsSy9aOCtIKytvSkNJ?=
 =?utf-8?B?dzJSVGdTd1pYRjE2ZG15T0VuUi9MWm5yV2tEM2NGNldHZVY1R2tmOTA3MFBp?=
 =?utf-8?B?V0hWNWhPdjZUSDYzbHpVOHZPOVJ4dWxnR2ZzbEoySnlpdmRqNXNQS09PRWhJ?=
 =?utf-8?B?Z1Nacmc2SERKSEhaQUFaMTlJSmJhSmEreU0rbjVPNndnVHRMcWVqcjVZNS9K?=
 =?utf-8?B?akdMN3AvV3VnT0JWR0RnS1J4V2xrWWNkVHJOR3hIZ2h3RjdMenFKWU1aZ1BD?=
 =?utf-8?B?TDJVMENTOUt2VG1tV2N6Tmhja0tyT0NmRG9LT1hLM2hFNVlDVjhKQ0hZc1dD?=
 =?utf-8?B?SWQ3MzdMaUYwY3NHSzlwZDRDZ0EyTEo2LzhtL1RORFNsU05rVDVNcitVWndW?=
 =?utf-8?B?bnZKSEJmdG1wZ3pUTjc5aTR3RzhwaHpGZ05qZnlYQ0tSZnE5REYzS2krK3cz?=
 =?utf-8?B?Smp1QjI1Skp4Yk9DRlBDT3NIY3BMZUhpVWErb1pIQndmaHZnQ0xPNFEzZE9C?=
 =?utf-8?B?bjhiOTgwbWs2MmNUVXhPZThqZm8vVTMzcFkzUEx0bE1zWGgwOWxxdVhkWXlN?=
 =?utf-8?B?eEhlUXJMalllbDBacW9IY1JEVTNLbzY5NmQwTEFIaENWSzdXWW9PN1IvZGNs?=
 =?utf-8?B?SUF3dmRQU0pQK2tzclBiSEZQamxlZEpXd1hkYU5NejM2alo2aEZXaGpKTzR1?=
 =?utf-8?B?cE1BNXBnTFFjNXBhQTVzWG9udEJ6cFJTUXpEb1g0cUNaOG1YUWliZmtuRTNt?=
 =?utf-8?B?RVY0Tmt5Slg1KzFNdGgvdmlQVGwva0k2RFBXMy9nK21tNnl1VE1WL2ZVaE0y?=
 =?utf-8?B?WG9mdDRpKzdmV3ErWHUzN21IejhJdTVMVExvSkpMWUJ3dVl5OGgxREwwNm1p?=
 =?utf-8?B?Z1N3ci9yNUU4bDlKQnlsdXpwNzFrNGtrZGoxUjB0ZE5ublQ5Wi93WEpjY1Nw?=
 =?utf-8?B?My9kVEFqZ2V5YTk1Mng2VytvYmxFbEFpSklBRmZTK2VvMFRuVnNJR09BZzRQ?=
 =?utf-8?B?TExFb2ZoYzVoVTdPQVRCWDlRMGVnc0RROXUyejY1TVJEZXAxVEJjc0dGU2sx?=
 =?utf-8?B?eTYrMnNxMVRrNlNlZUg5UFpNR3ZadFNZZGRrTzliSEhIU3dQRlE1RWl0alZL?=
 =?utf-8?B?NDZjZ0x2aFdqdkxkaTkxc3ZiUWg2Sjh0c29ubEs4bytOM3dqbCtKL21oQkJo?=
 =?utf-8?Q?qWQcKG4UCfO6IPC3ibFemZI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514a3a8c-150b-4bab-2d9e-08de10a13b6f
X-MS-Exchange-CrossTenant-AuthSource: GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 12:56:20.7550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GT6ozaZRRxnDrxiPK59e8Yx+5LQ5Fc7g1ceWoYK/WTOoWbxFgpRFoqpJkD9Dk1/0XzjXBZspQo5PY0/d9jiN0j6lNVhIoN23+csAzj3M9H0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8897
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Oct 2025 12:58:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20208

Hi,

On 10/21/25 14:40, Adithya Balakumar wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> SWUpdate debian package for trixie has an issue[1] when used with suricatta wfx.
> Although the issue is solved, but the fix isn't yet available in any debian
> version.
> 
> For now carry the upstream patch and build SWUpdate from source.
> 
> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1118485
I would discuss this fix with Debian upstream instead of fixing it in
CIP with a new SWUpdate version. As we need to maintain this version 
even after debian no longer supports it.

Best regards
Quirin>
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>   conf/distro/cip-core-trixie.conf              |   1 +
>   recipes-core/images/swupdate.inc              |   3 +-
>   ...x-rebooting-via-tools-swupdate-progr.patch | 129 ++++++++++++++++++
>   recipes-core/swupdate/swupdate_2025.05.bb     |  39 ++++++
>   4 files changed, 171 insertions(+), 1 deletion(-)
>   create mode 100644 recipes-core/swupdate/files/2025.05/0001-suricatta-wfx-Fix-rebooting-via-tools-swupdate-progr.patch
>   create mode 100644 recipes-core/swupdate/swupdate_2025.05.bb
> 
> diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trixie.conf
> index b133bbb..663f2b0 100644
> --- a/conf/distro/cip-core-trixie.conf
> +++ b/conf/distro/cip-core-trixie.conf
> @@ -12,5 +12,6 @@
>   require conf/distro/debian-trixie.conf
>   require cip-core-common.inc
>   
> +PREFERRED_VERSION_swupdate ?= "2025.05%"
>   PREFERRED_VERSION_linux-cip ?= "6.12.%"
>   PREFERRED_VERSION_linux-cip-rt ?= "6.12.%"
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 75be566..47f18c5 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -28,10 +28,11 @@ SWUPDATE_SELFBUILT ?= "0"
>   SWUPDATE_SELFBUILT:buster = "1"
>   SWUPDATE_SELFBUILT:bullseye = "1"
>   SWUPDATE_SELFBUILT:bookworm = "1"
> +SWUPDATE_SELFBUILT:trixie = "1"
>   
>   python() {
>       base_distro = d.getVar('BASE_DISTRO_CODENAME')
> -    if base_distro not in ['buster', 'bullseye', 'bookworm'] and \
> +    if base_distro not in ['buster', 'bullseye', 'bookworm', 'trixie'] and \
>          bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')):
>           bb.fatal(f'Self-built SWUpdate not supported for {base_distro}')
>   
> diff --git a/recipes-core/swupdate/files/2025.05/0001-suricatta-wfx-Fix-rebooting-via-tools-swupdate-progr.patch b/recipes-core/swupdate/files/2025.05/0001-suricatta-wfx-Fix-rebooting-via-tools-swupdate-progr.patch
> new file mode 100644
> index 0000000..68cd6a1
> --- /dev/null
> +++ b/recipes-core/swupdate/files/2025.05/0001-suricatta-wfx-Fix-rebooting-via-tools-swupdate-progr.patch
> @@ -0,0 +1,129 @@
> +From 6281f3783a303904981523ed8388b468d58eb5a0 Mon Sep 17 00:00:00 2001
> +From: "Storm, Christian" <christian.storm@siemens.com>
> +Date: Tue, 15 Jul 2025 08:59:07 +0000
> +Subject: [PATCH] suricatta/wfx: Fix rebooting via tools/swupdate-progress.c
> +
> +The changes leading to commit 077ef4f broke rebooting via
> +tools/swupdate-progress.c. Hence, adapt the C Lua bridge
> +lua_notify_progress() and update its invocation in
> +suricatta/server_wfx.lua as well as updating / fixing
> +Lua annotations.
> +
> +Signed-off-by: Christian Storm <christian.storm@siemens.com>
> +---
> + corelib/lua_interface.c  | 17 +++++++++--------
> + doc/source/suricatta.rst |  8 ++++----
> + handlers/swupdate.lua    |  5 +++--
> + suricatta/server_wfx.lua |  6 ++++--
> + suricatta/suricatta.lua  |  5 +++--
> + 5 files changed, 23 insertions(+), 18 deletions(-)
> +
> +diff --git a/corelib/lua_interface.c b/corelib/lua_interface.c
> +index 8d57aaa9..1ff3e5e4 100644
> +--- a/corelib/lua_interface.c
> ++++ b/corelib/lua_interface.c
> +@@ -1232,17 +1232,18 @@ static int l_stat(lua_State *L)
> +  * @brief Dispatch a message to the progress interface.
> +  *
> +  * @param [Lua] Message to dispatch to progress interface.
> ++ * @param [Lua] progress_cause_t number (optional), default: CAUSE_NONE
> +  * @return [Lua] nil.
> +  */
> + int lua_notify_progress(lua_State *L) {
> +-  /*
> +-   * NOTE: level is INFOLEVEL for the sake of specifying a level.
> +-   * It is unused in core/notifier.c :: progress_notifier() as the
> +-   * progress emitter doesn't know about log levels.
> +-   */
> +-  notify(PROGRESS, RECOVERY_NO_ERROR, INFOLEVEL, luaL_checkstring(L, -1));
> +-  lua_pop(L, 1);
> +-  return 0;
> ++	lua_Number cause = CAUSE_NONE;
> ++	if (lua_isnumber(L, -1) == 1) {
> ++		cause = lua_tonumber(L, -1);
> ++		lua_pop(L, 1);
> ++	}
> ++	notify(PROGRESS, (progress_cause_t)cause, INFOLEVEL, luaL_checkstring(L, -1));
> ++	lua_pop(L, 1);
> ++	return 0;
> + }
> +
> + /**
> +diff --git a/doc/source/suricatta.rst b/doc/source/suricatta.rst
> +index 474d02cc..a4081a63 100644
> +--- a/doc/source/suricatta.rst
> ++++ b/doc/source/suricatta.rst
> +@@ -557,10 +557,10 @@ The ``suricatta.status`` table exposes the ``server_op_res_t`` enum values defin
> + The ``suricatta.notify`` table provides the usual logging functions to the Lua
> + suricatta module matching their uppercase-named pendants available in the C realm.
> +
> +-One notable exception is ``suricatta.notify.progress(message)`` which dispatches the
> +-message to the progress interface (see :doc:`progress`). Custom progress client
> +-implementations listening and acting on custom progress messages can be realized
> +-using this function.
> ++One notable exception is ``suricatta.notify.progress(message, cause)`` which
> ++dispatches the message to the progress interface (see :doc:`progress`). Custom
> ++progress client implementations listening and acting on custom progress messages
> ++can be realized using this function.
> +
> + All notify functions return ``nil``.
> +
> +diff --git a/handlers/swupdate.lua b/handlers/swupdate.lua
> +index aa8a31d0..d32f83b9 100644
> +--- a/handlers/swupdate.lua
> ++++ b/handlers/swupdate.lua
> +@@ -63,8 +63,9 @@ swupdate.warn  = function(format, ...) end
> + swupdate.debug = function(format, ...) end
> +
> + --- Lua equivalent of `notify(PROGRESS, ..., msg)`.
> +---- @param msg  string  Message to send to progress interface
> +-swupdate.progress = function(msg) end
> ++--- @param msg    string        Message to send to progress interface
> ++--- @param cause  number | nil  `progress_cause_t` value as defined in `include/progress_ipc.h`
> ++swupdate.progress = function(msg, cause) end
> +
> + --- Lua equivalent of `notify(status, error, INFOLEVEL, msg)`.
> + --- @param status  swupdate.RECOVERY_STATUS  Current status, one of `swupdate.RECOVERY_STATUS`'s values
> +diff --git a/suricatta/server_wfx.lua b/suricatta/server_wfx.lua
> +index 0978ed50..d0b01bad 100644
> +--- a/suricatta/server_wfx.lua
> ++++ b/suricatta/server_wfx.lua
> +@@ -1471,8 +1471,10 @@ M.job.workflow.dispatch:set(
> +             suricatta.notify.warn("Cannot initialize progress reporting channel, won't send progress.")
> +         end
> +
> +-        suricatta.notify.progress(M.utils.string.escape([[{"%s": { "reboot-mode" : "no-reboot"}}]])
> +-            :format(suricatta.ipc.progress_cause.CAUSE_REBOOT_MODE))
> ++        suricatta.notify.progress(
> ++            M.utils.string.escape([[{ "reboot-mode" : "no-reboot"}]]),
> ++            suricatta.ipc.progress_cause.CAUSE_REBOOT_MODE
> ++        )
> +
> +         suricatta.notify.debug(
> +             "%s Version '%s' (Type: %s).",
> +diff --git a/suricatta/suricatta.lua b/suricatta/suricatta.lua
> +index 24d6eb8f..b8707a25 100644
> +--- a/suricatta/suricatta.lua
> ++++ b/suricatta/suricatta.lua
> +@@ -47,6 +47,7 @@ suricatta.status = {
> + --
> + -- Translates to `notify(string.format(message, ...))`,
> + -- @see `corelib/lua_interface.c`
> ++-- except for `suricatta.notify.progress()`.
> + --
> + --- @class suricatta.notify
> + suricatta.notify = {
> +@@ -60,8 +61,8 @@ suricatta.notify = {
> +     info     = function(message, ...) end,
> +     --- @type fun(message: string, ...: any)
> +     warn     = function(message, ...) end,
> +-    --- @type fun(message: string, ...: any)
> +-    progress = function(message, ...) end,
> ++    --- @type fun(message: string, cause:suricatta.ipc.progress_cause?)
> ++    progress = function(message, cause) end,
> + }
> +
> +
> +--
> +2.39.5
> +
> diff --git a/recipes-core/swupdate/swupdate_2025.05.bb b/recipes-core/swupdate/swupdate_2025.05.bb
> new file mode 100644
> index 0000000..b77236a
> --- /dev/null
> +++ b/recipes-core/swupdate/swupdate_2025.05.bb
> @@ -0,0 +1,39 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation, 2025
> +#
> +# Authors:
> +#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dpkg
> +
> +require swupdate.inc
> +
> +DEPENDS += "libebgenv-dev"
> +DEPENDS += "libubootenv-dev"
> +
> +DEB_BUILD_PROFILES += "nodoc"
> +DEB_BUILD_OPTIONS += "nodoc"
> +
> +FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/${PV}:"
> +
> +SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;destsuffix=${P}"
> +
> +SRCREV = "25e4534a157b8e432c3bcb4091e75724fcb0a5d4"
> +
> +# patches
> +SRC_URI += "file://0001-suricatta-wfx-Fix-rebooting-via-tools-swupdate-progr.patch"
> +
> +DEB_BUILD_PROFILES += "cross nocheck"
> +ISAR_CROSS_COMPILE:trixie = "0"
> +
> +CHANGELOG_V ?= "${PV}+cip-${SRCREV}"
> +
> +do_prepare_build() {
> +    deb_add_changelog
> +    cd ${WORKDIR}
> +    tar cJf ${PN}_${PV}+cip.orig.tar.xz --exclude=.git --exclude=debian ${P}
> +}
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#20203): https://lists.cip-project.org/g/cip-dev/message/20203
> Mute This Topic: https://lists.cip-project.org/mt/115872046/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 




