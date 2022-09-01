Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B525ECAAD3
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 20:10:49 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.62])
 by mx.groups.io with SMTP id smtpd.web08.17561.1662063044350246314
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Sep 2022 13:10:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TVLeOHd0;
 spf=pass (domain: siemens.com, ip: 40.107.20.62,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wmz7PL8r0jrPX0tlwfWQscPEiSoku5pXJWgDZyi/y2OsfgP77o7emIAI9dVJcgNvRpSbE+lQszVG+otZeXY6S0+luiGIFchNQJq58peZTp8PYETjvOea8dUm8ZQZf9ohdtZAseuBziqfstj4T1oIKbflpW4UJK9EKH8ocqMEusjvz9fbJJ+qoYHUfdvgeuy0fyBUUQOk7zU+xZpTjJyrIDWJlTq+P5iQT2CaFWUpjjeVyHpJJfWunTr+ytuyy4x0BRE3rJqSIacTp08NtVz9RsvfrJQXWgWJnK2SSY4s5haMDkKFBwEeI5p8qgoXEHKunPYthoixptaZAC4F9NAX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s88rrBqEzWt4oIK1+8a2jWvHTPBBPFgpqWy0cJgCfXE=;
 b=YSvT5OR5/fSU1rQ4R60hwtlzJhEgJQmXbtDCKqUWWi5f/GyjPpVsltJiAE3AxI5ij6zsuiJ7QvKmjoZ0QNDK0YIr4atf3aNp3YZKhE+NIF9FDXeW1K6tZUnRjbh/CNWakXamCPRS2OjE0wtfCntec+t2VRgkIgD6nnjHUgfFEQ0450AgVuzLl9+73cLKaf9qo/vOv1aoNzcRVyWrMDqPilZmW1MHeygfZ8vctSiAEKg0KSUj7fB+p7nQWaY00Dy+GC/x6g7J/UFdLW9lgw1EvAHR+mgFSApI9h49MjDgEFPR+C9L2U0Jlpf3MCJ51CWjfJtu8g/AHdFax1gJ8Todzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s88rrBqEzWt4oIK1+8a2jWvHTPBBPFgpqWy0cJgCfXE=;
 b=TVLeOHd0ZS34hEn8J9A9u53Z2PtZJy35x/wG/P30uR5cTi7OREQ4Q6RQwxEN2tEJywJP1aEOZHr+tXJIZai47brzNCh8yWC0unMiL37NhzMqAHuE/9Ux4qRENgXwFXLCE6Sy2iISfg88RrZZdXgmNvDCRTZ4KdPtXdl/1sCHVeG/ajzPduu6+nr6cMP62PJQwLREV7mccgaIVshukmVhqVKBAliSIdhVPGGAguyKnIXIiwyWm6BvZgeOWP2gbwgK5x7j5FkWoGDcymOw5Z7tvJ0tVRzvp+u5LxKM+08kJahut9J8BZPuVExbN6iU+HZUKMEJm2okp37hMc8a7r4B8Q==
Received: from DBBPR09CA0008.eurprd09.prod.outlook.com (2603:10a6:10:c0::20)
 by DU0PR10MB6702.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:402::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 20:10:41 +0000
Received: from DB5EUR01FT057.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:c0:cafe::b0) by DBBPR09CA0008.outlook.office365.com
 (2603:10a6:10:c0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16 via Frontend
 Transport; Thu, 1 Sep 2022 20:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT057.mail.protection.outlook.com (10.152.5.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 20:10:40 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Thu, 1 Sep 2022 22:10:40 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Thu, 1 Sep
 2022 22:10:40 +0200
Message-ID: <e8c40664-a766-95c7-ae02-85c507ab1b99@siemens.com>
Date: Thu, 1 Sep 2022 22:10:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [isar-cip-core] cip-core-image-security.bb: Add packages required
 for IEC security requirements
Content-Language: en-US
To: <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
References: <20220901145554.11456-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220901145554.11456-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.675300-8.000000
X-TMASE-MatchedRID: EhMq+2gclHswrKi3eh3JIsb9CgEQmMW5Pg9yfk4YC0aqFx2c/3V5cSNu
	PSSuOWltjklQr1R1iScgGlwZgKWOulR5ZeOtcr5O/vIzZewJd/yplEyHVtAnRV67ppG3mtjJ0Nn
	UUVMlTKYHZBaLwEXlKIPcXuILVCbadXYa38UIbTtHHcnuUG2vMAAnYruoVDk5jrVn4cme+w4ujM
	j6uE1hubbMVaqtU3gFXjesFOd0pM7i8zVgXoAltkWL4rBlm20vt7DW3B48kkHdB/CxWTRRu25Fe
	HtsUoHuSUfGPcjJsFJfuu0BhZjek+z9m3rVPiMLxd79+GJikSmwFMlIPaIBbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.675300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 C8098EACE1CC5AFAE12F892FF6F6570F61BDA021DACF52E24B39B4F36CFC783A2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21189afe-d466-45ee-4515-08da8c560b18
X-MS-TrafficTypeDiagnostic: DU0PR10MB6702:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FQqIyr7cZpDz2jLUZ38pP4lnRMtm2da6Hp0Ros9Ntut/gPIuXdEO0Ds2XwHgloFR+l/8t69qbduf0LLqHsVZ6QJJMP9BW0gAULxNkguixYWL1mls4a2lii31MbLF1kwCeNd1BBPD2mzZPUvBieJRoeHcVO/qESV0Mq+0c5ZVfYDSKbzxUDv9nSj/iQUK+cDlGuEEK8QmNXsCJpk/hrVkgAASJQTcmMUUMqR5Rh1iilnuJJmRXPzGR9yRune8bcEkRLmpN8xujfFgVgp3P89K4ApzSz/WmzCztW1Q4P22SQM/PB6xNj80311S+n8XK4f71YGesrjpyuOxqr57vw8zX8HzZmeIZdoKB0v3nPbMOXcu3O86QTihFNMZE6rUvTz1Yhun6cByeke9Qyx65MAcWmxSx46/lt5RMMV3VvGNtP15y4LKOnkwsLRoswc+whCdT7dFgFT4Yxn/+z95Y+/VnFvsG9hfJu40Hc94qcFsA8jKTPLmH4LedwFBD47sUGx0Uo2EcEo7tAY3mmes3z9QpwNpmmtDMen4Tqemo/08RzodjMa2yrggTtRZmLld7jAuJN+IRaBb2TjoJCT1j2oQjoId29/b8HJCKm1PV1K5HOTZJFi0GIdC129fccGog1Wh2rG1lnrxMQ5POBpP+iGiRnMjgytHu/5SV7t6ygYn0WZK6U+obYItpIIb063iQCOYWxEB3OoyCrA8S/E2r5e5+IeSoMHVb5HB4F1Lb/QyziY9LtO70IjPuToymTkJH34oZWMOtz7Z49nrQLdEtDIsEKH4NrfvYUtpOlNjGvSo7DmEb3PBcIe6X0gajWAqOrr/bXgG/HarZ+OhMsrcGS9x7yod2wCRlZg06yQK61kkGwE=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(346002)(396003)(36840700001)(46966006)(40470700004)(82310400005)(40480700001)(8676002)(82960400001)(16526019)(47076005)(2616005)(336012)(31686004)(186003)(53546011)(26005)(5660300002)(4326008)(70586007)(956004)(41300700001)(70206006)(15650500001)(86362001)(316002)(6706004)(54906003)(81166007)(83380400001)(8936002)(478600001)(44832011)(356005)(31696002)(2906002)(82740400003)(36756003)(36860700001)(16576012)(40460700003)(110136005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 20:10:40.6781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 21189afe-d466-45ee-4515-08da8c560b18
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT057.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6702
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Sep 2022 20:10:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9424

On 01.09.22 16:55, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
> 
> Add packages that are necessary for IEC requirments, even though these packages
> are installed as part of CIP base system, mentioning them in this recipe will
> make sure the packages are installed and also it provides the information of
> what packages are required to satisfy IEC requirements.
> 
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  recipes-core/images/cip-core-image-security.bb | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
> index 24b1f46..8ea032c 100644
> --- a/recipes-core/images/cip-core-image-security.bb
> +++ b/recipes-core/images/cip-core-image-security.bb
> @@ -34,6 +34,10 @@ IMAGE_PREINSTALL += " \
>  	sudo \
>  	aide-common \
>  	libpam-google-authenticator \
> +	passwd \
> +	login \
> +	libpam-runtime \
> +	util-linux \
>  "
>  
>  OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

