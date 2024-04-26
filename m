Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90715C4345F
	for <webhook@archiver.kernel.org>; Fri, 26 Apr 2024 13:21:15 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.61])
 by mx.groups.io with SMTP id smtpd.web11.14048.1714137671648071524
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Apr 2024 06:21:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=IM5VtV3w;
 spf=pass (domain: siemens.com, ip: 40.107.105.61, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7tnIb48lazptR5+1V53ayXmCFbt3biGzS/urVYwH/zJtuvKFx7ZRUJ6N92dwTAKFh6oCTpcwR6cWcUx3s//tK0Q97WpSWHPtbc8xcYGDdiXHER9viAQMu4ouMYA9GJ9sBGU9m2k+VBIEV3UtcA6Vtn2cN6nEVMOpZkUZWXLNo7H30zNoiq4lHXqpfi7jU9C7hV8hyxC2ACB4N1V5WEaSt5+mdtwlSd/UUv+muhPuoZQ2un2XepeB9+z2blTmUWRrYPIAEVhlfaWzppOGC5z6bXT7wa1hr1rtma14FgbSSyO0JgjzTuq/rQ2YNaih+Gy1TXc59PIixTIDjzMSX5bew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdSSNe5CcbyEeIvOEUJB6PvIb1B1jqTWeFt75mD7ofo=;
 b=XrjGfKiI4EEEjFnTix0YyTnRO8jnKW0CQB7pUeXBrsg0GFZD+g5gpvNDHO/GMKOwNYOXzyv81V3h8DLWO/LJOEzImijTsyzkenP7udG+aRcf9wtowXEY4Th1Uavzga/iYA/qIpHpdHokeCYZBT5Hc9FSOWNNOcArwNgbhg3Cv6uIoZU+jbcO5gSFcfTTiO422Ky2p+gX9X0hTSLiUx1ndAngT1sUgYQvJQPX2eI2gbE1t8woaj5HJitBxuza1Z6K+npSzp5Fg3mhACjm5fzyedCzXsjoKuA5fc2Z8s6CydWry2htqT8CkmAkV9zgM1eUyv+qBhP7AhVpVWgb/5b/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdSSNe5CcbyEeIvOEUJB6PvIb1B1jqTWeFt75mD7ofo=;
 b=IM5VtV3wQsXdvMn6Yyv6MDb9V1dIdNQ27nNlXG14Hs4R9hVwDXZoTLaZziygKMOOR3aqwrTzY7/eg45Hx8UM7Sz6MAtbyCCw54WirHWCStmw8b8BkETtEb5hwBhGUMo2K5ERbCpFGTy57BRC8tmwaazHVlLMn++ype1kW+eBTP1Yem5AbcAGLWuDyLbPGbU0WZ3EQ43LQhw+wq8YygtxdiaoQNt0/pWyq8eEla8gpti7SRS3cmoRyaSHC0aBssj+U6AFS5wPpjDjS6PM0/nfJKHSuVH/EVLqHHSfcoOiZNPk685mC5Q+Q37FXBPdM0WHPYFUcOA3KunBIUwiEG3lnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GVXPR10MB5936.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 13:21:07 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%4]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 13:21:07 +0000
