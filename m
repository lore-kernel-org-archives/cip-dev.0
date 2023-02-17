Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAE6C636D6
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 18:17:04 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.77])
 by mx.groups.io with SMTP id smtpd.web11.1554.1676657814440134457
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 10:16:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QQYZ/Aye;
 spf=pass (domain: siemens.com, ip: 40.107.8.77, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLDEuuYi/jMFbUsr7ZiaBywet0l9YPoZUmkAihN8Zh4aO1nyQtkqX61RL3ARMi4SNFukwV3V8JRD9bOFPV6bfzq4u4VWH1Bvz8czlzYZDGqF8+tnf5iC99byzOgptqFr7JZrk2mkDUbNrBpG7PPcfN7eEqTvZwGpvjurCYQFbRe0aWbpKEBa6bmaM1JevCxjIb1jmHqU0Gkl3UyRywf3fF+0ozPH+m3ObQtlUYA6MajalrLQHcU9HDneOMBlCuts+M4/vzOe0bdAtppLc2uxd2WFk9NgKjP6RJNsYGUtxl5meuTXgLhcZerEdb7j9jZLL0aWkPDBPIsgyJTW8iE32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzYB6ASw6ftka4op8fANisTFcsDR4DwS8vN7aPKqy/w=;
 b=g+PcqrnNainbKHNKgYIe+BcGv5VlJdi5JpPooVq71tAwRhtqiFeGx/+BDN3xCsXYaWtuY3WVBoIU+nciX/aY2AkeLqFrRuL7PXODcfSXmISHIrNl/gc3JUKjFGfQEoaPeQRXqC2y2eidaQ9Q9h7ouJ2HzlLaYr+5lO1xre5e+WWVXJy1L4rJ86YejtpTYzxHMVhjeHWy00bFWROfPPF/z2srcH41JkpSWqejILf0HxHGOium+Q91EiU1YzoCQ8BMc5IO4wV1ma7jge/6GPKheglUSIv+rCuOFsriqOKJhw6aOIKHN57NHpqSRTkOtOzLjDSQh2ZLPlWYpUVKAC+tyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzYB6ASw6ftka4op8fANisTFcsDR4DwS8vN7aPKqy/w=;
 b=QQYZ/AyeNljpwGVAWq0qI2Wqkjuc1Ka7lWjpbT/4jfORJQb/DZF2FR9ryzRgp17yyphFGPAX0X8KGkUaTwoWTNpj5hYU+7Ea8b7/lgx+BXemgH2hRTl63TaS9a8aG4+NxD5tx1m5odN1g/4fLY/2yv+ru8dznaJg3tbEhwltWhQbitQBQ8ATkJgRu0e/NpkHxf8dEulgzr+ERWrHZ4YmZGip/VHzeRUxeVlexhIewvJJiBoH4OZVi99lT/gYPS/3gZ82SrYXgNXYe3Lm/ozdFPSQaTWVddXNYcmOERuIBax2FWD7svJJsuv+lWMcwZFijDTiYr4jY4y4GqJ5JJdBVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS4PR10MB5546.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 18:16:51 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94%5]) with mapi id 15.20.6111.015; Fri, 17 Feb 2023
 18:16:51 +0000
