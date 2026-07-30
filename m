Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B76CC5516D
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 20:33:18 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20823.1785443593426540683
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jul 2026 13:33:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YTgegQfG;
 spf=pass (domain: siemens.com, ip: 52.101.83.32, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxA+MggYOuIi/tDmwueZkfEaF1GsD88ar0XiT+Ha9WYO1uBgXedrD6gXXo+KbuUX+O6JgTrspz6ieKSTBqoSsc/2NvZMWUGsO7CzY/5tikwRi+OzhBRkywGP/2xvRaTUh6cpeqYpTv8ClpmfqL5xGQUtPuY6hBF8lZGlT6eS7Pl9wHKkCkWDwsUBSJ4EXEdKXokbBsWMU7D6yeRXA4YVxnYEEZoe7v8SJ5aw3z4JW/G/rDAJ+GqsCi++jacCkFx7urYgqoZZt5LbPEanGjJemjuNCJGbdjxKU2g2U1DcR2TPFrhHn3g/EbNmpCwPF+9QDSkGkR3wIxhM9t3AVBx57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXvzTxForPRr8Wr8F92K/shTQZEpYg7o63UV4SOkp/E=;
 b=CnRvWA6i0fvLE39lrmjglmb1l+xqIIMF7/t/EbTPnaSmshCtfeAg4+tjdsBV4d4stP91qSsqI8g1Rl60s6cYWlfYPcXA4V83q+kIr3/Gbqi/tE+mjWU9FNZ58ASKog0//jDPtuxNxkRzDrHTYqVz0ujV0xoPSorNE1YvOINuaqJ3+aKuqJY1Yfv3aslYBk9ZQ4cFc4tImWzZBUbX5Vnw9OFGJJwXnU/dWFkZEoP4p8bZGlLlYbb5dIrAyMXLufj6hqc/RNdzcr9ft49F1y6gHmg8Qlx8BW+U3ageQajh02SABOV/lDY9GqSe2lnUQBIbRKMujKEBc22fRh/hnWoSng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXvzTxForPRr8Wr8F92K/shTQZEpYg7o63UV4SOkp/E=;
 b=YTgegQfGTlbjcy5aPDSRd3fUc5lN9Xd4zVthdXLaplC1uh+UaAWCHZlEat8UFNOyOUOnONBeGrsBQaj9nrEIZvCnz9hHxEpATueH52WRGY06NR6BwMHJtfaNzCB0DeNCNEi7WlEVvRadkpQmn8RSD2pXItK3KAc/MfX6AJdVkDMBFn90NStpFmOhmbxNnjD5qg2oPJVeAaMUiO3WBQVkS1S6AJlzsOXgSXL6pjhq2byom+kcluqrxvpZPSg0uxCgdBgodAF2YWkGHCMZcisQJo+tGTG9NYcKgAaBxe7k+aKuytPpWMDUnIGCzvJA1eOFwIzp6p4erUL19AgO5eVGag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5738.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 20:33:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 20:33:07 +0000
Message-ID: <4d61ec83-bb55-4c27-b370-0e2ed60bd800@siemens.com>
Date: Thu, 30 Jul 2026 22:33:05 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Pavel Machek <pavel@nabladev.com>, Ulrich Hecht <uli@fpond.eu>,
 Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>
Subject: CVE-2026-64560
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c891ef-7b58-4ea4-fcd0-08deee79c328
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|56012099006|11063799006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	9GyYF6oTP8hEbN1pR82Gid92bXXt/zAcGxL4Uw0gHZExMAz7xM6lDEdo82+0Be1bZxDOTtsREcjxUUmSeZ2o47o15pPyumgyUG8sfr0AVkORlYw3C7vjIBXo7gZppau3zD7WwR4uMOV9vnazMo7HO5ALgxyt/7F18xM34x0jYCsH7fT0IICYOh18iIoLtRZsqAdj5cTLPfxGKMM/NRSnryNVwtE6N06CaHeh+LvnYYAgs4GgabuRxXY3m9D+MeUG4k3chC2iMKXAVGF3N+CMjFdwK2e6lPUr2ZEUEilUuqeQux6IcxiyMbMgT3kYOIWbtijK8nGtfUulX1/+RBO7SAenHfAejGgq2Pt/dKN4yaBjO1yvboqaLH7QHCyxK3e1gQFtUApJh1H6jrnLuvfXWyYGSz8tTPBACUoUZdmXiLjufT8zJNtu5BIWv8PQdjXq3QJWQU8hZHgtifVsTHZjZ2r+GScNvZZZWOPg3VM11fOWW8Pjw885PSuXZzaVgcSTV2/rckk63eVMKmlO7Y5QO7cc6ZVBPnoH0TJm1L4PUPdv11myp3lj5vhvOk/cr3l9I3s3ZX/J0nR3prG2kFVEDS2tN4/EQqaj0s2WYbApvMKiy8vuF9W3Lykgx/hPdVU8WPQhJILBmo1+3uhAAHr4QD2ITGSmy2Q4m66zhJz+2/Y=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cUErUldYeVhlbGQ2dkJTV1g2R2k2Q2kvZUUybnk2cUNiWFovUXdxbkhNWU1v?=
 =?utf-8?B?d0g1dVRZa25QMkJWeDB0K3Z0Y3RmVUxmRVZkN0RsVHhVOURLMkw3a0JGNVBV?=
 =?utf-8?B?Zm1mUG5ibXNwSnc2Z1RFQlMzWWg2N0t2S3E0Y0tWWWgrWmF6cmdJcEQzcElW?=
 =?utf-8?B?eDlwVFZDVHJHS2NCdmZKelVRM2xUc2t1S1VTRmVwSFh1c21TUkhsVnNRdHJz?=
 =?utf-8?B?NStpMFgweVFDakNGaFhlWlE4UGdyeEx0eTlNOEc2Zi9SS0JqdGY0RHc0U1R2?=
 =?utf-8?B?ckhsVlhINmtvWDRrNC9CdU54Y0NVRE9XazhDUGs0UHlWeG9FckVFU2lQMXdv?=
 =?utf-8?B?WWMzN2UwMzAralpWcGNxeUZoa0pOemNBR0VPYkVQSjZxdlJ4UXdwNzcyMFpP?=
 =?utf-8?B?NWVSaitUcUtVTnJtWithTDdUMlQvWklRdmdac2x1dndpb0hrKzZqZlZxcEJy?=
 =?utf-8?B?N2U4S3Y1dlBnWnVkYTNMaFh4cGlkUHBUaTA5NWpUTG1lUDRmRlZkc1BIazU0?=
 =?utf-8?B?ZkE5S3MxZ05EbGRjTS9ncHFydXhjQXVCMUtKVXMxOS9RUDNzRkVCeGJmc01L?=
 =?utf-8?B?OG14SlhtTzJpYTN2UVUrVlV0cHRnR0xtVnVLdzRmalBQMDFIcGd0WVdSbThF?=
 =?utf-8?B?SWdSMTVJQUVzRnh1K2ZzUXoySE1tV0VNWlI4OHBpcjNpRStEZzhsV1Q5TVlk?=
 =?utf-8?B?dFpEek9SM01odUpsOWVUYzFGOHo5K1Q3a3RQZFZKanlJRDFmOUpWMnNNT1Ba?=
 =?utf-8?B?WmFLVUV6T29KL2VGYVRTSm5FWmFIZzRZaVZDMUhNQTRJeWFUdkFDbDNJS3F6?=
 =?utf-8?B?Z3hBVVhEL3pVQ2hhN04zcFJWZ2QrRXgzaFBkalp3a2ZCdUwvamhqT01DSEdM?=
 =?utf-8?B?OVVDcHhMc3o0ZEtxZ0tubTljMUtkOTl2Y1FNeFhDK0ZRM1oxL0RZZWhjMkYz?=
 =?utf-8?B?MXkzcUQvUVA3RjFaSW1NV1RTVS85L2pvUmJVeWZUTmYvNk56cEtMYkZaNklU?=
 =?utf-8?B?YXRFUkVzMERML054cEZJQnR3VlZlR1F4UWY2ZStyMlBwM2xObXd4eEdDR3Ez?=
 =?utf-8?B?Zlo3YXRodmQ5cVdVMENpTE9pYjExTlZubmNkcG1YNjhFVUNSL043eTJWL09E?=
 =?utf-8?B?RDg3RnlRbWFibzM5VXhSMU01bFNvU3YxWnc4cHIzUWhSbU92eU9oTDI2eTFK?=
 =?utf-8?B?RWVrdUkrbEFtZVVZYUtCQWdoRUNXS2pmZFFFd2paOS9pdzV3Z1RNM3pNNkFU?=
 =?utf-8?B?SUNTVEVodVlwK1JmcmtSV09tN0UvSzcra3BiUk5nbkJvc2JjWkJuazBvTFpQ?=
 =?utf-8?B?Y254U25FS1NiZmZwN0txc0Q0elU3NTF0Vmh3VkJOU1ZGWnh5cnFQSTdUbXU0?=
 =?utf-8?B?b3ZWNlBraHJwN0VSdTFFUHUrK3dYdjFsc1ZGWGFpVzFWUnlKdXVXSmQ5MWVR?=
 =?utf-8?B?ek1BNUwrR1kwa2FYb0pGZzdITHNMUlhGZjNHY1RQb2JycXdlWXdxbVNSUHlC?=
 =?utf-8?B?WmhyWSs0eEdGeEoyOTk0OHhuUHBXM1g2bVY4ZUx2aEVYRHlWa3FSMTFYYS9B?=
 =?utf-8?B?VU1Yd2tuQjI0TG5HT1dkSmtPenFvNTRKb0JaUzUxYWtnNmpRSFcwWGcvWTFB?=
 =?utf-8?B?cWdiOCtRdVJ3ZjRBTXdleUZiS1FYQ0dyZ0V3OXp4VFlhUHB3OTlnblFZeUNJ?=
 =?utf-8?B?SHE1OFFMQ0FsRzFYMUtzVllxbkRjUVgrVFdRK0p6SU1kaFlSTGUvR0J4eENS?=
 =?utf-8?B?dXZqR3R0U0N1Y0pVL2JEN2poNWQxOHJFd0JqNDRKUjh1WTUvRzZGWTlmUDhT?=
 =?utf-8?B?QlZDcCs0bHA2SVRqMWZnU3IxZ3dFUnh4RjBsQW8ybjdNSS9lYTlIOWV5cHg4?=
 =?utf-8?B?UEdOQmVxYURHYVBaYnJBQ3hWY0dmbmlnVExuclNNVkJsT3NFQ1NtcnZaZVhR?=
 =?utf-8?B?U0JYUldrTW1tbmlzOS8xSlRtZk44NWVtNzNBOGtmT0RUcFRRY0dNZUd0QVcw?=
 =?utf-8?B?NCtjUzVDNnUvZUJSbDlPVFRnakFFYjNSME9TYXp6aUNzcXFIa2RHZ3JoODZL?=
 =?utf-8?B?bjJ3TGQrYWxJK00va1NEc3lpUTQvNFdBUHFHQ21jYjEwbjVhNCsxeHdRdjNB?=
 =?utf-8?B?cnFqWnhzNHFtUEtTdjVCVVRHSlNnSHRSTGFmSDh2dmhTR29vc0xzYXJ3YSt3?=
 =?utf-8?B?MkJGYm40Wlg0Tm5wbEJBeDIvNGRFK3czODQvZ3pCbkJkQzBXQUl0U3pQdk5u?=
 =?utf-8?B?QmxrRGFzdU9QUlV5NERHbVIyUHFJWHFWQWkyTXhteTNwRXF6WlpYdmpMbGRD?=
 =?utf-8?B?Y2pkZGZ1OE1vRTJMVFY4MWxMcmdiRXVVQkw0NlkyblBSSXdxOHVyUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c891ef-7b58-4ea4-fcd0-08deee79c328
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 20:33:06.9381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFodLjkmLgT/qJpUzXB0H6QsPEVYLFpWNUPSGfJWgPT4AMarFiznxkZjWddaSLJTv+7hTpI3QbQmMQI7LyWPEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5738
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jul 2026 20:33:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23820

Hi all,

this looks like it does not need special drivers and is not that easy
to mitigate (CONFIG_POSIX_TIMERS=n...):

https://git.kernel.org/pub/scm/linux/security/vulns.git/commit/?id=081d2ff9592751aa400828237f17c108e4e1f513

Early releases?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


