Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F746C43334
	for <webhook@archiver.kernel.org>; Fri,  8 Jul 2022 11:40:25 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.59])
 by mx.groups.io with SMTP id smtpd.web11.6505.1657280422652778501
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Jul 2022 04:40:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JjgCT3xc;
 spf=pass (domain: siemens.com, ip: 40.107.104.59,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYEI2f5FjEIRmHRq5RLm9QrCIfnAXe3uJMUCIt6tOUlkgAD6FIQkAZ2mWFv1Fd/Fnlkecm48gfFuGENqeX729g24Su8NAEp5yo42Dx4T24CKCWoiR9OLr3Muf1RESRCbwzHFKtADLz6MONGUmk/BhUrn+sgDnl6XmNlCqO/oYNTTzkJSyxKPLEBUX/12JbLDOmzytyBQwATWC50gUrlP1EC8jFMiBj7Pm6zpUjNkignoTaJYJZOU+485U7LVC3gBy6CP/HllBWfX0I+4BjO/zCTsF7E55zQ3uZFt0dWANn2eZzTbCLmsOrpro3X/giQWTIFkylJSaFvKJQSj//TDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMa8lizKfiExQMzsTXQBkr9QkFSBMHVfWFyWfbT2NEg=;
 b=XhzDZATw9YaaBvCOpEWpSCySSUHzKJSEjFlv3H5upg7c10Qp6G5tBYuk5PwV14Ge5CsDyGdEcHe+Ilzgnyq6IYuuJJhvJfVCyRdjAloQg1AdSgnnhYVrfmh5OOy81ZAEfUAzEjqRpO7lTcBY/zIcf4KalfjTox8dJHbp1kcGKJMpyth26M5IR/xzs4akLyvNGd6XQOiPNnt8s9LUOmSBukPoxTI6skxT+D5xNuu3h3W9APsYZ1Ydr3O4vXh172Yi3GgDbpO4VsXDeU63XI/xAu34LBwSotUylUnqzcn2N27nZdRleyifp8gJqRNf082udlh+FCpgY9fUsgjwopaD9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMa8lizKfiExQMzsTXQBkr9QkFSBMHVfWFyWfbT2NEg=;
 b=JjgCT3xcfv8tWtTUtN79jWM4iTCNvxlj8Drp4tAO57PChgkBCtoXQ6lAc0hc474frLh/cPNkYZ/Jh3wKCA/tq9MLmYhbL7223+2DKSULiD6D9V1sqCSNxarRFEzI2v1ojMsEiVw1wh/wyR7zI+10weN+b38kOBrSHKt+JghEuYb7BK7kQIqT5rqrJizjeUtMo/iR3ZQLp1T4oZaXYA/jIZSC2YfbKgOSeLr3+1wddDW148O6xFa6MPOr3+b0FNNFEzD1BfQ7/3RfzIifkkYOdo0mRIcAQUb41BLMUcBISLukKiPMei1K0qPLqpDidUo3KydFwkrfV9DOVj03pUekww==
Received: from DB6PR07CA0090.eurprd07.prod.outlook.com (2603:10a6:6:2b::28) by
 DB7PR10MB2140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.18; Fri, 8 Jul 2022 11:40:19 +0000
Received: from DB5EUR01FT007.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:2b:cafe::31) by DB6PR07CA0090.outlook.office365.com
 (2603:10a6:6:2b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.6 via Frontend
 Transport; Fri, 8 Jul 2022 11:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT007.mail.protection.outlook.com (10.152.4.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 11:40:18 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 8 Jul 2022 13:40:18 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Fri, 8 Jul 2022
 13:40:17 +0200
Message-ID: <66f5de09-b57a-e7e5-574d-a85088f88073@siemens.com>
Date: Fri, 8 Jul 2022 13:40:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [isar-cip-core]
 cip-core-image-security.bb:libpm-google-authenticator debian package
Content-Language: en-US
To: <Shreyas.Karmahe@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <Venkata.Pyla@toshiba-tsip.com>,
	<kazuhiro3.hayashi@toshiba.co.jp>
References: <20220617144440.1846381-1-Shreyas.Karmahe@toshiba-tsip.com>
 <36fc490e-dd45-2922-e7cb-6adb5f675877@siemens.com>
 <OSZPR01MB88777681FCA17016AB061AE7DCB29@OSZPR01MB8877.jpnprd01.prod.outlook.com>
 <OSZPR01MB8877BF7C94A43323C2B5E53CDC829@OSZPR01MB8877.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <OSZPR01MB8877BF7C94A43323C2B5E53CDC829@OSZPR01MB8877.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.422400-8.000000
X-TMASE-MatchedRID: vIFHZ/uiyj8wrKi3eh3JIsb9CgEQmMW5Pg9yfk4YC0bGL//8mlodAx9D
	AC+YduyjUVuDEJ37MobbX2HHnbDB4NsfDeYbBo9aNBSSiEcvHFqDqnt5N5C6gRlxrtI3TxRkOKb
	ROSp1S17W3gJMbmpElj5lm+VDBI4EBuquHFWcDp7PPdLxHWscAxDjSsX6woaCfid4LSHtIAMe14
	6+kJPi6N9RlPzeVuQQYG32ZLukpVN6ipWzVkuu8DN360kR9zHUXHEPHmpuRH05f9Xw/xqKXZwhk
	tVkBBrQxq9PbUOwsP9QSFbL1bvQASAHAopEd76vEZe4o4R4zSf4auVg3iksPHxqijfxkFpjpTKX
	5A7cVC7McTyXJKIpkQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.422400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 B398890C1C63B7DE2EE726FFA561C97CDD68930E123516C2845D0E5DB71883432000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac342660-0304-4f29-db57-08da60d6a269
X-MS-TrafficTypeDiagnostic: DB7PR10MB2140:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UqP0r89S7/ugmBLmMM8qgF1/OcQnSjHJp/s7hbUNkU3SUcykedO1PgCVo6R1oS52T2cG/qv3UyqBJAHPKSUAv0hC0P4/6S9o/wdHYGPQQGHuL1aySHMEDDxp8UPURDnMllRtKTmTPbzTX+dRjCMBRgM67e5qZ8rYJw4zplIGoF8JAfzKgADBQ0NjrHyxM60dWGgTB8aN3neBepZf6G+OQcZL8rDrOhtpjTOTdXU6b3V7JqXgJk3PfFXibhEZbn/bIf7zehRsJV34vNSsN7F+tgFo636ASrWn5zsMsqhncFMJbgGT8h/QvflhneCnif8IvumB8rKBgJChc2qLn/8Y2Z2tZLxoMEsGUcRLWFvD+futnPMayyooEfC8OASFwZn/78cXOpI4TMukCMI/b7ITcacSw/QS82IWl/Qmkk0U/Es+zHdS54pJfP1uF5RVE5BadZ3rGsRMRoJPK5sXtdvs70fL6dsQuiKbdwzEAMa5U28QlB/Qn9iDNf3ULlAYQbajkZ3zS8vHorVrbfGFChyps3MPwTXjUNSF7J3rTea1oIbb+pdBfV57rQhdaWw75LC3yj4R3tnC9upqwV5ko59eo7o0kmb4XZ8OQ9hqyC6u696YV7eqi791u1P2wEebYG7iI9HfmdhJCWV8Pah5iiK3YhuXdDQNWg1ZUIesPMOoIDVfNE8Gs5pX1BroH/zqGlV/fXDMpS1rZV+NHDfdZ3kcNjm56+PzHrmqpLUHdt87rLjDY4A6I94sh7PhpmhwUI+Uz5AxOgWXkhU7/OwR46WeZnS4X+BXw91fNbZAsTqPVUMXBLWFN6MExuK11MfYPasyA1BpnljcLGsOcPKacRawhf8CUSYdGxIyujrzr6ObfOcTQv7WeQKGtGKPLJliEUziwKVcT/ugy/8fmhIcvuhX3fY7c+i+Nn4y53n9237NOSh4/jSfwJt8M+HHKre4jFun
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(40470700004)(46966006)(36840700001)(40460700003)(44832011)(186003)(54906003)(16526019)(2616005)(16576012)(4744005)(110136005)(478600001)(956004)(36860700001)(316002)(6706004)(966005)(31696002)(8936002)(15650500001)(8676002)(31686004)(36756003)(70586007)(70206006)(82310400005)(2906002)(47076005)(26005)(86362001)(40480700001)(41300700001)(53546011)(336012)(82960400001)(5660300002)(81166007)(83380400001)(82740400003)(4326008)(356005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 11:40:18.9687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ac342660-0304-4f29-db57-08da60d6a269
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT007.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2140
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Jul 2022 11:40:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8719

On 08.07.22 12:57, Shreyas.Karmahe@toshiba-tsip.com wrote:
> Hi Jan,
> 
> The configuration recipe changes to verify multi-factor authentication for local and remote method verifications merged in 
> Following MR
> https://lists.cip-project.org/g/cip-dev/message/8632
> 
> But libpam-google-authenticator package is not yet added, kindly accept and merge this request 

Thanks for pointing out, forgot about this.

But then we should refactor: your already merged postinst patch should
have also added libpam-google-authenticator as its dependency
(security-customizations.bb: DEBIAN_DEPENDS = ...). I will drop that
other patch again so that you can send v3 with this resolved.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

