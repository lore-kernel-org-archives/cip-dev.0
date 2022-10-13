Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95C3C4332F
	for <webhook@archiver.kernel.org>; Thu, 13 Oct 2022 14:59:53 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.79])
 by mx.groups.io with SMTP id smtpd.web08.8574.1665673189326963032
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Oct 2022 07:59:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=o6qPvyJY;
 spf=pass (domain: siemens.com, ip: 40.107.15.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFTpwElenAptDlyAXBiAzNRamweO2sWLHxUjwzs0eIxOSbD8RZrkhihXbNLRIEEHP5AhGq0BwcJChQVwNP6GMASKOQwMhb4W2Z7RBBipEbnKqkzppXpgLhrZuSqtp0YUjTcPKT7R9Li2nBpAPINyQqmn74k5B/JxncKHuO/+2d1syX8LavU0weVRp4opJO7udfcLvBLYK9rCVh5uUmeoVL6SrN1KPmnUve+v4rSVa0E9dDagsZe/Ef5M6yY3ClENNgfFsyM8vq1EwDvj29KoAX5o39qAzvr+qIflw4RmmtyziQEMu+FBBvwMKclsp9xPCq0alGIh/YbM1VJD0dRepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbUuWcUF5bYk1LP2PL4HYlidWWCH2Laq4QwAONGYq0A=;
 b=LurHXgE9tKxyAR2wnJ3fiVSevIGbNIpHWC+d5EjmXqhJD1nriNUlCE4gu2ZIdlbRiRaFqvPueh1d5G4VoggrfEag+AXxo0ahxguXqE6wGSpNlCWcyeE807EH9n+eLcK+0WIVVFdeNA/vMZfuqmIiReyXm+QBjtxe7DaweRCPdlHlPRsN25uDkr/fLwDQyhir2lt7e8XlcQiJIzULC99RScD18phTQ3GBazgMm57iEa7XFVI1yGeR9obDHv6A952QHiKf/pou/6/6t+Lhgf/s75wBwMv17xQZZO7gN8MphDjNH51NCVQQwu6/RdT2jkkOg8tPe5554iKV8+CP68zq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbUuWcUF5bYk1LP2PL4HYlidWWCH2Laq4QwAONGYq0A=;
 b=o6qPvyJY8rqmq2Swt7UOFn55dRsqNTKb2RzRUkiids/+BfhCxUwjNA8HXO2yoor9Umh2wYR8ubwO/cnjRmuwJ8IZTGdhstGeCF7MK9nfsudBH9ktT5P9/Nr0+Pr8ACO5WBA1XxzPRmGybHPFZaGPr6c/BeObH2TtMNbdkISSjvacBjupgFIxT/PGIHwNNmDVWeXN4BIQcD84V0xaxX6FWEzCEoTMF6YXaHGSv9IuZXvFSfVufqDhX++tl8XmzBevbRmv3lHNHYLhru8+/Nm7s7ZI9jGZLsyEooqnbxm2LlteX6/F0HzQjRcwM8OqFrbfCRJjjA/dsDrp9zDcVjNeuA==
Received: from AS8PR04CA0036.eurprd04.prod.outlook.com (2603:10a6:20b:312::11)
 by GV2PR10MB6525.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 14:59:46 +0000
Received: from VE1EUR01FT105.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:312:cafe::f6) by AS8PR04CA0036.outlook.office365.com
 (2603:10a6:20b:312::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Thu, 13 Oct 2022 14:59:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT105.mail.protection.outlook.com (10.152.3.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 14:59:46 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Thu, 13 Oct 2022 16:59:45 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Thu, 13 Oct
 2022 16:59:45 +0200
Message-ID: <47514904-9004-2efd-172f-ec093d0d495f@siemens.com>
Date: Thu, 13 Oct 2022 16:59:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core][PATCH 1/1] add support to install efibootguard in
 cross env
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
	<cip-dev@lists.cip-project.org>, <quirin.gylstorff@siemens.com>
References: <20221013144041.676637-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221013144041.676637-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.307200-8.000000
X-TMASE-MatchedRID: FSxjOqe5tUM5QaOxwNGfvo9bHfxDWoibMz0EFG5lnW+OjIrMSa2sR24l
	czE4XkmwBph69XjMbdlTHuQZZKa8u63aC25avUua0TTgowSeLurKWNgovqaJc4IK2tjTqNot3Sk
	TY86NiDgINpIFnbd6mmBt9mS7pKVTeoqVs1ZLrvAzd+tJEfcx1FxxDx5qbkR9OX/V8P8ail1ZDL
	1gLmoa/DHhVA9+r5qgUEhWy9W70AEgBwKKRHe+r1WajSSliq8fvQzkD3F4jl5EjRAWctX+PTeew
	P2S1kckd8iEjL+9V2s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.307200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 32D843CD945EA4C52CAEFD9706C98587317066C1560F1046FF0AF9406EC48B372000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT105:EE_|GV2PR10MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 4315cabb-388e-4bed-b751-08daad2b9164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4Qvc/EbNOjMc718c7RxBoORaKamkyiY4C74kKryPEEMmJxcWapaZOzKxqngFhT3tHsw5sTDc3LA+HcHvs9rfFmxCnvtt07Zg37zj1htFsqpacwfX1pbDqFz7sZctVA5hALYc2+GmrCho/0aBK5GEdlQxjTi+5pSilsczqhDz287DjqMFbAZu3JI3cUadzEbBwQsf8gwAlPHHQz/xn1T5W9b0qGmh6Hz6tRRBQXRmxB/EITRmPUllcv+FP1O/YbLh9tzjYihoi1ZfDJHXMlXfcgtEDD9Nyj0KnoPYhTU+wx3A9Wd1t2SJouRWu3qseub5E2FT06kXKRNkyZvtlKNJROge1mlmCWzq3ymB1R21M5h/JkDwsv7N6lvKrJt4tCujGlqtPmSUs10+OF38ofPVjo/f7DrOgYSpWx7IwMxw7nEpoOw9WHZq9bkjZNUzV2x7ZUhLSwUhwb1ssq4M2HukAA3CUp8ElNi0g0V4Dgrj858os+6TLN8Fnba5tLzNJA6rh96rrpMVVxNmv6obWXk+6O9Q3OtwnHvGuzMUyA/z+0+isvQzoE5aH8Afd9U9WjXSDSQ8OCkM6UQn2kRLUXHHs23AzZqs0g1AeXEXyfxbb7D9RD990fKywRtMd6ka3z6U/fbq2KN5Z0GvA7GAkXeLJ1rIHUpv/zuKgsO7xoHwZULZbyKrtFc/T8crXjHEPiM3fcPy5dST9wiKZ3aaUjJ5hUzVL5UmK2GTISTm6RjuegcXZS/oCxrkvWgDVaDzDq2pGdbPd5LgE9E9n6onmY0Lw+QtFWbu+RhPzHgDSVmYyvV6ZCLZy0ACtU85J7Paymx04Y0ARb2vZaJT0iV2zM5o7fgwigB8CeiVwMfXOlqhwSA=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(40470700004)(46966006)(36840700001)(5660300002)(44832011)(8936002)(40460700003)(36756003)(4744005)(70206006)(16576012)(316002)(41300700001)(53546011)(26005)(6706004)(6666004)(8676002)(70586007)(81166007)(36860700001)(356005)(82960400001)(82310400005)(82740400003)(40480700001)(86362001)(47076005)(336012)(2616005)(2906002)(186003)(16526019)(956004)(31696002)(83380400001)(31686004)(478600001)(110136005)(6636002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 14:59:46.0217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4315cabb-388e-4bed-b751-08daad2b9164
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT105.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6525
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Oct 2022 14:59:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9757

On 13.10.22 16:40, Felix Moessbauer wrote:
> This patch reworks the python dependency of efibootguard to allow to
> install this package in a cross chroot.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  recipes-bsp/efibootguard/files/debian/control.tmpl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-bsp/efibootguard/files/debian/control.tmpl b/recipes-bsp/efibootguard/files/debian/control.tmpl
> index f8bdd8a..626d43f 100644
> --- a/recipes-bsp/efibootguard/files/debian/control.tmpl
> +++ b/recipes-bsp/efibootguard/files/debian/control.tmpl
> @@ -7,7 +7,7 @@ Homepage: ${HOMEPAGE}
>  Maintainer: ${MAINTAINER}
>  
>  Package: ${PN}
> -Depends: ${shlibs:Depends}, python3
> +Depends: ${shlibs:Depends}, python3:any
>  Section: base
>  Architecture: ${DISTRO_ARCH}
>  Priority: required

Also an issue in Debian upstream?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


