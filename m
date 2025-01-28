Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D41C0218A
	for <webhook@archiver.kernel.org>; Tue, 28 Jan 2025 09:44:36 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.67])
 by mx.groups.io with SMTP id smtpd.web11.14000.1738057469237405512
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jan 2025 01:44:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WVOQnVpz;
 spf=pass (domain: siemens.com, ip: 52.101.66.67, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQE/MjNGaVLfPzkce5mjro9lkEFQpr4vjXatXW6ET34ZDy9X99r8Exb9hTapEok2NPEyFu+bC1FHSagsq/Jj0zkQKiVG5mYJDqctFG/9xKfrjPTawdniigoJthsebn5W/sF73V/Flmqk/YhOJ7AnULB4BWHj8FpIlwwORv4RwfUQmp+CiZjbdQ6itzX8lJ5erT3LgijtNv2KqnlaVzA8DxRLC6adB8lPY2z9pnMo5XX3JY6YLpu4qIWAcN4/cCpSZh293Aw77c9lzeUfjA3jP8Um5w2gNYsYovF+YtsH75LjLOjxXErs7P566t8iQYUiRM0RuodKzrogukzob03MBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1t1Al+hh75RMmfMF5OR/eNCJvPe+IByApcN9cUXoUcc=;
 b=VSgMXC/N4QNM2pPI03tafJ3ZniFDlmNethfruJSeCBPrnguHYMkoo+xRVg850WHDF5tZMSvL61PqKQbaN57MtmeBy142rI5s4g3RgGbzJRVcXam2GLnn+0yfdWwzgo8USnhsGbOJ9e+vbpb6yeD4BFzo47gxsm9vdGbDa0xoh7nhGbn6x+P2zw0YOurRfkFN3ZHJ6KltIU3UNB1n9CfkYpbDNYeKTOD6QjejSp+oA+udotMyhDeNGm65S/d5Q5OcrRtwfNnqSRraI314ohAmx/gvj/ZmohxArsYLB2pnTKWQmVn0Q6tyjhYJ8oUNrpJFYwaGK/s5h7wRUmHVYWtmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1t1Al+hh75RMmfMF5OR/eNCJvPe+IByApcN9cUXoUcc=;
 b=WVOQnVpz9MFEP2vQsHCOK7YvnEGZc2HzUwU5iyVHawAGGH3D2Q2hVWtJcQ2uY43e4S3seZz4kYA7yubw0Vj29ouEgEIbGLtoxQftkx7kDuAR72jD2CHX9a1V1NbvhfKrtAyninVbZhCx5BKVYq6KP1G6Ot64d+u/hsvLiPNoRvGvOlxwCPs5tSrwg1jNpZEGtZ85niGyAcRBqjSp0OFzx03FtorwuqzA2VmlT/4VdodHhfMBgEjaIlUf5G8jpkJek8u6DxiHu7yrDvxN+nyhhFxip5abVhZUGnF6SfpiUknn8NnXzrgvNbL08XFw7FzTdPEiwEDYIpDxkomDen62Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by AM7PR10MB3494.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.15; Tue, 28 Jan
 2025 09:44:26 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89%5]) with mapi id 15.20.8398.013; Tue, 28 Jan 2025
 09:44:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jan 2025 10:43:34 +0100
Message-Id: <D7DLXLIXEJ2B.1FZ2QPQSTIG41@siemens.com>
Subject: Re: [PATCH 0/1] linux-cip: add kernel config snippet for container
 compatibility
