Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5944AC282EC
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 14:33:20 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.43])
 by mx.groups.io with SMTP id smtpd.web10.53891.1742221995647921431
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Mar 2025 07:33:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Iks4imm1;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.43, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbMw32ATyRdGUgiF/sEClYeDZiHjFH3azNu0PhwGN7acEL7RmklDTqTnx+cSncFH0J560v3lpYz3x2rndUbq7oZir4IWLr8o3c6a2LC2UKei6VYrAuUyYdNuM15ZoYyf+JMa25S41hJLUOItBsPwP7NaVkYpY9FuOnBsIAzUukbK2TATOsHDjirPZyGpqv6wxBqKqnYGffzZTKnd/1vrh8GGFGeErUXfxxTelxi3/bGe2yOxO2A7Nop0Ejep6xnau+cdjnCuhYVgsM9pA69ZQbATZbR64Yii3uE329ZfXOB5hRP3EYhEqH03mUH95FFwBWuaWq5aqipWhMW9Jhmakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRA2mO1BzYPDfNWMfwqAojlNB9IScdh66klpRVPSXuo=;
 b=VIBfkgtVDByEUvT0coss66gNOkeLiHWOkuir4i0CqYb8oeXKTAnmLMCykn7PY5nxdUQKjCYQI/5eWh2KKoqHBysiGIhfSwp5TXykFuAjva/bo7ta8/NpH6rTzGyHtcPIAw+P1f8+ejs7lGZze8M+/MfEFoX34WiGIbf/HFRkBvA4YujJmTJHSP8PCHy8l84/LX0QJ4gGB3+K11BrAmrMzznClwA1mdFtOK3Mp2sQQ8SXMVBPxXyFPsjEJ23t3r0qRoOQY4G4TVfeaUWPnsoTEaYyCZvJlBfVP0OEYYXu5VJsple11VWfFduBfTlNNr0Juohk7CPSwlo/8Ba2SMBxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRA2mO1BzYPDfNWMfwqAojlNB9IScdh66klpRVPSXuo=;
 b=Iks4imm1hnoZ2foC2mam6VkEE+OfzUgvOxPO0+sSTtiFYlMpYqypQM5YVyi6k0V/RHrBn8OE+TVW7k/d5P7f0VLK3d7hdDYFD5S0Sq+bW3u3zctqWDpNTIiwCFPj7Txpp+rjtBrGE9VtWHKf0FvKrBFJH+G5in1pToINhvWn1Lw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY3PR01MB11176.jpnprd01.prod.outlook.com (2603:1096:400:3d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 17 Mar
 2025 14:33:11 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 14:33:11 +0000
Date: Mon, 17 Mar 2025 15:32:58 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/85] soc: renesas: Add RZ/G3E support
Message-ID: <Z9gymvnsOxYFrn5K@tom-desktop>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
 <Z9K4sW1iyC+0lJCg@duo.ucw.cz>
 <Z9LHJC92Bp3HxjT2@tom-desktop>
 <Z9P/qUzPfn368iGo@duo.ucw.cz>
 <Z9QTPtKb5Y3E3vqP@tom-desktop>
 <Z9QVjxYJH4OSm0sP@tom-desktop>
 <Z9ci7jj/Dne7qADQ@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9ci7jj/Dne7qADQ@duo.ucw.cz>
