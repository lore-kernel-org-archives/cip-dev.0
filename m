Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA1CD3E796
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 05:58:40 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2665.1765432711123680526
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Dec 2025 21:58:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JvqabPca;
 spf=pass (domain: siemens.com, ip: 52.101.69.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSb1hPv665jVlCY7GQtIsYdjYvI5oUPtYx6FXRF2teymdJJcPho/GUBLU7DaXcC3rf1cg/wCRlAm674iEBiQSkCoPnVHaY7a+gPrOOcKROiclMsDvvQdwQhupTYOjBQTe5rtjDxWCbSGLrd3CqVgUcUbHrHnsqG/cXWRMG9cWjK7U5MfAAIMRwnvTJRuop+rjHk6HcagI50B02SfDSXrgUTgU6CX4RWCa8wcU8j6UX63nNE9ythjCQ1TDUvadRFJrMW7H23s90fVMDU+rqX67VIriN53e8YQ/7AFS3uDQJGYL14wyIp9YsnlwKpbyIDIOA8xq6iKip7WW7a8kunYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUrGdO4ReH0uLWLfDdfw34GnFH90SUg9IrFoU6UFwo0=;
 b=s0oYav0ivtdJ6p31yQMyyGFCAkO0dUi9Ws6yFAE3ygoqOe8mefQxy6X3EWbgMPN2VMAwNtHyN8k0YuSqYPNTyY9T12lI4p9RYEobwlrOukf/L3Ledo1pldfD+cSeU4kOb4TZr4B6YCKQHMWajSQX26o5fIYCinRwKlnTOHt21wHbvdYp117PybEUuP0ITmuP3jPAPXa+xqs0HpmiQWIHonmzjJvb0XjJlFnY46Az4y7gpP42Q0SpgVXpKRfQaoOENtZlZVkDVDTZfunZjWxmXlztWIZI8tof1qHHmEQaYGl0ulqinm+RNrEwdaFqh63OCp9w/ruqiVhNW29J/St1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUrGdO4ReH0uLWLfDdfw34GnFH90SUg9IrFoU6UFwo0=;
 b=JvqabPcavNGE+WF+t9DWmmIbocRFXQEmLgIbFoI/fjv7tBHzv9Q6nToYLyYDN5G+pgy4mOd0lEbjLyr11drAKUakS95Tiu16hMMChKBapK1NmG/2Vz8lxRsarxCO+2e7xJij+QSWbKvDhrdUNjgNTfriyLO+eiBAqE/bJhP/V3sw4HwLmfkGw5/ni6iOlDk/uhGYxkElf3H9HGXJzLZeaAzncklm4ufXF22giKlkCrs8vn/h8sZDQ2k5ANzHyxRZyYDyPy6IldCtVWxzH0Lte2vmZRnJB3HHZHgTCqD3pcen22AWLj7/B/oSHDmdayG6XEgYGwWjYo0a5WbYk8jRbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5653.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 05:58:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 05:58:27 +0000
Message-ID: <6273c86f-b6e3-4709-bb88-66398b4a6df3@siemens.com>
Date: Thu, 11 Dec 2025 06:58:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: CIP IRC weekly meeting today on libera.chat
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <77cca9d7-bc24-459a-9694-0d522d3ef90a@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <77cca9d7-bc24-459a-9694-0d522d3ef90a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: ac46b313-43e6-461d-f1ff-08de387a4da2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R3cxa2FJOWtodlRSaEhXcmRiSFB4KzVMbHlTbnJQdWh1djdiUE1mTXZkWjN4?=
 =?utf-8?B?Qi9JQzlVT1VOeGlOTDE4M0JzSXRKWDBzSG1UbWN4aUlwdzI1USt5S2dtNWVa?=
 =?utf-8?B?OC9tMGxXV1EycHg4ME5Bc0JqVWI4dG56WlFWZFVKNlpLeXh4cmVWZDRORmNi?=
 =?utf-8?B?ZWo1dFpacWlLWGRGTGkrRExEUE0xVVVnR0ZhaXByQ2ZtRFpOYUdTWUd2eVFH?=
 =?utf-8?B?eEh4aG0rUGRzVVVPUFhja29wdmtsVlU0UTRoKy9lS1NGa0RpNktmVnZ5ckFU?=
 =?utf-8?B?WDI0NWIxK21EVGtPdnRXRWZWR0hrYThkSTV5ZEx6Zm5FMHZMUmloK0hMK2Qr?=
 =?utf-8?B?UXl4Y090dktLdmJCYWV1b2NhdlMzSmVkTEtycGkya3hTcTVLb1JxeVozVE1u?=
 =?utf-8?B?dE5PQ2lIOEgxem1XNXl6Z1BCUzVieGNOVlRWMFJjVEJYVENGRnErWU5tdGRE?=
 =?utf-8?B?Y0ViT0t6WjU2bXBUTnJtWmRlWXc5WStzY3hRUzRYZ2RUenNmUmJqdHFEUFRk?=
 =?utf-8?B?ZldpaG5TWnUzdEx1Mm9nVjBOUTlvSFpnRXVSY0lZcDVGaFROZWN1T282NXUz?=
 =?utf-8?B?K0loc3d5THloMFRMMElnVjA3MU1Zbm5XZi8vU0dNbUlKMnhWN05oaGlJQUtO?=
 =?utf-8?B?dzcyMlpDUURsMnVYTTUyNld4Z3VJVit5QWUxUXRVTWxDeExWbFRPdlh6dkFW?=
 =?utf-8?B?NXJjSm9aZXR5MDJ4Q2RtYmtuRFhMTmo1S0M3ZURnZEwzLzJoNEJxMm1Hczl3?=
 =?utf-8?B?RVdQRHl4WXNJVjRkU1RHSzVNNzFBZGRaZlE3a1FxbGdoc0dzV1RubjhNUnBl?=
 =?utf-8?B?c1lOQ3l2Z3VWeVB3MU1qbHhrZkI5SEI1YmlTeFh0cEV2cWR6V3VnZGdWSlc0?=
 =?utf-8?B?ZTRWYXhoSFBIQ1lDWW5oQnBzbHl1YXdwSEJYVkRNUFdQdFdiQlFyQUc1L002?=
 =?utf-8?B?d3hyWEZyZEFHbjV4VVlWSnR6UDRjck82cEMwNmJTTCtFVXhrYVRvVWFGTkk4?=
 =?utf-8?B?UGJUb1pWQUN4anhMVXJ2UlFLUk5Weko2VXVDcCsrYmhORGMxRXVza2xidjBO?=
 =?utf-8?B?eWQ1Z0l1d1hER203UkJOVmJYSkRJS3V6Qm5BbG5mUk1pQk95YzB1eUFMcEFS?=
 =?utf-8?B?SXJCcm0xdXBIbGtMZGhwcGhwckwxZFlDN29NbDBYVWpEaUFjOTRFellkU0lJ?=
 =?utf-8?B?UGgrdU5JNVJKVkcvVGNqRGlLVTZnNTUwMUhkekNnQWVHcEJCclNHV25pMGNJ?=
 =?utf-8?B?a3I3RHZ5UmxIckdKakFMejZsdUtjWVBBUGFhYlRvWlM2SWhMSWF1TmdiVG1h?=
 =?utf-8?B?VEFRSVdzMEtsZVYvK1ZaejlnRDd6YjBNclZPUUt5UkczRWE3MGw2U3o2SjlN?=
 =?utf-8?B?aUJkdTNPalBpZlJSb1NCWEVFWEUxdEVtMXlGZUhMMGRXV2QvQ2pPSm9xYTl6?=
 =?utf-8?B?NmhpeTJ3d2tMMWVKT0VXWWpyQ21naGNkcFpHMXlWVGpjTlVJOUs3MmdTeDg5?=
 =?utf-8?B?UUdlUmpXc2M4RGJlaVFqSER1T3JZeTNaQTZrUDFUS2JDa0dWRzY5WGNaWjVW?=
 =?utf-8?B?OFNwMjZ1ZzU2VGVYR2FjNHJjaEYyTCsvRkgyVVYwSE5FN0Y1VE55U2l1Yklk?=
 =?utf-8?B?MTl5WTBhWmV4Sno0OUxQZkF3R3RzMXF2RlB3ZXdVVDFFL0w1YjBTSFY3ZURk?=
 =?utf-8?B?bTB1U3NrckY4N0dTQUhFK0pDZ2dYVERibnNTRGdtaGVQNGdzd3JUK0JuSEZO?=
 =?utf-8?B?U28xZjdCWTJ0R1FYd2VhRlh4MnI5cHhuVTN5V1ZxMVJhZmJ6TUdNaHl4T21u?=
 =?utf-8?B?cjZyMDdndkZ0Mm05ZDFqV2RtMzUzSUtkbm5OUnR6am10YjVsdnBKODVHTmVO?=
 =?utf-8?B?c1ZJRTNYUVduMktLQWNsTWRnSGhaaDFjM1h3SlgrWEt5VEE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QjBrWmFsLzQxVUNwQjRDd3A5dHJPaTV2SlZTeXFrcDNhR29FazN3OHZ3cEw0?=
 =?utf-8?B?NFZaS3dsN3Y0MG1MWXk5WGVrMFpnRWgyWDR5cXcrS3ZnR0JVZ0hFZHgvMnl4?=
 =?utf-8?B?VWlvcG94M1E3cTFIaGdaNktrYTczZU5JQit0blNON1BmbXY5UTRaQ3pEMFNN?=
 =?utf-8?B?ZUhNSDJQNDlrZ2szNEhXSGNvdzNYL2g4NmM4MUJ1ZTlNdHAzWUdqa2RxVjBP?=
 =?utf-8?B?YW1LSDhsbXMzRmVRLzc1WVZHeUpBTU95RmxKL2dLaGtJbjNheXBEa1cwamdK?=
 =?utf-8?B?OWNWVUh4WHhFcHRFNk1KZnFibzN5Z3JYb0NlQkRGcy9QdFBKSFA5ODJqUU1z?=
 =?utf-8?B?TWpXOWgzMzllTVV2eThtTlZ5TDd6cXVLeThiZWoybTVwa1N6VEVDT1UveE51?=
 =?utf-8?B?cXpPZXV0UUxYUFBBSnlLeXNuSUEzb1VYUTI5czhCSEg5eGNCOWpZSXN6Qktt?=
 =?utf-8?B?RzFyTW0yK1FaR3FqZEVIMm5mWVhaQ0lnVlNTdld4OXVPdVhZRjVaam9VL3gr?=
 =?utf-8?B?RmVXZ0FENmJ0SFYrTFNhVUQxZUMwR2F3YTVJZFZPUnRBTnJ2OElqK1hMbzhJ?=
 =?utf-8?B?WkZpOGhMWlRJNGhZb2syZ3Y3LzNOYXczRnRFQUh6dzFSQi91OCtzcmVzZkhk?=
 =?utf-8?B?MDIxalJxZFlIWkE2RUJ1L3AveUVsWE1Ba2pJdjNQc0N4cG5uM1BpWmtMTk1j?=
 =?utf-8?B?Mi81STlsbWJxdlkrZGs0U0loOXRmT2ZVV1hteUJWY1ZMV29NV1hRcjR4cHVt?=
 =?utf-8?B?eE12TSt3dGFOUGdBaGx1S3Q0S0xhaHpzNTI4eUd0dGdXOGlYSzVKdFFiai9p?=
 =?utf-8?B?VERtTG5uNDl6MlZLaUlqMHBhd3NoMnpBQnBxcEc2MHlVTEswckR5ZGthUkUz?=
 =?utf-8?B?K2xVTkxON2NDV3gxNlBDSC9JOHhNYThsRkY2Q200a3dGQ3F4QzNuYlpLVmpB?=
 =?utf-8?B?ZEFidDNXY1hQT0dqbFlZMkFtVXV0dHlPSkVwZk14MlBWTTV0Nk1ybUloUHlH?=
 =?utf-8?B?RW9ZYTV4K1NWcjN0dlNLOWVRd242aGEwZnRySzUwZTlLMTRpckdZc29HK01t?=
 =?utf-8?B?NFo4N1lRY3ptbklsQm54ejRITUFhSTZhZW1NY2ZUMGZTQnltZXJubEdaczVY?=
 =?utf-8?B?V21leGpIZ2lzTURVc21SeGU5dDE0OXF4UERjYjJmd1RqbEVtc0VpREdqTXlD?=
 =?utf-8?B?amlaL0JtLysyTDNOQzZldmMrSmV6d2lnM253K2loMGl0bXVGRGhhZ09rYmpn?=
 =?utf-8?B?ZW44SUtlM2dQdllzdllHejlDTnJTNWg5VFpVZ3ZnWW15U0NJTXlUYzNjOC9n?=
 =?utf-8?B?bkFSZGdyRWc2RCtKR1dtWlB3WUFpSDRtclgrUW16NzhCL1FaMkhvekwybWtC?=
 =?utf-8?B?VUZmRHpISHlUKzBuejJmWmNCUnk1MTJLS0pKdSswR2NZTVhWMDF6SkcxdkNn?=
 =?utf-8?B?cDZCZmxTR0RxVXRpR2JVUHFWM3JwdWFrK05ONTZZeUNQaTNQNWpjSHJjU1Zl?=
 =?utf-8?B?dG0ra1MzdXZBMlFsRnB6aXpOZnVtRU5hajZrWnUrUU1XT1BoZWZOSjFSM3Mw?=
 =?utf-8?B?YmlIUWNoNkJnMFh6WUdpTzNwc2dZcDlhVUJHUm9Mc0N3NHpqTU0yRXN0Vkk3?=
 =?utf-8?B?VHcwS1o4bXBMYXNmN2NocVFKSWN0VmJJdnFTM01JUWZ4SGxxV05ZZkplNkhh?=
 =?utf-8?B?dVVENHNUNFEvY3NQYm5hZm40WUorUE93UnRnTDBpUG9RaGZkRnlGVm9zVkM3?=
 =?utf-8?B?SkF5SkdxZ3ZqemQvUm9ESzJzVU90ayt1dWthVnR1ZWFSSVBGdGhMVUdtRjlv?=
 =?utf-8?B?YXZNVlBsdGJNTlhVTTFvR0poaEdnTUp0WmJhY1VsT2k1alg2Wm0wWVUwcyty?=
 =?utf-8?B?SllHVlRrSjNNVnpZbXgzdkZVam9sYWhwR3hVemM4OUxiNHRQNXg4Znc4MFhv?=
 =?utf-8?B?RXZ3MTMzeUVISk1ESUJpSUEzMHhFeEJUbTcwZHpZTDlXWUNibVRYczV3eFBq?=
 =?utf-8?B?VGhhcWQrbHcxdmZoV0xlbmhiRk5GNFpoVE5oaVNGQUNiRHd1V2l2STNQQVda?=
 =?utf-8?B?VEo1SDZvSUxQZkFJTUYxVjNDNG1sc1YwN1FQNU5zSWNQU1Zrc2UxbmhEM0k3?=
 =?utf-8?B?aFRJQ2phMng0RU1pbE90aDZKOUZzNXl0YmxaV2M1UU9UcEhNb1BsbncxNFlz?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac46b313-43e6-461d-f1ff-08de387a4da2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 05:58:27.3765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gt+RB2HMxQi2f0N9yCJwkmgs+P1JvFPW5EzMQUxZDplNqTYkalfAIhArRPCNxrpLur38zTNTyhwH5poJyvASIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5653
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Dec 2025 05:58:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20967

On 11.12.25 06:57, Jan Kiszka wrote:
> Hi all,
> 
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
> 
>     irc:irc.libera.chat:6667/cip
> 
> The IRC meeting is scheduled to UTC (GMT) 12:00:
> 
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=12&day=4&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248
> 

Sorry, it's

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=12&day=11&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

Jan

> USWest    USEast    UK        DE        TW        JP
> 04:00     07:00     12:00     13:00     20:00     21:00
> 
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/12/cip.2025-12-04-12.03.log.html
> 
> * Action items
> * Kernel maintenance updates
> * Kernel release status [*]
> * Kernel testing
> * AOB
> 
> Jan
> 
> [*]
> Date the data is created: Thu Dec 11 05:56:56 AM UTC 2025
> linux-4.4.y-cip: interval 30 day
>   latest version release date: Thu Nov 27 12:52:11 AM UTC 2025
>   limit date: Sat Dec 27 12:52:11 AM UTC 2025
>   Status: On track
> linux-4.4.y-cip-rt: interval 60 day
>   latest version release date: Wed Nov  5 10:07:00 AM UTC 2025
>   limit date: Sun Jan  4 10:07:00 AM UTC 2026
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version release date: Thu Nov 20 10:20:08 AM UTC 2025
>   limit date: Sat Dec 20 10:20:08 AM UTC 2025
>   Status: On track
> linux-4.19.y-cip-rt: interval 60 day
>   latest version release date: Tue Sep 23 10:53:07 AM UTC 2025
>   limit date: Sat Nov 22 10:53:07 AM UTC 2025
>   Status: *Late*
> linux-5.10.y-cip: interval 30 day
>   latest version release date: Thu Nov  6 09:00:25 PM UTC 2025
>   limit date: Sat Dec  6 09:00:25 PM UTC 2025
>   Status: *Late*
> linux-5.10.y-cip-rt: interval 60 day
>   latest version release date: Fri Nov  7 09:45:57 AM UTC 2025
>   limit date: Tue Jan  6 09:45:57 AM UTC 2026
>   Status: On track
> linux-6.1.y-cip: interval 30 day
>   latest version release date: Tue Dec  9 09:48:21 PM UTC 2025
>   limit date: Thu Jan  8 09:48:21 PM UTC 2026
>   Status: On track
> linux-6.1.y-cip-rt: interval 60 day
>   latest version release date: Wed Nov  5 06:50:13 PM UTC 2025
>   limit date: Sun Jan  4 06:50:13 PM UTC 2026
>   Status: On track
> linux-6.12.y-cip: interval 15 day
>   latest version release date: Tue Dec  2 05:29:12 AM UTC 2025
>   limit date: Wed Dec 17 05:29:12 AM UTC 2025
>   Status: On track


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

