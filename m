Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D211DC433FE
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 19:36:19 +0000 (UTC)
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (EUR02-HE1-obe.outbound.protection.outlook.com [40.107.1.81])
 by mx.groups.io with SMTP id smtpd.web09.15344.1664912177979731099
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 12:36:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HM7K53cU;
 spf=pass (domain: siemens.com, ip: 40.107.1.81,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRzcC6PX66gXCQQqV99U2z8h8Juas9oMYgARHhI2ItiWhwNH/dzS7WauYPn319Sf5QJmliBN875B7Og2oE/N/pZ+9/H1rI3FY9QeGrX587ZGqWFzazOHzxnP4/dtNvBj4PuL9EOZqckEc2647VnKmpxwtQqBTo/N05JS2tTYcLnB9nAI1le+MDcr2DbVoJhctQ6XVIWxkba9afOGL1fsV3hXHz79mPtbq1XrLET6iwykn9qeTYBF5lnIEP/cMEs+p9o9p5zAnJItZjBg+/Doje/O5PdgiGjkPCacPFO5uIOaTKlCrHbzvWWOx6BAwY3Lo4mrwI9iVO5clsxseATDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbAQlPCQCO+07eIJx6J+ecjGYSJk5+IgcOoBTSM6cUo=;
 b=EpYasb0dZxHDjxP7PHb/aCk5ednbA5PhRrYp9IvWD3azG0g9H8OMrhj79oRyBoOf8vyf9UH1luf0oViCY8iMBqMF767cKP/kTAwuw5+U6WWwP1HM05obyXp0rWnRPqT0JZJywgT0Pu7JR2sQKUkBh1G0zS0vygWS51wgCqzRVW33y9NEfFfQhLpJ+b6/ATt1CT6DG8PSC/RVGNr+MzqQucTQEQxENQCfO05CD/6nYD9aCI4iHY+zFBwkh7bslFPjNBAbSLTgdIG06nfFAhuLiafPzx56X12qHLJMJgggqbsifzQC8ktpCIiAgisCcoUvWThLa9OljmXEzKDSM4AqpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=renesas.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbAQlPCQCO+07eIJx6J+ecjGYSJk5+IgcOoBTSM6cUo=;
 b=HM7K53cUL0WBvQzv6R5jnKne2pkrse4e27zy+Cs4vyTNslAMYYjWHfjIqU1tySPY6kXQRAVcwKmxXGEgG+6nAfedZ4RZZShwtIEvnj2wJaIDzdZGvJt4crKfAeD5MeEDDzYUrOYGJ6AYgA6oJP5FT/SR/JvifVp+srn/iEOZgIIIlhssnQX1fsHYm5hV7ZV3uFq6Do2w5Epon2Cu0kwwi2BazeKNoZVV5Y1hV2zz8Cx8UW4E34uhROSZvwc+7oVonxNE7mwAU9SGd7XziVRwxNdk6ckg3IB+lCYekhCJnlEEhvQB//SKkYlTedQXe10ebmzptlYG/qp6ALNOdPSN5g==
Received: from GV3P280CA0056.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::10) by
 PAXPR10MB5542.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:240::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.20; Tue, 4 Oct 2022 19:36:14 +0000
