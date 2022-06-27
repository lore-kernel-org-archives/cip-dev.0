Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44053C43334
	for <webhook@archiver.kernel.org>; Mon, 27 Jun 2022 12:53:18 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.53])
 by mx.groups.io with SMTP id smtpd.web09.41246.1656334394848181553
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jun 2022 05:53:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=S1vujXF7;
 spf=pass (domain: siemens.com, ip: 40.107.8.53,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a85Y+tZpWlPohWxDJ3jI6HCuAZa6tGwQXfFiWB0pASUZosrDmr9egCj+Kk6Y4BIi2uhZHlPma86dRBiGNhIcacfAjAc1C5jxGYd9OAXzqaCQajBhcISSWFyVTLjYEBNbiH3SCw9OMbouVPSC8y8aI/kiDz/ed6DuiSZK8L5AGhPXyZRw/Y5wikXcd2qT2w52gsEnr4UpVTY0hPkrE76geOLgf9o/p4Pzu9n6Uv1LuizN08uM1T8/X60mpePrpTjLEUouncRCEZsqqGbkoouxiKliUundxqV3SKeLaElMC2Y/O/9slng6ROkzbMUrdnbwPhZJTWFDk7aGZcBMiXqqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeJ1gpBeMl+gQAQGz+VSsHEsdSEXpUqqsLsUEUody2A=;
 b=YXpwr4XkWQ061ak/Dy3r7m/nO7gu1Zo+ajB/Wfcds5T1OpKGxIWbA26p41xIQ273ni0N/flDI4oNTJlDOul6c7Ga3EMImikRHVNqwbxJiPX6PF9Rkl/d6khQAYJgvo+Biwg2Z2zE3WMBZkPwgbUrPWAZ/HWFS8dqY8AF7bvXhEZoaUR3HfxPMxq7WMvW2L6+GpEGHBbnMpjNs+AWWHzu/jTZTIRJh53mUPOPbsyMTd5tvl+XcxHEVPvOsm0NaXhCtFH8P3IR9v8qvC1GvfvSRxRbPPh1/h6aOYzngVDdgVXu8bJAdiMa3Ri/cVjNHguoQWikQ0FJX1wqsOTU4U9lZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeJ1gpBeMl+gQAQGz+VSsHEsdSEXpUqqsLsUEUody2A=;
 b=S1vujXF7paRygRhai/xz15045Rtl1W+FFZlpaiXL0nZI5NJRyUCkrHfc97ahzZHjwEIfoU0H15EPxUFZfSjhSPUHIT9DBvLet+zF9xLnHh0PUh7xCKEp6H+h8usYGfGvSiwnWc5d82Iu/re2Y/O8h6WrSMbR3gn+pSq2fMS/yTHLfj+xUqzfzk/g1u8gf22UzFK3AIsvxVFOKIGF2oA5gmNAdLwVKHLfDY8aWxcg3jUDsQEEE58voRMNmeL67ja0qEnPKYmp1tmnl/Ec+1d7NODrFu8Y5R/nFsqTa5F+PUZH5MtgFwis1Hxf1GtUdxdq6uifkJUxAkIfqEJcvwmXbQ==
Received: from OL1P279CA0043.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::12)
 by AM8PR10MB4196.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 12:53:11 +0000
