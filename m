Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5404FCD98ED
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 05:10:21 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.71])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12766.1781759414759002952
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 22:10:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZpD5PKxm;
 spf=pass (domain: siemens.com, ip: 52.101.69.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+QYCe7xaMX/KTfgnvLdkLuQsVtzXzi/ixcJWgpn0c/0fdflLQgCU9keiITdrsTmu7in6seRsN07qQq2+OlNHJPHC1dhQJCPALDyNtyuPFf3DWAO3VHxzp81NF7AxIb/upXxrbxkxttTVAuWXlbhE53ks/xl7wrXZVyP9LCxEP6scbesQ02lVE1Psqb1gYB+IKLwW6E4QOkXJ5Ge1gLgZTX7HgMsB7V5GzS2rCt2vaLGFdaC7/AibvbnGBN8amyxe7CDO3JKEwdPavEY0H5FkuA4sV/l/Z5XQxA/wG5GdaeFXunN49heRnz11X2gUl4GVYUb03RlOYvCP2yD2M5SOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G14nvLNBQr3+11soUAjCNzVBFkR2+5Tkg2k35SV6neA=;
 b=nerZ8mpUddlw7sPx0AocRLS02CBFuwjM2Wt/aMfEIDLhx9h4og1WfHBtIm6mc2B6Jgk/spfWTrt74ds9Ax+f3nJgkJAiq0alR9YVvXdKRapd9tguAQCuyJYNMpBlF5s0DNNvRZQzatwN2s4kLzsLxazuObJB0OOhMn6XizKmt6zKa52Ban1e8N7RvHMDSldIz0KnFMokfYjmoCybF8RAx4fY5KCOE1WK8VXySFUJCrB96xmP+qlNsou9WOWqECbGl0qFuZfeXmwxkk+uKHbzRtO/lDSn9IgeJK6FmDjNCVQK/mnRptZApMfDnlbA2iMIHwzJJfMwqIKZWwm5g+aCDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G14nvLNBQr3+11soUAjCNzVBFkR2+5Tkg2k35SV6neA=;
 b=ZpD5PKxmf4yuJ7NvsEVuEVe5v+cDOADd2zQkwPqmzlDeboQ805r0iCikfY0vUewEMIIUEUvtjgYfnYW6iMLCYDg+XUgyOvHWy/HGEWAlP6IIPFh17It7FxpHZiFtjQBqLoLLAjhKt09BS6+PNZdSh7HXflxfcvId/WuPO2vgn96aYfHkDlHPOfifUxZtuW/5Krw8J3Z7tG+QyIXgZThj/hqi1kbCArhYc+GgC67nIyR5MVz1jEvnt4usNu95IKa1lfSzoO/nMkUj5tSUebx6SxuQRhglb6h25cdg6xv55N6R8Z7bo8i2+6SkjPTt2f+PjCpryu6VFdoRpI7juIOBSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7878.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 05:10:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 05:10:09 +0000
Message-ID: <3cc04da2-c239-4100-85fd-fe2c0f096284@siemens.com>
Date: Thu, 18 Jun 2026 07:10:09 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 5.10.258-cip74 and
 6.1.175-cip57[-rt30]
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0359.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c48c07-5e37-4af4-48e1-08deccf7de98
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	eH9SmhD1nM89o7tk6+8TTSIyAtugzwjn/OqWZmtkN0bh2gK7yXWJZ8US9QWLhXB5Q4SLY7MitdiuDBypCAoxtPQxKBFst6J2U3MkH1SFrDLA/wkenlpsxmfeW8FpbJ8QavAb1UA2kNaiV1aJbnaZ37HJJWHs/hvMPfIBVbukk5nfo4OA2EuPnXnay6yx0EkTaeLtHWMaRM6H5Pf8CvQIj4OXCJnMajpuS1OjCL64qT8XjRfADP+IhoB6Tkn+DrpyytikqvPwlxjLEGuu9qHzM+tI5Q+AzJDRzo0nPYl65CNZERsC18JqT9V+smCGu9mrjn3K/R2Caobru0evFaiTMXxqKJcQ/C1n3xcJHlzH93iDjIDl16ihejIfxwS+VME9TwBu8Y30rW+gq01i6q6I2nn5tlNb8OlNdauq/yhVswFKw6YoUw4zftOYxi1ykiOndtCAvTrNg/zxdmooG7B++xaL4xPs951Miyu1Fi10nRqBUhq6uOWU/wABHt5B2ZkbXHBz7qpUe0Sxb94rZD+mQTWA9PhFUb5mlP6Os1cFkmzi1lzNvq1F9l7ENHQKQhp/xf26gTN2ReH57GiRPLAvhhF+3o0RwiaUhBbfBgFIseSNsLAr4fac8JBH2i3eZEwsulbvhDKpq0/qx/UB5SCPrz01lK9jmLzuyodFyYXdEV2vRdzhxyG1ki30qNxzFKrd
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TEw1Q1pGV3JkMjZEUlZ6OUsrNW5GL3BQOUNMcGVXbXZmOERYSlRySDdLQ0tk?=
 =?utf-8?B?WkUvbEViVm5XV0Y2dE00OUplUEhvU09SbXcrUll3aWhzaVF2WjY1R1hXWnI5?=
 =?utf-8?B?dWZLZ3lIUXk1eTNNWlpZcnZCQ2t5SWtxWFZmS1g5WG1SQ1lFbWQ5UTJSbU0x?=
 =?utf-8?B?NWpsdUNiWHl4UEdjZS9UV29wRHlKbHVFTFpDL1RZbHRkTHdUR0ZWZGRhbHk5?=
 =?utf-8?B?SDNUNnE5ZVNNcEdUWlFJOHJYcDBXckxCOWNBazFyRnNjcnl4RVdDMnIveGFm?=
 =?utf-8?B?MDlKblAyUDd0QnVTZFlTQXRJTEM1NU1wSzRONEVOWmc5M3I1UzBWWk43MGVI?=
 =?utf-8?B?MnF3ak5uZUFTZ1JWbjBXdmkwMGppdzJTVE5NNDBDR1IxUlF1d05BSm9ETUZv?=
 =?utf-8?B?RTV1ZnFDdDBLemMxMkRteGNBNWxQaWh5YXpNd0VVbDl1d3BtdzdGb3U3Qm9o?=
 =?utf-8?B?cEpYenRIN3JmdUxDVDBobjVnTml0UTRsWlJENWtiVXUyZENGZUx2ODJRbFpz?=
 =?utf-8?B?dkl3WkNqTVc2YVQvK2E5eEtEalZzcXFSV3ZpNnNWVGJMeExtNFJlcGpaV2FN?=
 =?utf-8?B?TklBVWphTWZicG14dVZrZ2dLK3VpR2pqMVdoWUZ2a1k3V1FMS0Uxc1ZuWFNB?=
 =?utf-8?B?QzRoZVc5S3lFTXl3OEVXTWovMUN1RkhmVVVya2NqN0RQTFJ3UVplUmZoMy9M?=
 =?utf-8?B?RDRJTUpaYzBuVHNrZ1JFVSt6V05YeEx0UHdNcmtzOFM0aDNZSVpPOUlMZmFl?=
 =?utf-8?B?UkFTK09vQ0JIT0g5VDBzQ2ZuVXpKb1hzSnFBZkhMOGFCV2p1MkhyZ0xxcmhW?=
 =?utf-8?B?cytkcS9veWs4Ny9WRzk0aUlZSmt6ZnZZenBJeDFwVXZSdUUyZHpNZzI4NjFx?=
 =?utf-8?B?bFB6TEQ2blZFTXBNS0h5Z0tGSVBldm5xUHVRTHZaUFZ2dUZiV01xL1Vodng4?=
 =?utf-8?B?OUtLcVlFMDNuclAydUNqcWdscTFCc1RFM0hoa1FLdGVmbFp1Rm9Qb3pYdDhG?=
 =?utf-8?B?WkhKQkZJb3U5T2hGZzRRdEwxd3R2M2dFM1FaMXBieWFyMk8zWGJHREdTV21k?=
 =?utf-8?B?TkNuL3FacmZXOWR4QjRuRW1mMXJIQyt6QngySzRZYytibWJvcXF4RFhveHBq?=
 =?utf-8?B?NWNGWlRGUjdCMU9nclQ0dEFMbFZnR0ZDVWEwY2srSG5YUGhKWngvSmF4d01T?=
 =?utf-8?B?bllOR3krN0E1OWhjVlB2MkE3VmYydDFRZDhKWWw4OGY3d1FnOURyNk1JN0VC?=
 =?utf-8?B?K0Qza08wTi91MTNtWTNnWU1SRlJmbXlhZ2NNUkJmOFpUeThzWFpEOSsreXdv?=
 =?utf-8?B?WWtGWmtIcCsyTG45TktEdGJjRXpDRXFKM3NUUDBpV0hkeXlCRXo5K2o2RTZy?=
 =?utf-8?B?ODlHb0tRRzZLUWljWjRjck1EWUpJZVVBMVd0b3ZOVEttbVFId2FLaGdrQkVB?=
 =?utf-8?B?RHArUlkwNmtBelRCNTNGb3FoTlVRRm8yekE4RldoTDRDVTNqeTk3SEgreGNz?=
 =?utf-8?B?SFFteVBkL1VnK3NVSW5wQXA0U2xmM2Q1SS85SUZSWFpKbUtxOURYRUlCdTlQ?=
 =?utf-8?B?anRINkIzOFptaGdLQzJaZS9KV2dPZWJTQzM3d2YzdENtWWRsMDNHa1RyempL?=
 =?utf-8?B?aUxLdE5EUTJIT1hUVXZZeFl5bDNxSGZlYjNUaTJxajF3QTNUUk5hWXF0RTEv?=
 =?utf-8?B?NzEvOWp2S2xLbEcvbjlvajVHcVFaYUFUV29nOG1aRlRkTW5oTEhlN3o4VDlT?=
 =?utf-8?B?Nk9uSkE5K2VtTXkvMklkMWxYNWVIWmZOSkRuKzlYVlhPVzBYT0cxMUpzMGRE?=
 =?utf-8?B?ZmE2R1lOZmVpTjFTV2tHL3QxSGxIdURDY3plS0sxakd3VlJBeVp0VkdINVBR?=
 =?utf-8?B?NTZvVllhcWVBOUZPMkFoQWE1YmJiZWw4WGdzRlBmK3ZTMFQ4Sk5rVXprUlpL?=
 =?utf-8?B?aVJkZTgyVHBFMFd4N3dTT1M4QkJaOTZubWt5UUxRRmtpeVBBSDNheTMzMHBS?=
 =?utf-8?B?cDI4cUNnbFh1VHE5WXU5NUFmQ3hSdWdlMDRDQ0RzeUpnNHVqczhIQjlIK0p2?=
 =?utf-8?B?Y2QvSnJsSDN3MmcxU1Fzc0hIcFF1bUxxdnlsTWVPdjl5U1BZSnNkQmMxNG5I?=
 =?utf-8?B?UFdncDNHd3Z3MTkrQUNkcVYxVlNzVm8rODZyLytodHRRWXRQODdYUHVjc041?=
 =?utf-8?B?YXVteXFucWxkMUZnaGo4ck1CS3lKR3pjVXlhbUVqM01LaTBaZ1JMMk0waGxT?=
 =?utf-8?B?Nmxrc3lRcElzTDRXbHZRdDhHQm9iTkIrKzJqcjc2dVlhZUo2bm5JcFpJdlR1?=
 =?utf-8?B?OTZHb0phcFFPWHFKVGhYSEZsY3grWEtSTTdURStQN2lOak1nY25EQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c48c07-5e37-4af4-48e1-08deccf7de98
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 05:10:09.7869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tEXhiS3KWowR7ps/ETAHOHpRJ2S6KvF20xFszWFDYCW566TP8HHowd/AEom6yuRwJGP8puoPKGZfAS5P+u1lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7878
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jun 2026 05:10:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23222

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...6.1.167-cip53-rt29.bb => linux-cip-rt_6.1.175-cip57-rt30.bb} | 2 +-
 ...{linux-cip_5.10.256-cip73.bb => linux-cip_5.10.258-cip74.bb} | 2 +-
 .../{linux-cip_6.1.173-cip56.bb => linux-cip_6.1.175-cip57.bb}  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.167-cip53-rt29.bb => linux-cip-rt_6.1.175-cip57-rt30.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_5.10.256-cip73.bb => linux-cip_5.10.258-cip74.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.173-cip56.bb => linux-cip_6.1.175-cip57.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.167-cip53-rt29.bb b/recipes-kernel/linux/linux-cip-rt_6.1.175-cip57-rt30.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.167-cip53-rt29.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.175-cip57-rt30.bb
