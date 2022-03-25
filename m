Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AC9C433F5
	for <webhook@archiver.kernel.org>; Fri, 25 Mar 2022 11:39:38 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.89])
 by mx.groups.io with SMTP id smtpd.web12.4092.1648208376968134804
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Mar 2022 04:39:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=h4Cw48dY;
 spf=pass (domain: siemens.com, ip: 40.107.21.89,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eF21T4O3aZZSMX1Jn7tLxbNSGVxX8Rr4of2WkH+Td31I5cpIo4nbJKztBTecP+1cLjL9EkRyCahSPg9Xc40HZRD9PvtJIaZ+oQV+Lx1Pto9aS6f/3cMXFO7q8vmLtu10tyqIj57WwfVLZ4/I5DYq+nJBqaRGWMr/Sr875O7913WYzFRmr0QE8Z4HSSMqhcnCdMlzdEUbahjZrVyn1B1KvQWE16kvJaSAwlwbHDee9LSNbKd2qukJs2V+m1Zdbkdt5yYM9fov8cw84SLa0ASCXHwHZaN2nx6r0FYgRppaj3Th8lAztwiKj788+pjoLSWqYIczE/Uj3wdcAppi1bF2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCwqjN8SpAt+BMFa8SmTqtgvABy9mZpxqH99rWMGZPc=;
 b=GlAtjwV3+pty5EcmfdW3Q7zUUeLALYQU/xHsRjKJGdqODT1RjtKrjCOP6Wdl1c+hV80apv5B+xxa3VZnmPcojiKKtZrxDF3ZqKZmKOfkMWweJvKaooU4RF74yChA6oNsnQI3Usc6CS36RLVf1qYB9oieaUzzozHSkHVPyhZupIy2DjpeV+0ctrIZynyJKl28JHUZ9L2YoEs6zW4+EYLlnIGyu58qSehNQMxAJic2NJRhHD3PPKafx5FlybHHXiuHC2zWRmWl4acb4ylLCoDH/r/wypSa2WAaUUTlLJqEixJCp2/rXQm7EfS4fCyaXYuLvwU+7TnrVdxYZwhhQ1542g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCwqjN8SpAt+BMFa8SmTqtgvABy9mZpxqH99rWMGZPc=;
 b=h4Cw48dY/Jk8IYHX3VrTMEcBKjni3GFlpk+jubbF+y+E3g8QjJ+9VuZsppFAd1tLEGFVSWzy0Ystet9g5cV8EAKHRONhdqyiyHA4Clqokc0EPvcN5kcIZRvcBpNBNEMlbIC1mrh0ueLRoJTJ/GUu2lGFJj/foYdEG2OFRT4iC5fmMacncN49RsqPxTaRJP4zzTLSOBs1gPSKLaHGPH4ttO6/esavgD5e8lghmhKuLZLHV8bhaM9q4U1s+ftprQw9fPokHpq/vu7dZsLzbvrVvvYcoT7EdN7vylxEOnWGrMCbmRnswvlt5E3zcazT2UUlKYhTqbIKOmH3gEm9t9/YkQ==
Received: from DU2P251CA0025.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::23)
 by VE1PR10MB3071.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 25 Mar
 2022 11:39:33 +0000
Received: from DB5EUR01FT039.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:230:cafe::ce) by DU2P251CA0025.outlook.office365.com
 (2603:10a6:10:230::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 11:39:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT039.mail.protection.outlook.com (10.152.5.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.18 via Frontend Transport; Fri, 25 Mar 2022 11:39:33 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 12:39:32 +0100
Received: from [167.87.0.244] (167.87.0.244) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Mar
 2022 12:39:32 +0100
Message-ID: <b126a869-b4f9-4468-2e76-4bb4fe895632@siemens.com>
Date: Fri, 25 Mar 2022 12:39:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] python3-shtab: add export to the
 DEB_BUILD_PROFILES
Content-Language: en-US
To: Srinuvasan A <Srinuvasan_A@mentor.com>, <cip-dev@lists.cip-project.org>,
	"Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
References: <20220325083408.4080473-1-Srinuvasan_A@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220325083408.4080473-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.244]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.643100-8.000000
X-TMASE-MatchedRID: 8xNMUprDHac5QaOxwNGfvo9bHfxDWoibO5k/PxBAvv4HRzaQbsazqIJ4
	d9hmBU7mkWEaPHEbwIwwQgMMvRbeyRpSJNiZ/PIpJUyfGGX7bf6oXGwWsKbNNKchFrOB9kanzqA
	F0wFSjjVYwVHjLI3nekAc6DyoS2rI1rH4Rg0AOT105Kn0y9viBt4QDef0an8ubl4CKqupkMr0VP
	vT0zx0mKfub87GOZij8P7ohAxHFTni8zVgXoAltkWL4rBlm20vt5CrqYXZLj+x5amWK2anSPoLR
	4+zsDTthUfR2rvBju6nw52XVXCkJLcqh2ILn8D1AkxtET/Av9x7UfeWviiYuL7rQsSu0Q9yZDfG
	JRMOzFY=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.643100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 9F184CA44ABAF85ACBAD646B2ECEA8272BA05519A1513A035057E192797D30912000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc1e2249-722b-422e-0932-08da0e5421b6
