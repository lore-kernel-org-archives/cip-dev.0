Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F370C43334
	for <webhook@archiver.kernel.org>; Mon, 18 Jul 2022 09:55:31 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.80])
 by mx.groups.io with SMTP id smtpd.web09.25280.1658138119362532192
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jul 2022 02:55:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GTP/5L8p;
 spf=pass (domain: siemens.com, ip: 40.107.20.80,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhNIxsY4lb0v+ieNv0F5LEgKooE1jL1UxIECYw03Pfra0QqGLOWzl5WsLg/NgBBaT4n+Vo6Wq//TvY4F4fROn6OXEvj+XJeNa/JHosmxC8GHCS2X8lLcF9NxflYtOw4R/YI5Jinqluj+SLwIJpFWY5MPN5AD3Hpai8Um5jfp0y3SZk++KmGbJBrsL+eHF906r1TYWw/wXZe04EFG9UOCKkoKQid4pG0IfNS66dmBrWliA5I3G5Bowj9/Pg3w5cmIuIBusSXvsOAL25kT+XGsL1/yqaI4ilg38o8hvPhU/92pdRDrb41f6Ov/yCuvmMac7vLYdZb+f2XOwArFIt064g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8spxxCT1ude+HWbmu/Qc7gmimHYOUcvJGrHkaBa/cY=;
 b=bLiKmotb6GVqg+HxawQBPQ8pY+nr43ka5Dx0fSCe97FxWZAsjBmjQgyLsTk0eflJ4t2yNd55uQCrONPgT6gBfsEUukRWJd+9J35PpIMSDBVuo3s5icsavu8KMkEY3BbdZNwIIIXZBEoxF/Hv6U9gkVm0aiOqREEf99VDppRcME1tiHw9pfB2krjfzSQZ+plOinyf0P5Xt3TvtFRCvK9aJcPKMGwTK1P1prvbrB+fmhB4V8pPjWOC+rieDNLkKN0oOyBnONldbEfPFDL2lf9k+iJx/wL2jmNfx4U86IG+i8Bs7G2/PeB3Uwg1CbRLipmjJiw9sC9TF0598Ged+XC/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8spxxCT1ude+HWbmu/Qc7gmimHYOUcvJGrHkaBa/cY=;
 b=GTP/5L8pzFrKO5FkWq+A1M6mYOBoVBxO153I0GGNrShaQdH/S6sgTjbyOpCXgJjfsBZFxkWTIJO2J39L7iCsiSVh2sVhQMKFxOjRtkUcV+VezKzeLBLQhMsF0tLSSSOojKvufdffZAvf1I1PkL1rt0E4FpGFTziTP6HnpX/6cLbyWoWRagJXuwJi5bL/+AuaIqKhvIflzczvGII03JQ9kGU395/XCafOrWxV8kj/qeQ0Qx/yMKgQGRG0O+sGD7aShYU31dS+TgZQ5cY8noY5GXeNZ38Q/SUu7yTW5J5Ox8a6Oa/mNGBkx9Zgc2BeFw5dbrSWhCfr6k5t10Me+/zRAA==
Received: from OL1P279CA0022.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:13::9) by
 VE1PR10MB3375.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:105::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Mon, 18 Jul
 2022 09:55:15 +0000
