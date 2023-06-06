Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A592C77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 05:37:19 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.47])
 by mx.groups.io with SMTP id smtpd.web11.2315.1686029828794466459
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 22:37:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ok3g9WiV;
 spf=pass (domain: siemens.com, ip: 40.107.6.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0QXmLNKpE5+4cpolloYG6HWI7ke6lCJcgEp/CVOREpsdj5u0+ZOmwtPLz3yvN9dGV0fIxaiIBjijQAdjc5POLTyf7Ie7CB40ga8Fw45WJb3pMOW2o61xIP1c0B0jKWKJFSljSDsOWBb1TvGacyW2/Ae0ytvMwcs0e5oNsYMVGrSWHaBjzKKWcD59pUgPtEq0e6sixvH7q+3YHudSG9uk1QdfGyojaGfdgjy8NQHViI3MlWLG4eMHLcqSEGYWye1mJ/yFJ2AGtNs99585+HTik7FFVq6Mf/Rg8GH3MSnCGAeXCDi4KsFcWpDXTdmI1foW1pweCs27rkkaFnnz92wxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EhuJPRPy628V49n7mQBx0AihDhCuIFs5GpNPDqixl0=;
 b=Leo3weVBJljJZtt35AjAithrz7Z7zLA7Zuben4wNj/VlG56plKZwDEMxui9HqqcoHCSI0F+TQH0aD8Q1JXldTCRJrIQ9NDmNrdCYd8dXqO7S9twp/SmuFnGY8HyJ2SCDQI4eYFAMLoGlawqMH9AKjCKg3c4WHV7xTu6AyoT8Qgin4xNk67RUPXdDXK5q6IbqXQpoOR/IeS6jw2Pf/IgOwp7UxdqRx3LKHyU33PdcEW492jY+/CjUcTvMZhPzYjAiH8MnLEhh8+Omfzo0yrVa161yCtgG36fDMgxy/eQLxsY2R5AbV4T6XudB3T1a0A2I+SeJMBa786bcOmxBDxYFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EhuJPRPy628V49n7mQBx0AihDhCuIFs5GpNPDqixl0=;
 b=ok3g9WiVgTZXHJqaQPYWR5VhVhz57tp9ES7fQPu3qZiCZPYf1871m7I+tzdiVWgWgHb2sIZ4uL+bBfXVykRnOONxIqMum+3Ck0FfZ7mtG6pVDecyhKe9cZhiurp7vjdE2xoTfX0RysycWOhne//J0+gzK9I2vfFn8D7SC9JjMJ2nmzGpGYnp0QnWTAyZhJWEsqOKCGD2tNUQr5pm0Ii/7mHVZhJNrwDdmzBvTkaLJ2naN0yKxsocrT0n3GZ0LtJY2HuSWqjBbnmFMW7e3KboCfjWZpBUPepWwXGYGmWeWy98llPbyvUfXPFnyECP2tWuli2rkzJKfQsBoLfhuD8uQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4058.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 05:37:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 05:37:05 +0000
Message-ID: <15c4bbac-145e-f826-9c48-778531a1a403@siemens.com>
Date: Tue, 6 Jun 2023 07:37:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH v2 1/2] Add recipe for optee-client
Content-Language: en-US
To: baocheng_su@163.com, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com
Cc: christian.storm@siemens.com, quirin.gylstorff@siemens.com,
 baocheng.su@siemens.com
