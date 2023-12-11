Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E6FC10F09
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 06:33:41 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.55])
 by mx.groups.io with SMTP id smtpd.web11.2748.1702276416827198415
 for <cip-dev@lists.cip-project.org>;
 Sun, 10 Dec 2023 22:33:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ftjKzwd5;
 spf=pass (domain: siemens.com, ip: 40.107.7.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIRbG+IEOqYW3xkXFDFJVfnUu98oPzs6tO1t/vFPKek8Gs+w4NorWPoqacGpznEzoS2HJYA74bUKZiadLiv502GxDEE1B6sCAX8AjuSeDYee8GtrS7SSgA4C9YSPhL+1zcMiicpdQrR7uiIE0Yph3l5Ypk/42PfVG1kCVXIWtbcAmEHYJmF1slzG6Mpu83Mjexeb54S4/KMr4e0iS3mHrp9egIDmKklne5NRk/QePrMMFGGLgqd4q5CiTUOIKkau58Co8ctwIQpR4yRpHgRiOh4h3XTPime3b/iV4ULQcMsCtmD9OkToFL4PqFG7GXdFl+JfFjBbduZIEpNyhJetZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mUL3pYLOQW/uuJzmZJRhN/zTIcJO7GZ95IwQTydcMI=;
 b=itpvR5uRUrOSSisIBdP8Do7erUmfh5SVRI5LtOeCd5/+lmt8Q0f2sgCMniPNfC60mfrOP8aI7EGFoteGQQljEN6GpTe8jAeqQ2BonVU0x2EF6zdQqil0QcHLg/UuBAqbhU3t01ViUHaH9Uk6iif9Vp5Xbfku6JtCnYFQgWLgUR/zMjYdp62hSHo+bNJE3LtxxmKBpVZA8JOAZ7RYGT4+AxE5OiWaFICU7ZaVFIYnI7zCGQJ3qI7BT1ZdwJjYmRFtxTbVajYzTVkELpBW9sYLY/q0g9MBvj9bX7qJKAaaUKcKTstExWalXH6GbOJwHIzDNcV4hXfivHfrmmGAyMfwSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mUL3pYLOQW/uuJzmZJRhN/zTIcJO7GZ95IwQTydcMI=;
 b=ftjKzwd5N1lhHoZOQILnnVIIKjtdxO9sKV5SXDL9SpBTVOFaVYWFOHN21Xx3hsILPEpN2Gyag65ETMcWxXTiX/tg1peIDXfkQxEsbVkM3qlxDeunmfjPUJIWjTWD9Nqu6tBjllv8dMYwjIVnyKV17YwpVlHz9JIauGjzzQ60QW/Lp0ylnl9tYymgKsad3ejC5TGKB2aXFtcq0Hbu6daHvFDh+e+JFU0aaV51ygJyVtpYGpJ8fyU0uOOJO+VtO9DDnjh5WOFhovRNaAnlEiovF7+lYNonpk6Z3/BzQSJoiTdV1IWGzN8fo3krSPQcuvC+WQujDz5oZf0EyulfrwP+JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5552.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 06:33:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 06:33:32 +0000
Message-ID: <7c9ee21e-7e50-4c3d-9d09-2368315abd16@siemens.com>
Date: Mon, 11 Dec 2023 07:33:30 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Pavel Machek <pavel@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Potential ext4 corruption in 6.1.64-cip10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5552:EE_
X-MS-Office365-Filtering-Correlation-Id: 013ac70b-b221-4002-c9b4-08dbfa131889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bH9ysKNFLYDi4Y6gBhRQTP8J8B/3fYgRdIj/bOkChaXNi6QZot5RX6yY1nJHNlCLWBzzE+/8R8cNfsNRfl6gtwaEhf82ZegKTFsIbI+e1uG2PqOKE0rurZAOXe/qOa65ZpPnUENotQ1xScFJQj7Iadymy6cftP0nSjkfnwcZ3j8K/qVOhF4wH7fuWLOSaai3u+gh73psj0hry3/ElUH0tjGWKMA4RgllqoPBGP7thghKG1I9twgFxhkcOqlYojL9nPHuk/ppZNtjTD+qJCwbQaNxMTPoRwJYpu79JEvMrJ8fenut/i0gltjTANhRWurnsplU83Ks46sew3Io8RVboH5V5u9dh7acaxOVLOOEkJQNfStS+oR/kVkSOILAJ/ABeuFue6bUcgYEUDqtWtz6JtQDNe8jX70YXgEQdyRsRuzpXQE3KRwZcwgXxCBiOFY/GfKW3zMUuSHwDETM+cIEVTPgFeObu9QfdkGdU8GGFqGevMVJxymAViqg3plIeAFw5xSLKeLY2jGHPjGVlD3SycmvnZ9+mHrDkfu5mcyjiyCfMoVxx16QmJR6k0u/COAA5+MejsdooevQ5Z6SbrC/QfqX6CxBVrEClakipfSCiHIzvk8afN/68kfD0obhJZ2Y40TX2gzX3dEMHlMURQEeWR+TsRdRiCT5OZAv5uZZ5+myot6Fqc+aHpIhU7rTiHqb
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(2616005)(6506007)(6512007)(83380400001)(5660300002)(44832011)(41300700001)(2906002)(478600001)(966005)(6486002)(8676002)(8936002)(316002)(66946007)(110136005)(66556008)(66476007)(82960400001)(31696002)(86362001)(38100700002)(558084003)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OXpMNFJhTkQrMnh1ZkxySUxldlpDTG40ZlA5Vnh6cEZiZFlQQzVzeEhnT044?=
 =?utf-8?B?UWJCTmNDd0p2UWR5SjJoL3R1Ri9Ub3l1NzIybFVnbmdyTy9QamxHUXc5Nk92?=
 =?utf-8?B?dUtueDB3Tklxdi9PdmlsQ0x6Z0svaVFDakJZVGQ0djR5MWlSSnd4ZWtUdzlx?=
 =?utf-8?B?dUpZQlE1dzBaZmZNSHEzUG5aZUROYzNBYm16akQ5SjVrN0RLNW9KclpNYlRm?=
 =?utf-8?B?aHhHSUFNaGNseW8rKy9YNWFSMUphMGQvSmYxTlNURjZqWHMrYXliaWlMOVdk?=
 =?utf-8?B?VlpBalVMRzh4dE1xbEVYTEduSjFiUHhOWG5mSnU2V1JNcDhEKzdSRC96d0Zh?=
 =?utf-8?B?L3lEQjhMaCsyMWJBWVBFaHdkSmlYbGtTN2FIWWhLZHdvMXVNblE3Z01oZ2pw?=
 =?utf-8?B?WDE1YVFIK3lieFgzYnJidzRDVU5RTCttQkJGaTg4dU1MVEZyMHVhWUx4eTYw?=
 =?utf-8?B?VEVBb1Z5eGRCVG9zQTNBenRxNmdENkJmR09VMFRSYUk1aHZ4L2NFNytGRmNS?=
 =?utf-8?B?TDFIYXZEbnQ2bjdxOUFQbHdaOHhoSER1Tng3QnFrRFpxcnVUdkxWcWUwVDBJ?=
 =?utf-8?B?Qkg0dWV0TTFVbWRycFU5cVNRYkRlby8wdDkxWGh6VHBLdnV4VVMrSEVTbktx?=
 =?utf-8?B?MENaUFp3QXp5aFhYZ2JYZ3JyK3hxc2FUMFhsK2M3dTBaOHVmTGh0LzdOVS92?=
 =?utf-8?B?dWtPb3hHdDEvUVFuc0xLNllreHA2S0RUOThhRDl1eVpMaXBZVGtUc1lrNlN5?=
 =?utf-8?B?elVIV3dGN0l4cnA3eFpZSkttVGQzZlhjQ0pOaSt4RUxTdFJQNlg3TzhYcTVk?=
 =?utf-8?B?TE1tNGZKNnRKSHNabGo2VUptcStyZHVUL2FGZlRDTGIwZ0FXUWJuaVpOc3VY?=
 =?utf-8?B?QjlhR3VGckR6VUFBeC8va3gxNldOdGZEZXFJMkt5bTFGemVTelNMeTRnakgr?=
 =?utf-8?B?Y3FsMXRUdXBKeVpDMU5tYlRWSGE0anB4Yi9wN0ZjbGY5dEFJaHNWdExXL3pM?=
 =?utf-8?B?MzF2aTJueVZnKzlUVkZWbCtFODRUYS8zVTZRYnd3bi9vWUcvV2VTdHlNL3Qw?=
 =?utf-8?B?bkdTWEVsbDJCcFJNS0xwZGVKd1hmZjd3ZTAxRUtMWDBoMXhsekoxNFlwZlVn?=
 =?utf-8?B?dFpPZ0tDaUd5QjJoZUU3eURqcUM1MFAzLzhUcTg5cENIYk5McjYwYk8rNFIr?=
 =?utf-8?B?WmdLQUpVOHNQVXlLbkErcHFQWGdjcm9YcktDRHgyY2ZoUndHaCtOVDNvZEdV?=
 =?utf-8?B?b1E2TXZIeXA4cGVjZXFCRkJNM1BVSEtvS1dlcm83dEp5MEYzSTJBN2FMKzV2?=
 =?utf-8?B?M3J3cGVzR0t1SXZBSlk1MDZka2NSRmVRemxrc3QyNlRPVHEzMEo1WTB4S0M0?=
 =?utf-8?B?RDVGdGxGOStFYlBybHdhZXRPb2dlWkgyNFZ2OHVyam5VRklPcHlLdkt6Y3pk?=
 =?utf-8?B?Y3Q5QmEveG5Jb0hnWi80NnBvbDNxemZzaFhyL0lVeUZCRG4vVUJHOVFoNGN1?=
 =?utf-8?B?QUllVU1pb3d3ZXZoWm1qU3NZU0h4UllZVDg3TitWK1R1eUs3UFhlbGNxaklv?=
 =?utf-8?B?WTdSNVhwekU3bm9DSHgyMHRjcHFZSDZaZlgxQ2xVUnpNdVZCYW1CR2pNaXNR?=
 =?utf-8?B?QlB2c1paam0yUlRJYkFyNFYwb01HaW80aWw1V01mVTBrRURXQUFLbmF1REZL?=
 =?utf-8?B?Wm1RSWJMaUdlN3p3TFhPYVBhZllFSnMzN3pvYUlvSHlORDQ4aU5ZVlhURTRq?=
 =?utf-8?B?ZEhPSWVXZkVQWnQxMjdRYmhvakgzTGppVFpNZDRITFp1VlN3UzNwSll3V0l0?=
 =?utf-8?B?YVhtYlpwNnp5OUgyOWEwTUJIbUQ0b2NCNmZEaGNXNUw4bFlOdWsvb0VJR3N5?=
 =?utf-8?B?L3hXYlcxREZLMzF6TmNNK0pzeC9lU3BManFTdDJ6V3FrRVVZMGt1ZXhNYTlV?=
 =?utf-8?B?OGFSYmhSYmFxSzgvVmZNenI2cUhyQkMxM3J0QytFaDFGQnRXKzEwOVZJQzVk?=
 =?utf-8?B?QVZucVN3YWFubzhPYnAvSHgxME5zSy9xbG5yWGpvRFpJQm1wbTh3MHovSjkz?=
 =?utf-8?B?VG1UKzR3RjhoMDdEeVJGR1NlZ0lMZEJwK3I0ZTFIVG9sL283LzFNZFBtOS95?=
 =?utf-8?B?TGhFLzRRblpTZ05xK3BKNlJ2a3YzNUplZWZDelcvTm1LaExIZVJZTHprS2JF?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013ac70b-b221-4002-c9b4-08dbfa131889
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 06:33:32.7112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBEaHs4p5erBCG4aPBHK9dGuN2nnHLP5PTLFwfqPO4Lbfc3QdNZB0oVOXYx9kvspz1Y6ECwgl57tKTHmaBpNXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5552
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 06:33:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13992

Hi all,

seems also our 6.1 CIP kernel is affected by [1]. Please do not use in
production if you have an ext4 filesystem!

Jan

[1] https://lore.kernel.org/stable/20231205122122.dfhhoaswsfscuhc3@quack3/

-- 
Siemens AG, Technology
Linux Expert Center

