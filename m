Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1444BC3DA59
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 08:08:58 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.40])
 by mx.groups.io with SMTP id smtpd.web10.5774.1721117330826857585
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 01:08:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZrofRR08;
 spf=pass (domain: siemens.com, ip: 40.107.20.40, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=witkv4ef5KqWLoOBs4G9F3MomBrkYIf3yfkIx9qmhK6SvPiLeoU+p5DhuX/ilQdI4C0mvAh4eI8/ALOHvVGWjcAlh26yATpo4h0lUOZka7R+doYD+JSJYz82FtmAXusoM5RQnI662B5K/pWBmwlfl+iqIKaNzOlRvgbL9GodAzg88EWlaiM3n6aARCX+IL2OTMEvsMQD7e6BH+SOqGvgK7ZO90NXdqGT8lK+D8mwrpYFsAKnlRV/db1DnpYSLSE2m9/x4UJ2HMrYkDvR2tRHxVM/pR5alMk205NGQRYWF35dm90HVseXrkes951wHLFTCVEiGSyWWp19MSkyF0GkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJx5TQI5yNB2TLeFLORdqaak614jef0SMbLhlgW2r3E=;
 b=S8W2zlurqoSdpLAmjiyBl/j7NDAUTxwA2mBnI0M9Ahs8aEtNHD0JzDRxPqd7Kpcl9u4kY5sh2ovAkdEtWPmJmHD3grfXyXHecU9a73KIg0Ua04Ggp3UIXod07nfe+lB3y/pv56ya+l0ZZxfr1msfsv4Y8qrvqjNU/EIK7Wb07v/tEQoIzzTn8r8gj3fpScSxzWW3dFcSVTFKEJrLTSMli3Rq7KXT5wDzQF+CQs4aUYcxx954S4yv+hc/MyxDxdIOt54ad4QClBVLUm2CurJRvyGToqvleoEqyafzMN3HMiB7jyjKja6b0pm4Gbs7ZrPoKKMQypnX2MKAbjNXDWNoBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJx5TQI5yNB2TLeFLORdqaak614jef0SMbLhlgW2r3E=;
 b=ZrofRR08YVrqwyDNGOs0o+TuhElqLn9fbV2tWuF9xqjW0JEJnBlJyFlNAkOpD3uHKjWJeTGTKUezFy8XeJYTqjRsXrIZE/kuIdEe4liHzdAovVkg7eGqMxe5l9z2LPWj+jW/JKEkZWMmso1L+EFhmx9DRI1iUHoTvHmn9AJZidm7FgErYUZU7w9wmN8uESCZa38PBVKM9kxnWCKZADiMpXJmwQoScn51Qf6pT3QjrvFJopwJVNE8fOPMl264iDBumx254YLW9FjBTOu6YQ4O2WxXJyUEPY3c6Ak5TRdo64K3jb4lbPx5bUxl8KVVPpDbL9/t4Gx5uoaENzfLs7QZCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AM8PR10MB4082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1c9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 08:08:46 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.7784.013; Tue, 16 Jul 2024
 08:08:46 +0000
Message-ID: <ea872d1e-8af1-4bb2-84f3-728f611c79af@siemens.com>
Date: Tue, 16 Jul 2024 10:08:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] initramfs-crypt-hook: Allow speed-up of
 disk-reencryption
To: Stefan Koch <stefan-koch@siemens.com>, cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, christian.storm@siemens.com,
 michael.adler@siemens.com, simon.sudler@siemens.com
