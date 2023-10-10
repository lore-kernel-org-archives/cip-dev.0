Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10463CD80D1
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 13:25:39 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.79])
 by mx.groups.io with SMTP id smtpd.web10.91345.1696944336043022874
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Oct 2023 06:25:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fTIEhL5U;
 spf=pass (domain: siemens.com, ip: 40.107.7.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmb/SGTYNvl8CgLilXSzmzo8aYcZ2KDpZYmJx1hOk7CNuwSjyz9CN2Epr/sNNGrHGLTl8f0FNO9sHqcqOH07ikScFte7EHHF/TSt61zFyu0lBBETdS7sx9yn+XtzJZb5lQIkn22goM1Ozb6YdOgmBxwyB76MtivPB3Qx8cfhWTHcVmp0Zj+LutG24eHFbI/7bhJV4CxW4zfKZBg7uJ2456bruhRTopJv9ZcHdjf6eshwFcYaPk/6oCQl+kZOF6D5fluPCyHOWMcT7/gjOy3sRmnuaBt6ypUsk5i6rI9j0oPVNH1uHIAfi4NE4QppkqfohEccOTUn2sVFQaaBNeIb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJeEmmdOXfjd82N8F4FdtjNG+c0+7nZreOX/s2VAEgE=;
 b=FjxvCvZndJG+66rPjXfTBrL9GyHfZmqTyWgGz11iQd7YuNc6Qkb0zVRAZgp9HUMHRVBM7vgOncexRrdoBoW9F1YL4D20VnFUryZj+4sf3L0tEzkXJ4ecrOzM92wcm89uDnCrDnPn5yrGYXTUccxwoKFswovG4Fs8R7Qd8dBK2g4rvOUhgB/SYMYXnh6dmNwAoXm8wyqFvavksg20xy02clplCrnaCqSXuwpNKxrZR55DpeWR1ljSVdSWQ7TZo5MWkvI3u0xCjXpXGqNKIiqX865Z57Fy1CXj+L+64F2NDWURFpIclbBDIeyypFKfwfSWRfyIoabb+SdY8jrhzExXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJeEmmdOXfjd82N8F4FdtjNG+c0+7nZreOX/s2VAEgE=;
 b=fTIEhL5UUCReZAJVMVPz6REaq+E1ftttn9JK0up+QhUYAieXl3Evhu4ZHMfZqeUoBjNPOUldqum2hNKEOMx51AgbEqJlDUAoHSHrCDLEB09y2+PQKMiovj/KNJ+i1KdkFzRfT3mdSrri9mFL0Eu5fDLWv2ohu0aXqjL1rmwi01zj3f+HTgCSkmmsKQqeG/gHDMekf42fu1VsZMZWZaAopGxUK5EXhTdpJ0D5xwSg2Y+PYfkm96LFhwEs4oE6Hu+LUF8GZ0l5aqIahcLCEAUKGvVBV8Ytz6BSJ06Veh3GR9OV0ZDDoe6n7zmym4BI7hKlP3hG8bUBVSWUjpP0nKfJPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3902.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 13:25:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 13:25:31 +0000
Message-ID: <e922619e-545f-40aa-bfdd-9c716d6d1413@siemens.com>
Date: Tue, 10 Oct 2023 15:25:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] Add support Plat'Home OpenBlocks IoT
 VX2