Message-ID: <3a414ab2-b414-4559-aff7-99970d20f95c@siemens.com>
Date: Fri, 26 Apr 2024 15:21:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Generic x86 kernel configration (RE:
 [isar-cip-core][PATCH] Add support Plat'Home OpenBlocks IoT VX2)
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
 schilling.benjamin@siemens.com
CC: Chris.Paterson2@renesas.com, minmin@plathome.co.jp
References: <TYVPR01MB11245F45500C758184F6369A092C5A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
 <5367.1711107559199640802@lists.cip-project.org>
 <2fa52e58-0ba5-4865-adac-3dbe03c9b83e@siemens.com>
 <OS0PR01MB6388EFEF8FAA99557205AB4092032@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <5c49bdf7-5909-418c-a8ab-683797f6b141@siemens.com>
 <OS0PR01MB63887693ACFE968011C6315092112@OS0PR01MB6388.jpnprd01.prod.outlook.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <OS0PR01MB63887693ACFE968011C6315092112@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::14) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GVXPR10MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 595092c0-888c-48c8-6eea-08dc65f3bb84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LWPGLN+JuD373jXpyliGlZq0toHffgWBMc0ZuL0e/wdteNRkmAhIU6pwh6A8?=
 =?us-ascii?Q?hjQfxk6Ah7c+m4uFoQJOhK3Yg6X++OhDdBNP6gAsnklAefjnO/Y0iCfCfSBO?=
 =?us-ascii?Q?FOfqzP/1SkcHjaoUyeewSoq7HM3Tt23wBnuIRTastKVx9HEPe5VGJ96oNvcW?=
 =?us-ascii?Q?obIJHCH8ERhWzkG4LpySHwPn2cda0RW9MgC1yppLnBDe5xjH1l+ntZnqpXHg?=
 =?us-ascii?Q?YjQSaPjV3Y3IWkWhQl9wA9edntwCC60TvE1lwNuTum7SbOBSm1Mh+lvu/Wk5?=
 =?us-ascii?Q?8U+Gew7MbML+jDgnqe89lMW7Q8W966qgbl0nrTjTRbEfl2YYjVVFI/27IW+4?=
 =?us-ascii?Q?JLc1Qt8VnadHgFwQAmEInLsTuBBN2VHGm72+N3tx1uZQ2ZdO4aziGFwuC8kG?=
 =?us-ascii?Q?YLJFLCRxHSDydhWFKJ2zD2FUDHWlzyTMtGBhAiFJO5MSAs5nyBMGimXIXjNi?=
 =?us-ascii?Q?IbZ9uXLkR7xnvL4zWe5phXdhtHxU7wPCXda5tj1a4YHJIELlz5YpyZh6bxDy?=
 =?us-ascii?Q?+uw08E/PlydWupqK6dE7Ve898485GVSo7Q4lgiReOcDrXxjWaWs40jU7c3EG?=
 =?us-ascii?Q?addhiACkalEj6j81ap8H8GtqeYoaTrlt6gEncPmQaaqPXfArT65eyV0kogV0?=
 =?us-ascii?Q?OQ0R/gfaXBN85qZwD1VNawyWSJ8fL+sXUwFqYCRaY9XABCX6u+AWGAc8DRBS?=
 =?us-ascii?Q?GGbCVyh8Hv8FOIltvw5/ot24h3K2wGXUE3iWJTEM/+FuX3qjpXU8Yc4aTxqy?=
 =?us-ascii?Q?C8M5xTgmSdoLmcVULHnSQ0nLO1Gv73Jby1Ff9GqmmOilYiDhT3xNxAzE/Zav?=
 =?us-ascii?Q?k8lIuXuP2tNKOnkvRFY0obQ4RFv3U5f9KC0fjaeDBmYeoa1NsRIVZPAUZz7V?=
 =?us-ascii?Q?f0TOtrs7mIEQzCM6eKaaGJ2YnakrZHrG5WX/Cx6VFfi+a+O4k3OjY+spINvK?=
 =?us-ascii?Q?Ev9/hQShstXi7z79S04sILhH98fxFnWH5hl//zikvHEaVktQnu4aY2SrKtln?=
 =?us-ascii?Q?BDGINp+70QwWYD9uNDaU2Al4kzobOB5KmcB4s9V0BlnUswFZbyvpX7ZiyXpQ?=
 =?us-ascii?Q?HUXzbsG2mc5uYS8ZOzaIVis2Cs3UQJq4DAs7LRc2iePxQcbmGIqE2+mAdGzp?=
 =?us-ascii?Q?EXDvSW3aIdiV26vyQw4sHoaCIuTSK1hnl9o0zq0icdf0Ng1nMItbkfOPIy3B?=
 =?us-ascii?Q?pOcfFRxUfLCSZp/KHG6sKRRgfGTP23E1JU6g4Ct7dDgPKQSEhMTIwQc2iek?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?owdmdnxdQdsZLgvawowdcjQAx3XwIpmkPPaARBLmfl2AqLCD8Rh3Do9wTSBM?=
 =?us-ascii?Q?r36ctmW1H/Mzq++RrqKCqDp+kFoKMxdWU7ItT7+orOrPeOb1/ZnVxG5tDXBF?=
 =?us-ascii?Q?X7AKPILs50VMzntTPoYJybyr6vIcZBsihuxD4vvun64QjSxxgpWsRHX/uFLM?=
 =?us-ascii?Q?LiwcWhmLw8ejCOFZkTYrqRlE8SVLc9pvQ/+PPKr6vTpzBfhrji6rpe7t46mh?=
 =?us-ascii?Q?FV9n04fQS4mmjG62LvR3XY90tTFzt+o8zbeYYojnNgvXP8rQJnr7BRzTUUqh?=
 =?us-ascii?Q?x7ijhc53y6jwtc6GI9mI6H2bhgdrvtUcvfojs5Xls72tMjWQEhsoIJGSLEUR?=
 =?us-ascii?Q?uzmuHgIk05JgpbGICD6TDCIbv96Yu9o/lvB8ERbv9HItThkloEyD9HE7WkLi?=
 =?us-ascii?Q?dpTw1ea9SJeyaQvPbMPHSwbW19+FPVqgpAHTQerebIi23y/Fn3iYNSWenpVD?=
 =?us-ascii?Q?qEYo8IyUdf2iHFrue/jJsQ3Eezx3UhP4R5FBhVSzavXgtM8fu5sl0eKfnQSb?=
 =?us-ascii?Q?PtJFgGVKgjj7y+9rlwko45UpYOjsQ5xqogjWZREyplvDA0ORapqaNuuFOOYm?=
 =?us-ascii?Q?V9k4p2iKWfmh7n4/WNrlffWS2qQI2t/VECu24Qw8X+EJLCkVXdDcsarzkmfi?=
 =?us-ascii?Q?Fa9u3k9CbeMT4h8B90i8ry3iWUQ9fIYx4lpiSFTjp5ILa80GNMHGcRT8fg5Z?=
 =?us-ascii?Q?+oqcuLqmOhfJr2aTrQw71a5Cb6K+7qSYvoU+TDSWy8XUL4rTTq/y12Y7bqwK?=
 =?us-ascii?Q?xggS8hgqUoRKYGcQEOa9R0UD8EtaMSlaFbsNiz3VMDuDqiKESE5JCq/sc+hD?=
 =?us-ascii?Q?QQcamAzj3kPXLGy6Q4DMuo040CLZ7tR4UHXofvpfHd+yhi+gNmnxEA5IB0tR?=
 =?us-ascii?Q?c4gbThSdDDfAaZPjWdju4fueu7H8gL3z8bvz5qsTE18ov3TREXjc8R1FACTw?=
 =?us-ascii?Q?nO7fkoCS72ZbP23SR3DxOubS4HnamUOs9t8hS99gX7D6UafwpgbT8+YHQW8x?=
 =?us-ascii?Q?0UoCxI+UONbGVQ9jpBcihK4zTH4jc3aomr4qVv5x8yoN3EfdmFFcof9a8JTR?=
 =?us-ascii?Q?89U09zLoRDqQ7DouOVfZa2llLbv6H24k7Mk+Ri4M3uTuq1sCrpc6TXmZ72FS?=
 =?us-ascii?Q?SRGeSCcnOT4PdzCyDcEU//zpBai+LOeYFXYc5Ufnc3xB1iUHD5Uv8Mhn3f9g?=
 =?us-ascii?Q?eIfRidouZH2uZg0nGsh+jrBcBhZ/Y+deI2sr+8JdOhKcFWnfk1YMzZgSTwn3?=
 =?us-ascii?Q?sZRKHLqGe0Vwvipwti4KriYT4npoZiNOZaMEJDeJ8MXDS2sBi2sQuGRbAPK/?=
 =?us-ascii?Q?KOyYBs8pUnuXnVcYP7FvLmauS4EgSvC13ZLRXvQwUdaMTq0kjmRfjrcOo02c?=
 =?us-ascii?Q?MZZq7nm63lyBVw83KTm7YZ16IFzsKWQkfNPYnB23iC3JCWgK9UWIlQbLwLak?=
 =?us-ascii?Q?zTaw72spSCqT29KMbuX2/vi9sEfDrIcnzz33pQwo7nrhUx/dWyoaTbzvHLaO?=
 =?us-ascii?Q?CDb3e2EukFXQ7bBV/0K61NhzpDYV35tw3VQX6tyMzIYNbXomfEmkKczjnOS+?=
 =?us-ascii?Q?x0ghKFTjyv5GuvhpFt8X6Nq2MECVa7vfGe8KpOxVoUh0vrkywlV/7g+Y7Kpl?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595092c0-888c-48c8-6eea-08dc65f3bb84
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:21:07.8425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gUNjxrtUOVr9MZzOmpToMgDRHkMTJg/PuBJ4GDEWP0/2IK/RWYLE8nBU+iMPtGh5/nBrQPtXvshAAdSGtN/1YQYe5Wcsr506+4aw1F8Av0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5936
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Apr 2024 13:21:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15773