References: <20240715134630.1640160-1-stefan-koch@siemens.com>
 <20240715134630.1640160-3-stefan-koch@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <20240715134630.1640160-3-stefan-koch@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::15) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AM8PR10MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f6471f-903d-4de4-3b86-08dca56e844d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ejhhcVVJR3dDOWI0d1pjMHJteTVWR0ZEWnRLTGplT3ByeDlmcEoxUGcvblJq?=
 =?utf-8?B?N1J3cmdqbmtpZ09xZGhwTnhrMWZzQ3I5TndHcDNEUXUwYkRpejQ3MG9jV0Fp?=
 =?utf-8?B?QnJCZk1kaTRmUWNabFlkcVA1MVd3UnFLUlQ2aTBuYU5oWWttNVlvUDlBamNE?=
 =?utf-8?B?WGlTRk5WSnd5WFEwWlFuSjlWNUJ2c1BTUndWeU43THNmNEhXK2dUMG5JMDFH?=
 =?utf-8?B?dVF0cnE0N3BRUWdIRklvTjZKK3J3U2xpdFpVckVvQXpiMkJlQTBTRWhtKzVh?=
 =?utf-8?B?SGRpZnI4cll2Q3h0L2ZPb3pRb3pQTXNUeUE2L1NMM09WNVZxVUtSTVltbDhD?=
 =?utf-8?B?SkNiODZDV2FNQ1lyY2o1T3o3WWR4MjdlWDJ5WGhEek9jNTJkeDVHalc0V1RF?=
 =?utf-8?B?bDZQMnB4VjZjc0NqYWpCWVJmQXJCd29XUyt0VXhIZVp5TVVlbGJYMUJkNFpx?=
 =?utf-8?B?MFhtZ2tBNFd5dVM2MjN3ek5FanQvRVZOYSswUkE3MVJ3ZDlUSUNHS1dlYzZy?=
 =?utf-8?B?ZjJBYkhydzFhR1lXdHlXMzk3UHh3ZW9OUUtPekFnWmV2YUoyZ1FoYWdPK1Vn?=
 =?utf-8?B?a1FZck5JTklhbVFBWkRUV1AzK3BqYzI3UTdQcWFodFo4TmFCc2huc0FtNW5V?=
 =?utf-8?B?SFJ6WHhwSXJRSWtXVXp3SHFwSzVjSWpxaUhyVFlsS3d3dUJMQlVTdUJmUFBo?=
 =?utf-8?B?eEtiMEd2NCtCLzU1R084NW1ySmhYQXU1UlNQNEI5YmEvS3o4cGkrMGhlTGps?=
 =?utf-8?B?RVdHTWdSeWM4WlpOTEJPdTFjQ1FKTGJuMm1UZ2ZSc1BtOGNNbWdxNHVQREJM?=
 =?utf-8?B?eDVjbmpKMk1kdUNoTFo5OTRPZzZDdG82WWlFdHBRa0w5YnExQ3gvUWdCL25M?=
 =?utf-8?B?NVNock0wTXIwaTJRN0lVbDN3RnJXbHJSYlhSbW13QWJlaFo3ZHU5djlXdjly?=
 =?utf-8?B?UmwxdkNabk1qTzdhNGRtQWxibVByRlZjRzl4TDY5ckFKU2R5d0F1QisvbEd2?=
 =?utf-8?B?WVFCZUV4bEpvZTluK2UyTFIxN1grcWFRSWdPZk11Sm5ZUy9KQzAzbnJ0a0dk?=
 =?utf-8?B?QnhkNmg2cm5lalhDNWR2WVozN0JSaFZibERrU2pXaGd6dXVudkN0MjZ1VnFj?=
 =?utf-8?B?SWxIK1ExYlJwQWhxRWNKRUhXVndmcGpVdUVwdjdFdmZMeTB2eHQrejRuMlRk?=
 =?utf-8?B?SXloM0VoZ2xOQjFoWU4zOXdtR3Z4aTczR1d6QzNCQzVLWVk3aDF2WjJZak9M?=
 =?utf-8?B?NmdvcjFOL1J4Um8rQW9NTWpscmtxaVZGZDA2UGt0Tll5U0s2R0U2YS9hRkMy?=
 =?utf-8?B?eGZxQXVVTzl6WmxwaFJ0WkRCYS9vWTRMNXMwM2Nma1ViMjJtTHJSZlBGR1FL?=
 =?utf-8?B?T1ZYcEhsUTkvVVpJVEhqSnVmcURJS01vd3YwMkk0cnl4R0tTL2srY01DbFRZ?=
 =?utf-8?B?L0gwS09EQmR6Skh0cUpUeVlJSkIweTMvbjlGaUltcTZUZlVHRlJmaG95Ykk3?=
 =?utf-8?B?REJEVllBY0RweEJMRnpOOEg3QWVCbFBLbHNTckNXTGJxK1ZnSDBjTWc4QWJF?=
 =?utf-8?B?N011M0pVM0VYbWJVODJZdUdFbkhrb3lRc1BmQUpIdmxTOEttNGU1MlY2K21q?=
 =?utf-8?B?WVladGVUTG1yOEFjY1F5UjlEYUZCdFR1QzVHZjBkVnl4cTE3bGdNQ0k2eUxV?=
 =?utf-8?B?cGNiaUdtVVRxc0ZRTkRJRDdROW1meU9QMGFaZUV1b1ZrUXNkbDR5U09HNmpT?=
 =?utf-8?B?aHZhNG5YcHlNNlh6R0xUZG54TVpLMjA3MEZZdk1hem5OOUhybWM4bkhkT1JZ?=
 =?utf-8?B?QnhERFVZMWhOb0dHNlhPdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RVp6bHhZbG9iVmJ0L2gvNnhaUGl4Zk52ZmVQbUkwNzBKSHFIeEFRWXMyakNq?=
 =?utf-8?B?RlBUOFZUaUUrOUpNOENUTkVWOFhkK0o2MmJjNUpYbzZNdmRmaGY2TjJSUmt2?=
 =?utf-8?B?cThsRVFBVnl6NTl5Z1RoSTRjSlFXMjhqQTZIdW9tNDhYWHJORGxvUWJESndx?=
 =?utf-8?B?RDZCUE5YVk5aVXc2YVlQNFJLc0QvWEN6UjhQdCs4dU83d0ozVmdLK1p6Z1k5?=
 =?utf-8?B?b05IdmhhOTB5Y0Z0OW1hYjB6Z29TTnFQc2xEQWRlZFJ4RTVZenN0WGlEVVli?=
 =?utf-8?B?cW1ZWmdSYk1keDVWblNHUE5UbmF4VTdxaTZmNGZ6ajMwSFhLQ01FdmdkZE1V?=
 =?utf-8?B?RGRRQkpKSHBldVorRURlUTFtVEZWTzUyWUNyTkVQM3NkYmdZTWQxZkFGNDVS?=
 =?utf-8?B?ejE1UFVaaW1Eb0MvOTRzODg1TG1kVU83UjBJYVc3aTZGT3ZuOCs4cjBTNnF1?=
 =?utf-8?B?TU1oOFU1Tkt6QzMwcjg3L1dYRDhMaVVLMjZFb2pvTlZGeFQzbzhYK2tVL2Yx?=
 =?utf-8?B?UHJDcVRieko0UEcvdVp6K2dSNnpLR3JKWEhSZXVZWVpxZTg5YjI1b1EyNjVN?=
 =?utf-8?B?b1pVVjdtU2p2YVBGK2MyZHRlS1ExNnJOVWF1d3RJYnJxWkplQ21GakV2Tkl1?=
 =?utf-8?B?UTFlcGdtbFM4MVREeDZCT2pHeU1TL1BGeGdObzBMV0xFSjN3OWxGb0pHWXJy?=
 =?utf-8?B?WVU5aWJKRHFHKzNqQURYTzdreUkxQjFSOVRPWXdWVmxVNUs2RlZaUVNPVG9t?=
 =?utf-8?B?ODFzWFQ4NHlGY3V2UXJFUVV0TWgrSUpyaDFwN2NOSmczT04zL1ZQSWRFQTlu?=
 =?utf-8?B?UE1BZCtwYlVlUllFWkpYMko3ZldGNFJ2WkRxRm5uSW9BZU53Y3JwblcwV21o?=
 =?utf-8?B?dVZ3cjQ3Yk5wWkNsc2FGQmRXclg1UytmMG8yZWdLVmF2NUVrdHBNMitIek9V?=
 =?utf-8?B?MEVmRlBwdkd3VFVGV3R0NklUQllxV1hlbDJYWnhnVTlwNWVabVRZc0wzTUZP?=
 =?utf-8?B?ZWE2K3ZWR3plYlVqaExRcTIxTVN2bmNHWjEwdkZldDd6OEE4c1FabzE4dFN1?=
 =?utf-8?B?aWhaYzNIbVZ4cTJDL0w5cllXazh2UUFDc2xHdHZpc0xLSkpQOGZQVTZMT1Vr?=
 =?utf-8?B?ZTk1cnFQTERkSUhVRStudXdrVWpaTlFBVXlOTzhNSGdwVnc2MUxoWlFscTJi?=
 =?utf-8?B?eHFMODYrQnV3RHIycG1ybDBqbXlQWmhUK3lZWkxiL2FXZUJCNVdVWDVqeXFu?=
 =?utf-8?B?OW9pblM3UjVtc2hlUlJHb0VZSDRqZFBGTXhWL1g5RTBzaVlSdkJETjV6YUp3?=
 =?utf-8?B?a29oek9JUUtqNlc5cklzcWtrS3VIQVVMVlJRMnI5MzduRVBCM291Qm5NNGp4?=
 =?utf-8?B?NUJQbHM5L3JtMXpqUmVlUUVVV0F3Q0pTWitkLzBHZUFHZnNsV1I4SHZaT01G?=
 =?utf-8?B?VmQycEVZNld1eklMakEwc2FWYkNtNEFWK2Q0bEhJcVErejJZdXJpbzBsbFF2?=
 =?utf-8?B?SHVvWXpSdWNYVCtrTjhqZXpwMHdyd1RvaVJxWVBjMk1icEJZUFcvV0tQMWJU?=
 =?utf-8?B?QWxhNlM4WGZQNmFnQk1yMGR0UzRrTlJNemNESjF2b1ZzRzhQMWtHZHN0cURB?=
 =?utf-8?B?WHdxbHAyNVBYK0ZmZ0g2Yk5rZ2JMUWZLMFFMM0RzUXBwVGd5NHVST0kvdmFk?=
 =?utf-8?B?eTAxOW4wVnFVaVhoQ0xMbndVdEtIZENvRTczaW8zdnVqNWJWV3pDbzZ1V1Zi?=
 =?utf-8?B?U3YvaTltTE1OaEdCcTVyUFIxY09ndVFZNk4xNGtUYlNMRzVGYlpKWHY5NmJV?=
 =?utf-8?B?MHJwSWVZbGhqbXpvSWpXUlBlRW43RzhoNmpXaWJzZHJzS2RkMkxXWlpIczV5?=
 =?utf-8?B?amRUVFBuSm1obkNPcTFPWlF5a0lodm4zZXVPWWtFQzQ3MVRCblBxRDVFdnVD?=
 =?utf-8?B?am9OZjBKMmxDRDRaYlpBTjlLbDJOZUY2OWwwaDFYcjZhWWxBSml2ZFlxUWFa?=
 =?utf-8?B?RlczcTQ1SWxkTkZRK014UjRaMTJ1OE5ieFplTHFsZU1MWGFHMlVOMXJxTGtG?=
 =?utf-8?B?RGxocXhEdXh3RmUwbWxlSG0wVmhVbldmU1dwQXFDMTlvN2UrRXAvT1J6LzlC?=
 =?utf-8?B?bnJiUzhub3NUYTF4NTUzUnozYU9BVFpIcW5LcDNXYUdKMGh2SlpaVmwyejdp?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f6471f-903d-4de4-3b86-08dca56e844d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 08:08:46.5337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlACqg8+LFfHRst+VklcHXvv+MSsCr7ER7DpGPQ62NXIBu1AL9y+xWxBu43BVnuiTQLTXzwK3Ulr7W6LwH3Wc6Ek7SdWKg9z/mc/XljYBMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4082
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 08:08:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16524



