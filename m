Return-Path: <baocheng.su@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88095C7EE29
	for <webhook@archiver.kernel.org>; Wed, 24 May 2023 03:15:22 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.72])
 by mx.groups.io with SMTP id smtpd.web10.878.1684898114781704966
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 May 2023 20:15:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BHAiE0RE;
 spf=pass (domain: siemens.com, ip: 40.107.249.72, mailfrom: baocheng.su@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/1Zxp6Rz2xais/2LAd7utMZU0reV4C7AC+AkL6XWI3Kud18pog4LCoRTxGh3iV8VuPpbIqsDkKp9+LcCZu0u9u8kDaer5W548C68GvT4AHawHffcBhtrUkIVoj/B6HeBqxHYBQwJGoIjj6GN3feoPlYVdygbmxZWgRuLCJZFB5gdvQ5JpwmU6nHW7mRKrgWgH7sqlbjeASSiW2+0nRdNPx1yE9ztj+cZxKOYtTxz0gK6mnIDTvOGapBMO7hfrAedY4uO+bj0zRvnlsAwIsJDr+kwIcZOAjG15dGnCyFTupwgagqzKiP4msO2/YN/zICCm56PGaAsPdNtIocQ0PKYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hXGTeQleQ0jerme4o12VhnUtd3ncJ3hf8LA8jrzCDA=;
 b=U+jCQZ0tEUlJcpEWpQGaPwXPXRiOdvYGImdHacnxzIvtfzjQBn2Ym+hqS2Xtu54Iru4uMTnYmzloCGUx4BdsvyUdq+4v6tGE+3lEExgIQ6xPZ9dhRfAPnswVjypcFnCRHkpzgFt7g7GopnVKYF2xvHrxUHO0H+z+dS9L7DjxcGbrgQgbfaTYwUxl3vqPMOU9YchcjVCF2+nj0sKHN/1UJ96qOdpLOKiYOLYvf1HM21fX54hLSj+Wig//jRrmrtCXcL66sr3Qe/q+bX3xU+E1bSY8KwC6kN6s7OP5EE9BvJS8cPgAuBIJhMeXdAVkfexky+dDBN4Sso+DhLzQyLe6Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hXGTeQleQ0jerme4o12VhnUtd3ncJ3hf8LA8jrzCDA=;
 b=BHAiE0REjz7IliArMsJYBla6ykxFvNQvRhSKKShdhdYUm2vnVVWtYissjnCb1rEqxYn9XxyoiVt5qoXa2b6ImXS+hO/ya8bBZA5jdFp+s4599DqtsHN78SF3IWSocV7f5Bt/cSfwhnXQOkNvji4vHWz10nkeq9sQpJK1lYKr8RWOT9xsIX+OMaiLHD2pkMH9n0cjhFUq1ZthgCHRq91xFr9VgwxalbtqlQdikS4b8lNlO5Cmfo2PeWkSLH4165Ri0SvniwL/VMOUPute6YjDuG0jrB0dOU6EdaZfCmYl73KjJjL/jDgMd/C+xuJuJeuDhP/i+Aucmog6s6a8qACSMg==
Received: from GV3P280CA0098.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::30) by
 DU0PR10MB5850.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3be::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Wed, 24 May 2023 03:15:12 +0000
