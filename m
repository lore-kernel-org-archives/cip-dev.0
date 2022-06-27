Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181EAC433EF
	for <webhook@archiver.kernel.org>; Mon, 27 Jun 2022 08:14:27 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.57])
 by mx.groups.io with SMTP id smtpd.web12.39224.1656317664233638177
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jun 2022 01:14:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bcgLg7Nr;
 spf=pass (domain: siemens.com, ip: 40.107.7.57,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCnLmwMFwiAtUMI9Z6a+JdAzrhtFUt+pXTOMtJKj6EqK0VchKp42Kl0ZHk9OewZTy9fIBN5svhk0Qe4/pwNajC/uBEcKUqnBQ1sQH0CUJrOUE7ITpII7se4X3ekOpngLyBWIIDGn+5IXFtX66KHeACTPRowmCraOFbHRHdQ97sY2IDGTned/lMLGF6GUfTGZJv6NwncS2cOMBWkOld0jULhOjvzOmgh/tJZmN9hCcPr1wNnRQT8eV4Owt+ul/aojSuJ12uETh16aVUhCbA/8BTAxicKs0PHmiooaNIRlMEW++bjc65SbMlaZ6rxaUtDTlU4STBEOeLQgCqONupttEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfswDGsu6v9ARQ+ZEIUlfTMUjBZ7//4RYeahEAp6dI0=;
 b=gbPtxFxksrBQNVmTaTM5BgL8E9opwq0ZdqFDCOJm7ONYtenqdhSzskpEwYTqFve8pGZOjqVmaUXZVle/kVhvzwGeooNxj5Qi1NdYVU4jdXr5iYkknXebEjzufVbUvFlrN+ahoSfKwaD205kYldOh2MuC/2AzyPtBHjrTmu3KOQVW2zon7rWrY9p7im12k4ZCLPvYN3iuyvBGD/zsClb+5Bjuo3DoN40Ui7wteQaZlzh4pWAeHTAoj21VGmKabAJoPw3/L+bwqEkxsUi934NsfhdG5TsFw9eej8tqgWpYThycv8PsoMdePZ75c3fzRhFtR6fgj0TE8eAy/DqZMPkBGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfswDGsu6v9ARQ+ZEIUlfTMUjBZ7//4RYeahEAp6dI0=;
 b=bcgLg7NrD9hDUbuOwJme9dl3y29pJ8dMV7S/asmFV3LaC+43DV6Y25+aODMD7h8WWx0MKUDfAKZ9U8NA58YJ+X2ydPBqNIUbxzfNL0Ju80pJB6nqqcO+aHYIOV/XOA506wCDSGVK2ghT/qnEZRHBhWNoOfAPgfR/VY5hCPoIC21d/Mk0MqtPV1G0YKgaVTVFGRSzVe0OoQ45o9orprkAAwDC8nQ/mNya6hxExmbHVXyIfDh7ZA73665UjIXlxhtDA//tODQKzBRkcJAYAgr0piHTyXxO3QsPslnKvVXbur4ItY4uXpHwsLDheHHIKnhXwzWZ8eht/xbIKcFYPEujUg==
Received: from DB6PR07CA0103.eurprd07.prod.outlook.com (2603:10a6:6:2c::17) by
 AM7PR10MB3809.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:173::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Mon, 27 Jun
 2022 08:14:21 +0000
Received: from DB5EUR01FT042.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:2c:cafe::2) by DB6PR07CA0103.outlook.office365.com
 (2603:10a6:6:2c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.6 via Frontend
 Transport; Mon, 27 Jun 2022 08:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT042.mail.protection.outlook.com (10.152.5.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15 via Frontend Transport; Mon, 27 Jun 2022 08:14:20 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 27 Jun 2022 10:14:20 +0200
Received: from [139.21.17.228] (139.21.17.228) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 27 Jun 2022 10:14:20 +0200
Message-ID: <665fa99b-7ab0-1b8c-3662-c1f1ad7a8d4c@siemens.com>
Date: Mon, 27 Jun 2022 10:14:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [cip-dev] [isar-cip-core] [PATCH] scripts/start-efishell.sh: Add
 -nographic option
Content-Language: en-US
To: Sarath P T <Sarath_PT@mentor.com>, <cip-dev@lists.cip-project.org>
References: <20220627071206.21277-1-Sarath_PT@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220627071206.21277-1-Sarath_PT@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.17.228]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.317500-8.000000
X-TMASE-MatchedRID: rRgX50UcFf7rOhfRe676RwJfVW3wuXXEPg9yfk4YC0YdZEkR8Y/meUkk
	w4LFoknHzVgwP7ZMYf/WOp/Wv3+h1kKn0xKBwkXRmEKHz5YiYlQi0gNgcOfRtnzmmMD/HXF++If
	riO3cV8QnzvR+mP3cvmg+dQHLmupr3gdTOYIYVWubHAuQ1dUnuWJZXQNDzktSv1vPAPz22Fm3ZQ
	ujNDlAPtO6ICblM+P5N7sWrzbARs8MjL1f8qonVS8cRwTHQ3O6Mu8LwvFHOh327WtDgGBc8n0tC
	KdnhB58vqq8s2MNhPAir3kOMJmHTCYG93cCja46C24oEZ6SpSkgbhiVsIMQK2u5XqFPzjITWLAm
	msEiLikyR2ZTvFQeTDUCeEyDCiWd6PoRbnUdCf/p797Quh01pH7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.317500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 4CC8138A1FBB1921F15F72AACFD7ECBAA41BE08743D0945B483C5F34EB924B8F2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb620f01-9644-4857-c7b0-08da581509df
X-MS-TrafficTypeDiagnostic: AM7PR10MB3809:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tvjNccvKILFc4aB+C0pcv80kTS6tUZorf3vjs7sW3c2YXRmWXufmcii28OMJKeDk6Ue9NRBJJSu97pIFuXsW8by8vERHwtztXLP1OBFRjBLdkColk83QAPvqOAUz4KXzxhet/mg/gfKw4OC+A9tOUjk6D3G9JrOfQPhkscUI7W/WpLYxjeXz9P56En9hnP0j28xt6jMebSByJZ6GJPDdDUkNtKXN0hyhFH9+Gi8L0RPpmwZKgyceD7VMh59QF7EcjNITuOjViNGDVrGHerfs0ZHj3dT+uK8y8bvwUpbbx3t4g2pugH4LsejVieLS2F2WfLs/TFKOmHo4VhkrXzB4U60QjoqgvOGeNeje5fdffwg8Qzf/Xbw1XZvYbbKoy/WPMS+++XNQnuV9UdXelvIR9ODxoraCPYAq6TuWcs5NeqN6MIgGa2u8Ktd9TDbAc89ntsigjv2bx+tcCtsk1RKahTd1/0c0b3190DboicEXQ7PihxKxNPA5XAmH2TCsVzrBrF8mJ4XatO/YK4aly4Lx77U8r1+KIE1qo3Tcrf9yoLI+j1+zjetwc6ui8FBP3TLU+dXUS/epoMq2ORWQjxRfk9+FJ3Wr1wMPK4yhXco3y4gWPtGUjZeZZcqTKNN6QaG6qDEemgjtH2rwqa3kOBZQIMiMylDj61DaD648MbAn5j1VPevGdc8fUJeSDf64AiKcZI5UIVyjVUnR8sae2XzIRzCE1MEH0cqMPiZT/zqkTSocDQOVN/1cdesB5s9X0EpWxJnC4cle6jtU3WIZ/KiOcT/fLn3P990Jw27yN4TL4kRzh31+64o4E349iLahG/j0HEaafZYJu0f1fOvl8D6+7vR5oCEzEBCaQuV5XHWO416k6JXPqhmG/shGqXfIJ4kZiev92xeytq8pjoTM1tWq7g==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966006)(36840700001)(40470700004)(81166007)(16576012)(2616005)(82960400001)(316002)(82740400003)(956004)(186003)(5660300002)(8936002)(336012)(2906002)(110136005)(44832011)(70586007)(70206006)(47076005)(53546011)(83380400001)(8676002)(6706004)(26005)(478600001)(356005)(40460700003)(36860700001)(41300700001)(31686004)(16526019)(86362001)(82310400005)(40480700001)(31696002)(36756003)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 08:14:20.8783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 fb620f01-9644-4857-c7b0-08da581509df
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT042.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3809
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jun 2022 08:14:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8599

