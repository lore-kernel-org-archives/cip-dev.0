Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D6FC2BA1A
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 11:13:19 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.76])
 by mx.groups.io with SMTP id smtpd.web11.70455.1718968392947940701
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Jun 2024 04:13:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LuO4xnmg;
 spf=pass (domain: siemens.com, ip: 40.107.22.76, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQ3ayjfcxz9ZLcPPY8L8QjH6LfxQcoR1xqxWLhkPLnzD9GntE7GPLgc7NTasBRuV68gKCEOpir45NXhEIEI0kEMnaCGg4iQ3rLL0IZEhJuAKXx4JStopbtBenl54HVgWAfC2YvUuElv3XNsFFtjZX+ZNwV0KQZpqjW6fbCpI1n2nmBoWtRUeR1qPkdPwtONqpuV3bEJBCG8dnlRLi3BQyby3SD7/1Nrzht6JzPNijVj0uSbsvbbgWn4kk64cziD+xPvdG5rgikHswSyit1gsWJQjS0mPp8WR5yhOfzCyjMzl6dvJjrCN2HLD9I7k/cTwcm4QqhszTts6pGyv9bilKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jssFcMO6MBY2fBdUYVUWwyYfYG2qAQIZGcFkubwYTvI=;
 b=fh/1A7excLxe8MU4T8wIeDM54Xb1K+ihXlFsVom9YV3DbP9kUmcFlbMz8kzGxcOWP9+iMDjTDBkUrSicR8K5dLlUlLHpxyaBQwmSKF8xQKJwRHha8/+k2PCfVFJga5MSLi2hKNsuo8xZYc0qKkjR6Y2aXKKPyt0bVfy7xYRFQ6njl8mwE2DEGog+U8CIpchPn4yQ8Kz4i2/R/sAQq8I51XKeTDM9CbDM/cGPK+SR/9mF+pyWZLfd52IYV3lCxWwa0KJQqEFWI5uTCxOTCxOBvOO/s/9XB+GB+LHnYRQTRnB8If28noGZD3DkZWURkFo5aJwTo+nZh8iTyP/p68MRUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jssFcMO6MBY2fBdUYVUWwyYfYG2qAQIZGcFkubwYTvI=;
 b=LuO4xnmg5oorZs66u/CyW5TFkOvrwvkxBQ6VcRQcS/P+7fI7k8+JQyJWfrtDfmtvrERwAs/NKv8pS7Vo7Metm/CeQUgZDRoKf0+zVP2O6rjZ3dxK3WwYQWgbxTKxQ/Nfd68XhcuK3sYSpe4d6YEok9zm4+WrJoYAmArVTrD9Vjkw1RBE+j4KjSTLNsHcE5gF3t0KR66ocV8cG33zplSlKdRO+oabXXaj6Afi1jcsfNteXHvqc0774D0U+lKLN2Tdh7fGolExRgHEoPzXcXX+qTSaR/0KlsOgeYAgWYRC2mWnv3awze+THwjqBqhBHx6VYCYPl5rcLWJugDGzkPQwSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6843.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 11:13:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 11:13:10 +0000
Message-ID: <0244d433-11d0-40cc-a843-06f00711397b@siemens.com>
Date: Fri, 21 Jun 2024 13:13:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/2] encryption: assume
 broken_system_clock for e2fsck before resize
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240621105215.2233044-1-Quirin.Gylstorff@siemens.com>
 <20240621105215.2233044-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240621105215.2233044-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: db0f1a2a-5dc5-48ec-a60e-08dc91e3226c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZS82T3ZXTGJjbTBiNnJoNTVzTzVhZXExbkF5VVlRcVN4bzA3LzJBM2FzWTBW?=
 =?utf-8?B?NmtsSXVEdmM2Q1JCOHZGQXhGWXYzaHU5WHRVTktUZW9UQktLWFBqek03MU5V?=
 =?utf-8?B?dlJJdGN2TVZVVkJGelZESTlOamsyUFpHemMxUG1UTXd0NXRFWFRhcVdkWm5i?=
 =?utf-8?B?b01GYTRJNTNEbjAwZStlaEFvbnprRFJ3VzE1M0YzaGkwMXJGdU5LYnBzT01L?=
 =?utf-8?B?R1ZOR29Jd3FuSW83QzJEMkw2SW1TY2ZXV3lYVlpkelp6SHFvQWhaRWtZdmlY?=
 =?utf-8?B?QjA3cEJsWVRVbldsL2xCbkhXN1d0T0NiOWNRd3Z5VzhEbDBXZld0cUpFUzlZ?=
 =?utf-8?B?UW03UmRGeFZIcUhOcjZ5VFpnRGc4RG02N0lHc0RWYm1vZWhHcE9DbDdDa0tx?=
 =?utf-8?B?V2tnZzZQRDhNblFId2ZGdzlZVFJzN1lheVZRN29xR1JzM0UzL2hjUnVaRk1E?=
 =?utf-8?B?K2E5L3M5SlExWi94VkFHT0lOV1kvRXhiL3lNZmhUaVR0SVg1S1lmS2c5RnY3?=
 =?utf-8?B?SWh0QTNVS2RXc1E2bVZTR05uaHZ3NWh6UG9TeVJEWkZZVHBiSW5uQ0pDUW52?=
 =?utf-8?B?c0NTSm0vYlRiK01xS1FhT0JCc0I3a2RiWmpEd2hvRktHMlFJakoyVHp4Mmd1?=
 =?utf-8?B?cTArUitUTFd2M2JPNmF0dnB5MXF2eUJKQytPZ1JYQ2ZsSm9vek9NeEw0bkFr?=
 =?utf-8?B?SVRFck8yRGpLTW1uT0tFWWx2Z2Q1aTBRWDZ4YW9ycGduNUJFaCtHbmV0bU1K?=
 =?utf-8?B?U29vRGRqZTUzMW94UGpOTWtSamkwclY2RWVNSVVaWlM5bnpyVEhoWE9GMXA3?=
 =?utf-8?B?N3VreHZvZTJ5OWJTUTBqdXExa3FUd0ROZTJjRngwZzlLdFZmWjF1dHg1cFJR?=
 =?utf-8?B?ekh0Q0paUCttZmdqdmQ2M2RQMGlWek42RUtlWHNaMng0bEM0MTR0YTcrQWs5?=
 =?utf-8?B?dEhRbGdvSnY0WTc3L3ovQWxQa0FkSml2NFBueVpPY3lSQndjV3kxU2RFcUFt?=
 =?utf-8?B?Q1ZLa3NwVHlHQXY1T1ZZUDlubUw3MDBGYTZuUFlZY2tXOVl3dG1LUnNjQ3BG?=
 =?utf-8?B?eTBFb2dRSlUxMC81SFM1Rmpxck1sRHJQejlxVmx3TjhNc3plQTNvOXdqMU1p?=
 =?utf-8?B?L284RzVXREhBTlV5UUFjUHNCajdzR1ZvOHdXcUFjOWMyK1ExbWxnNzZjS3Q3?=
 =?utf-8?B?NkdmY0pkRVhzdVpUTCtXNkphQWZsa011QUh1cVVMMHdVWmcwN2NIVnNpdHJT?=
 =?utf-8?B?RjlmMi9KbG9xZ2NNbFBKVVN0Smd0Q3JXMlhFQkVoTWFXWk5MdWN3ZERwS3hN?=
 =?utf-8?B?MmVYWUxxS3hQRlpYNlg4RGQrQXNSaHk1bUhKbmtzR0dacnF5UndxTzhRKzEx?=
 =?utf-8?B?NjJrejIrc3R6dEhFOGtMdEw0ZnhkQ3ZMWDM5OUN2Zko1NitsTkx4dWFKTzAz?=
 =?utf-8?B?ZGRydWJtWUthYzlobFJpblArVFA4b0Z5akwvd0tyRkZIN1dLSHlDSEkyYm9N?=
 =?utf-8?B?YTFqbURjL0kxVUlqdG93aG1EN2xUQ0xyUEg5bzM1OGVQaXRzcWYra2pjQ0Vx?=
 =?utf-8?B?MEh5MUZ6QUE4WFVKM1dBY0UxVS9ieHp0OVVqQ2lZVXVFQ2JONGJnV2lJcjU0?=
 =?utf-8?B?amJYM091dkFXcCswOU5PN043VDI2S0VaM1A2bER2NVFDZmV6QWFGOXpQNGI0?=
 =?utf-8?B?YVJVL3NmWm5aaEUrVE1Fc2ZrWmptS1ZzMnNrQ1F1OEZaK0VPMExIYjMrK3hy?=
 =?utf-8?Q?RKmAeNsQKUDa2ehiumxoIP6ambffMEpk3f09eqL?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YkJVYmV4YmVhVTJ1WkE0WDZuRkpnYlMrV2k2cCtsaHRiSGRWU0lRU0RjQkhw?=
 =?utf-8?B?enN5b3Z6eTNxUlFmME1BbHF2ZVBQSkNMNUozL3o1eXdaWk1tQnhoaU9naUJT?=
 =?utf-8?B?NW8vTGdrL29qTVprMjlTc3dObTd1Y1FEWHl6M1VkKzVhOWhRSmFZbU1jeUZY?=
 =?utf-8?B?YUtVTzVJaDNoZ09MYlhQdkZFYjdWOTNHNnJOeHhCemNmY2g2WjFzRDdFUEha?=
 =?utf-8?B?R1g4cGgxYlpGOVA5czV3SUs0cHRhdlJIR1dLa3BUbC9VY3Z0Z2prTzcvT25y?=
 =?utf-8?B?RTlHQTlVMVFLM1FyT0NCNEoyTmZINGlYc2xGK3J5c01FcStXTjZqUE1DTkVB?=
 =?utf-8?B?OTJHZmlBcy9kalgvdHBoTWZyYUVzUUdzUEdjcnBtNElQendSSkdKSjhtUGRU?=
 =?utf-8?B?SFRSSUJpb1VZaFhCT3I5ejJUeFRXM2tXYlZkSFUwem5zcjc0VFNCTUlDSU5t?=
 =?utf-8?B?Ylg3d1hnb3NRYkZmWWExWDladDNPMzNNSUVFVFJ0UUxFVy9uUnJVZUdmU01s?=
 =?utf-8?B?d1pFOUdRVzByNWpZRFlheW9OYTVGSit0aUNVcTh4eUVMRFZNYTFTTWFHK1k5?=
 =?utf-8?B?NmU2SzNocVM2TS9LdVdkSWNmQ042dDA4WUxvM1ZDUCtTTmhGVGdhS2ZWNnor?=
 =?utf-8?B?V2ZnL1FyaWc0SUQ0Z3lWTTJGSFlkYTZXdjBwYkloVWJSZG9zcHppZ3V4TTVY?=
 =?utf-8?B?VXdjdVJZY3JCK3RqTVBJNE1CaS9BdjRwZUxUSm1rUWplVlRHdnZEbFRHaVhG?=
 =?utf-8?B?cUVPYk5Ba2pjSGFUSzJBeG1CNk1lRGJRbWgwTWdVblBvYXU3T2lIeXErNGlP?=
 =?utf-8?B?b1dtQmFkL3VGcE1rMytOR3ZEckhFdGI1KzhrVkNyc0hSNEhWYnpQekpJYXRM?=
 =?utf-8?B?NFB6Ymt5UStDK0tSdTg3cUFLeDJrK2xna3locU1UR3FxMTduS1dnUVFqaDZo?=
 =?utf-8?B?b0QvMXR5dnYxTGJndkV3ZXB6NTZhSE1obkduNkJoY3k1OVRObXhjb21EaDZQ?=
 =?utf-8?B?TXJES094azF0Mk5QdzIwa2gxY1FaQTdoM3pVSThvZFVGbXE5ZHJvMUQxekFO?=
 =?utf-8?B?QVo0c09tYk02N2RHVzVvV2xVUjdDWlhxckp5UUNXSk56NDlxTXJRdit1MWNw?=
 =?utf-8?B?M0lMaTBvWXlkZkgzRHhpQ0hOK28yKy9KaFh0VENwSGw1WTJEc3l6ZmxsWlpj?=
 =?utf-8?B?UE1VcUYzS01CT2ZDWlUxMEduRWpZc0RtQVV5dFZaTVpESnJjdGlIaW93ZGxO?=
 =?utf-8?B?S2ZjS1hrV3VVRFcrN0FZMmtvRitNUGxSdFZUQmFsaFdwTmpoYUpZVjJ1MTNs?=
 =?utf-8?B?a0twMm9YYjc0WnRJNjFoKzdkL0hEM3dhOXBHMHlZMjVRL3JWc1dQZ3V5S1RW?=
 =?utf-8?B?QnlNb2pyZGxmREpCcU5zQkNKYVNEUnJ0Ujk4KzRXS3hBZy9NQ3hkWmhtdUFx?=
 =?utf-8?B?SnA2OWhEc0tVRVhJeGZBWkJVTkxxaTg1dlltVEpjWjhKQkFmbzhZTGVnb0J4?=
 =?utf-8?B?RHNlUzVib3dURlBHK0tKMkRLeU5vUHF3dUFZWDZHZU5jY2R4R3E1M1BoRndj?=
 =?utf-8?B?VmRSbzNLckFpNU9FbzFMWEZYUmp1VVRsSTZVNk9XSytYaldwM1BiRnBUa3pJ?=
 =?utf-8?B?VHhEWjhMeHFwcHg5ZkFCN0lxZW03WTdIRjlXNG8vTGhOMWdObXU3aXdQaXcr?=
 =?utf-8?B?SE82SW0rc3IrNmFqTlVIRVJoVFdITFh4ZUJEK0VlWm9XQ2o3eUZmeGpXLzBF?=
 =?utf-8?B?WVFuRWZDcVpNcFRJV3o1NytzcWt5ZXpxQzRqMWJTdisxZm9Sc3IyMVNYRlhp?=
 =?utf-8?B?bWZCOC84VzhzNkordmM4TGJhamV4cHI3S1R6d2ZraHNCSEdqSlVla3BUYnB1?=
 =?utf-8?B?MHdHUzBBNk5oKyt3bURWZk1Pc2R2RmFuUWlreWNFWUN0U2UwYkZBK1ExMEhC?=
 =?utf-8?B?aHhxNTFIc2NFeWJFeWg5K1JPbTN6dHJaNWhkd0pvNHpFQmZVaEhxSUo3K0xC?=
 =?utf-8?B?d3U2aU9KaVlWellaeFpjSG5semVlYTV3UUZRU1dpMWVSV3pORmZ3ODluZ2hZ?=
 =?utf-8?B?VWNoTStuZDF2NFo2Tkhnc3NEY1lzTXpFOEZiSnlRTWNocnFkR3p1cnc3akYy?=
 =?utf-8?B?NFFoWHk2UkpRSHZrcnFNUUpGYW44MDdmK2xCTzM0SHFwRjBtOThabFlVOHd6?=
 =?utf-8?B?enc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0f1a2a-5dc5-48ec-a60e-08dc91e3226c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 11:13:10.1747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGqIVUa467aj9NqYdPhOPthOr8mEiHYDxA/L+kAsCFtxzqMHDnkahyW4nHnXtpYQ7vqqAJCBlRLCU8vnhVXx2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6843
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Jun 2024 11:13:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16317

On 21.06.24 12:12, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Some embedded system have no battery and default to some time to
> avoid an fsck error do to a superblock in the future.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/encrypt_partition.script    | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> index c319540..ff4c135 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> @@ -72,7 +72,12 @@ reencrypt_existing_partition() {
>  	case $partition_fstype in
>  	ext*)
>  		# reduce the filesystem and partition by 32M to fit the LUKS header
> -		e2fsck -f "$1"
> +		export E2FSCK_CONFIG=/tmp/e2fsck.conf
> +		cat > "$E2FSCK_CONFIG" << EOF
> +[options]
> +	broken_system_clock=true
> +EOF
> +		e2fsck -p -f "$1"
>  		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
>  			panic "reencryption of filesystem $1 cannot continue!"
>  		fi

Thanks, applied this one already.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


