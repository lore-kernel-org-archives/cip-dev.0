Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF92DC54EED
	for <webhook@archiver.kernel.org>; Mon, 30 Jan 2023 12:38:37 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.87])
 by mx.groups.io with SMTP id smtpd.web11.37511.1675072696221052206
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jan 2023 01:58:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=n5CWRi/t;
 spf=pass (domain: siemens.com, ip: 40.107.249.87, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfqhp2EqHVX/D3CsD0jx92sr4/goW++rprXsP3h/9eZn8OdfZuXPD/uIb+3igMqWBVu1BLaws7pAD2i2Srfd1o6k6X/xWch+VKwzrBziEyYSTeuNpjEK+dln3REAoinx9gnCBUnlag4IrueSyMqpSso+ij20qIcUTz+Dr13WKkD70+gzEtI78UKhbkkbhXgYKTUBG+1nGtN700ptxYmd0z5kLkgrJCC/Pknpmwgl4epwEko0KVBlXXY9O6kzWgruei+dq7SrDRbppYBdoam2MPEI399Bul38psiqhTZOi/WkkVUWg082c6tG/pIEycgGLV0w1s/bxbz9Yrr1YaTncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LWGzi17wOunB55V4+WW5tMAdxzmD6TaEWyPDjh4M9I=;
 b=Gr2CUJ4gYCSyv5Tw9qUWPVlyvsJO+rZVNt4gQRLy1dj2C0jbK3zAcnWfexQTY8F8wXR0L3XV/ur9IJ+bQKZya9WIGla7q8fmpYJQzNgCA5EBLPpm7DtQZ61lgqGNXp5QUS/xzFStvpHSXXLtNlvfXNOIlNPHqJDVLNCvXZKeUyi1Y9BqbICMKaf1LycMcfpbCeOh/vO6Uy0iPV0hN3VklvTT5Mdz5iJ9NCFRiWGoHzr9+5jPGSmgf2VuhQHMBhWHGEnv+VtFe/wYQHELC+wBh1jovtpTpq6e3JHujKVC8wub/cgK+7Yclq9YDKPsNFAQlHF0fvqYgpgtOaSXSKVxHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LWGzi17wOunB55V4+WW5tMAdxzmD6TaEWyPDjh4M9I=;
 b=n5CWRi/t9xGtp1EeIkKWC29v7nriwH4Lpf7OFAA8aw4EFGVpaHZcuElMsKqCi0TP30jOuMlu/wLR0ctPEZtMU9n3ah4Ewlp4hHC/yEV/rmHVrH9CNALHjUse5tBP67HVvOBSAlPu+fKJYrMCCqKmX1YEyZbB1WUX8yTFHsvN7ODGDjNdW+VA3MGGcYeWGPV2tBf8JPw/rhNALpqk03SpkEU7shsDKvERDL3BCdh8y7/fUPyK2du/bMt7w+u5U/CgIIAwxrDsDWr+UuV76ebcKF/xuqC7nZmj4GUiSVfBvDXF47VnwOlZaBTheDFYqAOrh81cDhBeKh3KGnvbOrQQNQ==
Received: from ZR2P278CA0008.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:50::11)
 by AS4PR10MB6229.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 09:58:13 +0000
