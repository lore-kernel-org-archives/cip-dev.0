Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7D1C54E67
	for <webhook@archiver.kernel.org>; Wed, 20 Mar 2024 11:28:12 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.51])
 by mx.groups.io with SMTP id smtpd.web10.41199.1710934084083260507
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Mar 2024 04:28:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aETFjJkC;
 spf=pass (domain: siemens.com, ip: 40.107.7.51, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/HZ3AnC2VvgCSuPLONN8vbHiBXmh3+qUS4gkk9mbku3esw1r+LEQK5XE1iF9UqbPvcDECpg00hrTv8xgpd+pcqO0RU7nIvG7JDauUfEJP/UGITXOeJcnWzzGitMNspFLa20XJhzQCtWjf0RqprKcTpOoGsjZsJIjbeRQE/GQZlJB4z7Ojp6NupbFm70puUWzY9z4lvtJ4eyp20nbrnt/3GUXKfhvLCRuTHjePD1Vy5sT4rChpzv/VZ47+O+S5Uj+Vn6RjzotnbR/2cORsLbSM1YZiTLlRa6uvszOKrvhGjMxap920vCNGnn8rL8ERzo3tfrVX9+qj9VDlc79VqcmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJbJnIvjc3OuAhQgOZWqkBuvdVpv5BNSUYNFrK6Co5g=;
 b=FmIQ60PoP9yeWpLjUHUcyq9SoThT98ax97J3I2q2tdPplV9ca2uteoI2wRHNRpR2GCBxaHxNx/KH2QjNFZrUhdPW8WowL8C1Spiwxe73BN8amVM8cUbIcqczNeoQdSsX+qr3CUKAvpoIJYuFKT425sRaDoagJW59ErkToN4VvIhXyZRQ6PfbZOYmA4z05cnMvWtwM9uIO9hh4Bf+2ZIEs0bfTdcbh8SeQ7dMtqMDtl5pSWMBH9T8MiD56dY7q+vNCVdGfgjeOUg5qb472GtDJTCxwRbPYAchX8QY9lPwnYBC5xAQkzUhvUgSKKYnug6yjnokKiea2fKsY/ntnisa2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJbJnIvjc3OuAhQgOZWqkBuvdVpv5BNSUYNFrK6Co5g=;
 b=aETFjJkCLMpqIsKO1Lz55ZP9JndgejHpW4TdzE1HxS8B/0YurQUx0sf18r0df/+J83A7qKWHu6o5/wGRSCi8ONgM98CNjFojmsU+pOV6G+fcHss35iLe3P8CFRpPfJcF2VZcjy0nz2XvZMglpVjLail1A6X7BNePHzYSBIpLQASd817X5AgI8nnxD75AjGl8DXdhe6DrTFttWJKxccGAsIElsvxN0DsJrdxMImYWJox53vLaBqLyp78X6B+nhl9ynESg4WqMnmUsnrP1AlvzEY1sDccxtj9+lQON0NluWILeQDEgXWnMbWMtcSAYVv0916MsgOh//nLY+iXu3XiuyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAWPR10MB8091.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:37f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 11:28:00 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 11:28:00 +0000
Message-ID: <1f5b0ff2-b17c-448f-988f-4999cd5f529a@siemens.com>
Date: Wed, 20 Mar 2024 12:27:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 1/8] initramfs-crypt-hook: Allow
 switching between clevis and systemd
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 johnxw@amazon.com
References: <20240319182026.1571362-1-Quirin.Gylstorff@siemens.com>
 <20240319182026.1571362-2-Quirin.Gylstorff@siemens.com>
 <0b49dc4c-db73-4b3b-bc4e-a4c8073a3956@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <0b49dc4c-db73-4b3b-bc4e-a4c8073a3956@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::8) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAWPR10MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c9ccc7-a940-4aa7-4c16-08dc48d0cc90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	P2SQN0Wa1bzMaJb+DdUQh9u5KlwZ2GMEbn9IkEaxkYhN9l/xsxkmrjBIamHI2CFyiw1NzHUfmG+zalMPo1GDwB15uaQRNcCBQ3oYxfa4u83aDpvgkD3rR7UVw5fm85DEzYh5PXI0BPoTNI/4jfLid8O4yWaag/feT6JIJf4SJoavGFXkTOkDNOB6IFYQOTkukQsCBUoJUVqGd5/gTYICiqBvadGgUa2CO0gSPfMbDH2Kh8bVhG6+bY+kVmqwMQgTJlyjjWGQ1m9+HSrPppnf3SI5UeRTf/6/FW5aCEuTeIWRbm/yOdQtgmRlgGxeXr8UL4dqu8u1qQuyzMkB0Pm2raIHpvNQb7DxIPw0f9imogiijZEmCV3XRnf9eW0UITwYNO//QG0PmqMmwLQo6a4OK8v5JVzhEO6knxNfLedZ8YrpNlRm46uWrL5hTw1JBHHpYZj1I8LVORBmHDqnlVnbxBeXl9hvCHBiUymrODR1UxD/2El1zL6rMUL4EVKRlD2nJWAmxvu3aJEZ+1jd+RFGbKeuRYduUu0Bpm9FxGSPtXSdML+B/Uqg47iHcyIkik5O6QwZT8mzWDi03wydI1dieniE3GibR7v7G62mXzRi1sGkUIbU1NceFOfM7U3VxNmSF+1vWXxCfv2tH12lric49N0N8/7AGbSGohXvXVCFzNU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MjJ0a3kydU55VHRla2dYL29GZFFTT0lKRllqQnZnbE1heGkzRHZnWUJtWXBr?=
 =?utf-8?B?eG51dmpyRnpBRmVQUmNWVGZ0VWtWTXhJTlJjeTd4YzdJUVNJZ013RmlWZTg5?=
 =?utf-8?B?RkxFR3BZUjU1RTUvdGRxSlFrMk5qNlhyTTNmUEc3M0Zhb3JXZDZSMVNLNll0?=
 =?utf-8?B?MUdFTEcwL3hkY0VvZDVBMVo4SEhMbGY0RVF1YzJ4ekk5WjdJaitVQnphMXdz?=
 =?utf-8?B?dDZhMTFoaEVKdCtDRFRkQ00wT3VCbDVNWTFGYXBtTUpPSDB1NUxEbUVFTFlK?=
 =?utf-8?B?UmtNM1g5b0lpUVRYak9DNFJtVGgzMlRYSFplYkN4QXZXSlcraDhYa0pQcWhJ?=
 =?utf-8?B?YzVkWllPV2U4U2UvREJBMWlJaDB6VHhvVUdQQno1WU5pOWl5ZFNzUGR2Y2NO?=
 =?utf-8?B?a2RqY1c4alhkc25maWpZQ0FaZ3BsNFpaOUI0eWZ6NERnMmRZRjdpTnlZKzZ0?=
 =?utf-8?B?NjdhNGdVbEZmU040QldLL1JSOHNiY0dQNGE1VWcrM1E4UVA4ZmI4d0gxSk9X?=
 =?utf-8?B?TlR5RVdSaERjanZ4cXI4SWFqSUV3ZHZnK2dFMWNHTHhabDRXUkRPdTBLejNB?=
 =?utf-8?B?bWxKZDU5dXBiNXhxcnY0Z09OcnFBajExQ29tZ3Y3Zml1eUg2SVdrVENnM3ZR?=
 =?utf-8?B?UEhHNE12MDZQbEg2YlJzOE40TisxL3VpcUkzMWk5NHgxUTRtdGZJbXdvbjRh?=
 =?utf-8?B?YUJQc3VuRldSUklIRnJzN1N6UlNxVTVKTzdnbGIwdi8rTVBoNmRHSG1objZw?=
 =?utf-8?B?RGNaSnk1TUo2N0g4OUtHSit0S2t1dDVlOEVkUzN6dis3Y0F2UkxLZk9Dbmgz?=
 =?utf-8?B?Ly9SaW1JT2UvY1g5T25PYXlHRW1LdnFsczJZNmk2Y2dYOXU0RXZLdUwycFdO?=
 =?utf-8?B?a0RHN21Cbk5ZY0dlUi9najBEejJzQnhFcTl2L2trMThOZTU5V2I2eTB6dDR0?=
 =?utf-8?B?L1lDQ3FScmdvbk1jeHo0bzFxMldFaTZ3cnBEbnVVcVdOaFRLTnNrc1VqUjA3?=
 =?utf-8?B?aDhJTGw2RzVUUFhTZ3RiU1FNOVpDNWVwUE1xbWdzb3dFSFl2UVhOQ3A1OUly?=
 =?utf-8?B?dFFjRXcvUnV3MmhYZWxGTDhVbHFNbjFDUXB6TkVwQUtXMVNZaUt1YTU4NEQx?=
 =?utf-8?B?SUdKRmJYcXpBRzc2eWNiVW9OWUt5WHNHOWwxTVBnOXhyeVN2NTR5Nmt6WG5Z?=
 =?utf-8?B?di90bWFLR1F6YmViLzdxbTJPbkNYM3Y5TkNzeVdVbVVhUFhvRXptTkkvQWIv?=
 =?utf-8?B?dTlOOCtla240UG9vcUJOUkZGRUh2dWNrOGdVZDZVeHVmMXVPSW9OaUM0UzFG?=
 =?utf-8?B?blVPWVdhQ29adGNUMlVwQWo1TTJGR3M2cUZ0Rm54MjlCWWRiUGovcTRFVjZx?=
 =?utf-8?B?QjJsbjFzMlNHdlFEZWhiQWpTdnk3VHpicnZIeUIyZ2pmYVVzVGE5bTlHdXBK?=
 =?utf-8?B?Q3V2dm80eXpNVENZbStsSWJ0a3JlMFJrU2Eza3pqUC9mQytzVTR0bm4wK2Rw?=
 =?utf-8?B?SjY4T1ZlNmphWmNPTzYwRjNJVDBsMng3K1cxTS9xRVFSa1lUdzYyOUJkNVhF?=
 =?utf-8?B?RVVHNUpVNGFSb1BSSDAyRmV3SlBMSXR4Y204ZWpFR1dNaTJsVkpTZVZIb204?=
 =?utf-8?B?SzU1ejZiYkRNZm9LOThLRXZlS0hQQUkvOE9YdXpkQ0lKTFcwTVRCaHl0QzNH?=
 =?utf-8?B?Q3h6UmNpYjdGaXJ1TlhjaytBSHRtMXB4TnUvem1KM2U1cWpqN0Mrajg2ZG9n?=
 =?utf-8?B?VnZ5MUpTdng0cytEbHI5aHczTHNOK1o3VUx5bk5CejNUU3hYbDZMYWREWS9G?=
 =?utf-8?B?eDNXOUFPUGVWSmNnMmpkaVo3ZkFJTGxLb1RUb0J6RnVmVlFCNStFb1FhbHpQ?=
 =?utf-8?B?a0ZucjJ6cU5RZ3VsNTg3K2JvSkxaM2lTV1lWSy9aVmUyd2dwVUVnV1FyZE9x?=
 =?utf-8?B?a2VCUlJod2ZIQ3VNeHlnR09MUk4yUVA1ZW0za1ZsSUo4eWt2U3VBRVlwcW51?=
 =?utf-8?B?UTJ2a25YTjhNU1o3Nko2ZEZ4Ukp3LzFHdFdVVEVqUTQyNWFjRStuQVdPd3JT?=
 =?utf-8?B?SVRKeE4xd3kvcmYwS2tqaEZhdmcyTWJDZWNIbjVuZExDTlZSd1cyMnVKcW8y?=
 =?utf-8?B?Y0NKWjJIcTFuWUJ4V2ExUXZNSWx4QkZlMUhQV1phRTcrRWUrZmtrWWE4MkpQ?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c9ccc7-a940-4aa7-4c16-08dc48d0cc90
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 11:28:00.3556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqkDwGmaRV5Ie1MGxrQvmdOVMbmlZytheL+UrGQQHIwnLQpuVABCayyLmRhwve2m6BXyjSJ0H6iCVQDI35iwm43Jx65a3jeQOhH4JT9xu2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8091
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Mar 2024 11:28:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15384



