Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321A8CA0FE8
	for <webhook@archiver.kernel.org>; Sun, 31 Aug 2025 13:10:43 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.50])
 by mx.groups.io with SMTP id smtpd.web10.28899.1756645838446965123
 for <cip-dev@lists.cip-project.org>;
 Sun, 31 Aug 2025 06:10:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=V66KsCOQ;
 spf=pass (domain: siemens.com, ip: 52.101.83.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usg4sWBs5TASmSsIzdIn2DKPD5I+YS4HFMlmQOwxIoz0q+TUbXFJU0pyDzyoNC4+QLR3axfjyH3Lk3CyyHMlumaPjZqiA1ZXaGvvOx/K7NP7kVmxqoQUKygcdjBNDd5yj0d3Bc8llkrR0fR0Dw2uonutdSHifi1ASlw4X0moSmrri0hdsg9RzbzFzlWCUR6IGtJww4mNuDdXb9wgDVNJUGvOdfZVTzBN5KSF03DX+dIWnMtZM5jIvaSrBE74uVPRFUe1K8maz473eKC2wJvS3n15NRq4PRQhVAxBB3DSBK7sO6bDNWaKeAA0+IR7gPc/JgxcjRuzUGH2p1OTw2Qw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARilepxErv211FWdfQT3qdfBy3Bg1pjqUobAU1UHRdo=;
 b=Xc3Iu13oWY4v2vK6EQPIfu80rSY7ProMYzZI0WYjRbviiS7+YVv6TYqjuTYMK6Nt6rf9TMFwnkxZ6vz84HSc0Uc0xHdTHxbV9OixvqdeasZVKl/ZbXVg3dALY/H+YsVzeFnNRkdscjkiKz6q4uhmNd45h2stspRd8uFl5vyLsuKshYxBztZe6nFyMZk0hdE4CwX2Dx8eGCsDQv6LSp7yA3EpQguLvKQjbbSqdyu7HPEreOiQHBwrmBZfmP6152Eot/rdUONxVEPNyEPen2VRTpL5hgf7/BZ0+alTm9uHYIjr4YvAn6kbteu2L5rBerZc1NktMDXao2vR/tmmXvgYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARilepxErv211FWdfQT3qdfBy3Bg1pjqUobAU1UHRdo=;
 b=V66KsCOQBEYLXhYVCAhTE1mj+DOvsws7uJ9aRl5whQJhpKyWTcPHWFFpAbHnYT0AVzEc5selz10/ncuFPNZu2cCMBJtwrrCl//m1LjiFxCip15gjOR6qae4Q34KoSvax0XcsjCYGfKWFi+YsvO3JcFzdP5cK2enphe8joMH31AZ2GLKEyNfClWMWBjqeZM/jR+uElYdH7evUKrxUfxeYAy6X2e++F9EdnMh+/xO4g73IUslCqIbAI5YAM9Ov9ZiWAKmrqfErIeT8VKl3gdyXIaQWq2yZQ2W/DgDeuNlpaJ4Ikqu75thKfF53ue1U4jQUufDEee7+14P+KOQV/mav8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3255.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Sun, 31 Aug
 2025 13:10:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9073.021; Sun, 31 Aug 2025
 13:10:34 +0000
Message-ID: <ccd932f7-27e7-48fa-b0b6-5e19881a8f8b@siemens.com>
Date: Sun, 31 Aug 2025 15:10:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 2/7] Add factory-reset
 initramfs hook
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, gokhan.cetin@siemens.com
References: <20250828110712.392641-1-Quirin.Gylstorff@siemens.com>
 <20250828110712.392641-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250828110712.392641-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3255:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4715bd-2ed4-4ef9-9574-08dde88fc4fe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dG5IcDBtdGxnbnZlaUZUZFpMbWw3T2ppZ2VsNWQ3S1ZmUmszTEc3d3N0T3pi?=
 =?utf-8?B?MVRQZThuL3c3QUpzR210Ty82anBuaTBhTzIxNklBcW5GLzhuZkZQdTBLdnBO?=
 =?utf-8?B?Y21qK3pwdnk5cXVHR1dZRXZ2TjJ5N3BGRFNSNnlSdmFiRlBmWFltelV5NjBF?=
 =?utf-8?B?L21hZlZublVZQi9YdzFTb2VRcE91MFpBNFhjb2huTFNNQWY0cVdNeDhrM3kx?=
 =?utf-8?B?aHBrZjg3RE1wNWdkV0VJSTcydkdBUzlSNW1BZnRoRFhLdjNIWjVudGtlanJE?=
 =?utf-8?B?UjBmSGthaGtHaitoaHZHQ2VibFZuQjdTQUdtbzBiR3hnWU9QT2x6OERwamtQ?=
 =?utf-8?B?dG8wcm5JREs1cm1EZWhGTThRVFBXcG44WXdxaUg5K1d6ZGY4UFRxbmk4Tkh5?=
 =?utf-8?B?TUtMMVFjMEZGQ1EyRlZSZXdnY1hpRWFja3A0WVZhQ1BENDhJNmpyd25JYlVJ?=
 =?utf-8?B?U2xmaVFNTk5XbExpckFTRG50Ulc5TURUdFBDQVhib0gvMnpnUEJyN3llOHJR?=
 =?utf-8?B?VnVvWURaamVaemlubUQ5YnRySTRBVmdFWnN5LzhXT2Z0RDM1RFpCZTBHZGdI?=
 =?utf-8?B?Y0VqRkNLcWFlNXZFdEk4aVU4VEpOUlVUb3NVaTZHYVg3RHVEZ1ZnbUZFV2Zu?=
 =?utf-8?B?SHR6NThkWEZIMDRkczJVSlpJamcrQlkzcDNScWExejZiVEpGV0dpZS9ZTEUz?=
 =?utf-8?B?NTlwYk0xWFJxeUZsVXZ3K1JYNy9ka2FobVNmcGRUb2tYamEvNUhURHZsWGNL?=
 =?utf-8?B?aUdVMlM4cjZqc0h1Mk8yMmVZRmVCT2thQUQ5OCtkL2dMZGIvZ2xnWThmeHFp?=
 =?utf-8?B?OVhDNnAvbXNmY2piZW5QbGhNVVl0QlJyeHoweU5JcHhSV2ROZzFJbHE4OWt1?=
 =?utf-8?B?SWoxaHlKVlQvN2l6UXVUMFBHd25iVUFEczhPWHlndi9HN092M2wzZ0hlKzNa?=
 =?utf-8?B?cGw5WFNzUTF0MmhpNkZ3NVRIemc3R3FUZUlEbURHaVI2ekdIbCt4VEZuaUNY?=
 =?utf-8?B?WlJmSWk1TGdQUG5vQm5tVnhPSzBocFpTM2I3Wnowc2w5a0lMYnFSWktXaEVU?=
 =?utf-8?B?a3o1Nm5NditDMloyZ0s2c1JGb3NNbkZQKzZ2cWNYZlRPdWxTVC9aL0NXdkFK?=
 =?utf-8?B?ZnFhRDNwWlFsWnpwSDFjTVFTZTEydTVjWFVSdXNDQitUWkwzK21LRU1TL1k2?=
 =?utf-8?B?NkVoTzVUb1dBQ3dMOGR5WTNpTDZvVm5XNnR0LzNtVlQ4NEt1M0t2cFBrUldE?=
 =?utf-8?B?SmthQXpYTGp0OXQ5Y2JNbkw4M0FBZ2lUUGIxVjk0M1Bmbi9XM0N5OTFYSTdh?=
 =?utf-8?B?WEVMYWtEQURPcmpDNzNsblY0a0lza0xkOGpBRjVqczkwYTRqMnU4MzNWSU80?=
 =?utf-8?B?Nm9SbjRFLzJYZlNrbm1lOWo3dU9yZmpPUWFGUlpIR0xmSnZiTTdxYXpPZ1Bz?=
 =?utf-8?B?K3l2d3o2aHMxeUl6RWxUT1U2cTV4R0U5R1p5cytrMmg2NWsrbHNwWjZxUVVo?=
 =?utf-8?B?czNHWFNmVnJkaFBxVVBWYVlERXBNa2gzdE5tREdldnJEdjB3L3B0d1RmaWh2?=
 =?utf-8?B?eVdaaUx1RTVMMGV1OUkrcEJXSnV6cHIrTDFnL0p4cHB2UXRZbHdKRTJnb0px?=
 =?utf-8?B?VkJVS2NsZkhUZlJBOFZuZUdXbCt0cEJkSHpLNUk5VC9uSHA0Rkc0eGlOZ1hr?=
 =?utf-8?B?NkVvSGlkRC90ZGZ1K2tZUXY4ME5MYmw1YWV5bkVmcE5sQUo1U09rZnpEdVZP?=
 =?utf-8?B?bUVRcnRjektJOTVOVEMzd2lmaUdobEJtYkxEWEE5UERQOVhXazB6WEt0NG9Y?=
 =?utf-8?B?S3paaXpva044QTNuSEp6RkdhNDkya2NYOWFkV0pMcDVrVzh0dW5kMjVpL05t?=
 =?utf-8?B?d2JLOWtaQTF6TFlUZjc1MU5NaGRQVklVVTdUdzZlY0hNWWc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RC91dEkvcEViYitubkZyMzcrVXVJTU1od3hsbzBlbFM4TWxrQksxYjYvUW9q?=
 =?utf-8?B?M2lnVld4N3MwZjZXajl2VVF2djdLcGFseEdMOTF2dm9EaDd2RUN5ZGJ0cE53?=
 =?utf-8?B?MVpaNklOWCtreUNtc3ZMdjFZWnBqV2oxbXJPdTFrOWVWaXZVa1BVUEpMdXBm?=
 =?utf-8?B?bU1xWENCcWV5SEtTYXhYUXhRQkE5ckJEMnhEMHRBQkZkU2FuSXZiR1MyTTVR?=
 =?utf-8?B?bWxJY1U5Sy9BVElaNmxzRXJCWUlpcDFwU2NhRGRaNUpnNUVUTTFaZnVCN1k0?=
 =?utf-8?B?YnM1V01pb1BIT0hUUkRTTjc2RERSbktOek9JZ2tac0MzNEhUZDZIZCtpWUE5?=
 =?utf-8?B?SEZ4T003NkhVNElGcGhkZTQxM09UdW5SemZnQWdnZDNNa2VZWkZ4OVI5WitR?=
 =?utf-8?B?QWxwVHBVd3hQZlVySythWE9jUXJuVTROVmhOajN0TkJRajV5YWVBN1ZOWkNZ?=
 =?utf-8?B?ZWV2WjJTRmJPaGN3aG1sSmI5cHNjM2VCVFFyRVVodVVHMm80UjJ0cWJLeWt5?=
 =?utf-8?B?eDhYNFZpVnN3SW93aWFWbHdYL2RGR1VESWlvRFBMa01KUmtxOW1tenZPb3Yx?=
 =?utf-8?B?SzJLTWtDbkJsK1o5dVhiQlFSbWlzRC9GZ0NYVFJMT1lISUxLRDd0R25Ua3Jw?=
 =?utf-8?B?N3FQaldGOUNmaFl5MmpxcVJwUEJMZWdlN3lldjltSUJyVlpVUWNEeVhGU2ZN?=
 =?utf-8?B?ZlFKT3NHTkpIWU4wY2NBaEZhdnlZcnFVRjdyTStUcnBlSk55ZDA4MmNqNVlT?=
 =?utf-8?B?cDh4WDJDaUkwMXZmSWN3ZnIyQXBtMFpGWWFaUmhKWkd4YU45VkNaU2ZaSUE4?=
 =?utf-8?B?bDg1R1VmS242cFIxdzNnaFI0QklORlNaWmphVm9JSFdzTDVUSUlSemlCQ3Fr?=
 =?utf-8?B?WTdSbEI1RG5SM0lsSFpYNFpadENsMGdrWGUrUE1UbFRYdENQY2FQUVRnYlQw?=
 =?utf-8?B?UG43Z3UyT0YxZ1JZK2UrMTZSa05ST1B6RjVIcmZvazJDbkJzYnlYZWY5VG5I?=
 =?utf-8?B?YnphdnJQOWVQT1lzK3ZJamN4OTlHQTFudkRPYlQxRzhBZ3ZwUkV6NGZJL2xm?=
 =?utf-8?B?Q1kvUGUyTGNveUNVeW1Ndyt5MzZSVkJ1R3YwWXZQdEVETHV3TUdZcHAyajVl?=
 =?utf-8?B?dHlKRFF2Wkl2R2ZMMTNrRVZCOU9zdTNMZ1pvSEtHOU9zZkhCOEZHM244cXhO?=
 =?utf-8?B?Mm9hdUZ4Zi9CcUF2VThrRHg4SVRwbTlrSzVGSkJZTG5TaGtTRGw0OENDblNX?=
 =?utf-8?B?aGxaUXdSSDk1bFRnMkZRb2dYbTRDUUhZNzdXYmNsemp5U1lnV3JjajVmZG1s?=
 =?utf-8?B?QjNPN053SzhCUTlNSWQwblFCeTR4ZzdId1VlSGMzY0t4RXFuQXdZeWY2dS9z?=
 =?utf-8?B?aFJVd0FHcnBmaFgycmNueWprU2pHa3ZldytiSkdlck1DNkdLVzhkMjFYa0kx?=
 =?utf-8?B?bzFIOEw4cDZGMDJGSS9QdHh2QnEzODhlbnJIZjRsaHhjUzA4TjhTOElibzlk?=
 =?utf-8?B?OUN2S0UxRk0wWFBZT2Zxd1pwWlZpb0wweUYyN3lCbElTVmFpL1F0TTcvSmww?=
 =?utf-8?B?VFR5ZDMvTnZaMnJvMGVWbWxiMmFmenBjbHV0YVFLYnJNVFVtcmRacmZWenJD?=
 =?utf-8?B?dzVkVkNFZ2NzWUtnTjIvNGlhdVJrQzA4WmtlWHYwdERVMFh0U1RUelovc0gy?=
 =?utf-8?B?d3hWN1N0YUQzWHFrSHMzT0VvVXp4cVoxRjViamphQytBS3Z5WG5PamVZc3Bl?=
 =?utf-8?B?bU5oekxubXY5VnY4c3dXWHltNTBEUU84dk1TNS9YQ2NsODVObE5PZVMzYzEr?=
 =?utf-8?B?RGVIalAzM2l1T25WQmlYZ1hTaVRsN2xsSy8zdmRwci95ZVY5VUhJRWVCR0wr?=
 =?utf-8?B?ZE9HV1ZKdzZSZjM5NkhRQjFCRFZlTFR2S3cvRUhaMXV6VGFFSzFzTzZ1eFZz?=
 =?utf-8?B?bWs5N1FGNUdFUWNmOElKbW9VQWhtUkhTNWtuS2xLYVBBMXJWK09XUDByQWwx?=
 =?utf-8?B?cXpvR2M0S0ZmUnRVMGNqai9mMVJKNktEQ3lCWmpTeUgvRUh1SmdLcW0wYjFX?=
 =?utf-8?B?YXF1YUZKZDVmSVp6NjhySFF1R0c1L2phcldRVlRDZHFUUXpwRnd3OWNESXY5?=
 =?utf-8?Q?iwL++s0yYxCWM9HXl9PeWKBzU?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4715bd-2ed4-4ef9-9574-08dde88fc4fe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 13:10:34.2545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeoZeN24zpthOckaP1x7L6elRU3Rd23VCnl2S54XXuYwE8ReEkIKh5VrZ4l73NsvK5KT7aEBX8tDQi55ShD2wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3255
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 31 Aug 2025 13:10:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19988

On 28.08.25 13:06, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows to reset the device back to first boot by
> formatting the persistent partitions.
> 
> The reset occurs if a file defined by the variable
> INITRAMFS_FACTORY_RESET_MARKER
> exists in the device INITRAMFS_FACTORY_RESET_MARKER_DEVICE.
> 
> In case of disk encryption it will invalidate the keys
> stored in the TPM.

I wonder if this needs some finer control: We only clear the TPM in case
that :encrypt-partitions override is set. What if a user if this
infrastructure would clearing also in other cases? And what if only the
encryption key should be wiped from the TPM?

I'm a little bit concerned about what "factory reset" may imply for
users. In some cases, it may actually mean to wipe anything that made
the device "unique". In others, it may be needed to return to the state
that was programmed in the factory, and that may include bits in the TPM
that should be kept in such a case.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

