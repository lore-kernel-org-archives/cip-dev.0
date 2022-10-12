Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3106C433FE
	for <webhook@archiver.kernel.org>; Wed, 12 Oct 2022 11:34:28 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.64])
 by mx.groups.io with SMTP id smtpd.web09.19365.1665574466457239713
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Oct 2022 04:34:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sUcRjs5E;
 spf=pass (domain: siemens.com, ip: 40.107.247.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bqma9XWZPpKuKITIcYqYvbCPyeV28JhdFw27xnoXDNCEOEXWq4e0uxEpSNwcrgFWmJV6ySxFI8NNiRyioPDMebXXcGc9PdFs1TIzxDL1dCw+gwyyxeoS44i7XZJdoSfflvQ6I9b3UKqk0LhzYbUQDpIoQfctMaiGFxo/fIcT2uRt6as8vx/0FUgwlT/V6CVT3SDOZB3DLb+2DFi+uQrf+RqqcFbajf+H6RDWGlvCy7n6JNXP/geR6ytqMHRDjgE9qgQcHeyDLXPyDAy2FH3t2ATr2KYN57WZ9h94G1xFu2YlDIxvQGx65GdSflcZ9z6UKNHbUXaHcHayXd5Nh4EbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cy4fWDtWZmRBDF1eQ3DJg8z9K8aZ1xu2/LjX6rsjDXQ=;
 b=YtBTux5+hPOT+cAxK37ljmJOf2grG3uLA0+pYivhdWXGmNpKA1ibmzUyHrgRCuJjWLSJWMOasX3eetYKsyfmXaMPz/9g4DNUBGmowoY79g6G82T/g7eTCN6vcJOZyLve0Rx3uIWMRGeREeddD+6fGVLpC8eLpo3ol5+00Ci6iftmNxMJ1PJrwbooRAqxYNIxrQq+qAHg2ZuPrg9mFhFZwP/UPoBlzO4LiiRq65ZNh8FE1B+vNk/vdhElxxRyM/kFV/CeZwrv8+mB9FkghaHQQU7nrWMTCQtCkkQ1TyM1pVb3qcx4optFiciIJJW/s9VxfwQqd4IgNjFXk0LS9Kvnng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=ilbers.de smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cy4fWDtWZmRBDF1eQ3DJg8z9K8aZ1xu2/LjX6rsjDXQ=;
 b=sUcRjs5EEP9cLglYZ2oUggPTaiguuCLn3E30fb8PEh7nWNEs8ojCRC8WpZOKWilcIPMoGYiP/rSDxcByilS6ShIOR+sUN2bgl6mZV9hqHtGZ8b78T+HVMR84MVHXxw8LVDSPPIULbaOBI4HhAFjMa0NfzRv7C0d88GP7IFOQtFGUltGhf2XmYp1kAOjBy841SyZI5am5+32S09QetiFlRachd+rexbOAWvIY2DUBLWKmVdRwsspzLUO3WmZ5Qj0fmkG2V0A++ZQFyAE9OFgkJfDh884VDbrBbY6U44JfY0zRUGxlXF9vyXwlm94Cvk9B9wy26caSBwFSO2H7MOs1wA==
Received: from GV3P280CA0037.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::20) by
 DU0PR10MB7262.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:449::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.21; Wed, 12 Oct 2022 11:34:23 +0000
