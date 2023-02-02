Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0385C05027
	for <webhook@archiver.kernel.org>; Thu,  2 Feb 2023 16:07:16 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.42])
 by mx.groups.io with SMTP id smtpd.web11.18408.1675354030013175086
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Feb 2023 08:07:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lZzCtbmi;
 spf=pass (domain: siemens.com, ip: 40.107.21.42, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEbjAN0G/lsWB9OUwB9aydRm/av1nRAKgMY6SimOgmSdRndsq+mePTieRqQLxggySR2dL5rmDPJ4kkw7LXPKwQB8CEBZRHqtO6Lt09EISzvedoPxkwGe4NSM3HoSVsP50/r5xwQaOHufvO6xS34GBdHOIKs8g51LHAUtLWVmMFmEHcHMTGBHi09nwDt5tsnp68V7ad3L9EHbdEEWwANUkZcgkDbuCIi7vlMiz083dTJ/ZuWrCW7dFMoiF2r5CgwRymGLINm4PltQHvchqyjqvnuODnPuLwPsTZM3wdCVjtLjF8xHiP6aMWAEwbWUORPybrcfzteIt6NrAiKMU2ngIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5okM/8+JfSL5oCkiSl6x2ko9syPG/TLxyR0kAIoJ7E=;
 b=iBCdcoKAG1OX06RPu29gihfXY6iFWF6KeKSrJegIV9CExwBEYb1GymTgPzpfa08igZXOzxJGtGBwlDOWMeto25TqA1zgkVKyCX7Vewk3tmso1ZMzrTwO/aNqDODhClCcITruBpv0x23kW3MqP5vnWfqAz09PoR7jKOMBgjH7dW2cHJ48eZqHRoEv80y3S6yJgLCOI+7AXVWIGnCwNvn7Ex1FMP7p/CPE8tt+E2+30iEDgUdOuZtxBk/tDzoIB1QC4sGP9afS+7tYmTyW4x9Eh0Tb8eLOe1HmWdt4jUYmKzlnjFdTACCNRcj31ATJEhwBEih/OIayIgREOru55Gp9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5okM/8+JfSL5oCkiSl6x2ko9syPG/TLxyR0kAIoJ7E=;
 b=lZzCtbmilH8c///TnJBM2rYOdo/2VxIYljIIqBd+Xzjh8G/PRWiptgKPIy0RgFT9BiGRsWhh0mvK++LDdSb4KuerZ6yhWJOXNpbbB6cb2ffawu+bJL5eyTrjr7KzQ0KYUvzHkDz6cCouwqQWdXB0eo4baDn75PRbaqGKH+VLPnlg2IAjMN1tpPMEclPqss5zeSp3typ3eb2jdi0FhPh6O8oHSUKK92iIhlhACiKpbukg6XI+5fyr3ra6Oe+/NFWfW9nIT9MCF9hGW1rcNZOPBaDeHEkVZMUyJgFd5anZN4tG90qNm6AiqNtkwpet3RnpdGyR0IogANR8ofgCThSolg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAXPR10MB5279.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:274::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 16:07:06 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94%7]) with mapi id 15.20.6064.022; Thu, 2 Feb 2023
 16:07:06 +0000
Message-ID: <cb04ad8b-8cd8-a5bd-6704-ca3d36e4a6c0@siemens.com>
Date: Thu, 2 Feb 2023 17:06:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] Enable Images based on Debian
 12 (bookworm)
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
References: <20230202150811.824615-1-Quirin.Gylstorff@siemens.com>
 <0b9cea9cb50626a59ea5818fc3e7ed582c2265ba.camel@siemens.com>
 <80e74fd4-6f93-7622-6188-43301a8dcd87@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <80e74fd4-6f93-7622-6188-43301a8dcd87@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::15) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAXPR10MB5279:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f72d732-2096-4ba5-6ee6-08db0537880b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5D4SAyV9IcXorK3v4t/m8bCCIrfMcvQCRGbMbgDSUtWIaW+Xj2HJsKi90ILTDe073o4aU5zijwMPydqQebYGn9/LKjmBzk7DPVO1aTbV/bVkmsiF7RADZf3XPXbt6BUsaBxxCCfOMjZSEODxOB9jOuFhVPQ93HSv8hu0iJVU5rJ5a+XpYOVC/7L0ham3nPP1EknQ6k4NXti4SHvjZ+TcfpX5To/P/lBJRrDMJqL1OmuB/r9s6Z6O2iyF9oFMBtn7vua3d7C//QRMQ31auhbrhWNJhNGuzyxboc/kuhMrNQ33l3B4tutP5iIS0zoNy/liytzPjzDH7w7qKtB/hCg+dUpAiqWcsyzqSkcRwdpPvYcdGIESzAUaw195vWJ8at9qrHrlO7iTfhuGg6PRcEpgfQ2eLpcC4lUQlgkTn9e6LA95/f9vDW9blSC53zzAo2NqwijNeJ982AyM23duwyyJyVczalJlgPwUg9hFDlfYjBH1XbjP9U/GRIjTz/GvboQyNhUC1FUYCsPWBH/6H1f9MgFO8i6QzR5sGTmv+1wDfEGD2tQej9RpzZW3JYhzfdGhmnNmF+dvFhntAA+59WONS9lQZS877pwleDHm66Fcr1Rc1+hCVUZ9q84Uu1dAl8eNV6HIZci/cSCeeUxkFZS9W/caB39QU31uoul6ZFFX/E9wuB+SwPMdSNbky1nR15A394rLlz7ngOwvfGAez50ARcA47wZ6qRNty1W3aTnciM0JkHME0RoqeeT2Uc/QDC5FvFMy3KjA4Br4SJMBV7pssA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199018)(8936002)(316002)(6506007)(31696002)(6666004)(478600001)(966005)(2616005)(53546011)(86362001)(6486002)(82960400001)(186003)(6512007)(36756003)(26005)(38100700002)(5660300002)(110136005)(2906002)(8676002)(66556008)(66476007)(66946007)(41300700001)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZUcyK1JlMDVndDd6a2pJVm0vVHd3cmxFckkwcStTWElXd0hTSDZRdXFidVdM?=
 =?utf-8?B?V2ZvRzg5QWpFWmlYdTR4cXNSSmpzSWVibHJGQ3p4S2grem1FQldWK056L0N6?=
 =?utf-8?B?WWdrazZUQXorVkFrS2RnaE5LZFlzTFZsR2laQXFtcUdnMkhoKzY4WXVNVU5B?=
 =?utf-8?B?djhlRGpCci94OGhRdnA3SkZMd1RQaTZBUEozMzk5KzN1YnhiU1hlUUlaLzhx?=
 =?utf-8?B?ZXY2QzVQdnVIc3U2Y2Y4VWRtUVlKRGw2aHZOdUtrMTVOVGE3L01YVmhaN2tJ?=
 =?utf-8?B?cENZUVBGRktxeTA2MGhqR1J2NnFvdmgwTWgrbkc1R2xVS2FYNHdEakl1UUNW?=
 =?utf-8?B?VXZicnV3Z3Jiak5BVW8zQTJPcHZaazBDUnJoeGEvRWFoNHovZG9tckkxNkZw?=
 =?utf-8?B?aGgybzZjZmgrVXR4RWdpNWlkaXM0eDA2UCs0T2d3WDUyL2M5NzA3YW81OW1o?=
 =?utf-8?B?Qy9CeTJhWmVmcmdMVnV0SzQzSTcySE9yd1V5eGFrT3QxWmtkaXpaV2xQRFM0?=
 =?utf-8?B?TnhoU3BhTXB5djI1Mk9MOFpvS25oQTYrczg3TzI0MDVFazdYdTNKZVMrSGt5?=
 =?utf-8?B?eEFBVmtlVVBPNzRSTWEvNXFiQXFBN0ZGSHJRR3hXY1pIVFlVa0s5NWJ1eXps?=
 =?utf-8?B?U0N2TEtRRHMwa0xmc2oyNzZjeTZKNzZpOC8rVXdpVURHMXJkbGNVZFFWcVMr?=
 =?utf-8?B?TW9QMGFhdGhXdWkxayszQlZvM2hpR1ZGc3VwYlp6VFd4anhwVkh5V2lkZ2M4?=
 =?utf-8?B?U21iNFlablBoNUhubkZIeHpuRm0xVTRwWW9tazVEaVhRQ2loeTc2QlU0ZVNy?=
 =?utf-8?B?WFU0cnpqbVFZdkg2cHBZZ21CSmFiWGxrdVV3OVBYNnRZV3VPZTA2djY5TXlW?=
 =?utf-8?B?Ukp4NCttWGR6bGRCQklYZzd2aXpFcG5jdlNtM2IrZVFWVitaeHpJdVhKRXhQ?=
 =?utf-8?B?TzJKUHIrSDZQOUpBaUxuR2tEVEw2SVVLN1o3ZEZjRUozNm9YWXJSNTd2WG1t?=
 =?utf-8?B?QXEzZUZ3ZnczZ2NiSnJ4YjlpSWZwb1dPODVZVDdVTkt4OStQMzJRVzlBQW15?=
 =?utf-8?B?Z2M1Z202N0N2YXF6dGF0Y3hVdjJWcXdVaDJVL2NuQ3FFbzF0UjF4a1Jybk5N?=
 =?utf-8?B?UFNSWUJnSG14TVN2T01DS056TnJkcFhDcXd4K2lJM1UveHZ0bG9sVjl5cysy?=
 =?utf-8?B?eUhLaGp2WU5mNERCRGNsSFNpUmxSalVqRkc3UVdpWHBzeU4ycnM1L1U2elRI?=
 =?utf-8?B?Z2RoS1JGRWpTdUNXRS94R012MHRvOHg2S2hvdlNCckVhcDV0WjBoV092dWdv?=
 =?utf-8?B?YnlOOHBxbHN0dHA3MHZ5RVR3dFdlaURCNWtvc05UTktqV0lZZVJVdUZKanJK?=
 =?utf-8?B?ZDBFR3hGMnl2S3lEYTlsUFg2cVdNeXlpZ3k3RUZpSDlkdXJOeFN5OFhOMVh1?=
 =?utf-8?B?dXJua2I4R3kvejVwMW40NlBGT2tRSTZsbll2N2V6cU1Qa3NKenpzVjA5R3BG?=
 =?utf-8?B?TVVhYmZKSm0rc2dVcktraDNSMWNaQTN0d0JVSUc5QTBpcnFENlYyb2o4UG1T?=
 =?utf-8?B?NTdwM0V5L3M1Z01lWTJnTEVXK05yaVlvTmpJUXdETG5vbGIzSktDVHZSSkNW?=
 =?utf-8?B?TWhjVzR4NXFxQ0pzc1Z0Wk9Kei9GelZSS2hZZXhnV0xXWHIxM282Wlc1L0Fp?=
 =?utf-8?B?ZGJhNkdFM3hUNk9XMkVUS0hTeGNoa1VFcEZCMFpwK3dkN3pHeTkrMkhaU2xO?=
 =?utf-8?B?YXRvTTJMeVNqSWpKcDFKREI3dUxHaGtabmxGSWhIMktkWC9lZGVBL0drZzRs?=
 =?utf-8?B?aXZUemZzczNqNVlwc2ZuNC9ONHZsY2U4NUJKdmJsODYxZGgyanNMNTdCTWJB?=
 =?utf-8?B?VFNlYVdvSGRid0ZFZTkxZy9jU0JpMmFpSlFZS3FsMVd2TkpibjVVNWZWQkQ1?=
 =?utf-8?B?NkJHUGsxWXZTRVF5dnczZzFKaVMxbXpkZy9FZFNmSlRLQjIyUHdpaTlqb3RV?=
 =?utf-8?B?blhyZENBeHhlbjJ2eGhmL2xWSzloZGVNWGoxSGs4VHkrQmJKamRVOXM5SXFH?=
 =?utf-8?B?TFcrdHZRcndMUVRraFQza3pTZXZRY21JcWtTN3RoUUZBVU5SNmVBbm1ub0I5?=
 =?utf-8?B?cGtjcWNvV0pZaTBoaWpUb2tsMk1aQWVjZENscjI0dnlkWVkxZmdERWNQWThs?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f72d732-2096-4ba5-6ee6-08db0537880b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 16:07:06.8097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+K2hbk7BTAgMeCNCQSwIShb5t20wH+AMCNdxLKaFwrVNKPpgcNs9NUapACrzsKG62ebVgooR5+FPdDc1wZfUkOxlcwP0ypGZ2daDLw1K3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5279
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Feb 2023 16:07:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10572



On 2/2/23 17:00, Jan Kiszka wrote:
> On 02.02.23 16:11, Florian Bezdeka wrote:
>> On Thu, 2023-02-02 at 16:08 +0100, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This will add prelimitary support for the debian 12 aka bookworm.
>>
>> Following the Isar mailing list I will expect some trouble now. The apt
>> keys fpr bookworm part of Isar expired... Fixes are available but would
>> force isar-cip-core to migrate to bitbake 2.0.
>>
>> Let's wait for some build and test results and see.
> 
> And there might be also a fix for the firmware topic coming, see Felix'
> patch. Then we can keep the hihope.

We will see 
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/765666637

Quirin
> 
> Jan
> 
>>
>> Best regards,
>> Florian
>>
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> Changes v2:
>>>   - Adjusted blank lines
>>>   - Change Submit subject from "Add bookworm" to "Enable Images based on Debian 12 (bookworm)"
>>>   - Replaced "+=" with "=" if append was used
>>>   - drop pinned kernel for qemu-amd64 secureboot
>>>   - drop Hihope build as firmware-ti-connectivity is not available for bookworm
>>>
>>
> 

