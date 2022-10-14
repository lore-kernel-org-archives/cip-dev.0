Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE29C433FE
	for <webhook@archiver.kernel.org>; Fri, 14 Oct 2022 05:50:06 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.58])
 by mx.groups.io with SMTP id smtpd.web11.4219.1665726597701611497
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Oct 2022 22:49:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CAgqqWCr;
 spf=pass (domain: siemens.com, ip: 40.107.21.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcrY4QEPcPh+3eUQ9k6bPt2BzQK/+XWmGJwBxO3LTRiFyNrJCZ2bXYb2JPx9k/xd9dAh1SrobO9H/MAzZHKN7EW9HyZDtPFx8XSpr5QD48zrJUiE6Snj2Xo6H4JyZvST3sKmdMue6XfDRo+/sDNLil3EE4Zi/e6dddN2Hdx+ggGjSre2I1vp0Xv2A8biCCODdcaHf1vOTZbqEo64xs0cqQphON4OSvVm4bJfbcob4zop8cUpg63OEVCVeIhxHdkeVGypPvgQKj85ZWuIZPwJBNFFImLok1hcnprKOk3MwBcAl6sx8VFWMhxjG49Py5cn+wCoCSSC60ytEO4CQStMVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQ5imEnzx3DD9ExIiVCmqbQKbHckPc5DDlqnQ/4P+zc=;
 b=GZiKBFcLS25M40IVMSqCahGo8wovDaVA9L04bMjnwausW0aWtfF6HM9nDyWueJrlGtR54y5D5SkdXRLejf7kYIacTSC80X44abykFKgfeed49KWiMHHPzQbmzYI4PKem4zo6CAc5YtNevhoHwy6bEkxh73Nm/gQUtSL4VcLyExVEvHMkrrfJqk1ocemL+H9YF6pBqutA4LzxuEansuqutC0Okomhi7j12G1doyb2ykrDXHQlVoOw7+w5Dl8e8KJ7OPqG/G3rtc9zz3g/xUvOTbkUTuxemZcg7RW0aoR5lO/mffYaLLpYVo1iSSSTYWJK0+208dZpUkEmH+uqVYlvJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQ5imEnzx3DD9ExIiVCmqbQKbHckPc5DDlqnQ/4P+zc=;
 b=CAgqqWCrNBr+8ut0svgoisav7n1UNL1QVy8G9YBf6U41KPgNymdHjnhAjU/W+gPiYXB+SRawC1vqNJPTsApXYJ1mt3Iat5hsFGrZZuGw6vcFHe8/A7H0vKGgx7kJ6v5jRUT7jPmSBdeUR9ad0uwh7jJE3GVb+NjOtylThAGoV+wlDz69WgfTzKaOeAFkgwX+zyhAgvJoVhy6gvawvOcXuYeEMeKfsG2VDa4utv7JbLLsP8u+eWQ+zaDt0X45WmP6QDVmGxD4DM55YVoaVy1UGmDTSyP9tyuRGkCfYbZSpm2X9Upl7E8U20Swmi/rh5qUN2WcZ+opxBlJHqp61cpjrg==
Received: from DB8PR03CA0034.eurprd03.prod.outlook.com (2603:10a6:10:be::47)
 by AS4PR10MB5798.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:505::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 05:49:54 +0000
Received: from DB5EUR01FT090.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:be:cafe::ae) by DB8PR03CA0034.outlook.office365.com
 (2603:10a6:10:be::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Fri, 14 Oct 2022 05:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT090.mail.protection.outlook.com (10.152.5.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Fri, 14 Oct 2022 05:49:52 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Fri, 14 Oct 2022 07:49:52 +0200
Received: from [139.21.18.154] (139.21.18.154) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Fri, 14 Oct 2022 07:49:52 +0200
Message-ID: <d7de47ac-d2ba-5d26-cfae-55006589799f@siemens.com>
Date: Fri, 14 Oct 2022 07:49:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core][PATCH 1/1] add support to install efibootguard in
 cross env
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
	<cip-dev@lists.cip-project.org>
CC: <quirin.gylstorff@siemens.com>
References: <20221013144041.676637-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221013144041.676637-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.18.154]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.787900-8.000000
X-TMASE-MatchedRID: FSxjOqe5tUM5QaOxwNGfvo9bHfxDWoibMz0EFG5lnW+OjIrMSa2sR24l
	czE4XkmwBph69XjMbdlTHuQZZKa8u63aC25avUua0TTgowSeLurKWNgovqaJc4IK2tjTqNot3Sk
	TY86NiDi3CLdtdG1oCGBt9mS7pKVTeoqVs1ZLrvAzd+tJEfcx1FxxDx5qbkR9OX/V8P8ail1ZDL
	1gLmoa/DHhVA9+r5qgUEhWy9W70AEgBwKKRHe+r6o6M3p7m1XFlnT4hSp3D/M0lEWQELGebReRt
	kkBv/0kF6dfVLyZPa0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.787900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 53A775E48CD1960090A5A6FCF8A9B9EB3F2A404F477F15B3ABF2E8FD401B603E2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT090:EE_|AS4PR10MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: fa90a8d5-0b98-4a52-e187-08daada7ea30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EUD/JaTzqlTkgcREDs/pk81IAk+tVHXGjrxBKeefNSrQ836bh7JbVEgomOTH6vc5TKjD1TcQw6qojfGNwZ/poH3uExfddkllFfeSKlOYBj7cCG7WJ7lA++gm+Kah/+d7aE5uCgozQ85FOzYwG2XSo6HPo43jeZQd7VOlS/etaq8XDodwbd9rK9AF1paHTM8IOQeA4vs7qmTKV+q8a+wXFO72czxH2iqdjD6X0pBW4dQB9fy66A0xAfBDsIVOf7VeHktbtE+XTgwCa/yMY3jUzne7g+Txcw0nhlh6G7cbCxS0kMpC+3/3GPq4h3AxMi6Iz44zNWMh8j9sl53YXFq3tlE2vwctL3uddvx87iB/rBolpL3HvEnv6df/YJAkhw26YenYjdMdBb+7qCgtwZdSOPvtFfKrnTTVdnw9VF2nWhib5ZmzgL+ORzHQTv2Zl3zEow24nwgq9/FpITsNnjiUQsywFgF07hi3YEp8TQOEji7lkcJNoQkx1ll+ZsPPCFyk/CZOp4INQT8ylXdJbobOh1Mc/TirGN8anhrx7q5qHgcuWwjFnkrGHC3nOA1vCzZZCNG0iNylGAixEiDzcw3QgmWGOTHLuLGkW1zm98NhXcQipVDC7uI261I/1roS5t6SpEyCKLawCDmYBhVqI85aeuo9bbZ51gOGFengZhXGCXppHysMTsCZjo7xJmthCQcFLj7cv5xcxqgKEJMalNwJeddGH6RByrRycVTJ0ttxEAlHxOKd4u4yAHc1YAnK+hl7QfdAfInzl0RbROodVF2gnRCKX+gtM3kGk9OGMN0vlJ9VbCeX/NN0VXBYkz0Dt2J7tPIep76jgnD5qH2mT0O7Zg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(31686004)(2906002)(16576012)(36756003)(40460700003)(44832011)(186003)(5660300002)(36860700001)(956004)(82310400005)(110136005)(4326008)(4744005)(8936002)(41300700001)(478600001)(316002)(70586007)(70206006)(8676002)(2616005)(82960400001)(26005)(31696002)(53546011)(47076005)(107886003)(83380400001)(336012)(86362001)(7596003)(16526019)(6706004)(356005)(82740400003)(7636003)(40480700001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 05:49:52.5780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa90a8d5-0b98-4a52-e187-08daada7ea30
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT090.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5798
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Oct 2022 05:50:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9761

On 13.10.22 16:40, Felix Moessbauer wrote:
> This patch reworks the python dependency of efibootguard to allow to
> install this package in a cross chroot.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  recipes-bsp/efibootguard/files/debian/control.tmpl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-bsp/efibootguard/files/debian/control.tmpl b/recipes-bsp/efibootguard/files/debian/control.tmpl
> index f8bdd8a..626d43f 100644
> --- a/recipes-bsp/efibootguard/files/debian/control.tmpl
> +++ b/recipes-bsp/efibootguard/files/debian/control.tmpl
> @@ -7,7 +7,7 @@ Homepage: ${HOMEPAGE}
>  Maintainer: ${MAINTAINER}
>  
>  Package: ${PN}
> -Depends: ${shlibs:Depends}, python3
> +Depends: ${shlibs:Depends}, python3:any
>  Section: base
>  Architecture: ${DISTRO_ARCH}
>  Priority: required

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


