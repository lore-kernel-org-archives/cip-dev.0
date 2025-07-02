Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80032C7EE30
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 07:08:42 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.6])
 by mx.groups.io with SMTP id smtpd.web11.17757.1751440113249645916
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 00:08:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wq9usaD9;
 spf=pass (domain: siemens.com, ip: 40.107.130.6, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCRaB6G6XwVnBlQl41DSycLc4ffyVQBAg+65XZriddN8/AF2PsJ2ZVNB9myCaZ6YlghhZAfUPiYOQOsreHE1nRoUFui+7tvkgARrzU1olV30CQ72MmB8aEMaOZgRp32mtbXakrpiNuE+xDkFcPY/ZTix/7Jk0Wxq5fYBOsJeazf0gIz89jF0gN0gjtmSu/oCHf8ZlWiEo6GQF2/Reeaec1dBa4aj9UKGM2f4X6Vdyx8m+FnP0rwx9F0NLHDLPpPAi/fQsBs0gRKyWJCnDWiBs4NXQn9AKNhTOIIJdSMl1zqYUfUaQUNOzuUZNptqRvBU7kawawGq5tvSptT94Qbeiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXtS4e0CF60YOEc4QYX8pdsYmtF7ZQ5XJATPPAy5Lj8=;
 b=bQZOYfgZSLDjdtMgip6vpk0lWJrwEu3KepCmk9JSPNjGYUKncpgjKV4+O8Vu+sp9DlP0rRkhNnJpnFmxBQBcD/sxAMKjx0hrOn7/SOFHsotvE6q8+a89So6SjsBMLL/ZpBRYIhoCxj02fiFhGBU4U/EeI2EepU3qQq+ELUjvwVY6iGBOHTJnvutAornsPnZLJGD6+//pi/hxhOWopLMhPEHaLbjXb4pAt4Kyp9hO//p0ieDZiBg0wGIkbN8G23Npc7G6Lmn0X9dQF97d3ic3eaczWNGKgdzr1YFZRiCqt83IWF0q5n2ecAtrccedAn+0Bot+WD5fuQ2DWCljKPjCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXtS4e0CF60YOEc4QYX8pdsYmtF7ZQ5XJATPPAy5Lj8=;
 b=wq9usaD9gXlwCj9elcFRWIXcfva++/M5KY30YgG/fkZ+0No1YpNlwLSY0Wg/rSoXcUv3eK8nYDr9KVdX4fBXL9CC2rODvu+BVijEFZIeEOgt0StFtmYlaxb9VKBa7Apu8J0acv8AC8+MUMKOXnnDoZ2JHi2zQNVdHR1Fnkw4RpupLn41uwUxhzPjICo2Fd7STCpshBnELJz34H/U8NAUi2sNVeojiUSZrjST/qicMJ+4AOtFgqtPMkDFhdl1bPgWUG5gmrcDI/3675NRqVVSfIgbf+b5wKw7Lg77+rXmhKimCuzuGVQ9EEY4P+bZCxa4DMVudCcUdZcYpOO3oBIaOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7346.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:606::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 07:08:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 07:08:29 +0000
Message-ID: <a4b992d3-eb46-4cf1-8e22-87024d969618@siemens.com>
Date: Wed, 2 Jul 2025 09:08:28 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
 Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>
Subject: [isar-cip-core][PATCH] wic: Fix boot by PARTUUID for bbb,
 hihope-rzg2m and iwg20m
Content-Language: en-US
Cc: Nikola Trifunovic <nikola@trifunovic.at>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 55db47bf-1aab-4a20-3fc1-08ddb9373f7f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WjVNTURHandNQWVTYVFWSVhzWjY4RzRwVTFvWlRlQmVXdTlYMUdxdVBFQmxG?=
 =?utf-8?B?ZkxmSmJhNFRYTDdUMG5LbVdZc3lhTGtxdGwvT1dmeU9IVll5S1dCcWR1NWtH?=
 =?utf-8?B?dXFlMGpVSFFSdVBTMW1JSVlFU3paTnlEMGp6MEdjL281clNBcXJUUDhnaWl1?=
 =?utf-8?B?NStKUmhWbDVSRWZ0ZVZVcThtK2R2Y1NQUU91UFQ4UkdUdHNiVUwzbUVtN3Mx?=
 =?utf-8?B?dlYyRTNXN0NLbnZTeUt0S09iSTcydzdnV001L3IvR3ltaG5OVmZlVWQ5czFr?=
 =?utf-8?B?UE1MTytPakdvZ2RJbUpmeWJLRjNCL0lESUxoa2VJYzdrajBpQ3hNNGZ6QVZO?=
 =?utf-8?B?NFRRZTExQTM4c2RKcGNqQUVKTzVpMFVqOWhiTjZTV0V3LzZVK3p1Y3c4bGIw?=
 =?utf-8?B?NlpoQXJFSWNidkpNcXJGS3VLRjFPZHltODdqWG1Nc29hUFBqM1hxcXhnczR6?=
 =?utf-8?B?d0VHc0ZzUzZpZmZ2bTU0Lzh5RE9TVkNoVERyRVFSNExDMHh5dUtuOTFUOTdz?=
 =?utf-8?B?b0pCTHVlQ2dBMXFVaUtFSGF6NXVUN2ZwZkNpK3RMMjdUbXNiY1AxVC9sSlVE?=
 =?utf-8?B?UnVTTmlsYmswNmIzUzMxVmQ4cEo5VysyZHluOEhzTVNtMVJCbmZKN2JhOHJ0?=
 =?utf-8?B?eVNrSy96TFNmVllxelFQejBMa2pWQy8wOFkxaVJadW0yeTZCQmNXZ0NwV29w?=
 =?utf-8?B?OU5FR3BsQlhxcGxISUgxWTRmTzllbTRZWUYwNVBKSHVSSVpNNmtDRmNjUzVl?=
 =?utf-8?B?djFwZzlsRnVFdW9rNXhzVWpHR2s5NStXVXErbGJzb1A0WVNaUTlwM2pRMlhY?=
 =?utf-8?B?cUVPdzYrZjBsSHkzZmVLbFp1dkRSZUdZYzVlME05NkJoenBLVXZUYWlOaEY4?=
 =?utf-8?B?T3h0WFhUR3hiRUM3WUNhd0o5YUFBbzQrNEtoWVFSaE5vSDJEUVlIbWxhbksx?=
 =?utf-8?B?VjIwcFRxL0RKN2l6MFVPV2g0aXZ1N05raFp4N2p4d1JoV1JMR0pYdUc4bEd0?=
 =?utf-8?B?SnJKMDNtdlBjb1NFTWhhc0dmZ3dCWHE4Wlg0bnRFS1ZnWUlnbTk1Z2wvUXFB?=
 =?utf-8?B?bGhqdldNbk5DU3BSL3h5dEZSSFdaazZ5WTFsQUVTQUlZNmhQUk9RdGl2cmgy?=
 =?utf-8?B?UG42ZWFSWEdMOGJBWnBybnJEZ1BBdGdvQi9WdUpaejVoSjZ2SUFiK2tONFNX?=
 =?utf-8?B?OFJCNy9GeFZXM09Nd1NHOGRoVUhwV3Nrb2VPRURNNzFocjlZcGVaMDg5bzFk?=
 =?utf-8?B?ZnJ3bEJRNFJCb01mYTFQa1hkQXowbGxnZ0VUQ3VQb0drbGJvVHBtcTdORkw4?=
 =?utf-8?B?VWs2eG5sdVk2QUhzNndNMXNRTEZ3V0dOV05WR3F1SzB0ZHRQcXNROG45eUxk?=
 =?utf-8?B?enNBVW1pODRnQm5aK2R2anV4cWJmOTY3S3lUNnFrb04ydXk0NDN6TC9MQk9C?=
 =?utf-8?B?TW85Y3ZTcUQyN01vaHdmcjlMNmFCdWl5ZDFRUDlOOGJKLzZBZWZDRzkwbE9N?=
 =?utf-8?B?OG02MkIrY1g4a1o0WnZKR0JOQ2hVbnZJS0dKQW1QWG5HQkJacnYwYkVoUHhG?=
 =?utf-8?B?R1dJVHV2TG4ySTU3YVlHbVdkZ3BtNXM3aVlPdy9XeVpHYkdyT3A2NDBLK2VP?=
 =?utf-8?B?RDlpTmdQejZxSThmRnUrWHNWMWl5NE9pMXFKbGpwRVRlYm56ZzlIUFdubU5s?=
 =?utf-8?B?dG1wamZRclJsMmp5eXh3aE1KekJ5cmlseG0zVktUL2x4OEhRNE5QdXpMZ25v?=
 =?utf-8?B?cjRib2JQSEIzdzM2aExPSnVJZlIrcEZra0tJODBwcVRQMVl0TDM2L0lKUHA2?=
 =?utf-8?B?anVWNmk5aDJTMXg3Y2MxWmZ5UW5CRHp6eXFRbG1tUjFUS1lrTjBLMmhPV0pT?=
 =?utf-8?B?RDF4ZHBQSUVFYUNkRzlDU3UxdUduNyt1VGlMVU5UQ0NnN2JIK0RTalNuOGMr?=
 =?utf-8?Q?8BL2iM2JKQU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VkorTFN4bEFLZ3hnM2U4UjNxdU5waDRUUUhsR3c5SHE4dWR0TFFtNkNCbVFE?=
 =?utf-8?B?cEdQTEhOMGJGbXQrMW5Pc0lEQVUxM0FTRHk2dFF0dkFkUnBQYVhOS3huRjFs?=
 =?utf-8?B?S0xjQmR5ZGI3dUtYVmNtVXp3M0g3Y1R4VDhnTGVIVFhjK2NsdVdrVUxpU0U4?=
 =?utf-8?B?SGNNWllOTlhzUnk2L2lBWVRpR2pDSEp5THpoQmh1bFl6SzdFS25BZmhCenV0?=
 =?utf-8?B?MmZDekF3R0JTbktEMjlhMWdXaWozdGJUVEJxc3Jtd3RIcFY3SXFrVHBzejBL?=
 =?utf-8?B?MzVmTnFHWjNic29wNDdHcEIveldqM3BndzhKYmJ2WmU0RWRFMEdjTGhXSWNQ?=
 =?utf-8?B?WjdseStreVJZdWZ5TzFiSjRzQ0hJdE5CYitsQVBEa3NzQlNNWGtiZ2lIeGVm?=
 =?utf-8?B?VVhOVERKeWU3QnpZYTllc2J0YUE1OC9vd3hZNDVWUitBK3VmdVZMNHBYKzY1?=
 =?utf-8?B?MitQUy9EOGhQbWlsMFh5UGNWVmdiNjVpNW53VHVFVTdpUm1mK244djd2MUZk?=
 =?utf-8?B?eDFvdFlTSFJkTEx0aTQzaVFwcXlTSjllKzhneGEzbXFZeEplU1o4WW5JeWFv?=
 =?utf-8?B?QVNXWXBkb0lKM3Q5aVNlQy9GN1BXdHlSaEpIMHR1S1RtQkY2aHptWkNzUUQ1?=
 =?utf-8?B?dXB0VVFxbDJhbjJxRkErbzNXekV3WktMRStHVTVFT3QxcGFwaGJyVk82elht?=
 =?utf-8?B?VmY3VjgyMDNET2FtLzhTeFJ2S2pTOW9FWkNRWWswZ0xhdmZiZzMzc3ZGbHNa?=
 =?utf-8?B?VHVtWmppaDZyZ05MWXJmb0liQmxwN2tpcDhma1dBeUVyNklPOGtqUmF6VXJs?=
 =?utf-8?B?ZWloejRGSFpESkFabTJRTU1LZGpRaktTd3NCcEU4WmgwcXlrQXc2SXUyQTZS?=
 =?utf-8?B?ZjBvWUtsU0t6aTBKcnNaSWVHRlJ3OEhZbDNqY3NnTC90Mk1NZFVaY0R1NllT?=
 =?utf-8?B?bWJTcjZkbHN4aDV6OFFteSttV1B4UUt6WVVCS1Q2T0h4NmNCbGlHNkhhNjNI?=
 =?utf-8?B?clVrYkx0OTdFbnlHb2NGRUwyN3hoSmxuM0tvcEZaQVpxQzYrS3REQjhabkZk?=
 =?utf-8?B?QVhxL1V2c0JjQjYrUFcxaXlrcWRnN09yd2VuMHBPNmJxQnJBQmhaQ2NNTFpQ?=
 =?utf-8?B?R3NjYjk3Y1JMUWZPdzJaLzNDQTdWMUV2eFUwSzNEMStKdEg0OXViZEVkMXk1?=
 =?utf-8?B?MkpCRVplRVIvODVtcGhSaDdOSnkrY2dkVk42SFFLWG1vZG5lcnR0TTNXMmZa?=
 =?utf-8?B?V0pFTDM0REp3V1JNbG1sTFUxR0MxdTVkRFlTaG4vRmg2b1dqT3I5L0FxNVB0?=
 =?utf-8?B?aTRRWHkrVDZiaC9IYnNVVGVVRHpKUWhTUlRJSE1STHJkbzltSUsxRGNXaVBl?=
 =?utf-8?B?LytrWlZvTGJMZFlSZ243cGtYUjAvclEwQVBsb0tMUjZQVDVrQ0dmR2FGcUJB?=
 =?utf-8?B?TGk2TUJ2TUw1THFUenBkbUduQ2d6TGtXZndEWlhxTkY0SGQ0SkQwL1dYS1pv?=
 =?utf-8?B?bk1WOEMyL0tBbTZ1U0ZoVGtmM0hDR2VDRS81dW9LVkVNemtmZ3BBTXRrSVp1?=
 =?utf-8?B?cERsSTYxakdhQXo4VkhSUUZGcjFZc3dzWlVpeFltTytERUJKWVlGZjV5WGNo?=
 =?utf-8?B?NDdNSC9xVEREOTdzSitsclpEdHgzVlVxb1FoUDA5bHI2ZExjRXByY2N0WTNV?=
 =?utf-8?B?dGh4VEJPaTZDRmtGaUxJMXhPcGNaN21NWjNHL2xFSnl2NWU5OHUyemQ5VjZL?=
 =?utf-8?B?WlBNNnQwdUw3bFBSWjRKaEZOejU2eG9sNVAxNVpmc0NIaC81VEZ5SHRBUVAx?=
 =?utf-8?B?NFFGRm5DTmZsZzBpbkx3YklEVHBQVVpGNHZiRzVkTnRTSjlDUjNaYUxGTzF0?=
 =?utf-8?B?WXFqTGl2N1NMa0tuUXRMZXdTWEtLL1ltbE1CdEZQRUd5ZjRRYVBtSmYwSzhx?=
 =?utf-8?B?QjlYMng4dzVtSGJEUmF3QUtMYXgyRFJTWmg3OTMwYlVpc3l6a0hIR0wvNzVO?=
 =?utf-8?B?Q0hTL1NaRkRhTmNJcFpnWGErS3VJL1ZPd0pRQ3FvcWk5RzdWVGxuVXdqbnpH?=
 =?utf-8?B?ZFJPYng0RTdIckphSGlWdjFUUk81aFpIOFd1YVRaeFIzV2ppRHZQYm5ST3FM?=
 =?utf-8?B?djRFTXV1ZE9kU2JCSldyd1g5c21ReC8veEtkRFkvV1Y5NHgrRVRROWV2alA0?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55db47bf-1aab-4a20-3fc1-08ddb9373f7f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 07:08:29.7307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBBvvkk6UKHnz8cw5/gpIcIBJKOCBQPJS0+AtApsRbJyEtngOef9psej3q4Kx4D9UgJ4hYadZvqV1Iy4nxOEEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7346
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 07:08:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19279

From: Jan Kiszka <jan.kiszka@siemens.com>

Using a full UUID for rootfs selection requires a GPT. Otherwise, the
partition table will only store a short ID while the initramfs is
looking for the full one.

Reported-by: Nikola Trifunovic <nikola@trifunovic.at>
Fixes: 38703cb8e44f ("wic: Set fixed partition UUID values")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

I don't have the Renesas boards in reach. Could someone confirm that the 
U-Boot setups we aim at with the integration (not covered in isar-cip-
core) do support GPT? I strongly suspect that, but just to be sure.

 wic/bbb.wks          | 4 ++--
 wic/hihope-rzg2m.wks | 4 +++-
 wic/iwg20m.wks       | 2 ++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/wic/bbb.wks b/wic/bbb.wks
index b46282dd..9bda7c04 100644
--- a/wic/bbb.wks
+++ b/wic/bbb.wks
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2025
 #
 # SPDX-License-Identifier: MIT
 #
@@ -11,4 +11,4 @@ part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-
 
 part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 25d57b24-f34d-412e-8c88-28629f23aa0d
 
-bootloader --append "rootwait console=ttyO0,115200"
+bootloader --ptable gpt --append "rootwait console=ttyO0,115200"
diff --git a/wic/hihope-rzg2m.wks b/wic/hihope-rzg2m.wks
index f5b850db..1c239f86 100644
--- a/wic/hihope-rzg2m.wks
+++ b/wic/hihope-rzg2m.wks
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -13,3 +13,5 @@ part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boo
 
 # Rootfs partition
 part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid b8bbba3f-3ba6-4b2b-8d69-4a95fd4f34ed
+
+bootloader --ptable gpt
diff --git a/wic/iwg20m.wks b/wic/iwg20m.wks
index 21fc4198..f66a19e4 100644
--- a/wic/iwg20m.wks
+++ b/wic/iwg20m.wks
@@ -16,3 +16,5 @@ part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boo
 
 # Rootfs partition
 part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid d0fa8361-7deb-43df-acee-1725d40d403e
+
+bootloader --ptable gpt
-- 
2.43.0

