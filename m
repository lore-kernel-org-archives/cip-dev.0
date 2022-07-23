Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097A6C433EF
	for <webhook@archiver.kernel.org>; Sat, 23 Jul 2022 17:24:25 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.57])
 by mx.groups.io with SMTP id smtpd.web12.8385.1658597063548338070
 for <cip-dev@lists.cip-project.org>;
 Sat, 23 Jul 2022 10:24:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=0LLB0vyu;
 spf=pass (domain: siemens.com, ip: 40.107.8.57,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALMFnaJeQm13zykGKF1VZq4s+N+REmWTHCjMan9WRxRg9Wa9oIg1q1+vtGWwQzbBnEyOJH9ZQ0uprxdLetyvmGjiss0SNnf3pOSlm2rvloKbbMsHve/lLSie77qc43Q38ee00qQNHkJJl8Yb4RWeZ6GOcS7ZRJ4V6A1BWp2uXU5DXtEC0swV1qKdA4+d4kKhWLaOdHt0897O5Z+/r/To+aG6+46dTuwR+1Osf+nwAPkE1VIYwPiRhwhHSKGuWnbSGFqIU/HqpGT2pM/n8RS2vGIKxZSZ2+ofPIMcUR2zC2LhABs/qBbti5OCCWTaD7yPnanzwtkBSAxPAB6kNArDnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARzgAhx5+iefT2cXoDzBtwtcrWFp3CCH0SBlctD0Fa4=;
 b=ZiV8dGIqJ1svIEodlO9/BKSFO1aHb2JghbYlLhVriVUb+lmXRDBH5Yn6ANqIa0KFuDmwmoQzHtscSljS1dRuk6FqJr988QZ6B1dwvwY++yx+qnH2GED892RrDXu6/hUQe2hPjHp6WLuUBASAhV87CHi2N5qwvw/81kifVuvrpzObp0i7txHXpv+gNIgHYB1PEgKdE2QRo9vq1xjYreLfLNP4qemfyqxUuQiJDSTecb9nS6LCxYsiNEfJPIaD1Ts06r4FJkiLLcDFQl7MbQmTGJiD0Tm4hg8PsXHdEnm9ELV10hKH4edUuEadGL5Er4xhKVblstPIRLQAM8oyn4jNxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARzgAhx5+iefT2cXoDzBtwtcrWFp3CCH0SBlctD0Fa4=;
 b=0LLB0vyuv3QgOmpjz2JaM5sXo6UBaitYLslcxBWhiJwewXtlMYDs7/en55cKMzsBWJyYbcpwtTZzBNb4hs4LSNpue1VRbVClMsqirpz/7qR5PxgUxeZuQswhint/BbydCYbGAkm+f3fv87CDo6KKIudqF/WOBFQ8sGdRgZCkI8wPhiD9iXquVYVrLXT0VvW8CH2At5TocsmBzNyRY11n2/z42L3+b5OKrZcal3FE5KzQWdJ2qqpAtbIhkAup8EY5BkPOi3u46aYp5qDWWMvGDe3eQy9GbcQjKt0qc8ZTDfuR6fohTJ9jasa7PtbQnquDw+G1Lfb0DXmNmMOk60+QCw==
Received: from DBBPR09CA0043.eurprd09.prod.outlook.com (2603:10a6:10:d4::31)
 by DB6PR10MB1781.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:3b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Sat, 23 Jul
 2022 17:24:19 +0000
Received: from DB5EUR01FT107.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:d4:cafe::3d) by DBBPR09CA0043.outlook.office365.com
 (2603:10a6:10:d4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18 via Frontend
 Transport; Sat, 23 Jul 2022 17:24:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT107.mail.protection.outlook.com (10.152.5.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.17 via Frontend Transport; Sat, 23 Jul 2022 17:24:18 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Sat, 23 Jul 2022 19:24:17 +0200
Received: from [139.22.136.240] (139.22.136.240) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Sat, 23 Jul 2022 19:24:17 +0200
Message-ID: <c63a7711-155a-7b0f-2109-1ffc4513954d@siemens.com>
Date: Sat, 23 Jul 2022 19:24:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [isar-cip-core] security-customizations: Fix pam_tally2
 deprecation
Content-Language: en-US
To: <venkata.pyla@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
References: <20220721065917.11637-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220721065917.11637-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.136.240]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.767600-8.000000
X-TMASE-MatchedRID: rRgX50UcFf4wrKi3eh3JIsb9CgEQmMW5Pg9yfk4YC0Z85pjA/x1xfj8H
	EU7XbMTEs4syQgRlrAbZ6KrkcB2NwWoHrAS1YTuNovzBAOTiWSvI2RqSAXh33vbta0OAYFzyZR2
	Pb/n2ShjfUZT83lbkEHIozGa69omd9gdo4A1msVVDL+swkbtLAsjtk333nHvJKiJEqUFWRgjdKR
	Njzo2IONtyuGMeRpfEEBU30mAyJQTcTnF4qsws8gU9C0Kxc2qhKFbesJUuOxy/inf4HhMrey6My
	Pq4TWG5tsxVqq1TeAVeN6wU53SkzuLzNWBegCW2RYvisGWbbS+3sNbcHjySQd0H8LFZNFG7bkV4
	e2xSge78X61p0BB4YTwcedY95tMkVrmpMPa5JGJ8A/Joy3I4z+ulxyHOcPoH
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.767600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 23205FED08ABCFB01DB18EA1DB35D82DC75AC001C5A7545102277D77154C46172000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bef71bda-58a2-4e85-dd64-08da6cd02ca9
X-MS-TrafficTypeDiagnostic: DB6PR10MB1781:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XShozyealHLfxs9jLzpsMf/rLXVQFTu3HHcuanJ65mr34XuTThLd2fuiWbxiYaax0k7sA/4oZtsMaYe7o1KNEBP2T/lFRyYvv9EfkQwiRvubtfP+KVhnWfeRnonrCJq4um4769i590PcaWOTdK24ZLKG9m62hNUrRlKvhXXUren6JER3tYM04aZUL9Z88UVPbsz8ep9GClwtyQwJYSxwlpZEHiZLGouQxR0Fkb+oXN1Qcu4oTLyz+ybXAMO5IwzWh3It1IVoMPNZOTqSfZEoo4DlVsrxXGixeeHZvp4dr1CXwgVxTaGW5j+EexSF/WTc7UzE9Mx4kRN0Q+ypw64jBLEHlJ+HZBCUF7nPS4qUA7XbnocEw1WhjvqmlcHjNcSlwvHgiKiBoWSnvocw0Xo15pj1emx5OEQ+2jmqNVF51aEcVAI+i7eiZ02DysQSGObeXjOXBqnsBdClRDBJaYjvCRYpcQ7t6FO5MpH6DyJWpPu3UWCLNkWu2AC5/sBC0OLgg1/ce5kgAJWkRqxvwN4x1C1FUsuXSyZ/yfC+wptGM52M0+778zO2Q5mpWRNKf5SagtqUkbmWX7T/Ndskp0ljxLD5t7hSnxZa5rhZvyhBFiVsfLzEHYgg7Q8KfpBhp+0NlhldxP+6oJoSzG2yRtjbzdgYJJttVOJrkic9AqlZ+97e3kx3pdSa7zLKJG/47aDBhwPvudC6cmHJhq6Kvw69ycDKhMOnWaR2oV3M1yclxb/cQ7VbxleQF7Ne6wB0f/BkCpEHBlieuuvKXb87bpNbiO4FMrAMNdfyh+qyg62aNv1vA38HX5FRvT7ZpjWFkKvVNseFE40TOkgb8tQAJHAqmGg3pLASR2A4orN1YV3K2jJRPKElp6/VQ/KByQSaUk4ZJipyoMF/sNHPYOHabZWzblterpXVhAST+AVZgMHHhUg=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(39860400002)(36840700001)(40470700004)(46966006)(36860700001)(6706004)(356005)(2906002)(82960400001)(70586007)(53546011)(186003)(8936002)(82740400003)(83380400001)(26005)(956004)(36756003)(2616005)(81166007)(336012)(316002)(31686004)(110136005)(4326008)(86362001)(478600001)(5660300002)(82310400005)(966005)(31696002)(6666004)(47076005)(15650500001)(41300700001)(70206006)(40460700003)(54906003)(8676002)(44832011)(16576012)(16526019)(40480700001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 17:24:18.3892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bef71bda-58a2-4e85-dd64-08da6cd02ca9
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT107.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1781
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 23 Jul 2022 17:24:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8892

On 21.07.22 08:59, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> pam_tally2 is deprecated from PAM version 1.4.0 that is from
> Debian Bullseye, and introduced pam_faillock as replacement [1].
> 
> Modified the security customizations to check first pam_tally2 existence
> for backward compatibility and if not found use the pam_faillock to
> achieve the same functionality.
> 
> Fixes #33
> 
> [1] https://github.com/linux-pam/linux-pam/releases/tag/v1.4.0
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  .../security-customizations/files/postinst    | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
> index 9ba8540..ae06ab7 100644
> --- a/recipes-core/security-customizations/files/postinst
> +++ b/recipes-core/security-customizations/files/postinst
> @@ -22,11 +22,22 @@ sed -i "0,/^password.*/s/^password.*/${pam_cracklib_config}\n&/" "${PAM_PWD_FILE
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

Shouldn't we rather fail (exit 1) in this case?

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

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