Received: from HE1EUR01FT091.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:9:cafe::ce) by GV3P280CA0056.outlook.office365.com
 (2603:10a6:150:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31 via Frontend
 Transport; Tue, 4 Oct 2022 19:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT091.mail.protection.outlook.com (10.152.0.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Tue, 4 Oct 2022 19:36:13 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 4 Oct 2022 21:36:12 +0200
Received: from [167.87.17.190] (167.87.17.190) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Tue, 4 Oct 2022 21:36:12 +0200
Message-ID: <964bc8ff-9118-77b9-118f-6b979cedbb8b@siemens.com>
Date: Tue, 4 Oct 2022 21:36:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Preparing isar-cip-core for RZ/Five
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Hung Tran
	<hung.tran.jy@renesas.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
References: <e47b7bf2-aa3b-3132-e9ba-dec7a747edd4@siemens.com>
 <TYCPR01MB105880E900B643CD41841600FB75B9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <d97fd149-c1b6-c4b5-cf36-4306881c228b@siemens.com>
 <38ce5ead-f7b8-e8f0-52a3-dff81f0f5045@siemens.com>
In-Reply-To: <38ce5ead-f7b8-e8f0-52a3-dff81f0f5045@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.17.190]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.243000-8.000000
X-TMASE-MatchedRID: tvpRZv6Yx1Y5QaOxwNGfvo9bHfxDWoibfHiU4sgyENKSJLHHb2KALSIL
	dc+InEErhnD8O3TjwmaqvdBo59cuvYJ7FIx7rr75HJfBKeADu1Jekvfhupum40+zv2ByYSDQ+If
	riO3cV8RemWwoCXDj9U12MsUfZOu5m0gaTU0ieiL0Iu1L7a9dfybZZYAQu9H5nVTWWiNp+v/aCn
	4DqCiXNi2D3rEYFrWrbcIAC4/H04lZGVkkvtEl3bsmzCPdqRjh7fg45MYQVOJTNl9jB9u8gA73P
	4/aDCIFgS5EXD2qbc3h06w0q6p9rOrc8uu0MOs1zbPoUo0CxxCdJYZJuTnwNmj110VUgQaLZZUe
	n1+EmbkQjsHZD9zVXujhqVa6NkR5jh5+Vj9kACfyaQ1cwlUuNlqlZQsfv7CJKwi7MItzaY2T+6g
	5ulhlrnPoYZUERzUBBuhMNLfO6UDJXhxyVL4EjPt+q7shlFAj1S/ye1IQXfZeYVWU5uHQ/Ayry3
	WoaCBEmyiLZetSf8nJ4y0wP1A6AKEwgORH8p/AjaPj0W1qn0Q7AFczfjr/7C1ADoqd8i4UD94R1
	q2KyLzXYv5BVM2IBqMGqbu2kblsDfQS5SOO8LM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.243000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 6041531B63CC8861DC08D1E0045C92769BB55B8332223A8DCEE393B0529788952000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT091:EE_|PAXPR10MB5542:EE_
X-MS-Office365-Filtering-Correlation-Id: c60e5532-6080-44bb-a9ed-08daa63fb288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RZx8n27FdOW0lt08BkevbyC6wBOxFFGykCtkXNqEMZjeQkrjFW+l442zX+e8A6k1C0v2pYOKgtMdAVccGhfQ2iqzNuFpOkTprCaaYQdiIRMF5qRHrIrS0Tr7hyU0uS1GCxEPWkjJYWJWnK4+2JcQ3JLOcgJfeIKrBR+OyhfAVVjIISSjZamlCIV+E5DmaCaT8D51Zni3c0ryu8irMkE2TsDFdRCtM21TVbq9HcBEA5H5oVVMLm7On+e1yrAOP8qXySTDtPr6HjAZ9PyvYguIDlRVbcnxRPoC/L/rS7wZoGLumuANm/b/cjFeol3QzRkEoUuu6/ucfkJHWAt0gmf2QGhg/JIxl3ldHJRbCy3Lo9MxS1Z++e6vC0HdCtdcoEtm6iaXtRRYl3wnfY2w9hydOVKBy4N+DuyQMzNa1QQgKiLxXz1wgUIh2VxKqz9px6qeIxxUKzBD3l+p1JKNaD1eQAeh6N13vTujQ/pFnwvDGztcLQhyr6mZp4BB/uogzZrqse0cDoysboj615Gj+giN8JmZwHQdCP9I0bIxC9lZaxTLosiMtKqP41J1ouhnBvZsv54BTd1p0jZjm+2HcMAFKL0Jcv3YZ8wMi350ut3Wv1og4xdQytT0XsGXxfE6C3bxLbTIEFy3ec3+M8KM5tWxHGFdhapCTa4g4TFwECraiy7S0EHI7joTL2AMZGexBN7dMIv0ZNUTbE7I0GgzX6NP2zHAIjPbr05yadkV9ISp2tGhk3IpVKDInmXWGl2gdryDMoRMfWVMpkJ3OqiuCcuVUg8wLnP7uIh/GUZbdtq6VYf1b8qPJQuY7jyAQCSl2eV1mAxAwFe1nOmkauHW1ZIvXEbMk8+q33pJkd6s/JdHEcE9l4HYdceqO2mO8ZX72zgHpFuULzMxQTrImGAg+TaUng==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(40470700004)(46966006)(36840700001)(66899015)(16576012)(316002)(966005)(110136005)(70206006)(8676002)(41300700001)(53546011)(4326008)(44832011)(5660300002)(8936002)(478600001)(6706004)(26005)(70586007)(956004)(82740400003)(82960400001)(7636003)(47076005)(356005)(82310400005)(16526019)(7596003)(2616005)(2906002)(36860700001)(40480700001)(31686004)(186003)(36756003)(86362001)(336012)(40460700003)(31696002)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 19:36:13.3860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c60e5532-6080-44bb-a9ed-08daa63fb288
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT091.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5542
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 19:36:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9638

On 04.10.22 20:28, Jan Kiszka wrote:
> On 04.10.22 09:15, Jan Kiszka wrote:
>> On 03.10.22 22:12, Chris Paterson wrote:
>>> Hello Jan,
>>>
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Sent: 03 October 2022 19:36
>>>>
>>>> Hi Chris,
>>>>
>>>> after getting qemu-riscv64 ready (patches will come tomorrow), I also
>>>
>>> Huzzah
>>>
>>>> had a quick look at the RZ/Five eval board you shared with us. But that
>>>> raised a couple of questions, maybe you can help:
>>>
>>> I can try :)
>>>
>>>>
>>>>  - Why is the default U-Boot hard-wired to a very special boot mode? I'm
>>>>    missing standard distro boot - which would include UEFI as well.
>>>
>>> Good question.
>>> @Prabhakar Mahadev Lad or @Hung Tran, could you help answer this?
>>>
>>>>
>>>>  - Where is the U-Boot tree (upstream support is apparently missing)?
>>>>    I'm still trying to understand the instructions how to replace it in
>>>>    QSPI, but first I need a fixable source tree.
>>>
>>> The Yocto BSP is here: https://github.com/renesas-rz/meta-rzg2/tree/dunfell/rzfive
>>> The U-Boot recipe points to https://github.com/renesas-rz/renesas-u-boot-cip/tree/v2021.12/rzf-smarc
>>>
>>> You're obviously welcome to fork/fixup as you like.
>>>
>>
>> How is the upstreaming status here? For UEFI, a U-Boot from this year is
>> needed.
>>
>>>>
>>>>  - Where is the kernel tree (also no upstream support yet)?
>>>
>>> Kernel tree used by the current BSP is here: https://github.com/renesas-rz/rz_linux-cip/tree/rzfive-5.10-cip1
>>>
>>> Upstreaming is still in progress.
>>> We're having some fun sharing things between arm64 and riscv, but we're getting there.
>>> I'm hoping we'll have something bootable in v6.2. 
>>>
>>
>> I see - over 700 patches for 5.10-cip...
>>
> 
> ...and it's based on an outdated CIP baseline. We are specifically
> missing "riscv: fix build with binutils 2.38", compared to latest CIP
> kernels. Those happily build with the Debian toolchain.
> 
> Fixing up locally for now.
> 

root@demo:~# cat /sys/firmware/devicetree/base/model ; echo
Renesas SMARC EVK based on r9a07g043f01
root@demo:~# cat /etc/os-release
PRETTY_NAME="Debian GNU/Linux bookworm/sid"
NAME="Debian GNU/Linux"
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
BUILD_ID="698957d5-dirty"
VARIANT="CIP Core image"
VARIANT_VERSION="1.0"

But due to the weird U-Boot setup, I had to add some hacks, rather than
a proper boot process.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