References: <20230606035506.10354-1-baocheng_su@163.com>
 <20230606035506.10354-2-baocheng_su@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230606035506.10354-2-baocheng_su@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: 4165545a-244e-4709-dbe6-08db66500fee
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Jv1vqJKV1HyUuaRF41Q9lR+1JQIa+iImpLLnXWAeTQQBW1rduMSzFAklrdc2dYu0LzKaZ8K/RKQJoMvNXgjeE87xY43gfUlnUu5wFFDErACBW8OZn3K0fJLILXeMF9mxWrLJJL7myrNgIjDrDbggfM5XH+6ECssz+mx/L4wpvV7Rqu3jZE1VhnFW1bpi4UiLo7DVCxIrdo0/5v6IVOl+te87LocBPf526t5845SgtxT5qm2BFC1Bu2CEHwpFrSk8LtzSeuRoYGe0zAyeyDTw8e8UlPIHY5BaIvXFEcGCiUk5E8JxQwJee6/QRJwLRRRFv6HpCo8AGz/kIOY4cQlq4dRR6w/Ez6Rkrxll47vEb4NgAbVSvHD1OckGvX/rSTNn6yKdN7HUXTmGFuXmTlogGX3KD4GHMidBmrQYPRpIyc07H9dzwaN17JymLS/ejZhBFkjevJRlU8Up2U3h43nCIs2f2dQJkyeChqchYgPNulpYg/YJU2ggZWNAs2Rc19dNUOxVvbqJoXaokHg3OPnR8Qjy0vt67/qrb+qghwU745EIgUv2ea8Frh7dCiVyLTR92lmrVgkug0YPgySVolj7agT+XbeVgvcVhbjZE2yp08Pyl0DvFquavqr5IQJHtxEL7WrEx3WZp1FZeEc8vISQZPNFrNk6kbETme2OBYjMtXzKj5FKoDxf9A6XCLBaXnEQ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(36756003)(2906002)(44832011)(31696002)(86362001)(5660300002)(31686004)(6486002)(966005)(186003)(83380400001)(53546011)(6506007)(6512007)(107886003)(26005)(82960400001)(478600001)(66556008)(2616005)(38100700002)(66946007)(4326008)(6636002)(66476007)(41300700001)(316002)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OE5uaWhENDFvQ2ZDajJXTUFPa2c2Tk5rczQrdWpGRStYUHc3ZjZJaEZHY0cw?=
 =?utf-8?B?OE1ZczJVNW00c3kvY2drTndjVzNqQWUrTlpNYW5WQU5HYU5mdTVkV21UUXRa?=
 =?utf-8?B?YnpqWDRqeHMxdGwybVRldkRRSmczcUI3d1EzSy9hMk9Hc3IvZFU2QmdvS3Nv?=
 =?utf-8?B?ZzYrVy82YUdVTzFnbE10SEhsYXk1S1RPd0l4MU5pOUNnWC9ZbXFwR053UUNs?=
 =?utf-8?B?MWlpb3N5S1FDZnYrNG9vOGFYZFVxL2lkU3JrREZtQmlqUG16V0F2UFJuUUlQ?=
 =?utf-8?B?OGc4bHVTMDlNekxWb3JuMnVDeW90OHd4ZUo0RElYTVVicThDVEZZTWdGRkYv?=
 =?utf-8?B?L3RuQ1JFMVl3ZUhTUzNBVFZCWFpKTjArb09wdXB6cjducm0rT3B1WWd4Ymd1?=
 =?utf-8?B?SmcrTW43ZHJxdmxYcDk0cGpEK3hjMmdIejBrTTZ2aFBSS3d4OERGeEtpckg1?=
 =?utf-8?B?NzNMSlBwL0taM3Q2S1RjbUwzTHFSVkJxM2FxalE0R2xaemZ1cHR2K0hQSDBW?=
 =?utf-8?B?RTR2M2FJblZRMGk4WEdKL0l3TTUwS0lWMVhDRGxUWC9UdWRzTFZCa3BRaERE?=
 =?utf-8?B?d2FXditOb0dVMFNoLzgvVTVpNTM0eEcxWDVGdFRRcnd5VFduWFNyN2FnRmNI?=
 =?utf-8?B?OFBlTWdTWE5hUkR0bmdsYndVbzhZN2hlUVpQdmlhQVAvL1ZjY1ZXbGRSVVBR?=
 =?utf-8?B?YTFUQmRJcEVhN2FXZnVKOEhhMFZUM3RaT1ZWOHlrN0JINGRFUi9tSG1QNHR0?=
 =?utf-8?B?a0pIRnkvRlROSkhLbUVyTXZYZFNJUWNwQ0FERkFaMUFteTY3eTdwOTkrTGNM?=
 =?utf-8?B?QnZOLy9sOGFwMHo4RlR4L0w2MGFnVWZyY1g4c1MxVTZIRFFOaFJoV1U1Y2ZZ?=
 =?utf-8?B?ZG1JN2hjVEZnZGgvZ0pNdlVwcFRHOStZSWx2YlRkcVBpWjlBcVVudHNGeXlx?=
 =?utf-8?B?bzhWS0lZS256Wktiby9FYVJReTUrMmJIZngyNzVna0JHNUJpaDhLM2huVWVB?=
 =?utf-8?B?eUlHc09CaGxpbTNGNExKL2crblEzMGx2c1J6ZEdnRE1ycmRKUExUaFhub2Rj?=
 =?utf-8?B?bWxJM1FST1YyRFFTcnNaQm54T1JxUWlPV2ZTQXJyN3lJV3ZYTExxUkEwSzYx?=
 =?utf-8?B?cy9IQm53aGJxL1picU5GaGtkNTg2a0h4Z1dDNnpPaDNkaHgzMEtwbkFvQXdt?=
 =?utf-8?B?Vk1oSEtBYW91V1h4RU1qa2s2RkJqRHROSEZhT2VRWE0xb3kzV1drM1pkZm82?=
 =?utf-8?B?aDFnYXlRd1Zud3lZU3dIcTJMaXhQZnR6Mng3M0toaUdTY2dDRndreVMvMlVL?=
 =?utf-8?B?dStDbEZWUzJwK3Y5TXdhWkJpU3RqK1BQYzNKOFF3MTN4UW1QaVVaN1cyRERJ?=
 =?utf-8?B?VjY5VVd6eWFBWDVzTXhoQmF2R1RJOHh5aFZ2Zlo2dnBOSHAvRDZYaW5ndDg0?=
 =?utf-8?B?cnZ3R0F6ZXd4YUdMd1lNUnJwaGhQbEliYythcVZQL1h5WGdFemdaZ1NwRVYz?=
 =?utf-8?B?T3Y0eFZMRDM3azhlUVFnU1NEbEJNeXVVOVNxQ09TQ0didFNxeU5jcE04NTRB?=
 =?utf-8?B?OEJZTEp4QjZaSmdmUHZITUEyd2YwQzZ6aUxnZFd6ZGlkbFJxN0tIbVc5bExP?=
 =?utf-8?B?TnVsdkh3anIzeklXZDdEMm8wbnZOeEVZMy80d3RFejhYOUdFWk12d1Q5cFgv?=
 =?utf-8?B?WDU0K2h5eVBkZSs1QlJpVmtUM25tZHYyY09PWjB2NUc5MkgzaGZOeUlaSnZD?=
 =?utf-8?B?bHYrL094MHRac1hGa1NOS21nZmpUS29QYVBTVzZKeVFRWklhYll3VFk4VWFp?=
 =?utf-8?B?U0RLdVFlUy9tOUFhOUZKNU02cXl4ekx4RGxuMjRuQUJ1VW1JMVdCNkE1Q0d0?=
 =?utf-8?B?YVp0R2x6NFlUVm96aytmQ20raEp5Rnp4SXFXK0hubkQ1cU5iNEpUdmJaWDFs?=
 =?utf-8?B?eGl1YjdQMzN6U1lreFRUUEl3QmczMjYxMWl5WENObS9CU2RXajBlSXY1VWxC?=
 =?utf-8?B?Zlk1ZkNXRG9oSVNjU01XWHJXZXFqdlFqZkY5dk1MZWhSY3V1V1plRFk1elJz?=
 =?utf-8?B?aEkzRkRESWtFYUV1b1IxQmY5MENyOXVnV21HU0dqZk13TWkzK1BCcFo0eW9T?=
 =?utf-8?B?Njk1ZGFsKzdXeU01eFJLbFNIelpGTG1Nd0xYcjRvUzIvejBNaEJjS1BjMGdz?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4165545a-244e-4709-dbe6-08db66500fee
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 05:37:05.5298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESuiCITwXeW2RZ68RoZK8Qz6wN5lqJfJ23omZz+s1FoeYmsrYgktWn/LxO3kOZxfv3xEj8VnFelL5Wy2djkLlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4058
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 05:37:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11837

