Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD37CCD1AB
	for <webhook@archiver.kernel.org>; Wed, 22 Oct 2025 14:22:55 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.15])
 by mx.groups.io with SMTP id smtpd.web11.10780.1761142969258380315
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Oct 2025 07:22:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=muc2cuN2;
 spf=pass (domain: siemens.com, ip: 40.107.159.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYXUcV2QmlcLTF5kSmPWf/8/X3mji1cN3SZCsou4PVNk3VtRR5DGDgufR/PZtce9vlCEmy3PbOJ4bShN8MewIBq3JmzKYjyYxjYTIT4zuEDSC56o9hrETqjlR2DNLlA8TXMxDEGMldDfl86/zHagS70D0rCKqeaJtysP7DGxN39fYBQTp8M+sSFvGBuWuDuPRfFoJ/R6WBqG3auIE0ePOgVVb4znGTXVwNaq6n7WIAVr6n/X0LNaYWmWVWNZ+0jxhwenG4HNjYGEG/tV5VSxc1NhHYTGFepYbsTulTdXTT8F8ZDDSmHxrgWLp39gNCVdXgzF+uuLC+dCfd2wg+aL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDHTp4+2jtwUH3NCcEkeBVlQAttHieD8Y5b72s+zoVw=;
 b=d7oG2zmsbUbpmL0Ad8M5yqr2FrKMBg8CajStzi4menW3RqFwY1YQpklG1wz3cLh4mXc58QOUE2LsumBNGk9ceZbjfNIP6LzekgssVtrTQP00HXonGksLsotkkqSSGOUssIIUuAypOVSoT41o+OV96aujAzAG/rX3U7rmSG5kYC/+JdhveZI8zdThKoS1KsJ4Fg7YZPI4B4B1p5BV/zk4/uhiREAp17a06YWKMYtakwwcwQOFbkotaEQvnfuOa2d9J5awdpnLj8DOG39XmM5hezCtxpjCohHrtl0BwfUKG5CfAzKy0VWH+aCJbj82+1kCNimOSCWXGs6yF0i7uzQTJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDHTp4+2jtwUH3NCcEkeBVlQAttHieD8Y5b72s+zoVw=;
 b=muc2cuN2tYNoNCc4bT9hmZKXCULucweDuoVUAsmUZcQbfmWGlVYtxqDPfpezPyOPG15tkYIIc801UGgwNFzyHMCusioaBm4C3aSAiwhl22Anlt6LJdKqGQnr/uOYqqIF7TcoXMfysnjfSQlk8ddGUnKM0TQP321rAXA1WiA2cAlR7RlHtDHZiLzoeMBOgljLJmXdVoluusDxBSqVc0xpLS4TmnS7rysYVUeCgON/GujXRu4miMprhZEd6ImBZ9vXQqqVnXFNRTpUGKGMjwRsNHIqlZa5/d7E5uKb86sr82JHM07mO8OZW33E4SFrvMo8Lp+KHi172F0wJiuNlNATbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8088.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 14:22:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 14:22:47 +0000
Message-ID: <7276ae64-76ff-4c46-916a-968e6567a192@siemens.com>
Date: Wed, 22 Oct 2025 16:22:45 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] kas: Update to 5.0
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:610:11a::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd9ada0-4cca-42a3-dcca-08de117678ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cytNYzJBakNHNmNrQWpsZVVESnhaYnFaOFQ2enFuZWpSZmo4NFptYjRVUmZy?=
 =?utf-8?B?R1IvYU8xU0Y4MUpHY2Fkcmo0eFRyblpaeVlmeTdYK2xqWUFpeThscjEyUDFa?=
 =?utf-8?B?QWJUQ3pMZjdoaE1JbXJtc1FuUC9UUHpGLy9pUVVvMFpOYmxER2RQY0V2WEtX?=
 =?utf-8?B?UWhHalFyT1J6OXErenBtS0FiNnQxa2JiTWV4NEMxRi9aTzlCY2UyWDBlN3E5?=
 =?utf-8?B?OUNZSUhscDY4WjhsRzJJcjE3NUluM2dCZ0V0YkRPTkY0Rmt6VUl4NGtOb0lC?=
 =?utf-8?B?NWc3bUptbmc5T0VJbHk1eEtlbWNmQWRveWpLR0M5VFZSN3VreWU1NjZBWFpp?=
 =?utf-8?B?TWpJUWhjNFZPbURSdzRuSXJLcTNidmh2aFlNTHRmd1F0ZUg0VTh5SVdYdSt4?=
 =?utf-8?B?R0kwM1hGUWZteitBeStBQk9GWlM1UlRVaForLzg5THRyNUZFUndCM2ZWSlJ2?=
 =?utf-8?B?dkJhT3lHWlZHR0xJYWxxaEU2MjFFa0tMMGpqc0Y2dmhwYTlrQWRVSG10ZEk1?=
 =?utf-8?B?ZnJsSDRzYjJNWUJMK1pEK1BOVVFNRllGWG5iR09CQStoY1NjVXJuMkxvSkhN?=
 =?utf-8?B?YWZzZTNhODJRSFNHdE9LUTFqOTJkbXVxM1VIUWlBWkdDTk5GMEt0OWdsT2R1?=
 =?utf-8?B?NE1vK29XWWh6dmIrQmEySXdUeDJzWjlVSWFSS0l5aUd1SXpUNTk3Q1M1ZTdI?=
 =?utf-8?B?WlIyTEFKZXlOelhOOGdVcU9aT1VlTi9uNk1qQWlpUzB2bjl4Z0U0VGFPR29m?=
 =?utf-8?B?VzhDS25rMUplQXpjNlkxcUpxWW5kNWpkSjNtRGlkRjBFU1JvL203YjJFbWRn?=
 =?utf-8?B?dmN3dkYrbWgxOWRGM0xWdFhSZktYOXlIa3lVTTA2ZkszQmxaT3Yyb01vU2g0?=
 =?utf-8?B?Y0Fxd01EaFBxQktxTEFOSVA3d1pOK2pJbFlUZFhqeEkzWUdwNjcxVjBvZ0RZ?=
 =?utf-8?B?a0ZScVFpOHVVQ3U1c0kwUnd2SmFIM2lsdkEyRTNzSjBsc1c4dTJtNFJSMnZh?=
 =?utf-8?B?Q3lUdnNyZ3hpQ2FiRkk3WmlMQ0NuemFwSzBsdEpQWG9zUG43ODM3QzBadHhy?=
 =?utf-8?B?NVdPSXpYRVVrT294WnArRkpGbmdqVDM2NXVCRU1COGJlRTdieXJxZElGKytm?=
 =?utf-8?B?ZHFLck9EdGJOU2tTeTl2T1prMGVtUE1CbnJFdGlZNTZrR1lXeTFBQUhiZGJX?=
 =?utf-8?B?cThuUll1b3FYQzVNUFkzT05NUDYvQ1QvZ1EvZGJuNlpPRnFTenIra0Z4eHB1?=
 =?utf-8?B?N2NGdTJ0ZXdib29uZTFTYjZGWTBuZEJUSlFsRmNVa1cxZHJCQTg3MUplZEw5?=
 =?utf-8?B?Y2dhUDZ2eWk3Ulc1bTNvejRtSmJ2U2ZBMnM4b2xBU2Npdjc5aHJIc3gvRDVt?=
 =?utf-8?B?NWhtUVBMWlRRcFN1M0xKbnAzZFh6UFo3UkVmRVU2cmlOd0V5T1lIWmlWS3Rh?=
 =?utf-8?B?TXN0cTN3VmRyTjdjeVRRZ0VKR3hTcFlHT0FtTytzRUhXbDJmbFp2a2tDdWc2?=
 =?utf-8?B?UEtTcjlSSW5RblRmRXcxU2ZUbkdBaGNVeVBSODc1clVsMTVoRGtOMVduUjU1?=
 =?utf-8?B?KzcyUkxzL3AvVlFyeHplVG43LzlPeE9HdzIzNEUzU0pXanVzRGY1MUo3WHJX?=
 =?utf-8?B?NmVjTFBXbmQ2bFZ5c3ptbmJ1Zm5IbWdJRzVSZXZvNmV0NHRDTkZLdnBuc1NY?=
 =?utf-8?B?TE9LMmlTQS9YazF2WHg5bTVmSXkxLzR6aTJLTUlaY01LYm4xWHV6YUNoeGt3?=
 =?utf-8?B?bXdYZytoMG1pZmxJd3ZIVjYrRTQvUHdpdFJKUTJ4QnV4ZmhtQnNOOWNETTBs?=
 =?utf-8?B?SXYxRkxWQlBiVmxQQlZCV0FtWDZacXZvQys1SGxUWmdRUUVWOUwyRWp1Rmxj?=
 =?utf-8?B?QTVpSmVLeGJOSHlVdkRmZmVqcGwxMVZzdlVSbmVrY1RQbEE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YVhTVXowaVJCSk1JN2pvQWlKb1YrZWpaa0YyNGRMZXFPNmZ2eHBwZzBZRVRi?=
 =?utf-8?B?cVd3NkV6WDBtdWh6QWp4MC81NElCL0VWRTlkZXY5aVc1emdwQ3Yzb2t2NnlQ?=
 =?utf-8?B?S2Q2WGVPR09CVm9xZ0hCUzMvS25vckZuVlBHeXp1cSthd2J6WnFOQW9NOVVS?=
 =?utf-8?B?MTkyU2JhUjI5Uy9WWlFEeEg4Y0JRYU5GNVpoQ3c5SW5PZkFlWTAyaUlwUm5R?=
 =?utf-8?B?alVWZHZ5SUxldExMM2FDMEh1R2JEb2VFSU1tL2JGOUI1TjRYaGNKbHl1OGV6?=
 =?utf-8?B?Yzd5aEg4WlJ0UlI3NDB1NWllcTU4amVvY01ha3gxdmlDT0tXYzVpSWxYZlRx?=
 =?utf-8?B?YzJJdjlhRko5c2U4M095UUUyb1Z6ajRSK1M2S0hlVHUwTjdBZDE5aHF5NWZY?=
 =?utf-8?B?QkRrbnp3WExDNlVhc2ZFK1FXMHVxYWZPVEd0cFJyWVVlY0tBVDVPWlV0OWFY?=
 =?utf-8?B?d1N1QTNabE5kMEMzUC9VejRueU8zeTM5SHo1UlFOOHdhdThPMGpYcU5YSjFT?=
 =?utf-8?B?MzdpNk9TdHZSMnU4bkxXM1RhcDEvSnlxV1AxeHdwS0hNYkdwdHFKbWNOT1NG?=
 =?utf-8?B?b3FaVVE4TENPUCt2QWltUjFHQW9nUlMzYU13Ym94ZmpHMVBibjYrN0ZNRGVT?=
 =?utf-8?B?TTZVVWhLTWJmRmZGYVdNOHJHSDJzOVQ2K2F3MjJIa3RGVDZpQitKd2lnR3Jh?=
 =?utf-8?B?ejUyeUNnUmI5QmhwUmNUMDM5T1R0TUI1WUswRXpsQWRuVXQ0T3VvYjkrNEZO?=
 =?utf-8?B?amJ6UDBhRlNlM0J1bkVWTVBTQWIwaHIxbDdONDk3SnRUZEVUZnB3dFJRdkFu?=
 =?utf-8?B?Q3ZWS0pKWG5PSXVRdjRKVTMrcFhhS3pDYmxUNUFjQjBadE9rWUVrc0lneWU0?=
 =?utf-8?B?K05Ba2prUWZOanRkbk9aeURDa0NNS290blIrbWxpcmJBL1dGT2pEUFR5NjQy?=
 =?utf-8?B?OVhuZjFPNFUvT3RCS3J1aU9wSG5xTTZESTduKzNtdTFtaUQ1WE1oMDh5cmQx?=
 =?utf-8?B?UzA2Z0kwT21rK2w4NEY5ZkxybEpWSy9RQ3VPMFl2azVDZUdQMk9sRzBIQzd6?=
 =?utf-8?B?ZlF2ZlQ0UC9oTUYwaXZIYjh6ZjdMSjBCQTJvWFV5cGRid2VvbWNZN2sxcUtv?=
 =?utf-8?B?NHNrUXhuS2xpQ1MzU1lKYTBMOFdyYjBrbkJmRy8xWFFqSUc3a0ZDczVGVjQr?=
 =?utf-8?B?dExHK3RScDZjSXJyYmJqTVVYT2p2Z0ZKVTdPdHBkWGdHOXc5clBwUnZncHhG?=
 =?utf-8?B?MVJEV2s5MjNVZndtaXVUcmRhU0E1SEZ4VFZ5NUhXM3F3SWczdzk3MzA5WXRN?=
 =?utf-8?B?Uk1ZcC8wSUs1NlIrUXBmR0JzWWJsQ25Odkg2VUtWSlE5akZkV2RqU21lSStw?=
 =?utf-8?B?R2N4M1VCSnZiQlN4T2RlaXJMdW8yeC9IK0NzalgrK3psRHFNL2hMUEdsWmlm?=
 =?utf-8?B?VHI4MjVxNTRtZHJXbGlCYnJWWitXV3BFZys0cEJtTDlZVjRnSUV6SXh0WVlY?=
 =?utf-8?B?WHh0UUVIbStnUXN1aXVPWkdLS20yend5LzluaVVOZFV2cFc2K3owOSsrVi9t?=
 =?utf-8?B?S0lxZkEzendRREpDc3BOWTFjUzluL3pDY1BENlhVS1NKaW9uUnZZNEZSUDND?=
 =?utf-8?B?STd4aHN4Y1JLM0xwUVNGOEhCYmVMeHpWeVRObkhhbjJTeElpcm1SYzNUanhJ?=
 =?utf-8?B?eDhPeXVOSDBBa0dqTFFMbGpYT3hHb095WXdsQUNjMXd6SzhFM1YxQzJOR2Vw?=
 =?utf-8?B?dFVQSjZOKysyK0hJK2FqbThxaUU3czVhemo1VEZDRm8wbnl6VEYrbDVkNENO?=
 =?utf-8?B?eGdpV09SZmY1dGszQ2E2a1M0djJQUHBCZ1dDYnhvVXpPUnMyRlVkcHJWRXY0?=
 =?utf-8?B?czNqcVNlRWhSaTVZTzZ0RWFCUXJTNFBkSEdGRHV3RUZ6QXA1a3BGb0FiZVZO?=
 =?utf-8?B?VnFSWE83NERCb1U0ZFRZRE9Femt3Z0hObnF4eDVSeHRHVktFbjNzeE0xUEd1?=
 =?utf-8?B?UlNVMS9pV00zd292T0ZGMUx4L2dacmRFdEJvcUxZV0hmZmVZMmh5SDNLK2w1?=
 =?utf-8?B?ai91cG9wZDhwVnE4R0JPQVhEMUJONDlWUFZ2K1E4R2tNSlM5SVFVWEhCL0hV?=
 =?utf-8?B?MXhDa3VNOFBNQTF6N1VYaXUvd0Ywcy9wakVXZ2ZDeUVkb29uTWJoUDRHNk9y?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd9ada0-4cca-42a3-dcca-08de117678ff
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 14:22:46.9926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NYcs0TqdVvnNoeDdET09SaR1sDoLn3co1QFcPu0vs4rGZlElKHSTH6buP+UhfE7c9qiAQKjJvHj7ByxR/fmdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8088
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Oct 2025 14:22:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20213

