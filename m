Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C2DC433F5
	for <webhook@archiver.kernel.org>; Fri,  7 Jan 2022 13:47:03 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.57])
 by mx.groups.io with SMTP id smtpd.web12.6441.1641563220362592857
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jan 2022 05:47:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CWs1RKFV;
 spf=pass (domain: siemens.com, ip: 40.107.21.57,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZf6ZLJZtieAUTWPSDsTc7mVrMwv38b5x1iCInpJq6vNALtYELBnByY+iUXM8wtuCuSoqny5HqNBZRJuMKI/kQk/5/DvmXpscUe1De7zzPn94aTGHetaGp6XP2ZD9TLtlp6A5wbkCr/hdgu+H1Jh450obe+tQZuwhYPuhq8OYb1URDL88L8BpT/rZOUCYTV82viXrhEvvQ9ewYIM2I1tPCR9Xdvn70/teYe0y2d7DEYVlsI0XZKxcy9BgRZzxleifDROKcnytEejOEQa3HL/V4xXGqdPpCA1cJ4ZBRnn+yp2H3fUH0fSJa6AdMkaBmr2ANhslnbXzs83KVnFezSLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdLa3CPpJ1e39IrQ6MaOjRULnaS7aM97/z1+bUccx4w=;
 b=aAwwKysB4x6QFD5DqGAc2NoTyOHjA74V22tW2ZWjXdBNTyQkm23RA8wE4EpDmrI0bCI6PqZVoM+quBWu/5NyMsEm7Ezqdw7/WWBbBY1So4WBjE8hD5oJrNSkmXPJ1ZOpSenWd8EEhwrSyoz0fuexYL1NbWrEuAV3EVFjbNSPODTCN2qY54qxhWafH5u7R6CIOQxqlr4t64Yy6TrXn/U00vidu0pqBPv0+U9Rb8v2jbGAUpO/R67kHVUoM6SGHdDhSZiEQPUoMrrvHR5OZB4dU+qq2Hxhn2X9xMclFQQ3rO9uxZRFxylqdDkKX5my8/Uu50zfgN5CWYsXmqIfR8fq1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=miraclelinux.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdLa3CPpJ1e39IrQ6MaOjRULnaS7aM97/z1+bUccx4w=;
 b=CWs1RKFVZRf3Gaz+jAaNrgmQTk9FV9OGLRRXJ0m5K7Oe0C4MpfSHtIoSGEc81W+N2XHy61kaT/wD+7KZQSG3mOAidf/YbL8Ww4pM2Hxii6WYWAwRfL20vleQYIx/ZlBSCKmvq/7Kk02j9ZF2aFKGjoj8YFm5V48sVlkFAwKFQYA8wJF0oyVAe6UXAF5rW5dUFy5/gFxllHtuNp2Hqm/ViFpwU7It8fQPV8SU5xuJ9YTPFugCUFywpjh9WU9zJRTCbgmnCAKXB14gN4if7hMECovRxa0pxjZ0pbGnqHWEmIZox8bnyUEZRRK98SGFzfDhQzih/uAzxLI8HgUKBfFGdQ==
Received: from SV0P279CA0016.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:11::21)
 by AM0PR10MB3123.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 13:46:50 +0000
