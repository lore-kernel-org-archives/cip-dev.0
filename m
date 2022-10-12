Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144D2C433FE
	for <webhook@archiver.kernel.org>; Wed, 12 Oct 2022 10:19:08 +0000 (UTC)
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (EUR02-AM5-obe.outbound.protection.outlook.com [40.107.0.63])
 by mx.groups.io with SMTP id smtpd.web11.18512.1665569944937649499
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Oct 2022 03:19:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Q6l8iCLo;
 spf=pass (domain: siemens.com, ip: 40.107.0.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxwq1NMKVMaoKIZhtTFfypDgsx0d1dEAQ4v0OAuu7xjJhdHzPON0cEEgC9JafvqBqeguoXp5hqBEJHsSaSzzHFKB2+XmLM6tng16QWgAOPkpalwfdzAq3JxYvjqG3xHc1Y2GpybX11Oyr3LhoLB/vxfxbDXxahw7qKtF3XveD1vgYPkSjQyC+oE9RrG48sHXhmETldTY/pp7h+vgTkaTnxpLa4C1fT6m8WqDUNhnPqzSdoUccRHg2BT9OWBeORNTqDbinKO4qjtDgXfv99j5dWPRQ7e5EVAkT2bSyi5Danaxo/tcuDfmtv5imdrRkMcuNzlsx6iv5n7wXI3O0JBKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pk1cqzv59J24ECYloaWsWIC0IVmXmUFBfzUhlmedugI=;
 b=EeRypy6UJzx9KkMtlT6DB7cOOoKsVbI0xy++vHbjDXHwpEBjOBUpu8YiFGDy5huX4e9PEZm6eNRG6PD7W2wk5kbXUSja1KvN8OmYz8UwxT+fMXAsoyqPJhPilk6mtwhHErNbnkPQvqO2h3WS2CCX7E00TSqZX/MWPtvpNLhdhf15kt9jIUtNn3bAlSfBt0a/E24f5WNwEh12vvw/uCL1kl9ghbEmgncyrJYrQmCeLyjOQbDls5juf4ArYAxNJdpQQL8Q7XClAJZNlgzGtnCzPrWgeDtw7ahnPgB6yR/3sVKU2x96Z8ffSpmb0QbxuSW6e/Vaktr3PE3SpACOvc16Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk1cqzv59J24ECYloaWsWIC0IVmXmUFBfzUhlmedugI=;
 b=Q6l8iCLoOCLDMb3LD1sAJArbvRW7lrW5AwPNB+W6bnVGQa0x/WJmmoEDc1/v2m560lpLY3h4XOKm/8jmhzQ/KHoWgkNx1jNc2km7SFRoND7UyFe5SF7qRD3FCE0PHiKgj9l3eHt0zBjGpR1Id00bNer/rx5BGBd2UN0OUapenPPPamei3wPoLXfQbkznWQiun3oVCb+1CtHv/cL4K2Qy2oo8DXRP2QsF1S4AaGYe/7yG3qGWO67zAN6DicS+9mrkNo0rXm0T0fRdjiY3NI3BRG7WCcDW7ejVkCJN95T7DRW6ynrE+xf8z4Kn5AoWAPDguz3gboAOtxcYSw00/iR1iQ==
Received: from FR3P281CA0039.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::11)
 by AS4PR10MB5845.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:510::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 10:19:01 +0000
Received: from VE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:4a:cafe::ef) by FR3P281CA0039.outlook.office365.com
 (2603:10a6:d10:4a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Wed, 12 Oct 2022 10:19:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT034.mail.protection.outlook.com (10.152.2.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Wed, 12 Oct 2022 10:19:01 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 12 Oct 2022 12:19:00 +0200
Received: from [139.22.133.11] (139.22.133.11) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Wed, 12 Oct 2022 12:19:00 +0200
Message-ID: <b34d60e5-57b7-fe83-ba8a-fceeeb3f88dc@siemens.com>
Date: Wed, 12 Oct 2022 12:18:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core][PATCH 3/3] activate nodoc profile for swupdate
 build
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
	<cip-dev@lists.cip-project.org>
CC: <quirin.gylstorff@siemens.com>, <pluto.svc.chengdu.cn@siemens.com>
References: <20221012100641.2986740-1-felix.moessbauer@siemens.com>
 <20221012100641.2986740-4-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221012100641.2986740-4-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.133.11]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.056200-8.000000
