Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45CDC433EF
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 08:53:56 +0000 (UTC)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (EUR03-AM5-obe.outbound.protection.outlook.com [40.107.3.61])
 by mx.groups.io with SMTP id smtpd.web08.82005.1657011232191040606
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jul 2022 01:53:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HqjatJfL;
 spf=pass (domain: siemens.com, ip: 40.107.3.61,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jn/PKkBl6UjgoGXrJX+NXffIYiN2a28W9jB41SueK8u0RPlsTA2+ByygY1Jdxo9O5gqj06032m+bLwDn6AWXrdEBAgZgwEdRtOwsfoq70D6H33lIHhADg22VVfyyU9ks8iKEbhgP73tquyoV2uIQPND0H/HaYnZw5juL8VT6CH6K5DVZOjMWR7GdNyY2aQfwyaIk64yc3BiIeMlXxzIyrdC2pg4My++MnwOdlJb7YySCGutKRWaWVpf15X+i8Ma75WgiMsYv+Nwj5bEudE3K0/P1kvgcrHZz4LIPWkp7+Vw81EjJHbP53MdmB1xqESlBHu7M7XsWfRNul8Q3K5tokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0k/dfdR4re5ESqHhdKq2s6N9xwkSM3ThGZYrZY6mTg=;
 b=ReUdLgtZo8TnGtp1SFcx9NBgGYCbd/zBTvPNkodbCKP95Lbf3Rt7NwoE3cIwtUZ0xxtcgYo4X5S0hKl7Z6tjMFQmmB0koKfy7ufo3PLF+PDtBmSlRQUWXEZHlqzb8jXmP3EKJscE20TsMB9bd6qNZaD3MMdf5/eZh8w1Ls0m+CXdxZRWnIiX1ZcRLk8QlUripFaUQXInTdhIILZku1pIWPYzesv5iL/8LEPQVObhQ5Z2pYrCI4RLOgO3QhFFd8G62TZtcxZLa9Ej1l8/YtIYwmbu2Tby1b/0tAt88YnwMQZS36qFmNjhTOw9WT7m0WMJTXC96YlNtwIadMKua3vReg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0k/dfdR4re5ESqHhdKq2s6N9xwkSM3ThGZYrZY6mTg=;
 b=HqjatJfLFNcy0MD8e8fJTkyu3G2eb4fiKhfbTM31esK6RIrqFZfVHJCcT2cgmk+d8/n3Ql4MnJ3DM+/j6JeM4B2zVSfxUNzrEmx85JkUFrSuLUJMKbnDB98POvCaA7CmChT8IKsGPDkwV97Eaq2QQewbkY9mTv5O7jWJp017b2ZaZ4b6aWAkVgwEyvQNdjpEB6DJPTxQzbQfUHoW2de2tf2C5BdOqu6MwZo1PE4P3U/JLvX2GvAE2ZAuwvxFuazjLVZO5M0pWVtjEHXmWpNFmYECxpK5Ppc+Qd9CyhQXZhNn7iHzzyhISweZ404JOQwzG/HDU35FtZt9yHxN7QrkVw==
Received: from AM5PR0502CA0017.eurprd05.prod.outlook.com
 (2603:10a6:203:91::27) by AM9PR10MB4023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fe::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 08:53:49 +0000
Received: from VE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:203:91:cafe::94) by AM5PR0502CA0017.outlook.office365.com
 (2603:10a6:203:91::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21 via Frontend
 Transport; Tue, 5 Jul 2022 08:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT018.mail.protection.outlook.com (10.152.2.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Tue, 5 Jul 2022 08:53:48 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 5 Jul 2022 10:53:48 +0200
Received: from [139.21.19.13] (139.21.19.13) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Tue, 5 Jul 2022
 10:53:47 +0200
Message-ID: <b8271bd9-8574-4bc7-9c96-5dc8843d22f0@siemens.com>
Date: Tue, 5 Jul 2022 10:53:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [isar-cip-core][PATCH] security-testing.yml: Add kas option for
 IEC layer testing
Content-Language: en-US
To: <venkata.pyla@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
References: <20220704172122.11322-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220704172122.11322-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.19.13]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.884300-8.000000
X-TMASE-MatchedRID: XYZjbEcsSe4wrKi3eh3JIsb9CgEQmMW5Pg9yfk4YC0bW4Mz461fsHGtq
	QgJyb0BRWgm4fq9o0LO8ozyo7WOjvj2XPP5womildYSfngwBL6jI2RqSAXh33n/HTU/OBaTGq5U
	6sO8HwtOwb7hccmYAhQSDCUdk18WirdoLblq9S5qxpjy1K0tDft5MntES9XX7cxMkBeI9K3eyjd
	LmEgWzaUamD+dkC4n9HwnNqsb00znuGpDZdzOQn6Byu2sDWGqWtkEL1EmUpaNgqbvjZaUg3i6My
	Pq4TWG5tsxVqq1TeAWSLvAQjXykCkGPbm3tak5+kZOl7WKIImrvXOvQVlExsHAruZnjhopu+gD2
	vYtOFhgqtq5d3cxkNWqnMjmJR+9Jkb6L5ENU9hrgApPViP9Ohuy4MRN4NCyxAqylzg4yHwY=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.884300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 A139FABFE9F065B1F7112227A2CB53B3FBF31CE5B5329A03207C9BDFFFBDBCFA2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f76c3e9d-a3da-4103-6f79-08da5e63e096
X-MS-TrafficTypeDiagnostic: AM9PR10MB4023:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MWnSWCGkrZQ8uTwkmn10d9GeBOEQXCSrN3nr2HvhEy68kJA0uRIVi1p7lgQL+uBbSEXhxYLNWhNiIni+W4SIBHcbdVDKOFW9Rw4gDgHaskITBZnRzzzEwQ/c3aRdVjeaEoB3oaoeryFMblPE2/XHd6H+EoNGZmUu1iaV+vBVbjbdA7EbtcRn0D1+hPs/jZC35UlQEaY/AGoT0vx87PVMniqUc6WBFTVB04LEdiEIe8uGgpg/3ygF0e1NGvGFNLKWGsVGLWOYxPlvldVif85J/jK78/V2Rykn5n3IRmxVUrWfgyNZZxdx8Z+0s481nj9SWCdf6DoDPTzF2hVxBJFiMAYHD1UXRCd+pnxm1OXm+JzHJ7rIkOAlFTV+OBiTaRsCiiiSCMJ6MUNl2QmcnSu/eWiYUf+dYg86b/WyhGbZY8g7lpME/7oasgbgsZKVyPonYBOZE5FhHY69JBQ+i87Aa09x21ZK2IW1WhbO0KKKAG2QiWWRU9CnQ+g9mkCVt5KMUjVRzYt/0+++Ws33fusfiP+02Gr95K9rAMERaCHJ4wFqtMN+4QFg1R+EkGjGgeljOZM3XWf3o5bzWHkv0fp4OQ7LhiSzSTrRcC127La5SzSNaDVR/SWAM7hSUOVVpSAxFP88hiBrdAYRl5F9bGApiooa2lA4oK04+R5gbkVALce1yyp4wWD3LMxb2Z5OZk6PTczLb6q9wAxFISC4MT/tS687LxS4uOGiB3TXLlLQY5ZxfkBNFWfFJiN56sk/V8HIiLL28YqHqWmpuoFin1ZbaARw0nmpwuFJ+x6JEUiM5GPqyWSvbyttHxdkf9lrNiiIhnOUs814nVv+NC670CnUkyHrJHhBEgZlSukDadOBOTxERbjBP1y7aXBVBpG1d7woR5SSS5+k/r/dFL1v6S0dWfHny6aQgm7ffBXtfJdP23bicc4In7PEr5EtjJLKRsdf
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(36840700001)(40470700004)(46966006)(53546011)(26005)(316002)(2616005)(40480700001)(956004)(966005)(478600001)(82310400005)(16576012)(31696002)(110136005)(54906003)(86362001)(41300700001)(6706004)(82740400003)(82960400001)(356005)(81166007)(36860700001)(40460700003)(83380400001)(16526019)(186003)(47076005)(336012)(2906002)(8936002)(8676002)(15650500001)(5660300002)(4326008)(31686004)(36756003)(70206006)(44832011)(70586007)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 08:53:48.8450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f76c3e9d-a3da-4103-6f79-08da5e63e096
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4023
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 08:53:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8679

On 04.07.22 19:21, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> This kas option file adds additonal packages required only while testing
> using cip-security-tests[1].
> 
> Also it provides additional rootfs size required for testing.
> 
> [1] https://gitlab.com/cip-project/cip-testing/cip-security-tests
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  kas/opt/security-testing.yml | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 kas/opt/security-testing.yml
> 
> diff --git a/kas/opt/security-testing.yml b/kas/opt/security-testing.yml
> new file mode 100644
> index 0000000..19215f1
> --- /dev/null
> +++ b/kas/opt/security-testing.yml
> @@ -0,0 +1,20 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation, 2022
> +#
> +# Authors:
> +#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +header:
> +  version: 10
> +  includes:
> +   - kas/opt/security.yml
> +
> +local_conf_header:
> +     security_testing: |
> +        IMAGE_PREINSTALL_append = " sshpass"
> +        ROOTFS_EXTRA = "8192"
> +

There is already kas/opt/test.yml. Can't we piggy-back on that one?
Would also already come with kconfig support.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