X-MS-TrafficTypeDiagnostic: VE1PR10MB3071:EE_
X-Microsoft-Antispam-PRVS: 
	<VE1PR10MB3071C8C0EFC50B87BC6A141D951A9@VE1PR10MB3071.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xFVBMJVbafNTZeiYBHJLh+kft6pAmZ+z6Zt/3nUzEP4n/Xfv6NyPIE80EofLHSlXrVHI53qKTjzcj/yB+pE0dBViYgACvrym4+TZ+QMUr/u+iOIWaPvGl9W5itJBxvn62Gic1500myRJ20ny1bR1X1t5zB8/q+reTNliG0FpKSlXDbJ82/h3vKSQnIt4+0LN30cgSNtRBZD57cDQthALhIOXkOOJQYeH20cQ/0HU5dTzZKSgRMorZ4CXflYR8pjIh8KxYQBej2+nrCdfOFwTpLtcOtEWUDwp3LvzP3LR7f4SMl4E/Kodhl8RJnCt85KCCDfcsy75VlSP2H8pZDepWLIDogUt99T8vZ87nh8qTSsf/rcGS8QGsmMuXk33EBpNDBFkEQ0fPpNwxhmxmd0IUCQZmXCB43beHfqij2Rq79iMoxPliSD6ICrQafsrKZWbRHWly7g0w3wLHfbkBIG7zqSkrZlLuanBOSyPlG9UgXMOJ79J1Bd0uBUndcvuGhz84f1yHoiYpa+BhwWK/nXvjBv6NqbShh1CjhKXt5F/47mPGk71KQvPBNxzOy2ZnjoS8HF6xQadmEqJkGzi1hCnmjFOZ4biVbXAlJ7L7noEA2KeTAj11FrLShkCDAdUrAaM8lisyBNTXSnfEuDXDgr/aa7pCJP+i81apsXuC6RZ5ZmUJZnEmVIpoC+ce3lLsddOmnfVj08FdJIidtW0vglJovyioX9bdBENfleIikyzUIWwHxHLt5kjZpTkD08BECWCOc/TNYjiV6cSTxpYfEcppQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82960400001)(8676002)(356005)(336012)(81166007)(44832011)(6706004)(956004)(47076005)(2906002)(40460700003)(16526019)(31696002)(31686004)(508600001)(53546011)(36756003)(26005)(86362001)(2616005)(5660300002)(6636002)(186003)(316002)(16576012)(82310400004)(83380400001)(70206006)(70586007)(8936002)(36860700001)(110136005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 11:39:33.1257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 fc1e2249-722b-422e-0932-08da0e5421b6
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT039.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3071
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Mar 2022 11:39:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7823

On 25.03.22 09:34, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> When we build this recipes in downstream layer the DEB_BUILD_PROFILES not
> able to find by rule file hence it is not set the required build
> profiles.
> 
> Here we disable the tests `PYBUILD_DISABLE=test`, but due to this
> unavailability of DEB_BUILD_PROFILES in rule file it is building along
> with the test hence it's getting failed like "Not able to import module
> pytest"
> 
> Exported this one to access from rule file.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  recipes-python/shtab/python3-shtab_1.4.2.bb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-python/shtab/python3-shtab_1.4.2.bb b/recipes-python/shtab/python3-shtab_1.4.2.bb
> index ce83d6b..554afd3 100644
> --- a/recipes-python/shtab/python3-shtab_1.4.2.bb
> +++ b/recipes-python/shtab/python3-shtab_1.4.2.bb
> @@ -27,7 +27,7 @@ DEBIAN_BUILD_DEPENDS = " \
>      python3-setuptools-scm:native, \
>      "
>  
> -DEB_BUILD_PROFILES = "nocheck"
> +export DEB_BUILD_PROFILES = "nocheck"
>  
>  do_prepare_build[cleandirs] += "${S}/debian"
>  do_prepare_build() {

I lost overview: Do we need to export now (but Isar does not)? Will we
have to with upcoming sbuild? If we only had to with past Isar, this
would remain a downstream topic.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