X-TMASE-MatchedRID: 0ayLSLUekQU5QaOxwNGfvo9bHfxDWoibMz0EFG5lnW+GOUGPCmibUywJ
	zaIVMjGt/gMNehoKqTvTWZ6m8Dlh463aC25avUua8n+TRW1yhDMlzrSFs7UBhuOQ2d8Ecza+guw
	tqyXlE6GUAUfla+IhaLKXWmEvaG3ElyyR46PvItPOeOtoiFWQseVHGbcDbAq6OX/V8P8ail1ZDL
	1gLmoa/PoA9r2LThYYKrauXd3MZDXvHyqMcM47IzdsNiogkUWPj0KMPMnW3t2jZP+ys5ojKMJR6
	/7C88Yi
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.056200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: ABE1EC8DC2466623C8CB185E0B7D4DEE73902E2D28309B04B16F47E9030AD4F32000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT034:EE_|AS4PR10MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: 99726196-8c2a-4e8a-c8f9-08daac3b2eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	J70e9JK+q4Rph3QtBpiP6EV4QC5n6r5Cb1m+E8RmS8V4r6qQJ7QgfntsN2h5i6cN+PNfUyBJ6Q2YQuNjv4oOAkfLGsSYO4P1Y8VsTV6ppzRfTJGjP1+A2ccJqdsJ56YRMR+rfj5HcSMmEHAaJXeIILARaqUpMg57f8CyBNrKmpbBxmxFepyjALG1T3wqDoY6tjK/N86dql0JHh1n2nEAFych1JK0SB4O7KInelfy7ObD0x2sZ93CmHrejXIauPBAHxI2eK7UyoO4HLyS4wbuQhxhL6TrN01Gc2sPl69z8q7B3PU+mHogTJDiw+Fi1ydRgKhKTkSnC83peNsNjwFL5e/Q3fwPu02zoSaYPfP8xa/QMJKEDbHL4es2m+1GZiT9MuSDVnK0rI5e50RqlENjvI7FWZxE7cg3TScbuhsKkz5G2qTGJt0azAigQvzqRvgNVElW5ZoBaXcYofIrmodAm67YQsNE8xyHz+muDif8+pk1rjxEX1CVHJgd5/yy0eilCeOR9tB1Vx4ozPqlOUDzEh+ypFzZ6aeBINplGUuAg/D6cXJN3Y9KDut619pkE0g96sq1o19xYeTyzuLdV6FmlvX8QPVGxpGR7PG9ZMizpQXuqPJbGiDu4Q1Gk2A9CoPuwwSI95LpIZJ5dHNtpWTC1/MF0kuwOyLIPGqYrsOiKooAjc0KZokRVb9fsUbHLSQiLC1mfZmz3mTy4hhMjDOKKmwPMY2NrQUYBaltNGB+EJCRTqrMI0reEPZYLGTmubcgJGMiBq9X6DbTclXTpp39NLxkqkTa1l2H0VHLPPRM04xW3VZewFQYBmvxsntmz6rAPyho7G1Zp3X41SjtDBCQkhYJcikWEeAPdW7ztQLKYJc=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(86362001)(82740400003)(2616005)(31696002)(956004)(2906002)(36860700001)(36756003)(40460700003)(478600001)(316002)(70586007)(16526019)(16576012)(53546011)(26005)(47076005)(83380400001)(8676002)(336012)(8936002)(82960400001)(186003)(54906003)(40480700001)(6706004)(70206006)(44832011)(41300700001)(4326008)(107886003)(82310400005)(5660300002)(31686004)(81166007)(356005)(110136005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 10:19:01.2722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99726196-8c2a-4e8a-c8f9-08daac3b2eb7
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Oct 2022 10:19:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9738

On 12.10.22 12:06, Felix Moessbauer wrote:
> This patch enables the nodoc debian build profile for swupdate.
> By that, the overall download and build time is drastically reduced.
> It also helps when building behind proxies that sometimes have issues
> with large pagets like texlive-extra.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> index 7bcf015..a81c521 100644
> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> @@ -12,6 +12,10 @@ inherit dpkg-gbp
>  
>  require swupdate.inc
>  
> +

Unneeded blank line.

> +DEB_BUILD_PROFILES += "nodoc"
> +DEB_BUILD_OPTIONS += "nodoc"
> +
>  SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master"
>  SRCREV ="344548c816b555c58ec199f31e45703897d23fb5"
>  

Makes sense.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


