Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8183C74A5B
	for <webhook@archiver.kernel.org>; Tue, 21 Mar 2023 06:31:14 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.61])
 by mx.groups.io with SMTP id smtpd.web11.6768.1679380272149419532
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Mar 2023 23:31:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AlVO/gJM;
 spf=pass (domain: siemens.com, ip: 40.107.22.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJJG4f2+0uJdTBSa78sXTLfKl7UO/mo4cRmpNyi5sgFK6D417khfSn1FlqB9xE4oJL2gKnIZ9c298q61qkx2DHgKU7y+WfgkW6O3O/mKQVtejc7gahlBmFHMJtSH+tnCnQ5+HmxpN2y5aLYRkbypb1lA/+d/mPpjPpPEB9VY4uF0FkCxUTCuvjFxBz2eXKgf6yRlLW7LVvFffLhzM/eMmvJDMd6DKDd0kZ+ha0I8PqJ2ZkgNg1YbmbEqjSqQ5Gs8xz8wc5rCg3IKE5Bu9fRUFNdT6phd7cBCsqQT/1cuK0mkqfhi8r6AEYgM0oDVs2E+nkUpXw/NGPDrGVgaTmj0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yIitwviowSmLSwQF6HyGDy02xolf01ma9y1Y3vKFOg=;
 b=TR/GUEwznaOB9CsLyecQqdWOy+yM8vKWJVPLAkrvqkDtvAv0Ck7jZPrFR0RfKPCLZ9CoXFSmYouv0xmwV5z3kmMc27XqOFpx4HkKIul9Shi5yg/3H00KgWLQ7PAmWHRL+WfyULqi2LDGKf2JyoUJoIAKxKGq/lXOeDH8zkxoTwsuHU197DjxzAM/itNQ/RCUn3GeigRpaR/tN56sE+4WHgK8qwGF8Xl6MqqhHR2xszwpcE5jHxh8t7pH52ueXF9M2JHHz5VF09SW0ioMbeqi9BX9o7q+pgRB12qvKWyEh1JiOupLuIJZEIwG8JbEHuJ3IblBOXLTzwv0I6cua5ULDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yIitwviowSmLSwQF6HyGDy02xolf01ma9y1Y3vKFOg=;
 b=AlVO/gJMinrhag1rABRybgKZx6uGGiVoLetA2I74y0kEaFA3gijUXjCPSHFHsM4KK5yTvIcuu+1BbV9cUr0PXizcV1oJVT9LF+JSJ5jB8p4Cu0rCLyrrkA1g8bEyzwfXMlIeGQikhR12TkUluMWkfhHXIpekdvHYnyrNW2RlQ3dEHj7Ip35Ggg7H9O73t0NyBoS7vGXQRxRKm32dZyJwNHssv/bwRi4i/tmYYcIiKXxez/X6Fo1eRUzSTVtARoxsuKLUKm7q2aiuCjdfluKtNKbPb32smfBOPQjnIqaB+caCqRCrN3MLhJXpfZGkSkOhJWQAkxycB0SmjFuYcmPbPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8255.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 06:31:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.026; Tue, 21 Mar 2023
 06:31:08 +0000
Message-ID: <05923d83-7dea-4d7f-5c86-e07288750093@siemens.com>
Date: Tue, 21 Mar 2023 07:31:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.0-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a81e1c-767b-472e-7c53-08db29d5db3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ezhc+IFqF99OLRDYVzy2Kflee9fqa4VuycdrNw7zTUwuhcOat41l6HM7BSVGYSyKg6kvC9b9hofixo6oGS8NiqsiyglCKs7AJvC3dMJKIo9n2x7BlPSxEg7vY5JC9Kh6rK1jhmpd/sjzs2v3mBwvQo7JfN/qUEVSSUmp367sdG7TIlwcp67/aSrYc7ZcF+orWBFTO2WwhV05FR0KhSYAiKCnMW8De1PC5xgd3GAHjwR9qmnD8IXzimyaFap/dt7OatbuWJuPQxAgXjxfVmcl+TnM7w4NDIK6N8fK2kdTdoyB0ANe0BZx6tmSY+xOptWqm6SaLZDeCW9PfXpcbF6JS+XxcChwuwknU/ciysi131CG/f1aYpcK3fl3WHOZmHoglF18fzUM08AFeOnJNhjeL4jAoJ6YfbNtmnOP89UF0j/4EWv7n35GGl5h/KU/Y5WDnUuS+15ADqh+U8u7iceyJNg0aFJ6ZblwJN8CpmcsFbY6fxd9IT0GxdNnyp+YWqrmP3FWI+qeXv0W/OEVyWyqTMJTrW+ALoJlHPsRBOYhQUXVWrw9M3YkzsCTX/tqMCXb7aAu5GpkSgP6EU0hXOcMK1AYFaHscQz/uCRbRdyjHsoveKSGWm7MAwpuL5mf+/NUSai4muIW7kMzEHtQRP+uFyASqBdgYH925juCFRTVkjcqc+/qyird+zvBpQ5o7p1xtrkcfnjAD363T2Z77J2RyNBCyJLU3m6ZVCmCE73B1ZY7Hqlrrrktp5DmtpIWzAocGa/cEFrLx3Nya93NS/Nsug==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199018)(44832011)(8936002)(5660300002)(41300700001)(31696002)(86362001)(36756003)(38100700002)(82960400001)(2906002)(83380400001)(6506007)(31686004)(6512007)(478600001)(6666004)(186003)(6486002)(966005)(26005)(8676002)(66476007)(66556008)(66946007)(6916009)(2616005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TGpFeDM1Y2R3SU5CWGgzMW5CRFhDc1I0SU90d0ZXY1ZJVVdva0lYL3Y0OGht?=
 =?utf-8?B?WHN2VHNDQ2pOMjltMllxdm9vOEVvL1BZekRWT1FEM0RsV0FlaUsrL1N4ZDMy?=
 =?utf-8?B?ZjhkUzd6NldZS2QwaG1WaUVoQi8yOEY4Wk5KYXlkdnU0NTlLbTBFbURDRW1v?=
 =?utf-8?B?UlByNHJEZWFOZFFkRVFHTWtyN2o1V2RzRkEzMDB2UUR0dTZZTld6N0RJN0xh?=
 =?utf-8?B?ck9GSGhOL2RKbE5qa3VsZUUyZEpGOGJmSnRTdktqN2hVVDE1U1pqbTRuUE1m?=
 =?utf-8?B?eisrc1poZEVSZWR3RHdrbisxbGpxS052Y1ZYaGtpMURIMnlHSmovaWU1MHA0?=
 =?utf-8?B?TkwyVHN5NFpNb0NUd0R4NUlqRGNFTlY5dGZCVHhRNDkwQUF5bzBtanVXSzlB?=
 =?utf-8?B?TURBWWQ1QkZ5TThDeUd6SVF3bE5keEU1L04yWloxOVE3LzVNa20xSE52ZVhy?=
 =?utf-8?B?RjRVK0Q3S3YxckFxaVdUWXAzUTNNQXlFZ0daU0VmVEVVMVlxRVhUa0hPQ2ti?=
 =?utf-8?B?dUZncU96RFJZcGhCK0NpNWJLODJPc09EWFUyeXZ3NFJyMEJ4SXI5cWZxSmdY?=
 =?utf-8?B?WXBRT1I4UllLcmVjVUNMcnJSd0FSaEdnNktiMTNvL1hITHVDQVliY0RTQjVO?=
 =?utf-8?B?a0gvQXlDTkM5Tk9WWlZ5YWd1WnBYdCt6cjBTTGt4eWkrM2tPK1Y3VnErVnVo?=
 =?utf-8?B?N2w1Y0dlWEtJS1g2NmVhRS95NnRMcmVwdnlQM3RycnR6MHVzU09aSWR5a3Yr?=
 =?utf-8?B?YUhMOWJiY1gwdG54WFRpQ2Vqc3RSaGM0Ukh0RGhBSVFlV1B1dDBlUmVmTHJC?=
 =?utf-8?B?UDZzc0R0U2NETUUvUGtVUGpLSU9oL01jTlBSczM2Z1BQWmxFQnB5TFJlSk5E?=
 =?utf-8?B?MW15MXl3eDlJRi9BTzAxSzcyNTdSaTdVWkxjNFY0WThPL3A2SE1mdVp0WlVl?=
 =?utf-8?B?NXNnbE5aQ2Z3Wjk0cXQyUFJPRnZjZ3lCUUwrMDVFL09HTXI3MVYwVjFLSmRE?=
 =?utf-8?B?YWpEQzJ5V2tZOERhZldKQmduYUtaeUh1MUZtTXhBRFlZdFNqZFlERW9qOVJH?=
 =?utf-8?B?NmlSOFpNcEV5SHREd0FkTGd0UFJaWlA4cXJRUVdrU1hxdE5MeW9CRXRrcUxB?=
 =?utf-8?B?YnVCbzA5YXUzRFNWZkthVlNOVzNDRE1IVVgyUkJuOTY2ZkxaT1NvRGk0TlhG?=
 =?utf-8?B?c1B4eUFNQlBYUkkyTFd5Z24rcDR6dDl4VXpSQ1d2Q1FtbGFMT1pBMGhoSlps?=
 =?utf-8?B?MTY4MHM3dDlEaWN5cHZtZFFLUUdpQzJ2aVpjUjRlMHFOdUxwRU9NMVV6eE9J?=
 =?utf-8?B?d0NnYW1Wc1RPcE5Ka29jaFU3bDFWUUdpa24xZmZPSmJuMTVJTm5xWkovMmQr?=
 =?utf-8?B?Nko1WVN3dUJ2NU5md1JnNldtSll3K1ZVMFY3dG4rTFRkMkM2RXFBRzN5NXFp?=
 =?utf-8?B?b2Q3THIwNUM5S05WNEM1TUdSeGJVR1lPeklJR3ZQajR5b1I5SFA1UE1TZUhq?=
 =?utf-8?B?eFhUcmZsRExtOHZhK1VML1VWTHVvNzBJUldYNzhWRkd5YVlaZFM2amcxL3BL?=
 =?utf-8?B?aDIralhUOU55K3VsQWlSU1IyK0duQmdtamVFZnFXSHNlMEwreDQ4bWdHVU1D?=
 =?utf-8?B?MDVLSnVhY2diL1BjK2duaHcvaGowbC9yclRaRldNc3pQNW9PbkVINmlySzYy?=
 =?utf-8?B?d3UyVHlSL3J0WFFrdWEvM0JjaWIwSW5aY1pMWXFmY3lGN1JVZmc4bWxJYk1T?=
 =?utf-8?B?b0NyWFdhbW51YWw4LzhzKy9GU3UxY1p0bVVISnBxWUg5aHEyeit4eDNWdXhw?=
 =?utf-8?B?WWYvN3FDcVdUTXQzbkwzSUg3R25reW92Y2FkNzNORVlXSDRPdW5ES0QreXow?=
 =?utf-8?B?TjQvVSt5V0Q5eGVVWVcyNng0R1kvNTlRZUp1SUZmYVd5eDUyKy9ObE5DWXJj?=
 =?utf-8?B?Tkd0Smg0WlRuWXZDM1k4US9oZjUvRyt3OS93dVJQMGRoZEVXVy9OcENDMnI3?=
 =?utf-8?B?c055VEVtRUMxbThmQU5HMGY5WmhhN0pQZkRMQ1VtelF0N2VrS0c2djAxa0pD?=
 =?utf-8?B?YnI1TFJTZGJxdjFkaEdrTnNkenQrUndHZS9zMi9BOGYxWGUrY1VZNnRDRWFi?=
 =?utf-8?B?R2RNdXhraVdvOXRzYXZWeWxOVmRMb0h0eW4waW9vZWJRWHFMOG5hdW5ZWCtP?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a81e1c-767b-472e-7c53-08db29d5db3f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 06:31:08.7294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKoYdOKWkYEsi47jAIn7lXXH6TsDscEzDyNLLB80LEUsQz6l2laHg0lUi7ygdjpv3FeMaRH0bpEcSj7EAv/Nkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8255
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Mar 2023 06:31:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11040

Hi all,

this is the first release candidate for the first formal release of the 
isar-cip-core, the Isar layer which allows to build CIP Debian images 
according to the generic profile.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/archive/v1.0-rc1/isar-cip-core-v1.0-rc1.tar.bz2
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.0-rc1?ref_type=tags

Please test and make sure we identify and resolve any remaining bugs
before the release! If all goes well, I plan to release by then end of 
CW 14.

There is one small feature still in my backlog that might get pulled in
before 1.0: Provided [1] is merged in time, we could also enable disk
encryption for qemu-arm and qemu-arm64. The patches to the layer will be
minimal, only affecting this new feature.

At this point already many thanks to all the contributors to
isar-cip-core over the past 4 years!

Jan

[1] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_requests/76

-- 
Siemens AG, Technology
Competence Center Embedded Linux