From: Jan Kiszka <jan.kiszka@siemens.com>

As isar still has issues with compiling bookworm in trixie images [1],
pin to the bookborm kas-isar image for building this layer.

[1] https://groups.google.com/g/isar-users/c/H1AuILdBBMI

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml |  2 +-
 kas-container  | 52 ++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ed151fa2..c5bf613b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -35,7 +35,7 @@ stages:
   - cve-check
 
 default:
-  image: ghcr.io/siemens/kas/kas-isar:4.8.1
+  image: ghcr.io/siemens/kas/kas-isar:5.0-debian-bookworm
   before_script:
     - export http_proxy=$HTTP_PROXY
     - export https_proxy=$HTTPS_PROXY
diff --git a/kas-container b/kas-container
index 0e99898b..8e67071e 100755
--- a/kas-container
+++ b/kas-container
@@ -27,8 +27,9 @@
 
 set -e
 
-KAS_CONTAINER_SCRIPT_VERSION="4.8.1"
+KAS_CONTAINER_SCRIPT_VERSION="5.0"
 KAS_IMAGE_VERSION_DEFAULT="${KAS_CONTAINER_SCRIPT_VERSION}"
+KAS_CONTAINER_IMAGE_DISTRO_DEFAULT="debian-bookworm"
 KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
 KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
 KAS_CONTAINER_SELF_NAME="$(basename "$0")"
