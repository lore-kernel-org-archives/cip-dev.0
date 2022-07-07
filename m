Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23235C43334
	for <webhook@archiver.kernel.org>; Thu,  7 Jul 2022 10:55:54 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.53])
 by mx.groups.io with SMTP id smtpd.web09.4109.1657191343801545492
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Jul 2022 03:55:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pNrNMPVM;
 spf=pass (domain: siemens.com, ip: 40.107.20.53,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQ+jmf/zsR1E9pm67auKizXUFs/maDRQFIrD1G5BSQOA7H7ALGperp3EwbbFpmizXh+1qcS7MUnTGZpvFKSspC4fX4JrWJkhI/mSqHgJU2NadMkFfdQUJpnPTAoSP3Uf2Nc/H5GmdhlNrhZE+wAWGn5NyqQR1KFnNlI1acTIw7gOb4bRV1tnP2wS6JcRm6Hjunl5PNSUX9pjH8Ow58/riIFeSTAiQswP9qu+q2rlXnxj6rEWY/cGSC49r6O/OTL/A0rIfxXsLxykatM/aT13poVPZLKBzGAfFSEkgkdNhJmftvPj+U7+iDhateRdbWuctNkZO5tFLIJnlCq38wL3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Rntj/VhVf75oNKv/wyZWLWkOhnX3LVMtrGOg5SpWRY=;
 b=nonV7cjQj+1LbJ4huaBqMF0UbrXCX2ngn97Mzy0MayC8tF9Yw3bALg9/3gv5uFCNbx/uVEQYUoBfdmpgAOuiNkO466nu+aqqcenYDmmaPiHUm9KrJVUUfnh36aQtq0dj9VAxbh+CWej0BJiD6mjn/rDW34F7NCAa3tsayzACjehs5FmRmFZOqCvW2P/lwAagtQg+7zPIt6anq6DtVuTqleNAjxnEvb+uRWOzjf2EuJ63X+oIp7qKTMtLRd4Cznhc4otUqXUN0aR4IZvETx8lS9etJwA5fc9rYykRYfOhXRyjZEsWw5UqFIrAkq1kq34GJDYsWVfRnXIuog8uogzmLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Rntj/VhVf75oNKv/wyZWLWkOhnX3LVMtrGOg5SpWRY=;
 b=pNrNMPVMYtGWDYK1IWC1+oZCr0FDmtcNuNNQdz1md4IiWDP2jXA1ftsBsn4eTBhpPwZyh9Uoooh1r+njfaWs4QMyC3Hl5onTLmVunO44RtTulyQmL2eG24UMPh9a+9nacvqYPJvuUeOE6/v/JC5t6FKzaTIGq90H2VIdYkNdyAVanJis+0XyLW9DOuZyeNqGT0UN8lWG8ZlQy7m8ENY4FAT60h3GTjHXPoaPVJ5aB4gh/RO6NVeC9sxT3HAAfr+Z+jxLhKUt8jLcnA35dcakkfjxaJa2kl9hZPhp2y/G+alo+0G3O9fNm7Tze9gQBEQwJb/CGcjV/bULhHUL3u5yAw==
Received: from FR3P281CA0049.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::22)
 by HE1PR10MB1785.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:7:5f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 7 Jul
 2022 10:55:41 +0000