On 4/23/24 3:18 PM, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
> Hi Jan,
>=20
>> This script will likely prioritize the choice of later-provided configs =
over those
>> earlier listed. But we rather generally want that features enabled in on=
e config
>> are also enabled in the merged ones (superset).
>> How could we achieve this? Probably most of the comments I would have on
>> the ipc227e diff would relate to this.
>=20
> I see. I think we need to check the configuration of each device to achie=
ve that.
> First I create a list of configs.

I look into using [merge_config.py]  instead of [merge_config.sh].
This looks promising as it takes the Kconfig of the kernel into account.
It still requires an make savedefconfig afterwards. `merge_config.py`=20
shows warnings like:

Merged configuration=20
'./cip-kernel-config/5.10.y-cip/x86/siemens_ipc227e_defconfig'
Merged configuration=20
'./cip-kernel-config/5.10.y-cip/x86/plathome_obsvx2_defconfig'
warning: The int symbol BASE_SMALL (defined at init/Kconfig:2043) is=20
being evaluated in a logical context somewhere. It will always evaluate=20
to n.
warning: The int symbol ARCH_MMAP_RND_BITS_DEFAULT (defined at=20
arch/Kconfig:732) is being evaluated in a logical context somewhere. It=20
will always evaluate to n.
warning: The int symbol ARCH_MMAP_RND_COMPAT_BITS_DEFAULT (defined at=20
arch/Kconfig:766) is being evaluated in a logical context somewhere. It=20
will always evaluate to n.
warning: NFSD_V2_ACL (defined at fs/nfsd/Kconfig:34) has direct=20
dependencies NFSD && NETWORK_FILESYSTEMS with value m, but is currently=20
being y-selected by the following symbols:
  - NFSD_V3_ACL (defined at fs/nfsd/Kconfig:47), with value y, direct=20