@@ -64,7 +65,8 @@ usage()
 	printf "%b" "menu\t\t\tProvide configuration menu and trigger " \
 		    "configured build.\n"
 	printf "%b" "\nOptional arguments:\n"
-	printf "%b" "--isar\t\t\tUse kas-isar container to build Isar image.\n"
+	printf "%b" "--isar\t\t\tUse kas-isar container to build Isar image. To force\n"
+	printf "%b" "      \t\t\tthe use of run0 over sudo, set KAS_SUDO_CMD=run0.\n"
 	printf "%b" "--with-loop-dev		Pass a loop device to the " \
 		    "container. Only required if\n"
 	printf "%b" "\t\t\tloop-mounting is used by recipes.\n"
@@ -117,6 +119,26 @@ trace()
 	"$@"
 }
 
+prepare_sudo_cmd()
+{
+	if [ -z "${KAS_SUDO_CMD}" ]; then
+		# Try to auto-detect a privileged executor
+		if command -v sudo >/dev/null; then
+			KAS_SUDO_CMD="sudo"
+		elif command -v run0 >/dev/null; then
+			KAS_SUDO_CMD="run0"
+		else
+			fatal_error "No privileged executor found, need sudo or run0."
+		fi
+	fi
+
+	case "$KAS_SUDO_CMD" in
+		sudo) _KAS_SUDO_CMD="sudo --preserve-env";;
+		run0) _KAS_SUDO_CMD="run0 --background= --unit=kas-container@$$";;
+		*) fatal_error "Unsupported KAS_SUDO_CMD ('${KAS_SUDO_CMD}'), use sudo or run0.";;
+	esac
+}
+
 enable_isar_mode()
 {
 	if [ -n "${ISAR_MODE}" ]; then
@@ -128,15 +150,17 @@ enable_isar_mode()
 	KAS_ISAR_ARGS="--privileged"
 
 	if [ "${KAS_CONTAINER_ENGINE}" = "podman" ]; then
+		prepare_sudo_cmd
 		# sudo is needed for a privileged podman container
-		KAS_CONTAINER_COMMAND="sudo --preserve-env ${KAS_CONTAINER_COMMAND}"
+		KAS_CONTAINER_COMMAND="${_KAS_SUDO_CMD} ${KAS_CONTAINER_COMMAND}"
 		# preserved user PATH may lack sbin needed by privileged podman
 		export PATH="${PATH}:/usr/sbin"
 	elif [ "${KAS_DOCKER_ROOTLESS}" = "1" ]; then
+		prepare_sudo_cmd
 		export DOCKER_HOST="${DOCKER_HOST:-unix:///var/run/docker.sock}"
 		debug "kas-isar does not support rootless docker. Using system docker"
 		# force use of well-known system docker socket
-		KAS_CONTAINER_COMMAND="sudo --preserve-env ${KAS_CONTAINER_COMMAND}"
+		KAS_CONTAINER_COMMAND="${_KAS_SUDO_CMD} ${KAS_CONTAINER_COMMAND}"
 		KAS_DOCKER_ROOTLESS=0
 	fi
 }