Message-ID: <4dc52776-be5a-00ef-a7d2-6a7522f8df7c@siemens.com>
Date: Fri, 17 Feb 2023 19:16:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [cip-dev][isar-cip-core][PATCH 3/3] .gitlabci: add riscv64
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20230217152556.516948-1-Quirin.Gylstorff@siemens.com>
 <20230217152556.516948-4-Quirin.Gylstorff@siemens.com>
 <86fa2631-b3d2-a667-2aee-a23f1f8f92d0@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <86fa2631-b3d2-a667-2aee-a23f1f8f92d0@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::13) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS4PR10MB5546:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df946c9-cdc6-48c3-811e-08db111323d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3MKuPsCiYe2p0kBYIVIimdcE+f+jdrq61qwAMd+hxqIdl2XlCa8zNutTKP3taGCZZSdQcWD90wy6yNS6kIs7dipB769bHaWB2RFGdD5W2QE8g+nxtParNzOXSMhLAWc3SKJ0qMlCs+j/Q2chJ9/Hx9DpasRwSdWnzX/qLRPiKw34xxqqZAJQ9GsWvJLYl/6lAJP4RDbCXWSWua4t9jSt6wey4xttMysE3Ip+u2L0/8ulB/Go2MRyLSh6rAwMMk4mrhpi0QL0wSnV5OfU7x/2IL0kn0F81P4fggho/IJPxEvvbERAKJXUwGUKAaf1xfmdlYgR8fJxaEoY5qKSnH9cVbHcTnP0hUyPtlAok2enkRpiBol1GgipDOK3npYpRUVlfDlbUjoVyey/XHw6POLghTcaSWNJwpqgOuGAq3TGruW4ozp7PmlliomG+wJ+8cfzlkfl9r+4jbeN4Hnlrh8Q4UcLOjIQ2ZYu4Nwz6p17BxZMQXU169hjGovPJJ3LIRG39hkDlcQCc2PW/OzKzp71+7hMyKK9wyPK23T4Pt/9rDu5DH9tRlNfnxGefdXPdnKYomdLvEfY/plR8N7GXbn5MzNQfoeXQjiWsf7qII4P2jppUvZSUcaLpH5UkRst0bRRtP5rLcWc2pfwWdigmiFceMd1fGujH7jWMmVhY5N/gVQYvozMtLRuZMpE9F4yENs7JTY4ZgJghwt4F+EV4xgboeox16rOlV5UDZuGMfsumwo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199018)(86362001)(82960400001)(2906002)(41300700001)(8676002)(38100700002)(8936002)(5660300002)(66476007)(66556008)(31686004)(66946007)(316002)(36756003)(2616005)(6666004)(31696002)(53546011)(6486002)(186003)(478600001)(6506007)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QjEzRkFmdHdkZm9BbGlTT2pIeURweUJnMDVXeHNjWVdFRDR5a1ZsZXFwOGRs?=
 =?utf-8?B?Vm1DNlpHZVQyZG12VlFaenR6Slo3N0tadUtNdERoSk1OMk40bE1LY1ZLVzI4?=
 =?utf-8?B?NTFyU1pGb1pjK0EwMGJkUU8rbW5wT1U0bXZJcU5oeDQxVWJSQ1NlVlJwakkx?=
 =?utf-8?B?alNFdmk1VmVNaVRVR25Cb3A5OE5ZQVd1Q3JJTEF0dzhnUzFiZHZkT2tiQUY4?=
 =?utf-8?B?RmlQVS9IZTBYa3pBd3p4cWp6OUsyQ2diNDRZYXhXd0pEQlRQT0JpNVJOZFpP?=
 =?utf-8?B?aHA1YWhLQnFaU2RvZXk1UExBWG1sNnZnLzdPQzdiZkdldEdYTUlab1hqMnl0?=
 =?utf-8?B?ZlVuRThSUk96QlVoUWhZMWhiYVZxVTJxTzBmTWdoRjhWVGZCaUFyUUR3c0kx?=
 =?utf-8?B?VXRleUk4L3VHT1RrWUFNbDkzTGhJNVhPcFRXNCs1Z0NMNFZmQnNVSFRHb3RQ?=
 =?utf-8?B?Ym1lNXI4TmQzdjhpYW1meWxydFhONm1tT1V1R2lRSWd6NDJWS05lS0dqeUNi?=
 =?utf-8?B?MVBoRGlPL005RzhpZTN3YnlrYm92T040aW5SU3NOOVZaWVNFZ3AwZXVJZ2Y1?=
 =?utf-8?B?Y3Z6OFVicHJ1OTRxR014R3BhM2VXV1ZJTklnZ2tZaVY4SU1OZnJnU2hHa3A1?=
 =?utf-8?B?KytwcnRLdXVqZWZqMFhFalIycVNqNGp1WTY0TE5QN2N1TkloaHY4OFNmNkZC?=
 =?utf-8?B?ZE84dzE5WnlmTXJrSXlybzlSaTVseFUyMjYrOGRscVpGV005REdqN3hvNmpx?=
 =?utf-8?B?aERoWlhrUnY2SVNyOVJBQTBXK2dvbDlQY1V1Z1pzN3FoRVdWbmh4ZHBxWUxk?=
 =?utf-8?B?OEhrTGFTY3hSNVFoUk1DUng5TE5TTDBPbWdpVTE4eVMyZDlzVHlqcmlsdnZJ?=
 =?utf-8?B?WGFXT2Z1amk2SURuTFgya2phR28zaXBaNkJQc0ZzZDJlcXNKbzNLZ1JzcUgr?=
 =?utf-8?B?WVB2Qy95eDdleG1jWWI4WXQ1bWRNR01xN2V2MnMwWUhob1BocHZFdGFLVHVO?=
 =?utf-8?B?d3NDdmJUWUR5OHhndmZZbE9XRHdpeloyMXBMdGtoUGFsbzBxUWlESWtZRzVY?=
 =?utf-8?B?UkpGSk1yU1FhT1VxZEdQOWFyTW0zQmk0WENFVXczQzFPSWduRks3QnlsMld5?=
 =?utf-8?B?SHgxWGNJd3ZtbldTcUV1Wld1Z2hyekdrUFlNbkUwSFBWWnJFVDRTbnplUXNS?=
 =?utf-8?B?VUVZQk9QaW9NVTZrbjdTcGNtRDdsNHVaRFo1YkFwUFNabkFhb1gvS2pRWnNZ?=
 =?utf-8?B?RnZycTJuWHdRYW9OQndxb1ZoOGhFZmpZWmlnaGN6Z2hRSXZwY3dQN21uY1hO?=
 =?utf-8?B?cUlMU2JWVElmdFJjOGdWYmMyQk1pakJteFM5alY5QjQ4UGlsd01lRU1hT3Bt?=
 =?utf-8?B?eTFxanBwalFrN3gvZDdYL2RzRmJSeEJzNGcvRC9mbnlndndNNU1rZitSbnl0?=
 =?utf-8?B?VnQ4M3hTaFpTa0dWSDZmbjQ4UTFHZ21ldU4rRk4xc3d1SmJHK3c4ZlExTGIw?=
 =?utf-8?B?TXM4ODhLaklkRE8vZXI3K1ZieEdGcEZIVlcrcXdsOEJza096cUxhV0JyRTdl?=
 =?utf-8?B?TUxmSGtzU3dpaUcwSWZFc3lCOHBGVlIyUnF0YVVhak5NK1Fxd3JMN1JsV09k?=
 =?utf-8?B?K1FhS3RiK29XcVZnby9sVlY0eE5vTFNneXY5YjIrVGNyeC8zNmNSMWhtMHJV?=
 =?utf-8?B?MzcrZ05xc0JXdHR6Smd5dTRoOUYydEdNY0FvY2hIYWlaMEdnRXlKbWZKYUJU?=
 =?utf-8?B?QjI5Z2IrNXo3QU40ejk5cW5yaTQ0dEdyVHduWkJhM3RoVmdrTVFjVVdiQTNq?=
 =?utf-8?B?Qno3YXRRaDBHa3pldWxqc3dXYk1oQkl6R1QyZ2pycXBWL1RtanZYempDTmFn?=
 =?utf-8?B?UHphTHBxUGR0eWxzbnhEZzlpRlVnaDFPbjRBOW8zdFd0NlJBdmZacFZaak00?=
 =?utf-8?B?UTJIRGNFRGJMT250SUZWelhkcHU0d3EwOWE5WndBeDgvVmtXWllieFkya2hZ?=
 =?utf-8?B?UTM0R0hyQUxpM1BXbFUrQkpJNGVDd21Pa09ldUJ5TklMZmpPRk1JSThwemZw?=
 =?utf-8?B?ajJGRHk5bUlQcnRhZXMrTlhzcVk0RjJGaHpibkZrMTU2SE8wM2N3VVFPYnFo?=
 =?utf-8?B?S2dPUGFyRERPRWZiVDYrdFVHTU54TEsxampqSC9BUi94Z1M4Wi85VEd0bExS?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df946c9-cdc6-48c3-811e-08db111323d2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 18:16:50.7668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbqJs9q2z8tIdxjzLPEfDPDRSDvH72rer1yiiqCu2tmEGZrdm/SJRTY4UoXfo5H1NN2usfsNjGVGX4a7NdwzoE5nmvyfcKwe9oT6sf5Bp1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5546
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 18:17:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10736



