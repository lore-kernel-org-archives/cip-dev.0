Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A153C433F5
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 07:03:19 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.53])
 by mx.groups.io with SMTP id smtpd.web11.3473.1639724597808264642
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 23:03:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RBRiD9Wa;
 spf=pass (domain: siemens.com, ip: 40.107.8.53,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTMGxXbCEF8wgBEZoQwGdBse45lYCaVChWIm6Z5FqguKbfkFlOHZ/eBMYjQbEHTuiM5sLk7YwuNNaQXethhXNlBhs0Wmcm7b6W0cYvSI7jkMy/l/5cH3XH1rQPuQii2oanwbABqEHx1G3Pvm7FOjvs2A7muXr6ooBkWZPc8kx22fPjDrVtrGxPKFxFhqokASO7kg41D5oZ5ccMjvBB7Fg7w9zr/yf/ZLYn7AFVQAFsbcgHJSfLNx9PMF4t9W1giZhRqkzKXgOwbO9YVDf6iveD4qdBLmhJuaeLBPs3j6ITy5PYwTAwmanaR3PIzSm9TizKxnizp63dWXR4FKgwuXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QM6w7m9va53mnSD5hyNu6yP4bK3qpK+V64hNFzCscs=;
 b=CdXkaHvVfZtTDBhk4yYiCuFqNlV6GlGELxV4yuxqKVfxg87NVROqDgz49NvYXvcvGC7SeTFNQ5D7vsP7hbh7Tb2xbtbRcOXWmjJ4aJp/Zr15sQGsPp6/52s5VNOKLdBWETJSTuspYEODfPB1ErZzDRhDp/PlWfoNBg+aN0C+2Gu68ER0Ul7yOP+yh+Z5eLnayqS/jClYUtW6dSztpDJHxqasYn37S87MiNU77dvUOd4r+AeckNHt6CQMgtyfFfqaX4n8wUr9LKeLzW+VHc4KluZwAlEJwltWA6AG7cYko8HbevWaHykbwZ4JSVEfktynCo85qVO8yA6FEgTIfsylQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QM6w7m9va53mnSD5hyNu6yP4bK3qpK+V64hNFzCscs=;
 b=RBRiD9WaHDSA6GLD/H7jwHH9B8jyuHJZjlBRbtm04Tccb/hwdPS8KXHOeTkosc/XwlcxYscaCaaMQNmP8jhed2a4Nc6iZ/YfbwofyGSWNjF5NLDkl0DcP0DZwGqO6k0lGQjNsYQcJ7dBrQ/LZLcEC8lF2qqJ8526J+qIS8Pnu6W4FUDaHcC83PdBCYZTzq15xxmWjyWURUQCP+8AHLw+/kVXrCO+duoBYeEsMuiZcVgxkWPrghyYbtI4ui3H8qAq9CjceTCZPrP9XVfdGhKQREeDtBMrr1nLH3E9GXchi2y7EBtNvPMpeXbqkFPca9bnTFeBQbwmgyaAuD/h8jOR2A==
Received: from AS9PR06CA0246.eurprd06.prod.outlook.com (2603:10a6:20b:45f::12)
 by AM8PR10MB4660.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:368::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 07:03:15 +0000
Received: from VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:45f:cafe::2) by AS9PR06CA0246.outlook.office365.com
 (2603:10a6:20b:45f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 07:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 VE1EUR01FT059.mail.protection.outlook.com (10.152.3.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 07:03:14 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 08:02:48 +0100
Received: from [167.87.72.12] (167.87.72.12) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 08:02:48 +0100
Subject: Re: [PATCH v3] swupdate: Add nodoc for buster and bullseye
To: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>,
	<cip-dev@lists.cip-project.org>
References: <20211216164842.3403906-1-Vijaikumar_Kanagarajan@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <48b4432a-171a-7bec-d6cf-b1e86b21d53b@siemens.com>
Date: Fri, 17 Dec 2021 08:02:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211216164842.3403906-1-Vijaikumar_Kanagarajan@mentor.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.12]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 942b4b4b-bd27-4210-9934-08d9c12b4b9a
X-MS-TrafficTypeDiagnostic: AM8PR10MB4660:EE_
X-Microsoft-Antispam-PRVS: 
	<AM8PR10MB4660181AB66B6EE2689838B395789@AM8PR10MB4660.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jlay+YDC/C+f2WqFI3m7HkXEvpUv+xG4qPP3y5rbH2bwF5Oez2ALZ+mITx5Jd9IQjuyFjKd3Zs4jpu7RhZbNcaPAwOueBrSeKwyjUgLb/E7V9ztJEO63iwRzw4Ho+UfkXbcWPu586RPpyydmPdNAJM+jUmbdZGt+7TpY858RMeYirmNJnxAbjEeVNKfpCg2TT9eamuDYjqMLgPTWdzf3n0oGa5HBj65rcOzPZojJfcfFnJN+KiI2ty0C1e7XYlRs/Y4qdNtFU0gZMeNvA8g5YH/7Mrd4b+LHry5siBZE4NB4/DC1dzNS6B1NLt7JSMZ78yqQAJKKfQQ4zf0xOOZrp7oqIseZGYMHPWoPscQudBxMPh9tTBb3uljbgF9SUia0H3SsoZ6a6AsKzK6GLORe0GOWelng2nM2+dmfR78zAB31PgRNE4OGqhdS95ZdMMHimCoyP/le0UerHE27Gh3mAqGMSor2JMpc8WQmZang9pk1SV6E7Xc+qfXrwgv25RoJwd1AcDq4w880vQe3LwrHnJ1U6azN7kDHjlRDDp9Oo+AXnnIYfPk30sUUdxbTXe9R5ARtQsPVJfYQBcRsI2a8FXQTZxghtLf8RLs/17FI5IvvPnKBpmVFIbw5iDuSwRLE4tAgMBnqNXrDWJS2vcUnVSd0gYV7lRhyU/snlD2tzcKBGIEHRuUHq8u60flT+o24fpaWLwsj0VFZ3Kd36tB/Sh7lTet2govBRQ8xTQ9F/jKSMW35B9Qqu6CVLMGJiuYN2BRrkOLPLAaj2Dm2NIL8DOHxVgAwSKLN3akca5cuWiQmrZKGLgg/4sAuasJ2ahFfZV1kg38LavGv0qnZTh+01zPOTlx4hQe5MfVMRVDeR+E=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(70206006)(70586007)(40460700001)(6706004)(508600001)(86362001)(356005)(16526019)(83380400001)(186003)(26005)(82310400004)(2906002)(53546011)(47076005)(31696002)(956004)(2616005)(31686004)(16576012)(336012)(81166007)(82960400001)(8676002)(316002)(5660300002)(44832011)(8936002)(36756003)(36860700001)(110136005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 07:03:14.2844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 942b4b4b-bd27-4210-9934-08d9c12b4b9a
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4660
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 07:03:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7168

On 16.12.21 17:48, Vijai Kumar K wrote:
> Including documentation makes the build fail in buster and bullseye.
> Remove it.
> 
> Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
> ---
>  recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> index a4d67fe..e25ee4c 100644
> --- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> @@ -44,12 +44,14 @@ SWUPDATE_BUILD_PROFILES += "cross nocheck"
>  # modify for debian buster build
>  SRC_URI_append_buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
>  
> -# disable documentation due to missing packages in debian buster
> +# disable documentation due to missing packages
> +SWUPDATE_BUILD_PROFILES_append = " nodoc "
> +
>  # disable create filesystem due to missing symbols in debian buster
>  # disable webserver due to missing symbols in debian buster
> -SWUPDATE_BUILD_PROFILES_append_buster = " nodoc \
> -                                          pkg.swupdate.nocreatefs \
> -                                          pkg.swupdate.nowebserver "
> +SWUPDATE_BUILD_PROFILES_append_buster = " \
> +                                   pkg.swupdate.nocreatefs \
> +                                   pkg.swupdate.nowebserver "
>  # In debian buster the git-compression defaults to gz and does not detect other
>  # compression formats.
>  GBP_EXTRA_OPTIONS += "--git-compression=xz"
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