dependencies NFSD_V3 && NETWORK_FILESYSTEMS (value: y), and select=20
condition NFSD_V3 && NETWORK_FILESYSTEMS (value: y)
No change to configuration in=20
'/home/gylstorff/02_repos/cip-kernel-config/5.10.y-cip/x86/ipc227e_obsvx2.m=
erged'
warning: PREEMPT_VOLUNTARY (defined at kernel/Kconfig.preempt:20) was=20
assigned the value 'y' but got the value 'n' -- check dependencies
warning: KVM (defined at arch/x86/kvm/Kconfig:21) was assigned the value=20
'm' but got the value 'n' -- check dependencies
warning: KVM_INTEL (defined at arch/x86/kvm/Kconfig:77) was assigned the=20
value 'm' but got the value 'n' -- check dependencies


[merge_config.py]:=20
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/merge_config.p=
y
[merge_config.sh]:=20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scr=
ipts/kconfig/merge_config.sh

Best regards

Quirin

>=20
> Best regards,
>    Nobuhiro
>=20
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Friday, April 12, 2024 1:51 AM
>> To: iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE =E4=BF=A1=E6=B4=8B =E2=97=8B=EF=
=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=B4=E2=97=
=8B=EF=BC=AF=EF=BC=B3=EF=BC=B4)
>> <nobuhiro1.iwamatsu@toshiba.co.jp>; schilling.benjamin@siemens.com;
>> cip-dev@lists.cip-project.org
>> Cc: Chris.Paterson2@renesas.com; minmin@plathome.co.jp
>> Subject: Re: Generic x86 kernel configration (RE: [isar-cip-core][PATCH]=
 Add
>> support Plat'Home OpenBlocks IoT VX2)
>>
>> Hi Nobuhiro,
>>
>> thanks for picking this up!
>>
>> On 05.04.24 09:39, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
>>> Hi all,
>>>
>>> First of all I created generic kernel configuration for x86 CIP referen=
ce
>> hardware and performed boot tests.
>>> The configurations of each device in cip-kernel-config are merged using
>> KERNEL/scripts/kconfig/merge_config.sh.
>>
>> This script will likely prioritize the choice of later-provided configs =
over those
>> earlier listed. But we rather generally want that features enabled in on=
e config
>> are also enabled in the merged ones (superset).
>> How could we achieve this? Probably most of the comments I would have on
>> the ipc227e diff would relate to this.
>>
>> Jan
>>
>>> Also, booting is fine[2][3]. But there are a lot of differences in the
>>> configurations[0][1], so I think we need to decide what to do with them=
.
>>>
>>> About M-COM x86, but I haven't investigated it yet.
>>>
>>> Best regards,
>>>    Nobuhiro
>>>
>>> Merged config:
>>>
>>> https://gitlab.com/iwamatsu/cip-merge-config-work/-/raw/master/config
>>> Diff with ipc227e original config [0]:
>>>
>>>
>> https://gitlab.com/iwamatsu/cip-merge-config-work/-/raw/master/siemens
>>> _ipc227e_config.v6.1.83-cip18.diff
>>> Diff with OpenBlocks IoT VX2 original config[1]:
>>>
>>>
>> https://gitlab.com/iwamatsu/cip-merge-config-work/-/blob/master/platho
>>> me_obsvx2_config.v6.1.83-cip18.diff
>>> Kernel size:
>>>      7760544 bytes
>>>
>>> ipc227e boot log (merged)[2]
>>>      https://lava.ciplatform.org/scheduler/job/1113259
>>>
>>>
>> https://gitlab.com/iwamatsu/cip-merge-config-work/-/raw/master/ipc227e
>>> -merged.log
>>> ipc227e boot log (NO merged)
>>>      https://lava.ciplatform.org/scheduler/job/1113356
>>>
>> https://gitlab.com/iwamatsu/cip-merge-config-work/-/raw/master/ipc227e-
>> NO-merged.log
>>>      kernel size: 7251072 bytes
>>> ipc227e boot log (diff)
>>>
>>>
>> https://gitlab.com/iwamatsu/cip-merge-config-work/-/blob/master/ipc227
>>> e.log.diff
>>>
>>> OpenBlocks IoT VX2 boot log (merged)[3]
>>>      https://lava.ciplatform.org/scheduler/job/1113301
>>>
>>>
>> https://gitlab.com/iwamatsu/cip-merge-config-work/-/raw/master/obs-mer
>>> ged.log OpenBlocks IoT VX2 boot log (NO merged)
>>>      https://lava.ciplatform.org/scheduler/job/1113303
>>>
>> https://gitlab.com/iwamatsu/cip-merge-config-work/-/raw/master/obs-no-
>> merge.log
>>>      kernel size: 9203296 bytes
>>> OpenBlocks IoT VX2 boot log (diff)
>>>
>>>
>> https://gitlab.com/iwamatsu/cip-merge-config-work/-/raw/master/obs.log
>>> .diff
>>>
>>>
>>>> -----Original Message-----
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Sent: Tuesday, March 26, 2024 3:52 PM
>>>> To: Benjamin Schilling <schilling.benjamin@siemens.com>;
>>>> cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE =
=E4=BF=A1=E6=B4=8B =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=96=A1
>> =EF=BC=A4
>>>> =EF=BC=A9=EF=BC=B4=E2=97=8B=EF=BC=AF=EF=BC=B3=EF=BC=B4) <nobuhiro1.iwa=
matsu@toshiba.co.jp>
>>>> Subject: Re: [isar-cip-core][PATCH] Add support Plat'Home OpenBlocks
>>>> IoT
>>>> VX2
>>>>
>>>> On 22.03.24 12:39, Benjamin Schilling wrote:
>>>>> Hi all,
>>>>>
>>>>> I'm joining the discussion to start integrating the M-COM x86 support=
.
>>>>> What's the status on the generic x86-64 target?
>>>>>
>>>>
>>>> Nobuhiro wrote recently he has a prototype. Maybe he can share to
>>>> finalize it together.
>>>>
>>>> Jan
>>>>
>>>> --
>>>> Siemens AG, Technology
>>>> Linux Expert Center
>>
>> --
>> Siemens AG, Technology
>> Linux Expert Center
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#15741): https://lists.cip-project.org/g/cip-dev/mess=
age/15741
>> Mute This Topic: https://lists.cip-project.org/mt/105344534/1753640
>> Group Owner: cip-dev+owner@lists.cip-project.org
>> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/17536=
40/1405269326/xyzzy [quirin.gylstorff@siemens.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>

