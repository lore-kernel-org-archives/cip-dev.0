Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D32ACCF9F8
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 17:27:54 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4785.1762536469280037348
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Nov 2025 09:27:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=v525Czah;
 spf=pass (domain: siemens.com, ip: 40.107.159.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKg+ZIZ209WlQ9oBLTwPZIhloHA4NjXXsKTz2+0fIZvdK9jYYADzZ3ROsYr0IElYbIEvI4WvoJUF9OElC9EJPEwhSin8GQQFhNa+tcpF85uFs9FaCXkMxnkxC6PFLLxOZ+ihG5dQz5LL+HnR0Im1Zgma74YvCex3wE00tWJzWYrB3shV/8gdoNOZPRWhnn1ScHd7imGOhefP01IVMq9kOhEnImyw9bDLDcLouFLRb6jFiBro2Vc0pz1co6EKWRJrrOanghI4978RzD7CZ8JI4qqhEjjIMOlc/jRqiUNWNFZVNobJ90DvhWjnyM2avTN5foPb9cr89BdC5/cVPgRfKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hG0AiLdD5G3UALKctKmS+wyJ4ab1QGYw7EBL4tPBGtc=;
 b=u4gqmwHYR2JYl/XFLcaaifSZpWT9B1WWPCYyPXz8lNoIcm3rU/Br+h7RWr7f+81ZHXrNt1TSZJwP3uniy+95iqhem7vE3uPGW3grUZ+mzl8LTnUSNt9Zy0CL4pefxZat8k4CACNCccNNcVdZHPccUb9jcg2pzOSvsWzfjgt7ZLxeSd9I1ORlE9zn8Do1rY+n/WJrDWdXreyjLjrV75+ffV/nlwimudiSgY2BmTxocK76Zpe1pV4bau8mu9bRW7FOm80WV19RT2mJ8umK7AY8NJirqAMneubXDEa4YmbyvFUY4p3uPldy/RqrfA2aconcjHml+odt40en+dUXMtmwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hG0AiLdD5G3UALKctKmS+wyJ4ab1QGYw7EBL4tPBGtc=;
 b=v525Czah0PwWPYNeMntAYx84wxdUBb/pq2xKiAk10QeDDnzEdgrukseMJ9MLcR1Zg7CYLqDEblVlEXMLyWDocZb9x7psBxYZFt/yVrL8afXLR3bz8i0vEoFEDSKaFvk1EDCw/4nVgAh/VkJU1RvjpvL0MdFJG0rT32KdVp1GIBpQ8GP4K4JtdVBnt/s3lAOHfImOGFsoZgIBxArCy+atwzb8k7rCuya0DDu4IL+YIuccBMD3qGZPGOOhlpNi8CWC/NbSN8kbHyxlo46d25tZqH1WErIc3lCHNRifPdclsofXrzFx/Cm8j8YLEcZ2LtYsCM4zQJX6D+v9qPY1uBJeQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB3993.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 17:27:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Fri, 7 Nov 2025
 17:27:45 +0000
Message-ID: <a4b042ec-2e23-4af2-8c8d-5e46f37ba32f@siemens.com>
Date: Fri, 7 Nov 2025 18:27:45 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Switch defaults to Debian trixie and CIP
 kernel 6.12
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB3993:EE_
X-MS-Office365-Filtering-Correlation-Id: 73800917-9b66-4af0-f40c-08de1e22f6fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dEhwNnNmU2tZVkJKcTJKQjRXU0Z1ZWU0cWZKUnFUTmdUNXhrT1R6MlFSL3p4?=
 =?utf-8?B?RVMzeWZQS0R2R2RNZ0tpcWZTVlpyRWhmNnNPZUNFcXFYTFUxcUIrWkk0WWw5?=
 =?utf-8?B?ajNjY1J0UGdlMXo2L0ZpU2liWFBIdE95YVRRQUxkd0pSZ29McjlQV0Ixb2F6?=
 =?utf-8?B?TXlESXA5eEhVUHhoQ0lqUklwekx5ZTZVcC9Icm40d3U3WUZKamNyRXJaQU9q?=
 =?utf-8?B?aHplT1RmNXJlWTFYWDdqZWxhUlV2aTVzK2VRdTd1Vllmd2p1SUJSQ1lMRmVz?=
 =?utf-8?B?RmE0bjZpU0dQZ1dIVWdSMHgxU0F3L2xLb2lzRjN1ekZKbXBXdVZnQlRubXZh?=
 =?utf-8?B?NTFUSGoxMzVpcjF2dVpCOTBSN1RSaUNyUVBBK3hhVlR0K0s4NTBDZExtc2Zq?=
 =?utf-8?B?cThvbFJKYjh6QU1rWVRUODBPcElZdlpXQkZEd2dCZncrdlY4K014ZTAwV0lx?=
 =?utf-8?B?VXBKTUNHQTZ1R01laFhzOHpDdFpPNG1FTHk2d1JsZHVWZUdIY0x4R3lZeDFj?=
 =?utf-8?B?N1NJekkzWmJMNGxpZ2dMWHErV3JhRzZNM3k5RGdZaUJaUks5Yy9JRVdKY284?=
 =?utf-8?B?VUthM01sNm0vSHppUGJQMExaa1V1cUorR3M4WHExQVhqNmMrSEp0d3h3ZWND?=
 =?utf-8?B?cjRISnhxSGNWZDJrdEhLQ2pJUit1VTNURjVJQXpKWFp4WitodHlieVJ4Nndn?=
 =?utf-8?B?MmluTjJ0QnJhSnU3QzBOelZ2ZWI2QjFaY3hLOG9PYzV4TUkwWXRrMkN6cFJN?=
 =?utf-8?B?Kzg0UkR3ZkI4Y2k5djNMSlovUGsvRzFFYWVBa1lDZUNPRWduc0lQUnA3Q0dD?=
 =?utf-8?B?WUNXWmxCMERQMXlpTE9wbWkwb2I4Wks3OVdjMDVPNUgvVjRSL3VUY1BLTHRl?=
 =?utf-8?B?Nlptd3hTdFQ2SUV6N0hJT0lGcUtRM1ltUUpaUGVVWk1La1ZYZjhtV3dQTUJr?=
 =?utf-8?B?WnpjSnBtcStJWGQ5Y01nUGR5SEtnZmFSNU5PSUVxSmNXTVQxN0ZzVzRNSGs3?=
 =?utf-8?B?L0dnTm9mamJ3cWdUVTlyOG4vSXF5K0FkSEZZSEt4ZzdPZEYyRkFtb1YvbHVC?=
 =?utf-8?B?VzFiQ1lQMys5TlkzR3ZlOFRYTFhQampWazJ1TXBlUDJxd2UvTmF5V0t4NzdZ?=
 =?utf-8?B?YjZMenNpTkpqTmYwN0pYUjlJRWZoNDJlWnJyZ0R2emdrVjdiaVZHQkhVR2tY?=
 =?utf-8?B?SFJ1bXFvZVBOMjRzcEFvTFNjaGNPbEJTUXI4aXFET0NrY2FVQVAzUFYveHVB?=
 =?utf-8?B?NXk5cVQrMmN4dVZVY0llQWlVc3lBQXVURjBQbkErdDhuaDlJc05ic0h2Ukla?=
 =?utf-8?B?NDhEQ2NaZkJucFhJNlBiTXJRd1BySlpoamdVR2xXVm15YWRjSHlkV1ZGSWZj?=
 =?utf-8?B?NnRSWS9wWXVwVHFDbHdocnA2bS9rOHB3d3kxTUFvN3NnWGpzeDlNV25IWjF4?=
 =?utf-8?B?cWFSVm5PZXFZeHIyWU1lMTltNEgrbnQyRncrRnVNdXBVNVQzeGdwTW05bEQr?=
 =?utf-8?B?VU8yQkczbTlZQ1UvRjROZ0lEQUx6b21saUM0aSs4bzhhK2UreStScWtBSHNo?=
 =?utf-8?B?eHZBZ0xGZFpuWEtRVmhaTXpsR0tzWEMwUzZmdDdxU0xtV3hVVDBKbWRYbXVi?=
 =?utf-8?B?ckJtMkgwaXJvSW1qcHJpWEhWdVB0eUtwdit4TXNuUitnNkh0TXJiWG5TdUhi?=
 =?utf-8?B?UTBYdWVoSVl4blg1QzhCVEwxZmpIRUFtVys1eUpvU1dEYi9zU1AyL3RrTkND?=
 =?utf-8?B?UU9HbS84eDE0OEwwU3ZERGdZMnFsNjRiTVF4ZUt3SzFOQk1TZEQxQVNWU1Iy?=
 =?utf-8?B?a0MxNlcyRVJuOGlTVi9GS1d1RVIvaFR3ZWlCVWVrWHdPYkxVQjZkaUd3YitB?=
 =?utf-8?B?ajVNRTRwbk02M0J1MUpYU0R2NmJIeWc2VUxFdGJ4Q1BvdFFCSDRkR1RpdXBx?=
 =?utf-8?Q?rWS+YLDdwON6YmcMmH7C0BxqBzGu++Ta?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z0E3SU4ra0NSeTZkeEdYYm5EYmdoQUM4OFFEYlpnOVBNMVpQbEtyT0w4cElS?=
 =?utf-8?B?MmI0WDhCMlRaN2xybzNqLzdpNkcxMTJxWnJiR05zWGxoNURvVktwQzQ1VkM3?=
 =?utf-8?B?dmR5a0VaWFVUZ2pmS2p1U01ZWTVDR3VPK1ZVU295VitqckNwZXJPaFNTUWVa?=
 =?utf-8?B?cVc2TGUza0s4R1Z4d2c2WUlQMWhoNlA2N0JzY2Y1NGQ3SEovTHVZcDgwaDJu?=
 =?utf-8?B?VC8rcTNPdi9sTGhybGdiUTJieWZ1QlZyQkxLdEFBbHFCTGpydmpvZjBpUHps?=
 =?utf-8?B?QUhzc2tOa3dqcG9ROGp4djQ3dzNyL1JRSnRwV1BBU1hMQm1uTndGR3Era3ZX?=
 =?utf-8?B?ZDgvRWRPeFhYVldsanhvZSsveXBHUERIZ2VvSFk3ZS96SklxYWl1RExyZXRJ?=
 =?utf-8?B?ZEUyWkhwU3Y2RnQ0dnQwNi9VUzNpOGsyNGx4MjRYMHRzTXlsNVVRM2FaOXZC?=
 =?utf-8?B?ZWZMVE1scXpzZGU4TTVqSThMV2thWWR6bE95L2xpVkh0bmhvM0M4ckhwVlZW?=
 =?utf-8?B?OXlCNFFrdnJxS3dBbks3MTlmMzFCMjhHbEFqR1FyaGhyTzZvTksvdkRVSm52?=
 =?utf-8?B?NGE5KytLSzA2bUJBWjA3aXJtQ2thbUVGMEhlSG5DekdNZmEyWHJIcHBzQ1dE?=
 =?utf-8?B?NWRydkJ0bHZOSE9WQnpXRzFSeXAyYkJHM0lnUU1odm5VMU1wd2RnNG5ObHp5?=
 =?utf-8?B?bENtWFVrdnc3VUk2bEcrcDBTazF0d01zdDdjZWM5Q3pLTzBWRTN3Tm9STGIw?=
 =?utf-8?B?dVQ3UFlRYUloMmdJVjRNRERhUURwbUJ6ZW9IYjVUcDdJRW0wVG5tVHM3TFVP?=
 =?utf-8?B?Q2pLSStCUnRaWitmbmorOTBBR1lYaXdESEVCekNlclBiZDY1YUVZTEJ0QXNS?=
 =?utf-8?B?dzFnQjQ5MEZCSUhzVHF1azlKbHJOZU9sVVd4VktFcXpYZzZEVHIzM2xDaXhV?=
 =?utf-8?B?Y2RRcURTZjRjZFRDb0pYK0Z0ZHdaQjJnbzlBVERpMFFVZHl5SGl2b3J2Vlgz?=
 =?utf-8?B?eGhPZk5ldC9PNjFpZXFHd0hnZXFqMUFGRFJ3VmJCb29pYjFLb1BNK0wwaXFw?=
 =?utf-8?B?TWRKd1RnbWw4YUprZWxGNVZaRWQvamc5Y0xqRVM2Zk5vbGNuckZ1RzhzQ1Zl?=
 =?utf-8?B?ay9aQlJ5dksrSjNnajdLTlJNeWNtWXhrQy8veFNFcG1Fc1FSYkVWVE1zbGFn?=
 =?utf-8?B?UkxwSFBia290YUMzM3l2REVlUFE2bFY5K3pFakcwV21ud045UlBqb0xiN0VL?=
 =?utf-8?B?VnpTcFpMWTc2R2o3Z3VRczhId2krRnFNNTF1RDJYcTRNWFViTGx6ZnVhWDRV?=
 =?utf-8?B?d1NRY3JLaHlEbDdNTEZkeExkdEhRRTMvb0d5ejgyYjV4cGs2WlBQYkdiWDIw?=
 =?utf-8?B?Vi9TT1pnZ3poK0NQNGxkK2ZFK0pDNUtGSHB1L0x2cUpxaXUrdm0xQWp4Ung5?=
 =?utf-8?B?Wnd3S3RKOHhJbXB4V2xxakVzdW9USC9MUjZpc1NyR1ozRWJnNnMrR1BKYWtG?=
 =?utf-8?B?dk84c25PYnRLM3ZUQjl0SUwwOGsrYkwvbWFocWdrdkEwY0JTZlloT3hIR3VZ?=
 =?utf-8?B?bGVsbExocHNqVEg4ZG1DSEhiTUFhbkFTd0toQldUdDdSQ2RlUWNONXlQbE5W?=
 =?utf-8?B?QUU3M1V6L1pCcEcvYUVoUDBheFRWNUZBYndmVGc3LzVnTThmNno3WDFxU1pq?=
 =?utf-8?B?MGhmdDFwazRra2NSeVQ0ZXkrNERCOGV2Vzh2QWZ0c21Gam9UQXBLUDBNSzI5?=
 =?utf-8?B?VXdNeXRJQVZVbGVlUXp1VHB6a0xRMDhUZ1FMUUYzR29mMjJHNnFnYlhZL0RB?=
 =?utf-8?B?K1hkNkNzVWhwOXVqTVJRcmF5TGdZOHNNUFZRVmVVQ1JmNkdpS1FGSGRRbjJx?=
 =?utf-8?B?Tm1HRXArWmkzZk12Y0xRRXljUURSdGhCcnFibWh4bDJGSzduSC9RTktNaklJ?=
 =?utf-8?B?aUFiYnFtSWNIWEpSUDkybHBKZVFHcG9lVzUybENZcmg0N0VJenZ1eVRZQW9m?=
 =?utf-8?B?TXZEODRoTGZ1TTJqczlXTk9Gb1dQWENPTFNXTXBhYkFNZStKSHNmWEF5dncx?=
 =?utf-8?B?NGVwOG1NTlJsTkM3bncycDljdTRGMmRqRXJ0VmFmSlNQVlRPQWtGa3B4WFZX?=
 =?utf-8?B?SGhNQitDV0dqTEhqUHZ4Q3AvQWRkbHRPNUt1aEZPQTlSOGpCblZzNk95U28v?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73800917-9b66-4af0-f40c-08de1e22f6fc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 17:27:45.7256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jv9ES/pSMGUa7p11HmFEob44rv9imsXZ83qayU0p1uJKyZzbaBHPq78xkY4x3omNXDsqFm+e4awAsy7IjYI/hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB3993
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Nov 2025 17:27:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20475

From: Jan Kiszka <jan.kiszka@siemens.com>

Trixie is now the standard for several months. Along that, kernel
6.12 should become the new default.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

CI is still kept at bookworm for now due to some open infrastructure 
issues.

 Kconfig     | 4 ++--
 kas-cip.yml | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Kconfig b/Kconfig
index 71649f6c..68773bc9 100644
--- a/Kconfig
+++ b/Kconfig
@@ -103,7 +103,7 @@ comment "Kernel options"
 
 choice
 	prompt "CIP kernel version"
-	default KERNEL_6_1
+	default KERNEL_6_12
 
 config KERNEL_4_4
 	bool "Kernel 4.4.x-cip"
@@ -180,7 +180,7 @@ comment "Debian distribution options"
 
 choice
 	prompt "Debian Release"
-	default DEBIAN_BOOKWORM
+	default DEBIAN_TRIXIE
 
 config DEBIAN_BUSTER
 	bool "buster (10)"
diff --git a/kas-cip.yml b/kas-cip.yml
index 19e634d7..b7d403f2 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -12,7 +12,7 @@
 header:
   version: 14
 
-distro: cip-core-bookworm
+distro: cip-core-trixie
 target: cip-core-image
 
 build_system: isar
-- 
2.51.0