X-ClientProxiedBy: FR0P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY3PR01MB11176:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b84c1da-b764-4245-ee2c-08dd6560a4c2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pG8WOrXkLYulLzg2dNsqqRtX29ZobdyhjFYJ1PKxpHbY0a/BDG+dSA0l25Iz?=
 =?us-ascii?Q?5F/eDD+gCs0+h3ivB23afzey14hGuite6WqxPpBiAAx4nzkW4So4e9H+3mr6?=
 =?us-ascii?Q?jljWlBDVwA7BmQ2zriGaoPQICZli9VzC9kFxf4q/RBBUhdK9Fs6FwIo4kpoo?=
 =?us-ascii?Q?ly6xFqU9fG1h7nypSjJDHHtgDd5yGS2wQoWKrjVwr0UB43kxZzTth+uouIul?=
 =?us-ascii?Q?66axX1vvDuoLFex1umj7aURRtESd+qSs5k1p4wYE1xLWAIv47MP8nRPu5b8v?=
 =?us-ascii?Q?/vJIf294aXLkGEOyBSjITUyx61NzNgfatala/O13DeIymOAutipFTMFobtG/?=
 =?us-ascii?Q?46DG9YAOJXYKTfaT/n3PKo+bl7VNPIWNcyc6viOlmk2rP3yYdVclo4fY+ZJ3?=
 =?us-ascii?Q?6rvZkJ/qOWXYdCjA46/RsOJaRENJjJRQpOXmp8nmwVvtHZIPgfdGpO59ioXp?=
 =?us-ascii?Q?3+BJwXAFSH9bGxptUJPhn9Dta3PzYz64Giq9WQKJG+ov2kuGgqpkc4r+BkxR?=
 =?us-ascii?Q?DSU//gv6odxwF/+i1zGdNZ6OOmloSNXVK12azIehAxd8+jT2xMyFtgKX+wPf?=
 =?us-ascii?Q?yI8Ro0ZXBcC+Sa4GIqXt7iMKB4nvRoUbSi0XRGnsB/Q+UfelfJ2ansoR0+NN?=
 =?us-ascii?Q?LOJEdAt53DxHtJm1w5FoZfklUndM5ysleF7+yK/HCmmv7gz4fGBe5JP1/phy?=
 =?us-ascii?Q?9/vsjdBBLGsJtOCUYCAJrXiJ1hceAEHezbe+g/tkExWT81ICFdXXci5t8I46?=
 =?us-ascii?Q?r50/EZChKsDjB9yXHxjtHlPMKTxI1M2d55rdGmrLea2e1gMs94u2f+Oqc/hK?=
 =?us-ascii?Q?DiOMXJNdfXyUydDRvNMUu0upl/0wvW9OgNkpmySFEa+Rob5nNI9qVuu1UYav?=
 =?us-ascii?Q?OBvCTYhf2rFbaB13iVqLLv2SkJj4FibCXeTxp7eNQjtqlqOln563s6J95IXX?=
 =?us-ascii?Q?xiZ4NWUkip6OSjlAppSFvECW7S10qy6ufH4Wkmn8+qak19f23RBmI6SoZMcg?=
 =?us-ascii?Q?S4E78QMfKWwRIzmr/11esNw7c+npzchzGfR3FnB3YII6xiHf4Pyp7U3NZy0K?=
 =?us-ascii?Q?xlk9PZozP2gWrb4waqwStnRAFajuwS4YmR709zo1LEdC/UGAj0994wUKG0BN?=
 =?us-ascii?Q?RsDb26otoXGbWe27Q8CUO+GYH+WWkAod1dlir+ab6KHhslyUb0QaX7YEhnJS?=
 =?us-ascii?Q?fwMxwZThwJlu+OxcRAQ0G9y0UP27weOucq/v2T5xJbuE78ZPTWSLGMmQnP/9?=
 =?us-ascii?Q?8HtKyUt106/R3R8Dhqv/EQDkp3Zwg2dMaJEecSHGqiqPnsZxAOBTLkbtNYWm?=
 =?us-ascii?Q?HDvKG3xnTJCCs6GzVDy8sGx7098x8NS2oKiJwsae3plWbVHKAX86s8Zv+xps?=
 =?us-ascii?Q?6N/3jluZaE61WVVGcgX6+vy6IXYuTdxOyGL8lCVy0IDomfm00neNFRbGak0H?=
 =?us-ascii?Q?u4+Zz5s7V16ImFRTT6Taa27uWspyIqdl?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5mbm5JNeSASibnHk12PFm/gO1g+4XpfUHfVjfN9IHMa8j2/vkwb/TVpfJNCf?=
 =?us-ascii?Q?MS75j8E1TpWGZ90kZ/jFZTIpIwhngyVDSszOwrtzer41BSdBN0pfzZGsrCJZ?=
 =?us-ascii?Q?c+cf2u3INsc059F3ALvx7LAMB4QaULK7lJardHGWB9xEFAXDr8nEuClVVYvy?=
 =?us-ascii?Q?ka7DTHjpk7Qm/ATm5Y/wAHDQtdCw//ZC/mN6G6kiO5a5RRdH2JVF9XzPEIkS?=
 =?us-ascii?Q?2E5aoTbeedZc4C/XMh4PM/HXuBqAxMXr7p1pTsjaQbXKjwu5TOPIQH5QX2t3?=
 =?us-ascii?Q?WpbBDF8Ua28hH8I5cktRcgkfdX7fC9xkmxd2K8LmXCJvvlt+FNmZ2FQDgGY3?=
 =?us-ascii?Q?YU2QopFbkOsxriqqP9Evyh1iYkdJld+wunYJwxVCp1d/g9tcfwjSiYJGcXtw?=
 =?us-ascii?Q?q+9Z7yUPbvlUBZLAVgM6hLCNmdoONRXGDGVz8vhilFMFXUXiHdhTRfq3RsRV?=
 =?us-ascii?Q?TDxWrrNSkwO9q0jSsv8o8dGsgQZT+9lrfbObWPjHNyVAoTtFgBdV+5x0h2dn?=
 =?us-ascii?Q?2ZMbpfQi+nrboqr5U+M8wb9VuqLUPXW9YhgRAPSsuvNnDFskinXQH8A5fKwA?=
 =?us-ascii?Q?N751Cyi3tic5WdTuCHskpVmNRWNtOz7gf1DHfV1fsPZVAfU0KhsSnaWc6KFa?=
 =?us-ascii?Q?KrlLEKFeWR6cht6G5Q8LqDH3u1YbQ7chDOKzPlJbUE3sWfxtY+0+k9rjdEhH?=
 =?us-ascii?Q?2MG6NZVD5xrYiZz1amw39xiaOIbqcqkCEVa3z1/u6uKp/UjFjqY8JYXdbxdS?=
 =?us-ascii?Q?nIfL3tQhf8Y10Jo7+tgivyB1s5vTYwK3wAMPbOZh4C3RBJi2gdmVmpmhiwVG?=
 =?us-ascii?Q?POJRIkCtNMYbvTE9PrtWMpmfDRjtLUuZFSRrWHwWloprSOtcrBHtgKNVl/34?=
 =?us-ascii?Q?EKS23Z77b9wH+MsZUMQOC5N571eONt4Rg81Fd6a5wCyM63lwrYcdXLoowXvI?=
 =?us-ascii?Q?LHGsULAbKuCo+m5BEAwhFtl6VmOHngH1CexdDDcODpGXoL698apDOy0CvasM?=
 =?us-ascii?Q?ohNEtlIi3qYy5F/C5MnZVtzDnc6WBn2ndeRU+O8aOf5H79+Qldu/LS5OrwYB?=
 =?us-ascii?Q?JhA27Ycafdl5FZ0o+6DdOOeXnYlgXpWR3aF+VuUala0d94De/USr9t/ZD3+7?=
 =?us-ascii?Q?xsxwizuOPuhxMRj/RMlbo177XoVuSXWDxHvlKKBWdQz1OGURtMocTkeu8+jO?=
 =?us-ascii?Q?Q0FfFgPUamvICuwIWi7B3TIunGIGGcjeuexdk4vZsRX6EaixNkmBVW3RRWGr?=
 =?us-ascii?Q?ai+tNad0otjve3NjBFdH4WZtR6mX3isPmJFjqcCrP2CyR/ucixQZfgPp4P1p?=
 =?us-ascii?Q?l+Q9jdNLF2TWelXy9KDTcwGK5gHwJo2sk6vUuenwlO1KZjYsjw/koTo5dca8?=
 =?us-ascii?Q?iKOSkGau5l9HQSJsCtzAqzmGc2Cl4XcBWgM4oex1xa2e+KFXQYXOmzMumOs5?=
 =?us-ascii?Q?okE6+HujXVn/U1Zi1cn8TElB/ll78tsIRcJywfxuh95Q3WTHWVRP2quFbeHG?=
 =?us-ascii?Q?gKm2FB9Ckyy6UViuM9XwvB+sxBwzHO4nVJ8/LNHL/c03rZeLpnoComKTk6rK?=
 =?us-ascii?Q?bEfzPQSYmt6i7T47jwcZMBST3F24L/4PadS8/WImm446YUHa+Ggckiczdcmz?=
 =?us-ascii?Q?bnKmikt4BBpJPEHAu2UFibE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b84c1da-b764-4245-ee2c-08dd6560a4c2
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 14:33:11.5431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QR7x3t2LgF1wzfP9gHgkhz1/+qRzjkhAna2JKR+XSNbzJkObKD/OLVa0WMWTKuWUdVapENXJz1KXuTG3JRQb0V+7hYjM2LY+KX2GycCBzz68K0kQV2GyIAPrKU3FrDPY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11176
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Mar 2025 14:33:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18233

