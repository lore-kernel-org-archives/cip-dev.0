Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB35CC001DB
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 11:30:35 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.43])
 by mx.groups.io with SMTP id smtpd.web10.14862.1691667032218080204
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 04:30:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DoOqiTxs;
 spf=pass (domain: siemens.com, ip: 40.107.8.43, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nic3leC5nq4X/+jNcU/VuyEQsV4IDHJ1wxRcda2yy4HwrXqOUPN2sN6qktUq/TCb33z+kRHUP0r9siqMR801NWkOI8WC/jJUpsZT01yLmdbUvOtb2eLbSSIolJAsXRmTT4j89kUI+XWPB1JIZWz98u74aynJijPP6CQRssWCbfs2RrRpUINvbetnkCAeBcFvj4AHyLLwqXXTVM9ixvnZinxjONDpCrQcEtaa36uBmKSYHadx+p8/7+CDB7K7g2guN9ltUh2bBZBTbSqvIQ1pQe65yQQrTRaIuGyldK+aRDzbyperqlo43NetRbfgnRWu1F2e9RhM1SLQuFb5+MNqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+zIV3iAhTdCrYcoKkVVvXwHrIXx8hAG2bB+Srmtjt8=;
 b=gIgELi/ZT6EFFbia2sMzfVHQlNDlNuMj+5yeFz2ee88GaTydjNyBr7k945cniHjqOpd/ph+LyYN3Lb+w4nX2xdadJoSofs2NfcK+nxLjKZPH7gobA6KuY0c1oKjhK0xIffNeTPVSskX/7d/z6H55Yw3clSB51n3A+5bPJYqQh6oDeRDtpPZhpzI9Pv80Actx1uGvILX4csZK32PFbGuz8F8Jkqr3VPJnlzlTFgSA3hFQ89e/LEtF+SEQvLyOuOyQvJ9zhFKvkZFlMnEFAMIV6IYtl1wefiXLbDNHuFl8kfMRcWP0+BG3HZxTrb+OGV1e8+Ya/sJszyNie5GUp98CWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+zIV3iAhTdCrYcoKkVVvXwHrIXx8hAG2bB+Srmtjt8=;
 b=DoOqiTxsvmokcMi/ekKQF1CnprgD3p1rv71ObiERlq5Y1lIgbxJdzsKY3MlrcaVhNQx6G8UAa7M+ngekS3qkqAY8ay66vvgW1RQtNO0dDwRTVnwt4BMd76lJnWChjHBd4WtFOt+krGlDejb5Yl9gnQ0Kb9cQ5MPCpbDDzcb88d3YXOm5YxaAJAM2QrWrpRPvtx0qMJWtTVtyMJuGr+qC+ft/Ancm6WKHFQy+q7DUPKPjnxSMkTNf010rZulO1JohhUuVyxNF/n8ssczYA5JL6rf4LkRYd1FF/0SzL5uJMd7LPluVEROs+5DyobNvcg91b7bpOvsIwjfVV0r9qmyl4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI1PR10MB7756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 11:30:27 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 11:30:26 +0000
Message-ID: <81ca5a8d-4b57-c71f-651d-fd5e01176661@siemens.com>
Date: Thu, 10 Aug 2023 13:26:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [cip-dev][isar-cip-core][RFC] swupdate-handler: Add default
 config to fix u-boot build
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 "Moessbauer, Felix (T RDA IOT SES-DE)" <felix.moessbauer@siemens.com>
References: <20230803102401.564807-1-Quirin.Gylstorff@siemens.com>
 <674bbcf8-8246-4faf-b80b-f5f672315492@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <674bbcf8-8246-4faf-b80b-f5f672315492@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:610:b0::18) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI1PR10MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: cdbbc2da-02ba-4489-9743-08db99953150
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VbWnYk4ddN4ghMZxGnad3TBXc5zTREpak4QkBRLAaIV/geUHTbU2gMHlzGGNtCxX0mtYlSJ5ZdAmJUSeFj8SMC7/uuqjMtPAByJGzyCNIzkdrH3o/Zmeqg+SJF3LqdFOaa56ax+LTYTYj6k8/V+PqFGnsBkMCKSuKncUAsLxUPTlz5QfR6jqUWFxw8TzZ09wnENp/wa3RwSLAOkkDgvXc4jmknmZyxZK3LT1wrLrBzMWPLCaAEWAQy5h8uIOAaU4t7Il6COYzQy9DQ8/sZMMCaO0Kz05fqeiy4hP+7Ts3PE7ZZ7tECoaLuX230cyoNy1GRtP/vsQuQZ1b/R162xdJ+0qA1dOxKGk1kmErxUQUg4UgIvUms8C4uGx2/6o6S06Qo/i6ETBIDHT1Zza71ga+R8yRmQpmFKj52wy36X3UC/WreRsr7Jv0kIW4MIH615D/ZzPjaR572KNcy3ppE9SH4lsjBr13W6ASg9oEUYq733/V3MXQR5HPVOfV2DIfgV/Mjt/Q67qzHBQRO9EMDkg/S6AultMTAJ3SN145EjCozP4u/+iBvF9v0UypVUZGawCn8W7CEfD3tjiUsMPMN9PWwWLwhgpQhsKmy5TG91zcgwJFKD/2Ltd3BrRmE3VC61FzFmaY1MSYW3fPmRcFY56zg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(1800799006)(186006)(451199021)(6486002)(2616005)(82960400001)(36756003)(6506007)(53546011)(26005)(6512007)(31686004)(5660300002)(110136005)(38100700002)(86362001)(66476007)(66556008)(66946007)(6636002)(316002)(2906002)(83380400001)(31696002)(8676002)(478600001)(41300700001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UkxWMm5LdENtcktSWklCUExiUTE4bGFrS0lRSmRvaG9XZW83Tnovd1lxMjVF?=
 =?utf-8?B?WnNOQzRLOE5yZUtDQXBxK2VCSE10RVFLK05jcFA3bnV3VVU1QXNFS3J0VUJp?=
 =?utf-8?B?Qm9pSm1xNFBzaDdnR0JtVlhrbkFGZkVtQ0x3S3RtbnRpUXBiMnM3MmNFdDhu?=
 =?utf-8?B?MDUweUcxVEJvZ0JRRVZuMUhKdW1Eak9qQXdrSk85RmhYNjk5djdyZVVkWFlL?=
 =?utf-8?B?UE12TVF2eGZkaHRCNmlDVHhGYzNhYzRmZWsvZHFqOWFlNml5TkZ2dTYrM1JH?=
 =?utf-8?B?S3ZXWVRqVmFadFUzQnRNdlg2V3ZYYm5SQVN6VVRhZndrR0lyWjhXRmdYZzVE?=
 =?utf-8?B?UzdDaElaSkQ1bWNSNVdSekFzTzY0WFRxVDdaVkdLOURNSlJiQ2ZzRTVOc0pp?=
 =?utf-8?B?NGU3M0g3MnpIMTkybjJveEJ0ajdSOEFqV2RucVdxMC9MeHVlZGlPeW5MaU5s?=
 =?utf-8?B?WkFHME5mUmdRTjFnZVBTeS92aFdrYXVuZ1JCUlNTWlJDMG9LQzRPKzl0WGtG?=
 =?utf-8?B?S29nSnRwZTRWeC83ejdBSXdVaHVBcVBsUkk0MzFtM1VJMFJXc3d5U0FuMlZB?=
 =?utf-8?B?dWdQVnlVVE5Zem4vMkF2NGdGaFRhWThlR3A0aUk2U3FSdjZ4VE5LbDV4OUo1?=
 =?utf-8?B?TUVyWnovSnZsK3BJMTh5SE81Z01RWDZwZU9vMEJSM1FHSTNnYk5pTHRzRFFL?=
 =?utf-8?B?ZWI5M3kvYU01MjBDZE50NlEzTkZUcUErN3pabmFGZWI3RHdZV3JocldWbmdU?=
 =?utf-8?B?bGU0VDVnT1AyL3BWR3JDb2lJQlp2R2I0L2ZJdDJ2eXpJUE8rbnhTd1k2VGg5?=
 =?utf-8?B?cnJRMWtaMjR5UzVvZ0x2NlpqQXVxOS9nV0RwU3ZNaVF4WTdmak1pRmpKUU8x?=
 =?utf-8?B?QkdRZFNUK3BhTElEcWVSMjRlWTZBUUxpYUZkNFJhcmYweEhYRGUvTXZKWTZk?=
 =?utf-8?B?SExnUVVVNG55MGo0U055cTBzVUNYNnllRWxFclgrVURpKzkzb0JhVG84d2Ur?=
 =?utf-8?B?c21GZWdVdEk2WjVzdXJoaVJWQVBVSExRdEZhYmxDNlhrYURBODh6MTNxZFdw?=
 =?utf-8?B?a2JGMFQ3L0ZkcWREZTg5MFJMREtPRjV5dURaWUgyc0NwZVBnR1NTUDM4R1Fs?=
 =?utf-8?B?Q0JGc2tlcjR6bDRxL0lLR0tTVHB2RVltYVJXL3dxYkJ3NktBVzdybzhsQTh2?=
 =?utf-8?B?MlhhR0lKaGczK3FBV25mWXJSTXJPYk1wQWZlQU5wRnozdGg4TW1vdEhKdWcr?=
 =?utf-8?B?ZUZGaFNqbHFhZStDWHNTSjJGOHpLdFh1RTI3eDFLV0JjM1BBQjVHWFdtZjBS?=
 =?utf-8?B?WVNxNEVVRTBRb2FXdDFSOWJUS25sakZGcUpvcVhxNW5XczRWT0M2cGRyM2Ey?=
 =?utf-8?B?NldhZ2MrMERsWkZ3R0ZycCtXYTU5NkJzMG1rUVMzTGJ1ZzdUN0U0bndKTkdX?=
 =?utf-8?B?S3pWdXh2dEQxL01CS3FBYUlibXpWNlkxMFBoM2FJdU9US085T0NicXlRZ3pF?=
 =?utf-8?B?YXVSOHBPTytJbE5pWVBhRHUyL3RXc3MrdzF6NXRTQTY5akVvenNWYXJvRFdK?=
 =?utf-8?B?aGkyS1ZVUVpvYnUxbW9Ca1dHQ1FiQjlhTnB1czJJZWdHeGwzQkVlL0tKeGg2?=
 =?utf-8?B?K1VKam5SY1puVTNPbVlvZ1BDNzMvT0puQTd3c1hVTlp3cjdQSnNsUDBNRkEy?=
 =?utf-8?B?V3FFTjB6aFY0WDBPaWtJVDVtUmdPbVRSdDlmNUN1TFU5bXVTenBvKzl4QXcx?=
 =?utf-8?B?NEI0NE15c05SOU5uS0xZS1BxWngzNkU2eUo2bUU3SjJlU083T2diYUVMM3Nx?=
 =?utf-8?B?Z0dVSG9PZkpQYTQyOWJKc2hGMTB1RG5hZnVDbHVra0JYSnF4Z2MvOXBEa2ph?=
 =?utf-8?B?NlMyMjRyeUhDeHNXT3B3a3M2bzZGNDBjT0VJcEZlWjdkbDAzYmxZWGNnQ3Rv?=
 =?utf-8?B?cmYvNEtaS2dtVUlGcHdXa0wrVlhrM2xaZFlkdjVFVllPNHZQNFdTdC84YjZj?=
 =?utf-8?B?RjgrTms1SDk3VFA4L2VJaFhOVjhRdzgyUms4ZnZldi9HSU5wR2hTN0I0bWR5?=
 =?utf-8?B?U1ZEd0E0V00xYVFjTU04aDlNNHB4WkFKN2JrSEt0aE1sYnhaMWR0RnkvaWdx?=
 =?utf-8?B?UHVEY0NjWk4rOWpubU5JbGZsY2V4eHhpUlpiZ2ExMDdKUSsveVVEeER2eVZn?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdbbc2da-02ba-4489-9743-08db99953150
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 11:30:26.1453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Im+fqUjJj6C3Qzoda32g+anbowkeiFelfSaF/u6UxI5clbd9hpTS+ROuGI4DmHKpW0V+aUks7HbXSq6UZAzyLcG9/ae1Vf0TyhCsgKxUGRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7756
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 11:30:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12599



On 8/10/23 13:01, Jan Kiszka wrote:
> On 03.08.23 12:24, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This adds the missing configuration file to allow to build with u-boot
>> as the boot selector.
>>
>> It uses the getroot mechanism from SWUpdate to select the update
>> partition.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> CC: felix.moessbauer@siemens.com
>> TO: jan.kiszka@siemens.com
>>
>>   .../files/swupdate.handler.u-boot.ini                  | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>   create mode 100644 recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot.ini
>>
>> diff --git a/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot.ini b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot.ini
>> new file mode 100644
>> index 0000000..0e6df08
>> --- /dev/null
>> +++ b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot.ini
>> @@ -0,0 +1,10 @@
>> +[image]
>> +chainhandler=raw
>> +
>> +[image.selector]
>> +method=getroot_rrmap
>> +[kernel]
>> +chainhandler=rawfile
>> +
>> +[kernel.selector]
>> +method=getroot_rrmap
> 
> This is not being stressed by isar-cip-core, is it? Do we plan to add a
> target that uses legacy u-boot script-based a/b switching?

I had one request by downstream for supporting u-boot with suwpdate from 
cip-core.

Without this file the swupdate-helper will not build if U-Boot was 
selected as the bootloader.

If there is no plans for legacy u-boot a/b switching I would propose to 
remove the u-boot code from the swupdate FSTYPE.

Quirin

> 
> Jan
> 