On 27.06.22 09:12, Sarath P T wrote:
> From: sarath P T <Sarath_PT@mentor.com>
> 
> When we launch the start-efishell.sh script for
> adding the keys into OVMF firmware we faced
> gtk initialization failed error. So it seems
> we need to open the OVMF in nographic mode, hence
> we added the required option to the script.
> 

Which QEMU-Version? Which OVMF version (buster/bullseye/something else)?
I'm not seeing this, but I'm facing other issues with that firmware
provided by bullseye (a crash).

> Signed-off-by: sarath P T <Sarath_PT@mentor.com>
> ---
>  scripts/start-efishell.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh
> index d451f43..0831f83 100755
> --- a/scripts/start-efishell.sh
> +++ b/scripts/start-efishell.sh
> @@ -2,7 +2,7 @@
>  ovmf_code=${OVMF_CODE:-/usr/share/OVMF/OVMF_CODE.secboot.fd}
>  ovmf_vars=${OVMF_VARS:-./OVMF_VARS.fd}
>  DISK=$1
> -qemu-system-x86_64 -enable-kvm -M q35 \
> +qemu-system-x86_64 -enable-kvm -M q35 -nographic \
>                     -cpu host,hv_relaxed,hv_vapic,hv-spinlocks=0xfff -smp 2 -m 2G -no-hpet \
>                     -global ICH9-LPC.disable_s3=1 \
>                     -global isa-fdc.driveA= \
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