Received: from VE1EUR01FT107.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:4a:cafe::41) by FR3P281CA0049.outlook.office365.com
 (2603:10a6:d10:4a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.9 via Frontend
 Transport; Thu, 7 Jul 2022 10:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT107.mail.protection.outlook.com (10.152.3.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16 via Frontend Transport; Thu, 7 Jul 2022 10:55:39 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 7 Jul 2022 12:55:39 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Thu, 7 Jul 2022
 12:55:39 +0200
Message-ID: <c5593a24-4bc2-b6a4-9f1f-d52e172b68d5@siemens.com>
Date: Thu, 7 Jul 2022 12:55:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [isar-cip-core] security-customizations/postinst:Add
 configuration for MFA
Content-Language: en-US
To: <Shreyas.Karmahe@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <venkata.pyla@toshiba-tsip.com>,
	<kazuhiro3.hayashi@toshiba.co.jp>
References: <20220707103331.3912839-1-Shreyas.Karmahe@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220707103331.3912839-1-Shreyas.Karmahe@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.054700-8.000000
X-TMASE-MatchedRID: 72nS2hokiaQwrKi3eh3JIsb9CgEQmMW5Pg9yfk4YC0YhXJsS++inji45
	ojdE7FAWAQe1ufITXxx4oPBwjFVS7nxs7qFZ9FbOj0IvV7jlqDhoDvOMa6ennlsX6O8mWQ6mBXn
	gI6jFvpf5q5JB+ib2QU7MpBiz7lGOg7cFeMsvTcVvedD3CYSjHZXi9leWDF7pMKPrF7dK57PKIq
	Aq0jIHigW+MaoIxPn7yHI9pvh+9W8r59u/gzv5MLUzq8RBkJuGcNYIRle9ggc7lKkz03w0630tC
	KdnhB58vqq8s2MNhPCy5/tFZu9S3Ku6xVHLhqfxIAcCikR3vq/uN97cjPqQ5sVvFZ9WAGw9Z8+W
	sKu4zAsXg5Xj2M/iEQ2M/gBE4+cC
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.054700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 C6EFFCFE57BCD2930B4C34C322D372F69102D87013FC117A42E32F06383AE9DB2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f830622-e8fe-40a4-781f-08da60073b02
X-MS-TrafficTypeDiagnostic: HE1PR10MB1785:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EWtK3nrD36fjXJtrdcTyyNCit+ZyTfGh4AzSEN8w0Vwcv9IfpSaYVHYllflfeRKlduoObx90AtvTNBz5Bou3S1v46u275jMV2N3lSKU8CtrvvYllTYgesylNDQ66Xoe4xsFv5QqQmhZAK5tLMqgQ+XWoGiRqkGxPXqeHx9jDdigwsjzd7vsiRvWqFFWFP6JW2a29pNfjjrCI2FdZET1tM0eP/yCZx6V9EnSiVHY6PX60yUKWKq2eAYZi51aKSg7HpN2B4vSugMBNdj3uoF/gTEfcIjhYyPy9lIqIiWKQ045akPOg51vOY8go25kuoBxLGrO4g+7iwV9uLk4BL3QUftSRc8DCwLrGtdXSEv13XQFc2QdFgJx67S+buKmk1xgSlvPBFoGazJGO0pZCmV5lj6AkYj5WCjlmhaPWiXCHpYE21Mqk9vo1NQQ5zqkr8+0BwMJxcrCm6jre1geVYHDOL7LVoAOZlLfwavyaQX90S3mnnHABeAz8589wt4bfUR1aJj8JEaHVSOrSQnhhAlzutcd8YTmYTcD6fYvubPdVRLE541j4xZX93SV3AMscuTRizCbB7+bEphmQbB/7aVwbJeDca6JIILEM3O8oaUV6SOuS7KaoSCas+sXuNpUm5jHJp1PtWbfrnV9QMbz4vINLZeA5hrJXwuCruokI3yo+lUWSTU7TnVM0jcEJ02347OA0ooox7w7ltHw7s+an+oQw64JkvhLVf5NbtTK6jxjiKehJyL+LIVw1jbjDByzeG0EaPz9oXgtBINqDtKWRjBVbKgvW5njGXi5kRcJRmdVqzmAmXL9MhqC/gpCjuC1K8T6+6jZGolY+APhTWo9w9o+b7cafmmsk2FVBv7G4HGk+DR0t1+fJxY4O3Aa0QZpSTh0p
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(376002)(36840700001)(46966006)(40470700004)(40480700001)(478600001)(36860700001)(15650500001)(70586007)(47076005)(41300700001)(40460700003)(83380400001)(8936002)(2906002)(44832011)(5660300002)(4326008)(53546011)(7636003)(16526019)(86362001)(186003)(31696002)(82960400001)(956004)(316002)(36756003)(356005)(31686004)(82740400003)(70206006)(8676002)(82310400005)(16576012)(6706004)(26005)(110136005)(54906003)(7596003)(2616005)(336012)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 10:55:39.6776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7f830622-e8fe-40a4-781f-08da60073b02
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT107.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR10MB1785
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Jul 2022 10:55:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8715

On 07.07.22 12:33, Shreyas.Karmahe@toshiba-tsip.com wrote:
> From: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
> 
> It configures libpam-google-authenticator for achieving the IEC requirement
> for Multi-Factor Authentication.
> 
> Signed-off-by: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
> ---
>  recipes-core/security-customizations/files/postinst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
> index 3699ba2..9ba8540 100644
> --- a/recipes-core/security-customizations/files/postinst
> +++ b/recipes-core/security-customizations/files/postinst
> @@ -49,3 +49,14 @@ sed -i 's/admin_space_left_action = .*/admin_space_left_action = SYSLOG/' $AUDIT
>  
>  # CR2.10: Response to audit processing failures
>  sed -i 's/disk_error_action = .*/disk_error_action = SYSLOG/' $AUDIT_CONF_FILE
> +
> +# CR2.11: Enable Mutli Factor Authentication for Local and Remote Session
> +SSHD_AUTH_CONFIG="/etc/pam.d/common-auth"
> +google_authenticator="auth required pam_google_authenticator.so nullok"
> +if grep -c "pam_google_authenticator.so" "${SSHD_AUTH_CONFIG}";then
> +        sed -i '/pam_google_authenticator.so/ s/^#*/#/'  "${SSHD_AUTH_CONFIG}"
> +fi
> +echo "auth required pam_google_authenticator.so nullok" | tee -a "${SSHD_AUTH_CONFIG}"
> +# Enable PAM configuration for Remote Session
> +sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' "${SSHD_CONFIG}"
> +echo "AuthenticationMethods keyboard-interactive" | tee -a "${SSHD_CONFIG}"

Applied, thanks!

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

