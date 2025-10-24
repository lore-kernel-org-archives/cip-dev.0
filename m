Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027BBCCD1AB
	for <webhook@archiver.kernel.org>; Fri, 24 Oct 2025 10:12:20 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.49])
 by mx.groups.io with SMTP id smtpd.web11.6879.1761300739201791049
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Oct 2025 03:12:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dtYCZQ0Y;
 spf=pass (domain: siemens.com, ip: 40.107.162.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=By8KkriTyM412rSMkDHbVL8Kpm1uWIJbLTTKQ3K6iP/q4CzQalpTkY4/BdcwGG8UlEFpz9v407Tsbojiw5Ng9mDakhhyzO821dauHRysRaYxH76sZ8ux1TKlnMz/28+4cT52T/k+vrGv0mxR+fm/EH0aM10auHohGWhIyWzE/wAyzZSLik5SPw0xPQhHpgk8VcVl4IVGqOyP2Gze7LwdjAbS2j3mtPipl9tLEheOE1kfpPeJLIcDBtyjJuOg1hAnMV4AE0Y1f8A8wzPi+XMpY2N9CQheSTi3s5EztZJ1itha4zToa7Omwhmts3Vl9fkotkqz5ccZnd048p4JUIvDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oycL93v7hw3loQKFcnGdixQGmFvpURvmux2g5YeHGbs=;
 b=xQ/P5dsUquGpvEtT2Rlp6WTZt97uCpWQlPphoiV+l47ShGsLxKgHjxx9/n3E3f/Ez1H/CVH/jQGEb/RtBySxgHAR4LJuwb/QBn2iZKtrD8zt6ZHvUmjnXZrjgRM6PXECLK/6JJBQsZlJQDNFe8zgpTRAy0Tgxt6eAQmKmuSlj5AjV4EJkwWmxdxjuNDsRZuMgAK6pre4YcBcJ5+hnymjx4SeWvfCnpQSCntVbKNu24VINFK3fiuiL/3ALciA5SBlXVnb3flmbXjyW8RJF04/bUDLlq6AvukuLPeeB5za9CazTtkJV3RpzO3U2v1VXXPI5jn4LTmIUKL+CXkapzYbqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oycL93v7hw3loQKFcnGdixQGmFvpURvmux2g5YeHGbs=;
 b=dtYCZQ0YXDoofRdcICtR/d/uDt+SkEW46RUCKDmQeDYkK8MuhrVggZuUnjC9MW3xGCtbpfHn12Dre1O1CBeGDmScCh8anMogU9sRJA3RzB/d8JWxK5QTP54SpsV+nw0R8AKZnHQP/A6WfmW4aDlECE4srU+bhXr6OKk6L2fcgSRohhRqOKqSRg+LWfK/kLz0ozmgZJZjKXmM7laSyz8VAHsTMip4K62wK9zj8YZAn2JKoXZtanT39Q0VYLuHUq4LD3DVF587yFzmoFwPXp7/gCTPo4TOxwzFF9cOmC/Ze0xeafFRE4DjZiKuWPrIIOJ0ohe3tikSQf+v4L1CWrf1xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6803.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:478::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 10:12:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 10:12:15 +0000
Message-ID: <70896e59-d6ca-41b7-b06d-bac4238d95f5@siemens.com>
Date: Fri, 24 Oct 2025 12:12:14 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH 1/2] read-only-rootfs: Fix rebuild from sstate
 cache
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0345.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 26607529-abd7-4dd8-bce0-08de12e5ce77
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M2ZDVEM2dVU1R1lUR2k2MUQ0cTNoVjh0MjJiOWJqSzVBbXFKa0pQZXZpQ1pU?=
 =?utf-8?B?bE1DWWhlajdaLzIxNmJINGpWN0N0Ly8rbUVEaE5mcTdRMWRvTC9LbytsWGho?=
 =?utf-8?B?bHRaQkNmckhiVXVWb0RWNVBDNmRhQWFDTmRzSW5GQUxlbW5oRkJPTGdwRTJN?=
 =?utf-8?B?T3lpaXpvRWswclVSZ3k5dng2SVBuUDhXbU5ZMnMwamJRYUVtNDhkd0hxazJa?=
 =?utf-8?B?aTNZTjh0dlN5RHJjMzE2UHF4NEJPTTJleXNRVVFEejljUy9Hbm1jRW51WkJs?=
 =?utf-8?B?RUNCMzVZc043eVBkUTVwYVhaazJFWWVTUGFteTJ0aEg3YXZxRGcrbHRBdkh2?=
 =?utf-8?B?K3Q3cEl0aDEwR1lEREZnTTRTbUpKYitRU2p6KzR2NjRyVGprZGRURDhDUy9C?=
 =?utf-8?B?MEFxVTRiMG52Y1JvV05iRGxRajJZVFpORGpVaVd3NFloMjZhQmVNYUxWTTJW?=
 =?utf-8?B?TnowVGZoR3J6NUhlb1BldExUQXdEL1NKUGJjWGNnZ1cweHJSUjBPZUhqOGV5?=
 =?utf-8?B?VFRwenhwb1lVakRTWXQxT3Zvb2oyRGd0MEt2VHNmd2JjTXhCL2hEM2tVUHp0?=
 =?utf-8?B?ekEwbWdGRTBQRXVlWWRpMlVIc242aFlYNVNDMWpVSlR6WDl1ekhGeFY5Tmds?=
 =?utf-8?B?d1JrbUUrblUwQlowTURiWFNRNFlVYmhhbnF2Ti84bWZWQWVuVUhqbWJ1ZzYv?=
 =?utf-8?B?NEd0YkxUK2dSVmhiZ05MWnFPQ2hnMEdBTEZIR2FYYTVBOEpzcDUrWGRqQWZP?=
 =?utf-8?B?c1NBNjVzUGFkK0VUS2t6aUl4U1VHRk1UTmVyWEJQTG9qdk0rVDVWMXZ3YS9O?=
 =?utf-8?B?L2Y5eFNNWEx0NXBrVkFBZG1QcXRsZFJEQ3pzKzRZS3FwdUtGc2dKdEpjRmJK?=
 =?utf-8?B?Q2NyZjNsZjJncG5leXpUVUVEYytyb015ODhDaW5OdmxNbC9BM3dkcFlid1Jq?=
 =?utf-8?B?UTNhSjlIandQSmR6QXh0WmVLZkFEUm9HT0tsYjJYYzhhQVc5Y0piVHQwa05x?=
 =?utf-8?B?MDRZWXV2S0JGcTBGZkhoRnJnZE5oQnMxdXFRQU5FVjhxdzVBZHRBOGE0d3NI?=
 =?utf-8?B?UFdVQVFIeHNPRS84Q2wzWW9nWlo3MkprL0FaaGZhYU4xdzU3RVdTckx3aXV3?=
 =?utf-8?B?S0paeklacWh2QUJlVXlLZXdydW9qWEtYaTRPeXBaaG1Ha1d3aUtWU3c0Mmlz?=
 =?utf-8?B?cjNLYXU4QVBnU2VCYzVpSHZUblNFNDFOcjV4U21sNjE5b1MzZlR2Sms4T2dl?=
 =?utf-8?B?dnVlVG4wYXVkSS9rZWVOZi80NENZbm5XMzRoaStxL2o5SzY1L3ZLUHpER0pj?=
 =?utf-8?B?R1pyNHpxUUZNTHZtQUVCTVZMdHlvaGFTNGMzQjhQamplN1lJWk42eDFBZzNq?=
 =?utf-8?B?cTJUZUFPQnJYTWFJaU4zUkNXUWhRMVUrZ0tncEE3UU1HWldaYzMvaVVGbnJx?=
 =?utf-8?B?dDduRGpQcHZtcUMxVXUrUEZmdmR4c3kxTU0zb0pyQk1LWkY2M0g2and3dDFQ?=
 =?utf-8?B?L1FFYnZKSlIyYVJIa1A4cXJwa1pSU0FUSWtGU1FUeEdySG9nSFVGNEdzOVR1?=
 =?utf-8?B?S0RSS0FoQWdsSHd5b3d1RUdHZlJENXBzSEVSVkRnWW9MblpsYmR2ZU44b3lM?=
 =?utf-8?B?eHhyVDRWblpJeThha04rcjJzaSs2RHlXVm1ZNnkxelR1ejZ0K1JJWU5oK1Zs?=
 =?utf-8?B?aXl5RkVTaWN0TlVGSkFRemxaMTIySGtVeUZJb3RWRHlTdGtqZ005STVmOFhi?=
 =?utf-8?B?TEprLy96S1k5Zm9WWmR5NVJpbjhtSnBLS2RBTEJ0bk1KN0k0M283Y1BQeXor?=
 =?utf-8?B?dlh5MGEvVkRJUnVIQUhkREJ0dklEOW44ZUNhYzZwOFdVL0grMC92WnAySm9Y?=
 =?utf-8?B?dHQ5YU1OeWxCUkFYT1VjaXFiU283a1BlWnFzWXlkMnh6V3hxdXNBamxBL3RE?=
 =?utf-8?Q?uv4qd5oZMMlsgGkyyVq6c2Ek+CRbnIIc?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S3k2STVpeDUwTVFmVUpiZThEZzIwQ2FIU1lTazR3Q2J5UkxWTysrOW1FeUs0?=
 =?utf-8?B?ek9wcGMxVmhzUm9QWXpIVXlxOWVEZFpLREhvL042T1dOZ1BFMWV0ektlQkl6?=
 =?utf-8?B?VlBzcGVWS1RnQVVhN3pySE9VNDlCUnRwU2V4YmpsZXFzeTR2TFdxYjFwZEZ4?=
 =?utf-8?B?eEdRWVVwZjRmSEViR3drYnJhZzJEZ3RmKzFMRzRITDd0UVZMRVhkTGdwRUEw?=
 =?utf-8?B?d2RwWXNNN084M0NZTDZTQ2syYjhnY1FDZ25xYVFCUGJtVm1YN2tZaWVsZ1dz?=
 =?utf-8?B?QjNJMlZNOVVhWXRiQ2NrNG16THlicEE0QnJ5VVJpL3NPeWNlenJGLytHd2ZY?=
 =?utf-8?B?YW9TWVdHb1k5R0N4cGQxaHFYY0JRdkYyZWQwT1VQcTlQaUdBcmoydjltT0pT?=
 =?utf-8?B?Q1MyTUJBdzNRRUJ1ZUY2ZXhpWUt6TkMyVzcxTE1BMVY4SjVVL21kdk9xMk9r?=
 =?utf-8?B?bkZIRERraHoxdW1QSWUvT2VYRkVoNFltVGkrcTRZVFJzcDhrTDJ5Q0NpOTdE?=
 =?utf-8?B?ZThRazRqMll4T3BKWENCVEVzclBhUDU1TjZZN1BsRGRVLzRrU3hxQis0VmFk?=
 =?utf-8?B?VjAzQmppd0U2OGlNZlJCVHZvay8zK3BxVVJ6VTBjb1ZXM0RzdzhBS2hteHNw?=
 =?utf-8?B?UTd4UVd1eGdvU3AvZU00bXI5ZUJYL2p1d0wwckh1Y3VCbFZYaHE1ZEhFUlpI?=
 =?utf-8?B?TDRsYnpYNEswcmp1ek83OTNicGxKTlpIRUgyclNrN2hnd2FnUlN0R21lNzRM?=
 =?utf-8?B?cFlja3B6aCtSTytHY29KVk1HaG1wVitnaUNLcGxESTdTcjZPNmpvTkxMRTJM?=
 =?utf-8?B?UGc2YVhkcXpIa1IzeUI4cFZ1OG9Ib3hrN3d1NkhJM2JTTnNTVUJubnpWY2V3?=
 =?utf-8?B?aFpqa3hWbW4ycDBpdDdVTFNCdzFGM1lUUWlMVFpGQmo3VWdGb0NYc1lyTDQ5?=
 =?utf-8?B?dXUzUzJ3b254NDROOVY2Z2NlQVpCK0tLaWwvL2xQV3FMRFBZcGluVmNNYUpN?=
 =?utf-8?B?YXdSMEZBNStMVXRJVWJqZzFBS1RqR0tmVXUvMWpKaUhXajhHT2haUzVwNXlS?=
 =?utf-8?B?UUNtU2VZMm14K3ZKRUoxTEdiZVc5elJxN1NUVjQzeUxWN2hKQnFVUVBhRnNZ?=
 =?utf-8?B?UFdUMkZvNFFaSk9MRmxxLy9NaHA5T3hGUnJtRUlKVlhNSXhIaVpnOHlQT2o5?=
 =?utf-8?B?WDdHVVVYRi9xS3VvZnIzNUs3S1RkdnBLMVN1VE9PK09OT2J2RDdnWDZKdm5y?=
 =?utf-8?B?cXRLUGpPL2MyZWRLdWtOa2VNeEhNNFRaWEhhR09ROUhxTWVscldob2dyZnRG?=
 =?utf-8?B?NU0veXoxY0h1Y3k1aStSU05NaVhObld1bndkeGxSV3gxZXhnenNiV0lGeGlx?=
 =?utf-8?B?WVVPaVZhUVRzT25OTll5NGp2VlVLbUx5YnVGZ0hRZ0lIdEVkV0VZNjl0MTFj?=
 =?utf-8?B?TmJYdFA2RnBZNFVTSDRvM0F5a3NXTkY4MmlLcldJek5BT3pHY3J2akhQOEVN?=
 =?utf-8?B?V2h3TVd4ZlpuTElSNmx6L0wvQ0Q0SVlTU1NRZUhpUWRMbDkrUlpaUmJudFY5?=
 =?utf-8?B?UXZucTBWTHdUWmZ6ZmNiSWpnVmU2SFdoV3AxVWJMU1F5ekpwbHF5VlphOVZv?=
 =?utf-8?B?NjFOM2JYWld5SkJkVWZsUnNsNFR3VmR0T09MTzQyaVpFdEF4ZE5nTUZtZDJS?=
 =?utf-8?B?Q0k5dXFoRlNYZW1YSkliTnZDeFBaWXBicVNFWTI5OEhFaGVJSDZ3dGkvQ2Rj?=
 =?utf-8?B?UytteTRRM0U4SGNpa0pSdDVqWUltaGNERm0rRVhxMDhqdy9BOVNueGdmb20v?=
 =?utf-8?B?M2Jhc1FDcEdkZkd4bHZlUUpwdkhiZEpQSHJsWG5UR2ZRNHZTUS9uYXRYZVhx?=
 =?utf-8?B?NXRLdnFXaS96QTZXOExhOUxOYlFkU3kwMGhrOHZML1M1cDFDYXFDSW9iVkx2?=
 =?utf-8?B?OHZoLytpT25IeTJMNDNzcHg0MFZ6MEw5YnhyaTVZa0svN0g3TU85aHpZRGhG?=
 =?utf-8?B?d1piY3lqY09JOFdidDNra1FEaTNHY2pOQmZhb09SVi9NSS8yV0NyRXo5VHpx?=
 =?utf-8?B?Vkt6akl5UnYxYTNsY1pYa1lGVHZhUm56bFM4Zm1JYW1EUUwzWUZxdzR2OGtP?=
 =?utf-8?B?d1BDeHJjV0h1Q2prYTk1ZXJBb3lUM0hLdit6cGErbHVqeG54SHR2RUdMNTNz?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26607529-abd7-4dd8-bce0-08de12e5ce77
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 10:12:15.5740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqcSkmcOXAAozwjl+pVGV6+glBRTs9LRq2yh5FyxTskH1fnmKWfhLf5CIV0U5OgT24Kr7ZTVosWWd15xMI+5fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6803
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Oct 2025 10:12:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20217