Received: from HE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::8e) by OL1P279CA0043.outlook.office365.com
 (2603:10a6:e10:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Mon, 27 Jun 2022 12:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT034.mail.protection.outlook.com (10.152.0.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15 via Frontend Transport; Mon, 27 Jun 2022 12:53:11 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 27 Jun 2022 14:53:10 +0200
Received: from [139.22.133.104] (139.22.133.104) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 27 Jun 2022 14:53:10 +0200
Message-ID: <82bbc689-c74d-649f-cc8e-a114df4d606b@siemens.com>
Date: Mon, 27 Jun 2022 14:53:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [cip-dev] [isar-cip-core] [PATCH v2] scripts/start-efishell.sh:
 Add -nographic option
Content-Language: en-US
To: Sarath P T <Sarath_PT@mentor.com>, <cip-dev@lists.cip-project.org>
References: <20220627093105.21476-1-Sarath_PT@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220627093105.21476-1-Sarath_PT@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.133.104]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.631700-8.000000
X-TMASE-MatchedRID: zzMRqZEINU7rOhfRe676RwJfVW3wuXXEPg9yfk4YC0aqFx2c/3V5cVdE
	Emf6TRVBjiLABC6i+1jbByg0EdD+x0Y7rq7vfUPSj0IvV7jlqDj34jYPK09QMCAI8aJmq0jwnQk
	HrAHoKqaAsuERIy4Gkx0+UH/XuX1CheDJAd6wrjIvHEcEx0NzujLvC8LxRzod9u1rQ4BgXPJ9LQ
	inZ4QefL6qvLNjDYTwsuf7RWbvUtyrusVRy4an8SAHAopEd76vDtFX4OQOwhy9d5w6kmPpPERvN
	0ao2xsxHm33z3pD1t8JDWTVHA61MA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.631700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 5CB7A9CB2426B3FB49D8E84E59CDD2F826D01149A08A0AEB19170C5CE73214B32000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8fe2cb2-119e-482e-e9ab-08da583bfdf3
X-MS-TrafficTypeDiagnostic: AM8PR10MB4196:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oqOZZkIVuFzS5h5XLGEpF+g3TfmwHILLWy0eI1aOgZGfyyH8rdRDRo2nK5HJD7zBcFAIJ70ZuqQy1/Wb9OzeCDIgZnqF277cQkhGp6ZG48W3hyhUWYSK5TOMVAijzu/K31FJJOB7diQdRK6kZoVp1RUZcT3HHFEYt/0GlCOiNQIgG+3tdZkQCLSUs289myjj3MsbUYQpZ3eeCojZif5HaklBGR+QfdKJK3Qa8WJRDHsNMmQNnymxMI44jviJHpCQ5o7sjhp25Pen2P4YzYpyKCfmhcFHSw2JKzZyI9yRyTtdUdVZNvYZnKpVr9tUzE3BGISyIx1s5Ot2mcdgpzDKqbb3MPk6jjJYrQIuHQs8a7ufW3vLWEIwB172vcifZOQP+2wGrM345W3doycCr1050ZFQw3aQCudgmC1Aw9L1NCYGrLAc+Dg33Ap94vd5L6LukeF8iwB3cdXtbBEAFXMQqkDzf7nqN3qkamXSVsgRiIfVJWzfS0eAus5A1yk89rpWrc4Y0QdzCoMJGlB9FBYBR74NHUtXfJuuuhynTnXWnA/JYW5jYJevvkIr4gyVBRFOykpdmFiNodkaoCunpCSAXnVMDuCSVxvd8tJrEoEuxFpKhyH8vemRlxSiuYWnODPEk3iWuK1/03cDpcM9a2t1NgjERhrs7nyahn9w5e60LHP90o3WVQXRirRd7nI/wLmQ7kLMgEZWDgniqfo7ysjr2nFS5PNkhUI5jBmaVqRzGgIUb3FPcdRjKmlI0my150GIHUao79uT1/Sz7zEAEs1Hg4a71+Q4XfgkOkDkzDNdWQvmE9vL8VVFFxld2PhanRzQmdAyZK75OEZWmEWRj3BnhOcISLKQVxAoCXrc9c9QWXK7Dow0D2IzDN4pPYEbYskreLWYCglVpT3bFAfnIs+a0g==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(40470700004)(46966006)(36840700001)(44832011)(70206006)(82960400001)(82310400005)(4744005)(40460700003)(31686004)(83380400001)(2906002)(16576012)(316002)(5660300002)(8936002)(478600001)(47076005)(186003)(36860700001)(8676002)(16526019)(82740400003)(336012)(70586007)(86362001)(36756003)(31696002)(356005)(40480700001)(26005)(53546011)(81166007)(2616005)(956004)(41300700001)(6706004)(110136005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 12:53:11.2500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b8fe2cb2-119e-482e-e9ab-08da583bfdf3
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4196
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jun 2022 12:53:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8603

On 27.06.22 11:31, Sarath P T wrote:
> From: sarath P T <Sarath_PT@mentor.com>
> 
> Add -nographic option to support running the
> script over ssh.

That doesn't answer my other questions, but it's a valid reason.

> 
> Signed-off-by: sarath P T <Sarath_PT@mentor.com>
> ---
>  scripts/start-efishell.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh
> index d451f43..0831f83 100755
> --- a/scripts/start-efishell.sh
> +++ b/scripts/start-efishell.sh
> @@ -2,7 +2,7 @@
>  ovmf_code=${OVMF_CODE:-/usr/share/OVMF/OVMF_CODE.secboot.fd}
>  ovmf_vars=${OVMF_VARS:-./OVMF_VARS.fd}
>  DISK=$1
> -qemu-system-x86_64 -enable-kvm -M q35 \
> +qemu-system-x86_64 -enable-kvm -M q35 -nographic \
>                     -cpu host,hv_relaxed,hv_vapic,hv-spinlocks=0xfff -smp 2 -m 2G -no-hpet \
>                     -global ICH9-LPC.disable_s3=1 \
>                     -global isa-fdc.driveA= \

Applied, thanks.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