From: "Michael Adler" <michael.adler@siemens.com>
To: <nobuhiro1.iwamatsu@toshiba.co.jp>, <felix.moessbauer@siemens.com>,
 <cip-dev@lists.cip-project.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250108100755.55673-1-michael.adler@siemens.com>
 <27230c907a5b0c43baada41fe3b49528b0d81eb3.camel@siemens.com>
 <OS0PR01MB638822A2AA063548128D1A8192E32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB638822A2AA063548128D1A8192E32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0303.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::27) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|AM7PR10MB3494:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8f73a4-5059-4342-7725-08dd3f805a96
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TFRhNHo0M29HRG1nT3hHbjRaWDNhS2JlcGRmcjdHclFUcjFyOXdQdllwMm83?=
 =?utf-8?B?cE15dVJROFErenQrcE5xS09LTzg5WUZpcFRGWm9SbWRESkc4eFB1U2RmdFA3?=
 =?utf-8?B?ZlIyR2hSc3g4dmcvZXFMbG44RU5WcDlGUTQyaERROWN4eWYzT29CR1lsSjk1?=
 =?utf-8?B?NVV2S3FkU0dCQVhWa2dFV0liUUs0ai8yUWtlM3FMRmdNS3hXTmpuaUtickNF?=
 =?utf-8?B?aUtyMVk2YUJKL21BQUtoV3JZTXJKYVdKS1dvUVRzeFBwcjgvSmFkVkZJNzdW?=
 =?utf-8?B?c3BrV2l1OGtSVHRidzN0cE5GYUNJc1ZrbEJtVjE5Skg1L2h2VDVsRkExenBV?=
 =?utf-8?B?c3pkbzFjMXk0eVdjOU5NQk81N1Z4OTBRc2VrNkg5eGRxa1NLMW5SWDFnUzBC?=
 =?utf-8?B?dEFld3ZST0FlVitWT0NtcGpCSnNjWlAxTU5Kc2kxRmtiQ0RlZVNXNFgzVHBx?=
 =?utf-8?B?ZHlCa1lVRVNDR1RlWU5lM2pWV2N2MGJmSXRaQVJ5YjV4VUhiTTVTUFM3R21k?=
 =?utf-8?B?SU5CeThKYWx2TGZjQzMwMjh4TlVJOXR5NmRBQ2JjNVBSSTh2c1NUSVA1Ulkr?=
 =?utf-8?B?NnBlcG9TU2tETVNsL2p4bHl1K1V6U2EzVUowTlRJQjIvSmxFbW9xLzJBR3Jt?=
 =?utf-8?B?cEdNUy9YcWhSUk4ySVVmS1V3bFIrZ0dTOW5qa0YzMG5FV1V4WEw0ZTZTaFpa?=
 =?utf-8?B?UkNVWi9hZzVuRWpDTERJM2xHSEJVdGFtQkZ5Syt6T1doamFOUjRXZkg1VDB2?=
 =?utf-8?B?eDUxOHdxZ1RESEFyUHRad3Q1Q2EvbUM2ZjR5MEtPV0NReStkeUZXZ2F0a2Rw?=
 =?utf-8?B?bEs0VUZ1d25uWG9LODZqNWRURklUWFVhMzRTQkI4amNBSHl1UEpHaUNpZDRO?=
 =?utf-8?B?dEFjMEx4MnJja2NZL3ZXZW1zN0pNTUxwN2lWRUxrdE1xRmNSVEdHa1JiUzlh?=
 =?utf-8?B?dndISUN4OW5lWFR2MWVoZ3pFMCtNdFZBOWVMd0F6TUxSNkxxTFBhdnhnS0Z4?=
 =?utf-8?B?SVFxR3VKTWpadTc3eFQyVzF5bUoyeVVpMlk5YnlaWHNqTE80L3hndncwSTlp?=
 =?utf-8?B?UW53b1Y0bzRBbVV5UFczdEZDQndqWjMvYjVLMlN2OUlMalhZZHRaRXl6YkRU?=
 =?utf-8?B?Q202anAwTWJEdmxuWGM0dmZyWmxENnAzeXVuc3ArbzNoejcwc0gyY00xYTdT?=
 =?utf-8?B?UjhlUVVKMExVNHphWXN0dzMwTnhla2lyNzFNMng0ZlIyaXVhdkpuU1MwNmNQ?=
 =?utf-8?B?QVY0MzM4SUhQNkUraDlUOXNSczRUMERqY1BFRXJRV2VldzE1bWFMTngyM3Jy?=
 =?utf-8?B?Q2FOVXJrcFl5TTZVd1ZmL1FZeDVpRTF5K2hlamJRYW1MamQ3d1l6OUpLMGh3?=
 =?utf-8?B?VVlkRGxycXpBYm0rdkNYdGduUEV0Ly82VDc2L2pjRGswUWo4Wlh2b1ZCRzlu?=
 =?utf-8?B?L1N0cGtHTE04eGoyT1M1aXh3NDU4WVMrYk5UbVBwSnhaK1hPbTh6V2tYcUxN?=
 =?utf-8?B?b3pnOFlnYTgwb2l1SjlLRWMyRU94YklPZ1g5TkNraHNTZTJDdnpjbVhPTnlK?=
 =?utf-8?B?SFpsMXF1bkNKSU93ZzFmMnBQTS9QeHp4OXJSRzFKZzdKejJTUi9sb242aFFn?=
 =?utf-8?B?SXVNdjk5QTRNUlVMVUVTTGlJaE1iRjI2YzFoQlhRc21OZDZaOGRFVUlIb0Ja?=
 =?utf-8?B?UTg1VjZsM2tKZjhFWmtnU2dXNWtuVFVscWcraHZBUVVOS0k0NUtpdjc4ZGI5?=
 =?utf-8?B?Q3RyVWk3Ry92cTd0c3I5OWZXT2NBSGk1MjBUWEZTVnZ5aC9yMUQzQXREWURF?=
 =?utf-8?B?QmZZUFpFMXlmZktJTGVrTG8xMkh4U0p4czhaMk5qNkFiRm9JVVZiK3Y1R3h5?=
 =?utf-8?Q?byZLtQY2SH/6P?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bzU3TWZJS1I5Z0xoV0MraUVXNjRmMGlnMjJYRlAxUXJ3c0d6djBKYVpNdDQ0?=
 =?utf-8?B?RklmS2pDb1lLeWhvZHpIL0ozU1JpSGdHdkdnYnlvdmFkZ1JvSkJlQyt5N0l4?=
 =?utf-8?B?azRpYUc1TUc0K0lXckZsSllhQnp4Yi9STGxubmxxUmlRZGZoTFV5OHVxNWFz?=
 =?utf-8?B?UDdUUGwybWNFQk9zRFRRMWNwelBqRFhqZnBxaFE1Y3g5Wi9RVHNrS2J6bjMy?=
 =?utf-8?B?WHA3bG5nYnJIand1Ynhrc3hiR0NxTkgzWk1hRGVWYk5Oeml4OXdCOE5SblJs?=
 =?utf-8?B?bkczQzdzY1dRYVdZVDFhOXJ1eU5Xb1F3dVl0VDE1TjBTQUJCQ2doTTBOdTYr?=
 =?utf-8?B?SDdkTENmTnduYW95TDBNcm5sb1AvN1ppbkpJSU9jdDV4N2c0RGZOc05BdDFN?=
 =?utf-8?B?ZEgzN0I4TVgwVXFrdEpvSHA0bXhmSFkrWTlLM3BUQ0xKcWI5dHh1NGhuWDhD?=
 =?utf-8?B?aWZHS3JwUVhUZGRvRWw1Y1pvcFdDdkxUd2thR3cydkszTUVBcUp0dTZGMFlL?=
 =?utf-8?B?N3ZrbExqSEx0alVUTWJFWER5dVNWdlh3TEJ0VEJlMTl4RlBvQU43N1FEaFRH?=
 =?utf-8?B?MVhiQzQ5Qmw1SXdqRXMvdXJZcy9iVWgyWVdMWmlRa2hwdklQZU92YVNjd3hM?=
 =?utf-8?B?Vkl0ZXZEVXRla0VRbGlPSmdwbERiTnVVUSsrcVhCV1RQbTVLMzNseXVXR3Nm?=
 =?utf-8?B?OCttbGlMWVkzMllrcXVwZjlLUVFMODV6K3JUdTF2dzkrSVhQVWc1TkVlS3J4?=
 =?utf-8?B?REEzSkF6Q3UraWxhbDhKcGl6WXplWkltZGp6ZzdWVllOcE9yRFpBR0x0eFc2?=
 =?utf-8?B?VXlSb2dWL01aUThSSkV0RmVmcHJKVGQxRDFydzAwN0liVk52bGFEQjdhTW9x?=
 =?utf-8?B?aTdUR09RaDhtTEdlK05yMGpydWNTaEhiSnlxTVB3Y0RRWGJmaFJ4Q0Z0TDg5?=
 =?utf-8?B?M09kYkFUNHdyWDFpbG5mYi9nRHFxcjlpRS95ZzdqYmZWMlVlMnV2STdaZFUy?=
 =?utf-8?B?VmJxenFaZG5STWhZaUw2VVB4ZU9rRHlhekdMRVVDYkcvdnlzQlpQWVhVWjV2?=
 =?utf-8?B?VnlhKzlJdVN2dnpxTHgrNkFrc2QwYVk5YWRLS2hBRml6RjBtc0d2a0Ztd2JM?=
 =?utf-8?B?dlI2dDRQZ01YRytKNkZqbjRhWnMxYzhvZXU1dE1WMEZycis3UTI3ZXREUGxW?=
 =?utf-8?B?Tkx1VUI4N1FhaUJyTEcrVWhDUUp5VHNlb2J5MzRGWUdodEFYaTlvQys3N3pm?=
 =?utf-8?B?TnNLUE90bDVOZ1hsb0NMdS9jQi9VL1FWa3dId2s3OFQ5MGkxRmlRRnkyRzVa?=
 =?utf-8?B?M1lFTTNiOVBMNUdWVk03UENpcWtwTW1Jc1ZQWlBGREl1dE5NRzROR29DREND?=
 =?utf-8?B?RmdXQTZ0NG1aT0t0am5HQlBUWEc3YVdOTU1VWm9OODN6bDVLbVNXN0lZZlVu?=
 =?utf-8?B?Z090aVJWemlCQjdETDBWU3JBYisweGsrWTY3OVV6OEUrcG0vcVptVVl3amdN?=
 =?utf-8?B?bFl0WTFobkw3cWJMUWFtQjF6dkJNdUVQK3JXd1BnNXp3dUR3VUkzS1J3Wk83?=
 =?utf-8?B?S095b24xeXNvUTBhUHAveHF3U2ZodHVhdHYxK0JEVHZKSmNXMVlJcWx0Vm9O?=
 =?utf-8?B?aHRadEhzWnpNMHdIc011UHhVRUdvcmVqUW1yQmJqR1QzSnM5RDk1bVE3cnBM?=
 =?utf-8?B?bWZURWNsVHZiNU50clJBYW13Q0IwZlVoenlvMGpmcnp0M2hpUEFMcHg4eWxQ?=
 =?utf-8?B?YTF2ampZajlVQzEvdWNCN3hhMitaRnkzRHphR1dqRDhoQnBWdGVoVHFIZjBQ?=
 =?utf-8?B?NkJCMDRWcEFrdVU0RzNON3hZYmxiejV1MHBweExiSDlpN1YvbVhJb1Q0VVdz?=
 =?utf-8?B?L290aFJGM3drNHFSNUx3UmJhMGtINFJPb1VjdWFoNmx4TUh3NzRCa2Nkd1p3?=
 =?utf-8?B?UjlBdm0zWVRwTkJXTzdSak5QdCszWnVFS2hLaEl0Q3R6VzN0OVpNTFVHNzBS?=
 =?utf-8?B?QU4zQUhBZzlLMmlxL0kzYlRheGdZcDVlOUhpV2lFb1hhaWNNRUJKalJGeG5R?=
 =?utf-8?B?b0NCR2NRWUhjVWJtOENZeWtBNGZScU1Xcnk5bmNFb0c0VFM0TVlYc3BVZ1hm?=
 =?utf-8?B?NUpzZ1Z1ZEE0ZW8rTHl3REdxUWJyRWFzNE5kRGhBN09hVGRpbmw4azFpSGd6?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8f73a4-5059-4342-7725-08dd3f805a96
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 09:44:26.6687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: da2IGjhzC32Yc0PQ7dIg4nECXd48aLsffaRrQMa5lNQx13ghw6ghNBo9hvuW89SgBy8c6YF/rGzCQut0ATtLAI6HmYwr0IR5MJhEM9+vtE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3494
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jan 2025 09:44:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17672