From: Jan Kiszka <jan.kiszka@siemens.com>

When building the rootfs using the sstate cache, home is already there.
Purge it before running the mv command to avoid

| DEBUG: Executing shell function copy_home_to_immutable_data
| mv: cannot move '/work/build/tmp/work/cip-core-trixie-armhf/cip-core-image-qemu-arm/1.0-r0/rootfs/home' to '/work/build/tmp/work/cip-core-trixie-armhf/cip-core-image-qemu-arm/1.0-r0/rootfs/usr/share/immutable-data/home': Directory not empty

Fixes: 786ddaab07d7 ("Move content of home to IMMUTABLE_DATA_DIR")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/read-only-rootfs.bbclass | 1 +
 1 file changed, 1 insertion(+)

diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
index 998269a6..6a21e9e3 100644
--- a/classes/read-only-rootfs.bbclass
+++ b/classes/read-only-rootfs.bbclass
@@ -50,6 +50,7 @@ ROOTFS_POSTPROCESS_COMMAND:remove:separate-home-part = " copy_home_to_immutable_
 copy_home_to_immutable_data() {
     IMMUTABLE_HOME_DIR="${ROOTFSDIR}${IMMUTABLE_DATA_DIR}"
     sudo mkdir -p "$IMMUTABLE_HOME_DIR"
+    sudo rm -rf "$IMMUTABLE_HOME_DIR/home"
     sudo mv ${ROOTFSDIR}/home "$IMMUTABLE_HOME_DIR/"
     # as the rootfs is read-only we need to create the link
     # between /var/home and /home during creation.
-- 
2.51.0