Received: from HE1EUR01FT095.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:13:cafe::e0) by OL1P279CA0022.outlook.office365.com
 (2603:10a6:e10:13::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14 via Frontend
 Transport; Mon, 18 Jul 2022 09:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT095.mail.protection.outlook.com (10.152.1.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12 via Frontend Transport; Mon, 18 Jul 2022 09:55:14 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 18 Jul 2022 11:55:13 +0200
Received: from [139.21.19.101] (139.21.19.101) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 18 Jul 2022 11:55:13 +0200
Message-ID: <8c62ad7f-f278-c9d7-4428-3813a985cfb6@siemens.com>
Date: Mon, 18 Jul 2022 11:55:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [isar-cip-core] cip-core-image-security.bb:Add
 libpam-google-authenticator package
Content-Language: en-US
To: <Shreyas.Karmahe@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <venkata.pyla@toshiba-tsip.com>,
	<kazuhiro3.hayashi@toshiba.co.jp>
References: <20220717124920.4114812-1-Shreyas.Karmahe@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220717124920.4114812-1-Shreyas.Karmahe@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.19.101]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.175200-8.000000
X-TMASE-MatchedRID: 3OnHKS+pL/QwrKi3eh3JIsb9CgEQmMW5Pg9yfk4YC0aqFx2c/3V5cTim
	0TkqdUtejSdnJC0YNlHX6TGug1j07rIw4X32YYkcfCMTxrfIk155TlbAsovI9PSG/+sPtZVk3Sk
	TY86NiDiSyECgVwbfJEAc6DyoS2rIjf84k1uW53h3IE+1hZ/O9tLYKRd+gtJebl4CKqupkMr0VP
	vT0zx0mKfub87GOZij8P7ohAxHFTni8zVgXoAltkWL4rBlm20vt5CrqYXZLj+x5amWK2anSPoLR
	4+zsDTtyMdyHKes7ltMPVuhT5DHq25P5AJBqKRzHFjzLIhwGQqFVw2E/orosQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.175200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 08F2B0D0F8E3DCE2C6FF30004FDC4EB35E84B83A0708C0AB957C38A20F4FE93B2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eab58721-3918-42f7-839b-08da68a39cc2
X-MS-TrafficTypeDiagnostic: VE1PR10MB3375:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	X0a7V7LEQWiYQ4VZDmzXuH+IShhwPa9NK6n8l/bCGg8vOB6XgepVP3uthcdOM6JvIDqdxvi+4qz3Aaqgl2vXEfWD9ZC0Kr5buTMvaRjVMamtxZXWeOv+gbIIDuAtd4BAdCvobbv8YV/2/tGjN8OAW+E0DioPF1z7w8VRosety15d9jDecDT9r3WyQgmu8x7E6aQz/wOLz9BXLsC3LoEoBAmGYN1taxXQbQE+iIFlMu9Vr2XIwnXXyLsOwzojwLGfLk22nnRnnZaHG+kAvezfAnqOitSjfmYG2qQnKiNbheZGfbypM8GicdKJd9CcG0baX1/8i73HVmj1P8Jm0kZ8U8vB4J6mFsW5kwKA3nVFUtIt6atymrkzvs5oqP4BQyMpFtZIWms91TobcSMDKarDfE5HVDOKPkGfyn3jzvuX3H+AX4TJ224vtZwq5417Ld/FVEJwcOAfb0EL9UI+E/3N9pwvkU6O4MpBUBkErFMGYF2N/qzcjWO4+qn0hDQ5LjspXEQYRLH2rxcEBK9WsaL5SLqn+KtCAA6b9Jn5nB9AKnUxdRTlMX6uRWRI+UVkc/0kTwUpcEhb8bo17Gj0U/psvcDtGjmY+Jjfs9RxopP6tBlWtvprKO+0kbdXP1OpFE+NTX6HEV0gaEEtePJ5x3CDyhTQJXMZHVK/eD6+SgVX86V4A1wo+o0U1y4beLQNAlaa3yqnAAv+d7B7ePXyrZ94rupvCjaTyWBdr0nC75SBKBji6JOWo+erx5HeA86P/IxJOyecaWpa1c/Wly3vgG36+4Sqz03nUbcmDw5sw5BmvhYwqw6l48nHlRvRaUVWz1+de3btZgmEgLFifQH6h+AHACqF1pnHOBB0qJKshlAPmlTq2uvsacsil+fxqaCq+lEfIIUIoi/8P11wkaUMtwXBCw06NvU2UlQ/VeTbpeuUQVA=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(36840700001)(46966006)(40470700004)(36860700001)(316002)(16576012)(40480700001)(70206006)(70586007)(356005)(186003)(82740400003)(82960400001)(6706004)(82310400005)(81166007)(110136005)(54906003)(40460700003)(53546011)(26005)(8936002)(5660300002)(44832011)(336012)(41300700001)(36756003)(31686004)(2906002)(15650500001)(8676002)(83380400001)(4326008)(956004)(47076005)(16526019)(478600001)(2616005)(31696002)(86362001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 09:55:14.4516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 eab58721-3918-42f7-839b-08da68a39cc2
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT095.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3375
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Jul 2022 09:55:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8859

On 17.07.22 14:49, Shreyas.Karmahe@toshiba-tsip.com wrote:
> From: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
> 
> Add libpam-google-authenticator package to the security image, in order
> achieve the Multi-factor authentication requirement.
> 
> This package is already added as a debian dependency in the
> security-customizations recipe, and also mentioning it here in the image
> recipes to make sure all the packages required for the IEC requirement
> is added at one place.
> 
> Signed-off-by: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
> ---
>  recipes-core/images/cip-core-image-security.bb | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
> index 6060978..24b1f46 100644
> --- a/recipes-core/images/cip-core-image-security.bb
> +++ b/recipes-core/images/cip-core-image-security.bb
> @@ -33,6 +33,7 @@ IMAGE_PREINSTALL += " \
>  	uuid-runtime \
>  	sudo \
>  	aide-common \
> +	libpam-google-authenticator \
>  "
>  
>  OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

