Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B94C433EF
	for <webhook@archiver.kernel.org>; Fri,  7 Jan 2022 11:18:45 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.79])
 by mx.groups.io with SMTP id smtpd.web09.5335.1641554324768724311
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jan 2022 03:18:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=H2yyfDjs;
 spf=pass (domain: siemens.com, ip: 40.107.8.79,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rq/UH+QW6ViNfgDk77GV7IevtxMBgZr9kO9tUPnfypLv7v0V/YcnK78wDeCG8dl2Cr5C0ZUq9gO2WCT47Pb8la0h7ZAdnZp2xsZBaDn1MCiTm1YGekI9itAXGRIVHk5GIrZ1MA+puWXuHS+3K4mP/yO/XpusUtJCGXjjj4jgDUvDxPXeVFLMGdMBhq+7XCU3d1F0rDbGx06D0Dpy1JZI6DuneMqJ7OLS+ePBr8hcctLVNHC8zjSpzdhbnH7/Q7hY3yUGjGZNFmMZAOvu3S4z781/r8LQyAHyhhcNh+5p8ZlAQxmSHUIG7fGbJ1x9Pm6eOryl/0G7lFV2OrvoFXeX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3PatTehAv7K/KlvfBC6GPZJOf5J+9qunkWSPF1G7xY=;
 b=j/lHsknJrWLeiUqNMXRQ6wh5g5zaP/7IzUzI1SIzLIztHXkov1ZneR9KpIfBkmcOA1oCcpua0IpG+F91vsjDRQK8HMsaWqWasMVlHLrSOYGc6nzPCpSlvz8lPEYzskFoFxfZ24LoBlwr2naCBMAwxpkZ1hrh+JkICS6enQgbPfd7CQyYtYwvADmMPAPUyEF44pVgin8NpibfI6ARpzry3jBe2yB11AICNCeeDEfRVViWuQgeVOtyz04jqfVGaXEDms7NWaRyfbDM1iaO7pFKNN2jVWaT/+aHynhnmbiZTEvNPUpWHaj75XAqqST43mV6LtK9Nk7awfqjoumHc1MJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=miraclelinux.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3PatTehAv7K/KlvfBC6GPZJOf5J+9qunkWSPF1G7xY=;
 b=H2yyfDjsMrGkh2LaA3ES/NNyh3TN31nUHqkl3DynGr6VvLE2OI1Pc6Ae4tbXyosgMVm84i63y6x+MHXycV8VmgIFT1T2KpR3LCoHwbzeSINzvby1HVuOVqbc0Mevw4l5m0z+R2HAkii3h9z6VTb9DblGbenUQTi/qdGIiHlcNcSVlPWmeFM145jQzdfMx+dzCnU91z7fhDMZy1lsY263wY8Bz9EMrClmGvziU0p3HuCEWVpIhz6wELisP0hbQnuG61JQHVCgA9euDZ66Mf/m08TuQGHpbE4szhdtaBXVlHOD5iOqVZeGv1J590+apRlgTB5wbhV6UMcJFSvM57f0ZQ==
Received: from OL1P279CA0007.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::12)
 by AM7PR10MB3779.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:178::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 11:18:42 +0000
