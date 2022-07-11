Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A27C433EF
	for <webhook@archiver.kernel.org>; Mon, 11 Jul 2022 11:01:10 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.83])
 by mx.groups.io with SMTP id smtpd.web12.27015.1657537269038918079
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Jul 2022 04:01:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MZCl/F5R;
 spf=pass (domain: siemens.com, ip: 40.107.20.83,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBuZiwsaEUynFMbLL/POhgKQ1Gu6zyOcx4wjuefa567pAwnwJo8CVLRKl51lrAx0HuuURMvqN8WIVW+XTYOUDgfK6amG3lw8ygKtBXNomHQk1zOoQker5pBff/42bzp/3OuTUpfLS3LiEudyHUhqLQr0EDXxOhHxPuG/pcNvKBvCG7vcww45DEkfVoY4wmhe2OLvpqSm3kgM+aAwC56ZjszIzQ+tBPMTuR4j/oeCwz4XgVS+HDLnomi3ZQA2Rw5TcrFezU6hDjhIVkhfcUZFSR3UhJlCWCZCUio1qd7qW1GfZU9c26sxsuLr3SG5qXJtaMTcB86vXUZuFzRJe7Si4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiHelIFiuXRWaq6Tivy2mAI7uhmMAf60zt0Bwg9TS3Y=;
 b=QtA4HOQ8ME0azO3eIqW3dAd+iDuRk7aoIZSksc5QdAydL/b0oxlzEjdynwPtisIyyZSgmGFFulw1fOWYqDyekpwccsz5pN9umPQTQj0RDdoH1nGiYRS9iZBOAZsYqKNSS7Q1r/3FuE2EED6lSoLOYl3u9fpoXYrnEM6apKBxj3onRu5LMVgO0mu52EJ+Cii0VtJUHj60t8BBiR8MtOlkAyapRlkX27lDN4TNUWr593gsnqld3IELTHe+Pv0hMbuJEbxCDyMH9gPUt+2EDqrOWgMAPNj6OwTztZ+nZRhN/60s5xhXbowyo9jX4TjCy5686yJpAfS5ezPj4iCn61wSDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiHelIFiuXRWaq6Tivy2mAI7uhmMAf60zt0Bwg9TS3Y=;
 b=MZCl/F5RC/55RiYretgP8mBkeKJkvWeNfmOG3i5cX5LtNaxG0iqrql2rfpDW0ABBpCRNiibBqAb52svAnBipwYuK4gkP+ns5kYDPwsOd4jAMLGLbnKV+dH5GHr5woxI2mD3boos3qB8763bZo+FBCF13503ar2xbxe1to7Fasi6SYmjJP7+RWlUyWeq/E5B52G2yaqBiBiBw7JNYetxIsLWACwQVFdYrYpzCrHAEuhNcj6vabmb4IrX4p2e4Iky8VIfhhgmBJrJib0TVJUmgNTUTxNsGMvc2YcXL17IsBXmfNuuDJ0gv0WYpDMjMFKombAljwNtFaWLcTgh2XHxX0Q==
Received: from OL1P279CA0003.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::8) by
 HE1PR1001MB1163.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:6c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.24; Mon, 11 Jul 2022 11:01:05 +0000