On 06.06.23 05:55, baocheng_su@163.com wrote:
> From: Baocheng Su <baocheng.su@siemens.com>
> 
> This brings the libteec1, optee-client-dev and most important,
> tee-supplicant.
> 
> Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
> ---
>  recipes-bsp/optee-client/files/control.tmpl   | 51 +++++++++++++++++++
>  recipes-bsp/optee-client/files/rules.tmpl     | 20 ++++++++
>  .../optee-client/files/tee-supplicant.service |  9 ++++
>  .../optee-client/optee-client_3.20.0.bb       | 47 +++++++++++++++++
>  4 files changed, 127 insertions(+)
>  create mode 100644 recipes-bsp/optee-client/files/control.tmpl
>  create mode 100755 recipes-bsp/optee-client/files/rules.tmpl
>  create mode 100644 recipes-bsp/optee-client/files/tee-supplicant.service
>  create mode 100644 recipes-bsp/optee-client/optee-client_3.20.0.bb
> 
> diff --git a/recipes-bsp/optee-client/files/control.tmpl b/recipes-bsp/optee-client/files/control.tmpl
> new file mode 100644
> index 0000000..b0c3756
> --- /dev/null
> +++ b/recipes-bsp/optee-client/files/control.tmpl
> @@ -0,0 +1,51 @@
> +Source: optee-client
> +Priority: optional
> +Maintainer: Unknown maintainer <unknown@example.com>
> +Build-Depends: pkg-config, uuid-dev
> +Standards-Version: 4.1.3
> +Section: libs
> +Homepage: https://github.com/OP-TEE/optee_client
> +Rules-Requires-Root: no
> +
> +Package: optee-client-dev
> +Section: libdevel
> +Architecture: arm64
> +Multi-Arch: same
> +Depends: libteec1 (= ${binary:Version}),
> +         ${misc:Depends}
> +Description: normal world user space client APIs for OP-TEE (development)
> + OP-TEE is a Trusted Execution Environment (TEE) designed as companion to a
> + non-secure Linux kernel running on Arm; Cortex-A cores using the TrustZone
> + technology. OP-TEE implements TEE Internal Core API v1.1.x which is the API
> + exposed to Trusted Applications and the TEE Client API v1.0, which is the
> + API describing how to communicate with a TEE. This package provides the TEE
> + Client API library.
> + .
> + This package contains the development files OpTEE Client API
> +
> +Package: libteec1
> +Architecture: arm64
> +Multi-Arch: same
> +Depends: ${misc:Depends}, ${shlibs:Depends}
> +Description: normal world user space client APIs for OP-TEE
> + OP-TEE is a Trusted Execution Environment (TEE) designed as companion to a
> + non-secure Linux kernel running on Arm; Cortex-A cores using the TrustZone
> + technology. OP-TEE implements TEE Internal Core API v1.1.x which is the API
> + exposed to Trusted Applications and the TEE Client API v1.0, which is the
> + API describing how to communicate with a TEE. This package provides the TEE
> + Client API library.
> + .
> + This package contains libteec library.
> +
> +Package: tee-supplicant
> +Architecture: arm64
> +Depends: ${misc:Depends}, ${shlibs:Depends}
> +Description: normal world user space client APIs for OP-TEE
> + OP-TEE is a Trusted Execution Environment (TEE) designed as companion to a
> + non-secure Linux kernel running on Arm; Cortex-A cores using the TrustZone
> + technology. OP-TEE implements TEE Internal Core API v1.1.x which is the API
> + exposed to Trusted Applications and the TEE Client API v1.0, which is the
> + API describing how to communicate with a TEE. This package provides the TEE
> + Client API library.
> + .
> + This package contains tee-supplicant executable.
> diff --git a/recipes-bsp/optee-client/files/rules.tmpl b/recipes-bsp/optee-client/files/rules.tmpl
> new file mode 100755
> index 0000000..a8f2afd
> --- /dev/null
> +++ b/recipes-bsp/optee-client/files/rules.tmpl
> @@ -0,0 +1,20 @@
> +#!/usr/bin/make -f
> +
> +ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
> +export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
> +endif
> +
> +%:
> +	dh $@ --exclude=.a
> +
> +override_dh_auto_build:
> +	dh_auto_build -- LIBDIR=/usr/lib/$(DEB_HOST_MULTIARCH) \
> +		CFG_TEE_FS_PARENT_PATH=${TEE_FS_PARENT_PATH} ${RPMB_EMU_BUILD_OPT}
> +
> +override_dh_auto_install:
> +	dh_auto_install -- LIBDIR=/usr/lib/$(DEB_HOST_MULTIARCH) \
> +		CFG_TEE_FS_PARENT_PATH=${TEE_FS_PARENT_PATH} ${RPMB_EMU_BUILD_OPT}
> +
> +override_dh_auto_clean:
> +	dh_auto_clean
> +	rm -rf $(CURDIR)/out
> diff --git a/recipes-bsp/optee-client/files/tee-supplicant.service b/recipes-bsp/optee-client/files/tee-supplicant.service
> new file mode 100644
> index 0000000..7148515
> --- /dev/null
> +++ b/recipes-bsp/optee-client/files/tee-supplicant.service
> @@ -0,0 +1,9 @@
> +[Unit]
> +Description=TEE Supplicant
> +
> +[Service]
> +Type=simple
> +ExecStart=/usr/sbin/tee-supplicant
> +
> +[Install]
> +WantedBy=multi-user.target
> diff --git a/recipes-bsp/optee-client/optee-client_3.20.0.bb b/recipes-bsp/optee-client/optee-client_3.20.0.bb
> new file mode 100644
> index 0000000..b760a2c
> --- /dev/null
> +++ b/recipes-bsp/optee-client/optee-client_3.20.0.bb
> @@ -0,0 +1,47 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Su Bao Cheng <baocheng.su@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg
> +
> +DESCRIPTION = "OPTee Client"
> +
> +PROVIDES = "libteec1 optee-client-dev tee-supplicant"
> +
> +SRC_URI += "https://github.com/OP-TEE/optee_client/archive/${PV}.tar.gz;downloadfilename=optee_client-${PV}.tar.gz \
> +    file://control.tmpl \
> +    file://rules.tmpl \
> +    file://tee-supplicant.service"
> +SRC_URI[sha256sum] = "69414c424b8dbed11ce1ae0d812817eda2ef4f42a1bef762e5ca3b6fed80764c"
> +
> +S = "${WORKDIR}/optee_client-${PV}"
> +
> +TEE_FS_PARENT_PATH ?= "/var/lib/optee-client/data/tee"
> +# To use the builtin RPMB emulation, empty this
> +RPMB_EMU_BUILD_OPT ?= "RPMB_EMU=0"
> +
> +TEMPLATE_FILES = "rules.tmpl control.tmpl"
> +TEMPLATE_VARS += "TEE_FS_PARENT_PATH RPMB_EMU_BUILD_OPT"
> +
> +do_prepare_build[cleandirs] += "${S}/debian"
> +do_prepare_build() {
> +    deb_debianize
> +
> +    cp -f ${WORKDIR}/tee-supplicant.service \
> +        ${S}/debian/tee-supplicant.service
> +    echo "/usr/sbin/*" > ${S}/debian/tee-supplicant.install
> +    echo "lib/optee_armtz/" > ${S}/debian/tee-supplicant.dirs
> +    echo "usr/lib/tee-supplicant/plugins/" >> ${S}/debian/tee-supplicant.dirs
> +
> +    echo "usr/lib/*/libteec*.so.*" > ${S}/debian/libteec1.install
> +
> +    echo "usr/include/*" > ${S}/debian/optee-client-dev.install
> +    echo "usr/lib/*/lib*.so" >> ${S}/debian/optee-client-dev.install
> +}

Looks like optee-client is part of bookworm, but version 3.19.0 only.
Latest is 3.21.0. Please make sure we aren't colliding.

And did you use the official debianization? If not, please do.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