Hi Pavel,
Thanks for your review.

On Sun, Mar 16, 2025 at 08:13:50PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > What is relation between RZ/G3E and rzg2l? Because early patches seem
> > > > to be for rzg2l support, not RZ/G3E. Splitting those preparations up
> > > > would be good.
> > > 
> > > Thanks for your comment.
> > > 
> > > RZ/G3E and RZ/G2L SoC have some similar IP's.
> > 
> > Sorry, to be more precise: 
> > RZ/G3E, RZ/V2H and RZ/G2L SoC have some similar IP's.
> 
> Thank you. One day I'd like to understand that naming scheme and how
> different SoCs are related to each other.
> 
> > > Fully agree.
> > > I will split backporting in smaller patchset as you suggested.
> > > Thanks.
> 
> Thank you. I went through the series up-to 23 or so, and it looked
> mostly good.

Thanks for your feedback.

I've done some investigation/testing here.
I'm going to split the big series into the following for now:

 - first series:
   serial: sh-sci backpoting patches 65/85 to 76/85
   (required for a minimal boot)

 - second series:
   clock + minimal boot support patches 1/85 to 22/85
   (as you suggested)

What do you think? Thanks in advance.

Later:

 - pinctrl
 - i2c

> 
> Best regards,
> 								Pavel
> -- 
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

Regards,
Tommaso

