Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345E0C433F5
	for <webhook@archiver.kernel.org>; Fri,  7 Jan 2022 10:07:54 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.67])
 by mx.groups.io with SMTP id smtpd.web11.4654.1641550072417866940
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jan 2022 02:07:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iACVBarB;
 spf=pass (domain: siemens.com, ip: 40.107.21.67,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNF8AbZHuo7UrxD8dRLR2zkbPvLSokcYsXDe3+ocotI+HSoS/PmVznZabCkYCBsJxlUKA/ePBkMIHZ71VBsPDuJUc+jcImP2GSqf3x2IP92+4zKTrn66tckBc1q/84CFkoVxYLo1LbXYcr3TPf0qhVJtXD0LWQAFq8pHGYSy1cWmwD2y+Sxe+jDzuioZ9UUBVmnWv2fK0qYOGKfyAdueuIogwytBerr47rvKBVKSDXpdGwocExIYeD3FFuOcD1185PFB7Q/kC6ggijoV00hNTug8gcFfsF5mSF3QmayGj3JifaOZTYYWvoEVNcVq6+7vjpTPIa532zsB/KCXX6cJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9/58e0E3JPLOdPvJO5IfnQT8wbeCzxriX2sDYaKpIs=;
 b=NkFbuuzLDlIcZK1EMSClyquLBX1NeWk6VLr6xHnWmmKouzDgETLzirenYNRhEoVixSXvYjE3Cb55Oep8z+cjQE2Ffpw/1yHeE4uHbwKi68Dc/EUcjG+mGQxFGZWSk08QTc5cVEDM6Q1ep2W1MQa5KMBoUlm5SdTipkg64daBi9z/di7X1cI3Tc0Sc3oZ9kuDZ3hAfh1dt0HsVeMO84ggPwEfeYcC+oytOwY6VKiuHKpQOExuQJWtkYYdvrpmFhUoVcw2tr9BWu65/33ie71B3U335uiRsWgevlqlQl9YvDbIaI+hL9e33Fu7w33k+WaywvSzFB4/XqT+Cz2YisMdwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=miraclelinux.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9/58e0E3JPLOdPvJO5IfnQT8wbeCzxriX2sDYaKpIs=;
 b=iACVBarB1AHi4Gn644Q4yKnoAVaoWg/N4sWviPCwkL74aK2LnHQS2pu+W5RJ+qYIpjjuFcuge9NfD8NxH1LDHjVtyHjgGK1DnSZc5ISiw7GNCfgTpkoYu9ZGULsDjFQusDFTik/dHtbV+AmH4UczvHlOTB2cM2zXeVm0VDIb5HWSxWbF5NWpyDv7cMsUF4Hd48sjBItzZ20yJfRXZTm+ac817khjce/70DTFhR+x/lqsYCgVvZz3haPO6PNKx1PDFd9D0J3BrRPmooAQdplrBdzD+TQbNmzlVr/+udaYP3gFdGbI5k+y4WAsprHie3sC4VKcHF/7eEa0ffMuRXTPdg==
Received: from DB6PR1001CA0040.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:55::26)
 by DB9PR10MB4410.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:226::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 10:07:49 +0000