@@ -267,10 +291,14 @@ trap kas_container_cleanup EXIT INT TERM
 set_container_image_var()
 {
 	KAS_IMAGE_VERSION="${KAS_IMAGE_VERSION:-${KAS_IMAGE_VERSION_DEFAULT}}"
+	KAS_CONTAINER_IMAGE_DISTRO="${KAS_CONTAINER_IMAGE_DISTRO:-${KAS_CONTAINER_IMAGE_DISTRO_DEFAULT}}"
 	KAS_CONTAINER_IMAGE_NAME="${KAS_CONTAINER_IMAGE_NAME:-${KAS_CONTAINER_IMAGE_NAME_DEFAULT}}"
 	KAS_CONTAINER_IMAGE_PATH="${KAS_CONTAINER_IMAGE_PATH:-${KAS_CONTAINER_IMAGE_PATH_DEFAULT}}"
 	KAS_CONTAINER_IMAGE_DEFAULT="${KAS_CONTAINER_IMAGE_PATH}/${KAS_CONTAINER_IMAGE_NAME}:${KAS_IMAGE_VERSION}"
 	KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE:-${KAS_CONTAINER_IMAGE_DEFAULT}}"
+	if [ -n "${KAS_CONTAINER_IMAGE_DISTRO}" ]; then
+		KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE}-${KAS_CONTAINER_IMAGE_DISTRO}"
+	fi
 }
 
 # SC2034: DIR appears unused (ignore, as they are used inside eval)