Received: from HE1EUR01FT038.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::fb) by OL1P279CA0007.outlook.office365.com
 (2603:10a6:e10:12::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Fri, 7 Jan 2022 11:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT038.mail.protection.outlook.com (10.152.1.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Fri, 7 Jan 2022 11:18:41 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 7 Jan 2022 12:18:41 +0100
Received: from [167.87.0.113] (167.87.0.113) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 7 Jan
 2022 12:18:40 +0100
Message-ID: <1a4f08d4-9a1e-5441-0a02-735618294e8f@siemens.com>
Date: Fri, 7 Jan 2022 12:18:40 +0100
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
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <CANgtXuNUWt4ez6O5pgeJid3avitUq=fiOnVQk_+opA+Q-aTf+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.113]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b653d8f2-9716-428e-a062-08d9d1cf75f7
X-MS-TrafficTypeDiagnostic: AM7PR10MB3779:EE_
X-Microsoft-Antispam-PRVS: 
	<AM7PR10MB3779024748DAAE3DA3177A02954D9@AM7PR10MB3779.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VktLTmM3d2VGcEwxWkFQeFRYbFRON0FTd3ZVS2kxM3JWR05Ub2ZLWkF0SkdD?=
 =?utf-8?B?SCtzTlhIcG4zVEhkSlhJVkhzL2NuNUhEYy9tOGo1MWdpWlFTOUxCM1FneSth?=
 =?utf-8?B?dGd6S1FEVlpTcnVHZDRoTUtPNWo1akRpcDhjNFVCUlVBVkpsODNDMWl3ZG9y?=
 =?utf-8?B?M2YvM1hVeGpsc21lTDVkTDlXVC9OVnlWSVdjTWdLc0tUSTUrVDV0SWFJZlRF?=
 =?utf-8?B?elJSVHR2Mm5nRTlPdnVBaDNQSlN1dDJzUDJkazN1OXBVaTJKM0NjVzZuTkE4?=
 =?utf-8?B?Wms2Um8vYWRIVTZBS3FjRXVxNlcwT1JzMVk5Slh5cUtoWFVLT1B6alhtU281?=
 =?utf-8?B?U1hvQlFpVjd6SUpzdzRJek9lemVxQXdmNFFPSE54MmQ3SHJ6STZML0dtOFR5?=
 =?utf-8?B?V002N0VLN05oTnY4QXIxNlo3NVpVeW92VXVPbGZ5WDlLQTVpUzRHKzdycm9s?=
 =?utf-8?B?TG1qT1YrcklPd2pjUlg4cGxVcGYyN0haZUVnaTFSc2loWEhMZ1Q1NEl4SjBu?=
 =?utf-8?B?ak95U0RXV2NiYm5JWVBiem85bXFIKzZ3YUtLZ3gxSUFBTis4QktDK0h6LzRL?=
 =?utf-8?B?bUg1SWU2eEduMHFoUGU2Y0ZLMllrVE1FOEFhY0VYZDNkbVdVWll3ZTMwcWM5?=
 =?utf-8?B?eFNKdFBkdGtJMmRvQ0M0Njc4RGJnTStneGxWZlgxcDBSMHMybDNMeExmYzZP?=
 =?utf-8?B?U3IydzZOTHhjVXc3RmJhU1IwTllJTE9vdnFaeGc1MWhKNG5ncU82VWJ5YlRU?=
 =?utf-8?B?cWZ3OVhuMWk2L0ZMQnZOOWV2ODNjS0h6M2ZQVWU3V1dEMlA2RzNEc3dSQitO?=
 =?utf-8?B?Y0laYlY5UlZBcTA2ZnJ0eFFrdzlHdVhORE1LbVNoNkxHQ01vaGg3dnllNW9J?=
 =?utf-8?B?RENuRTMzenNGTFo4cllzSzY3S1FENHVYaFpjOERWOW1XcEcrdGVyMmc2bDFk?=
 =?utf-8?B?Q0hXOHJha21rYjg3U1NvY1RmU2dnMkxGOVVxWGlHTERuNkZHUW53YVUva2Jj?=
 =?utf-8?B?bXZFajM5MTEraFlnQjhtVkhVVm90YVprd21vbTIwQ0ZMVHhGdGl6UUtjMEk5?=
 =?utf-8?B?cUduVW5WVStYSVRCMC93bkhmSjB1QmpXODdSYXBlcmdhTmNrUkI0UHJMWFFF?=
 =?utf-8?B?ZUZ2b0g2YlBSZi9MOHdnay94d0NwQzdJVDNaanFPM3d6N2xxMEVvZjFLd0Vk?=
 =?utf-8?B?VnBTVVhueHVZQ0g4T1p3SjZ4cHNLcU5lTnNlQklORlp6WWJranBJRC90Sk5G?=
 =?utf-8?B?MW56NlJyclJpcm5JYTNpMlJHem0ycGRMS3lmOXBkNjhCSm5vRzNXS2NxYzNO?=
 =?utf-8?Q?ditd6PE/3jD5I=3D?=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(40470700002)(36840700001)(53546011)(316002)(2616005)(4326008)(36756003)(31686004)(83380400001)(2906002)(86362001)(16576012)(70586007)(40460700001)(5660300002)(70206006)(356005)(81166007)(82310400004)(966005)(47076005)(16526019)(6706004)(186003)(36860700001)(508600001)(82960400001)(336012)(8936002)(31696002)(956004)(8676002)(26005)(6916009)(44832011)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 11:18:41.6452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b653d8f2-9716-428e-a062-08d9d1cf75f7
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT038.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3779
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jan 2022 11:18:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7345

On 07.01.22 11:23, Alice Ferrazzi wrote:
> On Fri, Jan 7, 2022 at 7:07 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 07.01.22 11:02, Alice Ferrazzi wrote:
>>> On Thu, Jan 6, 2022 at 11:12 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 06.01.22 12:16, Alice Ferrazzi wrote:
>>>>> enable CIP core image KernelCI to be built with gitlab pipeline
>>>>> and uploaded to the KernelCI storage using KernelCI API.
>>>>> enable cip-core-image-kernelci to be built for amd64, arm and arm64.
>>>>>
>>>>> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
>>>>> ---
>>>>>  .gitlab-ci.yml | 40 +++++++++++++++++++++++++++++++++++++++-
>>>>>  1 file changed, 39 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>>>> index e7db8c1..784343b 100644
>>>>> --- a/.gitlab-ci.yml
>>>>> +++ b/.gitlab-ci.yml
>>>>> @@ -9,6 +9,7 @@ variables:
>>>>>    targz: disable
>>>>>    dtb: none
>>>>>    deploy: enable
>>>>> +  deploy_kernelci: disable
>>>>>
>>>>>  stages:
>>>>>    - build
>>>>> @@ -37,7 +38,8 @@ default:
>>>>>      - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi;
>>>>>      - echo "Building ${base_yaml}"
>>>>>      - kas build ${base_yaml}
>>>>> -    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
>>>>> +    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi;
>>>>> +    - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
>>>>
>>>> Does gitlab-ci forces us to add that closing ; to the last-but-one
>>>> command? If so, better add it to the new from the beginning.
>>>>
>>>
>>> I'm just following the syntax that is already there.
>>> The gitlab-ci.yml file syntax preceding my commit is also doing same
>>> thing of adding that closing ; to the last-but-one command.
>>> You can check it here
>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/.gitlab-ci.yml#L40
>>>
>>
>> Then, if the closing semicolon is needed, add it to the new line as well
>> to avoid having to touch that when adding the next one.
> 
> sorry I'm not understanding what you want me to do.
> The closing semicolon is needed to the last-but-one command.
> Adding it to the last command break the script.
> 

Are you really sure about the closing semicolon?

https://gitlab.com/jan-kiszka/ci-test/-/jobs/1951623081
https://gitlab.com/jan-kiszka/ci-test/-/blob/semicolon/.gitlab-ci.yml

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

