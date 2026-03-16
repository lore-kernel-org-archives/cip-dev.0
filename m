Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E01F4644F
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 11:19:41 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.10])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47997.1773659975949829961
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 04:19:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eCqpK18E;
 spf=pass (domain: siemens.com, ip: 52.101.65.10, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZsvXF+av+xjfUgDtVj8qSnOCme9nt/ad1zt/hjaj0Ph7KoGv81cJA6O+c/gE7PKGi/hOtl5DVq+LLRA9EHz4iZddor1QB64gqReILr/ua6LMEpHinjznpMAvfw3kP1dwIYGZRBPw4FfBeVYfBIZUvPdAdhuSBabikBzxTd/2/ZL+iHgTi0wAwxRKgfvHnsRw/cmBNGgX3qhKHjRCbxdIbS8I6jWdgX/4rKk8KkKClANecLfZFDxDJWuSOH+BX4TGHfHp4QkkBy5wcSwT8Y/JHrsnWT7OrtUgrxiXhnaZy7sgX7Q85aNHBPLNn5ASB7YnmUKLgravZErmyOCwH5zWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQ6X32FopkIdUW3QdeJ/rYtg7WitLdoTaIA/yWnbEVA=;
 b=tuzPeGLltHdvQnrk80VFDj/ijSKucEhmvH9TUDux+JiH6QbZQuD2+xomm9jxjh4l5tZYRi6jc3uww4hwxcQZT2PUMS2a0uxVONc8HFJe0GtkbR9ihmKmJGz+H9BlCvFlqlUkKQD5w5ykHWsXjvEri/TXKFmkiB6LelwiHCMT4oWKJo/bKIRtiHAvID3JnZ2HUtGMzszYeUcEl+noDLdB22+uH0cW3P9hj1Qc6H2Gqpfutg6z5yIvjlYaZ7F7R6ebz8ZmMDrD5qPE4uXslnr332usr6uXh4KqE6tTfFQECVHDkTCmY2g3Xyyi9sbhDha3V3pX8oFbx9tjAsGWdm4pCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQ6X32FopkIdUW3QdeJ/rYtg7WitLdoTaIA/yWnbEVA=;
 b=eCqpK18ESvUzPLD+dFRKeR9vc2zmfqVtLJRrzU+FqqxOgEq6DbatJ2JMKumEz3uAElT5WrJ73i5MfM1eDvZHvesppeJhg6/VpC2pHJ0Iqq7E6L8IUZ8yzNJQiEKuxvvxN67NznbboFfY8DBIQDQKDS+YWOBpOadTYdhd+xgkUg4F36kh4nf6/tM4G6ZM3aRfnmV679QfJ9EgcRNyQ+gUMOaVWEjnNJgudPqFjSJiModk8cclhV000jmm385SNS0i2HgbkCUhp/nHt0mDTXc/K5Q16vCykoOg+RbtnnMXNXwrRtPBB3LagV7O5AMWpJmD9cBsWrUhykFj0jcIv1YzSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8427.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:21a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 11:19:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 11:19:28 +0000
Message-ID: <4ef4e7cd-a3ff-4ab7-9adf-5f23486fccd0@siemens.com>
Date: Mon, 16 Mar 2026 12:19:28 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] scripts: update-linux-cip: Switch to fresher
 mirrors.kernel.org
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CWLP123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:58::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f6c929-63b5-4b52-99fa-08de834de352
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	n/jH+8BFXQSNHXUnNx8ZM2FvAZiCHeb9CgOrISyegf4a0++AYxriUEG7mO6Do4z5U6w5T+gr+45DU55srlBDEeMt6EFX11nRiUUnEhTDI6M8Q0te/Vu1cq1cz0jEAT8hgSzMYa1n5I2TXtG3Je4IHQCsLXfqxeZuX18TJLvpAw+uDdpNXvCvUZqWTlMBc9lvajhLPIFaErAgBsJSM6GHIssnXFhL04uqrAus5eujOMozaoyGV14hPE3QB8ZOfrUxdaPnWQ32KoAoHikLk1Q6R3+oSpBedypIt29El+PIDJzYz1NuK2r4fu2E+nXUu4c0xd3HMrF6peWN9KFmF5nMYAGDkfAGjyuxRbo//+SPXvRiTqjlnrAfNJ/HkXAkCcWRRgjkbmInSSU+x1n7AkiKDiXF/jD1qlQ+Yh7z6SlIkwjMb1i5tOeqLR2fer9A4xuzJnhDaYQ/24Ux5EO/RuNnqI2L969iqkcyGVFgzpkWAFoyi91xg2j9Lp/K0smnMlFfvIGdxm9Kow8KFyJw4qZZFIVwvp+CykAKi3uJgWdMLfVObpxV7MYwV7Xy0LMHZX7ewPQa7QAGcwVWcKBpADiOis+KLwYl/ePqbO8Hno/ymsO8T5efLQV0cES3XQJQPB0LoZRKRTqREp64aAtrJDYQIWFbA4cow6hbeq8Ia2LUfBjJcYrjAb2eaODvNb1oA1XQlXTSLrnb4I9Ot6gng0ETeBGmkam4bV0Ccbl7NF8KE/s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R21pZmZ6WVlkSDFaa0NiWWFRTUhWYVdON3NCZS9SaStNNFpJTmg5QlcxNGtZ?=
 =?utf-8?B?N01EZUFUTDdLS1BkQ3BuRTZPS2d4SmY5RGg2ZWNUOHVHVTJSMXVjRGo0c2Vp?=
 =?utf-8?B?U1g2Q3B1VTNZVExpMEF1bE1pbWtKVTFpZlkzSS9XOHF6bWFGN1FDR0R1K25V?=
 =?utf-8?B?RjVKRUlrSXFWcmNxU0Y0UjIwWCtsTjNXeFNxTWRHK2VSNTdNYm8vZTRNMDkv?=
 =?utf-8?B?L3B5UFBDSktCYytVV0tVVkRlaWZ6ZGtxSFdGdGIya2tiMjFOODB1dmV6bTc4?=
 =?utf-8?B?ZDVkMVUyOEdBUXVZcVBYdC9NSnI4SDFDWWU5YkFRTzBNcmJ4Lzd4K0ZzYktR?=
 =?utf-8?B?cUxIN2FJQkZPREFyT0lpdFljclkyTkhoUUpjNk9IOCtMUWpoSlRxRFlYZ1hZ?=
 =?utf-8?B?SVhhWXZmS3B2OHFqcU9FQjkvN0tFTHVFZFlpM09OTlNaK2tjWXAzaVZZK0Zq?=
 =?utf-8?B?c1JmVFltOGtqdVhQVDRwQklRbzQ4aU0yRUM1YXQ4OEZRckpkWlZzcUt5OE5t?=
 =?utf-8?B?bG5na0pTVEU1ZTVYTUVzaDBvMHhnRVNmdzVyalRucmJkaHJBWmpjNmhFd05Z?=
 =?utf-8?B?Yms2TXF4TlowRzkvZm93TG5VM3FjSHM4bWhJYm1Fc2JmemlZYjlWN2ZXUVJ6?=
 =?utf-8?B?QWJJOVMrMFhIZ0dxRGtBYkhNUmFqeEtaZFBHWDEvUE9RS2VpTEZnbzVkTEJ1?=
 =?utf-8?B?S1dxNFVncTJ1Tkw4dEZIMUYxZjlpYm1KUjJMSUMxRWxVdEJCVTVJL0JTdFQy?=
 =?utf-8?B?QVB3YmNqbG14WExpSjJaYlhhYVB5Ky9ualhtTnc1Z2VHR3lWVXJYTFhIYkNM?=
 =?utf-8?B?bGZJZHVhTE55a2kxYloySDJWc1FoV3RKb3RTVW1qRnE4Qnk2c2YwR3NmSXRn?=
 =?utf-8?B?MUFHUWoyYnFnemQ0ekhBSDkvNVFoUEwzbzlROU5qUTNQTW5NUENJZS9xV3ZH?=
 =?utf-8?B?SmxRU0g5Snp0TzhobGwyeDlhSm5wdEYvODF1bDM5MndFQ3F4R3NiMkMwdmcr?=
 =?utf-8?B?cThRTXFuYjhhbnduUUxITmQyeHUwL0VSc0N6TGxiVDN0YkFDbG1xUFdzalZL?=
 =?utf-8?B?eUNHZG1odUMvU2V2NzNKK2RyQldHekJWaWFkMzdZLytURFR6N2xwU0VoNDVl?=
 =?utf-8?B?dUtqYk5MUi9POWVQMVFtc3FWNHZhVnBuQndyMjdVa1RUc2E1enR1akhQb0pl?=
 =?utf-8?B?bHA2ekFrK3d1dVZlKzdoY1dhVjFXeElEUzFBNXE1dlJTcnNJOE5GMHgweFU2?=
 =?utf-8?B?Y0tMK0VQajZkZENTTzVxdWhNb0lMR0xDZHd0UDJNeGZpeE16eWdDV3lIS2Vr?=
 =?utf-8?B?QUlUcG53dlpkOGN1ZXFxSFl5a3hEOWJhQTJ3NHV2V29lTTVjZC9nbnB5OENB?=
 =?utf-8?B?bnZ1Q2NlN2hkWGxHTnA3c0lJR1hwN281bTVRM0dBQWR5azVVRXNlbzJETWVw?=
 =?utf-8?B?ZWpvSHA2S25jVW5FVEhVeDB4bnNNcWJhNURiaW5rRWN0c2EyeWtvazB0aVc5?=
 =?utf-8?B?eTNvbk4rVHVkdndIc1NROVRhYUcvMlhob3daYWdIb2xwbllvaExqbmhMSGJ5?=
 =?utf-8?B?YXM2dDd0WXF6TzR2NlM5MkdBMTBNVDlyaHdhSTN2SlFCQmdDc3BlT2piTlFH?=
 =?utf-8?B?Y2JFdWRMVU1mVG8xOUd1NlFsTm9mVFYrMHlveVFqOU03eXVsa1BMRjIxQU5n?=
 =?utf-8?B?dUxEdVFPbVRYVzZEcldrK0lhSG5Db1BPK0VZMVYweC81N0VETjhkZnRCQU9N?=
 =?utf-8?B?Y3NFQjFMMnIwMG51eXFZMjJHZStJRk15SE50MXB5MXJkUkFkUlk5ZFVxRk5Q?=
 =?utf-8?B?bVJKVm53bk03ZWx3ZjVKQWpSZ3RvZitWZ2VaRWFXWXpHOVJtUy9vTWVGN3BC?=
 =?utf-8?B?aUNqWUU4Unl2bmFWcGtobkZPM2U4Q0NrOEtOQk44S0FiRHlydlFKSzF4OWZ1?=
 =?utf-8?B?bitGT1pZemRUSkl4REtUOUxyZHlCaTBpMFE1b0kwRXp6TlE4TGFaUy9WM1Rr?=
 =?utf-8?B?L1hnUGh6cGZudWlzaWNpbzJFV1ZaY2M5STF1MGdXSG04eW10U0RNaytYVUta?=
 =?utf-8?B?WERzZlVvQWJjZjJMWm5DRDB6WDlrUCtaT2VLZGNaRXdJK29ramhMOE8wb2d4?=
 =?utf-8?B?TEtUaG05K3BVK1F2RDBCUmtmMTZqUXF2QWVlVVZmNVB6SXdNV0Q2VnkxaC9z?=
 =?utf-8?B?WXlKSmNtbkRndWlzdy9oNkJCcFZreE15bUhka3NJTCsxWk80UVlhaE95NURB?=
 =?utf-8?B?MHBjSDFRZG9kNy9nRnFkTXEwckFDQ1BwbXdCTXNmbmdVS3EvSUdTVzNGOHlx?=
 =?utf-8?B?YjBKd01kc1AveEhUOVFtTTlkNWtDSWxwUEpwZDVsUElHUS94eHh3dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f6c929-63b5-4b52-99fa-08de834de352
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 11:19:28.4069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvhPaou3jKUaV/Q/NzsU6ubBGTadeUR6sNxw4WW86aaIGPUWU6OIb0B9XCWN4hTU/STET9B1sPcIeVhyntRivg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8427
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 11:19:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22381

From: Jan Kiszka <jan.kiszka@siemens.com>

The old URL shares for too long stale versions.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/update-linux-cip.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-cip.sh b/scripts/update-linux-cip.sh
index 5fbfa578..628bc4c8 100755
--- a/scripts/update-linux-cip.sh
+++ b/scripts/update-linux-cip.sh
@@ -4,7 +4,7 @@ pushd "${REPO_ROOT}"/recipes-kernel/linux >/dev/null || exit 1
 
 for MAJOR_VERSION in 4.4 4.19 5.10 6.1 6.12; do
 	rm -f sha256sums.asc
-	wget -q https://cdn.kernel.org/pub/linux/kernel/projects/cip/${MAJOR_VERSION}/sha256sums.asc
+	wget -q https://mirrors.kernel.org/pub/linux/kernel/projects/cip/${MAJOR_VERSION}/sha256sums.asc
 	if ! gpg --verify sha256sums.asc 2>/dev/null; then
 		echo "sha256sums.asc for ${MAJOR_VERSION} invalid!"
 		exit 1
-- 
2.47.3