On 7/15/24 3:46 PM, Stefan Koch wrote:
> As the reencrypt mechanism doesn't work at file system level
> so it wouldn't detect used and free blocks.
> This means that the block-wise reencryption process could
> take a very long time depending on the partition size.
> 
> Using the format mechanism instead of the reencrypt one
> would delete all existing data (without wiping). This would be very fast,
> because it doesn't matter whether a block is used or free.
> 
> Set CRYPT_FAST_REENCRYPTION to "1" to speed-up the reencrypt process.
> So, this would be done:
> - Obtain used space of the unencrypted userdata partition
> - Shrink the partition and resize it to the size of used space (minimum size)
> - reencrypt the userdata partition now with smaller size
> - Expand the encrypted userdata partition back to the maximum possible size

Why not simple use expand-on-first-boot. It has support for encrypted 
disks and does this without adding something to the initramfs?
Quirin
> 
> Some disk encryption implementations like within the Debian installer
> will overwrite the entire partition with random data for security reasons
> (e.g. wiping old already deleted data, hiding metadata, etc.).
> 
> However, this speed-up lacks the described security benefit of implicit data overwrite.
> So for security reasons, it behaves identical to the format option
> (there is no support for explicit random overwrite within initramfs-crypt-hook).
> 
> Keep in mind that a power loss while reencryption will cause data loss
> (with or without fast reencryption).
> The key is only enrolled after fully succeeded reencryption, yet.
> So, no recovery from already encrypted data would be possible.
> 
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>   .../files/encrypt_partition.env.tmpl          |  1 +
>   .../files/encrypt_partition.script            | 53 ++++++++++++++++---
>   .../initramfs-crypt-hook_0.2.bb               |  8 +++
>   3 files changed, 55 insertions(+), 7 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> index bb93361..2b02f55 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> @@ -5,3 +5,4 @@ WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
>   HASH_TYPE="${CRYPT_HASH_TYPE}"
>   KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
>   ENCRYPTION_IS_OPTIONAL="${CRYPT_ENCRYPTION_OPTIONAL}"
> +FAST_REENCRYPTION="${CRYPT_FAST_REENCRYPTION}"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> index f943aea..7bb40c9 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> @@ -54,6 +54,9 @@ if [ -z "${create_file_system_cmd}" ]; then
>   	create_file_system_cmd="mke2fs -t ext4"
>   fi
>   
> +# Path to full (non-busybox) losetup binary
> +losetup_path="/usr/local/sbin/losetup"
> +
>   service_watchdog() {
>   	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
>   		printf '\0'
> @@ -62,13 +65,16 @@ service_watchdog() {
>   }
>   
>   reencrypt_existing_partition() {
> +	reencrypt_device="$1"
>   	part_size_blocks="$(cat /sys/class/block/"$(awk -v dev="$1" 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)"
> -	# reduce the filesystem and partition by 32M to fit the LUKS header
> +	part_size_in_kb="$(expr "$part_size_blocks" / 2)" # blocksize 512 byte
> +
>   	partition_fstype=$(get_fstype "${1}")
> +	# reduce the filesystem and partition by 32M to fit the LUKS header
>   	reduce_device_size=32768
> -	reduced_size="$(expr "$part_size_blocks" - 65536 )"
> -	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
> -	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
> +	reduce_device_size_blocks="$(expr "$reduce_device_size" \* 2)" # 512 byte blocks
> +	reduced_size="$(expr "$part_size_blocks" - "$reduce_device_size_blocks" )"
> +	reduced_size_in_kb="$(expr "$reduced_size" / 2)" # blocksize 512 byte
>   	case $partition_fstype in
>   	ext*)
>   		# reduce the filesystem and partition by 32M to fit the LUKS header
> @@ -84,9 +90,31 @@ EOF
>   		if ! cryptsetup luksUUID "$1" &> /dev/null; then
>   			e2fsck -p -f "$1"
>   		fi
> -		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
> +		# shrink partition temporarily to minimum
> +		min_size_fsblocks="$(resize2fs "$1" -P | awk -F ": " '{ print $2 }')"
> +		if [ "$FAST_REENCRYPTION" = "1" ] && loop_device="$("$losetup_path" -f)" && [ -n "$min_size_fsblocks" ]; then
> +			# set encrypted size for expanding step
> +			encrypted_size_in_kb="$reduced_size_in_kb"
> +			# minimum partition size
> +			min_size_in_kb="$(expr "$min_size_fsblocks" \* 4)" # blocksize 4096 byte
> +			# shrinked partition size (reduce_size + minimum partition size)
> +			reduced_size_in_kb="$(expr "$reduce_device_size" + "$min_size_in_kb")"
> +			# set loop device as reencrypt device
> +			reencrypt_device="$loop_device"
> +		else
> +			# continue with default reencryption in failure case
> +			FAST_REENCRYPTION="0"
> +		fi
> +
> +		if ! resize2fs "$1" "${reduced_size_in_kb}K"; then
>   			panic "reencryption of filesystem $1 cannot continue!"
>   		fi
> +
> +		if [ "$FAST_REENCRYPTION" = "1" ]; then
> +			# use temporarily loop device to simulate shrinked device
> +			# because cryptsetup uses device size at reducing
> +			"$losetup_path" --sizelimit "${reduced_size_in_kb}K" "$loop_device" "$1"
> +		fi
>   		;;
>   	squashfs|swap|"")
>   		[ "$debug" = "y" ] && echo "skip disk resize as it is not supported or unnecessary for fstype: '$partition_fstype'"
> @@ -96,9 +124,14 @@ EOF
>   		;;
>   	esac
>   	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
> -		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
> +		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$reencrypt_device" < "$2"
>   	else
> -		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
> +		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$reencrypt_device" < "$2"
> +	fi
> +
> +	if [ "$FAST_REENCRYPTION" = "1" ]; then
> +		# remove temporarily loop device
> +		"$losetup_path" -d "$loop_device"
>   	fi
>   }
>   for candidate in /dev/tpm*; do
> @@ -182,6 +215,12 @@ for partition_set in $partition_sets; do
>   			reencrypt_existing_partition "$part_device" "$tmp_key"
>   			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
>   			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
> +			if [ "$FAST_REENCRYPTION" = "1" ]; then
> +				# expand encrypted partition to maximum
> +				/usr/sbin/cryptsetup resize "$decrypted_part"
> +				# expand filesystem within encrypted layer to maximum
> +				resize2fs "$decrypted_part" "${encrypted_size_in_kb}K"
> +			fi
>   			log_end_msg
>   		;;
>   		"format")
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> index 3497d95..e3dd515 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> @@ -57,6 +57,13 @@ CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
>   # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
>   # in a newly formatted LUKS Partition
>   CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
> +# Fast reencryption state
> +# It uses temporary partition resize,
> +# consider security and data reliablity aspects when enabling
> +# (e.g. wiping old already deleted data, hiding metadata, etc.)
> +# Keep in mind that a power loss while reencryption will cause data loss
> +# (with or without fast reencryption).
> +CRYPT_FAST_REENCRYPTION ??= "0"
>   # Timeout for creating / re-encrypting partitions on first boot
>   CRYPT_SETUP_TIMEOUT ??= "600"
>   # Watchdog to service during the initial setup of the crypto partitions
> @@ -68,6 +75,7 @@ CRYPT_ENCRYPTION_OPTIONAL ??= "false"
>   
>   TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
>       CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
> +    CRYPT_FAST_REENCRYPTION \
>       CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
>   TEMPLATE_FILES = "encrypt_partition.env.tmpl"
>   