Hi Nobuhiro,

thanks for your reply.

> Yes, please send us patches.
> There is no reason to distribute and manage CIP kernel configs.

I was hoping you could incorporate the options (which I sent in this patch)=
 because I'm not really sure where to start:

- There seems to be a lot of duplication, even at the file level (e.g., `fi=
nd . -name '*_defconfig' | xargs md5sum | awk '{ print $1; }' | sort | uniq=
 -c`).
  Do you manage everything manually, or do you have scripts to automate the=
 process?
- Device-specific configs include non-device settings (e.g., cgroups, files=
ystems). In which file should the container settings go? cip_merged_defconf=
ig or is that file auto-generated?
- There are kernel versions listed that were never LTS upstream (e.g., 6.11=
, 6.13). Are these versions officially supported by CIP?

Kind Regards,
  Michael

--=20
Michael Adler

Siemens AG
Technology
Connectivity & Edge
Open Source Embedded Systems
FT RPD CED OES-DE
Friedrich-Ludwig-Bauer-Str. 3
85748 Garching, Germany

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim Hagemann
Snabe; Managing Board: Roland Busch, Chairman, President and Chief Executiv=
e
Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Thomas, Judith Wiese;
Registered offices: Berlin and Munich, Germany; Commercial registries:
Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 236913=
22

