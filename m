Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4739.1794383101097370304
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Nov 2026 23:45:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jxepSUbZ;
 spf=pass (domain: siemens.com, ip: 52.101.69.71, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJRDyFGB2v1VOqRR47Glj3wIuvtPCzNZ0LL2M2nEBC3eMEtmbeJkq4TgUqWQQCOxPTVdN9ZOS/X+BrvWKsfnwWlnVIoG5Sq2W7Vou5sibW0La0N2r92vq/DF+rkcydaviHwJgacGlJBMwWLX4jpQgPl3xcRt4nBkDx1UyE7zwAJQgcprGyxjHBJZ6x3Rs7mURsb4jBhxpBvT8DITaLoyue2efvR9Ss2R695TJu7shuZUbHzgxqOGX7SSs3TjNBgj07j6pkPZ2s/tDaIkmR2vN9+4+6GboCSlLhTilauW0BTD+1Wd8JGOSmAy9pMGzq/qwDf8VxCtvQjW5B3E55na0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hu0/DSLSwx5sFiChWCeZqQni90iptN4NRihg0lIrMDg=;
 b=hYff2G6nIkarc2EZ00LzEmkmhczHTq7qhIx3hVvlQnSGol0MrtFPyzwGgn1Hd5wLwd83gzQ+8udbCdwVQoROW/VPk77AF2sKt9EP09/SVGnePTOEpK42DoILAUkF4gZNvVotcy2l6ZQ3jQZ7ypUwTL9ADZnEMPlPw0WVbjmbZDlAmwyqMnHtb4/1wp2ZkWdB0LjshFHGoJA77QnTJ/tqsLkhaHXAXNA25+7Ctt++LwlGaHSDe/+a6eGNhVWiWYedJxiYnnejnAtlawCRmHoeeVQbJXlb+iyY2z1PwB0hQ7OhnUujEbMvFp3jE0JJtAuDUj+YX1i5X1IBedFMPPEkbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu0/DSLSwx5sFiChWCeZqQni90iptN4NRihg0lIrMDg=;
 b=jxepSUbZWeKQiCP5HRMv69akt1mZTOiITuR0AyNRgzqprmiXmGGpSlear7uf4zlNEC+6zhdTgEL2t8+aWSzwNxP9xE0eaAxaUBEoT/1re0UHlynBfMBkF90CnlC1yzdibY0BcEfZn9wHUH/hPB6cw8lb7Iq9U3ji9hcF98DTRCE92vf4luWelhy7FRlodawNSimeFF+fe2hV00Ejehmm7jMXXg5xpmjjc9FvAI+ffBwLPGaxuenvwiE1YWGXo72qESuswTwjgUkDgOuGXRgWW8+ElaJ4AWCwxL07CSbJavc4gEOBLYvGeJdJ+h5UJ26HY+O7LynNK+1DGUlsdKXnLQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS2PR10MB7576.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:547::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:44:56 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 07:44:56 +0000
Message-ID: <84a4c55f-9786-49b9-bd16-42a9ae3dd0ec@siemens.com>
Date: Wed, 11 Nov 2026 08:44:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 03/12] wic: select the A/B
 rootfs image via WIC_ROOTFS_IMAGE_TYPE
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
 <20261019102541.672620-4-quirin.gylstorff@siemens.com>
 <edeedc71-4d4f-4f96-84d5-1d9e7313148c@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <edeedc71-4d4f-4f96-84d5-1d9e7313148c@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0406.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::11) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS2PR10MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: cc002793-33a7-434c-fb8c-08df3fc7adf9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|11063799006|56012099006|4143699003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261022115727099003|261026121527099003|261102123227099003|261021121427099003|261028144727099003|55112099003|18002099003|22082099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: sSRYs7SJrYYJNW99dtrKra3PRK0lWf2jiRkA3La+hFaF2x1LhZxykToaroF/wfKi57IuapMuahtqrFb6PekWN7qoYxbgsBTd54vqbF9rzBAUDl9vxZ6duYAyPiC8XVZaWwUiWxFa4NDwqGNx+KYHUx8rtbjWaycGY8lNMYFXOZB5RUMBMR05CBvRnQQWaziTlj9IdGMyeYh7BkPYHnfaZY7NAYNL8mLgW98IlY2bxcxh7XfYbAhcNK50zG9pqCAgsFR92ljFAduOThoURfzsbhKV5FBvvO0CX/HN0LizGB/1bfLIYMpxPU/OU7XZow3u/UK1BJ/GuMK0A5F24B+q7MsbFhLeEQ4bH5UmPOPbTehcaQBoyUcJSFR63fv+HdffSQJaWf50bpwvSno5rehsUGqaszXpxgmofihLwsMVwzmt2xig8xI+8tgZSX1sjrRwSVLyu5nlisLPEnPPTha3Usjae7Zx21vrOHHJb3B1jg6vbxjch+h2QO0hrXqyvTCccwk5YAdwBEVV+g+1xhz6EvkP/YeOoXvKNuwSq4l2wPjrsw6pvrPGIeg1/T0fuetWBit2oWkQ79datyRqPC+Vvry4Sd4ZbeqsrU7bsCvJ96UM9xzapiDXOMQvON0b33r2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(56012099006)(4143699003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261022115727099003)(261026121527099003)(261102123227099003)(261021121427099003)(261028144727099003)(55112099003)(18002099003)(22082099003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG5NZC9hTkNSMVRzZlhrelZDN2xNWGFaSEp4OTFjSy9vZVUxajkxZ3JSeXlK?=
 =?utf-8?B?bFBpc0EzR3h0NTI2V2padW9NcjUxVzJvRmdYTlhFcjNEaUdSRHlWTWI4VHFi?=
 =?utf-8?B?RmIxamEzZkJwZGFmOTNVVE81TkI5M0xvTFVzbVZGaGVHU282Q3o5U0VXMDlM?=
 =?utf-8?B?YWM3WE5Bc0lxTlZzNHRKMUd5UjJxSHYrR1BWZEJ2KzUrU0xpTjFLMjhpUUpV?=
 =?utf-8?B?YzlJZWRjUURBQllkVCsvWEVaQk13N3RRRk1UQTFxbzdPMm5LbURRMDNrYkEx?=
 =?utf-8?B?dy9FL29QZVRXNi85OXVmSURtYitUNklJdURvcFB2WGNsOHV6L1dmVXJpOHBz?=
 =?utf-8?B?Ukp3ckJaTEtZM0UwU1U4VDV6N09ZYVRjL3YxWHlXdnN6MFRHNVg3emFNWFhH?=
 =?utf-8?B?SC8xTVEzbmwrOGc1U3lJTkJjS2h6Q2VaQUZuT1VGUWNocUJ1TXcxbmk4cVNm?=
 =?utf-8?B?S2pmNHllUXJmRmk5TExWQWtRUTNUTVlPVUxtV2hQekF3a21MRFUwVmR3U1J6?=
 =?utf-8?B?QjMxQnIyOVZLeHQwZVlpKzZwa1ZLYWlRWUZpMG5HQkdHWldDOFY4MHYvcGti?=
 =?utf-8?B?VlJoT1E2ZTRCU2FxTEFsYVZNemhwWVBCY2FtNVVPUW9Kem1TeVN4K2xjYncy?=
 =?utf-8?B?aUdCT1VRZ2hSeW5FckF3RnhHMGVlU2UxejNjSnJXZzJPT3Rzc1c5a2JpYlhF?=
 =?utf-8?B?Z0gwa1pGcEgxRHZvQ1c5UjhiQjliQXptckRBRVAzbCtFRnJrcVY5OGcyaVhw?=
 =?utf-8?B?VjQ4VVVZRUV2Q0VKRm1oVFJOZXVaSVhxUG5zNlZjNFBpN2Nndm9Lbis4cW4v?=
 =?utf-8?B?RkQ4S2pKSXhES3B5SXo0Nml2NGdKYmY0VlJxcW5DdUpUVlpFUUtpUzJBYUov?=
 =?utf-8?B?NjRZeW9aSzJGZS95alpsSTdQbHhYU0V1NStCZWtnWFdWZGk2Q210V08zNlVU?=
 =?utf-8?B?ZVFpTVNBK2VaWER4dzJZbmZjNjZQdDREd3RzejRXRVN5M21ZbXRDN29VY3Rl?=
 =?utf-8?B?elVJR3NIdUdLUW9aSnh5bEZ2NUFPQU9NWjhjaVY3OXJZcDIwZktFNFM4ZmhE?=
 =?utf-8?B?d2tJbWtuSTBBU0M1Y0VwL0swTzhZc0VVSWdSUzFkbnViMkRTdFprQU1oWHpG?=
 =?utf-8?B?eU5kTWRBcFlXK1M2L0F0U3REbXkrY3UvbnpQV09VUFNVMW5YS1p4eU9YY3lu?=
 =?utf-8?B?NHltcVovcnFyZEhxZW05Q3EvMlNIYkIrcXRLVUdadk5FbWhXNFVWelZ4MmMy?=
 =?utf-8?B?U1hQSlBMTmFEQ1NDWGFKZStkcTNyaXJtZ25jZTgyUFpvL3g2OE03TmZOYldl?=
 =?utf-8?B?RWZzWDRyREM1dmdKNlpUSDVVU0tvMlpNZGNxeU95bXFCanc3MHN0UjROS2p4?=
 =?utf-8?B?ZzZqRkNPeXR5VUhJcmo4QlR6R2pGL1o3MHBNcTZ1MEVCcnNXbVRqbU5rNmFv?=
 =?utf-8?B?RHB0MWVmcE1wYXh1S2hFd0F1Q2J0Vi8rVUJrMVhaczc1UTIzN3hpMmRuMUR3?=
 =?utf-8?B?cm1qUHpiU3QxcER4NGVUVnpyUi95NHRqakk5bmpyTlZncE5aM0J6bGRNL3Za?=
 =?utf-8?B?REszdXY0Y2ZrU3JSV21uWFcwWDZHaXE2YVVGRTZTRTlXNG9pZnlSUkhGZmhX?=
 =?utf-8?B?Z3lJMElYcGM3d0UzTzRNUzdhVUVpenNRK2piWUZPTFdzeGExa1l5cUJDRkQw?=
 =?utf-8?B?UkVQQWk3aUtWV05UUnNtaU5SVkhVcGdhb3RkaFF4V0piYWIrazJZMzRnTXU0?=
 =?utf-8?B?SXErUXVuZlJ4cjFvNmtRbXp3MWx0ckl2Z2hvNW9UYmlOU2xKeVYzcUVpNk5Q?=
 =?utf-8?B?QWFvdERBQlBoeEN2clJoUy9sN0kzYXN2VjZlNEpDK1VPZzdpajl2TUs1dTU5?=
 =?utf-8?B?UXB6d3hWK2xZaytBSklpZEp1YmtDbTE5aDE2TUNvYXBGUUJESGtiZjc2RG9T?=
 =?utf-8?B?ZlVaWkNhZjBSenV6YVB2TzZKb1B5cFE4WGUzNi94MGdEd1hQU3FQbkh0ZFJJ?=
 =?utf-8?B?b2YzSnlmN1YxZWhwUlBjOHBxVnp6MkNPSWVieU50OEZ2VjEyUzdHQWNJSWUw?=
 =?utf-8?B?YU5ZOTVoajRyelVtdkNmNEVEckx1QTVXU1ZDK2ljdG12ZWNiYUZ5Y0hkSnp5?=
 =?utf-8?B?NGFSbzdzQTdUS0d5UGV5Z0hXRXk5elpEeS8vU3k1bDBMQ0c1QTFyeFNDWFBK?=
 =?utf-8?B?WnZLelplVnBjdXJRWjR0U2hyUmdyWXNsa3lsc281QVZzWUZva1hZOFNaazd4?=
 =?utf-8?B?ZEc3cW1JL2VOT3BxK3VlcXpEZDJzRU9NMWRYcm1zcFF1M2k3a2ZocDJDem9V?=
 =?utf-8?B?UjJoRVhYcEl1OUNRWDdDREhVcFNYMGhrNG9JWG41czI0d3ZPY2dzVGlxaitD?=
 =?utf-8?Q?Hjfnt66ooK+VLCjc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc002793-33a7-434c-fb8c-08df3fc7adf9
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:44:56.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +E/MTrlitYSTSilofyIRbKWcTcSR7cjpYbI0TJpNtvyyTzOHTePwOEWJASph4yuly66ljqfTaAJhP3kxwRApgfqrwiRXwwf5dw1Wefk8JZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7576
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 07:45:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24737



On 11/5/26 7:48 AM, Jan Kiszka wrote:
> On 19.10.26 12:25, Quirin Gylstorff wrote:
>> The efibootguard wks files take the rootfs image from
>> WIC_ROOTFS_IMAGE_TYPE, which is verity if RO_ROOTFS_VERITY is set and
>> RO_ROOTFS_TYPE otherwise. cip-core-initramfs installs the verity hook
>> via the new ro-rootfs-verity override instead of secureboot.
>>
> 
> Err, we still have both RO_ROOTFS_TYPE and RO_ROOTFS_VERITY? This really
> makes no sense. Please avoid the latter, it looks redundant.

We need two flags or variables to differ because verity consumes a 
rootfs.${RO_ROOTFS_TYPE} and changes only the file suffix. in theory 
there could even be a ext4 partition.

The only way we can avoid that variable would be to remove 
${RO_ROOTFS_TYPE} from the image and use a non coded variant but this is 
other than normal file systems are handled (.e.g. ext4).

Third way would be to look into a separate verity hash partition like in 
the uapi discoverable partion specification[1]. But that would be a 
redesign outside of this patchset.

Another separate patchset would be to move the partition creation and 
verity creation into a wic recipe. Which I don't like because it creates 
an additional wic plugin we need to maintain. The current approach was 
inspired by meta-security[2]

Quirin

[1]: 
https://uapi-group.org/specifications/specs/discoverable_partitions_specification/ 


[2]: 
https://git.yoctoproject.org/meta-security/tree/classes/dm-verity-img.bbclass


> 
> Jan
> 

