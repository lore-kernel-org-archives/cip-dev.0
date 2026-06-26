Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62236C43458
	for <webhook@archiver.kernel.org>; Fri, 26 Jun 2026 18:29:09 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.41404.1782498542509597581
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Jun 2026 11:29:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cNzMPlCE;
 spf=pass (domain: siemens.com, ip: 52.101.66.48, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZD3x8ldqrNlJ7+7WzO7VnoZBGv+Usgr4pnvngktVMnyq+or7Qr+zGkau4TxpHclL4wrEv4g2CAgYE9hMFGFgYKtn2Cu0rMhs9frpTPRr0EE/gdDP7ePOzXkZAKLuNp4+Yrpj2wfSRqfZWmjr+Zq+gSurORH4pR//EOYIZ842SePnflfEWdNnt2Dcr+nnvA0ZiuPv9xnABZpP9aAQxgHYgKQ8Bk74Xm+iutaBL3cVShvloitiuj1fNh8LSrT8mF2c7/kFZhn7dlwrRbww3rghIPPHGxYp1C+A9DJPBVxPVmBk25tgRikDTOI+C5Szbu0kQRLQc/W4mlVhRjoZ1CbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySjTKlvFQyhmfgDTgJpOpxT8Hd6Jcdw7BL7pgtnYS0Q=;
 b=HB5cMqTy6GYAmmHN7KTH29uQCofhnDy8S/FavQ7gG8wZmHV3xNrP9tXRAgx5yTwzzhfwdUfHeky+IArGVmBG4uHQBd9VJYF4CTYxlBMTHLDHkcEIFcFLw5mNfGEhNd5UlN8iudkNIz6LPNUjsFgC0faA0uyiCT9gufxUXhFBLxHbbZqQ8qPf0jrbm0sryMBPa1EY13FyxiXVnlrNUiuZbpvcxbBj62LlkFSK4vp8zFJ4+bkdJ/GRhrh0J0cfio8Tv/zgZ1bbbwfJI0piy8lWskyTWNMkfh01ZuIcUNzVC+n7+RdjFDgtiyZQ1w7NmovpGJWf1JEPuzoNd2/w3lMohA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySjTKlvFQyhmfgDTgJpOpxT8Hd6Jcdw7BL7pgtnYS0Q=;
 b=cNzMPlCEZbetkbZl30QeDOH4GLzcgzcmpkp1451O91xSq7Vlrch3QUI+nY0uhkLg9ganro/dz+5QNXaQxc2wnJQsLPVR+Q4eXN/rmIoBvT8kIM2Syx8bbi20E8RQLNBFdwDq+JjLPx5HjmqVQqgR0ZyXwTYH7gxMVfA6Qqsccqcm8N+IWyO3SOeT24o2Xtdh8zkO0rzFNyfgJCu3xsIXmXEhvFNAVMXfkGebbhNkpwHImGNhhn7AO6C3DkCDPHqBEMm/qkN4DLyEQZ4LJlVdHt5T213TxW+OQTCVVLKF/aonTmSEabKMqBI0rPeZQTM/iTYERH+j7aAmM51uEs/1+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DU0PR10MB7381.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:447::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 18:28:58 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 18:28:58 +0000
Message-ID: <43d2827c-d9ea-4fd7-b5eb-9a2181c6b4a9@siemens.com>
Date: Fri, 26 Jun 2026 20:28:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] Add missing MACHINE to install
 swupdate-config*
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 cedric.hombourger@siemens.com
References: <20260626163330.523726-1-Quirin.Gylstorff@siemens.com>
 <71292516-320c-4da2-8e7f-7079b4293909@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <71292516-320c-4da2-8e7f-7079b4293909@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::18) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DU0PR10MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 0541891e-9c73-4de3-9329-08ded3b0c94e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|55112099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 
	jCmxom1xwsAscBXMPGOxp1X9MLdrL2iFWABMfcwze5ijlZuDO6Hbj4vhx5SmjOjtI2Fv4GU9Y1lFvXeNsa7a821s2ePKerR5o/Kvgt5YX6uWJWwffIjHANIdTrrRPYB9sbvuATX+YW4/DSc8gGDCPc0yLqSZUUxeUOCNA3aFJDFdcYhIOGuUfSGW+TAvP7Q3rum4bk5b5mriU55yV2gm5CIJzHCp2j1ZdEODIXL2iDe+2n1aLMymBBkZ8V6YQTxemx9qaFChivS7asLOjw52eWwNAl8bLNE7cwQ2y0Il5oYUrEv89jxhF3zbsskoQwV8h6bcOgojHUQXMnlaLi7k24qbgiei/4JwqTZmayPfscvL1ehRoyNfaUNPLEZ8v7IiogLkQPGOkzMufyGPhThkzPOUTjfzxJ6SNP4rhYtepV7esdyjHqBg8smUjfaWJ6ZyuoWDCIjf3/P165MUqP4bHKlg1lL/US8Lw0Wlc9+zLkwL9cU64juE+WpDGMw26f5Ik0zK5YUEAU2Bb7iyPMfAvqGy2ix3JVzqiYuK25HEEswOqijP4SId+iBe3LHwCXKbd+GDePy6WaQ4+fPyGg+3rjRGisiCceIZl8H6og10Lxsx/2zb1CO8t1802TgmtDQbmbRbRLcBVGBKgNSq+1jwi/r2BCs000/KTsjawC0pgRw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(55112099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RmxXTDRYcEprM05uN3JEaWRSZXRodjVhbUZ1SEVRZXU0MTJldlp3RjcxOVNi?=
 =?utf-8?B?dTJnYmE1TWhUZVR0c3R2VFZ6ZDNmdFpoWUtRSG43aGFnNjhjOGMzR2E4SDZ5?=
 =?utf-8?B?T1dJZFdEMFVPMk9KMzBVczhOd2FwaTFjaHhwSndXYkhMeHFIa1Q3RytrakV0?=
 =?utf-8?B?NEE2d1c0VWZuZGxuZ0llR080R1ppYncwbTM3RDYvMEd1aXVwRnpDN2J0YUF5?=
 =?utf-8?B?TFNITzZsaWI1aHpGNElhZmloRVhmaE5tRndabzdnaGRJeVdTeFFUd3J2Nm9C?=
 =?utf-8?B?L0UyNHlQYkQvSVZUNXg1TW02OW1ZNXNpUVM2NlJ6TjREZTBWV1RZa2hPQWRq?=
 =?utf-8?B?d0wvN2FVK0h4WUJ2RU1iQ2gxeEhvYnppV3FaMVphZHhqNnAySm9iTjEzRmRB?=
 =?utf-8?B?Vm5abks5V25YKzkwdnpqUWhJSE1KaXBOZTVEVjJ5dTkxeDZOai9IdnN5R1Yz?=
 =?utf-8?B?OXJFSmFBTXNDWXNCUktjSUVpNlo3RHVFS3pnWjNXY0V2WEpSRjlDZ3U0Z2Zx?=
 =?utf-8?B?dEZQczNERHZTMHp0b3M2cUEzMVFndTA3UDUzeHpEdmJQMEVLSE5sanIvL1lh?=
 =?utf-8?B?K1hDaHk2VWpYK29VNTFOZlZWUUNmUHdTR1hDakZ4MWdWT3RPdVpUam1IY2M0?=
 =?utf-8?B?QnNHYlJuVGZlZklkcGoycHo5V091NjAwK2svMjU4c29OQmNuSHhkb0JWQ1RG?=
 =?utf-8?B?emM3MExRMEZXUEJ0TXZpL3RMaTlzSDBkaHB2UXJwR0JIUTB1NUd2Z3o5VTVY?=
 =?utf-8?B?THRMdXBobXRkQlg4OHNzZDMrZFhnU0tMVGFjdVZIMnEveFlCTTZ6NmdFc1hm?=
 =?utf-8?B?WWFUU3NLeWtKQkpxNFBwcHRBbTJQVnl1VTY0dFU4eS9rTXB2ZlBpTHpOK1Vy?=
 =?utf-8?B?STlLT1Q5L013SllldUQ0UUtxMlVSbGJDbHRISVJQQk1DZnRnTUJsWjVFVk9Y?=
 =?utf-8?B?aHo1RUtaOGtQZko3eFdKU0hWbzlDVHJUUy9xYjIvaHBlb1pnM0FoajhVUmF3?=
 =?utf-8?B?aktzWXBkMlEzUlMrcmtTTDM3RGVjWFpGTmhNT1FRemxuZjBnMDhSR1BGR3hn?=
 =?utf-8?B?M1ZPdjRhdzYrY0l0U3ZjT2FvK25SazNNVW1CbnUreXlHd1Njb3hrWUN5L0hH?=
 =?utf-8?B?dzlkQVE0bXhiMTVMeGlDWFZOeHJlMWtjdlFjcGxKNW01YmJnaGpwWkNtRFFJ?=
 =?utf-8?B?K29ad0gwcFNtWVRQcW5waEl4ZnFpekoyNzZrSDQwZmQwWmVvVWEwbkpjQUdy?=
 =?utf-8?B?Z1VmUEtpU2NNTy9VS3djc2hvdnBHTDBGbzh0cGc2R3FNMzkzWXQ3N1A5M0U3?=
 =?utf-8?B?UU9McXhHMXp6THVYZXdTZnBMM1BGSzEyb3piWkljMWhBSDZ0NGJNV29lVWgx?=
 =?utf-8?B?Q1RMVzZXZTNXT2t5OFZLdnkzR2YyWHNTc0xHNWZTdTlpV3FhUjk3VXVCSjB3?=
 =?utf-8?B?M1pMUllTeEo5dGk1clMyRlhhRytLSDJVbkF2ZkEwQVlYVHAwdVJ4UlBZcFVo?=
 =?utf-8?B?bXpSaGk2RWFJZ1ArMjZqbUtNTnRwRUhGbHBWdm1RYXJXZmJod0RlY2hoSUR6?=
 =?utf-8?B?bHI3Slg2eWRTNEhRR3BUUHJiL0tKVFg0czlmaDBvZ2E3d2k4L1ovdXZ3aG5O?=
 =?utf-8?B?S0tUSkJ4WXVlYjgvWWdxa2t2Z2hMV2tjM0l6Nm9KNzYvazc1OU1nUXpEWFBO?=
 =?utf-8?B?b201MXUwblpsTDBZQ1gvUGpINFdEOHQ4amw2QUN6N09WMEpqb1BvSVd5eVJv?=
 =?utf-8?B?QVJ2bHFLR2p5N3F2d0I5Z2gvQ0loNU9hZ3pxdUxoVzZZM3F2SzlOcHdXZFZu?=
 =?utf-8?B?eDh5SkY3TWxybGhBRjkrNGtnV0VUVTNsZU5ldlFOYitsbFZyTUdqY3llUGNY?=
 =?utf-8?B?NU82bzY5ekpZZU5zMjdUUUlQakh0c2NVWTc3SXVVd094SXRFWnRNamo4MzdX?=
 =?utf-8?B?dGxITFdEWEJ4RUE1N1AzR3c5UGlXdHE4cnhzekxSZ0FTMklmWGxIR0l3Yitu?=
 =?utf-8?B?TzE5Q0xpcW1oOGZpNlFNdGJESHVmTWFRK0puaVZSS1pPQTl3WFIrdTdhMXcr?=
 =?utf-8?B?dXlETFNMSVJpaExnUmdyc2tON0gzcHFLeWN4RUNZRjN6NkdTUjFzU0ZhQ2Ro?=
 =?utf-8?B?MTNNY1E2OFFrL1NNRXRjc1IrZm5obnF2SDkyMU1yenludzJaVTNRRW55eE15?=
 =?utf-8?B?Y0NOaXV6QWlYVUhtOWgyNWNRWDU1REdhdlBIb01nZTEwRlhNbWN0V04xTXVp?=
 =?utf-8?B?VkZwWFJkVjZPR3hZbGgxK2Z4bVNKMnA0Y0svL3ZWTVJRa2xyLzZLczZwVXhP?=
 =?utf-8?B?QnNKUmlqc3laalNyMGtzNFQxc2wxZm1ObGg3eXNjS3JabUpKVzExTkdJaHdu?=
 =?utf-8?Q?L86/omJAT2yuqjJ4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0541891e-9c73-4de3-9329-08ded3b0c94e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 18:28:58.0537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTkuKkrfFiMKHJ+/Xj01lUDSgX8HTmw60/JNZDHMuIRCFjepWv1geYqtpK7qGzrIRifbcmV/IaBink4vi2jwl53GKoMEUQ4rrmFotMu77is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7381
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Jun 2026 18:29:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23288



On 6/26/26 7:13 PM, Jan Kiszka wrote:
> On 26.06.26 18:33, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This fixes an issue when building swupdate-config* for two different
>> architectures, for example arm64 and riscv64.
>>
>> The reason is that both package are ARCH all and provide the virtual
>> package `swupdate-config` which leads to the following error during
>> installation in the rootfs with Debian sid:
>>
>> | Building dependency tree...
>> | Reading state information...
>> | Package swupdate-config is a virtual package provided by:
>> |   swupdate-config-qemu-riscv64 0.2
>> |   swupdate-config-qemu-arm64 0.2
>> |
>> | E: Package 'swupdate-config' has no installation candidate
>>
>> To be compliant with the Debian standard the conflict field is missing.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>
>> v1 was 'swupdate-config: Set DPKG_ARCH to any'
>>
>> Changes v2:
>>   - set explict recipe name in image creation
>>   - remove DPKG_ARCH setting in swupdate-config
>>
>>   recipes-core/images/swupdate.inc | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
>> index 00e972e..006d622 100644
>> --- a/recipes-core/images/swupdate.inc
>> +++ b/recipes-core/images/swupdate.inc
>> @@ -59,7 +59,7 @@ IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFB
>>   
>>   WFX_URL ??= ""
>>   # check for wfx url to enable support for wfx backend based updates
>> -IMAGE_INSTALL:append = "${@' swupdate-config-wfx' if d.getVar("WFX_URL") else ''}"
>> +IMAGE_INSTALL:append = "${@' swupdate-config-wfx-' + d.getVar("MACHINE") if d.getVar("WFX_URL") else ''}"
>>   
>>   IMAGE_INSTALL += " swupdate-handler-roundrobin"
>> -IMAGE_INSTALL += " swupdate-config"
>> +IMAGE_INSTALL += " swupdate-config-${MACHINE}"
> 
> Shouldn't we then also retire the virtual packages?
> 
This could break downstream. Also I currently have no better solution than:

+DEBIAN_PROVIDES:remove="swupdate-config-wfx"
+PROVIDES:remove="swupdate-config-wfx"
+RPROVIDES:remove="swupdate-config-wfx"


Quirin


> Jan
> 


