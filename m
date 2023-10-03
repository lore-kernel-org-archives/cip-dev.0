Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14125E8FDB2
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 20:26:12 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.53])
 by mx.groups.io with SMTP id smtpd.web11.1284.1696364766407735328
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Oct 2023 13:26:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MkKCrikY;
 spf=pass (domain: siemens.com, ip: 40.107.21.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i85KXnGqRa0aQlFdS7OXouddQ23PE9+xk17+02moPQ1KXavDQhQRLZ7KK9d93BUMo/lvhH1EpEpsb67PTye2ezTc+kUNd5LZTWqzFQyrEfETapV9dmV2RlRqxZ5bhRIln/6BBj8tlEz6SWiqHWxBMruZZ66HrRZ6sgKrN7Uqt+hihddZkvxNHs2ul+mDSR5nvnDTqKmTCsLABATWZPQbiwn5y0F9Jwn5LaFA9NXdpUuzvGW5z2M2xfgXj/VdyBbuq3AsF+nWw5HLgCtE291S+BkEa4JCEc4ptj3EZvy79lgP2L9mBpUKeS2Gw0dBSp0+99A0QVvnOQRJsxjnKVyEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQ8FrO+UcDsCgbR9+NF09rbMTkUc/rYwOIOGG9tiT0A=;
 b=nwI9rLbm9xx0Dz2KtTR+IbpnLproF2MA49IKnYnBw1vN97aCisGz+HgXi5D27gPbhZmOO1EA+eAJZj+ElU2Uj02NbYv410CvADKAqDvf8PdJjG80Uw3suJjJONZKRNAWgLOU8m1AaADzyWCUpuEaMArHqmPxHNyqKj1ZyRLXuleHuOGCH83kuCfR/uYQfy0aJQwGc5UI0huSspeu7zdCINn/cYYva1NNvyQVgIIB3ViilTCVkXO0PJ1JHuI6fXGLg15YzOBP6QR4tiKnwIrg5+XsolMSFu22vgGOSj7HiUAgUZHL8XH1aCXpI0uLJ5IfcHBIQ4skybIVaImxvI1Jsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQ8FrO+UcDsCgbR9+NF09rbMTkUc/rYwOIOGG9tiT0A=;
 b=MkKCrikYJU0/b8FoSNWyeVEKcemGsnWhRhRmGhjVF5TqRpuRwMDlUQGalEIVndML0WOiKSVcPe3a07vsPMFs0STYNtuRNCOmBuNh1DmadvCClNewOkyoOdpo1wkXV2BsmBznXMWxjX5gluTPfdGmJTdvlnNkVkSC3HnwABvXl50SkuSN3MjFTsG0d1mUHYomPlt8ttXo1P3oaxSeTZT2QYInAWedd9y46Dm8yZNXgZd9h1d1mfIgeLMY0A/H9VP/HI5s9AqSR0y5ziyjSpIidcBRZV2ZH04HVZSJk/ZPjFY3HSyysSi/ue5wsukm1rLXPD5Xx8fh+dfgx0GTl9n7fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3671.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 20:26:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 20:26:03 +0000
Message-ID: <614b4511-9364-4b1a-92ea-d8e0c8a46349@siemens.com>
Date: Tue, 3 Oct 2023 22:26:00 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: projected EOL v4.4 SLTS
To: "Kadel, Michael" <michael.kadel@karlstorz.com>,
 cip-dev@lists.cip-project.org
References: <4785f4d6-3bd4-4f98-92b9-77e705f4bd95@siemens.com>
 <27529.1696247997132604008@lists.cip-project.org>
Content-Language: en-US
In-Reply-To: <27529.1696247997132604008@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3671:EE_
X-MS-Office365-Filtering-Correlation-Id: 048244ac-e114-4fef-d416-08dbc44ef6c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nZ8kUsWqhI2EaqBav3jVYouOUEKZKmUVE2w7ZgnY9zr+jr985YZ2UF6nHD9joj1SHnlQzoTaTQv0+8G02dCaucHPha0+vcJ2k9kVw/7T2UdaG1jDqkXO1E9W/+4dJ08WXhFZf2Of2GxWvH/Ud40yOHXIQwx2xfdddb1MK7AsAHYORJR+crAwU9pUiN55mhBaHuqES93K6jx97oBV7HhYBL1J3UE7O564U+D9NWtatx8AnKxr3WQ2zYKYDFoVM8D1wZOjI1Cfg/7GBt2/NiuFwmuph2BCigRFyx4RmIx3LdmvlH/a+qkYyxme1jCvlO4QuIEDQwvAgO286eqjolLOU4C7EutH47Kc2Hu2ShS4T4P+C/qsxU26yJ31heuuoJ90wYMR5iAqfy56YT8vcCHH04f2lfUYuh8aniKLSRLojQl+5S56hhUxCRiyBqCWe0xl4L3mX3tb8r1aotOFpsTfSarBAy9Q/45N86Hr4/uFcw70hC58NtwKOQUM5ifBVkkFKBog4oA4Gv4NSe8EJzK8Kw4Y7tL7W9iVtq72uOAJ5BmcnzYMEK98rpfPV8d/e1n51nDOA6RJyt5oLEE3FX8vjh4tVdBvd0Z6e1GIJA948ujf/MuhOjlVMY4OsO8wJGxtkOERw3KO2fs2kt40L522vw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(4744005)(2906002)(66899024)(38100700002)(31696002)(86362001)(36756003)(82960400001)(53546011)(66946007)(66476007)(66556008)(6512007)(6506007)(316002)(41300700001)(6486002)(2616005)(478600001)(31686004)(8676002)(44832011)(5660300002)(26005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MlFCVnl4WU1PMzFjTVNvaXIyMkZteklOVVZDcTNOOFZLUnhBODNSam5QRHhU?=
 =?utf-8?B?aSsvL0NmRkRUdUZ2NHlYSzVxN2JMelVjNXZJTllTdUhzdDdKRWxQNEFwWWNw?=
 =?utf-8?B?c0Fua0RVbXZNbmZQQnI0eWN5eUNsSjFGWFdId0JCNnBxYU0wNHVwNEJINzV2?=
 =?utf-8?B?bFVycytueDJHNnlMc3Fma1RiRmtUVU9GSmdGQWdCM3czV3BmeUNFN2ZpYUY5?=
 =?utf-8?B?K1dmT0hlbGhSL0JlWlhaeXBvUElrbUFNWEo1Nnk0UFNMd1pSaUQ0b0lHL3dv?=
 =?utf-8?B?NTFaWWdLVyttY0tnZStXNWRtaXpQTUY5VmR3ZGdlTVdBTWxkK1dQd3NoMVgx?=
 =?utf-8?B?RGU2TzFUSnM2K2M5UlRKTzY4V0lWckI4NE9xQlpjN2RQbmZxOHhkTm84QmEy?=
 =?utf-8?B?dkR2aGRYNGFxUjNFUW1rQ1c2elVVVmFVUk4wY2lCemJReW02QWFIMllnTkZx?=
 =?utf-8?B?R2JOWXV1WkxqU1Erek5CS21KV0Z5ck80VkE0VE5WWEtwU3pBNjlKbmtHeGtn?=
 =?utf-8?B?VTVFaUptSExIM0FMcmU3OC9lN05ZOElMdFJUd1VzVGM5emlRR201SHZYdWVM?=
 =?utf-8?B?aHU3R2dXVFBWYmRuSjIyMUNLQlRLc25Jd2I1cEJxWDZUcFg3VFBVQkRYYTlK?=
 =?utf-8?B?UTNsMHVvZ2VsS1NDYWd5c1B1K1ArL2pGY3FWUU9DdmFoMCs2cGdmWElyZEI5?=
 =?utf-8?B?Tnh0VzU4V1VQalVoOWdVTy9vaHNwcDFaSWtDNGczTFU4Z0JZbitGbWxCelVJ?=
 =?utf-8?B?ZmIyajdHbDYxTVAzNjJWMTRDdHZiakVUcUd5M0gzWnNlcTE1RVJnTGpsb0tZ?=
 =?utf-8?B?b3FSRExhb0Irby9ra1FqWWtFeTdEa2NRQXhnQ1M4YWhPSk5PcEdFYUovZk9i?=
 =?utf-8?B?VmoyUVpybUZqSy9SaUdmNFg5dEhISkFCdktKS28wQUpkZ2pWRkZINE5hWksw?=
 =?utf-8?B?R24yRk5kMzgvYUk2VlVaL2RtNWViVDdZUi9VNEdnYUhsN2RYUjRia25TWnpQ?=
 =?utf-8?B?QjFmQlZWa0JCK3crdVhZMlErY1lpNURlWXJpWWhFUGFvblVwbXVFR3VMU2p1?=
 =?utf-8?B?aWJRVDBnM2R0WHVHN0R1YnRrdUpTWGlQc1hQeEs0WEhRTzRla0JhVHk0ckxa?=
 =?utf-8?B?UVg4RithLzZYRGVoOG1uOEVFUi9Jd1JlaXJwWllKblVQNHJ1TmJrQldiUGd6?=
 =?utf-8?B?dWhJQVVhM1orcEdoU1cwVUZ5c0drVit1d1NENUgwMHZCWlh3UUg2RnFsNXYv?=
 =?utf-8?B?R3BWWWlXKzIzQmhZdjNrd2hiODNNWUVTQVR5QVRjR0hQRW5EWDNnSnBJc0dD?=
 =?utf-8?B?alJGZkJzeHFZeHdwbmtYRGQ2N1liR091NW00OUVXUDM1NG1xZlBaUTJZelk4?=
 =?utf-8?B?RzlkWHVYcFRpR2FmWlR6S0hOYzhxL2R1bEw0UFVtV3pRL3NScWUyOFV2ZjJR?=
 =?utf-8?B?T2ZDTU1zZ0xNWXV6R3RPNzdXMmVoQW16NERseXVFcEM5TVYxK3pBbGtiTkVL?=
 =?utf-8?B?NG9kN1JNVG9hRHB0TWU0Tjg5NCtpamZQS1pGVGJDUGV0OTNvYXh5NDdFampN?=
 =?utf-8?B?UGdGWnUrdXBjeENDQ2RDS2grUWNadk1CNWx0Y1J0L2ZRaC9ya0kyQWF0UVlM?=
 =?utf-8?B?U3BFdFd6anJOc0JhbTV6a0J5VzJpQVRvRmR4YmhEbEduMGIwZHZ6MS9BMFBB?=
 =?utf-8?B?enVIWEYrMklXUE43TVQ1WXA3LzE5eXlMcThGR1FOb01tT1lyS0FoT01yTnRZ?=
 =?utf-8?B?UTBFYTBsQVp5eWhReFR3SmZOeDFkZW5lRlFBMTBKVXFmZTlteEY0VWNBQ0Vp?=
 =?utf-8?B?akh0dWNoU2JjTGdDREQwRGordXZzUFhlTHlVbzd6azhIa0RkNnRGUHJIOUV5?=
 =?utf-8?B?NGRKQUlpdmd1K3JFZ3RKQkIxbmJrVU5obE4zcGJYWkd4SzQxVnBqSjRTYkpk?=
 =?utf-8?B?RXI1Z0FxWFViS2tIbFRtSFo5dUtTc3NlM0ZvVnNIOUwzbkJ6L3ZUQ1lkZUJI?=
 =?utf-8?B?RXdDN0g0ODJrc2d3cWk2OHFSNXhvVlhrUWk3MEU5aE5lQTEzTlc3NHYzNlZr?=
 =?utf-8?B?WHFKZXlmUWxDS1Z2RUFCZWNlTGFGY2RBSGsvWXhZSkdsd2R0dUp2bWpzYkRJ?=
 =?utf-8?Q?QXFlkxAB7VarTexAY1vje3KNh?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048244ac-e114-4fef-d416-08dbc44ef6c1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 20:26:03.1224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCvuv+yCfgdm7X4ws44ivJ5wKWGdg9mZjR2+HOlLutHjZq62c5WGwuPXnGnPtKY5TUWFonpzn86YgFYFPZ0cfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3671
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Oct 2023 20:26:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13265

On 02.10.23 13:59, Kadel, Michael wrote:
> Hi Jan,
> 
> what is necessary in terms of resources and budget for us as a company
> to extend the Linux Kernel v4.4 i.e. for further 5 years (EOL 2032)?
> More precise, how many FTEs should work on this kernel extension
> and is it also possible to purchase such a service by the CIP?

CIP is not a service provider but rather a project that aims at sharing
common costs of the members. However, the CIP project is in discussions
with a potential partner who could offer individual services on top.

If that could include extra 5 years would be to on different page - the
longer the support is, the less experience there is about the efforts
for backporting.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


