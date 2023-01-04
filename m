Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5036EC4708E
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 13:41:13 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.83])
 by mx.groups.io with SMTP id smtpd.web10.12183.1672839654157250356
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jan 2023 05:40:54 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=lq1Jkl1e;
 spf=pass (domain: siemens.com, ip: 40.107.15.83, mailfrom: henning.schild@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBgTuF9gE7bkPWwhK1BiZblbvDBPx2ZF1Yvn3R9km88a+9lGw9h2KktSGSXXl9wp1KL1Bo934Fr+l70zvJkPYu9jIb3ls+c6Mootn4CjBodMPfL7A/CkY1VV9K/Kva+9DQjprKF4/qgoBxeLnTXwwGg6NcD4pxonlLNSiqsV9y5N98kRZtp+kgzhouK0D9xB92b1Yvn2fQJX1UfoNHm8+dQ6ip87U4UAOvvT7mbdEx4C2dVJYh2PEe/ZUNQIEoIzzVc8TwNWWhJGzhjgx6Jbib7NRuivczUAELsNtrLX5HhT8iWpk6p7IM/FshxDpir3dvdHcPtDRFDH7XvFsBfY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFYu4aABhkADD9t+Fv1pa462z43Klfp1uszpHnHc/Mk=;
 b=kAarettZ+Vp1twrIZ+H3J7rQRITFmyN7vXl5C0mz081L4heRfwK5hmpsidfTCRl7exefYL5kKvNxfP8CG6dqAr1SmUTAFMq19kkeFUXQWJ10rhS+xKYDewpRrSO9wSr/XXG1FriwSzmsLI6Op1acTD3mBVoUPQxN6gyhP4dEpT/gKNyid96QwpecJsIig6QD4hkAQ7855ywLySIQwO9lGzZpCYzYqp4uuu9INQ9756RlbqU8FQU+Bi6Pj18Zo4LdkKKkE0wuGEGSB+bzHBwDM4fpcF+B6hiCdJb9OlzQQjqoNLX96zzMgzCXnwpkqKG+WegHOc4bUmg/hzx8t5+IGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFYu4aABhkADD9t+Fv1pa462z43Klfp1uszpHnHc/Mk=;
 b=lq1Jkl1eIEjdM7z3OMBoXzCgrDeVutI+XPSqEk1EnqJ0ER1t4G/cbe1eOl1q1TPAeriKy6EXYPIPHqy+nbEnfQ6+3fpXQoAJ6XMn9JViZE3Z1vWmfc19PPv4X1Fk5zLbkSP2nNk6FxOjLg5CN0lTmG9+Go4DVuDVJjHin9kR+bljJVIB5r++K6mpnBFkgslrqRWAErhzTOZK73hHxHWecN3vuY79EI6W7aNTxNb3kXJt/JP+3pjLhg6oT9wWysfOB917VUszQaLrqBQIRFQeF/FPQNtob2D6Gh3iVduqGr1HucsQgWCacNAeV40/IvG/uHo8/WFJKCOq76X7adU6Rg==
Received: from DB7PR05CA0024.eurprd05.prod.outlook.com (2603:10a6:10:36::37)
 by VI1PR10MB3277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:135::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 13:40:51 +0000
Received: from DB5EUR01FT105.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:36:cafe::2a) by DB7PR05CA0024.outlook.office365.com
 (2603:10a6:10:36::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Wed, 4 Jan 2023 13:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT105.mail.protection.outlook.com (10.152.5.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5966.17 via Frontend Transport; Wed, 4 Jan 2023 13:40:50 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 4 Jan 2023 14:40:50 +0100
Received: from md1za8fc.ad001.siemens.net (139.25.69.242) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 4 Jan 2023 14:40:50 +0100
From: Henning Schild <henning.schild@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Wang Jing <wangjing@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
	Henning Schild <henning.schild@siemens.com>
Subject: [isar-cip-core][PATCH v2 0/1] root home dir package
Date: Wed, 4 Jan 2023 14:40:38 +0100
Message-ID: <20230104134039.11897-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.38.2
MIME-Version: 1.0
X-Originating-IP: [139.25.69.242]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT105:EE_|VI1PR10MB3277:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bcd7d79-38d0-4712-1dc4-08daee594b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	alr0koCXF18Ow4StDmg95EtPh960KgnmijKkw043TbQw9vDOjHimOxTu4a94bQsmB5cRgyjLMgGkwCeTy8XvuTWmWztniJwp+7lHd+ZvyrPoD2XxPxCWdm06/CJ4uMvmXcGpJhVjGrrZcKC6nUUa6FlnVnRWYmvAiVxw4AJ46fw6tOKk5N+5WCMEJE75prh50F1vIWRCE41fv9pz16NYAZFzt/ZDKnZcTrBgFfF08cXMNndz1UHAW1NVOfaK5OyTsKTBQ67YgB2uypzMgwhdQG1Lyu4QfVutKLAv+qlPd6L3KdBNQW9pc/3emBpMP2x21o8fAm/WPpteIHz83HUiHOAEPifbi4nq1h3zu2UbvCoBtm+AQDnDpO3wjMZLLNrlPexeScWMX2UUVfsZ10l/ZXvDGM57UdHUgDSHY9GO5/lSS/4AJlki8tbszK+iv3+TsH4q+9w3Tw1cTOQddEY+NfaFlqJRJoApFH/f6m+nAFafiX8/+JRWAp1i+nfc8PoFrMOnFQQVYeXUFr27ElWDa96ygdgwfI/FFwOV1Saqp0ezB5G7CXsRdNdBVy7SkjGdCCOBp2oqUv9rE87cOAyN69vLEb/NC4/6TzmOg6xcKM+8A9IQsDe6/BMGk0tMWg9RmsmZK6P5OaI6TqYl84nONtlVFzTk4/kQS6BXfFb6Vl3Tt+ZWXDdJoOoj+nJqpgiMYOPsG37LTHahAz0ZV1zpR8pNTspCS2TBATKP6T8oqII=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(4326008)(8936002)(44832011)(8676002)(5660300002)(70586007)(70206006)(2906002)(41300700001)(54906003)(6916009)(4744005)(316002)(36860700001)(82310400005)(36756003)(6666004)(107886003)(478600001)(336012)(26005)(186003)(2616005)(83380400001)(16526019)(47076005)(1076003)(956004)(82740400003)(81166007)(40480700001)(82960400001)(40460700003)(86362001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 13:40:50.9917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcd7d79-38d0-4712-1dc4-08daee594b64
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT105.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3277
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 13:41:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10315

changes since v1:
 - add missing copyright header
 - update copyright date
 - rename recipe to include PV 0.1

This patch is now coming stand alone as it was not merged with the rest
of v1. It is based on next

Henning Schild (1):
  change-root-homedir: split root home move into own package

 .../change-root-homedir_0.1.bb                | 15 +++++++++++++
 .../change-root-homedir/files/postinst        | 21 +++++++++++++++++++
 recipes-core/customizations/common.inc        |  5 +++--
 recipes-core/customizations/files/postinst    |  8 -------
 4 files changed, 39 insertions(+), 10 deletions(-)
 create mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.=
1.bb
 create mode 100644 recipes-core/change-root-homedir/files/postinst

--=20
2.38.2


