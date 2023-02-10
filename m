Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BECC05027
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 12:08:25 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.88])
 by mx.groups.io with SMTP id smtpd.web11.9573.1676017786077322804
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Feb 2023 00:29:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lK8jEPoo;
 spf=pass (domain: siemens.com, ip: 40.107.104.88, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+6iD/SF7ZxQixrK5lxmcOz2C06WA6OSbpPpMIhKpuVAkmA/0Qql6pPhw3v8BzZijw44X6+Nn8qT1pk697IlQ6BIwmz4fmBhY2QBNOgylVbqby+hXJA0LcSX3rdzXd+jh99pRgJbvO0K0n5jVAysCSk84NDtCz3uQylRlkdkoHzSSqDVnaoKyU0DZIysnVDoB576Woq4Ep1rK3UUJ4HFSU7dervlKiJ/tcYMEVNP/ME+wGUhXbKhoXYWG2mCb2bw/as+ackDK4CxnkWOkozdqnF2bygJkXmrVMTMeEfpIC1ttHBtmiNu6ograeQkpj3v0HcMfakZujcnW0OyqNTLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgfnPipP1x6tb0uOISt7FqnzBQntbRUKKzKBd9BGngY=;
 b=CgF06UO9fahIiRtn5ALRdL5wIAfYLRD2ClAAHtMhLOodgIdfXBpPeQmuR2KR4nWhJZMmAW19LAOfXoktMEPcmkzvfUwo1Uo/24U4jktQ2fjFijF7w/f0dJ8gctcZnZQjNQqDZal4s9sQEGqi2P44xlyv9PVNN9SdWprlcgKXpyn4jFo+Jsx1kByRjz/kwEyWBShhgAOqqNdFXhfkM9KekVTymHy7dN1ZUIGD05Xl65exAVzbc9YHnYLTQS86r33sv/b5OgT1JvqnKqni6FXsGXFv2bDfxgrlPp0dJQ4uJxrprh8zOqtbUsVW6JpUIMiA8IIjg2JYq4/F8sqJl5mi6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgfnPipP1x6tb0uOISt7FqnzBQntbRUKKzKBd9BGngY=;
 b=lK8jEPooqloyXXaVZyp8m5NndG/PbSEA+04V/VYQifiz7lN0lE4k/cubGxXKMgfW23/74dhVsRBvcbTp9jcy+EnCK/9nacHa2lY66tmSnHsZI0Ssry8hB6r3rS6Gpxvcz+NrJ7qq/nxyY5q7MgLvkTObgWOWc9pfkm15fYC+Z0ehWHyoWZNXNOMKEGZtGhM0GzTtN5bptpkfShsMjv0dZUKAzWRljFGdJQLzUsRzG9m3gYGNJzUjnmzOuvk4OAqFvcbxg0p0NKTkU7S+bFTRJe9gr1JCUR0cNFjkDf4wQAwHeQ9pvckA2MegdArjOnCAOBIKBWLBtmnohaY+r4JXTQ==
Received: from AS8PR04CA0139.eurprd04.prod.outlook.com (2603:10a6:20b:127::24)
 by PRAPR10MB5345.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:297::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.18; Fri, 10 Feb
 2023 08:29:43 +0000
Received: from VE1EUR01FT103.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:127:cafe::ad) by AS8PR04CA0139.outlook.office365.com
 (2603:10a6:20b:127::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Fri, 10 Feb 2023 08:29:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT103.mail.protection.outlook.com (10.152.3.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.19 via Frontend Transport; Fri, 10 Feb 2023 08:29:42 +0000
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.21; Fri, 10 Feb 2023 09:29:41 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 10 Feb 2023 16:29:39 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.017; Fri, 10 Feb 2023 16:29:39 +0800
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
CC: "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH v2 1/5] register image classes via layer.conf
Thread-Topic: [isar-cip-core][PATCH v2 1/5] register image classes via
 layer.conf
Thread-Index: AQHZPRs95TAIxTfDD0W0E9lFthkIVK7HUFOAgAAC+AA=
Date: Fri, 10 Feb 2023 08:29:39 +0000
Message-ID: <aef3f8b5e3a66e2b24e56194fd03b90fd821f3b5.camel@siemens.com>
References: <20230210064503.706699-1-felix.moessbauer@siemens.com>
	 <20230210064503.706699-2-felix.moessbauer@siemens.com>
	 <89c23ac5-c9f2-d267-496c-1437fd7bedd9@siemens.com>
In-Reply-To: <89c23ac5-c9f2-d267-496c-1437fd7bedd9@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
x-originating-ip: [140.231.210.96]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT103:EE_|PRAPR10MB5345:EE_
X-MS-Office365-Filtering-Correlation-Id: af98dae2-c63f-4990-2dd2-08db0b40f552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gEy2lNhXi6FKPlH1qNTp+w7HjPno9Nmk3aoAwg2tfNuI7n82QPS5hM5t92ZcmgpHtU8tLg+O40ymztk2BCpWweQtq9en/VgtJB9RECisXBFk4uOvZ3C/JIXCzrB4ALCZRhTw0OjJomF7VufIu6ZKXxmsC+YmPOjJsepd6sMOupHzjmkzHBOZnwLXct50m8NPRWIlVV/1DwRnVVcKbnhwjlDUCbsF50/3rBr/uQmtO/otUvhTbdeCVtQKSwUcR1W0R2+zQy4EtVCPCJeIh9tySxreIh8S4N+2GxLn1tjDsFf2+i1RGzNknr/iLF4cGRHSu1t8zla3ElD2e/7H046pPVtKsFDUkVqVSVgzvxGe1EbzaDLbbCiEFF/6jzWMIGvtGcSqhPVwLVuO/kAAcZaMmbdqtdWm+aMLnlS2tmXKIASzuaewyk5z1wfD+pOJ+H+/j0ohBTa4NLJcSZ3FGsJv2oUBOa64itLjjR66xVbrN+ljrXaj5UCxAKEXllt8EFjKoVr+i8epluIae+aKzyO7HnFfIZGROKo0wtLCg82e/39/e4oR7ewhqdHt8RmGwhflION7nk1g/cH10akJyINIvAlhtRqrLIdQsu3goqjn/64R+LANdU3OcTY2lQPit9032z7mXQvKU8qk7lfkSA9L9LSRZ+jQjmSNTaVvrwr93IcjPejrFP3Fw+YNxGzXOSsOwBueyjnfUOPYZ+hrZ9ib9ITfo14GmWFm7T/t1jRQ8I4=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(86362001)(5660300002)(186003)(336012)(47076005)(8936002)(26005)(110136005)(2616005)(70586007)(956004)(83380400001)(36860700001)(82310400005)(81166007)(70206006)(54906003)(6636002)(8676002)(82740400003)(40480700001)(316002)(356005)(41300700001)(4326008)(53546011)(107886003)(82960400001)(36756003)(478600001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 08:29:42.4204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af98dae2-c63f-4990-2dd2-08db0b40f552
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT103.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5345
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <743416485FBFF64B99EE526676E07B30@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Feb 2023 12:08:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10662

T24gRnJpLCAyMDIzLTAyLTEwIGF0IDA5OjE4ICswMTAwLCBHeWxzdG9yZmYgUXVpcmluIHdyb3Rl
Og0KPiANCj4gDQo+IE9uIDIvMTAvMjMgMDc6NDQsIEZlbGl4IE1vZXNzYmF1ZXIgd3JvdGU6DQo+
ID4gVGhpcyBwYXRjaCByZWdpc3RlcnMgdGhlIHByb3ZpZGVkIGltYWdlIGNsYXNzZXMgdmlhIHRo
ZQ0KPiA+IGJibGF5ZXIuY29uZg0KPiA+IGZpbGUuIEJ5IHRoYXQsIG5vIG1hbnVhbCBhZGRpdGlv
bnMgb2YgdGhlc2UgY2xhc3NlcyB2aWEga2FzIGlzDQo+ID4gcmVxdWlyZWQNCj4gPiBhbmQgZXJy
b25vdXMgaW1wbGVtZW50YXRpb25zIGFyZSBkZXRlY3RlZCBlYXJseSAoZS5nLiBtYW5kYXRvcnkN
Cj4gPiBpbnB1dHMNCj4gPiB3aXRob3V0IGRlZmF1bHRzKS4NCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBGZWxpeCBNb2Vzc2JhdWVyIDxmZWxpeC5tb2Vzc2JhdWVyQHNpZW1lbnMuY29tPg0KPiA+
IC0tLQ0KPiA+IMKgIGNvbmYvbGF5ZXIuY29uZiB8IDIgKysNCj4gPiDCoCAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2NvbmYvbGF5ZXIuY29u
ZiBiL2NvbmYvbGF5ZXIuY29uZg0KPiA+IGluZGV4IDBjNWZkMzkuLjJjODg4YjIgMTAwNjQ0DQo+
ID4gLS0tIGEvY29uZi9sYXllci5jb25mDQo+ID4gKysrIGIvY29uZi9sYXllci5jb25mDQo+ID4g
QEAgLTIyLDMgKzIyLDUgQEAgTEFZRVJTRVJJRVNfQ09NUEFUX2NpcC1jb3JlID0gIm5leHQiDQo+
ID4gwqAgDQo+ID4gwqAgTEFZRVJESVJfY2lwLWNvcmUgPSAiJHtMQVlFUkRJUn0iDQo+ID4gwqAg
TEFZRVJESVJfY2lwLWNvcmVbdmFyZGVwdmFsdWVdID0gImlzYXItY2lwLWNvcmUiDQo+ID4gKw0K
PiA+ICtJTUFHRV9DTEFTU0VTICs9ICJzcXVhc2hmcyB2ZXJpdHkgc3d1cGRhdGUiDQo+IFRoZSBD
bGFzcyBzd3VwZGF0ZSBpcyBvbmx5IGF2YWlsYWJsZSBhZnRlciBwYXRjaCAyIGlmIEkgc2VlIGl0
DQo+IGNvcnJlY3RseS4NCj4gUXVpcmluDQoNCldoeSBkbyB5b3UgdGhpbmsgc28/IFRoZSBzd3Vw
ZGF0ZSBjbGFzcyBleGlzdGVkIGJlZm9yZS4gSSBqdXN0IG1vdmVkDQpwYXJ0cyBvdmVyIHRvIGl0
LCBidXQgdGhlIGNvcmUgbG9naWMgaGFzIGxvbmcgYmVlbiBpbiB0aGUNCnN3dXBkYXRlLmJiY2xh
c3MuDQoNCkZlbGl4DQoNCg==