On 2/17/23 16:33, Jan Kiszka wrote:
> On 17.02.23 16:25, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .gitlab-ci.yml | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 311702f..95adad5 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -38,6 +38,7 @@ default:
>>       - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
>>       - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
>>       - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
>> +    - if [ "${release}" = "sid-ports" ]; then base_yaml="${base_yaml}:kas/opt/sid-ports.yml"; fi
>>       - echo "Building ${base_yaml}"
>>       - kas build ${base_yaml}
>>       - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
>> @@ -326,3 +327,17 @@ build:qemu-amd64-secure-boot-bookworm:
>>       use_rt: disable
>>       wic_targz: disable
>>       deploy: disable
>> +
>> +# riscV
>> +
>> +build:qemu-risv64:
>> +  extends:
>> +    - .build_base
>> +  variables:
>> +    base_yaml: "kas-cip.yml:kas/board/${target}.yml"
>> +    release: sid-ports
>> +    target: qemu-riscv64
>> +    use_rt: disable
>> +    wic_targz: disable
>> +    deploy: disable
>> +
> 
> This will run against snapshot.d.o, and I'm concerned about both
> duration and stability of such runs. That's why I left if off so far.
> 
I would like to have a build for riscv64. We could add something like this:

   rules:
     - changes:
       - conf/machine/qemu-riscv64.conf
       - conf/distro/*sid*

Quirin

> Jan
> 

