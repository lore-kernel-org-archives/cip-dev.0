Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDF1C25B74
	for <webhook@archiver.kernel.org>; Tue, 21 May 2024 10:04:03 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.76])
 by mx.groups.io with SMTP id smtpd.web10.16064.1716285834524537743
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 May 2024 03:03:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kxzVSkjF;
 spf=pass (domain: siemens.com, ip: 40.107.22.76, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AC/kN8xoN24EtiwnAorV8MFWw57hprey2PxN20Us9kNTrQ5SuH+7elxIOoKdPmYnnPpyNGNm5dLPKH6ljgbCe2BNUWXSR8ZHcvfUdVQwpG5mGK06dJhIpotsvnwWdHIFiQMHgCMX+xI5znXKWg2mkoX5y277+XjZCpCW0wYz7FwLUOo7V1o4pY8NhVu4uHW954P7Nf4Hs4T/eq+U2IvO8GfEpRw9ELKHbhbTx3mANb08jE7ceIAnZAuIe50MtwYHbdUvJeAMDcplcInKevE6vNnzmsoXWAEdTk/7mtHZl9zhttvaR8BZeSy9WVHd4Q7QcvOa99ZFmjdaJhvLjoONTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/793SgSmMygNRKYgTNI321ax8wOjtRvhh2GE7fBqSNw=;
 b=R++8sbrjmbLku8DBGQm8mc8TFyR47RYWXErnBY+GoVwPt+X2Xjrdgavv9w38tOrNTRb8rlbp7CJrXkXRyRr/Gu99ytoUqmAhTIDkhz7m7NreBQWYjOEzYe2MBnihXGpZoTo+wcNZbzXnDCli8HWcbw58rrnATZMhDy3fehsdXRy6M5RmghKEGqSg3cCs0sAZS3sBhQ3rM62w1IssZElAtWfShSNA40WuqVfvTO1L3PhUTVIIx/vW3haMgv4Cd2tciKbEYAROICGLzx4Jwm5GiIvYuW8lu7+R8pmQyYr+YYKRNJsqJmBSyUAzd/owWPR9loSbB01pDb7NJXO/9XbkpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/793SgSmMygNRKYgTNI321ax8wOjtRvhh2GE7fBqSNw=;
 b=kxzVSkjFl0M6xtKAapMYgOnnxvMSWQzkAU9Bk89MXJUyaEbov9vKTpUn4/CQlHMaEgWZGyIO808+cyhCyrKMx4OJ38dGQFxXtJ4SdLEB+8qR+fbbW7rW+0UDbEb6K/z5WafQEwNgaCwJvT3Um1P4lNsMW8l7HjcNKlwi5VM+cG+cPkqlVTJa4p4fnMjwafVwQf0k8uQ8OXT6qvy3AJZu9Ls1/V8lJIcQa6tNiN4djNlHWAL5fo6BlaSWWYzqy7vjNPtsKk6Pm4TUEQPulOyTPMXm6wWeuaGoqmzioo4EejCqveDWua/LeiwaTbV74qo6YIhbnOkE+2wBNVO4DT06/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8570.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:214::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 10:03:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 10:03:51 +0000
Message-ID: <1b48cdbb-584f-4268-8043-ded16f57c3aa@siemens.com>
Date: Tue, 21 May 2024 12:03:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Heading for isar-cip-core 1.4
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <e0209629-9d0b-4721-993c-b7f0a52079a8@siemens.com>
Content-Language: en-US
In-Reply-To: <e0209629-9d0b-4721-993c-b7f0a52079a8@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 178ba328-b1b3-4b5a-058c-08dc797d50b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eERjM21LYWJ3QjlKS2NRdVBNcS9tWGZ2MDFtQXRoaW9aMmFpdFh1U2tnM3dX?=
 =?utf-8?B?Zld2T1A3UW5sOFJzSEU2dVM1KzgzWXE2Q0tSckxpTWJQRzB4T2FGWDFsZDZ6?=
 =?utf-8?B?U1dINXBDSlBjcVMvOWQ2c2dnRldJR0NQdzk0Wk15VlRyeFIwOFpCYnhYQ2pU?=
 =?utf-8?B?ZlJ3amxPbDVrU3BmeW9vYnorTnNISjZqaTZCZzhUNnpIdTM3T2xidjRMM1ky?=
 =?utf-8?B?N1NUcDJUVDZhZENZNzFUQ2hMZ0wxV05uRUYyeTdud3ZsQUM4NksrRjZxVjE0?=
 =?utf-8?B?cHJPenhPc2pwZ3NRWmZyMnF3NWxvT1dNMjlOcHNCS3B5UEF6anAxOHAranVI?=
 =?utf-8?B?MGtaVG1TNHQwQXYxWndUUWl1NGV4dGVjSXlmaHc0SjdQRGlWRWZWUFA4ZFNq?=
 =?utf-8?B?Y21ZQUp4M3JCeVlmVGlIQXJJSEplbldaOC9TbS9NOWVRN1daL0MwZTVSUlVP?=
 =?utf-8?B?WW5od0N2ZXJQc1QxTDdLbTNlSllWcEdDZGRETzhIM3I4T3BMbmJnTmtTQ25O?=
 =?utf-8?B?bHhvOGZGYkFES3lISUVZUGx1RGZ6K0xGNTk0dlJHckZHekpxdHM4SWpoTEs0?=
 =?utf-8?B?cEhsQnJ3UDVkRXcvSUpWMk5WRDlHZHZ3U1pna25vbWl5OEE1RldMbloyazlZ?=
 =?utf-8?B?ZWJTcGFjN3d1Qy92Y2hzUWhOeEFqQ21hUjBtVElENlNXWEc4OGRDNVNBVTBN?=
 =?utf-8?B?Qmlpd2ZPU28yT1lSd3BQUWRabElXeld3cUY5cWtwUEhNN1VOZkd2S1U1SFF1?=
 =?utf-8?B?U2FKRlk0bi9jRDM0WUxaUUY5eFZZaGRvQzJXK2dmNHJBVGpvWWxrMTl4ZWhR?=
 =?utf-8?B?dFpqbFZSbW1VMlhQR29NdFRtUUQ5L20vZzNYU0RHcWpSM28rOElwZlFwcHB4?=
 =?utf-8?B?QTgxUG5sR0VMa01wTWFTTmY5WU5vUndoRmpJUW8xR09xcnJ6VkFEZ2trVTZJ?=
 =?utf-8?B?dGZUZGkyUGhFdDEvQXYwWmlhNWMrN0V3Z2QvN2VzWVpTZFZTd3E0N09YZXZV?=
 =?utf-8?B?VllVZkpRdW5KMVhud2dPckMvL3Z5VDFnK2VSdkJYbEVGd1lSRHg5Z0J0bVRq?=
 =?utf-8?B?b1pjSy9ZaVlhUXlyYjFKNm1hWlNQdEk2TzhVK2VieWlDbW1iMlZvRWdiaUJ0?=
 =?utf-8?B?VzhtU3Y1N3ZuYmtKMnBIdG1VMzduVTdFYjVRalRhSE1HZnpFOEJLQkMySEpC?=
 =?utf-8?B?L2lyQmgwdXZMWFh6M1Q0a3J6Nm9KRSs0QlN4Q3dnZ0FLUm9QZ2lPeWE5aVNV?=
 =?utf-8?B?VHFLbkdibXZYUnprdDJDeitGRlpoa0JHV3ljRnZKQUtHVWlnd0tyM255RG1R?=
 =?utf-8?B?bi9ram5RcDQ4enVESW9ROHBjc1g1UmF0VGlRSmIxWDhISXFUN0M3ZkIxTkJz?=
 =?utf-8?B?ODY2Q2ZIUHNrSTM1cUlWNE1wOEU2WUZ2c0kvcFN5dms3RmljV3RzZXI1K0Ux?=
 =?utf-8?B?U1E1c2kvS0tnV3Ryc3RNanBxT2Q4SzZTeUR5M1FVOS9SQUNVZE1UZW15Zm0w?=
 =?utf-8?B?eFpVUEUvZGxpT1h3K1k0UElvNC92MkFIQWNqNzRNUHg3YU5hdXIzbVkybndP?=
 =?utf-8?B?czYzQ1NyZXRvSk11TXAzUkhUQnBIVXV1MzFVMWFrcjB6UTcvTlpYemRHM1VQ?=
 =?utf-8?Q?WVcWetlVKt+D5fgYzYhOkaiOrhExEZe07NDrwwiQJq2I=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SlFrNUpqaFo1MVlqQzZ4UmJVWk1mKzJHRHUxODRHdjhtczNLQjdVaW91M2xH?=
 =?utf-8?B?ODFnRUJqeXlUYnJlc2tEd3dGQ3puYSsyZmpVNVJJWFR1dGk5Rk40eHdSRlNE?=
 =?utf-8?B?OXFDQUxqZzZ2dG9GUWQ0cDgzK3FrREJiNUF1TVZiNzFsZUJDNml0ZXNhUll2?=
 =?utf-8?B?YkF5TUZzZXQ1R3VsQVBWVUhpUStZMkEycnVSSy9MZWwzMmpWNjlBWVpGc1dw?=
 =?utf-8?B?bGV5S2hoR1VLeStVVGtkbEJGbXFZOGEzd051VWlZSGcycEJBcGdZdE9zSW9Z?=
 =?utf-8?B?OHIrb1B1ekViV0FXNlljRFFmSGRJRzEwT2YrcG9zVFh3WWFjanIxeEI3UURq?=
 =?utf-8?B?ZGVlYXlwUHZnYXFIdVZGdFFOcVdrQ2dPR0Z0TFJMMmpTYm0vZjQ1cVMzZGJp?=
 =?utf-8?B?NHNRL0J0RjJBWTFwOG12WS80OHhHb0FnaUhHN1RIMFVPbnUxNVJLLytIVSts?=
 =?utf-8?B?QkNEa2s2Z1M2QXhmZytvc3pNRjNjdWdENmppSjFLdktiM3BtN0YzaDNhMVJ5?=
 =?utf-8?B?bXU1dXRIaUVNcVNwajBYeTZDNkU0YjlVWHpWeStqN3NsZlZUVndIZ2Rxamh4?=
 =?utf-8?B?cXZLLzg2OUdHS0tqdmdsZVRvSE1tNFIrcG00NDd5bld1R2dyQTFaWTJNWGQz?=
 =?utf-8?B?MmVTN3ZyZFkyU2xYeHhRa01OczhlaEYzVlBMUFpUelRQaCtGOFpTdWo5VktU?=
 =?utf-8?B?QjZOSDIwOVhCZkI4MTRhcld5K0V5OWR5RDVrMXpNbjBTSkEyZVZ1NUxRM1pI?=
 =?utf-8?B?b0NhMitHOE1SMERKYTBEYlVzUjg3U3ZnRlZYMWtXWng2dG5qVjNzckFIU3Bq?=
 =?utf-8?B?T1RjTUZDN0RHd3ZXNUdreUJmTG50YzJYbmJSZmY2VlZROTNtcTE0ZFdiczRy?=
 =?utf-8?B?L0hnZmdqQjVPSzdQVllOb3dobXlkalhqSDNlUmszY3JsWXFlK25HUXJCWGtW?=
 =?utf-8?B?ZWF3TVJvcEdxc2tXYlVqTytHOE56aWg5QlRnZ2p1TmNDY0w1QVluc2dtMmdu?=
 =?utf-8?B?N250RDdFQnZ2WHFQZFFMdGVNbzVGY1dCcG96M0luVzJWSkFya2tnRktJNGJh?=
 =?utf-8?B?aWkyT0xYTGFPYzJwbkpzd3FSZUxSVVdXN0FWbHdxaHVCRDV6b212MFNlbVdO?=
 =?utf-8?B?UmJCYWtWRW5mVGZjNEdRQW12UXROV2p4VFc3T1hWUTFqRnNDRDloaE1KT3Vn?=
 =?utf-8?B?QWN1MjdVSHgrUDh2THJrZkh3T2dGa2J6RjNIWFBIcnhBNm1jTDF6VG1rUXNJ?=
 =?utf-8?B?SFI1K2R2N2RQSVdWR2J6WmtBMktyVTM5R1RSRjBXUTRMdGRZTFN0SU9xaTBi?=
 =?utf-8?B?aEcwMTZWRXFGZnVxMndidlVoMHVpZno5UFloalJ3aHFmTWUzVDZ2cXZZd3Fq?=
 =?utf-8?B?bXBxLzI5NjdTS1pVclRzZXhXN1MzTDByeTFUSm9maXlHTjV2OHZQRFN6V2Ix?=
 =?utf-8?B?K0hFMEpPTWd6STZZa3pDa1M5ODVJWTUrajRTa252VG50YVRLMWdEd2J5Rm0z?=
 =?utf-8?B?bnY0MWRnSjRUTWxwcFdScmErZHBwUSt6S0g3WWZMdWdCYXFkdytQb093bVRU?=
 =?utf-8?B?NUJzdDF6dmpIVFRDby9yNG4wcm1WNlBwbkptU2NBYkNIMXZjUmZFWjBxNDlJ?=
 =?utf-8?B?NWl4Z1lXNVk1aGMvZ0hJN1czZUdZK3lGcTJrNGx0dVh4OUdRdGF2YldQZk5H?=
 =?utf-8?B?YjJUODYzUzMwQ1BFNkJNaFBJTXdaeTVYVHpScEp5SEpMalJxOGF4RHhLR252?=
 =?utf-8?B?ZitFMHEvUUJpWkZBLzZ6VDNNSy8vMkR3dFRQY0tVb1JRak5PVFY4NFdORWZR?=
 =?utf-8?B?TjVUUUZwNEQyL0FaZUI4cnpHenpudjA3U3IxQkR3UW1vZTlzQUNjUnNTR3pQ?=
 =?utf-8?B?YzR1NG5rTG5yZ2dKTUhwdXQ3SHZNendqb0IwR2pRR0VsMHpGU3dyY1FYaU9n?=
 =?utf-8?B?Qjh3Si95eTRCS2sxTjVsU0dOTjRQazBpaXY5UDJuTW8yM2dSaHBZQmVERjBN?=
 =?utf-8?B?T0gwRmNGejFFM0pSanc4MVE1UW1US0RWb1RJb1F1bGcyUHZCb2Nhc0x6ZzJp?=
 =?utf-8?B?bkMwWWc4bFlOcnJHd3krejJNV1M3eXpSQkhTYlFaSDhBWW4xYzg4QmNuejdV?=
 =?utf-8?Q?FSgBRtM/g7SloqxaTFyCwazeV?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178ba328-b1b3-4b5a-058c-08dc797d50b8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 10:03:51.3194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDOcEDpQCYp/LJzR38sp60FjpxKPaRnJe3TDQRb9/A7I820l+M83aMl3FgEdeI8c6kjOZMLwJVeBqoKuUMOI/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8570
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 May 2024 10:04:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15921

On 07.05.24 08:59, Jan Kiszka wrote:
> Hi,
> 
> 1.3 was already a bit late, and now 1.4 will be as well, considering our
> quarterly release goal. There are two major series pending (delta update
> and rootfs encryption) which I think we can finalize this week. Then I
> will tag 1.4-rc1. If you have further things pending, please speak up now.
> 

Some people may wonder why there is still no rc1:

We pulled from isar some updates that also changed the way custom
kernels are built. Those generally work but contain subtle problems
around how they produce corresponding (or not so corresponding) source
packages. Those issues are understood and should be fixed by currently
pending isar patches, and I don't want to release isar-cip-core without
having them sorted out and validated also by isar-cip-core.

There is currently a testing commit in next which patches our isar
accordingly [1]. It's not for stay, just for running our pipelines
early. Local tests were successful already, they supported the
development of the isar patches.

Jan

[1]
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/9ee436e59e76a46a341d1f66378d138e839b5087

-- 
Siemens AG, Technology
Linux Expert Center