Received: from HE1EUR01FT052.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:8:cafe::76) by GV3P280CA0098.outlook.office365.com
 (2603:10a6:150:8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Wed, 24 May 2023 03:15:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT052.mail.protection.outlook.com (10.152.1.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.15 via Frontend Transport; Wed, 24 May 2023 03:15:11 +0000
Received: from CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 24 May 2023 05:15:09 +0200
Received: from CNPEK01M06MSX.ad011.siemens.net (139.24.237.223) by
 CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 11:15:03 +0800
Received: from CNPEK01M06MSX.ad011.siemens.net ([139.24.237.223]) by
 CNPEK01M06MSX.ad011.siemens.net ([139.24.237.223]) with mapi id
 15.01.2507.023; Wed, 24 May 2023 11:15:03 +0800
From: "Su, Bao Cheng" <baocheng.su@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Storm, Christian" <christian.storm@siemens.com>, "Gylstorff, Quirin"
	<quirin.gylstorff@siemens.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>, "Su,
 Bao Cheng" <baocheng.su@siemens.com>
Subject: [isar-cip-core][PATCH 2/2] initramfs: Add recipe for optee based ftpm
 hook
Thread-Topic: [isar-cip-core][PATCH 2/2] initramfs: Add recipe for optee based
 ftpm hook
Thread-Index: AQHZje3u8Yf4/syLuk+pJerpd+u8nQ==
Date: Wed, 24 May 2023 03:15:03 +0000
Message-ID: <664ef5ea0fa832ff709718b249a93864f98714c6.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u2 
x-originating-ip: [140.231.151.229]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4A03FBB86540F429B0BE27496A12438@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT052:EE_|DU0PR10MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b5f103-ca0e-4241-3f2a-08db5c051636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	86jJKqK74LzSdk72Y99b/oGepwJqYCT3XFB57jdmwpW/rj0FOmgU7KjlLICNUuq4nMfrwfAzSfzC11kr9MFNFLbp1asebguQB06pF1gdsBp8GKmyLlQCWvvQ3MVB6+w4MXGl6H0pQ84sNBttpOBh4ao23UQG43xIuTDeo3fkDC9PKUh1kN/R8AoBVKsD79GZ5kEBiKggD2udDloqjf9UjCbrX3wlB2NDs2X5K+K1I82Z0fo404LbYxzV3FV6S0Yuts0c5jjDOLSEDBCXLk/tXA51mYSFBKE+xGHmAHxSAhRxnfjY4zxh96z4lkrQxE0NHWIAkplgjfyfH83slZlVu3JARSAWgpqwAukxeSAYZA205gmPhWJKytyNY2WzwVbBh0QSGApuX6X909+k3SAfozfheigGEsqns3TTf9tgLugvHLVekvGqv3j0abtmy97QdMee/Wi+JQtTwbj6tf7b9gB+aXo9fuyl9XIvOgQyNfvtzIQteAbesiOXPL+w/1MsIx1xD4uAvvZhvJXL6WlHqsIbcuAXeVgJhnC6lCOAN2qDITCNfnDqw1KY85GwQQWv5kSggRC6ZPwqhXp2vSgQb64arXJ+HStcYU1SqNQ2Gph2JBdhcbwWotvZrOKNo5wTy1o05IMdRhq9cAnBuYOIKoQrVND4TY4N7aQR4Ya4vVVyoM8Fw2zjuZn2uEsLDz0iKnLRZ4dnb4QG8spTNEzQKZk0CTOYRT2R4CQpUqUhyDAsQAPejzK30tnXUP5DYX9Js5XDWcrvggz8VSqzyqRsSA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(54906003)(41300700001)(82310400005)(316002)(70586007)(4326008)(6916009)(70206006)(8676002)(8936002)(5660300002)(478600001)(86362001)(107886003)(356005)(81166007)(82960400001)(82740400003)(40460700003)(26005)(186003)(40480700001)(2906002)(956004)(2616005)(36756003)(36860700001)(336012)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 03:15:11.9309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b5f103-ca0e-4241-3f2a-08db5c051636
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT052.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5850
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 May 2023 03:15:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11625

UHJlcGFyZSBmb3IgaW5pdHJhbWZzIGFwcGxpY2F0aW9ucyByZXBseWluZyBvbiBUUE0sIHN1Y2gg
YXMgY2xldmlzIG9yDQpzeXN0ZW1kLWNyeXB0c2V0dXANCg0KU2lnbmVkLW9mZi1ieTogQmFvY2hl
bmcgU3UgPGJhb2NoZW5nLnN1QHNpZW1lbnMuY29tPg0KLS0tDQogLi4uL2luaXRyYW1mcy1tcy1m
dHBtLWhvb2svZmlsZXMvbXMtZnRwbS5ob29rIHwgMzYgKysrKysrKysrKysrKysrKw0KIC4uLi9m
aWxlcy9tcy1mdHBtLnNjcmlwdCAgICAgICAgICAgICAgICAgICAgICB8IDQzICsrKysrKysrKysr
KysrKysrKysNCiAuLi4vaW5pdHJhbWZzLW1zLWZ0cG0taG9va18wLjEuYmIgICAgICAgICAgICAg
fCAzMCArKysrKysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCAxMDkgaW5zZXJ0aW9ucygrKQ0K
IGNyZWF0ZSBtb2RlIDEwMDY0NCByZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtbXMtZnRwbS1o
b29rL2ZpbGVzL21zLWZ0cG0uaG9vaw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCByZWNpcGVzLWluaXRy
YW1mcy9pbml0cmFtZnMtbXMtZnRwbS1ob29rL2ZpbGVzL21zLWZ0cG0uc2NyaXB0DQogY3JlYXRl
IG1vZGUgMTAwNjQ0IHJlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1tcy1mdHBtLWhvb2svaW5p
dHJhbWZzLW1zLWZ0cG0taG9va18wLjEuYmINCg0KZGlmZiAtLWdpdCBhL3JlY2lwZXMtaW5pdHJh
bWZzL2luaXRyYW1mcy1tcy1mdHBtLWhvb2svZmlsZXMvbXMtZnRwbS5ob29rIGIvcmVjaXBlcy1p
bml0cmFtZnMvaW5pdHJhbWZzLW1zLWZ0cG0taG9vay9maWxlcy9tcy1mdHBtLmhvb2sNCm5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi45OThhZTYyDQotLS0gL2Rldi9udWxsDQor
KysgYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtbXMtZnRwbS1ob29rL2ZpbGVzL21zLWZ0
cG0uaG9vaw0KQEAgLTAsMCArMSwzNiBAQA0KKyMhL2Jpbi9zaA0KKyMNCisjIENJUCBDb3JlLCBn
ZW5lcmljIHByb2ZpbGUNCisjDQorIyBDb3B5cmlnaHQgKGMpIFNpZW1lbnMgQUcsIDIwMjMNCisj
DQorIyBBdXRob3JzOg0KKyMgIFN1IEJhbyBDaGVuZyA8YmFvY2hlbmcuc3VAc2llbWVucy5jb20+
DQorIw0KKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1JVA0KKyMNCitQUkVSRVE9IiINCitw
cmVyZXFzKCkNCit7DQorICAgIGVjaG8gIiRQUkVSRVEiDQorfQ0KK2Nhc2UgJDEgaW4NCitwcmVy
ZXFzKQ0KKyAgICBwcmVyZXFzDQorICAgIGV4aXQgMA0KKyAgICA7Ow0KK2VzYWMNCisNCisuIC91
c3Ivc2hhcmUvaW5pdHJhbWZzLXRvb2xzL2hvb2stZnVuY3Rpb25zDQorDQoraG9va19lcnJvcigp
IHsNCisgICAgZWNobyAiKEVSUk9SKTogJDIiID4mMg0KKyAgICBleGl0IDENCit9DQorDQorIyBK
dXN0IGluIGNhc2UgdGhlc2UgbW9kdWxlcyBhcmUgbm90IGJ1aWx0LWluDQorbWFudWFsX2FkZF9t
b2R1bGVzIHRlZQ0KK21hbnVhbF9hZGRfbW9kdWxlcyBvcHRlZQ0KK21hbnVhbF9hZGRfbW9kdWxl
cyB0cG1fZnRwbV90ZWUNCisNCitjb3B5X2V4ZWMgL3Vzci9zYmluL3RlZS1zdXBwbGljYW50IHx8
IGhvb2tfZXJyb3IgIi91c3Ivc2Jpbi90ZWUtc3VwcGxpY2FudCBub3QgZm91bmQiDQpkaWZmIC0t
Z2l0IGEvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLW1zLWZ0cG0taG9vay9maWxlcy9tcy1m
dHBtLnNjcmlwdCBiL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1tcy1mdHBtLWhvb2svZmls
ZXMvbXMtZnRwbS5zY3JpcHQNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi5j
NmVlMmRkDQotLS0gL2Rldi9udWxsDQorKysgYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMt
bXMtZnRwbS1ob29rL2ZpbGVzL21zLWZ0cG0uc2NyaXB0DQpAQCAtMCwwICsxLDQzIEBADQorIyEv
YmluL3NoDQorIw0KKyMgQ0lQIENvcmUsIGdlbmVyaWMgcHJvZmlsZQ0KKyMNCisjIENvcHlyaWdo
dCAoYykgU2llbWVucyBBRywgMjAyMw0KKyMNCisjIEF1dGhvcnM6DQorIyAgU3UgQmFvIENoZW5n
IDxiYW9jaGVuZy5zdUBzaWVtZW5zLmNvbT4NCisjDQorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogTUlUDQorIw0KK1BSRVJFUT0iIg0KKw0KK3ByZXJlcXMoKQ0KK3sNCisJZWNobyAiJFBSRVJF
USINCit9DQorDQorY2FzZSAkMSBpbg0KKyMgZ2V0IHByZS1yZXF1aXNpdGVzDQorcHJlcmVxcykN
CisJcHJlcmVxcw0KKwlleGl0IDANCisJOzsNCitlc2FjDQorDQorRlRQTV9ERVY9L2Rldi90cG1y
bTANCisNCisuIC9zY3JpcHRzL2Z1bmN0aW9ucw0KKw0KKy91c3Ivc2Jpbi90ZWUtc3VwcGxpY2Fu
dCAtZA0KKw0KKyMgVGhlIGZUUE0gVEEgd291bGQgdGFrZSBzb21lIHRpbWUgdG8gYmUgZGlzY292
ZXJlZCBhcyB3ZWxsIGFzIHRoZSB0ZWUtc3VwcGxpY2FudA0KKyMgMTAgc2Vjb25kcyBzaG91bGQg
YmUgZW5vdWdoDQord2FpdF9zZWM9MTANCit1bnRpbCB0ZXN0ICR3YWl0X3NlYyAtZXEgMCB8fCB0
ZXN0IC1jICIke0ZUUE1fREVWfSIgOyBkbw0KKwl3YWl0X3NlYz0kKCh3YWl0X3NlYy0xKSkNCisJ
c2xlZXAgMQ0KK2RvbmUNCisNCitpZiAhIHRlc3QgLWMgIiR7RlRQTV9ERVZ9IjsgdGhlbg0KKyAg
ICBwYW5pYyAiQ2FuJ3QgZGlzY292ZXIgdGhlIGZUUE0gZGV2aWNlICR7RlRQTV9ERVZ9ISINCitm
aQ0KZGlmZiAtLWdpdCBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1tcy1mdHBtLWhvb2sv
aW5pdHJhbWZzLW1zLWZ0cG0taG9va18wLjEuYmIgYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFt
ZnMtbXMtZnRwbS1ob29rL2luaXRyYW1mcy1tcy1mdHBtLWhvb2tfMC4xLmJiDQpuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uZmVjZTZmZg0KLS0tIC9kZXYvbnVsbA0KKysrIGIv
cmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLW1zLWZ0cG0taG9vay9pbml0cmFtZnMtbXMtZnRw
bS1ob29rXzAuMS5iYg0KQEAgLTAsMCArMSwzMCBAQA0KKyMNCisjIENJUCBDb3JlLCBnZW5lcmlj
IHByb2ZpbGUNCisjDQorIyBDb3B5cmlnaHQgKGMpIFNpZW1lbnMgQUcsIDIwMjMNCisjDQorIyBB
dXRob3JzOg0KKyMgIFN1IEJhbyBDaGVuZyA8YmFvY2hlbmcuc3VAc2llbWVucy5jb20+DQorIw0K
KyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1JVA0KKyMNCisNCitpbmhlcml0IGRwa2ctcmF3
DQorDQorU1JDX1VSSSArPSAiIFwNCisgICAgZmlsZTovL21zLWZ0cG0uaG9vayBcDQorICAgIGZp
bGU6Ly9tcy1mdHBtLnNjcmlwdCBcDQorICAgICINCisNCitERUJJQU5fREVQRU5EUyA9ICJpbml0
cmFtZnMtdG9vbHMsIHRlZS1zdXBwbGljYW50Ig0KKw0KK2RvX2luc3RhbGxbY2xlYW5kaXJzXSAr
PSAiIFwNCisgICAgJHtEfS91c3Ivc2hhcmUvaW5pdHJhbWZzLXRvb2xzL2hvb2tzIFwNCisgICAg
JHtEfS91c3Ivc2hhcmUvaW5pdHJhbWZzLXRvb2xzL3NjcmlwdHMvbG9jYWwtYm90dG9tIg0KKw0K
K2RvX2luc3RhbGwoKSB7DQorICAgIGluc3RhbGwgLW0gMDc1NSAiJHtXT1JLRElSfS9tcy1mdHBt
Lmhvb2siIFwNCisgICAgICAgICIke0R9L3Vzci9zaGFyZS9pbml0cmFtZnMtdG9vbHMvaG9va3Mv
bXMtZnRwbSINCisgICAgaW5zdGFsbCAtbSAwNzU1ICIke1dPUktESVJ9L21zLWZ0cG0uc2NyaXB0
IiBcDQorICAgICAgICAiJHtEfS91c3Ivc2hhcmUvaW5pdHJhbWZzLXRvb2xzL3NjcmlwdHMvbG9j
YWwtYm90dG9tL21zLWZ0cG0iDQorfQ0KDQo=

