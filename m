Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A77CC4829E
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 07:25:25 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.79])
 by mx.groups.io with SMTP id smtpd.web11.9230.1707981922394438688
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 23:25:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FWoM+5Ks;
 spf=pass (domain: siemens.com, ip: 40.107.105.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+xzJpT6Qf0xuQeIfwT9quwygnWheUiaN674EWyASruc9p+X2z/crjylhdXeykXEIu9aYmJncZ4mjlkSVlZTrS36pwH+BQuhGYORM27GsuAxW5cnYr25jNYmHvlWAt3/GPs2h/kXopK5WLhgH+3pqtz1EGLFqop0M3ooJkJGJSFcD1DODdVs9kzWvjS3KY46etzaproZIijX1TWKwNZNABVrlhs73AXOGchsEf5RNtq70LDqIzZd7sjC5y0vfCNFsZHQVq4HmF6PAN7asOldmNpn2VF3dShwbtJLSDDVeLg1Z5bP7mQ3HBhzAa49SOZN5JGZ8vNv8Ok/5GU0NiTgrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xDyfi1dAMfIFWOWKqFlzP5aKNrwpV8+LW+2A8FnQ1A=;
 b=fAW6yE609U3VL4lYJDX2IR7/irodGJB/AjInAZvAlIO91qWitgy1/7OmP2/ziJxQbNIz4Ow5db2C6dXhScZYBrtPJki89xnf4pmVuKX0FHuBHj3h+/i58C6PzA22jPNccpZof0ftVFxn1rAz7Y7c7bgAWeI4eCxBdL6AKo6mgV2PkvtRngQH5oyT1hG/zGWywetCMopbZToP1ojeQE8kNabxhalye4/xMPV/AtBO8YZaI0nQoHmiXXJOvNR7e5p0eKOTiQ1qB2ugQEQjR98uuvYBjh0nuKkbb57MOr+IEvJrEnJdf9S3GWfLg33bsvcGe+81GMxlYorcl33Z9pBErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xDyfi1dAMfIFWOWKqFlzP5aKNrwpV8+LW+2A8FnQ1A=;
 b=FWoM+5Ks9pzEmpTDK3cuqERAtB993kh2yeakERlZ8by/R5KJKyNBc/x5R5p1JCLlibb8M1ndx3Nnm0kDrXsTCft1TTwXZiejAR0hgDU38Kf+dV/OYLE7ah8bYQyqIxgPKpavNfnqYBPhAbrPHsAEtXhBj4ZcCg7RUFjybzOKTDnv/aF2OSSfc/3azPDprQrqEXsRqBOzAbPTYA8dSRSqKRVz5WYef1S2ddyHA9TuYXrwU3JFsKxOPKP8GZPej0HiyUnKJfLXX+M0iDtC/JNTBdpZJ2n6N/q14c5KBVSw3Xs6x99azgeAU4tHxfu4rKSMpqe/in2dUHQN01AK/nJnCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6426.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:545::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 07:25:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 07:25:19 +0000
Message-ID: <35333ced-20d6-415a-b9af-fb363b53ab66@siemens.com>
Date: Thu, 15 Feb 2024 08:25:17 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0261.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ac7e76-2192-4a95-0727-08dc2df7434a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5fbtJR/RzsFFYBS/TYgrq+BIVBmtepxT9g+mUdbZh5E1dJWo7B/gTooptgU17L9+pEKF2iM2m4c584pobOqoiSRl3amUbS4z6bqTL91h1j157k7CaWrNaarwOji6w5wSsc9f7O+lSC0HNSAPpwJvsAgfevF69HA6lr+9STJwPjhSnad5meBtlq6ApBbRuTKY+coieDQXTWRqWI5l7YEhbnlcBPulTxLngATt2e+UFJPlyszY9Rohege8st9ed0pSC2peiZlfbFenbweKgnfMeGOCgdhHP9lMKFn9i9K0DKjZVpjxUA6CCvQ8du/u6f2zczz0ZDYkXSxXjc94cWyxDLdk1ei1cTPCimfhp6b3QenYqr+yDoq9YNjpJKeXX5BlwkmG+6n7obkGbi309YKtq0jsIr8K3LNhVdEWnzJbrCcT0zqjpqj3bX5/A2Rnnoig/YvcT6kN1WOoiOFIQt2kv68H4xhGvzTwcYHkmbMXzeuzWjglZYytoR2aQDivBypss4G4p+gnvTFNRRtegHpSoPi6BAkWJXXnxGTb/DEJqE4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(41300700001)(38100700002)(82960400001)(966005)(5660300002)(2906002)(4744005)(26005)(44832011)(478600001)(36756003)(31696002)(66946007)(6916009)(6486002)(8676002)(66556008)(8936002)(66476007)(6506007)(2616005)(83380400001)(86362001)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bFRjam5iL0hBMkZHNzZxdi9BNUdaZzN4MUJSYUxyQTNqcXNVMUV4OWtOYlVS?=
 =?utf-8?B?ejJValkvMUFpK2h3MEk4eVF1WUpDMGgrMmRMVUFGU0pZWUZTZk1rWUtEVnpX?=
 =?utf-8?B?MGVoaXJ3VTF6VkRLdEpqbFlZNWoyOXFkMnJVVTlCaFdzRWpjV0JpdjI4Q2hn?=
 =?utf-8?B?QXVrUkdYWXNMMVJYR1RoSTZFRlhBVTdzWlZUUW9pcjA3RjIyM3RDOE9JbTJP?=
 =?utf-8?B?UGtqbzVsRmxGaDFPQ3JEUGpwWHhPbW5UR3QzS0JBVm9iYmNGMGo1TVFhamM3?=
 =?utf-8?B?SG80elFmdjF4cE1RczM2YnRGTTlkT1haZldRbStOcmtLSUVuS3cvWEFnRDdq?=
 =?utf-8?B?dXBQazczWWwxNDFFYTkwd2ZPL3EydW9aTTNCVlBSYXpkRitRNFMyc055dWpa?=
 =?utf-8?B?YWpSc1RseVRqWmRaSTRYVHowb2FyYWIvbnY1eVlMSzVUZGp6UFV1UVpaYklS?=
 =?utf-8?B?dFExQXI4aDh1d1FiVWJzT0lqd05OWlZhWVBDY1NrSG5wNE1KVFJJSDVHS0hn?=
 =?utf-8?B?TDNNSWNka0xiSXV6WVVPQ2xrNVUvMmNxSmlhY3ZxUGRmMTZYbHhIeTk0QnZv?=
 =?utf-8?B?d2x6MkxrdW9HZUdySis2Mll4VTNGOTBJOFBxdE1UbzFmamRSRFYxWHBVUkFj?=
 =?utf-8?B?YUg2cWFiVUgwdW50SXRCM1JWZW41dUdZRWNEUUNjUitZZXdSWGZpK2VZNTRD?=
 =?utf-8?B?VE5lWmwzU05VYzRXdWxZanBxTDk0V0R1bGlXd00vcURoTWRlNWFzVVkzMFNz?=
 =?utf-8?B?NVlzOHphRmpxWmJ2S0NJcXlwTXpqZFpjVmFaakFQOU8xcE9aQWY4TjFLS0VN?=
 =?utf-8?B?YVQyeXlTN1h2V2xEM3VqSVQxRUFoMWM4TE90a0FxNVJqU0pacGU1TFdrQmVR?=
 =?utf-8?B?S1hWQWdKSjY0ek5pNE9ha3o2UklpUXcxTmVGcUcxdlI4bWdhTklWVTRmbnA0?=
 =?utf-8?B?ZEJJVjFMUDFVeGRXeG95VDFqbktXaWh2T2xTNXVRSm5VS25rVFJWUWdpWU8x?=
 =?utf-8?B?T0pITk02ZHJnWkU1dEFoNFVKUmRPYTRMaUNZaTBCTGpleXZnY2U5b21CZzZP?=
 =?utf-8?B?MVN0VENsdytxSVIvYW9BOUN4SGNiQlVNbE9QR0RIVGo0S3hhZ0o3V2xucGs4?=
 =?utf-8?B?djVTNnFEeXh6ajZqYURxUm5Sa2h5ZTlZYjRHS2pub2ZyYUIzSHoyYWNNNEJN?=
 =?utf-8?B?c29pSE1VYm84dzRNYys1cUo2MFJiUURzSXlNdE5wMlBtbU1ORWpQazE0ai96?=
 =?utf-8?B?UEhCaU1lYUw2Y1N4RUh4S0V6dW01dTJ4SjVmRXhBNVJXbGk1cU1ZYmxiWEcr?=
 =?utf-8?B?UTdXZm9KQkhTejVhT0E1WllRamFBZmdjb0F6T0hmVnZHazBYQnFCVkh1OEdP?=
 =?utf-8?B?eU85SlNweXM4OTAvbHpZc09ySXlqNFdjVjhJR20vZXplNTlsaDlYT1BCMlBy?=
 =?utf-8?B?N1FIYmdnNGk3cHQxcmRlV1c4SDhLamtjUGYrSXMvQTgzL3h2VWlUNmRpWGZ1?=
 =?utf-8?B?a3VJaEVmN2JrZFhRRTNqQURxbHIzUjJXYVM2aXNQN2dyajlFOGE3U1hTYkgv?=
 =?utf-8?B?MGJvano2OURyRTUyMGFVT0dsOHJBZ1I4dXRvL2ZvL2h5RG5DVW0wU1YrWFg1?=
 =?utf-8?B?alMwZ1ZnQVYwaVVnWTByd1NoT1pRVHVlVXA0dTUxSlBWWDZqbTlPNHFIOWFC?=
 =?utf-8?B?VStWalgxU0ZVaE1mNExkN09EWW1uOTVJVDQ4WXQ4Tkl3b3drWk1GcG5JUXd3?=
 =?utf-8?B?NGZFZUpIM2dnYXk4My84Uk0rc0JDUDgxWi9ZR0lHMWNCb2MwUTFWMGNPSjl5?=
 =?utf-8?B?QU53U08ySGFVdnQwWEliVy92dTFxVk1mUHlNNzgyUXdEQ3BFZVZkWTd2Wnpj?=
 =?utf-8?B?V0t5NlJBTExkRnowWUdkMkszWEFLeml1Vy94QStXYjBCb3pSNjNSUjB4ZTk3?=
 =?utf-8?B?enVJUnI0cDNyZlF1WFBCQldRb3JRbFVtTWlORU85WGFXMGFkSGU5ckF3YWNN?=
 =?utf-8?B?YzRhbXh4TGpnb0tMQWdQVEVlR1RnZWZRLzVjZXBudGgwb0dlVnRmazdtaThV?=
 =?utf-8?B?OW1YeW5LZGpjOHhoRVNaREFCY0RrWUtDd2VUTkRaRFBncktteTRtS2dWTG9Y?=
 =?utf-8?B?WFQ1SFh4ZVVWUGMyYkVlZ1JHNTg1NnhKRWtSdFgvNnN0UVFGNEhQT2ZFVVZL?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ac7e76-2192-4a95-0727-08dc2df7434a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 07:25:19.3330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XU7OyKJj+7xePa295VPiB3rc7tVhTXq0a02CZwgHQwK/kmb1sA1J4IJ7NUTGu1GZGuCGz62qczOGD1OLqeoPdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6426
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Feb 2024 07:25:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14988

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=2&day=15&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/02/cip.2024-02-08-13.02.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB
  - Kernel as CNA, more CVE assignments to come - any impact?
  - turn off kernelci bot reporting to cip-dev

Jan