Received: from HE1EUR01FT038.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::9f) by OL1P279CA0003.outlook.office365.com
 (2603:10a6:e10:12::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Mon, 11 Jul 2022 11:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT038.mail.protection.outlook.com (10.152.1.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 11:01:04 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 11 Jul 2022 13:01:03 +0200
Received: from [167.87.9.151] (167.87.9.151) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Mon, 11 Jul
 2022 13:01:03 +0200
Message-ID: <f6176d56-ee0e-6b3d-53a2-dcba82de82ad@siemens.com>
Date: Mon, 11 Jul 2022 13:01:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [isar-cip-core v3]
 recipes-core/security-customizations/files/postinst:Add configuration for MFA
Content-Language: en-US
To: <Shreyas.Karmahe@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <venkata.pyla@toshiba-tsip.com>,
	<kazuhiro3.hayashi@toshiba.co.jp>
References: <20220711102903.4088463-1-Shreyas.Karmahe@toshiba-tsip.com>
 <20220711102903.4088463-2-Shreyas.Karmahe@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220711102903.4088463-2-Shreyas.Karmahe@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.9.151]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.616500-8.000000
X-TMASE-MatchedRID: FdhKtQVb1TzdDS6etHbe2x8Qq+M7nEvg/k5m7D0YTS/x5KZMlKYS/Tim
	0TkqdUteuDN23G33DKYwbGWKLQaL6c3aYyig7WDai7kudfmTABOcwDdLDXDKeT8Ckw9b/GFeQZQ
	mndT7pfABdlbY0orTyB2rrGe8rZbLmfJeSkrv0+qisl4BOACV2p8SZr7CT1NHWTWEh5N2a9HFNT
	BT09GlYl42zm1Zi+MJcULR8x5ADnA8ojAITt0iQDeC74ow4RfOzPunZX5hd1hgU3jdZjTfnPMvk
	xDPDXiHe8fEEoQTPqBzFn5q/FBFPIXgyQHesK4yLxxHBMdDc7oy7wvC8Uc6Hfbta0OAYFzye+Dz
	0kRbVDibKItl61J/ycnjLTA/UDoAoTCA5Efyn8CNo+PRbWqfRDsAVzN+Ov/sMM6HOoL5qtNUL9R
	9EeYbH8ECe2pRQDeOpeziimJ6MHbNqnhz213Suw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.616500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 578B96A3078B5E191F8C97F1A548F94E00CB40EC8204EB180C4EB6B2312073092000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0af472e-df28-4503-ee89-08da632ca633
X-MS-TrafficTypeDiagnostic: HE1PR1001MB1163:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AOfD/4xYNyCl1L9WuziLVxNfvZkvkOG8ybi8tfzBhd3PPLENDps1fXVKzeLg2EZnruppqzI8KRbvUHFqJpEVI5WrEerziaFUI8bD6hw6I6NVM+0ZSxVP5BSl/wJZpGO0GX5bZWvUwHn9EvoR5yzGCfeiAXgDEtRNf4DCBC37BQPw3yGe17AbtddUymfgK//Gs7HOeFq4xTM2yahYUJXxMlpB2sUmYQqjO98nI1Ffgb0+e/94aR2eoulVsPZ/PJi6mT22lAxrop/8zAkCK7zyMPQ/+vCWQ5Tu9ydqcMj05+qT8WHUS5kK4RE5xFqVegGP85sjKni9YqDEbhsMPo3Dy3RSk9zS3CsQ6IYX/npKYSOqgGcppYHuXhHk2isf2T6QBhp0lj3hoeBTxniAToqmIqUcYuillT9aYbnXcoU9U0LaOdALVkU7yWiOYJLy6hDQEcuAq5ZIEYYuWgINlXLX8SR+sxtee+zBmWLMYqY4+9JedkFRNqAwoUTyD3Z7+K07wsBrY12FX1DnFl3NbvBYlonhRah8HND6nEaJ9Se3dSB08QVgdgxzzdxsV1gqn51V52zIryesuh/9m5d93UwGhcVU9kAhsV+NOKOqCUBdsIHzLKKnhfV2PZ6ZVq3U4JUOuHCUz5Qw6SarvAQJhE+MRzpqF034AauNNFs8Qa23LouPQJd7MUt+4QpAeZ0OUc/c7BHxX/wc9lCp6xe4oQkOup7dX/Rgzg4fjZzZhetJVO2vIEcmNG8Do8HBArv/ponOe+adZrd1VcrlzmD9OAnNpk6awUIKegS5PmzLKvIs6+bwL+yUEwkWiNFlA85OLWPAT2MyTHX1dwn0NkKtXF6vk5MjKfVoRCgCuYrIukSsAbuyNhcRieVBcS/QRpeCQeszGko6b+cMGQ7zfl4+HvPSrEwtu7DNaAeOghtS2GyhUuc=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(40470700004)(36840700001)(46966006)(83380400001)(47076005)(336012)(8676002)(40480700001)(70206006)(956004)(4326008)(2616005)(70586007)(186003)(31696002)(16526019)(82740400003)(82960400001)(86362001)(8936002)(5660300002)(36860700001)(356005)(2906002)(40460700003)(81166007)(15650500001)(16576012)(53546011)(316002)(54906003)(26005)(36756003)(6706004)(478600001)(41300700001)(82310400005)(110136005)(31686004)(44832011)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 11:01:04.3655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b0af472e-df28-4503-ee89-08da632ca633
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT038.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB1163
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Jul 2022 11:01:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8740

On 11.07.22 12:29, Shreyas.Karmahe@toshiba-tsip.com wrote:
> From: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
> 
> It configures libpam-google-authenticator for achieving the IEC requirement for
> Multi-Factor Authentication.
> 
> Signed-off-by: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
> ---
>  recipes-core/security-customizations/files/postinst   | 11 +++++++++++
>  .../security-customizations.bb                        |  2 +-
>  2 files changed, 12 insertions(+), 1 deletion(-)
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
> diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
> index 10d875c..4a41d2d 100644
> --- a/recipes-core/security-customizations/security-customizations.bb
> +++ b/recipes-core/security-customizations/security-customizations.bb
> @@ -16,4 +16,4 @@ DESCRIPTION = "CIP Security image for IEC62443-4-2 evaluation"
>  SRC_URI = " file://postinst"
>  
>  DEPENDS = "sshd-regen-keys"
> -DEBIAN_DEPENDS = "sshd-regen-keys"
> +DEBIAN_DEPENDS = "sshd-regen-keys, libpam-google-authenticator"

Applied to next, with a little bit of subject massaging:

"security-customizations: Add configuration for MFA"

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