@@ -283,6 +311,7 @@ setup_kas_dirs()
 	KAS_REPO_REF_DIR="$(check_and_expand KAS_REPO_REF_DIR required)"
 	DL_DIR="$(check_and_expand DL_DIR createrec)"
 	SSTATE_DIR="$(check_and_expand SSTATE_DIR createrec)"
+	KAS_BUILDTOOLS_DIR="$(check_and_expand KAS_BUILDTOOLS_DIR createrec)"
 }
 setup_kas_dirs
 
@@ -339,6 +368,10 @@ while [ $# -gt 0 ]; do
 			if [ "$(id -u)" -eq 0 ]; then
 				fatal_error "loop device not available!"
 			fi
+			prepare_sudo_cmd
+			if ! [ "$KAS_SUDO_CMD" = "sudo" ]; then
+				fatal_error '--with-loop-dev requires sudo for device setup.'
+			fi
 			sudo_command="/sbin/losetup -f"
 			sudo_message="[sudo] enter password to setup loop"
 			sudo_message="$sudo_message devices by calling"
@@ -454,6 +487,7 @@ done
 [ -n "${KAS_CMD}" ] || usage
 
 KAS_EXTRA_BITBAKE_ARGS=0
+KAS_FILES=
 
 # parse kas sub-command options
 while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
@@ -592,6 +626,7 @@ forward_dir KAS_BUILD_DIR "/build" "rw"
 forward_dir DL_DIR "/downloads" "rw"
 forward_dir KAS_REPO_REF_DIR "/repo-ref" "rw"
 forward_dir SSTATE_DIR "/sstate" "rw"
+forward_dir KAS_BUILDTOOLS_DIR "/buildtools" "rw"
 
 if git_com_dir=$(git -C "${KAS_REPO_DIR}" rev-parse --git-common-dir 2>/dev/null) \
 	&& [ "$git_com_dir" != "$(git -C "${KAS_REPO_DIR}" rev-parse --git-dir)" ]; then
@@ -686,12 +721,9 @@ if [ -n "${SSTATE_MIRRORS}" ]; then
 	set -- "$@" -e "SSTATE_MIRRORS=${SSTATE_MIRRORS}"
 fi
 
-# propagate timezone information
-if [ -f "/etc/localtime" ]; then
-	set -- "$@" -v "$(realpath -e "/etc/localtime")":/etc/localtime:ro
-fi
-if [ -f "/etc/timezone" ]; then
-	set -- "$@" -v "$(realpath -e "/etc/timezone")":/etc/timezone:ro
+# propagate timezone information to entrypoint (requires systemd 239)
+if command -v timedatectl >/dev/null; then
+	set -- "$@" -e "KAS_HOST_TZ=$(timedatectl show -p Timezone --value 2>/dev/null)"
 fi
 
 for var in TERM KAS_DISTRO KAS_MACHINE KAS_TARGET KAS_TASK KAS_CLONE_DEPTH \
-- 
2.51.0