On 3/19/24 7:33 PM, Jan Kiszka wrote:
> On 19.03.24 19:18, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows device which started on Debian 11 to continue using
>> clevis for encryption and decryption.
>>
> 
> Would an upgrade to systemd tooling be possible as well? Create a new
> key with systemd in the TPM and add that to dm-crypt container?

I need to try this. We need a passphrase to add additional keys. So we 
would need to store the passphrase for the encryption somewhere on the 
system. A possible solution would be to encrypt the passphrase with
the TPM chip and store it somewhere on the system.

Quirin
> 
> This is just out of the concern if we may have to maintain that clevis
> path forever.
> 
> Jan
> 
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .../initramfs-crypt-hook_0.1.bb                    | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>> index b275c0f..317ea12 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>> @@ -1,7 +1,7 @@
>>   #
>>   # CIP Core, generic profile
>>   #
>> -# Copyright (c) Siemens AG, 2020-2023
>> +# Copyright (c) Siemens AG, 2020-2024
>>   #
>>   # Authors:
>>   #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> @@ -17,7 +17,17 @@ CLEVIS_DEPEND = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools"
>>   
>>   DEBIAN_DEPENDS:append:buster = "${CLEVIS_DEPEND}, libgcc-7-dev"
>>   DEBIAN_DEPENDS:append:bullseye = "${CLEVIS_DEPEND}"
>> -DEBIAN_DEPENDS:append = ", systemd (>= 251) | clevis-tpm2"
>> +DEBIAN_DEPENDS:append = "${@encryption_dependency(d)}"
>> +
>> +def encryption_dependency(d):
>> +    crypt_backend = d.getVar('CRYPT_BACKEND')
>> +    if crypt_backend == 'clevis':
>> +        clevis_depends= d.getVar('CLEVIS_DEPEND')
>> +        return f"{clevis_depends}, clevis-tpm2"
>> +    elif crypt_backend == 'systemd':
>> +        return ", systemd (>= 251)"
>> +    else:
>> +        bb.error("unkown cryptbackend defined")
>>   
>>   CRYPT_BACKEND:buster = "clevis"
>>   CRYPT_BACKEND:bullseye = "clevis"
> 

