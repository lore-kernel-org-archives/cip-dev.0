Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFB2C47077
	for <webhook@archiver.kernel.org>; Tue, 16 Jan 2024 06:03:02 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.72])
 by mx.groups.io with SMTP id smtpd.web11.6138.1705384971999377549
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jan 2024 22:02:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aJt57VCt;
 spf=pass (domain: siemens.com, ip: 40.107.7.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diRfJOb5hPIQ6hkGWHBKjkyPZA8F6/1vQ6Pn0lwScQdgDKH+2GxAYORjklhOm02RZWGY9DTjZ8daER0zOif7Fmp1fw8ejqk+A0g8IxigE33z5rAMAjr2XFku4sj5/2EjzUpOCmNK+ZNT15XHHOD7wEsR0Y0h96IZif0w0t9Cx3eyIVZEGdMisTWGlvihGsBn0OtD+4Vlw38s6u9KI3V8lFE0fEIFnJc7BjgHplS9m0sFgn4/KhXV/pBELzMgwdn+XSCW5gjHLo0C/VZhuyR2LDcb8JtCJdfflh9qS6mYGJJ0xLYfhJrwUdR9VnN0B9S3SOTgkJQoed2BiyVfL2l1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uo+o9Y0Wdpb+Hu2Cp+SNrgw2wCjpDdxBE6wGHDkm8A=;
 b=IOhjM0jEJYcPk+sSZtW3v2zfhLXIeuRboMq8+aNkBFGpbxU+xkSeIbwZfoYXZi5fsB16TaffJynvcmRdMOx2BnTg3/N2N9dkSHcv3oHSb7UpXH/zT1W6KZ0VNcZ7XrNEAWy08oEqctdHwQ8eA4frmjGC3Rt+Oxal9CRX3F0WxFBv3SPGJUPu9DY7l7S/uilSGbPvrNEGQP4l5p1IJLgkOrIGiRCtpcLRcfO+xKTCLsEZ5Ib1mZ0kp8VOyHCW5C5+d1VMKIeVfF05K3bIEKW7NGp0tb+8ZrgHd0oprBzVWOhR8swV7OSROibUS4BiiOPTIgDKt9bDjqBgT0YDWAN3Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uo+o9Y0Wdpb+Hu2Cp+SNrgw2wCjpDdxBE6wGHDkm8A=;
 b=aJt57VCtrBBVcJy/7Sp7uglJ09QdGt9aN9OCbNEvekL5yH1C5XUsWKh9m8L9SniAKOi5lWpUdkNpfXY9TsnKVI6nxAQTq5CkWKJg/QyyuPiDW0CW0xCkPoa676uPY1VWEG9PWU855wgJ7lAoZfzPNGxDeBnHjcXjwed25WhnWhP7WL1sywJCqd11Q+Wcb+sgHSPezRBbkml1ztohDc5+tZW/FcA3LhlURln18VhIQ3xGqNAqIanVeDBi8eVtJUnRup/m+ZuWo/k2s5TlvsQ+1o85hc1uK419sAV0as+zvPqV+JTW6uCJ94zNo2hrZbMb34z2f1F37ODUX8/yk0cJgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7745.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:365::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Tue, 16 Jan
 2024 06:02:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 06:02:48 +0000
Message-ID: <d738649f-8e90-4275-8015-180798150f0b@siemens.com>
Date: Tue, 16 Jan 2024 07:02:46 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core] Closing for v1.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: b5218acd-7e16-4ab9-ad79-08dc1658c43b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/b/7zza78Ytq0kwe7rtw9uzHIWnHAgCfvLwcGtT5miGLxgJ876s0FAkMwDzXgxgoagOmKCJVJaGjy3+gJDuucMX1Gp+sD3aAVDvDHT4PuB+m1bEFyG+klszvPhoTBSGsZeBA46cfpZTpMLYNl+wGiWc+9ia5dqXiwaFuOy5n2Pe1aaaiym8hA20sV7OOL+l28mD65lwu3lBtuUFZY5kdvWVwHsp2iYgdCuIyoENJOQ8lHEeEiRRMFbQ3O2t8OFd/TRtOgBk0vBGoT+CgUVIFCKiOIyHH6gP8WZFA0ScdjAjVQSVijzrC3YwNvVHBL0303oWYgIBdiKU6VAoJJWQzkdOj2/DtCf/ly8+zWZh4XCHxMdHl8CPfJ3KYKSG+dUvVd5t4Asp2pnoEBduRYyu/Iyyc4GOyAnjFMAa50OAMxLkvzJuCQrGkh1kHvX3eq3JYVBKZvZMgMN7m67Fh7Ty9x+Y9KU9JeGRmCpvyKDT1qonS4oHbonSft73OBgxYahedV+/3NYXysTi3c345hGBJGmiY1F6l3t03V/IUx5IFq7Ru1gLXwLuQGylSVrQOZJvPt1ew5TDmtanKO827/8qfJwPP+oDgWkAnZ/5oYONnt4nlydjgP7bcO5+ThmS5a+BNvGgC9wK00gYD2OEL7H1sow==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(366004)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(316002)(5660300002)(6512007)(2906002)(66946007)(66556008)(66476007)(6916009)(6506007)(38100700002)(83380400001)(2616005)(36756003)(31696002)(6486002)(26005)(8936002)(8676002)(31686004)(558084003)(44832011)(478600001)(41300700001)(82960400001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZFYrUXcwdkRLcFFhTGdaVjdsWGx2cVIrOEFZVXFnb1RveVJpNW9FV0ZUL2M2?=
 =?utf-8?B?alVqZkNNS0lCTXNIQ1k2VHNMa2ZPZUl1VWRtamR1TWNVYzFMT2dDY1BpeFRD?=
 =?utf-8?B?S1pDbDRCcEFrc1NyeVE4R3ZXcG5LT2xkMVB2QmxkR2lqa1JGejlBV0Joa1ZU?=
 =?utf-8?B?OFVRb29QdEorRXRjWmoyVUwyV1poaFU0Vm1kYmN1REhlWm5lck1hcmhGYVdH?=
 =?utf-8?B?NXpMWjFyWlBobE1CZDBrTTJMSGxiSUlORXpqdXhuUDhUWnVhaEorZHl2TXZC?=
 =?utf-8?B?bmVMNmNyNGJnRkRpUnVmcEZUbFpaWWVmSWMyNW5yM2pTdzNRdTgrZXZjaklt?=
 =?utf-8?B?YjFEOHpnTDFZODBYd1VTalFaVFU2Umg0c2hMSjBvd0F3Y1lHWUFLM2NSZndR?=
 =?utf-8?B?YjV5WE5zRUtwZlZuNjZITXJFeW1YUzN0RkJaQ0t5MUczU2J5N0RvYUZZNTRX?=
 =?utf-8?B?aEkrclZCa0ZaaGh0U3E4ZlNhSFFOYitwZFphbVVWYmEwQTJKTWpXcDE5Z2Nw?=
 =?utf-8?B?M0d1UmY3OWk3dEd0cWExN0RsQVdLQ1BuMm9BV3BVc1BaNFdXS0F3ZUFqSFFB?=
 =?utf-8?B?M1dPRDdNS2lsYkZ3cmFzaENXUldWaEZKdk44VVN4MVpQR015U0JhZFZkMk5q?=
 =?utf-8?B?MTM3WnQ1bmRmT2E1SUtML0laZ2xoRnhJeDRNQ1J0anY2NWlTdXl1Tkt1Z3c4?=
 =?utf-8?B?Z1B6WFN0N1VKdEpLenBrSyszaHc2NXcrb3lKM2Jsd3ZOMUI2L1NOMno2eDVX?=
 =?utf-8?B?TnV0UWs2MUU1WnpQTk5oZW5BVmg1bVdjdEcrWnN6N0xuRkpJTFJadWNMSzlq?=
 =?utf-8?B?OHVtY1lITWthMS8zU1hmY0tQcFZuakpVQXRlUFhlcDRacjBlQ244eC9Pemlv?=
 =?utf-8?B?ejNURVFYZ1lkOUFxS2F4elRudHNQSTdtWjVsQk5GRFpnRXpJdkU2alp1UTE4?=
 =?utf-8?B?UGlLNGFpb2tSVU9NUEd0c0Uzd0J1dmxabVVaVGkwNmdabnFjRlFYS2F2dHRz?=
 =?utf-8?B?S3BkRzNmZ3pZRmpsTmgzY3d5cG04Sk85SGd2U2pGTGdUZllHTW1UTlZIL3FI?=
 =?utf-8?B?cjk2Mm43cHJ2aDNiRFJNZm44UURYa1NGNlgrZFZsZDNidEwvSk1CQVlySWVC?=
 =?utf-8?B?NmFreTlvWnNVeTdSYkZ1WUNNbmJyeW8xTG82eGlBU2prVmQvcmNNdUo4QURF?=
 =?utf-8?B?ZEdBbVFMSVd0aHVHMnEzbXZGZk83dzlXYzNrQStmd2RoMUF2VG1HMi9nNzhr?=
 =?utf-8?B?cUhNZWdBeENyNDFNWjRoWkRVTmJHa0JBdkFPayttQUNQY2VyaVMwZStHWklm?=
 =?utf-8?B?cUJQdm9aRjJmbDh5bFEvd09hdHBnMnIwRUxOdnJXNkIzQ3gzYUl0aTVsdVZT?=
 =?utf-8?B?YVhMZjh6b29YMW1UeG9lREk5K0RRL1FLRmFUdmxRR1M1WGVQenlORGxsbDJ2?=
 =?utf-8?B?MEJ2ZXpjWDZxTExHZmtleWRQRlQxVWJYWDVHenZxL0p0L2hYdXdORXhFSXkz?=
 =?utf-8?B?TkkxT3F3LzhHM01kdjFpYnZCdjhVVEc1ZVViY1ArYnJNOTRlSzBmZGlUbk1T?=
 =?utf-8?B?cGxzakRkUVh1STMvN3kyVHA2TEVaWlh2UGlUY1NDRVVHTmF6aTk0aXAxTzlS?=
 =?utf-8?B?N05mYUtXblFEVG5rUGRqWWszaExMUm96bENSKzVQOTdOZnY1cGMzSExKblVE?=
 =?utf-8?B?eEloRi9ORWpmOHVobTVCWk5acjIyKy9XbXZTMVBBdUxkK3VPUFpETmxrM0RG?=
 =?utf-8?B?cm5XR0NOWjE3UFZVYTM2RFhMUjFOdXZwcHZGaGh4UTgrSThHR2JmUk5PRXdC?=
 =?utf-8?B?MHp2WWZKYnRwbUVTLzNjbzJkY2JZR2ZqU0ZEbVZNK1pvbzA2UnFQakJEVUc5?=
 =?utf-8?B?N091SWRCT0UvM1RoRHVCMkdiZ2Jlc25nYUFCdkp0SW9scGE0VGNnb3c3SmdY?=
 =?utf-8?B?V0hwZXdIa3pTQ1pkNWs2N0hQZWZzNG9ZSjM3NFhScGxmOEtnQ1k2QVRwTFox?=
 =?utf-8?B?N1U0WHFqQ1JxRWd1SDdpMWJ1R1FhWE5ReXpnQ3FlZnVybUZmWWpzY0hTOUgw?=
 =?utf-8?B?ZG1TSEtXNWlXMlByRDM2Y3dLVFh3L0t3OGE4L3lueUorZDZaMEg3MnJpZTBR?=
 =?utf-8?B?UENxbHZxT2ZJa0FFU2FydW1ubUh4TERseFZMN1VFazVwT2dtYlMrWVNod1RN?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5218acd-7e16-4ab9-ad79-08dc1658c43b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 06:02:48.7309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WirENBZ1LFnR/GFG5muKALf84YxHPtT5Hkvwjj5gxtTYZKMUc7KX6EsNRwRhywv9O28SAw5OSmAGlgCxzjdUeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7745
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jan 2024 06:03:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14394

Hi all,

I'm planning to tag v1.3-rc1 by the end of this week. If you have any
pending patches, please share them now.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

