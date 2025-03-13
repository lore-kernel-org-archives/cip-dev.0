Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF47C282DE
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 11:53:30 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.48])
 by mx.groups.io with SMTP id smtpd.web11.12640.1741866809043816111
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 04:53:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=L8LKeRgJ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.48, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khCi3hLZkQQMasgPlXiYD6wlsPddcB/R/mdeLVy6p5xgaUsGa6ugx86cyY7BUeo+XTbCWrMRSPAmc5D+C0RUf4Ptq4ctUPmGo96gHiwO8qDBrQ8WWnWaLpPajaXorkzPdXFnn8rzqs60r3QHSZoro+uizYPNicrTrBEXLS9JHlpqSGUZ4RJLC1RD0+zP+rUtWb8AgqmXn974NmrCIDyT6mUnduo8cO5ccl0pHzIRssPWna5SnrSVnLJQfCsMGRQzk3m/bH/get3hjITYjDdp47xQW3caStGvxs6Z5KhDvzjG0FvkEfeumcxJAjTqu4wkcrl4FYN1AjBlFbMMcimCyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1afjIzHGNtjAZs8cW0EGKsXvo9o0jOIrRQtw2JkTOck=;
 b=x4pZofyLqaaoDdbvvR3dvyhxqTBgI4bEecLveqjhATGMfVqKCLyCdaOaRcmBYGLxzAt01S5GVNDQIAqVJr4p5S31eCUXqfhyJAEgaw4wCBjHpxxhuCVTjRraDpsYA77afc/Wd5A7HlNM9EMXwQwqF7eNnJUZOeIfRi7jzoQCFqjDR4Da+69GQWqUsa1es/+gSDU6vLTQP7dEZ3UeEOo7dzkJn4X7E+Cxzxr/iQP1fQdZCA/UbRR/8yCUOKb2w7ZitPN3mfAuAo1rtkmnDsO72rXHjwZceyL0UdPXJiRfvPMUUDhVqmuAU+LAQ5ItpZiV6u4/LKUcJ61MTdalKk5rvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1afjIzHGNtjAZs8cW0EGKsXvo9o0jOIrRQtw2JkTOck=;
 b=L8LKeRgJo9t2xjmY2/eRe+7x1VUiP00wcVScYNtlfqZag+pRTOXK9R41V5FH+XWiF6atiRyOQU+Kr+4JdPGiVcVF1if/qBmderOFvB77TFOOAYHuWorqQ8ss0sFw1UMgIYiOFyO0W57zktKIUNi8T0Ry3+gH40L+DE+Y+HnH+lM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13941.jpnprd01.prod.outlook.com
 (2603:1096:405:21c::10) by OS9PR01MB12553.jpnprd01.prod.outlook.com
 (2603:1096:604:2f5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 11:53:24 +0000
Received: from TYRPR01MB13941.jpnprd01.prod.outlook.com
 ([fe80::1512:cd0c:8675:4688]) by TYRPR01MB13941.jpnprd01.prod.outlook.com
 ([fe80::1512:cd0c:8675:4688%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 11:53:24 +0000
Date: Thu, 13 Mar 2025 12:53:08 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/85] soc: renesas: Add RZ/G3E support
Message-ID: <Z9LHJC92Bp3HxjT2@tom-desktop>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
 <Z9K4sW1iyC+0lJCg@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9K4sW1iyC+0lJCg@duo.ucw.cz>
X-ClientProxiedBy: FR4P281CA0355.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::8) To TYRPR01MB13941.jpnprd01.prod.outlook.com
 (2603:1096:405:21c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13941:EE_|OS9PR01MB12553:EE_
X-MS-Office365-Filtering-Correlation-Id: 79df5641-e0aa-4972-da64-08dd6225a8ce
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?b8erZIMFcz2EPbPUFQ3/UQXxu5ViBBRj5Yq6feJXR9w2paU+d/dNTPEklXWO?=
 =?us-ascii?Q?gRPa3NHHmAiFz0MzBSoM/kXJi3a+I8v0iCnV0/TRVwPY2sawy/uF0q4D8bVg?=
 =?us-ascii?Q?m/y0RYRzM2CEa/yjoj99PVIxgwuuX2LFe3K9a3NKA4WXGwnM3bETfcxop4v5?=
 =?us-ascii?Q?nqHn57yxy9pJnF6xHqNf6NZiS7AIQveHv8kEuEMMKM1UorsGcShTK4PVxwB8?=
 =?us-ascii?Q?0mkqIWJwyw+1UMQUxkt6/4fkUvNTr9dsCg44pMhYtwJnMz8d8kMOeqdPT6B8?=
 =?us-ascii?Q?mesq+ewW9q4Jw/iLjju/m0CLZYfXEdPVizVgX9OIZrwOh4iwJMQU9SwUfc1+?=
 =?us-ascii?Q?qddYws9ejj8tRUdRKu5P2TBKcdYK7gwbLAaWoxKAUX9D7uV0400+6KIIGg8c?=
 =?us-ascii?Q?VepUwx2tkABidi2a9MK+J9GT/WsJP8uV0MRBb5x2yal9sUk+Jo7Yw62T1c3o?=
 =?us-ascii?Q?m7rNEie8mODR0bbBrGNBvpYj3/JdUlhw+fJ9vTGu3qlDOdIdkvFJIC1XYD3n?=
 =?us-ascii?Q?T3P+ltk9lvi+HoKm8hURKM3XBNay30+VVxmETRJTRiOAHrTqWLbCAT1nzf/S?=
 =?us-ascii?Q?FCJZUU8n+8iFLphrW8lMJ+yN7QyLbFFaE1WE7sFgSONlVlyvSc8fBmIA0S6R?=
 =?us-ascii?Q?BiFdNOMAngU+4Ha+/bWHAitpzEJaXioWIP+LPfIV9zjNXI3q1Ft1QMna4EYJ?=
 =?us-ascii?Q?0nS/aUycCmIPGoNbn+smyiSbcNSq1SrfG4heQhAM6p4tXzT95QGKVe87AoFC?=
 =?us-ascii?Q?6B4S14wj9NwUlVnv7UP15Kfg+sp3bJf3MwYEGB6HdPQpZv/5E/Kg6TCDQgl4?=
 =?us-ascii?Q?5IuwkmFrn+U1OC2LtQB2AzP3oWRsJsGlM9JdrOa6yya/fSD6YqmYm0ZXf39T?=
 =?us-ascii?Q?RcfrTrC/2e9UY3OR1WaVVCkkrYPrIc63DXwxvW9u0wi7vsyah755C+LBMDDa?=
 =?us-ascii?Q?WDJu/X9Mehtii2+zDLlKSuK+24eCwwODsSgrxvinn4YqaS6UQcuFYJo/v54p?=
 =?us-ascii?Q?EleadsIVeWEEqHmgcuLm6GPFTHi3oSH33Sv6jeqr0Ml8sYjMdRwi/kuffxwy?=
 =?us-ascii?Q?jGvBrIOMSAu5hNAiX3JrHd6T7+uUOkMNq607npqZfPqunPx7g4CH5hqYhaG/?=
 =?us-ascii?Q?5bQRg1GuzmPnrR21jR/h/Ae/RMYy1MqlGGnjZhfUQlDCq6w+umcGr237os32?=
 =?us-ascii?Q?NOQLFrH+OvQyRa/czC7SYp9ZPlHkYBad3SrPRnMzpWEXd5BirgYimR4EII3O?=
 =?us-ascii?Q?cp/ZQcUgG7lJ6/MupBKgG1yFqAqVQzilhCeQjkje+hriw1wP44d6wHJMBzS8?=
 =?us-ascii?Q?aJSudkbprdpy3U7CA5ySo8ut7ZRFVAJq6ihkNJmIZgXydDaSWBfM99rl6b+j?=
 =?us-ascii?Q?Rk1vJtRv8XHsH4mU0tug5EtgU78yBs14QCw5y1i7+cNQriPW7dJRYXW3u5oU?=
 =?us-ascii?Q?lL8vFiGuxNTvwUXACwP2D2+LsOyhMzsK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13941.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZpVVIPcfav/aod+5nhsd3wqd76ZNs9JlbCCbDZOE3dBqy3Pgj0scxJeUylyG?=
 =?us-ascii?Q?vMZFNAzBYMkTuIKMTqzN69/1P3L7uL0dKAbD0NrIxXGDbE2OhIOOXmTrG12+?=
 =?us-ascii?Q?zvtOfG89gzfpatJfWYeM3KkRH4a1ZqqbU4vCqi7atvIsmCXXeAjVl4xmPNsx?=
 =?us-ascii?Q?dXmrwBbZcLeiHzH+PVSKqawT1wCVUpu7KIj7GpbMcUYwObDZEQquXfQCy+0R?=
 =?us-ascii?Q?8cOnHudWIYvgunVhal1sSzk0ICheh/TV2gQN645G+JznnctCuz+BODRzCjSE?=
 =?us-ascii?Q?sNtI583dYUkqHDmLzff54g2ptM4vyLSfpmyT4T5UgdgLRvHPgIKIqSe4g9AZ?=
 =?us-ascii?Q?pnqngL756rwox2hybKXuQoDG2kL+D3QaEcUjn0/KvurcvF9j0Dzxoj/pYFbL?=
 =?us-ascii?Q?yWUln5W3GoFyekXHmFiUPhb1ll0zLCm+b64zLvYuB/nuxl97+YcvZ0ScyWuo?=
 =?us-ascii?Q?RliZCtZvG8pvEx6W9svuDvymEWgVdzUYMvJxbvSVHEQFKt3p3hyozcyyhEhx?=
 =?us-ascii?Q?XVXxCxVwfDz35HXlxRAY6Fx7t2jLH0AMnbm0jMUY5rWVTUY3ZVrl4q+EvhE5?=
 =?us-ascii?Q?CTz79Q5s6guiUvZ4pwGVZbVFfe+k1SxjSShsmSRQebOXC9nSk1f9oNNrHC3l?=
 =?us-ascii?Q?VwyH5M8XgEc2YkG+XgQJsjA6d4l67UsNoycpomGpmdxZ1IGYD3KbSEetJvig?=
 =?us-ascii?Q?uLIFr1N6QzmVWtgoaBLonHoLCREBp0DAqDkw9h3Q3hbqhMupFLojohp6kjHg?=
 =?us-ascii?Q?C27UbRHTtC/47NMhMPmjCyYf6vH33hltJj39SxDSZjnZ85cP0W7r+JojMUk3?=
 =?us-ascii?Q?rSSpTF0lsCk/QdVXkZJzf/4Jlz7+8nC94I+K+8p66jg22gPdGIgXXl3DX5UJ?=
 =?us-ascii?Q?pGKTGgpEKeNMVjs+gQKjAusY23BdKul4IibiVweiF+E/qwvjMRqvUPoQ4Vo+?=
 =?us-ascii?Q?zLfxxEZx/6GvKn4k8U8rGko4i5HBFqu36mTl6Rpbv7aV2UfgiruPqdA8vmWH?=
 =?us-ascii?Q?bFY5zyAvgEoFnTxIUZp0NdYhCJyayLRzsDuT1o+1x00k6PwEjbz/2vFaDoAg?=
 =?us-ascii?Q?+DwuaAREWjGjViowglLPXrEmyap/TNk4+dS670OGNytlM/ue4EKDM2QUDlN9?=
 =?us-ascii?Q?BynwsyKZe+f/V2Q2FRKYnMM6uO7iXZxYZYpmrUSp/VBrPJG+r5s34rBrzBgZ?=
 =?us-ascii?Q?Ea1z4rT295ZmzWNJ3yvqErFRPl4aTHz0qPx+h7R4gmTQQrOCQkPelEHfXh10?=
 =?us-ascii?Q?IzIC+bRJ0i5ouyJfWfk5ak43/OPh6XvAa+RlQxEv6fW43GDZEvO81pMJpMi/?=
 =?us-ascii?Q?odTBC5MwQgqzwt2GMVuHusPhiujiGuW29toQuhoif6GW09GacYuAqm6qmNaN?=
 =?us-ascii?Q?2Gcc1wLx8oAMGU1hYdsc0EuZc8MUCi4O8wbSP9nMTQMle53uKZ8vFYVcZ5d+?=
 =?us-ascii?Q?U0fIhKZALbdA5zylWHYq4odMDNiIKFw186ByI6y9RKPG5mV4yHtYY6G6tQkl?=
 =?us-ascii?Q?51vlQ1B+ptAyjJcNm4pjM/2A2gPokvxZqTv5JX407vwORxrW5S21a0jSuJT7?=
 =?us-ascii?Q?44J4y2NlXgK/HotXvkLPQfJtlIZRoXx6oAUtEo31gu9E52pDqlZJNqwN3iAU?=
 =?us-ascii?Q?vi6yvof0B9Vriccr7ebvpCk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79df5641-e0aa-4972-da64-08dd6225a8ce
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13941.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 11:53:24.5657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiyzDcudVXUoAERBf4DoppLe95yYYMsXY893xemEQo+fWZe7JKMchmlKaCSY6668cnEgGxoZ3M7pNiA8BU/cNLV4sdPAXidlk1Wist9IQAwbwzXXqUcRl0DHJwkZ/7f/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12553
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 11:53:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18188

Hi Pavel,

Thanks for your comments.

On Thu, Mar 13, 2025 at 11:51:29AM +0100, Pavel Machek wrote:
> Hi!
> 
> > This series add support for RZ/G3E SoC to linux-6.1.y-cip kernel.
> > All patches are cherry-picked from mainline kernel.
> 
> 85 patches, 3000+ lines of code. So we deserve so back story here:

You are completely right.
Let me share with you some details:

> 
> What is RZ/G3E? Is it new generation of something? Is it used
> somewhere?

The RZ/G3E device is a general-purpose microprocessor with a quad-core CA-55,
single core CM-33, Ethos-U55 NPU, Mali-G52 3-D Graphics and other peripherals.

Here the first introduction to the kernel: [1]

> 
> Why is it important? Why is it important for -cip?
> 
> Does this add complete support? Or just enough to boot?

At the moment mainline supports only boot. So same backported here.
Going foward will add complete support.

> 
> Is it in 6.12? If not, what will we do with 6.12-cip?

We have a plan to port to 6.12, once cip releases 6.12 kernel.

> 
> Do you have it in lab running tests somewhere? When was it released?
> What was first mainline kernel to work there?

We have one on the lavalab, but is not up as mainline doesn't have ethernet support.
Eventually RZ/G3E board will be added in lava lab for testing once ethernet support added to mainline.

Does it answers all your questions?

> 
> I'm curious, and, dunno, 50 lines of explanation what this is would
> not be out of place for 3000 lines of patches.
> 
> Best regards,
> 								Pavel
> 
> -- 
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

[1] https://patchwork.kernel.org/project/linux-clk/cover/20241122124558.149827-1-biju.das.jz@bp.renesas.com/

Thanks & Regards,
Tommaso



