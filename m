Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2BBE9A049
	for <webhook@archiver.kernel.org>; Thu, 19 Feb 2026 12:50:34 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.55])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13002.1771505432398428786
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Feb 2026 04:50:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Kbfwqkox;
 spf=pass (domain: siemens.com, ip: 52.101.70.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuypG9KW6/G3i2BY2NjriqQ+0k9BvGWNEmbJeosuaxk/uXbm/f1H/cpDLH2+nI/2IRfdRES7bDJ/DZFM58fg82cV7lxmtRKvfQZD713FvyAXVbOOxIZ0anRsmwVU79ns4LPmRiqEN1ItZhhXY2QgViXHe8ReR6etSFPtq4cm2j9MU6anY8taJACkf3zDgL0hj9KdYl06s5Voimq3yDO021uLqtgIFUTg/+cHE7r3uNzCtUiLMEFVmxb2MufbWwZoD20Ozx558syUIhEpt7KGLv3etJQJO61fJkj9W4XtIWJ7b0GTqLazJg7Y9iO9ill/+9k5UE6iN2lMF8KVYGfgjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jk6jQS8yWDbA6+05SoFJelseG7xtevEfP7S3RaXG9So=;
 b=w1ZBZ2kcQzShR8Us2DCZ9eo4Ohnr2qv33/srjyVS/hOYqklN3Hl3lGtJhhH16LwoVb7UUB7g2QMOv7qfgciEbPQv6kkEWPJIZsSgNHwv+NOSDZJkjiqgQvpmS3V2smtDHmMrJXrU6jnHE7tP/kYWPLmL/5WIECKiP/idhMsa5dJrEnl8NoIOXL/FF1XOmy40gBBAtya4vtBnHxUejYYnuAyUx7opR1Ro9mS315T98PFXVtsT7+RBrcE3myRJ+CLSR3YKTfjdDJbgzRhfy2LmZuyr0DOHy8QTbnJa/GXRkG2vyXJBnRt5yoSQ36fYZnb4GoEOtPzMBuOmP7xjtRigQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jk6jQS8yWDbA6+05SoFJelseG7xtevEfP7S3RaXG9So=;
 b=Kbfwqkox2Asg3AfRg+Lqb9zdoKtVQXeSgsk2wbwAhy+6cuSssht1AdREp7cF8uGtr8a8c6MxahDB4dOLe7k3Vtr2jIzMEBzyCSVbw7EuX7HwtlmcXaqhvBvyoJmPjYQ3Yvj67SWZCz6W601+0RzDcsVi2Vd0YA3xrd6gtozkTMP7PWUEV+hWDW0ZLOv5xxLBJYXA7sR4sLmyNE0IfIvDMd4jDZ/5xfUz6cOkaqjPNrMNvFi6uX843YY/yPGig0Em64ygnIIo8eqRk2jQH+8FSHmCGlhhzTkZvbdyfvFYm9ybfPINdV7zsXaXulD4BOCh0LWYNrUuAtck7GhQ8ovRbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7139.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:313::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 12:50:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 12:50:25 +0000
Message-ID: <3bd31e51-cdb7-41b7-9c7a-c65146d28cb2@siemens.com>
Date: Thu, 19 Feb 2026 13:50:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] fix: Disable bootloader
 interaction in case of ebg only updates
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260219123726.922484-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260219123726.922484-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 384d9eda-50c2-4f75-65a9-08de6fb5738d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cld5bCsrWmpkOHQ5NFFUM05MczNEemxxdHdnOVA0Ym5SR054SUxSRjhxZHJn?=
 =?utf-8?B?MzdHNVErR3BpRnI5ZkZwemVGR0F4dVRlTmUzT01EV21vRHhnaTErOVJPbzcy?=
 =?utf-8?B?Z052V3FDR3ZDVk1IQmxsVmxWM3N2SG1ucVkvbUx1SGF0NnFyYXpvU0RQcHVv?=
 =?utf-8?B?K2ZPc2o2SnZwcVJyRzlqSWw0V1dYeTdBZGVOU1ljT3RnMm13QzROaEJSMm9r?=
 =?utf-8?B?RWY2R1g4V2JJS1VsYTVIbWM0aHYzU09yZDBHaDVQY1IyY3RML2JYNDlnVmV6?=
 =?utf-8?B?dnNHeHB0cTFDMURibTQ0TmhNKzdBSCs0MkMrSUJqeGIvbktycTFiWjFTSS9Z?=
 =?utf-8?B?Q3AxQmJZRS9Ccm8rK3J0Nk16Q1Jsd0FaTm9FbXdJWStvR1ZxL1dKbVRUbjYr?=
 =?utf-8?B?R2kxZ21jbWV6S01vV1pabEJYRmdEelJQTHBTRXBlZUIvL3RTMFNVTExBTUxi?=
 =?utf-8?B?OG1nc01US2xHdFZJSisvaGJIa042Y2QwaEJRRERJTlNTK2Z6K25LSVlQckdr?=
 =?utf-8?B?Nkt2T0RpamFreUFNK3VhWFg0MWpQZ2tUVGdSK0YyV2hNTDQvZmx2cmNXWFFD?=
 =?utf-8?B?VkczWHpwdUVMVG5tY3I0bUdqTzNLUTB2N2hyNUd2K3M3ZmgxUHdSdDhlZFpW?=
 =?utf-8?B?WVp5Mzc1STFmQnloZ2FLTW43VW85czBabytsRzQ4dFhCSGVHT0FUa2RFQlVx?=
 =?utf-8?B?U0JqWGViaFJtcmlFZSs3c3htSjd4SFdraGN0c0Fib0lJVVNjd0xucnRKTTY0?=
 =?utf-8?B?a1ZzNkZlZWIwTVZLS3gySHB6dmRIb2dFRUcxa0cyUjczYWkyUTU4YlkzWGZG?=
 =?utf-8?B?bmhKbFNZUmVyNnplckkzNHJ0RmMxK3BFdGFSOUJaZzMzVU9ZUEFZbWZCYllJ?=
 =?utf-8?B?RGRmTHFSNmR3NWhUaFlVTUpKWEJ0QndiQW9TQWx3WkhoOWdyYWJNNm5sQnV6?=
 =?utf-8?B?WkxORVVySWFiQkNZYzhyZk5jYVhXUkh6eU40S2dpd1IwZnI2bmNKWjUvYkps?=
 =?utf-8?B?RnphdGU3YUtmWjJmblg0dmE0R09TY3FxRFpjbUE0L0RRMDRnems4RDdhTlgr?=
 =?utf-8?B?VTFta0c2cUVZZWhNMERvNXhFRVJFNWU4OHJhVU1tcXJIREMzbWRXMEJWU29M?=
 =?utf-8?B?bUx6YXRXVjBPWU9UcGFmMDRHaEgxNjNiQWVIb2JpSlJ1L2tOeW92QmRxZ24v?=
 =?utf-8?B?am9jMTAvTXZVdlpWc1c4Y2tqMTg2eTdLNWNqWDRzYlRMS20vQmt5NGRVWDU3?=
 =?utf-8?B?ckxndzZ4SVhGZmU1YXRsa0I5YVdzYmlFTm9SS0NhOElxNGtlcEpiTWhZWExN?=
 =?utf-8?B?UEtYd29nb0dCYVVJVjFTMmJlWFhSc3JIN005azdQcUMvbElMUkFCUWRkRjkx?=
 =?utf-8?B?VWNFMS9wdGt0VXY4elR0WVJQZ3krSkNFUmdFUFI2VVFnMWkwN0FQN09SV25y?=
 =?utf-8?B?cksva3NCWFJPWWc0aW42dC9aOTA2TmZyaDE4SnJKLzBZQ1FpTGtZUjlMelFk?=
 =?utf-8?B?MWEySmdTY0xUK095Yk9Mc2FNR1MzbmYrV0w4NHVZR25mR2dEVVA3d1Jxb1BF?=
 =?utf-8?B?NUY2YWxaUWkrYmhZNVI1U2lDai9zSStHekM5MlRUdEU3NUlTaWpKazVCdWFB?=
 =?utf-8?B?MmI5S2JJRU9UVnBCc1d2ZEFYSzBNdWF2d3lUWnAvMkJmVWFtVTdZdGJoczJh?=
 =?utf-8?B?aGI2dVJkSklGNlplT3hVM3RJZy9qMU1zdVBjMWJzaVQ4NHYxcGc2NWFZZEJo?=
 =?utf-8?B?SENPZjZsYWpkTmI0V200bWVURzk4Mk94UWIxMEIwUHVKU3FIZ0pEQk1UNTJp?=
 =?utf-8?B?UmVBVXBwOFdOVkxyMklWU1JBMnJHZy9SQ0xhVjRBTElUN25ZOC8wN1FNVVdp?=
 =?utf-8?B?U1JEVmdYY0t1bkZ4N0pydnU0T2FGdUNzV1JzYmFyaVEzMThONm5qSUZIai9z?=
 =?utf-8?B?SmpaZlhMS1dQd3ZhYSt3NE11bkZMRHJZRUhnaGdMTEUvVTJtNjVKY3BoNU0y?=
 =?utf-8?B?Zy85TFZpNEUzU0tyT25VWC9lbDkyZzEvMVo2dkthQmg3d0VTNmJPbjRsZTVx?=
 =?utf-8?B?eml6SXVmd1ZSTmxUYVRGM0JaeFU3eUp2WS9jR0dDbyt5U3dJWlZTUUdsYjNL?=
 =?utf-8?Q?W81s=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dGZTYlRtWUREa3kwd3pEUFNrL1MvRGkzR2xWNmhjMldaQ2xkaTg1d3p0VVZu?=
 =?utf-8?B?RjJ3Kzh1eTk1OVFsTXRldEw5UWpndkRNcGU2YWRINnNBQTBXaTRaYllQZWp3?=
 =?utf-8?B?QWhMMWI5ZmtycC8zajN1WG9SSHY5Q3BmaGZnWkFGMm9JZzE3TC9QcGlTQ0sz?=
 =?utf-8?B?Z3EyNS9TcGIxa0gveUdJUDJ6ZzhEQ25UTGRUcDNhNk4ydTNuTlRJSGFmRWl2?=
 =?utf-8?B?czdxWncyWGpsQWZSbGg3TytOanBReDc0L2l5QnA5UFlEZmRHc2Z2UE80Z3pj?=
 =?utf-8?B?VjJsTW5aMCtjaW56WVNmQ0lVM0l5eVNZT0QyRFVDeUNKODV0Umk2clV6OTVU?=
 =?utf-8?B?VmhQb0lmMjgybkdjZXp0Y3NFYzhEZ1llaDhDd0lzeXI5SU1zMUFuK2lzUnBi?=
 =?utf-8?B?dUJaaDlyQ0dQckh4NU8zakozWXhyL3l4ck0rN2ZBc2ZUOWdObThlRUdFOFp5?=
 =?utf-8?B?eXk3bTJkMS83dzAvcklpMzBmUDdMeU4zQXRNcUZDNmhRZTYydnVPdnkyMTRX?=
 =?utf-8?B?eTFDSDVXbzBLQzRxTEVVK1gyU2ZzalRPTGJhOXBDSFppdVZESEM4R05TUlFK?=
 =?utf-8?B?SEJFSHBsY3ErVEVnKzNtSnF5TUxtY1Z1ZDk4RHNWNm4ycFpTZWRlYm92TXRR?=
 =?utf-8?B?L3laaVRlTVc2aks2RkpvOFZNZSszUnRDbjdlc2s4M0gyeGhteDlXbXIvaE5i?=
 =?utf-8?B?eG9xZE1rQ0xCWjlkZlZDdE9LaXA3MExzNE82bTV3VHBrUWVhdTFKc0lobEw3?=
 =?utf-8?B?OUFPcFRPckhoQm5TajRLY2YxL3d2ckdaSFdvZHc2dnpNcTFYakQ5bVFvekJ6?=
 =?utf-8?B?Wm1UV1V4czNnK0R0bUN4dDJDRGVXK0xDR2t6OEhjNjB5WmlmUTJjOVRDRUdp?=
 =?utf-8?B?RkVQODFIQld2VU1QdXBSTnZoRjFEN3B5bG9MYWxQZlZ2bTVScmVBbmVSVW5M?=
 =?utf-8?B?bEt1NmhMQjVDL3lGU3F3UTJiM0R6eEdabU1aRFRXMjg4dmxQZnh2MGx6eHcv?=
 =?utf-8?B?K3NYOFpRRGpueG5xRjk1aFBaN2VaNUZmemNJVS9MbFUxMWFCdGxHSSttY2lQ?=
 =?utf-8?B?NGhlNFBOM1N5TkUzR1V1c0VBSnM1UzhHTGtxSGpkS2U5S0JOVDNuWWhacmhB?=
 =?utf-8?B?dVAwdi9PbmZ1c1Z3ZkZYb2tGV3FXbXVkeFdKSUN6S0xRS0FGL2U5ang5RXEx?=
 =?utf-8?B?WVc4NGplNUtRa2xNV2ViaEZSTFpqLzlnR2F2c2RURnRBN0F0TTB5WjNRbDBD?=
 =?utf-8?B?YXNTWi9CU0ZzVDRNWE1HYlJ0V3o1S3VTVklJWmJ3Nm9CKzI3RXlqc1RDZlJL?=
 =?utf-8?B?OTRiOFg3V0hacVllWkh4dENlLzN0TlhWcGU4RmQxZ0U0b1d3VkY1YWFXdlFl?=
 =?utf-8?B?UkNPMFFQOW1BK0NLRnF4Qi95TEVCeEpKU3NzY0JGMFE5cTNSWDRQZXB3V0pT?=
 =?utf-8?B?K1VmcVRzcXp3ZG04M0VuUnR0YkhxbmZqN3RQL0x2eHRqUTJvZWN1cWFLWmFh?=
 =?utf-8?B?M1ZYdjluRGF5NWNWemdhL2h6TFp1MXlQdE9BWFE3SlFkN3ZqT2NoY0FUZGdF?=
 =?utf-8?B?TXlrUjhOamxidjIxWFU2Tk9QZ0ozQ053Y25OMGdva0FCZ2tFZnJadzdFb1ZT?=
 =?utf-8?B?K2toWmZDOUdxM2svZyt4YW5wRUgvWCtHNEIxRzlJOXhSRTJLcldlTzg3UTFa?=
 =?utf-8?B?MDZOZWxGRDNUQ21mREpZYmlyZ0ZjK2NTUGZLb3ZLU0FpY25CUlhOZFRjdWtp?=
 =?utf-8?B?VVh2eCtIWnE5MzE1blZmY01tSTBnS0p2clFSM3RzNzl5aGJYUzVucGdudk1D?=
 =?utf-8?B?LzRwSk8yU0tyYzA0MGxVMUQ1MUJaNEpwMkw3USs2ZWd1Ry8vNlhZRXZTWUZy?=
 =?utf-8?B?c3JvTGp6dk54V1hibzA2WGRmbDc2bW5Mb1lNSSt2dDJaa1dueG4zWEhwUzUz?=
 =?utf-8?B?MDhJNURCakZpbExpQStxanRVRnVwa3JYMXJHOG0rMmowcGRNTWhLRCtwR2lI?=
 =?utf-8?B?Z3YyTE1ZYWlmOVZjMmx0c2M4NTFSUVhpVjFNMmdGQy9Xd3VGTWd3MkRKeHRW?=
 =?utf-8?B?OC9yMTdiRUVyRiszcXJ3NHhJMVJwZlNHZ0F2dzExMGhKbWtSZ21MQnpzb3dv?=
 =?utf-8?B?TVp5eUtWbitUQ3V5aW50L1ZyYnd6bDJpZExTOGo0eEY5aHVBT241dmJTNmFY?=
 =?utf-8?B?RmFham1aQ0xxd1BhU3ZVY0M5ZTh1YVp1Ny9yOUJVOEVLektGa0kxQVVISVd5?=
 =?utf-8?B?Qk5OZUdPMHQ2dWhsTXJuc3R2Nm1DRnU2ZDkxd1IyQ3dhOW9WbmYxWWREU3R0?=
 =?utf-8?B?ZUU0S09mR2JiaTlBQzdwaXdUK3ZoaWNhVW9XV3lpc0lEWVdrQVBOUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384d9eda-50c2-4f75-65a9-08de6fb5738d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 12:50:25.6918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5GKxUK+rB+d0FQsmDqexrGzE+pPeKWwbeHVzxmpYoqyxDmChX9y3pmyebeRb+mhB7PSsurKciCDVFvNqvDxUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7139
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Feb 2026 12:50:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21898

On 19.02.26 13:36, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> During an update of the efibootguard binary the boot entries should
> not be changed. Therefore disable the boot-loader state and transition
> update.
> 
> This was found during testing for issue #149.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/images/swu/sw-description-ebg.tmpl | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/recipes-core/images/swu/sw-description-ebg.tmpl b/recipes-core/images/swu/sw-description-ebg.tmpl
> index c19157c..a63e38a 100644
> --- a/recipes-core/images/swu/sw-description-ebg.tmpl
> +++ b/recipes-core/images/swu/sw-description-ebg.tmpl
> @@ -12,6 +12,8 @@ software =
>  {
>      version = "${SWU_VERSION}";
>      name = "${SWU_NAME}";
> +    bootloader_transaction_marker = false;
> +    bootloader_state_marker = false;

So we need to set both to false to avoid the SWUpdate talks to EBG, and
one does not influence the other (although there is only one state in EBG)?

Jan

>      ${SWU_HW_COMPAT_NODE}
>      files: (${SWU_BOOTLOADER_FILE_NODE});
>  }

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

