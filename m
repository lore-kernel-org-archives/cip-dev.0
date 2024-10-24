Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951BECDDE69
	for <webhook@archiver.kernel.org>; Thu, 24 Oct 2024 10:01:36 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.85])
 by mx.groups.io with SMTP id smtpd.web11.10873.1729764094163929011
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Oct 2024 03:01:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jbVcS6J4;
 spf=pass (domain: siemens.com, ip: 40.107.20.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wj5PEFfbMTFXBlyq3XE+ZyXauQmhrGrAZddz7tKArqIh43LbOtHi4u82FwEvSCJQ9PrIGHDosXhfWRoeUjO5Vy0mD+rRuQymvHebgc2Ehx/VR6ryz/w5HlaDkiM3bcjVSs6xplJSI8aVvSKbqjr4PnxrDWXX1juKLOqswuwq0A26gi6zVzSbXw4fj+X3yCmnYJdH+CpENiDcC00ixuI8sym6hx45yc91mH+EEF6OZZ9635j8HnxB7zBijczPdJ/JwTliaHolPMCcDrogiBpqMwFvCfu0eSmFTovJQsWuo3I0AJkrSC0umibkTSgdFSqwYk7CJKuJkPKzGpfjI6vgeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqHVsrS+Gh8DhE8G+AxhuVSBByRWWBJ8qpG/seQ4dao=;
 b=tiTVlOEz0yCGBYWRDIKhLPzf6qEokn9fn68LCgX0P1CMPO9LB0N+cEArHCIcD2nJL/chHbhSvXFQSM76g3o2Szm7FcXwT49tWXDuEX+x1Ut/Lyz8RC9mOJfWBOOTi+xzHdGF4EIKoKMyGWnYWz/ypPARmSiOn32srQdz3ib2Gyi887e9XMOYThrrPfjJ7U/JK/O9OcAeGvztGWZ0sa1v6I0e69hJ82LL7o54XcXbyjy062QHbFuKMk/4Ee/dCWAGb9mK/oRcA2FCz3W1n0miXcPLFRAGbtBlGFCznYUe0o8glV6lZZiwSclQ/seR0mtLNaW93lhkgvf7s+9JC8U3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqHVsrS+Gh8DhE8G+AxhuVSBByRWWBJ8qpG/seQ4dao=;
 b=jbVcS6J4MdnkMBDOjtMkQLjDyeCMxHx+vzgp1M8Audl8sCK9VkhWfWT1qxiE6IkyZIEcrwkwpcDtE23KCZYxsDTbFQdJMyMS9qNAi1/idpyuvzY1Yu4kOWyzv9IJMUh06o09aE6Nbh9os/Ikg3bDTe/nP7xMMnxTzkKPuEcmg9y1Q6H8ygROHu430A2s4zLo6JO97ssyOxnlPw0uCzjAf2mxtx0NTwYHNIIpb4YiUNZ9/0xRbHdWzhfHigmxydkQGXoj5t/NeCOB7jnHe4jpuoOI6TzjXEarCwX6fb95WWmYo0Zg1YMTcPudjwIdnn25iSKtGLyht4bwHu1VM+BH+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6916.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Thu, 24 Oct
 2024 10:01:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 10:01:30 +0000
Message-ID: <4b2469f6-3a1f-49f7-b340-5a7006a37900@siemens.com>
Date: Thu, 24 Oct 2024 12:01:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] localversion-cip-rt: make correction to -rt16
To: "kulkarni.vinayak" <kulkarni.vinayak@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20241024065045.549653-1-kulkarni.vinayak@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241024065045.549653-1-kulkarni.vinayak@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf6599c-88d5-4a3d-fa89-08dcf412d51b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YnI2WU51KzQzNUdkbXNHOVlDUTVmUFBxTmMvUVp0UStMTUd5VmZXOExpSUcv?=
 =?utf-8?B?MnN4MzREYk45M2JuYitmYjZzWDE0aG96aE1LYkl0L2RFZ3pjckdVQ3hURkFI?=
 =?utf-8?B?WDh2a1lnMVF2TXpMU3Q1NkNZbTdGOVFTRkJwRzF1MWFKOFhlUzFHcC9NT3Zj?=
 =?utf-8?B?NS8yVWpLcGZFTUcxT1I1NXhNY09rRml1TndjbisvZWhIQzBKK2gyUDBabkZG?=
 =?utf-8?B?NlBhTmVGK1ZKb1FiaStQTWVIaThPUVp3NFh2b05UcHJORXVBbXFrdWJmOGZO?=
 =?utf-8?B?elJRRHlTejlzamwzV3g1VFJQcFgveDJwY2lnQlpkN0trOVcvL0JvM09qcDJN?=
 =?utf-8?B?WnBTTEhhempxYlB4eTh5bFlIdnl4dVpNQTZvWWZ2bEtsRGxiQWZrblA0cGE2?=
 =?utf-8?B?ajd6Y2xoaHl0aFROcVdpM011UU9XdEJPVmVvVzR1RUF6MC9tSFV6Y0lONXoy?=
 =?utf-8?B?aHVRUkdVTWhwZXRHcEhSNSs0VC9hYTF6YXJ3K01RMXRFWGNQR0RTa093NDB6?=
 =?utf-8?B?RlZ6UWZGN3pneHgzYktpems3SW1ndUdhaVBjcVBLK2RjSGdmUHdJVGpLaHZU?=
 =?utf-8?B?QUhPdUphS05BOGt2aWI5UE9wNFNOLy9zeTdrQmp2dmdwS2szVTdKdGZ6WGRC?=
 =?utf-8?B?MDJQZmgyNGMyaTZ6b3dWOXpBcUEzaEtyalZXUEtTVXM5aU5ib3hmbHNKckVx?=
 =?utf-8?B?TVVsSmFmTVRqZWhHTmlXWjZPU21LbkxsdkZ1Y0c0aGFicStaTk9kbENjckdB?=
 =?utf-8?B?NDJ1UldCQS9pQTQ2ZXUrMDVqY09Bc0tndFN1ZTROcTM5SzgrQVZyOHV3OG9D?=
 =?utf-8?B?c1hrNk9pa0tCY1JqZjZDdURkdFlQZzlncSsrY3BJVThSOVVMRTN5WW9tQnNH?=
 =?utf-8?B?bVRWOEo0ZzJFQmVxaDdBSkF4Ym9JbmFzUE1zSkZ6dG55RStJZkRoYVJvWnZK?=
 =?utf-8?B?bVVkNkVkZmJ4dWdRU1E3cVhiMlR4bG1KT2dYb3FEUWJNbjFPbFd3UHBVaDBF?=
 =?utf-8?B?UmhSdmdvZEdOTWpYTzJhWjlYamM4VUVMaXZReXQ0bWFDRmF4clQ1dGZRbjNB?=
 =?utf-8?B?Q3Qzc0p2Z0NBUzNIWXk4OUFNSVNTaUEzMVpxN2ZyS1c1dG8rcEZGK2NCeVBy?=
 =?utf-8?B?UVphY3BlR0wybEJKbFNkdWgxcjlNSGRKbzV6K1phdXZ4VWF1YkhSL1N3MDdU?=
 =?utf-8?B?ODl3dWFhOG1YSFNZRFNEZjBxSmFYdmF5bGpOa3FoS0dwa2VWVmY3Q1AyeVNm?=
 =?utf-8?B?Z0cwZXlrVmpnQ0VOOFlYd1RqcXNhbWh0ZDJpSVplZFFtS2J2TlVwWlRGWUt4?=
 =?utf-8?B?VUtVODlPbGZOZTljQis3UlpTNzJzSUZIRVpYRzY4ZWYvbzFPc0lGQkI3WkxC?=
 =?utf-8?B?UTdIeHllbktkajV6NncrNXRZWnQ4bE5YbzhXTFNCR2Qzd2w2NTNzTzBrTktJ?=
 =?utf-8?B?bGhWUlpEWXNzVkRTNGI4L1J6cEJVeDIwaE9aTzFwcitSQVo5NHg4bTNOSE5h?=
 =?utf-8?B?R24zZzUyZ1JzVHJJYkxkMEhZc0lGakwwaTdlUERmcW9zZGlyUTA2bklXdGxZ?=
 =?utf-8?B?ZGhiQzB0eWFZN2Mzd0x2ZXloK0owODg2c3RlTGZzT0ZGTEtTa0w3ZnBuV2Jl?=
 =?utf-8?B?MzVSd2ZmVnVUaXpHSStEb3Z0OGgyZlo4Qld5bUx2QmdWdEtDQ2FvZVQzL3ln?=
 =?utf-8?B?b25rSEZ2NWJocmxnK0EyWm0vejNzeWZkZzNmNUpVS2FENFd4MFBGeXBQcjY1?=
 =?utf-8?Q?XnJzIHPUfzFagBg30C3s/omX2aGsnblKSgZHJnl?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M2tBK2VON3NkczNVOU92Y2ExQkFieWZiSk5CL1ZPa250OGNkYldMVFJIaXZ0?=
 =?utf-8?B?SnVEL3JVcFdPNUI0TVNCSDE5ZEJ6d2FkNWFiKzU0WUtyQjVBR255NDI4UFp2?=
 =?utf-8?B?NjgxYjBjVzN5RmV5bFpRL3pySFJ5NFVKVlVXRTNXN3g5a1JhQ1BUMm9jMG9N?=
 =?utf-8?B?SW9PU0JxTUFHTEs4aE93dFQ1UGk2RDZ2ZGMrU05veEJqUTZKYTVDdWY0UWtW?=
 =?utf-8?B?NGJTdFplUGlXT0JFQVhubGZ1WWhOK1k0VCswc3g2OHliVkRPWmp0ZVVLTVIv?=
 =?utf-8?B?em02ZGludDU4ZG84NlY4dkdWNzJuL3ErV0JmT3NhN09DY3pqWWZOV1JNVTlB?=
 =?utf-8?B?WkszelQ4aVM1blhXYWRLckFsTDFSVHl6bkNxd2xCdUhhR2JjaFBHSHYyQzRj?=
 =?utf-8?B?OG9SaldxN3Z1c3VrdWRzZ0I0eVRoMWVOc1RlNXU2NDMwc3N3VGVJaG8wTHpu?=
 =?utf-8?B?ZzRLM1JUUWtiaXFQZ0ZNOXFjSUtna3o5WmRzYWJscXdBOVg3QTc5bGdJSFFM?=
 =?utf-8?B?UGdKWGY1UTRudE5tSFBuSU5OK0hvVnNsWElrVmlDQUVEZ0RFZ2NWaUVPc0E2?=
 =?utf-8?B?OW1VOWQ4SlRLaENkSVo4WlpoZHNzWlY5TExPc1JPUWN3MDFuS1dxaVplV01R?=
 =?utf-8?B?d2tCak93OWxuZ3NDT2ZPMS9LckIxWVA2UElROG9RYmhWVUZ0VXd2TEFNN1hw?=
 =?utf-8?B?Ykk0cHZnTUVSelNYNjRkRlk5UTk1dDlpN0JmNjU2M3I4L3MzVHZkakZDYnY5?=
 =?utf-8?B?VDBvbnRVNllXR3p0Y0V6eWpQNWVLWXROVGFBc3dNdFMxeGRBZ0s0OTVZV1FO?=
 =?utf-8?B?QzhnSElTZmNGUGFEbUUxK2wxeFlTdDZaWFB4M3dSNC9PRFVaU0ZrZTdHWXJt?=
 =?utf-8?B?anhlSU1LbEZvOHBzUjZVTkJsZFJwOThKY2pXejdIQ1dQR05LNEFIY3NVV1pv?=
 =?utf-8?B?dWQxNlhENlEyVWNmV3JsMUxXWDRBL1grNW1DcDNpNnRKR1dIOExhZ3JOSE1L?=
 =?utf-8?B?Vy85Z0pEVUtHWmxkY2hZT1NLZ1RnRGIzcGFCalFXcXFCU0FxTUxMUndia3Ri?=
 =?utf-8?B?VCtZaEdRaHkzbHBaM2hTeVVMekVkMUd3V2MvVVBlN2w1RkNjTG5BQWNMdTJ4?=
 =?utf-8?B?cnhhWUM4eTNpTmc3NHRRNTNTaWt4T3I5ayt2WmZ5V293YzdiRWl6MERBU3dv?=
 =?utf-8?B?OU1UdzJVSUJ1dUJFUytieEUwdURDaVZqMTJHMnBLbk1rOWloZU1nK0lWZXcr?=
 =?utf-8?B?TW1yb21uMWNnSWJtTGttMFl2TERLcW1jSHlJVzVDUE1wTXhTM1RlWTNJcUJj?=
 =?utf-8?B?a3lHK096dDFCdkF0empkYkZiVCs5RUh3Z1NJVUp3Y0xaTkprZUFNMWJOa2F4?=
 =?utf-8?B?aUdka1FBTTZoTTJGeG52UWtzWFhKSkt6YjlvRFNtRUxlQml6SjNINnc1cHBs?=
 =?utf-8?B?eWU0MHU5TmpTejJPTjdLNnBmbmowQTdBK0ZBMUZ1b3BpclNpZzJ5ZjMxeXFx?=
 =?utf-8?B?cFNhS0J0R0F6UVdRZEN1THNKQ3VlOXg3am1oZVkvaTI3dEpPVEhaRUwvRjMy?=
 =?utf-8?B?QVZ1YVV3c2VFNUwxeFFKSVNqTE9FQXFxeXlUVUpCRWFTTjdkZmNROHFMK3U2?=
 =?utf-8?B?Tngwdk5TZFNHdXFVa01xWk0yL3BONnJVSjhwSktwRE1LeVFQbHU4Z255Mzly?=
 =?utf-8?B?U0prV1lmengvd2pnSE41RGU1cGtyS2JoNzV2aDFCb0RXOFU1UkxDWUE3c2l3?=
 =?utf-8?B?Mys4QVVNRkdhTDJLbk5KZHhUOTNJL1F5ZnBxSXZabnF6S2JNSzZJOTZYUURQ?=
 =?utf-8?B?SWM0S0xLRFNsd2ZVbDk3Ui9EbzRlTzd3c2tXRmdtUFgvd0FqajJmMzJaemlX?=
 =?utf-8?B?N0RKWTlMM2xKWnE1cy9DbW1LaGFEaHlwMmFqLzZzRFNnOGo4M2Yrb1d1aDYy?=
 =?utf-8?B?bThSQjRjOHdxZk10dDEyU29JOWtlc0ZCVGVUbjFRM0hsTHVNdDhjRVk3MTU4?=
 =?utf-8?B?V3VSR2dDcW9JTEtmL3F3YXpoRW9GZlBZOGM0cDJzcVZqam1peDNpTUEvNXMz?=
 =?utf-8?B?SkVyK1F4SmttbGQrVWlHUWFqVTBBaVh5anhhVUhYWmpjNFpZQng5ZkxlcXBo?=
 =?utf-8?B?NGxwWkhaVXpPbDdTcGFVcThHSC8xVEQ3YnNOcXppVkVUOTVPdGZuKzJKY2hw?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf6599c-88d5-4a3d-fa89-08dcf412d51b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 10:01:30.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ql0THCySdDX2EHkX1hUwfCQYSCw7OFk6BwlNCqSnl7TmuVuCvpClBY54ozTjoNMKrmVGZpt4qykZ2pH9oA9FcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6916
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Oct 2024 10:01:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17077

On 24.10.24 08:50, kulkarni.vinayak wrote:
> Update to proper version matching the tag.
> 
> Signed-off-by: kulkarni.vinayak <kulkarni.vinayak@siemens.com>
> 
> diff --git a/localversion-cip-rt b/localversion-cip-rt
> index 3eedd3bbecbb..1199ebade17b 100644
> --- a/localversion-cip-rt
> +++ b/localversion-cip-rt
> @@ -1 +1 @@
> --rt15
> \ No newline at end of file
> +-rt16

See
https://lore.kernel.org/cip-dev/b274adfb-c698-4c98-a68b-bb92f710a598@siemens.com/T/#t

Jan

-- 
Siemens AG, Technology
Linux Expert Center

