Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936DBC54F65
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 16:03:55 +0000 (UTC)
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (EUR02-AM5-obe.outbound.protection.outlook.com [40.107.0.79])
 by mx.groups.io with SMTP id smtpd.web08.8696.1649917240818214480
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 23:20:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=CCnzkoCD;
 spf=pass (domain: siemens.com, ip: 40.107.0.79,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAiQ45FprVsL1QAQcTfdY4+b448kgqO2g6PjIpW7wfCQvYJ/LngE6UVrpNnuBcsyDxacGPsWRX2wk6ri0uAfwvW05kHt0+FUWqZn0tBpJGjginpPnXbSMJbe4MdcEW1ImPDM7ewvdzlLGbcboOjD91EMQE1tQZPSJLwbhrnAOqKzGFKpqhh9UmKVsglqngp/N2pIx7V2o7TaqYRwSEVi/BV5xXU9QaMvrylJUsIf4YKf4LnG7FF68FVdLoqaIbtTJiYk8DLSFdK6qbX9T+jSKHHoUamnwH5nSlqiHdFm3wsggUGkDkobN/EFy392KIfnepU59QOIM5HJbhbNjY0d+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IT6o15PsURfePJst6dpM8izwOtB0aRRARc8RhccaIU=;
 b=jELZe6t9ngqwJgJ7tEyPA9B7lArOIDD+LLIBGMuLdlqMtzqg3do1G5a2rvpo7kWXBjURfzEOMRQ+iV3cOMVF+zdu5g7FY8uZZu9+YAkys3kZUEtvSLFXtPG10KcFQvCFIyFc6NGle58bBJeSbCtgP2sjgtcworJhcq8me3hORQXhqDFkP1zAq1tcRfpV/nfNC7G3hnbcTnVpFqMox2H6AoAdNq09zPpbrnIcgTFggiem+dVU2OJ/8xQ4c1HJ5g9K8yIc8x6kjBN3hDLUWyuE9eyl4TZ3urL+OhDegI7FqSUtcjkJbN+PqUhVgpPEYa9V5i0Qv/g0kD/9s/E4hDBdoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=moxa.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IT6o15PsURfePJst6dpM8izwOtB0aRRARc8RhccaIU=;
 b=CCnzkoCDemNDzv2SnCQH6fclUWvt1jhKM6v9F0saBIBBE/UppxFo9lFBOSI1fUdCs+v9oLgtWXaRjUUH4NttBNuZXBpeA6nECqJwHTnbAWQLmKwH9BWQ09X+AgQjxUliKtKi3BWFH+JvjoT6F/BqnpsEyY+y8Ih6c267a+hbVgR/E/k/INdWijc8mqOidb4dNn4kdM/6hDCw/HwzT2iPDAtJpLKNsdw6NgNNpRy9kXDVCrk4lV+f/vDUauh+u3aeP0hhZLlpO00NuWUzFDB9AnmhaYIrdreUVgAUkwg0FXgmECGODS25fTfOf7C/cwL97S0s4VeaTEcxOEBi3ffdoA==
Received: from SV0P279CA0047.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:13::16)
 by HE1PR1001MB1212.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:73::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 06:20:37 +0000
Received: from HE1EUR01FT004.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:13:cafe::6a) by SV0P279CA0047.outlook.office365.com
 (2603:10a6:f10:13::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Thu, 14 Apr 2022 06:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT004.mail.protection.outlook.com (10.152.1.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 06:20:37 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 08:20:36 +0200
Received: from [167.87.32.156] (167.87.32.156) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 08:20:36 +0200
Message-ID: <1e5dcc0c-6b4f-1fa7-3e01-200aa6468f89@siemens.com>
Date: Thu, 14 Apr 2022 08:20:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH linux-4.4.y-cip-rt 1/2] arm: dts: moxa:
 am335x-moxa-uc-8100-me: Add new MOXA model
Content-Language: en-US
To: =?UTF-8?B?SmltbXkgQ2hlbiAo6Zmz5rC46YGUKQ==?= <jimmy.chen@moxa.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: 
 <SEYPR01MB42723C86A5D4FCC894BE3AFFFAED9@SEYPR01MB4272.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB427277235B66D7F0856B5E79FAEC9@SEYPR01MB4272.apcprd01.prod.exchangelabs.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <SEYPR01MB427277235B66D7F0856B5E79FAEC9@SEYPR01MB4272.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.87.32.156]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.666300-8.000000
