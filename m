Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A273C27C5F
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 08:59:20 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.56])
 by mx.groups.io with SMTP id smtpd.web11.15127.1718009949461785314
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jun 2024 01:59:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=URQiSGjl;
 spf=pass (domain: siemens.com, ip: 40.107.7.56, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sbl0erGf9w0n8N36BQc/RqLC38wUw3+ah0lSuHuChvWufFW7gyaYABhVcjr7EdoJLfJxO7YHeb4XVYMfI7ld6Igmq0YGOvsTaNNoanTyszKhD3f2D0pWIDjJlUl89PDUSU9ReTDWmBoCa2k+xQRlrYYcb/C1IPowxbQVMXamNnXT2z2rmohQNE7Vo69Qe5i21fj7V5IU5QU7JRIFVEhoElbfJ62LkteYR5aTDGjZKy/J77K/YJ/Ev5ebdMT/Utpsg5EYioMTgbkk+7XkgnrevvO5SNAfeH2A+cBaBHlc2S2wOES478FPgOIh5Z6LXmIJ4PR7iRJrww6oPULRv06SXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfib9mKk+4XL8GZ0oBN2olZczBkUoezGdBBOKmou20k=;
 b=b5pU44tsVgoa3IjjI25q7aMyR0ArnePahvXifz9Y4p0R0RRX3DMvUxKj9s7gGuk5G12mJ49/1NqtGQntiD1zlvh/dO2n8zRbVUA9Lc9T8ivO7JcfAJ7ohI1I30OKA6gxjrGd1w3VGMGh2yIaw/KPIKJC5xsXdaSkyTScfS/P3lwjrDS6PdQHEc5Hk8UIGo7DXDRe33B97+HJEMhYVXvqoaUyG62/Dg63LhmnC370/GixF04YSy++QYZbOHjVcYfTsaPRMn/hRg+uIZ3c78FImebriKv7Y5MdwBLkclFqvLzAsqevQ+K6gHY5tdcfGz+MCiloVQY2gCXA9cuxj3dcAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfib9mKk+4XL8GZ0oBN2olZczBkUoezGdBBOKmou20k=;
 b=URQiSGjlDn4PEz8vF+Awar16hXWFlLclBBMO27JgOj9kQ6uJ/rCkf4hnkakaXZJD0J99cNSMhi8HjV7dqag4IRrib9LrJ8M/a+QUjEXf89+HHzV753aYyrXNwm23rfCo9ITNUY/BLI3L1lknNTjeWSWq2umDKL/JlZwBN/Zjgp8ah7R9xXVYeOiWfYybecOEsAzOcMhSNPosoMy+KsCYv1G2o2SUMBKOBXLC8o9WRw23zIRDWxlBpmRg+NuGSZwj3ckMgmW7vEVhZophMaiaXRhd1cHA5DwEt4JIa0MNNnBpEAUw0G0hexfIM+YtkXCIUwnmMEc1oRCCoqmBt/d3nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB7555.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:426::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 08:59:05 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 08:59:05 +0000
Message-ID: <2bd98a44-7974-4969-8e4f-c33db4f3edb3@siemens.com>
Date: Mon, 10 Jun 2024 10:59:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Adding swap space to the encrypted partition
To: cip-dev@lists.cip-project.org
References: <35bd7c87-c345-4d45-8053-27c0cafe489d@siemens.com>
 <7313.1717714182247115411@lists.cip-project.org>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <7313.1717714182247115411@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: dc48ab4e-a90c-46c2-8dda-08dc892b94f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bkh0RTBsU2w4d0VyVU1EWHYxYnBabXpYV0ZpaUJseUN6dDFhWk1hMzBvempY?=
 =?utf-8?B?ZVpIMHZoZUwwR3RPdS9hVDJTNS81bElndFVuRDlQZmZ6RUJyVW1jNU02VE11?=
 =?utf-8?B?RnFTbEJoci9jeS9pZmFkYkZRWmxPUElPSUpHVDVpdWt4K1RRTVliQUw3VFZs?=
 =?utf-8?B?b3FGRU9OSng1TmNtQlg2UG5pTERua3BzUmpWc0FrQ2pwT2kvbFFaL3RrRzBv?=
 =?utf-8?B?SVRXcEZkTFdxQWE2ZVJmZElISWwzQWNVZWZFYUY5cWhuM0J6SHovYnZieHJV?=
 =?utf-8?B?Z0xrc1FhclJtT2JsWEMyQmRBVTFHSm1BMkM1anBKMnA0UDlLNE4rNzJ5SEMy?=
 =?utf-8?B?WENpL2ROcm9NVVdxZUlhaWNsQllZMXIreUV4Ky9ra0tQZzlCbXlpVU1sZFhq?=
 =?utf-8?B?VnRrL2p4cXNPM0FxYmRuUjJDZ3NGWGRyUTQxSXBwK0VhVUlESzd6OVRFRmVo?=
 =?utf-8?B?dFcwUUhacG5nbjNGdFlNM1lmOEJnc2h4Z1ZpdkU5MmN0a2JUdVRXdWRyLzBp?=
 =?utf-8?B?SExNZWJrejM2RHp2S2RjTEFkSTFia1Q4c2VjOXpDUE9EeFBNVTV5Sjc1eGRu?=
 =?utf-8?B?T2ZRNFQweUJMVlVUV0VqQUMwZjlBY3NwZ3NpUitjUnRlQlR6azRwY2ZXS21k?=
 =?utf-8?B?KzZuZlpQUWlPSkVLTmV0UXFYTWdxbmVENG1IWlhKRjZmV25PRDc4Z3QrV2Vj?=
 =?utf-8?B?V082REw0VnF5WHdGOTJmYm1VdTFVRjlhVG9Vb1BsNzBpVGdrRjFMSXNLa3FB?=
 =?utf-8?B?QkVNRXJ1MmhHQk8vWW9xVlNGL3YzRmM0b21vejZ5d2ZXSC9WNFpuTUpWVEN6?=
 =?utf-8?B?TWM4TzZYWWpsMmttVlRvRUZVYTMxRC9pazVnR3JnZU5Samo0dDZzK3FOK3JZ?=
 =?utf-8?B?aFdHaGtrWGwwcnVNM2VBUVZFbFlWSmNJSmdjdEVQMFgyNWVzRVhxNXE2M1Rw?=
 =?utf-8?B?MnA4QlBBY24rNk5EY2VVZXdiclovdmVGUVQwd1JQMkVlajJEL294WHJTMm1P?=
 =?utf-8?B?bm8vS2RsRHZEY0hIL3g0UU0zcTlNNzdIcmp3YUlDdVF6dUtsWlVyN1Z3bW0z?=
 =?utf-8?B?VkkwK3NOck5rc0h3OHh0NEpwL0c4RGpUNmZvcGE2R2M2b1k0WkdYNW1NeHcy?=
 =?utf-8?B?SDhRenJYNTZYSElnaXZleFZ2M0NyU2VOYU1QVUphZVZKUjF6LzdQT0g4b3F6?=
 =?utf-8?B?dm9aNHFTQWowWEtEdTRkQURkVWVyak50Q244ZTYrUnhnUFh3OExRYXJJazJa?=
 =?utf-8?B?OXZ4amdSL3h1N05VdnlPVmZhM0xUMnV2VExIMUJKeHUvbVJwM00vSTVkRVZz?=
 =?utf-8?B?MjdVbDZZR0c2OTRuS1BtdGhJTEFqUGVYcGllekdDTUlHWVk0cDJnRUNWY2wy?=
 =?utf-8?B?ems0bW0vcmlYMTF0UDlzQ053Zk12WWloTFpLZDYzYUlFQzdPU3NubXc2cWIw?=
 =?utf-8?B?WmxCVVhaUlBLak8vL1RMaDkvNkIxUUs5bnp0MS84cDdaTHRhU3RoclB3UDZl?=
 =?utf-8?B?VUtoYmZNVzg0K2tlSzVhZjY0cHJjSGpFc2lJREZJdG9BdEtNYlduS01qWHJv?=
 =?utf-8?B?UCtqSlVRZTdJNUxkVlNHUEhiZEg3UHM1TUxxYm9COWtNcjlPWTE5QTJzanVw?=
 =?utf-8?B?YUdZNk50SStwcHIxb3ZrbnZPWHdjbWNSYlNtYmprRjR6OEFScXhjeTVyVE1C?=
 =?utf-8?Q?WNUhc5khCNKqW2elZPf2?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bGJDT29lbVNEVlQxS0tTUzlvVXpuUWc5UUVRZ29EbWJLcGtqWWx5bWR3K0VJ?=
 =?utf-8?B?ZHNTOVlPb0JmOTMrQXhSck1OSUxGUHJORGZuMjgxTWxMQ0czMkhiYXlWaysv?=
 =?utf-8?B?MlVJc2FhUUUvNElidUFubHZPRXkzUHZaMU5pK0V4YzQ4QjE5OXo1a3dzQmNS?=
 =?utf-8?B?bHA5NzI1RTdWLytjS29pdjNSQkpHZVdteVFpYnpmS0sxVkRHNjJzWHl1U1U2?=
 =?utf-8?B?OFloNVdWQW9rcnQvTFpuQkhLZHd4eGVlNGNPSXRtQlV5RnNUd01ZWkY4ekpE?=
 =?utf-8?B?TjU4NmI3QmFYU1RLMnNERkV2SkJTUkVjZ3ZKK0Joc2x2clp4QnJzU3U5clNK?=
 =?utf-8?B?aHV5MnBCVDgrT25WVzZndUJ3cnY0cURXS1dhRmxwN1VOR3ovK2Y1dnNyZ3FB?=
 =?utf-8?B?UFM1NnBOaG9VQ0lqeVBxZFJETXBVTDIySW9CeVZUT3VMK2VjYVBvUVYzTGdZ?=
 =?utf-8?B?SnNuczZmOHJvYkpEQ1l2Z1djZVB1N0ZyT3JEMDZoZ2JOTjBtUDFqV0xmVmNy?=
 =?utf-8?B?TERUSFFGQlU4cGxrVkYwZEhyY2hSeTFjRFB0V0RNMUhyTG9zMUxEdjJBbERa?=
 =?utf-8?B?RXNBcjJOdVhKZlNLS1dOa2srQXFDaWN2NEVpZ0ZLL0FrNTN2QURaQTZSZVM0?=
 =?utf-8?B?VnpFa1ZRcFlRa29vM25hWDRUQ1gxZlVROFMrNHNsSGR0UjMzQVRvRGo4R0M5?=
 =?utf-8?B?RndZMFFlZzlHVEdvREZkT0pqTnZRQjFjSFRLalVvUS9TWGw4UFFRVWQvSDU1?=
 =?utf-8?B?OWI2dWNFdkFDS2EwaXZuYTVlWUY3aWZWV0Y5UG9MdGdjd3NQMzJTL3NrbFdn?=
 =?utf-8?B?Vko0dWNEVnNla1JTZ2N2WnJQc2FxT1hHdE1Xaml6bDcyMkFVTzcrazZVTG1B?=
 =?utf-8?B?U3VZM3dxdWsyZDdlWUxlZ0Fwc1lCTGFVTFdZTkZnZUxFZWVGRHJVUGZSekFv?=
 =?utf-8?B?NVAzOEdITHBsTVl2Rm9ja3hVelVoWU1vRERKVDV4MEpZNmovWWt1UWY5N1d1?=
 =?utf-8?B?a2F1NGg4dlRKL2E0dXA5NFc3b1RjMWpkZXRUSDVqQWU1MDZPMGJ2azNETFpx?=
 =?utf-8?B?VEZ6U2lITk4xYWFpVHM3NmEwVmNBZ1ZhZTZUanBianVENlZyZzM5QWZpZkFL?=
 =?utf-8?B?NkhLRXNHczFEbTVERlkzRU94Wk1XYlNUem93U1pRaVZIbXJmemduVzdWWGNE?=
 =?utf-8?B?eUFFZm9qRVFBRWZNTTNiQjk3RitqYmRhWjhzL3BBcDJOS1IyRVQyc2JVZUpD?=
 =?utf-8?B?MjVrdk16S2haSjNORlFTNnNxUmN6RTF5TGR1KzJyVzc5ZER4T3pWOTZiRGdD?=
 =?utf-8?B?YklFNGE2OWxBWmxaRVFNbVk5SkQyRmd3NEFKYjFIVjBRTllFQWFQb0ZHbXR2?=
 =?utf-8?B?ZmVIdkR0ZTJXdWF3U3NMSDBodUN1Y3hrTTlDTDF2TzNWYWdFa085ayttMmRm?=
 =?utf-8?B?eDdtYWJLSmRaRkZ2dllUZTVub1o3SmFRT3lEaWtYdS83V2tTeXpRMW4vOTZF?=
 =?utf-8?B?a040bmlxQjVkcFU1UVJUaS9KZ2VyNGtvTkFnMm5lckRvTExuWnU3UHRGNThO?=
 =?utf-8?B?WnpwTFgwQmhMKzNFM1VSTzFzVFFwRmp1STRJUkcrcjR1R2lhSU9rUjltemV2?=
 =?utf-8?B?WWVqcVUwdEdlZVl6RFJDTkRwaHBtRk9UeTlHUThMMHpvSUsyc2w1bVRuODhO?=
 =?utf-8?B?RmZzbDZCWVNQL05oZHBIcExhS3hya0RhRGpwelVRWVI4UVpzZ0hnd1lhM09s?=
 =?utf-8?B?b1IrRGZUTG5YTUppOFhLbDFqb0FGN0dodVU1UnRya243Z1RIcG4xeDlPR0x3?=
 =?utf-8?B?cGtzMGk2MlJudFNYTmRHR1QyRzhFZ2p1RDNiM013S24venZaV1phVVNXR2xk?=
 =?utf-8?B?bXlqTVdEVVpNTU1rb2Z5QXRHZzR5blZuQzlmOFI2ZGFiOFJTT1BOWjdscFIw?=
 =?utf-8?B?cE1IeTFmQ24rQ1d0ZjRCZG1xNmlpNEVaejd4ZUVKS25HNndDbm1LVjhrVVBI?=
 =?utf-8?B?THJsYStnNTlqK2JuMCtVN0Q2UzN5bVE1d1BjLzkrVnZhZW5EQk5uMDdKZDRr?=
 =?utf-8?B?T1k2QTdBU3RKYkM0VWE3ZlFuQ3g1UlBhMkJrN1BKM3hFZGlPNkhJc3lPaEVF?=
 =?utf-8?B?RENqb3ovVlZucVJsYnVsYWhhTlJJWGR6ZDVxZ3pIbWZyN0htckRleXk0QVZN?=
 =?utf-8?B?cmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc48ab4e-a90c-46c2-8dda-08dc892b94f8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 08:59:05.6962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FI3ATa75xh1+Wq3MSl+SFdksnCE8eVsXd7aVM0yeuzg6TBjO7KZH8W18Rl5CMTWjtRqSl1VUYi/P/XxvKDTaJmbg7V5pNLvD6/oBHwiq4XU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7555
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jun 2024 08:59:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16181

Hi John,

On 6/7/24 12:49 AM, JohnW via lists.cip-project.org wrote:
> Hi Quirin,
> 
> I attempted to add a swap space within the wks file. However it created 
> a swap space outside the encrypted partition.

yes this is expected you would need to add the swap partition to the 
list of partition(variable CRYPT_PARTITIONS) to be encrypted. This would
also require to modify /etc/fstab.

Could be a swap file an alternative?

Best regards
Quirin
> 
> We have devices that does not have large RAM where the swap space is 
> needed to keep things running, so it is necessary for us to include a 
> swap space within our partition.

> 
> Regards,
> John
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16131): https://lists.cip-project.org/g/cip-dev/message/16131
> Mute This Topic: https://lists.cip-project.org/mt/106372674/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

