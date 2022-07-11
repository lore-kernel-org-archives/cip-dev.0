Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAD3C43334
	for <webhook@archiver.kernel.org>; Mon, 11 Jul 2022 10:59:30 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.76])
 by mx.groups.io with SMTP id smtpd.web09.27006.1657537166015278548
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Jul 2022 03:59:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=s8CeALqq;
 spf=pass (domain: siemens.com, ip: 40.107.6.76,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgUzA+BobKplNoZHlwUVcv9sB6FCqWKCpRT4gz9RwSMcr9tMcy3AsKxYH6vVjGYMoKC5F2lDp5WSdUPLGGbtwDeZIVpt4+9eXG6MvysMbU7Zu1x5UK7E1CAYSmzjN/Cf8ZIDYrOZxWVy+w5YkAjiiPp8q2rqaCsGMEA9hx7KAkVf4b+e9vH46BkW2wnQbvtXq7/3i9WCXycpgDFaCozo7bG9sO3P3ynWYaRc7pkxQWTjNeXVeiV4O4cN7Ew+NXh++mkO92fNkq7kLbPDplJdCr6Vy8MGyRblTdRrFIh0xasMF+emdk0d+LI3VFT8Ta5OgNbmSQ9cwk5OOlEQDzklhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=it2iNj41IRskkDl8enkeefCpbtzvYSQBb+a79lYPRcs=;
 b=Wkiu8RNvwEqupX1lB95NXW2O+ODPmXDP+72p6lOK0Ega4FhZDphh+vdfC9OD+5QlUZYPKDNl0H4gmrttMf96ZMS2HG7dAh4rh+7WOGbDK4gsG8QBpKxJ6tdVtOSAm/+bJ6aB10blWaWGT8f5fNKLqXemm01n+uH75sQmCemF8Vk4tmx7ADKxGChN5SnNnoq/tT0/3gBIsdUc82s3vZ8DC765bp5bd5WxldaU7wpR9Runop8Ow3JRmrhZYgGlZwY3OnVX4mxy7khijMOvdGSJiFJzgdChIxsXoskOypVg6rsy4DATTWH5OsC2HySxyfP5HtFKmbBR8nrQwjfN5RNmVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=it2iNj41IRskkDl8enkeefCpbtzvYSQBb+a79lYPRcs=;
 b=s8CeALqqHqrUeCeFkAG9wo3PwqxH48/OfaGzONZpyE1KQZJZcx0sTLqewkA8SSPq3zZwZAywvRWycUhg4qp+VzQQM+6JTZztPNApII7ioK1lU8UInCT5+KtehghLaLUE4qokAzPfP+a1LSkqdAAc0ezkjRufftFVH0vSPWJ3FSqcsOhlANPMj438RGeDaC/shnyNfKR8gWYObQxC9V+RR9mAqhxtpjP0bui4/vNTWndgRS4hHH0On7czjUyGJFDEo+63NS1bglW4qN7xr/4x0HCLjn7ppqNoj+vKDu7dc2tI4ytnA969RIDTLY6PtMhqx5aOI7DztkppWltBNRHOGw==
Received: from AM5PR0701CA0049.eurprd07.prod.outlook.com (2603:10a6:203:2::11)
 by VI1PR10MB2510.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 10:59:23 +0000
Received: from VE1EUR01FT040.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:203:2:cafe::8d) by AM5PR0701CA0049.outlook.office365.com
 (2603:10a6:203:2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.11 via Frontend
 Transport; Mon, 11 Jul 2022 10:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT040.mail.protection.outlook.com (10.152.3.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 10:59:21 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 11 Jul 2022 12:59:20 +0200
Received: from [167.87.9.151] (167.87.9.151) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Mon, 11 Jul
 2022 12:59:20 +0200
Message-ID: <cd7d2ff6-d79f-01b1-e970-1b289587468e@siemens.com>
Date: Mon, 11 Jul 2022 12:59:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [isar-cip-core v3]
 recipes-core/images/cip-core-image-security.bb:Add
 libpam-google-authenticator Package
Content-Language: en-US
To: <Shreyas.Karmahe@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <venkata.pyla@toshiba-tsip.com>,
	<kazuhiro3.hayashi@toshiba.co.jp>
References: <20220711102903.4088463-1-Shreyas.Karmahe@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220711102903.4088463-1-Shreyas.Karmahe@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.9.151]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.676200-8.000000
X-TMASE-MatchedRID: RfRf601lRZHdDS6etHbe2x8Qq+M7nEvg/k5m7D0YTS/x5KZMlKYS/ReK
	/B+WKxKsZJiJxbczw5/UobyHIcIzrrIw4X32YYkcdG6HnotY4Wu8GQW9yBIzIvgWrMZvbmeHS1z
	wNuiBtITfUZT83lbkEGSHnmQL6FL6Ko7X68Rw9F5qFJg6e/Q9dkL5qYNMJ0izLG6gc1cSnZwA+J
	Hhu0IR5pQBR+Vr4iFospdaYS9obcSXLJHjo+8i07ao0Zou4ee+TX7PJ/OU3vKDGx/OQ1GV8rHlq
	ZYrZqdI+gtHj7OwNO35N/S1zEq4urwCtTXFayZBHvi72daBe7xsf6CBmHJSZybzb14B5nsv
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.676200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 D30DF8169978AC1FA1A551FF56D11A84C9A0B11AFEDB3EEAD97EFA9AF21ED1482000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ceb99699-df2d-43a0-5b82-08da632c68c8
X-MS-TrafficTypeDiagnostic: VI1PR10MB2510:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xNfkSw386gQycJ2Rnrk6jpga9YYU506+KtCE6y748dF+aY3tBf0o3hsi0sSA65lea78Lg9Gg0GUgacWXmbViKfQEd/BDFr3GEGqoRfmz99T/hLCTHGIUxQeMwn3YGnOLX7Zj2X/P9+HG7Q7VXYRoxnF6cxeUlJZOXC3iZVowvHVNT8r4Y5VRw+R2BKGkvec48tWH4dDlxe0PaPGzg+3mN5pg4Hs7nmC0KltinoDtNP25vkM2fw+tQuu07b/mFhSI3CIVQSkrwdJuHuCAbyuEBSQyEAMmcfbF0lEISMMZPrCrkjZml/usc4kcurZvUHdPiUu2xAFqxPbSsZvH8CISfLOr0ysl1ULrTvEY0vd1gBl4WsNBNmq45g04fnVr2sYv2I3vSTCPLyhFXDFksvjL9K8c7h0xAN1BOQPk/chuE0iLWYvFxwZCATtMwQYmqSD8aGnG2EpyxsaIJEHvFOQZGriMKHYVU/j94L7HxNZK79cTSphj5Masgw+dYhnUZ9aXIXEs9xO8X7vEar/5JZwHKQ6NhNNUG2hq2/b3dbm7FkPvPSMQ5ia3Rhk7p6pvAO92dOaDNd2UCIRDWmDGuMJ7OVl/URixo3rEwRmpS8b8SNdTJfvStIz8Dup8l5BxbQaclP6dhlVbt6bwRXadKPsSFMle50kYqi6h16AHNQ97BogOuNbO9uhJbZRVqoPaSgsHHeN22DbwpbRkXgsdylMt+AtAHut2HIUPv/mFIX612uF+bN7X923zRSLg/YzJN6Nc/ysryBS8xwa5JnnfVisrfalG/8n5FblbxnHta8RUO3uxCsCBEY8/r7FUZHwlDBm1bhKRmMB4HCHyvQiCss9H2UXiTOZhpFOjbtTZB4BBsS0dxlbTK8OiZOjnDd9LoS76fDiSIaWpcyYzfHtJdSydpFOLfzVXajtNCnwDr8Xw+iY=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966006)(36840700001)(40470700004)(110136005)(41300700001)(316002)(54906003)(478600001)(53546011)(15650500001)(2906002)(6706004)(16576012)(5660300002)(70206006)(4326008)(8676002)(40480700001)(82310400005)(70586007)(8936002)(44832011)(81166007)(82740400003)(31686004)(86362001)(36756003)(356005)(36860700001)(82960400001)(40460700003)(16526019)(31696002)(336012)(26005)(47076005)(186003)(2616005)(83380400001)(956004)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 10:59:21.3549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ceb99699-df2d-43a0-5b82-08da632c68c8
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT040.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2510
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Jul 2022 10:59:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8739

On 11.07.22 12:29, Shreyas.Karmahe@toshiba-tsip.com wrote:
> From: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
> 
> Add libpam-google-authenticator to enable Multi-factor authentication.
> 
> Signed-off-by: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
> ---
>  recipes-core/images/cip-core-image-security.bb | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
> index 6060978..24b1f46 100644
> --- a/recipes-core/images/cip-core-image-security.bb
> +++ b/recipes-core/images/cip-core-image-security.bb
> @@ -33,6 +33,7 @@ IMAGE_PREINSTALL += " \
>  	uuid-runtime \
>  	sudo \
>  	aide-common \
> +	libpam-google-authenticator \
>  "
>  
>  OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"

With v3 of "recipes-core/security-customizations/files/postinst:Add
configuration for MFA" (non-optimal naming BTW, will adjust), this patch
is now obsolete.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

