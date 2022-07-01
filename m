Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64D0C43334
	for <webhook@archiver.kernel.org>; Fri,  1 Jul 2022 11:33:07 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.80])
 by mx.groups.io with SMTP id smtpd.web11.36755.1656675178501021034
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Jul 2022 04:32:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mLTk+F5T;
 spf=pass (domain: siemens.com, ip: 40.107.8.80,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOBcYcEskIEsVA3c6SMuvgG5S9WDQfNke0LDhagMFs509cGUAsEVKgFs8CkzpiX1bNrllq+JTZY8Jrxqs5LRsayPk69h5rXQ7LxQGR57QmGFn1prytiJhJRqYfcNYCmBz7sii9ctaYlY9Lmod5O/BPNfFrUG7F42/iLC39KLL7sa5lQOtgn2h7Xq8dunz7MdhivAK+TfUNU0q2RHmIRNczOmb5QOB+KwmEY+mED/qQ4SWRZRH2Erchkk0wimCnZikYm5yP6VMd3dy5k0cxa5RhYRT3cR6B/PnmbGpJzQqDK0cxJ7f//QiUfhyT7/UY6MT7BhKbMOYnYkVmrs2iFIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPxfvb0k6FUwh5m6DrSP/etAOU4WswFiidLcGb1BVbs=;
 b=jGgVufpquknO9mOYN5BtzPkj5x+5Xmfl4FIjMhhxHb+4IoZ3u5Ut9Cx3f7+SodgXg3WqeUuxnA4Xe7fHpBaizcu6n2nrsnfWIsgcbIOLjLzLUM9PkBn/48efZ5yt535zWQmm7rP0jiOAr+bBOb0u64qOxqpraO0iRN+zNFHtAaTk/1dvW4hCUdZ7tWWbMlXlYGw0kQzPcx8C9fwy2Oqo8AXaeuGDcubBbecmiWce6cJIoceyFdVslLfdRLJ9yA3klk+JZU12dZea48az73XgHKpdjcCRA8LM6xgVtu3KusUzUSDV4n0BU1XmfpZJ9675hVgLhsw2nkMMTL86VXgvdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPxfvb0k6FUwh5m6DrSP/etAOU4WswFiidLcGb1BVbs=;
 b=mLTk+F5TQecJQo2KBST9t4BSXGFGaYxNd+mkmDX/DO8S+1PBdW3JK0ujfo25UZI8oVGaGhSX2kRqW9hyYZRbG28qZ1wL6Ux4wdqcAjCJWyVaL45yGvmUFWB96QXn4Eu+M6ikyLSAf/RtCHmRBp/uZpghjxLCpCjL32xlZltKZ1tvT0QWATmSBO94PBIRazA1iBC4F7TYPX73Tfs8vHljEPNJEiPd5DtWtoqacjfREfFmxmw3WRySIQAbO3d61L0E12EbCQpsqnQez2wb8l1envM43tBYIQ+OOy+XgFF1tXkPd2NQpj+qjPjjmEMcCetiI1O7OH9R2OLNvfXRRO8O0A==
Received: from DB6PR07CA0108.eurprd07.prod.outlook.com (2603:10a6:6:2c::22) by
 AS4PR10MB5546.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4cc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14; Fri, 1 Jul 2022 11:32:55 +0000
Received: from DB5EUR01FT032.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:2c:cafe::3e) by DB6PR07CA0108.outlook.office365.com
 (2603:10a6:6:2c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.8 via Frontend
 Transport; Fri, 1 Jul 2022 11:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT032.mail.protection.outlook.com (10.152.4.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Fri, 1 Jul 2022 11:32:54 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 1 Jul 2022 13:32:53 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Fri, 1 Jul 2022
 13:32:53 +0200
Message-ID: <446fe1e4-eaca-f920-3750-cbea068a8347@siemens.com>
Date: Fri, 1 Jul 2022 13:32:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [isar-cip-core] postinst:Added lines to verify Local and Remote
 Multi-factor Authentication
Content-Language: en-US
To: <Shreyas.Karmahe@toshiba-tsip.com>, <yes@arc11.toshiba.co.jp>,
	<cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <venkata.pyla@toshiba-tsip.com>,
	<kazuhiro3.hayashi@toshiba.co.jp>
References: <yes> <20220630112644.3682066-1-Shreyas.Karmahe@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220630112644.3682066-1-Shreyas.Karmahe@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--19.062700-8.000000
X-TMASE-MatchedRID: AQ9SOYvqpDYhz+KjBN9OuYldd8VMUiC5/k5m7D0YTS/x5KZMlKYS/Q/o
	5bNHEsCTV7MQTbTl028i5/9hlXY2r+CvRZnq77KlA32djEHOWJqcwDdLDXDKeT8Ckw9b/GFehnC
	FIAQefsjoU8g9IMz+h0gOYX1vhvgM47CMV9e94vyyCtXR476v1Ad1O2DSI1kjHli0ghrWY9ty4V
	FP6muDhgF2VtjSitPIHausZ7ytlsuZ8l5KSu/T6j8hBHS3QANt1cQa/EJbtzYhXJsS++injt0pE
	2POjYg45lhx0mBJyPHO6e57srUCCSvn27+DO/kwtTOrxEGQm4Zw1ghGV72CBzuUqTPTfDTrfS0I
	p2eEHny+qryzYw2E8LLn+0Vm71Lcq7rFUcuGp/EgBwKKRHe+r4GkpcVXmy/7gMGyEdRIGzaiz8o
	rma6WstFT6o61EmdUbUw3bxFAruY=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.062700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 18E0305B7FCD4FC147F1651DC3303B473BD4D46CB86C3C438C363A1AEFC1E0B92000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e456002b-064d-4840-404f-08da5b557077
X-MS-TrafficTypeDiagnostic: AS4PR10MB5546:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	k7WT51T8uhBEIbynRX0a8KnOMxmwhsqQSK7AsViAyQ+8vCXusFX3fnxUZ9UnqaojQ1YqwQACLDyn46L2fHSney5Be0ZT0VSAmm/jyMEC1yPoPt3ToChVGe7bXoExGF+W0ZHmbWI+Y5DcRf/IrSkYs0ufjBq8t8nPbrn/QVjDT1uGUo3rau5X7wrCKrpe0G1S8juaV5ZIw61/yLrBl8n7GvsjkniJc43z0hEm/q1A7FtdKd3cy/8DsjPLK+fWNh6YTId4Irmy1Zbh4JcFCZzAnkNSRjpWnr8i29rLApMWG0ZlCjLCZ0LJmKyLgmboGZAZn4KlQhnBc0RbjbAlJVNjy6jY15fg2yrJc3189snJg5jHu/0DvCFs1f5PmEYpq65NZjViOwHLSj0WUZVqOEZdiTCzOfKVmjJwlflVY0F40eZuQBPd3Imwy0oOOl5RBjyaReVRE9SZ2BDu/9z8/RGau8DxctQgV+5FXamprlnlnq50Ke9CfRKcduTfooeBLujc5DJ4lFmcxNkIzY9jrv/BsQ6xL3ilTRfigWdPxE5j6hHKyf23S9c2hnQjQ3ZTxVYQaJKGcoM57wJ1zAnUsJQRn+4a7ehe7QdFSKMqDrTH3M2ocOZCMQfb/GmCddAHPWS7CLsoeFRxYh/SEEFeSNVpgm81Vmrn5UerkV3thxU368CBRKl/fzzE7oZL2AsbBFw1dRAlhTjipfQrisxuaHdVhmBs7nu8VkOBInr1SCOynb9s32/+9RSAbMzPSpvKcOMkoBuWGrQgtyNTzz6zXT8HTrJJH/+1Ifg16E84TJmyRcxnG1pYUGh8Pb+9HYDqgE8rX92/LszEsPbf56qYLjkqSt6ifD3TqNzoQ/6zyq/3h2sY7hEnUrqFvN2+DTUye5lSdu880gHrHD4aw8wPIcg+xYgCLOrxchanpCRWkzZN3G4=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(40470700004)(46966006)(36840700001)(70586007)(83380400001)(36860700001)(40480700001)(40460700003)(110136005)(5660300002)(53546011)(70206006)(31696002)(26005)(15650500001)(8936002)(4326008)(86362001)(82960400001)(81166007)(82740400003)(8676002)(478600001)(16576012)(54906003)(2906002)(44832011)(41300700001)(2616005)(31686004)(186003)(6706004)(16526019)(336012)(316002)(36756003)(47076005)(82310400005)(956004)(356005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 11:32:54.2776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e456002b-064d-4840-404f-08da5b557077
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT032.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5546
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Jul 2022 11:33:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8631

On 30.06.22 13:26, Shreyas.Karmahe@toshiba-tsip.com wrote:
> From: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
> 
> To enable and configure PAM for Remote and Local MFA Session Verification
> 
> Signed-off-by: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
> ---
>  .../security-customizations/files/postinst        | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
> index bb7d15b..843ce3c 100644
> --- a/recipes-core/security-customizations/files/postinst
> +++ b/recipes-core/security-customizations/files/postinst
> @@ -15,7 +15,8 @@ echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
>  PAM_PWD_FILE="/etc/pam.d/common-password"
>  pam_cracklib_config="password  requisite    pam_cracklib.so retry=3 minlen=8 maxrepeat=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1  difok=3 gecoscheck=1 reject_username  enforce_for_root"
>  if grep -c "pam_cracklib.so" "${PAM_PWD_FILE}";then
> -        sed -i '/pam_cracklib.so/ s/^#*/#/'  "${PAM_PWD_FILE}"
> +        
> +sed -i '/pam_cracklib.so/ s/^#*/#/'  "${PAM_PWD_FILE}"
>  fi
>  sed -i "0,/^password.*/s/^password.*/${pam_cracklib_config}\n&/" "${PAM_PWD_FILE}"
>  
> @@ -49,3 +50,15 @@ sed -i 's/admin_space_left_action = .*/admin_space_left_action = SYSLOG/' $AUDIT
>  
>  # CR2.10: Response to audit processing failures
>  sed -i 's/disk_error_action = .*/disk_error_action = SYSLOG/' $AUDIT_CONF_FILE
> +
> +# CR2.11: Enable Mutli Factor Authentication for Local and Remote Session
> +SSHD_AUTH_CONFIG="/etc/pam.d/common-auth"
> +google_authenticator="auth required pam_google_authenticator.so nullok"
> +if grep -c "pam_google_authenticator.so" "${SSHD_AUTH_CONFIG}";then
> +		sed -i '/pam_google_authenticator.so/ s/^#*/#/'  "${SSHD_AUTH_CONFIG}"
> +fi
> +#sed -i "0,/^auth.*/s/^auth.*/${google_authenticator}\n&/" "${SSHD_AUTH_CONFIG}"

Dead code? Or forgotten to activate?

> +echo "auth required pam_google_authenticator.so nullok" | tee -a "${SSHD_AUTH_CONFIG}"
> +# Enable PAM configuration for Remote Session
> +sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' "${SSHD_CONFIG}"
> +echo "AuthenticationMethods keyboard-interactive" | tee -a "${SSHD_CONFIG}"

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