Received: from VE1EUR01FT035.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:910:50:cafe::25) by ZR2P278CA0008.outlook.office365.com
 (2603:10a6:910:50::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 09:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT035.mail.protection.outlook.com (10.152.2.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.25 via Frontend Transport; Mon, 30 Jan 2023 09:58:12 +0000
Received: from CNPEK01M04MSX.ad011.siemens.net (139.24.237.221) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.20; Mon, 30 Jan 2023 10:58:11 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M04MSX.ad011.siemens.net (139.24.237.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 30 Jan 2023 17:58:07 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.017; Mon, 30 Jan 2023 17:58:06 +0800
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
Subject: Override of sid distro config breaks mirrors
Thread-Topic: Override of sid distro config breaks mirrors
Thread-Index: AQHZNJFZ3aNSH/WFc0S3ecB2UIGf/A==
Date: Mon, 30 Jan 2023 09:58:06 +0000
Message-ID: <0236184cd3f04ecb0a3282bdc6c8fb7eeb04ae81.camel@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
x-originating-ip: [139.24.247.31]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT035:EE_|AS4PR10MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: 359cca24-1f2c-4fc8-ba17-08db02a87fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	18tMD24nOKDUyZvo+YFpE3VkeCeat2jNZkWZVx3SG8OlyMPScXhQG2cy/aY57GjaBrt1lCZ5JEzMfXDcHxI0VWxfrotwAyYb+iRaVxEdGHsalAlDM7yrncHzxdjjko/a7TyBm1I1x6TVXalLg7GEF5iAN1e3a3Xbl84wFn+lrwp2QhEqLYeuWOUTR+tK9sHWc12LoTKCNEa2F0CQxNC8TWVjqVOuO3TUgQX89Jo8gjeezDx6OSTm1rmtu5UfgiWNGgidTIl+yG9RxIe8LYer+CnLtOD8ImC200AudV692CjXlROiG7Z1iExCrvxT7VdOezYkFbwofE7DiBB3ok8Ke+7H15+foKt6qt410psBE+J/swNuo+DVVTG+D1mcRh9wORxoWbMpne5gNuZ9LtjgUEpQNgeJdANcCXSDD5nLKqiQWw77+nf5l7bRYnJixCGlZZSOoTIVSl1aug6Aiaw3AZuJz3k/Qt9hDDSnE+o+7EEJXe1OWZSHetFB8rB0HiaUyaREwn3KQwwZO/cT1xj1ZkvEEkXmLIGzTdl6k/pqAe6F2eWvch5W3zC+g6s8zjcsZd04/U8sqLpur+sbLrAvBdVdocHfmZ5j9ao4P9gGmaAy50AH/w4RWcCF26eDgVhq+RIESXzpr4FdUKsBy/5H8sWbzChYwKY+q4InvWNaFCYGciU3zkcad1Blk12iOloka3CvfGgP/VU24XOwTa9HBl65wwHf3JH7Mj1MAbPFmxI=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199018)(46966006)(36840700001)(40470700004)(5660300002)(4744005)(8936002)(41300700001)(2906002)(70586007)(8676002)(4326008)(316002)(70206006)(6916009)(478600001)(107886003)(36860700001)(40460700003)(186003)(26005)(336012)(83380400001)(2616005)(82310400005)(956004)(82740400003)(356005)(82960400001)(40480700001)(86362001)(47076005)(81166007)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 09:58:12.6414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 359cca24-1f2c-4fc8-ba17-08db02a87fec
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT035.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6229
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <4664BAD1DF1A5C428B91EB862E2C53A4@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jan 2023 12:38:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10505

RGVhciBkZXZzLA0KDQp0aGUgZGlzdHJvICJkZWJpYW4tc2lkIiBhbmQgImRlYmlhbi1zaWQtcG9y
dHMiIGlzIGN1cnJlbnRseSBzcGVjaWZpZWQNCmJvdGggaW4gSVNBUiBhbmQgaW4gaXNhci1jaXAt
Y29yZS4gV2hpbGUgaW4gSVNBUiBzdGFuZGFyZCBkZWJpYW4NCm1pcnJvcnMgYXJlIHVzZWQsIGNp
cC1jb3JlIHBpbnMgdGhhdCB0byBhIHNwZWNpZmljIHJlbGVhc2Ugb24NCnNuYXBzaG90cy5kZWJp
YW4ub3JnLg0KDQpUaGlzIGJyZWFrcyB1c2UtY2FzZXMgd2hlcmUgbG9jYWwgbWlycm9ycyBzaGFs
bCBiZSB1c2VkLCBhcyB0aGVzZSBkbw0Kbm90IHN1cHBvcnQgc25hcHNob3RzLiBBbHNvLCB0aGlz
ICJpbmZlY3RzIiBvdGhlciBsYXllcnMgdGhhdCBhY3R1YWxseQ0Kd2FudCB0byB1c2Ugc2lkICJh
cy1pcyIuDQoNClBsZWFzZSBjb25zaWRlciByZW5hbWluZyB0aGlzIGRpc3RybyB0byAiY2lwLTxk
aXN0cm8+IiB0byBnZXQgcmlkIG9mDQp0aGlzIGFtYmlndWl0eS4NCg0KQmVzdCByZWdhcmRzLA0K
RmVsaXggTW9lc3NiYXVlcg0KU2llbWVucyBBRw0KDQo=

