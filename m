Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29629C433F5
	for <webhook@archiver.kernel.org>; Wed,  5 Oct 2022 05:50:13 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.58])
 by mx.groups.io with SMTP id smtpd.web09.20565.1664949008796614727
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 22:50:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tONSyAmt;
 spf=pass (domain: siemens.com, ip: 40.107.8.58,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGR+rRSkZlXsXBQK4DEf+sI8bbeFjKh+/ai40QDf0tmh4JYl2ZR/ifGakP0UvDj+2RLyp2iX8GLi6b5HguOgJSc/RO4XT6hFnKkV01qgFWE2DoruyaCE1pEzLfGeWLjiG7K7moZo4Q94G7+APEC+xdMahfnEoljORuhIxm/1LaZu1nY5ntwi4iBw+4m/l0ab9h5HOGg05aYoReuNM9udm7dlur3TVcsyueHhiXzPy/vTitVn6JMJrUj2MfC6Q2Pk2DymmuSSlYVn8J8QC91Akgfh56o63sTD9c28PF2+9yzIMyYEJFI6VhjXl0X4pVy6Ge0KslQR7ItXP+7ddDthVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEfj/B+TgboFC6IoFGu8TXDQlKK8FhJh6na8iIxNkQI=;
 b=Tzr48+wty4e3+mgxbaC8b3jd49WMkQgYec1A2ThQfBfWbJnE1LgIoQXQx6OqTj2b/0xhH0bofXZoF8H6knAL4nV/vo2i40P4ZNvxJBZtVTy7x4b3PixXePisvF3g407Zqa5rO5UeP2Cpc3CF6tH/fWdcBRCdRlWczYYfb3gQjqMGMw4S6v1umtAP/JjLIJEjC+biEmBCV9gfxjgnko5zXyus9H+vY42pjJp26x0JvX1vfe4DcM/02C00MS1pIcXt+NnRGikiMu1cZZekvNJoXRLe7xqJWshGgO1sdGGF6cxEUVauMciw6CuELzEKJ6avKYRD9tlXQKTa4PkKGfyRfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=denx.de smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEfj/B+TgboFC6IoFGu8TXDQlKK8FhJh6na8iIxNkQI=;
 b=tONSyAmtaUb+zDjAFqti2i4uDhLz/nh5dKHwJDcX3ysndI+XQi2jUkng+Rh+bAjhS1KQAd836BIlY8mQCP//68w6WrEVr8cGCm+0s5ATt0hOGQ9dUkpd+qomKYiBP2O+Ur/BUnLfRLJfE6W5jBkxN1dwlki6GMF/ZE6rYDKe+cfVoyaS82jgMH1mQYGd7/DkZY6tRraVzdLKjyCae3bH9pgunp3eam02kO6vYGSz+gEnY17kOnJZ6/7WQZrOd8q4TRo1mlV7DSx3UrpCfGGovQ4kBVD2V8mBLpFf6Tdg4L8zDf63t/bKnengVrP+SXYnA03Ef+vIvNbbjMOcqHgSVg==
Received: from DB6PR0202CA0031.eurprd02.prod.outlook.com (2603:10a6:4:a5::17)
 by DB8PR10MB3467.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 05:50:05 +0000
Received: from DB5EUR01FT054.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:a5:cafe::8) by DB6PR0202CA0031.outlook.office365.com
 (2603:10a6:4:a5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31 via Frontend
 Transport; Wed, 5 Oct 2022 05:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT054.mail.protection.outlook.com (10.152.5.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 05:50:05 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 5 Oct 2022 07:50:04 +0200
Received: from [139.21.17.164] (139.21.17.164) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Wed, 5 Oct 2022 07:50:03 +0200
Message-ID: <d6824d9f-6416-6d78-545e-a9b425cc1b20@siemens.com>
Date: Wed, 5 Oct 2022 07:50:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Realtime support for 5.10 on RISC-V -- not there
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Pavel Machek <pavel@denx.de>, <chris.paterson2@renesas.com>,
	<cip-dev@lists.cip-project.org>
References: <20220902095754.GA18026@duo.ucw.cz>
 <19ae27fc-592e-e3a7-09ce-c258e2e42970@siemens.com>
In-Reply-To: <19ae27fc-592e-e3a7-09ce-c258e2e42970@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.17.164]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--13.362800-8.000000
X-TMASE-MatchedRID: Cc2Ao8tLfKDPhQMrvkSA3i87ok1axQd4c2zotcYu6/jx5KZMlKYS/fio
	Isi7Sa0gbDD7i2QfyEf47Xv617HbRyRbF/fU7LsUhSunsgDtnFYHdTtg0iNZI4IK2tjTqNotxYt
	6Ilbxn6nURn+XOe/hRbNSrREeq4umIFQ3w3Zkqyzxk5wM/pTh1vfuVpATnjcHdJwJSs8rAzmIWG
	vfT9ZpjE6yr+fYrPb07DWCYCEbYYDp6MBi+MH1la9iVfvGLbGiQqHw3tJ7i06Vjmqvt/p8co1j+
	mrGi/PFXfeuAdBCdZVGZ8HtdXXhGCvn27+DO/kwtTOrxEGQm4ZJI5ZUl647UDl/1fD/GopdnCGS
	1WQEGtB4UhBPLRlvhqu6xVHLhqfxIAcCikR3vq8Pgl7o4llt9b4j4kcma2jkdxF4yLG76Ed3Y7z
	JHtDusd07MIIszcZP
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.362800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 D0E9FF76B0F618E502F2721921E20298AA33D8A9C952635DA11DDDFF9F3B6BCF2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT054:EE_|DB8PR10MB3467:EE_
X-MS-Office365-Filtering-Correlation-Id: 0647b577-2ed1-44a2-7e28-08daa6957418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6LFA2xp7SLylLY3El10PfMsPrDtx5ndQoyfxwtk3zIahlEvZrqHo+xmShwuyb2yU1tXNxs1cW7AyuqdyN5lXVnZaiYeCG9jerSstpN6Yyd7WMoWu+o+Ro4nOI9V5v50oWDGHErFlQO1XcJvw5A2NFJ/cc0n1/cQkeCRLVAvtMTKe/hi2btunH5tdHYGA/N2ILR9K3KuMtXV8WVwxnAl0mo6bF2mxn5x+mQElquvWKCxomeun+gmIDKy/RUrx1x0F2KbTJx9WCZSJada8ECtde82NNgmqNF0KdMX2EdGACUnTNb+21afGdnSVoNOw+lUciLjTTQG4NsPGZUflN1GTOG/GtSrYGkdBShC/9HQWfl5M88QYre57gm0ZeMBXLeGhRwvCgZ3BhGAAmyARSXGPYnVb3tsey3/6qrck2zG5Q5EZyAZumgZqdDUpqgZ7WRVRxm+zEDBW16VYvaA285qs3NExWu02dRUvg9DUjK4g8smoceSPb5+Rn2aYedYCtKIFm5CCX66wGjoNxj5CkQz6tISnFeupkcS72twsS5P8LExARZExfJbcsTI6XRM1O9tP4yeMmcSil7HLxJGgEaBwlqt+EL+8gRqcA30Wx6dQgDOTVFQGSVNNq/m5X32teikovvqCtmVaWkLuVat4ef6MdA1ig0DW9tGTtolOgaFyWejZU4mAfnHg1bGso5DtlaSeQ1yjVVq4hb6jaUcOgtE66DcIg8dNouZSkt2X5wb6nb3B4C5kR8KNlmoz4bp23z7RQm09huXA3C2ZmJCjihhi0Lg3edxWZT5WdT+vXKDwDMOgH4g2qjHXpNseTa8qnzDQhJXSvgA1azS0Jg5aefnE361YWTFrc4HLi0r6wwolS/JzB12FchwkzQPndD2KNzfWEdopALpfG9WNgY6QmAP6oi6+RIWJsJdSMVL8cswsQKg=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(16799955002)(31686004)(36756003)(336012)(81166007)(356005)(82740400003)(36860700001)(186003)(82310400005)(47076005)(16526019)(86362001)(82960400001)(31696002)(956004)(26005)(53546011)(40460700003)(44832011)(5660300002)(966005)(316002)(2906002)(2616005)(478600001)(41300700001)(70586007)(8936002)(110136005)(40480700001)(16576012)(70206006)(6706004)(8676002)(3940600001)(2101003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 05:50:05.3821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0647b577-2ed1-44a2-7e28-08daa6957418
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT054.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3467
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Oct 2022 05:50:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9643

On 02.09.22 16:47, Jan Kiszka wrote:
> On 02.09.22 11:57, Pavel Machek wrote:
>> Hi!
>>
>> In rt wiki, RISC-V is not listed as supported. 
>>
>> https://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch#Platforms_Tested_and_in_Use_with_CONFIG_PREEMPT_RT
>>
>> That may be outdated, but it does not have corresponding config option
>> in 5.10.
>>
>> pavel@duo:~/cip/10$ grep -ri ARCH_SUPPORTS_RT arch/
>> arch/powerpc/Kconfig:	select ARCH_SUPPORTS_RT if HAVE_POSIX_CPU_TIMERS_TASK_WORK
>> arch/arm/Kconfig:	select ARCH_SUPPORTS_RT if HAVE_POSIX_CPU_TIMERS_TASK_WORK
>> arch/x86/Kconfig:	select ARCH_SUPPORTS_RT
>> arch/arm64/Kconfig:	select ARCH_SUPPORTS_RT if HAVE_POSIX_CPU_TIMERS_TASK_WORK
>> arch/Kconfig:config ARCH_SUPPORTS_RT
>> pavel@duo:~/cip/10$
> 
> Thanks for checking! Same situation in 6.0.y-rt, it seems.
> 
>>
>> I do not think we can or want to support realtime on RISC-V at the
>> moment.
> 
> In fact, we couldn't realistically commit to such a non-existing feature
> /wrt long-term support.
> 
> If there is interest in enabling this, we can start a development effort
> in upstream. But if that could then be backportable only to the next CIP
> kernel, would even be open.
> 

http://lists.infradead.org/pipermail/linux-riscv/2022-August/018823.html

Maybe there is a chance to have this in 6.1-rt so that 6.1-cip-rt can
pick it up.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


