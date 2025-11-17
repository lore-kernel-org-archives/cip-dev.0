Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9B8CEBF61
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 13:42:23 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9611.1763386924719772214
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 05:42:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Fq3gKKV6;
 spf=temperror, err=temporary DNS error (domain: siemens.com, ip: 52.101.65.6, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0YNbEczwNrXZoWcW6eOGtsHPgmUPNtRttQsR5+r3aqIs94H3WBwIWbzx83fJG7tdDj1MGrfM3HC1rCnEwt4RCYolonn21eKzDYP7ZVlZFxFMfalF+bkitKSKFmjZh0TlFVopENuTmd1S2P/fr4O/Qoo1qMIYjIrlsJFx7vdJQ2bm9FDsioZ3MFS5pjEQo+VBlYGgGpJ+LfhP6bHGq5SA/Exz3RH+/9hHS6W6OFI+fCT7pnRt85GhPhBzF+w/R9x5MpvX511JjCgLo0nnYBdBazlg9ToMAGu3DqFerHGJCmuKMhDfiF9otLTIZWC7g3YIXCt05Hd9vhTsyCj1WSz1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2RBBvc4enaI54jbr3gXharOY7XgGCkMseY0jcu+0do=;
 b=M5HLfW/JLEcwgtTMQj0ZxzbRXOK0LSSjanvdfiLGIru7HzFTHr6Tnh88yMsSd+DiXOXwyvXzuA9iYAr+mRjGjMgvU8GOWYGxVrE4F6pMM4IRxtPkKTr9lJXkKNjQLJEIvf6hHbuKvHvsi5eJeMw/b61QpPWf6Z2YSbkpRL3/u5iqckUoX7Ie5A5tnl0R0pVsOgRyHKWPZc1PcjhmCCbfS6DX22/KfbNmVLc0FiqclU+aqoEIAYQgGkducmEfzqswPLb47UGYoXpIzlYh4I6pqKdUOxbMRiYWc6uEzv5LWkRbc01fAFZz8kU5w/M2nEx2qhWWVzuU4Zy/Z2xTf4EISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2RBBvc4enaI54jbr3gXharOY7XgGCkMseY0jcu+0do=;
 b=Fq3gKKV6fQPNxexujJ2EDXd8WgAP6snwWjFDSWQvyjYIUgE3bakNG7+K9t474v7oH6eQ6/q1QMsgeOux75kddGB1/Alrzpqo/XK9h863F7G7ipvSgktL44hhNSqcXHY4PwyF9r8zQbFIeX3BRI6kUAK3Px/zCdMRJNQfqN6dtZ6mmTJFQDp65EmtbJ0gUkIz7lna8X3FOxdRO8LQu6WO/Onakn6yLv5tl7sCsuY5tj3zq9Bb0oKu85SQqp6zmqNbyk9bno4qiETy5hNucIFWAH3KlFVelR4ZIpPYZiYvRps+Et25x3rSvXhxb+OxXO0m86ZK9iD+stZYP0cCMmhqpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5701.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:319::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Mon, 17 Nov
 2025 13:42:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 13:42:01 +0000
Message-ID: <622a5489-448c-4643-8637-d64669a14b7a@siemens.com>
Date: Mon, 17 Nov 2025 14:42:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Testing isar-cip-core on the iwg20d
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <a0f4d994-2f70-4bad-b823-b3bf1a373fce@siemens.com>
 <5cd84b25-4709-4813-9d38-2652810874bf@siemens.com>
 <TY3PR01MB11346468D1012CFB886455D8286CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <52e217f0-5cbb-451d-ad56-4c30927b99f3@siemens.com>
 <TY3PR01MB11346CDEF02F029DD1B64560786CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <70790d7a-1ac9-4c7b-acc6-2ee4edc4a472@siemens.com>
 <1877EA27D24C204E.1114802@lists.cip-project.org>
 <TY3PR01MB1134685CE8A4BD38F73A0C1D386CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <80ecb9cb-2b48-46ec-b92d-090898097f5b@siemens.com>
 <cbf91714-ab26-410f-befc-f43ae2840b56@siemens.com>
 <TY3PR01MB113465454940A82FAC538AA8A86C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5d00d5d6-5b13-4ecb-bb9f-e3724d96e6da@siemens.com>
 <TY3PR01MB113469A4BD6FE4943F03F6D8B86C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB113469A4BD6FE4943F03F6D8B86C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5701:EE_
X-MS-Office365-Filtering-Correlation-Id: 74243111-d45e-43c4-a5f2-08de25df1619
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MEdjZE9RSGlLNXZzZ2xSNm9DQmF1ODRBVitpRmhVc1BLSFFkNGN6aE9hRHE3?=
 =?utf-8?B?dkI0aXAvWmxmbWV6TVlJRXNMTGUvZU9IclNlZjBrWVcvN3JLbzBOZXhOakI5?=
 =?utf-8?B?UmpiN0tRUGJBQy9zS1RYZjhETmdKeG9yMEpPVFFWYWdtR0JLaFNBa0VQc1Y1?=
 =?utf-8?B?MDVMNmVBRi9Md0k1UGNDZzdnRFE4YkVNeXJkYnN5RmRkU3RnblpSUUdFL0NC?=
 =?utf-8?B?dVBqWkFNZ0hGNWoweXVoR1BZMm81VWlHNjhHbnEyRzJkYVcvdzdFN2c0cEcy?=
 =?utf-8?B?eEZMdWoyMDZJNURoQ3hlN2VNK1ZwM0ZNTWJuOWdvZ0Q5WCtQTjhGNVo5ZWFs?=
 =?utf-8?B?azVHeFFUV3FrOWdrdjZ2MXk5Ui93UkIyMVJZb0IzTkd4cGVVKy9uQlZkMGlG?=
 =?utf-8?B?M2M1eUdXNlhweWlJbG1kZHJFWHJtVU9wa1BoVHRIVnh6aUkwNGs3cTh1aXBN?=
 =?utf-8?B?dWhqMThnNjlNMDBsMDAxcHlRWnVBZkNuRFE3THZKdmw3aWtxc0NyRVRDd3o3?=
 =?utf-8?B?SmJoNm1wUGV0dVN5N1kwNmd6VlBCMDRGZXBlQTE1SkZaRklCdytHK3pSb3Nt?=
 =?utf-8?B?Zmo4M1pWbGhxZUU1YXBHd0FVeURMWERKY0hTKzBzMGx4dW9kSlVUd2lwTWpO?=
 =?utf-8?B?Q3dqVmo3UGRIRUlmeUxHTkNBcW5Pc0xPTjlpaVZRQndkcWxqVHEva1h1QXBJ?=
 =?utf-8?B?dFVPczNaMnpaaEx5cjVMTEJSK0kwZnAxVmdEVUlOZlVxUm80NjlXSnhaUVNx?=
 =?utf-8?B?YWdXaFVBeFJZeXZUQkE5YnBXaitOQ3UvMG44ZXdjSDZEQVN5RWNHVm9GQXcz?=
 =?utf-8?B?TmNRR3RLdWFDM1dZOGl5bHZRZzZKaWlMUVVZNC9SWEhQWUJOWlZqZ1ZiaDZP?=
 =?utf-8?B?Y3Y1aGZFOHk1bm9hWW1ENTgyZkJsK3BtaUk1cEN1bHp0K3NST2p1OHlCL215?=
 =?utf-8?B?N25yTHh0bUVTUXZaU3pXWmJteUkxeVBmNWJlMFFydC9UOHI0dGF5SUF4djc3?=
 =?utf-8?B?ZlFoZi9KSU16bFRUWWdVTHVKa3BYWHFIbVZFdllPZGl6M3c4QVZnTkZYS3N4?=
 =?utf-8?B?cTJtcGtjaEh3cFBRcW4yWEdNOEdicndwMFNOS2RyYitXOVMrYnBKMlJ1bEhR?=
 =?utf-8?B?RlZFL3p5TlBGcDIrL0xxbzk5d1JIdjZBOWN4YTVPSjluY3lJeVJ5cHhjdG9p?=
 =?utf-8?B?STJ2WE9Fc2N4Q1RHQnI3TGttVXlkV0hzSlFVUU8vQzdKZ3c2ZEVTd3lkdzF4?=
 =?utf-8?B?OWV4ZWo1RFg2OEdidG9naS9oTXNncUoxeUpDLzRLY0lGU0t1dHdhaXJFU3B0?=
 =?utf-8?B?Mk9Kakpyc1duanVWZzlxWCtWYVFlODU5MENlUlVFQWVwZjY5UmU2K0dOSGUw?=
 =?utf-8?B?MTRDZEYxb09PZWx2QzBRN2RjV0p4Mmp0eEpqQ1Nkb3VxMW1qcXZjei9henBs?=
 =?utf-8?B?SStXOWtqd09ZWE9sTFNtdUV2YmxjdkFnS2JVZXNuUyt0WTh6Z1g1Vmw3M1Y0?=
 =?utf-8?B?Mlg2Z0YyWEZWdzNjZ0N2YnY4VndQZFVQMW9YQ2RYWXZaYWwvNW8xSzl2ano3?=
 =?utf-8?B?Z2NETmo3ZjNrM2s2RGlKMWN0S2lncnRLQkg3RklKajZqYlBPKzBDRENvTERW?=
 =?utf-8?B?Z1IvTm5aOE1xY0U3Q2xpcC9wRWFkS21kQmtReGtCMlJzZkdsSUhSMUgyMUZD?=
 =?utf-8?B?VDhKVCtwWDQ0NmtxNnlpZ0RlZ0R5d3ZodFFTSG01MGpYV044RnM3SnEwVnFY?=
 =?utf-8?B?QjZPZDBHSUgza0J4bC9zZ245QTlPRFNsdDZRbUtmTzgrNytTMmJHTnJQRjFQ?=
 =?utf-8?B?MlFMd0RMSWd1UytsdVZJVG9Zb0w3MCtYK3VpOERVZm9JYW02bnpmak10Q0Ev?=
 =?utf-8?B?QWhxTzhndktrQXp6Z2QwYU9zVStOeEV4bFFBWFNGS2Z6SkgyVVEwek1qTlBS?=
 =?utf-8?Q?IYT1zz0lydYw3RK0JOd8D/SlMspFrPYd?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NUE0OWdYUXE1OXVGa0JnNDYzUE8yNE0vY2ZlbmsrRFQzM3l2M3dkMHNpU1RJ?=
 =?utf-8?B?cDlyd1hFaWZlNXBxMFp5VEQwUHdrVHN2SksxTmRuNjBtMUZuNnU0M0RFV0VG?=
 =?utf-8?B?UklQd1ZXQ2NaV0pLeDZ4bVlPSitHWkFuNVRabWJkVlMvTGR3S214ekxjL1Fi?=
 =?utf-8?B?cHpqSEZvU2RKUnFYaXMvbVE1enRWSHhSSFJwRHNxQ2RFc0c1bk51SFhYMnhn?=
 =?utf-8?B?NnJBaG0wUlhtVUJxT0lHZUNuYWN1RExFQlpwNWVwWi83aFJoNWJ5d2VkOVN2?=
 =?utf-8?B?eHhzS01rVktJaVFSaE43S1FLQlp2czZnaFBRb3BUV09Vcng4MDlaVzZGYnQx?=
 =?utf-8?B?ZEh2cUdxRVFpYStSNVNKR0YwdjFpRlBIcWM1SUFVeTdaZy9tVXg2ZUc0cHhY?=
 =?utf-8?B?ZUs1cHlTYXZMMk5mU2xCckswTU55THlrV2c0b2FlOWtnbWp5WDdveWtCMGdu?=
 =?utf-8?B?eHYzN0VNdERxL25DNkgvd0R5MFNMeDc3aDIyM05jQmRJc1J3emlNN0RNejFY?=
 =?utf-8?B?VWFwWWMwTXdPY3Rvc3I0ME5zWHc1WksyMnI2ZDBOaVJiVVFydFhwUGJwUWs4?=
 =?utf-8?B?UXZ3anhESk40STAwejZUeks3cXQ4NER4S1F0ZVdyTkw5QkdxWXdYQzNwVDNZ?=
 =?utf-8?B?SW8zK1dDL2lzdS91VzYwVzNrQlBOaC9XZUtjTFhJL2NjamVaT0FJbTFocWdQ?=
 =?utf-8?B?R3VkMmJ2Q1lObG9sYVZYaVVzbVUxS092NkFTQkhBREU5eW54enZnR1p2ZjEz?=
 =?utf-8?B?ZkFHY3JPVVVXTUJkZ0lBVWZHMk41RGI1TGZTSDNlWForWEFFUWt5aU1XV1hO?=
 =?utf-8?B?eWlrN281a3V6YjVxOTl3a1kzZGxLWDNValFOQUFmNUZqWWNMYThodFhOT1dZ?=
 =?utf-8?B?dTBUblRLK3RJQXVPYi9BSFpUdnNCdVBHNDFpQUtFVVd0S0o0Vis1QWdMUW9E?=
 =?utf-8?B?eGxUZ3J1WWhHOXkxNVpwemVvbyszOTlWdS8wM3cxa0pFUDVPWjFGNTJqallp?=
 =?utf-8?B?cEdlTkllRFJxd3NlejBmVStORUozbE4zS2hNR1FNdmhPS2p1aENnZ2RhVWli?=
 =?utf-8?B?ZDFtM0xqZnNGb2RhMVIwVndtQU4wd3JONVFWa0ZkQ255KzZrQWhBMmc1Zkps?=
 =?utf-8?B?RXF6SXNtQ2k3RDNxVkhnVjNGbGpZRWdLcVdoUWdUQUV1czh3WERLNGJKWUg4?=
 =?utf-8?B?MTdzQVovcVFhSlFCbFk2UTJKWTVEYUpBVHE3Tm5sWG45OVRzV0xpUzV1dExZ?=
 =?utf-8?B?emtZTmQ5bFhSNmdCQklvaHRLUGlBZFZiWHRYUkplOXBrTEFrcDN6Ny9NNVJs?=
 =?utf-8?B?aGNNV2xJYVdYR1JwWkl0cUN3Yi9XRnhsNWVocGVTYWUrbGZ6UlZlZzB1T1R5?=
 =?utf-8?B?KzA3RXRuK2lqMjExaGFNYkhNdVdQWW94Nmo4OWpjMXBQWXg0M3YrZVVkTHZF?=
 =?utf-8?B?MU8zQWlOVXJ4eWFVUUkvYm5kUHpEUjBXM2s3UGw5KytsOEhLSndpRng4dVdp?=
 =?utf-8?B?bCtSR2FkMVZDUW8zTCtHMXpxMkxEdTFkbC84ZmpTSHQ2RlM0aGRZcVZtcDJ0?=
 =?utf-8?B?Zy82OTJTWUNJRTU0b0w3NXBlZUQ2dTl5WDdtcysxVnJnOVlqeERYclhxUWtF?=
 =?utf-8?B?MHFkRThHYUlvT1ZqQ1QyT2pwREZHOFZNajVsZ2toNU1KWFpMR2hBZUJhVXpX?=
 =?utf-8?B?aTQ2Y0w4RjVjR2QxcXcvMS91Q0RpeFhlUHB2Z0xoeUxSeGJhc0xHS3F2c2FI?=
 =?utf-8?B?NXRNMUxlOWRZQmJxaEdqMWprek1NR3ErVkhwd0s0QjdnL2lNaFoyK05Fc0dQ?=
 =?utf-8?B?S2JsQmJIS0U2UG9FVFZzYnpFbEt3SnhaVEJUK0Fqc3F2eUJPVWxPRXpFMWow?=
 =?utf-8?B?QTZ1dTY5MmNHV3RTUjRCWThRa3FoNkNpZ09JQVJmZitaV0wxUjVpY3JxVURj?=
 =?utf-8?B?YmgwNU1wY3ZkdStCbG1lS2szWXVTT1c0aWcvanhydDUwdnhzTWdCOTNDbFk2?=
 =?utf-8?B?a0ttbVJHWmFkckl1cU5hWEVKSGZPelh6OTUwUkJFUHZiNVFEUVFha2RjUXNo?=
 =?utf-8?B?R1E0UE5ZaWtGcDhuejdiZFBMK2w0bVZEUmJPUUpsUWMxN2tTSEprNVo5b0RZ?=
 =?utf-8?B?WmpyYkJCajUxWHpoZ0ZNbmsvaVZkVUYyMlZJTFI1R09qMFo0MjBBZDRTemY2?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74243111-d45e-43c4-a5f2-08de25df1619
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 13:42:01.2882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glwN/6VwSTavCqxRDa+8y3WpHH7eMsD3rZiIdZXZdYBv+zAxnwmDCFjYy0Z98Q0hIrg7xADOn6YSOkpB6kWsXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5701
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Nov 2025 13:42:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20583

On 17.11.25 14:39, Biju Das wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 17 November 2025 12:23
>> To: Biju Das <biju.das.jz@bp.renesas.com>; Chris Paterson <Chris.Paterson2@renesas.com>; cip-dev <cip-
>> dev@lists.cip-project.org>
>> Subject: Re: [cip-dev] Testing isar-cip-core on the iwg20d
>>
>> On 17.11.25 10:19, Biju Das wrote:
>>>
>>>
>>> I have attached u-boot.
>>>
>>> Please check
>>
>> Will have a look, thanks. Can you confirm I received it correctly?
>>
>> sha256sum:
>> 224c1cff35b672c886afa94e3c857c7218bc75db179c97f48ad53b6592e5a167
> 
> sha256sum /mnt/vm_share/u-boot-iwg20m-g1m-v2013.01.01+gitfe16aa4fb779567d1b7da7c3cf22eaa9555fb483-r0.bin 
> 224c1cff35b672c886afa94e3c857c7218bc75db179c97f48ad53b6592e5a167  /mnt/vm_share/u-boot-iwg20m-g1m-v2013.01.01+gitfe16aa4fb779567d1b7da7c3cf22eaa9555fb483-r0.bin
> 

Perfect, then I will dare to update.

>>
>>
>> Now I have a somewhat similar issue on the HiHope V4 RZ/G2M I unpacked:
>>
>> U-Boot 2020.10
>>
>> Wanted to enable EFI booting, but U-Boot is likely too old for that. If you happen to have an image
>> for that thing as well, that would be great.
> 
> Have you tried 6.1 on RZ/G2M?

No, but that would not change the requirements on the boot load. This
one is outdated. See also my other email regarding warning during 6.12 boot.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

