Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F20C54E58
	for <webhook@archiver.kernel.org>; Tue, 26 Mar 2024 06:52:27 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.130])
 by mx.groups.io with SMTP id smtpd.web11.2569.1711435937893030764
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Mar 2024 23:52:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wXesXFea;
 spf=pass (domain: siemens.com, ip: 40.107.22.130, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrxTng8El+4O1Yui61CLJ+AfLCKz+RSsNaf5/tX6x3gfFLt3kNih3H/AiRdzfIho3WceJjKdwkGTvN5e8G58UoYqTAzn0b1sIXY/R2EzeckVvq0396ANkkIrCLK7upofVyr6eolD91SvQBJqouQw2Ar8Kt/git+dZnnmRDC6st1LV8Us7iMYrAvjd6ruCuX2sEnRT7zcWzX0jzwcGMcKOnLvDicLvoXZ/1QRDC0E1tV9gglOzbSJjZZXJXw4Iv4Nz5AIm2XGZ5dTqCL70/IDfOYNB8yLyfoM4zLj0/soNYs9zYBx9kx+6mKXrghZG3xNc8zQBWi0j98obof+DcnMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNB+ibmgTpK6g/a2pxdu1oPg3akqZLbVzpekiW07M1A=;
 b=gVQMGMHiG2imsDuCLluqKUdFmsckCS8bN1oEKrmaawVXMiZ5E/2uPm4VrTBJeqvg1Q6FF6LPe/fuVBqob3v7v7rIR0Zuh4b2G/2jKKtyEMgwsqM8azdFKbOVtAB05v4T0u+jtoPlgpEqpZAXfzciQhRErXY8eFfFGL8cfaMzT3RAgAxj6jUBADM5V41JxlpGwrQHyJ9CiBGC4oxPm2PHZGvBtKIlFRdU6aijznLlJI4b8yyRPU4TYlM4FA3nCEJFnko8m4deWtNA3PdN3+PItKsK4/VBCeCLFwLUKPVf8/e+DIZpsxz7zXdDGfcjhNaeDoV+QfbtcARwHNmUjPOv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNB+ibmgTpK6g/a2pxdu1oPg3akqZLbVzpekiW07M1A=;
 b=wXesXFeaVtgK73ZJbWvk2vDuJbRoGd8oubP8LeTBAlE/o51p1PWWlhkiqjoRQYdQSyxVMQWDi5ioOgYAar/Jd4wUnzBLwoWPcnjo2Bb3+kgvNUr8KBOnchG6q0xOK8erW29t8sZWphdN5BzduqdyxBARLZqZ2wuzm4rq5/XsCmppqAQMUhwguHiZCleqAskly5bDPH2q1izmHCT970KwY+Iz/AlHx4Dt0npu9C5aZIQ/V67FFmfs31hcisLS8dzduFG4k8Nzczh8Z2h7BQOWAWbRPHENBhPc309Hd8whqZxB1HG9fZaRLFK1xYf4RyJ7KoMfnYh21UPvUr3RI4i90A==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7335.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:445::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 06:52:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 06:52:15 +0000
Message-ID: <2fa52e58-0ba5-4865-adac-3dbe03c9b83e@siemens.com>
Date: Tue, 26 Mar 2024 07:52:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Add support Plat'Home OpenBlocks IoT VX2
Content-Language: en-US
To: Benjamin Schilling <schilling.benjamin@siemens.com>,
 cip-dev@lists.cip-project.org,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <TYVPR01MB11245F45500C758184F6369A092C5A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
 <5367.1711107559199640802@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <5367.1711107559199640802@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7335:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dlbEhnRkTZ16gveVAwi5IbZw/XBB3C13lmeITtX0X/zYBs9gyaRmS47QSVwmHVj97JFpI2UPVblQ8xrG34XuGjli9FR+/xbHemh4xTkVENxZiPT3eLQYdUvhClLwlmz45nnIfqVrWV6q56a0J7vcPKJzHNGYU8B/Znjo1+bU4Te06ykUo9275qm2aHK5bmDNPfSQd+k2ITIJgG6xYnvtz1SjOdvg8yPN9Vwjs+SoyfpFBILhI8WeH6Z0lnWmiTvBtv0GzAJigMeOhF60KywTRWleNA0EeGxPIodmjouDFuXNIl2w17NxRiSStDvzM45FJHmj10jTi1qI3j31vKEwvYTCtFWTuSUkpxopeDjTNBLDqQCCzSjFWab8s57FklUSdb945S15uXq+OncgXAZlc13gyaPSopJ1IUFhSATrUTRgiZ+FrSM/0s0sy2k8acLwUBP5rovHnSjwGXcX2433E+A4gR0ZY2AMDsxb5j7giv6MDZEF+1hK4KZOptWKzFGtuU5Aq/R0T7K1+EREpUrBmBuUe25+brCduv+wvsbPqaKM9E6Y1p/Ii2JV8n+hX3cC4JKCu5pDr3HZAnXdELinGVSNMcjw+RAHuSHDE66KwqnO4JfnMOMDeWEKuDcI9x0bDdLOfffjBK7/fsP9k057HSRizDb+c0+vfB5JSHC2fA8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TDNSMWQ3WTZnZzBRS3JxaUNqdHVDL3JXTUZrSEFZeDh6SE9pc0FwUVQ1ajg2?=
 =?utf-8?B?Wkh5eUF3NkQ4NjlKVHdqVlF6N21LNXlYTDRJY2MwUWtwNkQraFE2STVJaXE3?=
 =?utf-8?B?cjhpU0RmYjlndnJiOXh0NEZBLy9ZOVl5ck9vbjJHNFhNekYyc2dkZ1c4UFVr?=
 =?utf-8?B?dERFeWZIVloyQlJpLzhpTjh2K0RZNUlRQ1lmNy9GM2U3MThzeW4vbGxod0dU?=
 =?utf-8?B?ZVd3cHZXRmpLYVk4ZFM4QWpVVE5YN01SY1drdldpbk03OHMyYTRZODl5MUxM?=
 =?utf-8?B?b05kcStCalZSK2s1cGh0Q2JHY2JoN3JLTGVDR1J6SVBqbVV3UXlCQWpaZk1D?=
 =?utf-8?B?Skd4RFpxTHRPZm5PNUNsZ1MvUkUrV3VUZ1lJZ1o0VjVMQ2paODdEa2FiV1FU?=
 =?utf-8?B?L05xbjR1VWZHZUpNQ2RpRUh2dG1wTEdKL0FwYTV3c3FCTXp6OGl0V1FhT3VO?=
 =?utf-8?B?RmpmVHFCQXhHcFhyTHFRL0ZCbHg4eFZNb21RK2NJc2wzSUhLVFpBdkNsM1Rj?=
 =?utf-8?B?VWJUYkgrOEhXNkFtZ2VHZUtWRWMxL3BQRGcrZ05aSCt2WWxsTjdaRXIrczcx?=
 =?utf-8?B?YnkrK2hLWnhVMkVxZUNkQjFlaHRoTW9CVUZhdkN2ZGJzWXFvOGV0OVQ0cWVo?=
 =?utf-8?B?R0FLZG5FSlRFVXI3L3JmaUpOSWp2M2dSWEtqck52RjJVVHF5RThuUmxZVmpn?=
 =?utf-8?B?TjF0VklIL2hoViszdGZlKzVLTUJtWnFWVzAwQ0MvVnJhQUFleHZ3QnlxY09O?=
 =?utf-8?B?UnN2VG1wREd3dEhtNnBPS2VGRExmbDRxQkE1cjk5bFJkemIxZTRXZ0NTUzJV?=
 =?utf-8?B?alNMK01QVktrK3IxMHlkVUxkVU1BNjVFNDdKdW13dE45cGhPZFpUTGYzdGph?=
 =?utf-8?B?azlrV1lGMFJXbmt1NHlqWG5WUkdtTXR5VjYwWkQ1UkNLR1pnN2xkb3BJOFhJ?=
 =?utf-8?B?ZURXbFFUbzNSRjJwMlZ3MDRreDdjQjVqb0o1WE4wVzNCTCtieU0yY3NzV2RK?=
 =?utf-8?B?TG5VcUJjYk5QRXR6Mjlpa2djcGpUZGpXeHRldy9DNUc5a0JhdTlaZUlwK3lr?=
 =?utf-8?B?VWwyTkFoenRCUWF4TnJDWWZudEt0SE1VRFJxVm92WlNBUkJKSXpSRHhHdXNO?=
 =?utf-8?B?eTRoem5BZ1VoOWdsdGZMU2IwdVFHM2JrcUZXRWJ1bnZvaFJKU1ZXa0Q4eE8w?=
 =?utf-8?B?S2FiblZRb3lQSlU3WVp4Q1FQNC9BdVFCaDBQN2g1T0JROFlHVnBBV1BOLzZt?=
 =?utf-8?B?Uk91eHlOSHlHYm8xdTNzZHVyN3RKeGFpQm5sMlNTY3NEMVh3T0hEUW41RC82?=
 =?utf-8?B?QmkyL3k3Mmt3VUNCNEdzU0o1c25QcklxRG9YU2M5bmRvN2hOQzdZcmpkNzIr?=
 =?utf-8?B?U3p4eko4OHVLUCtZN1JjUzdWY0hxOTBQckM3dDVEeEhGeXViODc3UzZpU2I2?=
 =?utf-8?B?cm1zZ3BkTy92MURDYmdZYXJZYnN0Mi9PcWNWYnFkZU4rR0U3amltSkYwVmJ1?=
 =?utf-8?B?VThyMjFKZGtPckk3cDBLTmx4akNMSFh3RS9YWTU3b01DQWY3NFU5U2lmNUww?=
 =?utf-8?B?MjhkNkMzWUJHWEFrZW9vdVBzTWxWT2xWcDAyMmEwTWZYeUhiK2RzS2V4REcv?=
 =?utf-8?B?L2hJeVdDcFMrUURVSWVXZVFhTldpV0pxUmJkUnhwQm9UbVo3aHBzTVR6Ynpz?=
 =?utf-8?B?a0EzM3hhZ3dZdWpOTUx2RVRxYk9CbnVkNGc3OUg2TTNmbnpyMFhkbGVSeElR?=
 =?utf-8?B?S2wwaXp3Wmk4Q1c5RVA2VVdyazZTOTdsdEUwQVN0TmduV1ZzRnQzeHFqWnI1?=
 =?utf-8?B?c2VkaXFWa1dlRE1NcjV3aTNpMUp2MkdST0JkT0lGTG9vaUUyU3pjblY5ZFla?=
 =?utf-8?B?cXUzTGoxbXMzZmdEOVBIUHplTldEQmhzOER0UHVJRUFCT0JHVjE2OVJXZHZH?=
 =?utf-8?B?TDd4eUl1aFVHcS95RFhlMFluOEZ0bG8rVEVzN0hYaFdXME0zbWwxdXd1eXE4?=
 =?utf-8?B?UnhMZnVjYTh3THAxSGR5UWljS3p6VTA0NTRpTzNjcmZiNHAxN2RKdk5mek1L?=
 =?utf-8?B?eWpjWGpaSUprUzg4ZDlmaHdNNXRxRFpCQVdOSTloSy9RMGh0N2NwbDRXMjU5?=
 =?utf-8?Q?t6x5AaspVrbkVF/rr1y2246T+?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be17c209-392d-4d47-d623-08dc4d61453b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 06:52:15.0192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTH7gXtohkjNsSK+CF+2fcaCcDhnxGceTNKCuCWlYmUvZqQMX5kArLFFT1ohJMjvFWEQK9VMvB+PXmR+xS2HLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7335
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Mar 2024 06:52:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15415

On 22.03.24 12:39, Benjamin Schilling wrote:
> Hi all,
> 
> I'm joining the discussion to start integrating the M-COM x86 support.
> What's the status on the generic x86-64 target?
> 

Nobuhiro wrote recently he has a prototype. Maybe he can share to
finalize it together.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


