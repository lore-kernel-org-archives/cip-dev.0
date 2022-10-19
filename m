Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7434FC4332F
	for <webhook@archiver.kernel.org>; Wed, 19 Oct 2022 13:57:13 +0000 (UTC)
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (EUR02-AM5-obe.outbound.protection.outlook.com [40.107.0.58])
 by mx.groups.io with SMTP id smtpd.web10.8431.1666187831539514966
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Oct 2022 06:57:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JLJsaCgg;
 spf=pass (domain: siemens.com, ip: 40.107.0.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMaO/i7+4u/ZIB1EGirp+2KaCiKBbcn4KG0ky5WyxyzzT3Gous55fa10RMzqfm0Uan/vXdDgmf2sFS+t41N3qUwkIKjpQqtIIm8rMRqs6Z9h5cduVn06MLD37yQR7vaApJvcZVZ0ZgQnSLHObE4XZ8F24QWfAFNGzylz7B0Cdn0sYutmb1suts32Cd+YPjzCrnmjUxpf39tWyJ8+5/e2lmqhiazrTxH/jgHqgfoAzdPIfpwQwatqyMt2r8g3FyyTj8UB4Z9Kz/TQLzz8oeiV3QB+ViMdpLwdYcR3vQaJH9e5eF/WZ4KUdlarojx7Ks7ebawxXbLhR0tsG4AEPV9csg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUQLqLr4rB5FIuPAeBpcaILM0uG3D2JWDUaf7de8mMQ=;
 b=HeFYqmioEoMLDS7bTkLBs+NsfwYNeyJkLKkQ57rTpKWORFknyxI7geX4XKOztt52t6vwXtAW9sSQOG6HkUuSaFvghBzpfz0FeLH+shylOx20NrMQUYGVNO8ffdb+QloOOOFPUxjrL07viNps9pt6nGwx07t0rBYIUk5KQ5CISpYePqCW34OpewIi53+rk5c0MOQtzI37GHTFSN9OfiOvF/VFIu1sQ/pSYSvwdU4AXG4AIslC4p6WOst+fXJxNw0H93p/npEFbrkXjngmcqZZxcUacXREh/4NJZzXkK4S7zC8c0UIWPl3aBk3mbusJGh7ca2V86gm8BrYQ3yOGhOEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUQLqLr4rB5FIuPAeBpcaILM0uG3D2JWDUaf7de8mMQ=;
 b=JLJsaCgg0hGsU2yGR7SQMa1x/EJGaQ7aIEAZKHc1Ud930VdHtMx9tRnfRGoaruZw+S8p+MRYEx1Ed6y9uwU+v0nYIXuWpqINf03jFv8cNwUnXwurLGO5rRh6s0td+pIM3DoyNNzcx6MFahHPWPsBCMxbaFglj6pbxl1Ene2g6ocNrqBDq79whvWfHp7ZxRNeARYnvVDXOxeDP2g98q3/CNA6bvxAN+bOxMbtnelzsaXXKV7QP1bWFrEMdVHOaXV1VfC3CVN9Dt5itRHmohDiKIJVVHQZFx0YLKAHWasufL+Msa+nwboWHHnwzrzXBODtcDMjx+7qSFDMjzeRwrF3Ow==
Received: from ZR2P278CA0004.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:50::8) by
 AM7PR10MB3190.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Wed, 19 Oct
 2022 13:57:08 +0000