Content-Language: en-US
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, minmin@plathome.co.jp
References: <20231010081034.3762306-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <3781349a-2426-4fc4-9e9e-1d543112375f@siemens.com>
 <TYVPR01MB112457EF240E3EE05EF931A5592CDA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <TYVPR01MB112457EF240E3EE05EF931A5592CDA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0399.namprd03.prod.outlook.com
 (2603:10b6:610:11b::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3902:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb35863-e9a0-40a6-03c6-08dbc9946071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IlT7pulW7rf/XUHWs1dp2tI/7aitzL5pPG2eWzTvarEegudF3It/5EzQAiSu4TILTAba0Unt0cQ3RNScpK8rmpt/fBjHN2ys8moERQiV/fgky3H5zJqCb9+lCeJNXXsLSPSkomerMDhaC9z0c/hrlb+02Un3Bv7t08MZ8lKYYnETWYa5Ypw6M01kZjRjlcCpUbdkfSVwyjGah89p8lMyYE9KioVGA0H755cxuUUHc5LezCJvO3kc0h4dLrX5ZokATi0vguGL81tgo5wjbu6rwO0dy2Rwt5NuaTOU7ljPaeuztX/pRlfnmeq6jRHOkEEf+TkSoi9EZTWuDO/wOJ0nmKzgUE1VEqc9/fAy2csyLGECCPCW2rmPjkRhYdZ3uk1piqLiR0DwRCcRLGsyL2BdcRlaKHtoBzp6nCmUgt7VJ0EWuP2idCMUfL/m98nvhc4bQp/fdkoW1g2sflA3+ZPlo4XwISFHznNSakMGdgsV9BnzoKrDdmN/Hbzt2j3DxCvaHN5JEcJCQTuHmVTpILfQKmzLmO2AIoZkcrRBSFtPok5q1sMzZh7mdsMjvlT/6qqXIKArm+oMooK8iKJp4/k3g9a76F3rEkd/IqZgeug8N6tLRgC2+FAtYMuCllemE3IX349B0jkKVLGHHiF/ilRjKTTQ7x0WiA4XBn8piKpZqzmRNODCbOfwqo7dX62zfmdL
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(53546011)(6506007)(478600001)(2616005)(6666004)(6486002)(26005)(83380400001)(4744005)(2906002)(5660300002)(66556008)(66946007)(66476007)(44832011)(4326008)(8676002)(8936002)(6916009)(316002)(41300700001)(82960400001)(36756003)(38100700002)(31696002)(86362001)(31686004)(151773002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WHA3ZkN4cVZuQ3pQbS9xRlYrT1pNMVdvc29iT1I4NmRYR2RBbUFVK0E0QWpr?=
 =?utf-8?B?S0dkNmZ5V0V6dDByWlphZitodGtTQzdWcGJ0VWN2SGR6ZE5Wd3N3NytXNmhQ?=
 =?utf-8?B?MjBFUXZISW5YaUFoZjJhbENoZkd3cm93b0pRWkY5aitqU3JwT05KVG1rai9i?=
 =?utf-8?B?UkhtazRLUGFGdGY1a0xGVDkyaDNpMUtRME5haDJ6YU1HRlNsMld1ODJFMEdh?=
 =?utf-8?B?akd0dTM0T04rUnFvMWNEN1RHcEhlcFFZbjhwZ1RFRlRrUW5TdlRIQTNlSFpQ?=
 =?utf-8?B?M0tLM2R4SzRMaVpwbDhrT3F2SG8vN3BlY3BqY2Z3MmwzLyttVitZeFdYU01j?=
 =?utf-8?B?dUNSWDFkTE15dXpaYVFKMFMzcCtlOGd2WVF3Y0FFMEpMdnlFMkZuaC9YUE1k?=
 =?utf-8?B?ZVFtM012QXAxNXYrT3JYYmV1T2ZGcklmb1ZOWlNFTE4ybWxlTUlOYzc0cWtO?=
 =?utf-8?B?elFldkRaZC9Pcm9tcWdkR01aVlVoU0Y0RGFEMUx0Mm80OGRlY0lWangvMjl3?=
 =?utf-8?B?ZjY3UlVubTdUME9nM3IyVmdvcklKb3l0NVFtc3RJUjl5VFE4TmpQTFNqMm9Q?=
 =?utf-8?B?YVY2ZlQrOUY0ZUpYQk1vQ1ZqZU1abjZPY0kycmxXaVYzQTRYK2owQ2pSTzRx?=
 =?utf-8?B?KzVlY2g3UFFhWUxYS05Rc2NqQmU0d3RYeEZiRFdmS2Y3bUpMWmx3UERoYnpq?=
 =?utf-8?B?U3BJWjJWVUVIWVdqVFRxVFdnUEVSRlZ5cE9sOExuSjZJU21EL3pGOVd3NDhU?=
 =?utf-8?B?c3RzZVNteWEwbWVHdmJFbkZ2MjVpREVydHpYdjFubjdscEl1djkxTTVxVXY2?=
 =?utf-8?B?czg5Sm54NUNIbENYbUJnZkNQeFMwVUtqMit6MUVFbE9Xa2oxUmhUbUNUK3k2?=
 =?utf-8?B?UUsyR04xV28zQnVkMHA2MHdBbS84V3hXZEU1Y0VFOURhOHUwSDQzQXJWeHBY?=
 =?utf-8?B?ZDk3SVNKY3BlNjJSSGQ4RWkxcHdJUzFDbFlTQkU3NTM5Y1RzQ29TcnUxZTZF?=
 =?utf-8?B?TWZiK0loZDh4NzlzZSt0N3ZMSDQwL0JpNlRUU0U5TFJkV01BUUNkd3VRQ0t1?=
 =?utf-8?B?ai8vT3JGQ2FTbWdERUZnOHpJcWZUWjVsNGx3cEdaOTk1YlVtSkh0cytSclhq?=
 =?utf-8?B?STdsVzVlb015WHdQWHljNHlRS0JDcnVvTVZ0MzR0UytWNG9qdVBSL3RxZkVR?=
 =?utf-8?B?RHIvY3EyWWJ5UWJ4R1pkdE1SUlBkUWRndnBNMHJHYlUrbm5qZWYxbjdtUDZ5?=
 =?utf-8?B?QnVZOXoyZ3VUWEoxTlA4cGh0LzJtTEZpSVdZa09zSlpoTzJDczNQZ3VYQ0g1?=
 =?utf-8?B?V3hwdkI4cjF0SXUwNCtrYUZzTzA0Wis2b2JMR3FUeHBYYkpaZmlRelZqSzEv?=
 =?utf-8?B?YjIzc0JHZnJYamVPUU1CL1ZxOEZKMUpubVhOdkl4eDdybG1EZEV6Qmowd3dZ?=
 =?utf-8?B?OUpPMlBEZ0ZFdGJQOWw0aitNQ3lGV0FNanNsZU4vWEt2ZnJpTGlFcnVuT1cw?=
 =?utf-8?B?ZEFQeVBvR0hpaFh3ajhZeWkwN05US3YvN3ZlMUhHSTByZVdtalNUSTU3YXFC?=
 =?utf-8?B?MGoyc1drMm5jL3p4K2taUngrajFtRFZHTlBHcFoxS0tJOVBwY1Vqd1Bad0xD?=
 =?utf-8?B?SzlnS1Jad2t2dGNvRmVJWGdDb0Z1TmdwTjdSTDc5YkhOUm9OVlVVYWZVdWJU?=
 =?utf-8?B?QkRTVXplcmJWL3dIb205SlBMTE5sUmVOWG0xNkkwRHJzekp1bjh0QmY2TFox?=
 =?utf-8?B?UXJIUVVhenBTYVlhOXR1ajBZcndvMzZnYUVTblBqTjgrU3dDcXhJY1ZXSVYz?=
 =?utf-8?B?SlZzdkhBZnVEckJSZXFMSmVHVGlGaEhid1JmeXZycnNueFlFQ2NDQ2FRcWVN?=
 =?utf-8?B?bDJCK1czQmdtQXA0cS94OENGQmFSRmU5Um9aaGhwbjd1ODE5dDdnZ05ZZ25N?=
 =?utf-8?B?ZHBZM3pzMnNLSDlmTGJaZ3lKZllheVVMTU5BRVdHc0pOdUlCdUZyUGNKOGVN?=
 =?utf-8?B?UDNnb1NFcE9IMUp1ckdVTUtXR1dXK1JxMzI2YjUwcE5tSUh5OVh2L1dOV1NX?=
 =?utf-8?B?b0NmZ0FNVmF4cytUSDcrY2RPTXM0ZWFMZ1FlYUszSGRqek5yT1RxcVo1amQ4?=
 =?utf-8?B?R3JWZ2Z3VTFrLzRqZFBKclh0WlFFazlRSE16M2VQeTlraHIyY0pISkRHLzBW?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb35863-e9a0-40a6-03c6-08dbc9946071
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 13:25:31.5349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/4TOu3v+bcMe/LcMd2gitNtqekMfa+n+kLTaLRvjs48tN4mP2m3yMlUIAHhk2URDLcVcXzfE3Bcfm9lTHeXpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3902
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 13:25:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13372

On 10.10.23 15:23, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi,
> 
>> On 10.10.23 10:10, Nobuhiro Iwamatsu wrote:
>>> This adds configuration files to support Plat'Home OpenBlocks IoT VX2.
>>
> 
> <snip>
>  
>> That's still generating a separate image. Can't we consolidate the differences,
>> like you already did for the wks file? E.g. have a kernel config super-set?
>>
> 
> My understanding was that it only targets wks files.
> You are proposing a generic **OS image** that will work with other x86_64 reference HWs.
> Is this correct? If this is correct, we need to create a reference HWs common (super-set?) kernel config).
> 

Exactly. Just proposed that also in the TSC. Open to hear if there could
be any conflicts/blockers in that direction. But I think x86 should be
rather straightforward.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