index 52a2b585..37d5a329 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.167-cip53-rt29.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.175-cip57-rt30.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "a9066c102875e05f34fa9192d87f204f5ff3f5a237fd0d210e3fe3179a5eefea"
+SRC_URI[sha256sum] = "a75064376eb4ec4c816ae11381ced89e0a8073bf90c30391cdbbceffd8f254cf"
diff --git a/recipes-kernel/linux/linux-cip_5.10.256-cip73.bb b/recipes-kernel/linux/linux-cip_5.10.258-cip74.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.256-cip73.bb
rename to recipes-kernel/linux/linux-cip_5.10.258-cip74.bb
index 44c98cba..3d6df804 100644
--- a/recipes-kernel/linux/linux-cip_5.10.256-cip73.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.258-cip74.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "b911f12ba8975ab4c114713c03275662457190fd9709148a4ad735705019e7f8"
+SRC_URI[sha256sum] = "6f6c15a038ab580786c2c0fe3c499fccadebd0c1c0957457506b0fc01141e6bc"
diff --git a/recipes-kernel/linux/linux-cip_6.1.173-cip56.bb b/recipes-kernel/linux/linux-cip_6.1.175-cip57.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.173-cip56.bb
rename to recipes-kernel/linux/linux-cip_6.1.175-cip57.bb
index 1138c238..5169f9c1 100644
--- a/recipes-kernel/linux/linux-cip_6.1.173-cip56.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.175-cip57.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "0332d054d7ab7f74506184d1616ac9dd9d77ef2f33c3de1f7128466ec0d8d933"
+SRC_URI[sha256sum] = "4c3e2161e11ebd8f1caf5d62a648472e15896d056e2793b4033168f450eca8de"
-- 
2.47.3