Received: from VE1EUR01FT037.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:910:50:cafe::49) by ZR2P278CA0004.outlook.office365.com
 (2603:10a6:910:50::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33 via Frontend
 Transport; Wed, 19 Oct 2022 13:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 VE1EUR01FT037.mail.protection.outlook.com (10.152.3.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 13:57:07 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 19 Oct 2022 15:57:04 +0200
Received: from [139.22.133.243] (139.22.133.243) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Wed, 19 Oct 2022 15:57:04 +0200
Message-ID: <5a813483-3c27-9dcf-1e75-3bb229d4e069@siemens.com>
Date: Wed, 19 Oct 2022 15:57:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] Update ISAR revision
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20221019134351.420472-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221019134351.420472-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.133.243]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.491800-8.000000
X-TMASE-MatchedRID: /RB2PwB13wPdDS6etHbe26x38sCrHdkHPg9yfk4YC0Zwju9EALAXQquV
	OrDvB8LTBph69XjMbdlTHuQZZKa8u63aC25avUuaEeibLJ/yHITsAGjS6lxxKgi0LLplf+UvMHi
	1Ydy2WEh65yXsx03DxOyA7WWewtfE4xxPxzqqM17a++rCI4JwzZXvqupO0P3ML8y5bOx03xkORj
	M32hn2b8EguqiGeZ5Jo8WMkQWv6iUD0yuKrQIMCAGLeSok4rrZC24oEZ6SpSkj80Za3RRg8POO1
	wEdfAbgeNYZZ8ZOdwgH8663kPDdt7y+pIzedcjS9EoCEgUgYlI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.491800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 89175D3A951E2F5CDDCD9123FB0E272A4E077DFDDE6EEC5C8362203D32C7ECD92000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT037:EE_|AM7PR10MB3190:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d4ed55-5000-468f-2352-08dab1d9cf93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GeDIfKOGiQOZtGZ+u3zqPXLeaqkBEi/WFUCxpaYv3vVanXwpk1H1RHJ1qu9Eq2zNIbWYNk8DgJuYXxRzA2sufIDsYEwj3iU9eM6qUYv35M1zCAXbO5s76/qbQWVZhiaXR4s7LktSSRwDwmTeRAzUyIVsXLsIILs+h0HJaGw9NuxaLKHCslYUun6jU3MIQg8hp/RrBNchADG/76Z1RtKuyMdYA8gOEPWdahwcDPGXOjiMiSP0p2BzJ6RHUt4LsAi8+OJ55DjCe2ToZzKXz6K+S6oC6wk+mXQzzR09J2qxhKoaEGD7zRfMpy4cPjKB6E1/RvcV9o4m9f7Fo9eod8AX0ArrNMYygDjimL6QuzmVHviV+cGLBIh1OdbVgiDnJr4jmk5OjqKu5wygYAwS6CFTv9rQYj2tJ0LK2QYkXBXF9dva/NlbT1+2mW+ilhE3/Z6JJqLTAUNruFIeDeSebNG32fgjm8jHFw48u8nNuA5s1K/jNeCdUMOTWCKrYrFUgS+8t306GGaFZHClrZynCiCC23TdYYYnvHbgXXujz+Xy6ajipR45E5gJ96g/M1ZZkBjv5oBfnnOTnWNwKPlnRTOyYJLD2Qh9iZfyjGGsMg4mzFhrA5Kdh23z9F2QBNTpykjQbSK6qqrQInyMJ9oTzrODSW+RpGix22bxRFqujWoFXNoB20TOVdHaEn6RKp/5ysKm3ahl2He+M7dou1ug5L0RhxhX8uIHSN5avQe0VDDyHpZjeISnwZoky794/deUlN5vU7pZ818cdqsBpa/G5BHUMxsd2387VdDIAhZZyC+jsRJJI8Wz0u7H46nf9fPbv/b68czVTR0LO+RZKe9hoi77EEmZnfRY/9x5+HxhoSqF9jvVWLQnWL4JM+kdsB4zkhFc6If6BVtAM8VO83zW9cLZ2g==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(41300700001)(82960400001)(6706004)(44832011)(31686004)(5660300002)(31696002)(8936002)(316002)(16526019)(336012)(16576012)(956004)(478600001)(186003)(36756003)(70586007)(26005)(53546011)(47076005)(2616005)(82310400005)(83380400001)(15650500001)(86362001)(8676002)(36860700001)(2906002)(34020700004)(110136005)(7636003)(966005)(70206006)(356005)(40460700003)(7596003)(40480700001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 13:57:07.4423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d4ed55-5000-468f-2352-08dab1d9cf93
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT037.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3190
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Oct 2022 13:57:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9792

On 19.10.22 15:43, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Update for downstream layers.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas-cip.yml          | 2 +-
>  kas/opt/swupdate.yml | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index 24062c5..10f4594 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    refspec: 0daa55195f0f55465a367aec1ceeec5f26c161af
> +    refspec: fc4f004eb67237d9d09b1ffad0de1a19217fa94a
>      layers:
>        meta:
>  
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index b2bff64..f0d3f1b 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -24,3 +24,4 @@ local_conf_header:
>      IMAGE_FSTYPES = "wic"
>      WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
>      INITRAMFS_INSTALL_append = " initramfs-squashfs-hook"
> +    WIC_DEPLOY_PARTITIONS = "1"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


