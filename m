Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A112D5E15A
	for <webhook@archiver.kernel.org>; Fri,  8 Nov 2024 11:42:44 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.56])
 by mx.groups.io with SMTP id smtpd.web11.11024.1731066157416918325
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Nov 2024 03:42:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VBByTS+6;
 spf=pass (domain: siemens.com, ip: 40.107.247.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+zsxbrzw861L6ciYKE2FotWDENIHUw5bCw9pxbN9y/BAAARYZ9YNyirwtPqYXOqNTz3xVcD3Us/8TQa7hlphHq/8az8zhZ74n5OSlfM43YdfluOdFB2aJD0KEgvUrjAlUq6Z8ZheAXh5BbcvrTzhTkOSDaGIudeTUFc/GMJbSeRE2tA/DbrAPb5zzqM6uKDCzsbSnqdQlq6/MvOY+aIDpsxsois747ht4GvKqrquYQ9YRWFnzFzv/NhLwa0AJ0kEVlw+n5aG1GdHDbL+bKKtrBnn6xMxf6hodrxVfp6AzEbJObQf0yeoZo/OXSYcMFdhCxHQtmWr4V5UEoPrNpOxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3kvtT4iiLqWRcEIHysAw3QwRkR4i3ggvFP838rCIvQ=;
 b=GmNO4N22cnSN6MCXmTXiD+gsXc4v8K5ecUWWDGIb4GaGObHwICUJBywIp2TH22Wzdb5Xi4jwSXRMLFwVLZEgU7Rp8sVy+rg1sD1z8hiKDCBDj26N7awNJUlryEUP2DJN63oLXKCN+DP6fuOMmyT/UAMLnO127MS2HPuiFETHRlG/+qPPJm89K4LkqqcVfmB1YnzuqlHriSByz0BUxiGW7Uyo2vSFzkneD3yhI+8kcP+7MCJLuK6owmF8BnyGKXZ0zeTmu5HyGd3rsUhms96IYtjsU6p7vziYoAlxUz7ScIcVEe6cV0A8Yhz+FoYqZPGRAgfxLL7KsKlVFSBjZag9fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3kvtT4iiLqWRcEIHysAw3QwRkR4i3ggvFP838rCIvQ=;
 b=VBByTS+6wVtDeHv2tpO2U8I49AUGG8w5mm95GuPRJbTL23opQouobwJKfgcXZKhEsloLvC6HsauapOEP37ZGL9WPfVDjeG3KLl6bQA22sCtXhjyqOvkDo7c1Blke7DluxSYZ3zRv9/viVPDRFBx64mgvwLoIMRmpV9nuznDiPwnwgrG6Jap2sAwRyMCOQOwHWPRU+N496t6RsjqtYM22aW9neeHZw9IDc9XXLGBCI2An8XHCa1k2bWpmuEi04/UXQMK5QGDXOou6tz0/43XqRo6g4GclADuTG+vJEkcUj8rw8QBs7R/0u9G/PU7YGynJQcGgYIyZr8GUtXEfXeXIaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Fri, 8 Nov
 2024 11:42:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 11:42:32 +0000
Message-ID: <07bacbe5-4716-4dd8-88e1-f9fc3175b9f1@siemens.com>
Date: Fri, 8 Nov 2024 12:42:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled. (for bookworm)
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20241021185359.927395-1-alexander.heinisch@siemens.com>
 <20241021185359.927395-2-alexander.heinisch@siemens.com>
 <d4932ec9-d4c3-4be4-acac-b3957b710627@siemens.com>
 <AM7PR10MB33202B3696E06E47C3520679864E2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <47553bc7-816e-4f42-8745-d5992b6e650e@siemens.com>
 <AM7PR10MB3320E21C3DD427C0C85A3556865C2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <AM7PR10MB3320E21C3DD427C0C85A3556865C2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5b2307-1ab7-42b9-6aa1-08dcffea6e96
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L1VXL0lmTnN3dFRvc1BFZTdlZC9MYkxGdFRYT0NBTlBQNFRhYnNmYk1Hei9U?=
 =?utf-8?B?Z2dSYjc5YlA3Sk9Rb2FDUjZqZ2R4YzZycjArZldqT01SWXdGWTNZQ1hSckVj?=
 =?utf-8?B?K29OUXlxbm1xNmlSSFdWYTBKWTh2c3JIZng5NTAyZUQwbm5UZHZkWW5sbEdS?=
 =?utf-8?B?M3FlczIwTUduTFhTSG1ldmpsNHlGRVV4LzNTSTNjQ1pQSjBnNnhvaG5hY1ZD?=
 =?utf-8?B?L3VQOTduM1Q0TTA2SmtRV0VXdjBZVFRtaXBZSXBjbzRXbitscjljcXJWVHVQ?=
 =?utf-8?B?OC8vbURCN2lnNkVmMFV4VGhzWmpqWFh4dng4dlVtNlAwMkRSd0NHNnRYbXAw?=
 =?utf-8?B?UUlnc2VQeFhPY1Jyb0NVYkNkMTJiNm1CditRRkx0Y3EzQm4ranlKMVVmcE9w?=
 =?utf-8?B?QnkrYVc5Q3d1dkh5R1NYVEJ3MCs0am80VjU5NWxTUlFNMjJpcG9SOFdycW1j?=
 =?utf-8?B?SjFhb1AzSjI3bTUxTy85a2xETzNJazJHRXBTT29oV3N2bmxvd05RdnpQemhL?=
 =?utf-8?B?Sm5xMjl3R1NkV29VNWFubUY0WnJ5V0huTGFnRGM0ejNtOHhJN2lHMHBmS04y?=
 =?utf-8?B?bUFqd3grL1lsZmpqZHp0RFFBeXFHVWRLbk11QXAyYVc5cXdMdUZhQ1VqSnZ3?=
 =?utf-8?B?c0FEQzZHWVpLYlFURWJFcU15ZUlDaTBDdmsvN29oZ2pxc0RRajE2M1gzRXBN?=
 =?utf-8?B?M29Wd0NUaVlFbU1YV0IyN2J3VTRuZGlNWUVBWmdGRkFRSjZIMlJhS3hyb3pz?=
 =?utf-8?B?R3VOU1VHSlhESXJHaXk2Z01Ec2RDZ1dxOEU4L1dLSUhZeHl6aWZLaW9xa2Vo?=
 =?utf-8?B?ZUlPNXZvdU05dCtTQVp5WlM3WFViQVdoS3dIeDR3ZGRJK1dLZFg2QkhDT1lj?=
 =?utf-8?B?aHdvVXNDNDdDcVJLZ1JvOURjMjJRTzFEY0x1YUZKM2NBbi9yMmhZYTFyd1g2?=
 =?utf-8?B?UC8xMndvdis3RU9MYU1wYVpEYjlzZXN6V0E1SnVUNElnUXUxaGhzelVIZXpC?=
 =?utf-8?B?UEx2aHlXMllMQkgwcEJSRGFKY0RIdTRDc2ZMNnpPZjB6ZFZEVWFPaXBnTjRM?=
 =?utf-8?B?VnYyMDFWRlRERnlUY3plc1pUOTBkRDk4cEsxZ3hPbVpHc0NxRWNNeWQwQXdV?=
 =?utf-8?B?OFk3Ri9vQmx5MFZ3bTNnWlZxQTkxNWZieXFOV2QyQzV4NjM2UmVPZ2poVFR0?=
 =?utf-8?B?N05SZ3k1bkJNZmVDTEUxRkpaMnV6Uk5obmh2RUxXeUMxMEZPais2WGtNemNK?=
 =?utf-8?B?cDcxcHhxV3FhOWhidk4rUDIvVHlkaW12aU85MThUcENGOUdzRU9ZWmRtZk83?=
 =?utf-8?B?WVhXdHZVcXM4WFVYSjJKSmh3cUJ1TjMrVVRJZmFLL3NNWDgwWGxmNmxsOXZT?=
 =?utf-8?B?NEpCZ2d3ZUxSdGhZMThSM1JUOUN3TEhvbzNVMHBDa1N4NVJaV3YvNlBleHNw?=
 =?utf-8?B?akU3Y0dQeHNZVEsyT0NZMUduaUlLS0JmU3pLNmZOSUZaK1NxSVBQU0NZU2l6?=
 =?utf-8?B?MFdoZGdXOWxrY2x5eXNXU1ZwQmdFMFkvcGJjc0RsMjhXMWFrVXIvbjgwT0N1?=
 =?utf-8?B?M2Frd3dseWN1NVdPdzZUSmRhR2JqRlJtb3lSWVo2ZjVNMGJ4R29XWHVIREpS?=
 =?utf-8?B?SS9ZbnB2cG9VZzNVQWJOcmhNajJycHB5N05weFNGT01UTFNhMHVMcXA0UjNG?=
 =?utf-8?Q?El+ZEY5fMQhiZkjE9CyE?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OHRsY3I1bTdaeWFUWFJiUzh5Wms2c3BlUE5ZWmkzMXp5RkQ1OU9JU2ZFQjk1?=
 =?utf-8?B?SFdoZXJyVFRDMUZQREMvM0M4RWtqQ3RSbFBOQjNSeVN4b21Vb0MvVjM4Mk04?=
 =?utf-8?B?NVVBWnU4MDJ1WElYa1ppSGFRWkR3bGJtMjJXYVhBQ1FhVXJ4NEdrQkEzRTZl?=
 =?utf-8?B?VkE3SkdLWit5UmQ2bW9oanJpRWV4MFBqWnFGTWk4RWVQQU5EbmliYk9HU21H?=
 =?utf-8?B?QnJERnN3YTVuSUtub1ZzdTYrUXFxVlhuNFpLSHVEMGNrQ0NFZ2prNFpKa3JX?=
 =?utf-8?B?Q0lpVU5EbHpPNWZiYlZMWEhBbWY0OFkvWXBXR1Jpdmo0S0NPcUp6QjNEek9u?=
 =?utf-8?B?VVNxc21TR3d4UFZibWwzRFZtdUJkNWUxWHk2K1BnVXJZQlZvZVZxWDF5bkNO?=
 =?utf-8?B?VERaeGNZVS9WajJheitQczFXL0I1VmMySVdYS2x4ak9WSi9VdGFzQ05jVnFY?=
 =?utf-8?B?VlZDMjRxVldob08rckxVR1ZPd3hhdExwdE10cFFLN2NyOXBtYnJDbnRDdGxP?=
 =?utf-8?B?RDhFZTZBUWFkOWZuTFRSV0wweW4vZG83TXVFNHgxSTJaTE1rZ0tLaGF0KzFr?=
 =?utf-8?B?MVduNkdaS0V6djRCWTRHdFZVMXpZd2RkUk8zMDA0blZQMDhFSmtQZkxiTm9z?=
 =?utf-8?B?SUl3V2RxTUtVZnJzeC8zYU9CeVhRUjloZEkzSXlBTnNXZHRSNzd3OXYzcTNt?=
 =?utf-8?B?Z2ZEL2dpRWZpT3FHMklZeXY3L0lPV2xCbDZOaVBtL1pYREFGQmZDQ2hpNHZt?=
 =?utf-8?B?Qm9qWDhENVVBN3B3cENMd1FocStENlpvTXVuaDRKTy8zVVh2Y3dUdTNIdjgx?=
 =?utf-8?B?Z0JwalJEbEoxTmlsTEdSMjhLVUZLeis3bUhUeXRZcnd0MWlDZlBadW5EeGkr?=
 =?utf-8?B?WlQzUmo3OHBTZlRFWDQ4NG81Y0lKY21EZnVoM1grNDJ2empnMEZhS2JCdkFo?=
 =?utf-8?B?aFkvbXFlM1g1dFFMUVNYTDdMMTRJRlcvK3E1bFl0S2tqajZ2V2I2QVYyNkE3?=
 =?utf-8?B?ODRBcFozQTFFRTBEdDVNR09CNkkyOUI0eG5ZY3BhcTRuNlVLb2lzeDNVNTZv?=
 =?utf-8?B?cEdGL0FTaFd5SlAzUVB0OFNhbXVIZHlLVy9SV1N2My9OY080VGx6VlJQUjVh?=
 =?utf-8?B?R1JIcTNxVTEwRDFzZ1V4ZjZvckN6UnRoMFdLeEVZRkxtejNOQmJIWk0vWGlE?=
 =?utf-8?B?N284TTViMUErMVBZSWVzelV5K3B3NWtPUFJ3WVhkd3VkcEpvZm9CK0wyMWN4?=
 =?utf-8?B?UVA4MDVmSm5hV1ZtZkNyUmVmWmhLSUtCQm5NL1RCcUZKWHB0alEyTnhGQTFl?=
 =?utf-8?B?eUNraGZTV0QxMUlURitKNWcvalVycE1nNGlmOVVXS0hiSEpBVjhTTU5lekNm?=
 =?utf-8?B?QkRKTWhVdTlib0tWZ1VSWlFTWVZQNVlWcld5VEZCRE1Hd0tlamFoelNXa2Zp?=
 =?utf-8?B?TTJIcEFZTmh0dVZmVm1xYXNBaUpOc0hpYndwZnpkdERnUy8yOVJCQXV6UUJz?=
 =?utf-8?B?YU9KcVZNS2JUVVVGUHBKMHY3WkdEZHJKK0gyeDEvc0k3RUVsZk5XWllxcGRs?=
 =?utf-8?B?NGlaM0dsUVNPNmgxZ1k4VWo5Q2Y5a3JVV2VHUS90bkxocDg5ZnhCQ25yK0JM?=
 =?utf-8?B?R09GMjJjZnFCNGlWbnVDNjVCaE5UTU5xbGRiYk1WbytQdkhaeGFXZVl3MElS?=
 =?utf-8?B?NDI2MGhCb1c3WWJvL29TK0NRc0l4cHFLMTB6eWYxRGFTME13UXdrUGRIMklQ?=
 =?utf-8?B?SGNPNUROd2dTN1phcEE5NWEvN3J0QVFNZzN6Y0duWGRJVXhiTTl2WVFHWTNX?=
 =?utf-8?B?eUpNZ1BEYnNQTjcyQ2FvN3d0eGpBRGhidW1XalBJYnNpckhBWlpTWUt1U1Fl?=
 =?utf-8?B?dnczOXQ1WHI3U3kzSWdUQVBYT0UrUkVKSFBTZ2J2N3ZpNWc4T3Bac0VUSWcx?=
 =?utf-8?B?ZTZicG8vR2NVWFpFUnN5YmxGVll6eDE2SjVkNXQxV2J1ZEpNcDQ5ek9mbTRO?=
 =?utf-8?B?SUZQVWQ1VkxYWjhTV2EyQXZoRGxsWlZXUVFDcXE0NDNTM0c1b04zd2pKZ2o0?=
 =?utf-8?B?UERyY1ZScm9rNWFTNnhhWDl0YWp4Vjdob3hpMEFsWlRTRXZJazhSMmJxNHc3?=
 =?utf-8?B?QVVpU1MrUm9xbUlsQWtuWXVvbC82NHJORXRNb0dGbzE4VEdWZjgzcTlFSWdn?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5b2307-1ab7-42b9-6aa1-08dcffea6e96
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:42:32.3950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzBhsABzxVnc28l67xih5ycur8v1pnIp6t8hkyS+thBAX4KAr1pywAYFChe4UDkX6QytVpgj/k2wXIGkviJidQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9069
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Nov 2024 11:42:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17225

On 07.11.24 15:32, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>> On 24.10.24 18:58, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>>>    Unfortunately, I could not find such library anywhere! - Therefore, expand on first boot and similar,
>>>>>    still won't work for current disk encryption implementations for buster and bullseye.
>>>>
>>>> There is no clevis library as clevis is more or less a bunch of shell scripts. If you want use expand-on-first boot with clevis a solution would be to extract the passphrase, see [1],  from the tpm2 partition enter it via a environment variable.
>>>>
>>>> [1]:
>>>> https://git
>>>> lab.com%2Fcip-project%2Fcip-core%2Fisar-cip-core%2F-%2Fblob%2Fmaster%
>>>> 2Fdoc%2FREADME.tpm2.encryption.md%3Fref_type%3Dheads%23steps-to-conve
>>>> rt-clevis-to-systemd&data=05%7C02%7Calexander.heinisch%40siemens.com%
>>>> 7Ca83978638b104123b3a108dcfe891659%7C38ae3bcd95794fd4addab42e1495d55a
>>>> %7C1%7C0%7C638665111935069295%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGk
>>>> iOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoy
>>>> fQ%3D%3D%7C0%7C%7C%7C&sdata=ynIFg7PJa3BefAF9GN7s7rB0E2TeP6%2F4G%2BHDA
>>>> vNBRxA%3D&reserved=0
>>>>
>>>
>>> That means a bigger effort on `expand-on-first-boot` script than just 
>>> setting the correct package dependencies!
>>>
>>> Currently, we are using systemd based cryptenroll in our project.
>>> So there is not too much motivation digging into clevis for that use case.
>>>
>>> Still, I think fixing the issue for bookworm (systemd-tmp2) is better than not fixing it at all.
>>>
>>
>> Quirin and I discussed this a bit longer today: We actually should remove the need of expand-on-first-boot to access the key again. And that is also due to an idea I picked up yesterday to lock the tpm secret after initramfs so that we reduce the risk of leaking it via the main OS.
>>
>> Our plan is now to convert expand-on-first-boot into an initramfs hook that would then come before the crypt-hook, thus would only work against the unencrypted blank filesystem - problem solved, just differently.
>>
> 
> Actually that's a good idea!
>  
>> For now, also for trixie, we will just make the dependencies of initramfs-crypt-hook release-dependent in isar-cip-core.
> 
> I guess this is the patch [1] you are referring to?
> 

Correct.

> Just to be sure, still, the implementation of the initramfs hook for expansion will be in isar?
> 

Nope, this ideas fell apart after trying to convert the current systemd
unit into an early initramfs hook. We will need to split things:

 - expansion for already or to-be encrypted partitions needs to go into
   the crypt-hook of cip-core
 - filesystem expansion may be doable via the existing
   expand-on-first-boot if we teach it to skip partition expansion if
   the disk is already full (currently, it bails out early in that case)

> [1] https://lists.cip-project.org/g/cip-dev/topic/isar_cip_core_patch_5_9/109441764
> 
> 
> I am currently using parts of the expand-on-first-boot scripts in a 
> device bootstrapping [2] utility in isar-installer-image
> Unfortunately, that utility is under heavy development right now, so there are 
> no patches ready to upstream at the moment.
> 
> Nevertheless, to reuse as much of the functionality I provided [3]
> back then to reuse the image deploy scripts as much as possible in the bootstrapper.
> 
> [2]: https://groups.google.com/g/isar-users/c/ta0G_KGS_yU/m/5HnEK09BCQAJ
> [3]: https://github.com/ilbers/isar/commit/8a170f9d634b56fc1445b4e9674d73c99257a9f4 
> 
> Similar will apply to the expand on first boot scripts (among others)
> 
> If you agree on that, I can provide a patch for expand on first boot before switching
> to initramfs as well!

As written above, the architecture will look a bit different in the end.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