Received: from HE1EUR01FT044.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:11:cafe::93) by SV0P279CA0016.outlook.office365.com
 (2603:10a6:f10:11::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Fri, 7 Jan 2022 13:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT044.mail.protection.outlook.com (10.152.0.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Fri, 7 Jan 2022 13:46:50 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 7 Jan 2022 14:46:49 +0100
Received: from [167.87.0.113] (167.87.0.113) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 7 Jan
 2022 14:46:49 +0100
Message-ID: <4dc49005-ec1a-3631-d011-c6e1c6de972d@siemens.com>
Date: Fri, 7 Jan 2022 14:46:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [isar-cip-core][PATCH 4/4] enable cip-core-image-kernelci
Content-Language: en-US
To: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
CC: <cip-dev@lists.cip-project.org>
References: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
 <20220106111614.218823-5-alice.ferrazzi@miraclelinux.com>
 <c8e9fcb9-eded-90fb-98cc-f766a7a9fbf3@siemens.com>
 <CANgtXuMOv+rJYyEMC0CgZsap0YETmAt30S5ia5x6+W+ppKKRoQ@mail.gmail.com>
 <65c523ba-cfaa-877c-e36c-1f0a6eec4602@siemens.com>
 <CANgtXuNUWt4ez6O5pgeJid3avitUq=fiOnVQk_+opA+Q-aTf+A@mail.gmail.com>
 <1a4f08d4-9a1e-5441-0a02-735618294e8f@siemens.com>
 <CANgtXuMojGBivk3E6aEhVwOC1W0SM2o2HpKzM=nHxPHDBEx_MQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <CANgtXuMojGBivk3E6aEhVwOC1W0SM2o2HpKzM=nHxPHDBEx_MQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.113]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2880be1a-dbf2-4d69-3a1e-08d9d1e42805
X-MS-TrafficTypeDiagnostic: AM0PR10MB3123:EE_
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB3123E7E76A433E932496E973954D9@AM0PR10MB3123.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RkNIR2piMU1rK3pKT3BUR1kvWHB6dHFUNkdON3JHQ0hMdi92Z3ZzQlNCa1Fv?=
 =?utf-8?B?UTE2TkpnZFlUbFd1S0hTM0NVeEFwMVI5QktlZlg0Tk5XRjRBQUhGVXdzeFk3?=
 =?utf-8?B?VmtKNEpOZFlwTDJBN25JRXdYMWZTS3ExRnN4NzA3NTdrczJFNlBJcXlpUkdI?=
 =?utf-8?B?aGhnN01QaXg2bVVNZjRpRzRRR0FpOExob05QZ3NkMzgwVERXWDN5UTZqTXhY?=
 =?utf-8?B?V0ZjdHRMTGxjeTFDK0c5cXBDN3lPY3BtN0YrOE9jaHVaZVg2SFh0M1FQT1Jy?=
 =?utf-8?B?ZkhqckpwWmJOdHczaXhiWXZoRVltMExZa24vbGtOSXVHY094blFmckpvdEZ3?=
 =?utf-8?B?d3dTU0RKVXZmMVVzR0FWWDNNZzNkaGNvSE44bkJKK3MvTlZrOCtIeG9rUW81?=
 =?utf-8?B?YWZ2MWtSdE01b295VzdiRUJiaFBrRjJMNFRiZWNwNUpxRG5yVEN0UnhSejND?=
 =?utf-8?B?YWFqT0NMYmg1dXRJT0tJVmZEeStYckpFczdBamwyT3ZkRkJsWTNuek52KzA1?=
 =?utf-8?B?U0h0aThFbHpBYUFSbGZyczJydkZVWUYxYm9ZQ0pycWFuQlNBczR5TUVMTVJh?=
 =?utf-8?B?MnZKUkoxeWhMTUNWUTZ6ck1aOVNWeTArUks2WUtscnJ0NTdUNGQ4Smx5M3VC?=
 =?utf-8?B?TVdRbVhuYndyS3lpTWlEb05hNDdiVzY3YzVyMWNCQ01td3hrbW5RZXRSRDhr?=
 =?utf-8?B?OGRvYk1TbW1OdmFjUHk2eHc0Q3Bnb01odk5UZWxIVEJWVDQ5czQ3UW03RkNS?=
 =?utf-8?B?YXIyWmtHOGFBNjk3K3FKMmxQeWdXNlUxakhHWnJxSUVOM1B2c1RiUktkVnd1?=
 =?utf-8?B?RlF5TENMOHU4czZlc2FwZ0ZOTXRuQmU5MHpBS0dqWmFMc2pmamNSbGxYaEsx?=
 =?utf-8?B?U016cG1RNTMwVnBjYXpQQUZzMUpRak50cEdWc2RtRHhIakY5T25mU2hLWnU1?=
 =?utf-8?B?U1VyMmhXY01uajhiRkRYRjNRd1lMQ2Q3M3B1S1FmeTNUS05XTWw2a0hER09r?=
 =?utf-8?B?ZGZobEI1Ung0R0FVdVNCbThxSGNoMW85bmNhRE9TdG1LUmR0YzRmQ0x0Qk44?=
 =?utf-8?B?bkZkVXJxNFdlamRuUzJKU05WbWpoVDdGMW5wOE9tUmI4K0xNY3hJTmZGVnBN?=
 =?utf-8?B?VUh6TFZiVkNLVzR0K3ZPcEZRZkZvZTR1Q2g3cTlCUGFmL1JuZjhrWSt0L1VN?=
 =?utf-8?B?MGRyL1Jqa2lCWnJNRUpubDJIdUFDOWp5aURlaWttanIyRndJMGt1ZG5UdlZC?=
 =?utf-8?B?OGpNejNYeG9ZSm94VWRJZDViK0JIdEFYb2lMSWxjbklFNWdpQXZ3M0tISk9C?=
 =?utf-8?Q?rIpVii0uqBWUY=3D?=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(81166007)(2906002)(5660300002)(82310400004)(956004)(31686004)(336012)(86362001)(53546011)(2616005)(8676002)(47076005)(966005)(16576012)(316002)(44832011)(40460700001)(36756003)(36860700001)(70586007)(70206006)(82960400001)(508600001)(6706004)(16526019)(83380400001)(31696002)(356005)(186003)(26005)(6916009)(8936002)(4326008)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 13:46:50.3012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2880be1a-dbf2-4d69-3a1e-08d9d1e42805
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT044.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3123
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jan 2022 13:47:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7348

On 07.01.22 14:40, Alice Ferrazzi wrote:
> On Fri, Jan 7, 2022 at 8:18 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 07.01.22 11:23, Alice Ferrazzi wrote:
>>> On Fri, Jan 7, 2022 at 7:07 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 07.01.22 11:02, Alice Ferrazzi wrote:
>>>>> On Thu, Jan 6, 2022 at 11:12 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>>
>>>>>> On 06.01.22 12:16, Alice Ferrazzi wrote:
>>>>>>> enable CIP core image KernelCI to be built with gitlab pipeline
>>>>>>> and uploaded to the KernelCI storage using KernelCI API.
>>>>>>> enable cip-core-image-kernelci to be built for amd64, arm and arm64.
>>>>>>>
>>>>>>> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
>>>>>>> ---
>>>>>>>  .gitlab-ci.yml | 40 +++++++++++++++++++++++++++++++++++++++-
>>>>>>>  1 file changed, 39 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>>>>>> index e7db8c1..784343b 100644
>>>>>>> --- a/.gitlab-ci.yml
>>>>>>> +++ b/.gitlab-ci.yml
>>>>>>> @@ -9,6 +9,7 @@ variables:
>>>>>>>    targz: disable
>>>>>>>    dtb: none
>>>>>>>    deploy: enable
>>>>>>> +  deploy_kernelci: disable
>>>>>>>
>>>>>>>  stages:
>>>>>>>    - build
>>>>>>> @@ -37,7 +38,8 @@ default:
>>>>>>>      - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi;
>>>>>>>      - echo "Building ${base_yaml}"
>>>>>>>      - kas build ${base_yaml}
>>>>>>> -    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
>>>>>>> +    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi;
>>>>>>> +    - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
>>>>>>
>>>>>> Does gitlab-ci forces us to add that closing ; to the last-but-one
>>>>>> command? If so, better add it to the new from the beginning.
>>>>>>
>>>>>
>>>>> I'm just following the syntax that is already there.
>>>>> The gitlab-ci.yml file syntax preceding my commit is also doing same
>>>>> thing of adding that closing ; to the last-but-one command.
>>>>> You can check it here
>>>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/.gitlab-ci.yml#L40
>>>>>
>>>>
>>>> Then, if the closing semicolon is needed, add it to the new line as well
>>>> to avoid having to touch that when adding the next one.
>>>
>>> sorry I'm not understanding what you want me to do.
>>> The closing semicolon is needed to the last-but-one command.
>>> Adding it to the last command break the script.
>>>
>>
>> Are you really sure about the closing semicolon?
>>
>> https://gitlab.com/jan-kiszka/ci-test/-/jobs/1951623081
>> https://gitlab.com/jan-kiszka/ci-test/-/blob/semicolon/.gitlab-ci.yml
> 
> you are right. I just checked my pipeline backlog and found that some
> months ago,
> I just checked for both without ; and not the case of both having it.
> Still we are changing the syntax already present and used.
> is it ok to use a new syntax? if is ok I can send a revision.
> 

I've sent a patch that removes the superfluous semicolons, you were on
CC. Just rebase on top and follow that new pattern.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