Received: from HE1EUR01FT074.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:9:cafe::29) by GV3P280CA0037.outlook.office365.com
 (2603:10a6:150:9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Wed, 12 Oct 2022 11:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT074.mail.protection.outlook.com (10.152.1.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Wed, 12 Oct 2022 11:34:22 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 12 Oct 2022 13:34:21 +0200
Received: from [139.22.133.11] (139.22.133.11) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Wed, 12 Oct 2022 13:34:21 +0200
Message-ID: <34c6d0ba-bfe4-7b9a-d564-b7de58af8453@siemens.com>
Date: Wed, 12 Oct 2022 13:34:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core][PATCH] Fix mount options passed to systemd unit
Content-Language: en-US
To: Uladzimir Bely <ubely@ilbers.de>, <cip-dev@lists.cip-project.org>
References: <20221012111919.8911-1-ubely@ilbers.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221012111919.8911-1-ubely@ilbers.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.133.11]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.288100-8.000000
X-TMASE-MatchedRID: 0ayLSLUekQU5QaOxwNGfvo9bHfxDWoibdBh3bZKhFc3BLypRtAo4yET0
	lGtfbK/pBph69XjMbdlTHuQZZKa8u63aC25avUuavWpUlhrjisYHDvjr7OxGkI61Z+HJnvsOLoz
	I+rhNYbm2zFWqrVN4BZIu8BCNfKQKQY9ube1qTn6Rk6XtYogiau9c69BWUTGwFQ98tXLWB2Ex4V
	QPfq+aoFBIVsvVu9ABIAcCikR3vq9HjZKTqpeSAKH/EzDxwLDtniAZGGF28dEs3Qu0OVWN2S8up
	BPpePmF
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.288100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 2082F110166EF0E5F4712F39C33A9A8452C5029E6C2C8D5220CA487B3CBCC2312000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT074:EE_|DU0PR10MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: 4386a026-10c5-4c7f-0284-08daac45b59c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	st6tuLBQtPiRQBcYcrCLLQ3t6xieHozec8vw1dofnde2WmK3yd/rMtB1AlBoJniZuPbcg8dc5ZYWh8HAHb1lofhSDVmlFrfws4Bk0511RNx5KlOpZijuSqTDGcIUb6lwQMI5aD0XBOhzfDQWUrQMSFbHZbzUBe3hug34shp7TSzQa9B3apvIIWNoKz1H3Fu9MkngGKIpaYmAq54MOeQXUt2onkkzbKSBA6ZKi61adTWZ+rliV90bExZNcZHQFoT6QbZMj9FKbQUv++yMHQH7q0PMU5z4UQnUDln6bnDkPLagmD9jSCo1LrFWIeXL3EVrr7GlzuljKPTepnf+4DOpCvRo8NxagytiMsGXgKBnGJh+6E9h6hJV0T/rE6stHkWqYdzGeizPkLTsbgmvLLMCCbeIz5CmM94QuhqGR1A48GNlC0YvUl6bgAXw/vILEe/aNgig9GkOP0SIpksUOLticQz87QGusAPfM85PQ3d3Rw3Af4QWEQL2jLBJ4e8KtJwZur8tn4wPgCC1Psz1EV4mKp4TXk0cMJQ0phtxDeGrhQBUan6RZ1N4v7XOXMW1lPs3BC58ciPKtQxrQpKtGPY6n7Kfjb5RTWNjzBOH7iGiuUz6UXdzsrysKXJg0/HTb4YKbLpA8GJHzHiQMAI8EsjQ72ZMpcDGuXuPAmdRk8kgNnHjHM7lZJ2X4RNf7rFWrcS8syWijrJHM+zLDouk1Uk3OzFqJ7OS6jpt12/aED9JoptJpG8LegTuDEfsFcH4bgeg1ZTD4u64WagWoU1rra2b7FXGEH6HicRo3CKp60RWlCOALqYvPZ/OZj1/PLvlxcAq5hkOVrD3oqnPu611PSS7bg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(8936002)(478600001)(40480700001)(44832011)(31696002)(41300700001)(2906002)(4744005)(5660300002)(31686004)(53546011)(356005)(70206006)(7596003)(7636003)(70586007)(8676002)(26005)(82740400003)(82960400001)(6706004)(36756003)(16526019)(16576012)(336012)(110136005)(36860700001)(40460700003)(956004)(2616005)(316002)(86362001)(83380400001)(47076005)(186003)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 11:34:22.4974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4386a026-10c5-4c7f-0284-08daac45b59c
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT074.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7262
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Oct 2022 11:34:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9741

On 12.10.22 13:19, Uladzimir Bely wrote:
> Mount unit template used wrong variable name for mount options.
> This resulted in empty `Options` value used for /tmp mounting.
> 
> Signed-off-by: Uladzimir Bely <ubely@ilbers.de>
> ---
>  recipes-core/tmp-fs/files/tmp.mount.tmpl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-core/tmp-fs/files/tmp.mount.tmpl b/recipes-core/tmp-fs/files/tmp.mount.tmpl
> index fcb2f3e..be5e663 100644
> --- a/recipes-core/tmp-fs/files/tmp.mount.tmpl
> +++ b/recipes-core/tmp-fs/files/tmp.mount.tmpl
> @@ -5,7 +5,7 @@ Description=Create /tmp
>  What=tmpfs
>  Where=/tmp
>  Type=tmpfs
> -Options=${TMP_OPTIONS}
> +Options=${TMP_FS_OPTIONS}
>  
>  [Install]
>  WantedBy=local-fs.target

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