Received: from DB5EUR01FT007.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:55:cafe::23) by DB6PR1001CA0040.outlook.office365.com
 (2603:10a6:4:55::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Fri, 7 Jan 2022 10:07:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT007.mail.protection.outlook.com (10.152.4.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Fri, 7 Jan 2022 10:07:49 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 7 Jan 2022 11:07:48 +0100
Received: from [167.87.0.113] (167.87.0.113) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 7 Jan
 2022 11:07:48 +0100
Message-ID: <65c523ba-cfaa-877c-e36c-1f0a6eec4602@siemens.com>
Date: Fri, 7 Jan 2022 11:07:47 +0100
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
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <CANgtXuMOv+rJYyEMC0CgZsap0YETmAt30S5ia5x6+W+ppKKRoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.113]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25b19aa7-8537-44e9-0a1e-08d9d1c58f50
X-MS-TrafficTypeDiagnostic: DB9PR10MB4410:EE_
X-Microsoft-Antispam-PRVS: 
	<DB9PR10MB4410309D46E71551A53CA0F2954D9@DB9PR10MB4410.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6msXsFXihOfXAYIMTWP4iJLi+06KeEbScfD1G2zBb08ND38M8YYYYBtH6VJLwe9m9mdWtYUqiH5ksqnAOgx7Fwe7dFBK37L+cOfqoM+AbJg1cDOA86PiIwc7nIZOSDuwDYdGUb2QnRoKwPoCrGq24bds4f2qpKRrnBPyIV6ZcUc6E7VjqZMZKlU2iz2yrifuIQBMSoYtO5lx3t1t9OtHw7VH1CEg4UsLf7ap8Pk7J0d13o1Whrs1zt2hT2gCWgBGg4ISrEuQidDY1P/FpLRXboSV7gzZDjYVsnbccjDLCt3Vu/lEf420MIV9B8UCwVPe3wBCw3YjOMAcSuMk78L8C7kdw1jrREENVt9meq24DsuICls+NIg0tcypCiMirILKG/7D+0kcZ0RzGHRhyS0LcBTTEwZAQcG2lnRXjsmirEqBbwUsoQDQWt72qRvRG9Vnoqp6pM1bvAmcyuZQLTY5pFMX9SidNnuhSqaKYWhga+UWFQ/xO1nvB5MhJGncHwa8utN1GtiWrV41Wiy59w/kREnvdFI253wZ6sl9XxQIzMO1BiCQeVJ1qk9QPZDPluArbun1hFXEEepfZ3i0pvEr13Vj9TnGOh859YMyBXF2sAIcC/B6uamhSX7U/iAzsq/dozLsCrG5OWn1UIgsNcl9WIov4W4LcNkvrXmQxCJe5W1Jfg0203j8M4c3msClMFfapJ90J2hHMGKef3trixmaDkc8Hw2+9LZlRm3Z+BSY70YzugSxwXMZa6WlhlenOwCuOLl7N/96cIpPTxvt35gFO1TRgmvfWM4T+aCCbUwmGiPieDb+fG+pfJpi+mCLd4LT++h6qGR4OpDP7L4rg+NfuhubAm7vDrA6r8adH64zSskei+58RWhaA0eS4HgwYhl2eFnSxVIcOubaVRfHW86F+8THXpa7kEXJgfJs500usITLcZPLCgY0myNJRImTSyy/
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(8676002)(508600001)(31686004)(8936002)(36756003)(53546011)(2906002)(6706004)(6916009)(44832011)(16526019)(186003)(36860700001)(966005)(2616005)(956004)(70586007)(4326008)(70206006)(40460700001)(5660300002)(82310400004)(316002)(82960400001)(86362001)(26005)(47076005)(336012)(16576012)(31696002)(81166007)(356005)(83380400001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 10:07:49.1992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 25b19aa7-8537-44e9-0a1e-08d9d1c58f50
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT007.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4410
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jan 2022 10:07:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7339

On 07.01.22 11:02, Alice Ferrazzi wrote:
> On Thu, Jan 6, 2022 at 11:12 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 06.01.22 12:16, Alice Ferrazzi wrote:
>>> enable CIP core image KernelCI to be built with gitlab pipeline
>>> and uploaded to the KernelCI storage using KernelCI API.
>>> enable cip-core-image-kernelci to be built for amd64, arm and arm64.
>>>
>>> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
>>> ---
>>>  .gitlab-ci.yml | 40 +++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 39 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>> index e7db8c1..784343b 100644
>>> --- a/.gitlab-ci.yml
>>> +++ b/.gitlab-ci.yml
>>> @@ -9,6 +9,7 @@ variables:
>>>    targz: disable
>>>    dtb: none
>>>    deploy: enable
>>> +  deploy_kernelci: disable
>>>
>>>  stages:
>>>    - build
>>> @@ -37,7 +38,8 @@ default:
>>>      - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi;
>>>      - echo "Building ${base_yaml}"
>>>      - kas build ${base_yaml}
>>> -    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
>>> +    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi;
>>> +    - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
>>
>> Does gitlab-ci forces us to add that closing ; to the last-but-one
>> command? If so, better add it to the new from the beginning.
>>
> 
> I'm just following the syntax that is already there.
> The gitlab-ci.yml file syntax preceding my commit is also doing same
> thing of adding that closing ; to the last-but-one command.
> You can check it here
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/.gitlab-ci.yml#L40
> 

Then, if the closing semicolon is needed, add it to the new line as well
to avoid having to touch that when adding the next one.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

