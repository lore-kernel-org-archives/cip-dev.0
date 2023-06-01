Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74286C77B7A
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 10:34:49 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.54])
 by mx.groups.io with SMTP id smtpd.web10.27360.1685615685346216070
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 03:34:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=D/Ki/yKu;
 spf=pass (domain: siemens.com, ip: 40.107.8.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfIqxGUc3Z/g3/uodY0rUgjHI3k9aN6RdGXp1NKagJ2p699JGpUpQr/gGOMBsEm1DehpqhJyVkDFs4f5jfpYStT4+8VQaOz7qpTs3P8gFrg5H/Hdj9YY3fFgNQJOahFy0obkY4LxzRa/5ddSu2Cc+qboMHwgqVAotFe0WiTHTJcKermUCdvIR+t4GqdHq9AjpkSk6ja2NcpLugl3yHFATW8NAjotpHoAnZYjLVmk8M//Dd55toTBqTcC2oOMA8bqSqrsxOA/B45yF7lhV3vfgs21lhn5wcTUyR+8Vf12+9jLkqQssVWYcnYsFVpUPjLLQxihrAkaoL6+xUh1xdhujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRs1eIfVK5wLh3rVKjE4Jt6pMy/63sPAI3Ud+00iXGI=;
 b=mxGXweEHc+mKFMr+T1LMy7xBBBnPyC0hKuVAKQRNs82AM5SPOmmDXvEr2W2/ZlLbv6XgQvHZUrIDsnZs8dfHPeaAmHe2b/P5bNIVStUrlL8C6NT3AwmOtQJ6BNTSd9kJ0g33CAr7Efiqw/L0UDgLycarG4bmGJH0iwNp1he8w9cQIU9p09QAxtj1jHBT0tbaG8pKImhpzfdmNEW3RQ8khcpAu7tMAS0uyrPE8gOFcFeHRljxeHS1B9D6rpaUlHTeh5cWMut5BRLO07z07Z5PKP0OFu7zrgFfkUQCYpjpGWhwVKPgOXtuEDEe49k+cZF0yMVIUHyd1ViCnbxiMGuN7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRs1eIfVK5wLh3rVKjE4Jt6pMy/63sPAI3Ud+00iXGI=;
 b=D/Ki/yKuKNa2wkCuAl0VlFXelNDk3BcQYDHCCJIZxdkqibA8tMNr+RmvNIrN7+L4vc8RdaFD743AF0XBxbug3zHhaTqyLy0AgFtOpxOsFTCmREMXbayu/rUHdZ9ckDPyChH11UHHLdOtubuUbEo+cB5Z2eM05Z7ciG5hpES3v6UbbAnVPKHfJcPAOpPICWlvO0OLnBzDAuszg2txjT0z+d+Dr0grZ3z1qVagmbkOu+MuIZOluHvnpZ3zJ9VsXhyvKJOBzouCik2B2uWw/2OWlQp+J1iY7Vm73s+eEahG4JFNcjMWpeEG24MPDQgjZV4xFlB2nyFo5hPJ8YJMtlzvbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5509.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:316::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 10:34:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 10:34:42 +0000
Message-ID: <54ccb6ba-4a00-38b2-bc65-65a7baf86957@siemens.com>
Date: Thu, 1 Jun 2023 12:34:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core 0/3] Add ext4-fs image in reproducible checks
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230601073454.1896-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230601073454.1896-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5509:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a72aa68-bbc8-48ae-e2c1-08db628bcf2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iIReOXXt9VhZTbGSsFxwDcxuhKovP530IZS2avfgVQaY2ig3lk+Yq4BmJHGnOENxmEeKatKKh5cDPTUmAvaIda+KP+VUzNgE1nNNc8DizCiM5DXKiWFgkVBb/agdBG5ti6B14dpG/3gvhaSu5HuMoMyKvCiQxaVFEHwaXsetnaxl1LnIl+/ct3WdYlaeTp2NrugdcNH2udH1Twemv8WSVhPkpPnscrLnPDdD2qOHVE8WDNedOrfflklwAh7Hz3BjV89Tyr138REpKECxxCbbRZ5RfpcM3i+lC0Y5YSP73/nvE6JkqU/4IZgMPwwkfyT5t1r4Of7WBrIhFepPATLLWin0zlo3KjNECPksmE3FpEAMwi24zTa+NJUx4GR58NxU+q+/A99EuFyMI1aUIq+0NGY8PoIRGrZ8A/nUU5tHTH9fAV+ygZ85l0BljbYu9nQEuMigCmKxqBQAujNlIkVRCY7skc5z5rRU0h44SdIT3lVhyMBs9q5vQB7g6HIuyMc0vC4msXkLNqU25QE2TnyH+ZPFdXrJSXmFqCn77nEy7hI5IJUQjRi00lgFb3Rb+4Y+p3J88pZccnT1nzH7n5qFAe7TRT3QrYS5Ob4y221YC7iGSb1S6tLZhRAqoHWa/2u9tKc3YOj3iATuWFFBRTYyYg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199021)(31686004)(5660300002)(6486002)(8676002)(8936002)(41300700001)(478600001)(66556008)(6512007)(53546011)(186003)(44832011)(4326008)(316002)(66946007)(26005)(66476007)(6506007)(2616005)(2906002)(4744005)(82960400001)(38100700002)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z0hWOUYyUGlxNy81RWNvbWw5MzBYT0tmOGxuUHJGMUNEUVp5Y2YxTGRpQVBF?=
 =?utf-8?B?TmR4Um00T0dDSGJIVGlCMDNUNEtDWXB5QVQrcmF4aFgrVTdncktDcmFjUXVq?=
 =?utf-8?B?blltT0ZPWU1jQnAzWTVOVDNFSXUyVng5UDJJUnM5UW41cFUzdVNEUjNwMW5z?=
 =?utf-8?B?dXZodys4ZVVGR2xhMWlTbHlqeWZEbk1NQVNOVGNaM3R0WFJpZEl5VmtQaHlD?=
 =?utf-8?B?V0tCYWF3Zk1aVjNTbEZnazdsMTlTSlRSVFZiSGltYUpqcER1b2pIVTR2TzNE?=
 =?utf-8?B?NS8yNWxVSDVIWHBaT2cvS2lSNVBnbkl1elNwYlE3RkNxVVhNWjFSdDcwdE5W?=
 =?utf-8?B?d1FWSnZUWk5UaGxCMWJKLy9wczZ0bTZBUVVGMStaQ1VDdkk0SnVDZmVtbDhQ?=
 =?utf-8?B?VWEzb0V2OU5pRHdVSURQZE13NURPclZ2ODRONExmcnd4SHdxUWpETzI2SEVK?=
 =?utf-8?B?cjB5b0hFdzJjUXl3c0hCWFdCVjQ2ZjJoVVA1MUtPcFQyTmxNUHpxOE91a2to?=
 =?utf-8?B?MVpDTlNsUkhCMHdzQm53TmpKRFhDamt0ZEZQaUF6dWVNUDFEN0xzbGg4UnBP?=
 =?utf-8?B?U1NteHBlK3Q0U3p4M2YwaXBFcmZUTDNqMnU4cDdaWHdJYUw3TUZiZWtiaUor?=
 =?utf-8?B?R1FvcWJkUmxSaksyM3Fsa3VlWlNudWZBVlZwVlpXamxoOEdTY050YTRtYmV1?=
 =?utf-8?B?WnlYK1JBQkhJTmpIRkhMdFFYUGlsVzEvRWthN2UzOXR1VXdoelVCcW1tbk1Q?=
 =?utf-8?B?R3Y1eXVTZHFjUWV3MnIxSDI0VHJPYW9YSTFqNW42NW0wdXVHaVVqMVl3cFow?=
 =?utf-8?B?azdocmI5MzRwa01lUWVjRXpyL3NYZndWamtzVGlZaHROQmxzdjg0dnUwNGl3?=
 =?utf-8?B?NlFFY0hFYktQYXBEWXJxWTVKdk40SzRWcTJnTzZDdktOOGRMS2ZRZHlwejZV?=
 =?utf-8?B?VXFPQnRBZlFkdk1UMmFJT3p3eEQ3ZXllRStaS3RoUkcvUlA0SVpUdGY3R1hp?=
 =?utf-8?B?VHFBWm9Sa00wWGZkcnJDSlNyVTl3amNWRitqc0tKQnhNWnFTMTI2bWk4ZW5v?=
 =?utf-8?B?dmdpRVZJNmhUYjZFaFo2eXdhRElaMi9NSzBpWThTNVpwUHltZVkvSWJ4cHdT?=
 =?utf-8?B?KzdUeWRXbVBrcnA0di9DOE1tS2dqQzFmRG9VbWROOFZkRHA3c2RaYnhXeHJy?=
 =?utf-8?B?cVhybGQvd09tU3pnSDJYL1ZkMnl6ZW1ybkpqdzYweEJYbUduUXJFUkxmaHpT?=
 =?utf-8?B?TUhZdHJ0NU5UVmdnOEFJNVJuWm50WGxoM3M2YkxqdklQMDRoSU9MK0hTQnFF?=
 =?utf-8?B?L05IK0EwdzluVk5hRFM1ZDVwd1p0amF2S2tBVFA5M00zY0Rnckd6ZlV5bVU0?=
 =?utf-8?B?dUFTM1RzVVBsQk5mQ3UybGxhV1JrN1VoSVlNbE8xNGxZYVgzbDNrVG9QWVZu?=
 =?utf-8?B?U2tETW1NY2VOZ29ET3IrSnJRRENGT20wTzZaeFBjSThmekI3NHNjMnlNZERW?=
 =?utf-8?B?V2JjNVRWQjBxUVo3NWxzYzQ0RTc1eFdTNGVndkxkcHNBSUlBNEJVdGsrdU4w?=
 =?utf-8?B?T0JPekQ3R3N2b3RpRG52K1RaTEVweHZjVlZjVmFaYi83c254YVBLSVRma0oy?=
 =?utf-8?B?UW8vbVJwL2YreWY3bjRXUFRHRmEwOG9aMk9KMGx3c293ZUF4QmFjNnF6MnB2?=
 =?utf-8?B?NEdPQmFPeTc2TjJ6b2psVTdDaXFHaVJZUy94U1lReUg2Tm1vemM5YTRSRnN2?=
 =?utf-8?B?RWVCK0xQak4rTjRabE44K2JLVEdMcmFjNG1GTjlwaExXMGRLamlkZy80c1d4?=
 =?utf-8?B?RHZ0MFFpMW53RnQzNFZ4QjdtZ3c5R3NVTkwySWNXNzBtK2FYWDA0dmpESzNl?=
 =?utf-8?B?SnRTdXBFRkZXM012RHQ4RURSclBYaDhTbTlaMFVyQXNRYXNvZDFUVTRiTTlh?=
 =?utf-8?B?NUQ5ek9xMS9scEJrVStjeGIzVzhlYk1GRVRyM0Mxb3RVQys4OGZDdmM5SEVB?=
 =?utf-8?B?RDN6aTUwV05leHRRYTg0MDIwQ2hzZGxnbTIwQW05dDZJeU5FR1ZTN3RiWS9y?=
 =?utf-8?B?aHIwd1AwZ2FhWFlibXVzWUl5S1dsdkpDZ0ZUS3dPTEQrVGFpam4xcWF4UFZo?=
 =?utf-8?B?VGJwclZJME0rd2QyNHhVYTRwbytyaGFCV3NIMHU1NTV4NWNXdmR5YTZsYU1l?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a72aa68-bbc8-48ae-e2c1-08db628bcf2c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 10:34:42.0135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jme/D2RGXVJOviz8+3G+SBQ0shso/F06ZSSch09bZwunrHyJwidPH+ZBvi7+QvyWxSqSvWo1xwbOGPwN1ZuGPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5509
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 10:34:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11723

On 01.06.23 09:34, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> Hi,
> 
> This patch series enable ext4 file system images in reproducible check CI,
> which is next step after tarball images are being reproducible, let's
> see new issues in CI after integrating this patch and continue to fix
> them.

Can't we address that directly via wic? That's a way more common use of
ext4 in Isar layers.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