X-TMASE-MatchedRID: a2rrTcOVXHlmvcelz2C5QLQc5DCOw3yNPg9yfk4YC0aqFx2c/3V5cSkD
	YTG6KmZagCOzL6v7C+fd1BY8NqeZC9FChERArRPnj0IvV7jlqDhI2JoaZhHcbsEvKlG0CjjITsh
	xekO5n0stferJ/d7Ab2Bt9mS7pKVTeoqVs1ZLrvAzd+tJEfcx1FxxDx5qbkR9gxsfzkNRlfJq8/
	xv2Um1avoLR4+zsDTt+Tf0tcxKuLoGU3WKueFtlwhYaVWrUfsjfh8BtNg/MrtnWMydQiFnvQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.666300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 E81ED7C66196CF32CB0C8A1B197C242CDE2C1FDDD2BA21C98EB5BFBFE0EB43002000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c29cec14-68be-4165-140c-08da1ddee439
X-MS-TrafficTypeDiagnostic: HE1PR1001MB1212:EE_
X-Microsoft-Antispam-PRVS: 
	<HE1PR1001MB12125B79BDA687E4479BF8B395EF9@HE1PR1001MB1212.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6CfS5rlKmRFHOZhA6Acl4edkZDNQV3TX0xlXOjf4s6cpmA/prg9Tv/ZN6YEHOLIo1pveaQQN0rWCUEd+E7JZ/USyIeMBChF14tp69WO/iWj8obF52iBwkAS7bwR0LKqyPSu/vHB6kXzZ0SFIBSJtgbY2KSNNDS7KPiufgfKAXdCrQhsNNPfwXn5N9Itzq3PQ7hxDeMlTgDiZWGzHW1g+1jHSm0M5rGQiin8hz1fMHlijSKjq6b/L6VcLsG5LuMOh2QO32YOomRlwesruDp0RrxRLZYxUcgFgtOJrcEQDUktZMCXSUqZRfUjXiQcdnPyJuq6d+aK5gPlEfGXl0yoKT5TWVj5NHznpK51DMsy8a653GAJlb8sIDYbjWcNThN53I26tNWXYDet2vEg+zcnn9u92EAd5MfkrEpGhAZeLyga27hGFpgI4w+93cQhVPeQ48Aa0IItclSc4CQS7Q6uzWEuO+yUR7WbGNmNPls/wwKwYw67Q0QHOLZ95UXXb4juHS9Fa5R7PSIEo1BnGbUEwoBSmxpj6aYrlucJOZpeBOHxWHWVnHIRQ7Fh74MDJw/Zjj1lZW2b9LLey6L/6rkR1GjtBWOpKRgKyOPkG9Br460n3/cmVMJPvdxE6reZZY08bSyYQZDJxLL8xodepDARLG5iI0c06w9go3h8dHw7nZWhnlOERmbLCy2GKdTcWy3N7mKzI+bm22E4RqgV8GSP2KJEKGkxlKe7Tpo8kbIIzfEo2DxOgyQFr0CyFKbo+4xpG
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(70206006)(40460700003)(186003)(36860700001)(16576012)(7596003)(36756003)(356005)(53546011)(7636003)(31696002)(498600001)(956004)(31686004)(82960400001)(86362001)(82310400005)(26005)(2616005)(8936002)(70586007)(336012)(4744005)(47076005)(44832011)(110136005)(5660300002)(6706004)(83380400001)(8676002)(16526019)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 06:20:37.4456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c29cec14-68be-4165-140c-08da1ddee439
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT004.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB1212
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Apr 2022 16:03:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8095

On 13.04.22 10:45, Jimmy Chen (=E9=99=B3=E6=B0=B8=E9=81=94) wrote:
> Add DTS file to support new MOXA model (none -t version).
>=20
> Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>
> ---
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile inde=
x 0bc7ae92cdf7..b706d47413ff 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -464,6 +464,7 @@ dtb-$(CONFIG_SOC_AM33XX) +=3D \
>         am335x-evm.dtb \
>         am335x-evmsk.dtb \
>         am335x-moxa-uc-8100-me-t.dtb \
> +       am335x-moxa-uc-8100-me.dtb \
>         am335x-nano.dtb \
>         am335x-pepper.dtb \
>         am335x-lxm.dtb \

Wrong ordering, or wrong structuring. This commit alone would break
building kernels for ARM.

Worse: This is not upstream. Add upstream first, and once merged there,
we can back-port.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux

