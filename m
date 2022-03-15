Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01BBC433F5
	for <webhook@archiver.kernel.org>; Tue, 15 Mar 2022 06:13:38 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.49])
 by mx.groups.io with SMTP id smtpd.web12.7515.1647324817267577097
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Mar 2022 23:13:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Mk7c1P9t;
 spf=pass (domain: siemens.com, ip: 40.107.21.49,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKKXFvOxDbOlfCJPXdzSCt3fMbF7mPBekRYwQeKcEhcRv4cMe/LZFDmS0urG4gLReZIiD8tts2RrraRAGgy+k3mCY5A9LV3Ebp9oGbKglKY/yMPWiHVCd5QH0ZpTHaXGm7sa16SC6eSXTGYH9C7aSZFYTywMBHo6XPMXIf97xm2PfY1OUdNlyQWGyTjMGlxVZD/5t4YJXLEMKi/ZZ/ab5NJBpS96qsVyM/PNxjqQ4TEN8afdhut01mmvwq+lUDESJEvYHyTxrdrhREkhQveAUVhCC8x7N2ywlcrc5jJ2GNGsUhUlxPnlo+NCAai6bocqsVd4L8jNd44zwKxeVUzsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xlILQTc/jfXmcTd+caOTWC1jtvwYbMa2PyeHrkj0Z4=;
 b=WHj/g7y9bTKLIdsd3jSBTHyLe4Vy4/Lqtvz2jDZ8JpMXBWqc5oTw5dnr0fxH6Of7R2c/R2suOBvsPF8n2oRrwS3PJadkbMySxMfO18lH0Yp9cygw6jLkIKe76CbV2Y573a2NHL7Ud5/h3SDizPMOkgXQmX0p9jj+yuhf+p2Bz0H9Ln9CM9rILbpTf5aYSZ0zC1fC2E7eQyh/suGkvL8xpM61B0U06pVqZgcmyBBTMq90B5rwbCAeNmO/rJRMWYugttTGIBD5w8s+2ZTkIsJiBYI+4820dsqvEQ02qW5e7Ki+hCnlYfRvTFekppedT7eIdzol2O1R1HE80GgvGhtDmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=denx.de smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xlILQTc/jfXmcTd+caOTWC1jtvwYbMa2PyeHrkj0Z4=;
 b=Mk7c1P9t73Bc4k0eMhnA9M/Bp95ZhbCV6ZMtvRmJvwe0M1U19xSb64M1NkNZCJQ7XH/z4f+92sd7Wc9sEkG8OCXBwNyw6RqJznFFkrAYRQbJIb0cCg+PdKiPfsvF8lHiyYz1zZIVAL4DpGyi6//44GmocFAACeKlWkv6RAJU3PnNi1FMsNCf+ZzW0vWxl3y1Hmj4jdhQX8+SZV7fMFezb+adA+CPHt/aj6Nf3RWrWrCLJHIjN7CmeTpDlPDTeSVovE7sMuiEQsoDfKqnI8EZFqYEDul8rW3vqXq0GuKJmhXboBJ8k+xPHtsmVLJNgarzXsLIrGVgpIZhWNlwkcMSzQ==
Received: from AS8PR05CA0013.eurprd05.prod.outlook.com (2603:10a6:20b:311::18)
 by DU2PR10MB5062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Tue, 15 Mar
 2022 06:13:33 +0000
Received: from HE1EUR01FT047.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:311:cafe::73) by AS8PR05CA0013.outlook.office365.com
 (2603:10a6:20b:311::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26 via Frontend
 Transport; Tue, 15 Mar 2022 06:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT047.mail.protection.outlook.com (10.152.1.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 06:13:33 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 15 Mar 2022 07:13:32 +0100
Received: from [167.87.0.35] (167.87.0.35) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Mar
 2022 07:13:32 +0100
Message-ID: <2cd7693d-dc31-f378-e309-26b019404f2b@siemens.com>
Date: Tue, 15 Mar 2022 07:13:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [ANNOUNCE] 4.19.233-cip69-rt24 (-rt105)
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>, <cip-dev@lists.cip-project.org>,
	<Chris.Paterson2@renesas.com>
References: <20220314232121.GA23936@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220314232121.GA23936@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.35]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f673953-93e5-4c54-aee6-08da064aeeea
X-MS-TrafficTypeDiagnostic: DU2PR10MB5062:EE_
X-Microsoft-Antispam-PRVS: 
	<DU2PR10MB5062C14C974BC2F76349A78E95109@DU2PR10MB5062.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	X0AImONiI+k6PO1B3zY1Bv9vjfxu7Laq8Ljz/uz8ufmHVi+ulsTjGkwKM2tXnMkVCfflYz2z/sjAqS2SEtbrh+jTIZesyXlg8MrwCE1z7VmoqUHnKaoXjlYVblmaJhxJUBXTQB+m9FhviL1QgO8uSLKb4lF6hA8DldUfZ1B545xeK7HH3pbO1eIuofZwzPdUW7eMhKRXILQ1nnn4GQcWvOvtfmqP+1sX75K3RHb/p/ZgCHPMzURRwufg6XyUSxTPThw4zUVnxlZVgZnn48lbDM+1UvDTe1STY3jornL1CGOQsSkH+FYaQkHkAcl1fzJmWEoROS+mxUIZG/omvpZOJlXxB656NlGUYKVd2dCuALwdMVs4ZsSgdSteXfz7msbky1qcCTMWA8yZTRctSMH4lrmlLI5aZfT4xXmc7l2NETgUuiZ6TqAdDDKhYiwz15fhWanj8ErUgmuJ2H2zCGF3Tq5h/TS867e9bqjGBHJmMX3Zup/B6SBWen9LUoUxC9WtRzvsRRm1FdPwoG9wPRrHEkjmHe1RDpYCd0XgtbhEW25rrKUPtBT4b92hzURuMGbFr/ySsbhwr4QpVpEXgiZs/hei+uqMu2RA0CCiZoa97n8qEjBE+N2hmKnztXR0ehiGP1Ie3HIW/NyDosjeSNlN1Cifzya27glOqCb4hzEdPD/PY2wu8ktXqqgts7WOUHWOHXVILr7GcH6i68Sh8+VtYAZqYeee80+FeiOZAYTpcvv627d/vYE08bWMgRocfgEXdV6jXg622va1l9jNuBhJn4gdAOpDFyGNhlOU5exwnd06I7N+eOk6ImvXHlljosvczoalHT9qlBeEhu7kWxdHRVfQVxdhuOSABbKn9rcIch9wU4JoHdkE/zPVLQty9RBHW9k1fQFK2e2eBebBUsJb6w==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4744005)(36860700001)(5660300002)(336012)(110136005)(6706004)(316002)(16576012)(8676002)(70206006)(70586007)(86362001)(8936002)(31696002)(26005)(186003)(16526019)(2616005)(956004)(47076005)(82960400001)(81166007)(356005)(53546011)(36756003)(2906002)(31686004)(40460700003)(83380400001)(82310400004)(966005)(508600001)(44832011)(3940600001)(43740500002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 06:13:33.1113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1f673953-93e5-4c54-aee6-08da064aeeea
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT047.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB5062
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Mar 2022 06:13:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7739

On 15.03.22 00:21, Pavel Machek wrote:
> Hi!
> 
> New realtime trees should be available at kernel.org.
> 
> Trees are available at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt-rebase
> 
> And their content should be identical.
> 
> Note that there are speculation-related bug fixes in the pipeline. If
> you are using complex out-of-order CPUs for dealing with secret data
> a) please stop, b) let us know and c) be sure to install next update.
> 

You tagging script seem to have run amok with "v": ;)

 * [new tag]                   vv4.19.233-cip69-rt24        -> vv4.19.233-cip69-rt24
 * [new tag]                   vv4.19.233-cip69-rt24-rebase -> vv4.19.233-cip69-rt24-rebase

Please fix.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

