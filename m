Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468E2C00140
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 15:35:24 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.50])
 by mx.groups.io with SMTP id smtpd.web10.8260.1658849715067921102
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:35:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tWZUQJIG;
 spf=pass (domain: siemens.com, ip: 40.107.14.50,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQG/tdBycKa9SEO47IKyxwH/Tpb2luj9ODtX2aDC5eyJSTcfkcbpoFJV2qsvUxSdzoDETJhhqembARFYfzZBzIuOpLZ+EQxLylLFthEuexpf0GomNoQSpmuv6MELOBCexWp/bWljd41A4M2mk32NICp7smJ50wBaSIBje9s2Fq7S52m6p+KE19TVIHT4mzyHbEb5c8UbIFL0rPEb1DgT/u75G8jPM3Hg0WX/dpsOTOywyxoo53B+jQ+UZzC+iEjPSopGUI1VgY6fafY6wSiWXSx0VWsxCNhIAPLKtfl7ZztjMxL5Tp01Q4Wg4CMGynZDqW32kaXt0o63r8dmBAFudg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfO24KA3rFu1hb+6svDakMvlsc9QQmRhArcDHVUP+Eo=;
 b=ACV9Qv4GwyKXytCbFmcBaukytqT1I1FH5t2tuAo+d412pKxeWc6tBibr6RRwRZChRDcHJ8c5Qs5qvGEdyyn83sNsGpIvXxwMlQ5pLUIw7z/8+0CDeAxOcVOVFBkUSrOH8FMDvRt2vrF8iJARTdsj7OVBmP6nCqihWIawAsVaWieMupbyrMT398Qrzcd69E6xk9cT4ziHfVOgzC/AQmMkGzVTtQIMoGaKM8zz3BbQvKANUaAflBhPRo4HEeH1VtcmW55s4ltPo4JLIqaUmag9x0kAD5VFj7aAQGEjc6dTJKlHE7dzKbbQd9UiDaJYHHUDM4tMnV+4CfHolfmihVAVAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfO24KA3rFu1hb+6svDakMvlsc9QQmRhArcDHVUP+Eo=;
 b=tWZUQJIGTMz5J37X7Bhnb+Quw81ydb7SaHth50TOnJJyI3Va9SrIK4rR9HB5bsIHu4bW20XqVbn91fYVlFmULicROHzKwLTbuUFnI0bAoH2jHwkc9xHKxwkb9GfaU7Y485Jmc4jIcUruZ/wz689VWy2cY20j8CWCYj1DLYNKDeMJF4lYeoR8CMcMTDPsLCGZ4uPxbj1B2XE1irWKW5M/QUrr1YYXn9ECrAaBMo+nL3sRwR7kQaBO0rDG44hhMDdYmyadUHcpAMgBnZlZ9ODxPk6aWZI+CpLadnekQl8kL5mv5zj6f/bCLBahi+kvXgN8oPoJ6hpUaJKIBZHMWr+XiQ==
Received: from AM5PR0601CA0028.eurprd06.prod.outlook.com
 (2603:10a6:203:68::14) by VI1PR10MB3198.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:132::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Tue, 26 Jul
 2022 15:35:12 +0000
Received: from VE1EUR01FT084.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:203:68:cafe::32) by AM5PR0601CA0028.outlook.office365.com
 (2603:10a6:203:68::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Tue, 26 Jul 2022 15:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 VE1EUR01FT084.mail.protection.outlook.com (10.152.3.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.17 via Frontend Transport; Tue, 26 Jul 2022 15:35:10 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 26 Jul 2022 17:35:09 +0200
Received: from [139.23.72.44] (139.23.72.44) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Tue, 26 Jul
 2022 17:35:09 +0200
Message-ID: <c1a95b61-a1c8-f2ba-d962-dfcd6f45e0e6@siemens.com>
Date: Tue, 26 Jul 2022 17:35:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [isar-cip-core v2] security-customizations: Fix pam_tally2
 deprecation
Content-Language: en-US
To: <venkata.pyla@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
References: <1704D51B3A6B759B.22812@lists.cip-project.org>
 <20220724175344.14522-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220724175344.14522-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.23.72.44]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.890500-8.000000
X-TMASE-MatchedRID: 10+ctCQpgSwwrKi3eh3JIsb9CgEQmMW5Pg9yfk4YC0Z85pjA/x1xfj8H
	EU7XbMTEs4syQgRlrAbZ6KrkcB2NwWoHrAS1YTuNovzBAOTiWStiWV0DQ85LUpxVZzZr7+O769x
	ONVZSrH2lPD9bqmQtH0SZHn3ztBVPzNloacNHyNDkBJIJYqRkd8ZMpEGIcNqhec1y1wrvN8UZ9k
	iZvd+oBCf0DxhZHOwycRFtLs5mkQMzaJvSF1fCZpRBa3u5J+EMjl1W6HbLC+FeYVWU5uHQ/Ayry
	3WoaCBEmyiLZetSf8nJ4y0wP1A6AKEwgORH8p/AjaPj0W1qn0Q7AFczfjr/7MKblzRv1/tPcz7/
	puaxc0jP8ubao4uA9c/YucOHaAsE8DqnAEsgNCQ=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.890500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 00295BFF97C5492294AA86D313769D74F5CFFB7CC18C581E608F5AAE6CDD49252000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08b2125f-2f53-4ac6-3649-08da6f1c6d01
X-MS-TrafficTypeDiagnostic: VI1PR10MB3198:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QibSWUnzXc8suNZk1534M411ttFgprw7XqjViUwDWVQOOdcAzEMS9jhrNNTha0U1XL6wTY7mbc7f1Sspq25aJMKVczxrCS9w9qU7x2OooQdNhKzzymxKzJlmXEW04f9/aDyLlOXfvkRZdVbVuNWWwyThRd8EaMHcg2kxEyle0lqlIfFKUU/I+bzL1r+EineonN1S2xi2/pO/AisKyKNiglS7dfrnVGK9FPco925IWelLBk2HbFswe2OpVOO7zEJhMs6i2IgKu9YvfEun5FQbaXVzgmBaiPUaggXODnJeSQdcH+TvQFo2UjvEdWYWkvfV4TK3q20ktRej4UdS8o7KtwsPNzDt3rykbucDBS5kjBLfJ5iJHtUEEoHSHaAfraMituDnfQsfJlSCaMDeDwm0blebgvP4PjkQTO2LD7HIHZN090Hnvilj4xbPXZdCJt/mSZ2Za2K5QLltkPAhEAUK1YJ1V+lp3hGgDYMzhBVDcpf/ah8BTRc9eEyYo/BDMnrWWwtmNint0yiWRCdcVg6ObcLGvnjH4HZjtYVstLekA0p1lJhX/LkpM9lixtKF0Qlo4h7lmIfJepenOI6mdwllyOuIVvPck5/z3WbtE7pMiPnPzhPNAho123IJjVeHXtw0iB7ZkRO80ViLDqfLQ0mHQISqO0z6X0451F9F+958/pyXU1ySPbec6hjf4fYs3gLblzAfTfYxrnSUC815UKLgvRpXngyPAIxmVmSA6fq60AgwdXyY3q1/SumbVW7RmQ5MNZdjvIcYA5wqgiPbGUiTwQBiYLytaKo+9LMR4wfI3KPILutEMNc+qpcQTCGw2f+eol1KByCH8/S+KmuK1COO+9aP5iFI6itK2IMbufvrHDU/TDCFmtqWTR+w2jWPI/TXn9glLGMdOB4t1QfDJ/0hTw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(36840700001)(40470700004)(46966006)(70206006)(15650500001)(70586007)(8676002)(336012)(4326008)(26005)(8936002)(40480700001)(5660300002)(2906002)(478600001)(83380400001)(44832011)(47076005)(40460700003)(53546011)(36756003)(41300700001)(110136005)(356005)(2616005)(316002)(16526019)(16576012)(186003)(36860700001)(6706004)(31686004)(54906003)(82310400005)(81166007)(82740400003)(82960400001)(86362001)(956004)(31696002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 15:35:10.4284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 08b2125f-2f53-4ac6-3649-08da6f1c6d01
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT084.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3198
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 15:35:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8943

On 24.07.22 19:53, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> pam_tally2 is deprecated from PAM version 1.4.0-7 that is from
> Debian Bullseye, and introduced pam_faillock as replacement.
> 
> Modified the security customizations to check first pam_tally2 existence
> for backward compatibility and if not found use the pam_faillock
> instead to achieve the same functionality.
> 
> Fixes #33
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  .../security-customizations/files/postinst    | 20 +++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
> index 9ba8540..0d0eb07 100644
> --- a/recipes-core/security-customizations/files/postinst
> +++ b/recipes-core/security-customizations/files/postinst
> @@ -22,11 +22,23 @@ sed -i "0,/^password.*/s/^password.*/${pam_cracklib_config}\n&/" "${PAM_PWD_FILE
>  # CR1.11: Unsuccessful login attempts
>  # Lock user account after unsuccessful login attempts
>  PAM_AUTH_FILE="/etc/pam.d/common-auth"
> -pam_tally="auth   required  pam_tally2.so  deny=3 even_deny_root unlock_time=60 root_unlock_time=60"
> -if grep -c "pam_tally2.so" "${PAM_AUTH_FILE}";then
> -        sed -i '/pam_tally2/ s/^#*/#/'  "${PAM_AUTH_FILE}"
> +# pam_tally2 is deprecated from pam version 1.4.0-7
> +if [ -f /lib/*-linux-gnu*/security/pam_tally2.so ]; then
> +       PAM_MODULE="pam_tally2.so"
> +       PAM_CONFIG="auth   required  pam_tally2.so  deny=3 even_deny_root unlock_time=60 root_unlock_time=60"
> +elif [ -f /lib/*-linux-gnu*/security/pam_faillock.so ]; then
> +       PAM_MODULE="pam_faillock.so"
> +       PAM_CONFIG="auth   required  pam_faillock.so preauth silent  deny=3 even_deny_root unlock_time=60 root_unlock_time=60 \
> +               \nauth   required  pam_faillock.so .so authfail deny=3 even_deny_root unlock_time=60 root_unlock_time=60"
> +else
> +       echo "No suitable pam module found to lock failed login attempts"
> +       exit 1
>  fi
> -sed -i "0,/^auth.*/s/^auth.*/${pam_tally}\n&/" "${PAM_AUTH_FILE}"
> +
> +if grep -c "${PAM_MODULE}" "${PAM_AUTH_FILE}";then
> +        sed -i '/${PAM_MODULE}/ s/^#*/#/'  "${PAM_AUTH_FILE}"
> +fi
> +sed -i "0,/^auth.*/s/^auth.*/${PAM_CONFIG}\n&/" "${PAM_AUTH_FILE}"
>  
>  # CR2.6: Remote session termination
>  # Terminate remote session after inactive time period

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

