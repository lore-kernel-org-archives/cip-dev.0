Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA4FC83F12
	for <webhook@archiver.kernel.org>; Tue, 29 Aug 2023 07:00:18 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.66])
 by mx.groups.io with SMTP id smtpd.web10.12009.1693292416015410888
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Aug 2023 00:00:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=j8MWpyJF;
 spf=pass (domain: siemens.com, ip: 40.107.20.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRMu1MBZcj+ClXykULRuXzX6gVDUvUcct/s9A1KnOcGtOvJHhQmfoZc9pnpx0vie2nIgFXkoUGSuVULMpfXHiFZvQ9sUacHfEFHv+AFpa3hIVSZlZp8/0cSrQ17pzfK710/vOuiFcvWOyQzVM1tMTmXUC7nzvSroXJUAcGTGGLgWWbUiO2mPpG4jNi0EDJYAy2Yh5QqM4M4o3ot7HUzLV3VX9Zlep7tK4036DAyvwIQFE4donI/048SI2epIEPiZSo0CFHHjUgngIfB7XjV0Q5+K2oVret0uow0DUzWAakjDZ3rmaH0CtAAoWRyH32QVvh6UsBVUUCsaK4+1MGRt7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezzKsQyoSSX2fCrwqlJZhlGHfkm3Mq4A7ZZ3uxtDrpo=;
 b=Yvl+74I+zynvpPaFAdXr22DXRl5Z+8t/sxXAAaV3tXRVNR+m+Qzy0t1/RCqWnoF+plDSX3fQd7OFPlUry9g0W7yPhqxs12nywAjg6Jz3jjgpm/kBFEcAA54v0TkyiHFiL0UBrSD9VjXv/S91OEAOqBXq8/iBNd3lJHLgVAHrEbM74Z501hqNHXAqiMWM6js40z7NRgMO6acwtxeKvM85/72pJp9FVhAJX+rtZkGr9fIapBmps0hEkvySUmut3yEFRzLJN1SsB4oarLxHNpbaugg8oQiGUS3X549xMKaR41u+NEM9HlrN3H6YDkIteTQMpoXrLh9vZXrK43N5zmgLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezzKsQyoSSX2fCrwqlJZhlGHfkm3Mq4A7ZZ3uxtDrpo=;
 b=j8MWpyJFwyoeRleCV1R/nQ0NH6qTF1H+jWpxR14weUSBcawiaVCGG/jdoVRegODK+7xNfHZpXACWpJQE6K1JND0nDkS8UgXpQmPwIlg/0Rxt6UmZ3AxpOxCo/zQLhWG8zSj4Vh4lcIbjmFQa7FORGkJEBA8UmfPoa9A3Nlbz6YlCwgs1ScsJMShT7wNqWMKfgZsllkl8xuJqIeEBnV3RvId0RJ/8VbnzzhQBrOjQCp5Qq1fWo9nZfh4qR05jxqEO2Rq4d6+TQwvRUhSWdPhu8Ollc0Uhqycbl3uUEB9GvDxPKOUaSov+iUJNHen5k1pOxV3hxKFztVBM6f7OPegsIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7427.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 07:00:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 07:00:13 +0000
Message-ID: <250396e4-9456-42b8-9071-33fbb3a71752@siemens.com>
Date: Tue, 29 Aug 2023 09:00:11 +0200
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IFRy4bqjIGzhu51pOiBbUEFUQ0ggMC8zXSBFbmFibGUgc2VjdXJl?=
 =?UTF-8?Q?d_boot_for_BBB?=
Content-Language: en-US
To: tho1.nguyendat@toshiba.co.jp, cip-dev@lists.cip-project.org
Cc: kazuhiro3.hayashi@toshiba.co.jp
References: <20230828104315.466393-1-tho1.nguyendat@toshiba.co.jp>
 <bfcdf1ab-f22f-432e-b232-36733465dced@siemens.com>
 <OS3PR01MB5880C40F370BAB87E9F087F995E7A@OS3PR01MB5880.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OS3PR01MB5880C40F370BAB87E9F087F995E7A@OS3PR01MB5880.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 931e2722-f476-4798-3a74-08dba85d9784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dR16Xu3nMfuKQsfzNmKTxdKURQj+n7q7IjKC7kMF5xQPr9S5nTPI9JYwmybRsdmWuL1rXUub/aYcfrFAVL5xaCKE2y+NxUWpsX+bPGazDo9afmJzJ/mNZj872N6icKbBl8VeqhpxwTUdX7wabyJ/BAZSZx9LnJsYLL5NiWZA+PDULJJ9YqzJpNN7gC7x4l70HLpeTaHLBC4YnZHpNouMpHYb0yy27+uHyuU29nNFRkHizX60FB3lbD0VAvVyt5EKr+TNZKfzL1EmOgKz6IR2ZKO6JT1luGrkL5Kf27Ms/SuwQJKaqh/eyQFJu5TnuqdIJDtkdPkw0RXiRk1lnJezBL08zRR79BMiZjoA8kslQDGoMtGMRd4vQ4sHEMaAHEdcVM6NVYKZk/BaxKmZBXjMJ/jbjjlYBdF1zEYYThpOOExq9YuIc4b2XWTbB7HflL2cT/rwfN9KlTd5fMtd+P3GmckeAyHS0uQml6+6xfLAL5BNJKJo3lcyHuNoFKGnQB1gbZ2uWXz8EtwmFg2JIyG18MdyOOcogQ+a6BtCvGWujL94blF7rC9i10/CqJEZvFxMhwhv0P64akgy3Iy9ysfoUqc+3d+5Y7YRiqdXkha7MFoUKpH7A/Ojil9WSShtZi3T8wvCPzDLZfpoQqCSTeekxQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(186009)(1800799009)(451199024)(6512007)(6486002)(6506007)(53546011)(966005)(2616005)(478600001)(26005)(2906002)(316002)(41300700001)(66476007)(66946007)(66556008)(8936002)(44832011)(5660300002)(4326008)(224303003)(36756003)(16799955002)(82960400001)(38100700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cHdDampTYWtMZGwySmZKRE16bk1iWi9zRVlPVGdMTHprbDNkVTRkUVp3RGxC?=
 =?utf-8?B?ZERyeXZ2SnBZSmFGR1EvM0lPQ2FzVGhaa2oyREhhb1NlbmtLbjUwNGxXRWho?=
 =?utf-8?B?Skk0dUs1MDF4d09Nc3NrNkhNTWltSk16bWJINVUzbUp2dnBZSTNRNTZ3cDU1?=
 =?utf-8?B?eUloM25KK3E2b1VqbmdWQyttK2s1SHFaZE5jMHpIRXgva1cxZC8vb0J3Z3cz?=
 =?utf-8?B?SWliRGdkWGpzMnZzNFJpVGEzRUQ4bmtuZE5qT0svYkprYlRubHN2eUIwdTAx?=
 =?utf-8?B?RzVrbEpIWncxSWR6NWJvVWszZTFpalJ1U1QrUFVsZTJ1K0dUanMyV3JJMkVo?=
 =?utf-8?B?RnZPc1dEby9DL3Fqc3VDWk85dVlXamtSbDByQVp4MHR6M1F1TjJpVFNZQTlG?=
 =?utf-8?B?dWRQK2liSXFqdW11OXZzdXFIRkVlVXNLak9XdzJkNUVWZUlJQStHbmcvazhY?=
 =?utf-8?B?YUlSQk45WnlvSFo3eEQ5eUZaTWVKampiY0xRYjN1aU1jU1VlRG9vMW5vZzgv?=
 =?utf-8?B?NHRRQnpUcUs5U25rQ0RyN05Mc3N4c25lbW8rTGJIOEdkR3pvSW9OZTRiOE9I?=
 =?utf-8?B?V00vT2Nmdmo3TStpY2x3WEIvNmV3UWFBRm5lVTVmQ3RiallXcmEvNDBVa08y?=
 =?utf-8?B?clZGbzhYMTRLLzRzMFRzdzZuZHpmV0hjSUdrSGV4TTZBa0F1TVdFOHhEejhE?=
 =?utf-8?B?S0swYlVDOFFkT1RnWUZZajRpNEpCbEtNNXp4UUhVQ0hlOFdHUGNYN2xaMXg4?=
 =?utf-8?B?L3dDY1VqTDBWYXp1Vit6cThqM2hmS09JLzJsc0d3V2RsUmJpU1dOcU4vL01l?=
 =?utf-8?B?RE9mYi82VThsbHhQb2tyWXNsMXJWdE5pZzQxeGpoays5QUhxVXMyME5TOGJp?=
 =?utf-8?B?NDltT3c2RmpRbHZobWlRZkxpRk1wclBXUDdJdTROak5tTGRsc2ptYW9BVG5K?=
 =?utf-8?B?Z2toTXVRR0J2amNHZm1FMlRPVEpqSEkzZm90NzFoLzlDVjBlRndlWjZ6cGsz?=
 =?utf-8?B?bkp6aGxTOFVBcEo2RTVWQTF0TTF4c0JSbHdvZEM0NDlNbnQ1V2VRTGtuYWxK?=
 =?utf-8?B?Z2JSNDA4QmdLSy9JeWh1SUFkbEIzQzYxZ0ZQdGZhZG03aXhhUVR6T3BYUWdU?=
 =?utf-8?B?NFBVb1dWeGVNaTFrRzQ5NUkvdVlCR1h3ZXY1cmhqUnNjOVlURm8vdFkwUWx6?=
 =?utf-8?B?WWhUaHhvZVo2OElGM1FRNDIvWDh5b0U4UWtZZVhCVXV0U1hKQWttWkphMXlE?=
 =?utf-8?B?Q0dib3RSTXU2VGJZenRIdUdXeEliSitIQTN2WU1DQkRmY08zYmE2UFJSUEo1?=
 =?utf-8?B?U25DdXhqWktZWTJZWXRwaExuQUVwanpqdEkzcWdOd1hhVUpNYWM2dkI0NDd6?=
 =?utf-8?B?SEd6cG5VTzFwbUtpUWZmamZVRElIOHYwZndESVRwSnZxeFVuK1hIc2NqNmxE?=
 =?utf-8?B?N2pwT3p1Q0o0NldNbnkyUGdLYnJ1eVNFNFRPcktIZUpqTDdSRzJ1UjMyT2Rt?=
 =?utf-8?B?UW5KNlM3TnJrK2d2OWRuazJoQ3liMDh2cTlIQitPZWJPTWtqSW5VNG5QY2l0?=
 =?utf-8?B?N0lQU3ZGQmtSdTEwL2FUUlRhaE9YU2YzTUYxNCsvNXM0WXprQWxoNVhMcGdY?=
 =?utf-8?B?VGRXdzcySFJVZmw1VktzQUZRenZyVUp4UnQ5UGJUc1BPdVVWTjVjdTRlTUNu?=
 =?utf-8?B?RGJidXZCODZCMldXUENnSFVIaDB1SGhwdDMxT3d1MUZaWE1CVkNlaEVpaFBx?=
 =?utf-8?B?cllpYVV4Wno4MDR0eEg4NTVsb0x0bGg3RjNZb0lrWVI1NFZnWldPV0JLaWx0?=
 =?utf-8?B?eFh3Vzl4eGowZVlVaE9GckdjOU9jbWt4bjZab0t6VStLbk9zNWxvQzNpdGFN?=
 =?utf-8?B?R2FzNDZuOVVYdFFJVklXdDRLZlVwTjZXbFNIWHdidWw4T0pxL2I1cWVQakFm?=
 =?utf-8?B?bWJsQVRGa216R1IwTUo0Z3BGYlBMN1JjNzdGUFRaQU5KeEI1dUVoR1BhTGh4?=
 =?utf-8?B?Sy9SWXFxR0pXOFBqcU1EL3ZXUUx5Z3VNMGpoanYvT2NsOXc1WGsxOFVGeUlw?=
 =?utf-8?B?MzFqVFIwTFBCOG1vYlRBOXIwdnA4a0xXQXZab29SVUpGSmV0bTRxZVFtcS9U?=
 =?utf-8?B?UG1ka24vSzFuMUJNbXJ5bmNIaWlJNGRvNEFSKzlTb0tCSTZEZlFxM2VBRFo2?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931e2722-f476-4798-3a74-08dba85d9784
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 07:00:13.1787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNTIicnVZ2GI0/+N05+K3Q+E1MnjPqKySXetPzcmrovnXQRp5b3ync4JfagIGVJhBLpqUso5tv/4WVvaR/NIKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7427
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Aug 2023 07:00:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12892

On 29.08.23 04:32, tho1.nguyendat@toshiba.co.jp wrote:
> Hi,
> 
> 
>     Thanks, patch 1 and 3 are already in next (I assume you didn't change
>     them in this round, did you?).
> 
> Yes, I didn't change patch 1 and 3.
> 
>     Patch 2 now makes we wonder about more fundamental things: I'm sure we
>     can boot securely via UEFI onward - provided we can store the image keys
>     somewhere. How did you address that? Did you test that you cannot boot a
>     manipulated rootfs? I'm not seeing anything that enables secure storage.
>     What we would need is some secure storage so that we can write the UEFI
>     keys into it.
> 
> I have tried to use TPM2 on BBB before, but I got some problems when
> enable TPM device on BBB:
> 
>   * No TPM device for BBB, so I tried to use TPM9670
>     (https://wiki.52pi.com/index.php/EP-0149
>     <https://wiki.52pi.com/index.php/EP-0149>) but It's for Pi, not sure
>     it can work with BBB.
>   * No device tree configuration for TPM on BBB. I tried to use some
>     examples but still not work

An alternative might be an fTPM, like we use in [1]. I'm also playing
with that on the BeaglePlay, not done yet though. What we need for that
is secure storage, possibly via RPMB of the eMMC. Not sure if the BBB
had that already.

Jan

[1] https://github.com/siemens/meta-iot2050/

-- 
Siemens AG, Technology
Linux Expert Center


