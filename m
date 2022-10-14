Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF57C4332F
	for <webhook@archiver.kernel.org>; Fri, 14 Oct 2022 05:49:56 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.52])
 by mx.groups.io with SMTP id smtpd.web11.4218.1665726591502777668
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Oct 2022 22:49:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YC+Iz5q8;
 spf=pass (domain: siemens.com, ip: 40.107.15.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uqmwwhjaw2On4cYRE9nFLgx9Y5y5qSLVDVkQiRRFKTjgudMPlDeFONeArmwdKJR+YuhUulwhBQ0FWKisUL2QPs4G+KA7a9nOtaJgOqENztuAPk1Z2R/gi4KGZA+CMQeaf+EOniJMDxhFfgSCQDvi8DDXdmiz488oTUM0jSAljIypLBOvZ9Ju2CNVjpSbA2+2K5IWvPuk7hnxvbjmM+/FN0eoPLupAltDcBq2UCeFwhOdAPUP87Dxk/183NmpY93EYIz4oxkU2CK8vEugbAeQGO1+2BDIQEbcaN2aCZwou3eJ22CDtSW4G60etFQRDOWXtnNOmZUbIQcDzinzbDPQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mV/aJ2BqgrLTeN6d8kW8t/y6t+kMS9UfktOuihA3NkQ=;
 b=S+DjXeW3dmTs/Hup08w8kxbcWkKYwCjM93xlJlh9SW2+3YNuzyjtwxIHAgjZ9uSjxs+mQiz43KoAM1yv4tJlyC6r4oP6PiEWwCTyeF9n/c3a1U3naAT0SRorIOnBOj+KsUwBmk5QX3MKFxUDd5uUSrxVRNKU59wh52tJNm3E+sgvrR8bIMfJjxtq46tG2Eo+RX9yij+8zTOrgbJAV5F29YaAm46XvZ0eQaSFsFyEDADD3SW/6yqoo1psR4247vWHMzx6j9vE/+4lS7jjs4V7+Ukaf5eMKpag6EJSGOkwGl2KQLVbEH9mk9MirAogsvkC0x9smiXkMvVeLuZyRdFJdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mV/aJ2BqgrLTeN6d8kW8t/y6t+kMS9UfktOuihA3NkQ=;
 b=YC+Iz5q8ZJagShJPwV9QT+Pxn8ugCB/0bYG6LVFKpb3mwbC0IsLpncfKAG0Hr7K3/L4obY+sv3oiYrO+ty9k4hfedzeSL/v1fogoIqeDrPkJFiPZKwGEzgwGOTeVS+7N2ftk900ye2IztXk2XgnpVFrJd54LTMAaAiM7di9DEhqMpNm/Xvzb4d6ERtxsvpo2mSa2ZxZa777xqu0sgwlefAgmDwJUe5JMfLhJZ7dlTqYjELlJyKLXRLIVh8hRV83ciIQb0VGk1XnRmpyGg8X3N3dotO7NdAqbDzmR71y03v1Qxc5yvqXmecqyUJCp41/jrBsdo2c057Ei6fPa1iz+Bg==
Received: from GV2PEPF000000F9.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:1:0:18) by AM0PR10MB3538.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:158::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 05:49:48 +0000
Received: from HE1EUR01FT075.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e1f::207) by GV2PEPF000000F9.outlook.office365.com
 (2603:1026:900::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Fri, 14 Oct 2022 05:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT075.mail.protection.outlook.com (10.152.1.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Fri, 14 Oct 2022 05:49:47 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Fri, 14 Oct 2022 07:49:47 +0200
Received: from [139.21.18.154] (139.21.18.154) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Fri, 14 Oct 2022 07:49:47 +0200
Message-ID: <8d3cccb0-46c6-e1eb-9211-e427de153dec@siemens.com>
Date: Fri, 14 Oct 2022 07:49:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core][PATCH v2 0/2] Simplify integration of swupdate
 into downstream layers
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
	<cip-dev@lists.cip-project.org>
CC: <quirin.gylstorff@siemens.com>, <pluto.svc.chengdu.cn@siemens.com>
References: <20221013105938.332899-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221013105938.332899-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.18.154]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.244000-8.000000
X-TMASE-MatchedRID: 3OnHKS+pL/Q5QaOxwNGfvo9bHfxDWoibjaw7apmokF4aLqFbxdotGdwC
	a7XGp562cTvu5oaYS0s5khb3w81T2NQ9TGaBvejnprsDoqJsiKTi/TzrccQ0itIli0qREPWYV44
	7DNvw38bozDhGeQC9EoJu1gspD5vUOGLr13gKSYxAbrZKfdoaTPI1YbpS1+avjrVn4cme+w4ujM
	j6uE1hubbMVaqtU3gFki7wEI18pApBj25t7WpOfpGTpe1iiCJq71zr0FZRMbBWdFebWIc3VsRB0
	bsfrpPIfiAqrjYtFiTlqfcstHtwQmoUofZYywOh0r8lbr3Q+LOaRGasEw1IuX7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.244000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: F55FBA3AE61648B75C7D4BF066E0B7908E95BD2B7931F9DAE3877F7F263427BE2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT075:EE_|AM0PR10MB3538:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b2751b-c86a-437d-9e1a-08daada7e701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UuoAYY+eCDGCMW3Je/QVP9DOS70WtSmJvxo4F3A97Nge1S6OMcic8Gl7ODCmj2cDI1A27ROnRm1rbF3crXfzFnNIQQtaTkzIl/Kg3kkxJxBEviL1MuNGulVz8Y5m+3zDVOZzWYS9/9bRZWx98N+N4/MQ+O1cleYEflWHbNDmrbBXMxoVoGZqb3YaDB8CC7HR55KKgvCkXttLuqTmpO/ceK5A2K3W1f+xZk7SQGINjZcWylutstTOE7UaBlwvFJtRa50hkzNS3sTwEQ49dkl9wEThn2peZ2o5kUrdkXkh0T5GsGGX77d10sJlU/qONHZn4zxwoisD7knGcsFH1E8O+6FJeY4H8V2wlfo2Cm2/NHTs1LVyoj94ioZf115+ioYq1fvnK6h7dmvvDW/P1UopNW2O6Y73XO51V4jIuBwXZtMal6qzwYsYICJciPU/hVpM825TVLXfY/5z9esk83ee1BC15EiQCuOSw4tfYBkXweVbfuSSAiGCOPjDPEUa6+HnCeBHk4iH75dO/W54OkyZCNkyoq7J7LgRqihJr6nsL9woPkdLcOXEFhYEEZItY/wsPXEqw3+F2hZsDHFtDU0dewHtWolDqHD9XyjsDcJNj7X3pIKz9aeZ2mnsIwQ74Oe5biz2pahQvbij9s4gjmDT8GrYnReETGkpoR8qsqHZ8+3owunPwCUuDs3/tl2MY6LbKpNr0hZ1q/aiv3wrT6kGvNvMWv+mWWO57DEw3U1dDUJ8aaw+rUPzQdvTkwYI04Ag2XYxiuEkNUw01dUP/Y/cznCkpro0Z3dvFyHiu4k4YvP6A+cyqKO6CH/F1xeA3aSH1b0Za0QGkgf4ptAbou6cUsvED3V87ZLYM2wdlGiRkuE=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(356005)(82740400003)(82960400001)(82310400005)(81166007)(31696002)(86362001)(40480700001)(40460700003)(36756003)(53546011)(41300700001)(26005)(4326008)(6706004)(8676002)(5660300002)(44832011)(8936002)(54906003)(478600001)(110136005)(70206006)(70586007)(107886003)(6666004)(16576012)(316002)(36860700001)(47076005)(336012)(2616005)(956004)(16526019)(2906002)(186003)(83380400001)(31686004)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 05:49:47.2154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b2751b-c86a-437d-9e1a-08daada7e701
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT075.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3538
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Oct 2022 05:49:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9760

On 13.10.22 12:59, Felix Moessbauer wrote:
> Changes since v1:
> 
> - moved initramfs-squashfs-hook from ebg-swu to swupdate kas file
> - minimal style fixes according to review comments
> - fixed typo in commit message
> - rebased onto current next
> 
> This series simplifies the integration of the swupdate infrastructure into downstream layers and especially for debian stock kernels.
> 
> Best regards,
> Felix Moessbauer
> 
> Felix Moessbauer (2):
>   fix: add squashfs hook to enforce load of module
>   activate nodoc profile for swupdate build
> 
>  kas/opt/swupdate.yml                          |  1 +
>  .../swupdate/swupdate_2021.11-1+debian-gbp.bb |  3 +++
>  .../files/squashfs.hook                       | 25 +++++++++++++++++++
>  .../initramfs-squashfs-hook_0.1.bb            | 24 ++++++++++++++++++
>  4 files changed, 53 insertions(+)
>  create mode 100644 recipes-initramfs/initramfs-squashfs-hook/files/squashfs.hook
>  create mode 100644 recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.1.bb
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


