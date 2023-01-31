Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEBDC38142
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 12:44:53 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.40])
 by mx.groups.io with SMTP id smtpd.web11.8188.1675156191526112344
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Jan 2023 01:09:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uqlvFe0J;
 spf=pass (domain: siemens.com, ip: 40.107.104.40, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8MDqMBEkRcEHrGXXj/PPC9Y3zUmPnGMszr6AA56cS0xeTLFLZfTDMbSsDal6HtWQJErLCFQ67fQb3LrydLc8m89EjLRIwgmSfSAPu7arkk1nYr/26QilZ+0yzo/gqvwJZwC5JhOzAzNG6KIl6BxXQozFDFPVLZcmJ48ORrOOnnteZMIGNtuObC3gkj/YzCOpZxgb+xYMVaEilVaorRlrortq4NAoAQmuDDqwc1meGucTaNoIxJk4TqhhZTVpC9kXrNB/ixCx+pvbSwFKdMPxu672bbiArV4LT02mB6n4jeQhEvGVN/Thnck3s2oH5GuiC9U9NeePHadQHmj3wnvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYtXBcHm50DWrk318NMmDzxThOjiU/mAIMR6PqQJ1nY=;
 b=lWWSbAPxGtnYKo3VQtvONJb7MUPogYvWfoEwpFabugJ/3tlmvmJfAGdODfZBgWSV9gZdP+GRNxx95MoEIjKN9riJCngWNVfZuEuvxaq7j1NMFc8UZt+9b4dOIac6blbY5WHmdmpQTybRWvo2JmEDhV6ucLKdGIIMRTS9Q+iPxHg+JoAL//mqKXrSzV3L8cHWfNUYRRkBUY3fUuTqTDe3eXbbpFBvrjjwQ7UIqpfbbKqNAaTdoN6mxXqn13g+g7y/VnIa8P5BUKJvDa3dJusdjKm9VfMYbkImLe6U4ukWTBsOxyOHL/VpmaByggK7ewlGoQrGF7UomHwffFhbVXZmUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYtXBcHm50DWrk318NMmDzxThOjiU/mAIMR6PqQJ1nY=;
 b=uqlvFe0JeMhnmpGKRvg4vsbx6pyujsb1y/X0cEWbJuUVlVAK/TRNxNOg/Fnw1grJlaFupKPsV2F/3cIvRS0XAO1l4XpFUkXhDvsGVuSNN+uXyMBKtolcdGPY7a+HcvjtRz+Hk7KkiyXi/KREboj10Hnzhc97aPuvr/wYFL9z+HV7xlFeIQNuUyjnYo+I0oaqj3KVHOeINOu+q2axk8l1Wwx8vnbqk5lz9EufhBNnAum8a8n6wpFetUnNGKeTPOrGT5Fb82wj1I9B5baRle2lONTsOtoVtStQ8DDWtXEwMJYeNWtI6nMIGkyDeQhmGfu6Do/X7JHbGI7GLoq/Z4qclg==
Received: from FR0P281CA0146.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:96::20)
 by DB8PR10MB3767.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:167::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 09:09:48 +0000
Received: from VE1EUR01FT033.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:96:cafe::c6) by FR0P281CA0146.outlook.office365.com
 (2603:10a6:d10:96::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22 via Frontend
 Transport; Tue, 31 Jan 2023 09:09:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT033.mail.protection.outlook.com (10.152.2.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.25 via Frontend Transport; Tue, 31 Jan 2023 09:09:48 +0000
Received: from CNPEK01M08MSX.ad011.siemens.net (139.24.237.225) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.21; Tue, 31 Jan 2023 10:09:47 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M08MSX.ad011.siemens.net (139.24.237.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 31 Jan 2023 17:09:44 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.017; Tue, 31 Jan 2023 17:09:43 +0800
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
Subject: Re: Override of sid distro config breaks mirrors
Thread-Topic: Override of sid distro config breaks mirrors
Thread-Index: AQHZNJFZ3aNSH/WFc0S3ecB2UIGf/K62RTgAgAFzAoA=
Date: Tue, 31 Jan 2023 09:09:43 +0000
Message-ID: <5ceac9cb0b555bb7678894eb3f151aefe797465a.camel@siemens.com>
References: <0236184cd3f04ecb0a3282bdc6c8fb7eeb04ae81.camel@siemens.com>
	 <65f143aa-3e48-9075-357a-08087a5e922c@siemens.com>
In-Reply-To: <65f143aa-3e48-9075-357a-08087a5e922c@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
x-originating-ip: [140.231.210.92]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT033:EE_|DB8PR10MB3767:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afdbc90-0c9e-4d82-d4c2-08db036ae734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	no/BNZ9MWDCKkx5cBxKp2pETHLOXCggJ8LmBMiEcrAlLHt/ZcLUR3QnZE5ixSe16V1PoRZu4rr3HaJhnTEHa1IpgYPuzAW4yWEIUzAr48UCg5HBn1XncbrB7kFPuY4e/IvZZg+ZH7C+xLs0nvPUPGi2OLf7x/MPEX3pCx6Ee6tQbapICBaN7zuan725bimvv7WMGQnwcoCPegT7sBAW5nij3dS9CREbJyPeKolResCAgobEmdha8Vhwybl65hpYGO1BBfCEH+NOeMWM7LQuTmiqRzuW+yERB9pSObl96hDSI5+evWr085Ge0cNUFZfqcrOMi6isK28hWyVPLhSVmw89it0xAIAVBzUvnSkdnT1i3h9eSceYv0LMkU1okv0GHCB2LXPoCcIcYoFs24B0mjXPkHhvjkJMtZBSHqz+9I3ak6AnNs2LfAOpCZvpEL7oZGrCD9cRb0R+45aB6lsHMVArYvrXEtrFTHxm6dwLlW4wloh6Mr6L0flgirrIaBP61ZFUzO0pFD0soNf9WuXWTzYEGvIyPiM4SmCfXlPhWYZ/6v5RKh5nJwudzgcPS4sa6LIbnzwE6NcnSkQWoT+4NZ/oZ29PscuQ4x6NST53TmeXInZhi6RlRtG1/HXyZk1GnEQikB/6wvy7TAug/nGQeCM68lEMAq+vJqAX6X07wdcxnSZY9fTBQwkc5JwnIZZc3J+5hIUh5XmMIaP7AMik8uOGO3tVjR9AmPeccPbzndEh26lV7nicMH3xgnERjwtphwS75sxicCp7MWPF18i77Zg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199018)(36840700001)(40470700004)(46966006)(70586007)(70206006)(47076005)(8936002)(8676002)(36860700001)(41300700001)(83380400001)(336012)(36756003)(40460700003)(53546011)(956004)(2616005)(82960400001)(82740400003)(110136005)(82310400005)(5660300002)(316002)(26005)(81166007)(40480700001)(356005)(6636002)(186003)(2906002)(86362001)(478600001)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 09:09:48.2914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afdbc90-0c9e-4d82-d4c2-08db036ae734
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT033.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3767
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <071985C3A9AC6244875B40FD51805EA1@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 12:44:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10525

T24gTW9uLCAyMDIzLTAxLTMwIGF0IDEyOjAxICswMTAwLCBHeWxzdG9yZmYgUXVpcmluIHdyb3Rl
Og0KPiANCj4gDQo+IE9uIDEvMzAvMjMgMTA6NTgsIE1vZXNzYmF1ZXIsIEZlbGl4IChUIENFRCBJ
TlctQ04pIHdyb3RlOg0KPiA+IERlYXIgZGV2cywNCj4gPiANCj4gPiB0aGUgZGlzdHJvICJkZWJp
YW4tc2lkIiBhbmQgImRlYmlhbi1zaWQtcG9ydHMiIGlzIGN1cnJlbnRseQ0KPiA+IHNwZWNpZmll
ZA0KPiA+IGJvdGggaW4gSVNBUiBhbmQgaW4gaXNhci1jaXAtY29yZS4gV2hpbGUgaW4gSVNBUiBz
dGFuZGFyZCBkZWJpYW4NCj4gPiBtaXJyb3JzIGFyZSB1c2VkLCBjaXAtY29yZSBwaW5zIHRoYXQg
dG8gYSBzcGVjaWZpYyByZWxlYXNlIG9uDQo+ID4gc25hcHNob3RzLmRlYmlhbi5vcmcuDQo+IFlv
dSBtZWFuIHRoZSBsaXN0IGZpbGVzLCB3aGljaCBvdmVycmlkZSB0aGUgbGlzdCBmaWxlcyBwcm92
aWRlZCBieQ0KPiBJU0FSPyANCj4gQmVjYXVzZSB0aGUgb25seSBkaXN0cmlidXRpb24gaW4gaXNh
ci1jaXAtY29yZSBpcyBgY2lwLWNvcmUtc2lkLQ0KPiBwb3J0c2AuDQo+IA0KPiBUaGlzIGxvb2tz
IHRvIG1lIGxpa2UgYSB3b3JrYXJvdW5kIHRvIG92ZXJyaWRlIERJU1RST19BUFRfU09VUkNFUw0K
PiBmcm9tIGBjb25mL2Rpc3Ryby9kZWJpYW4tc2lkLXBvcnRzLmNvbmZgLg0KPiANCj4gSSBwdXNo
ZWQgYSBmaXggYXQgDQo+IGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtY29yZS9p
c2FyLWNpcC1jb3JlLy0vdHJlZS9xdWlyaW4vc2lkLWxpc3RzLw0KDQpUaGFua3MgUXVpcmluLiBJ
IHRlc3RlZCBpdCBhbmQgY2FuIGNvbmZpcm0gdGhhdCB0aGlzIHNvbHZlcyB0aGUgaXNzdWUuDQoN
CkZlbGl4DQoNCj4gDQo+ID4gDQo+ID4gVGhpcyBicmVha3MgdXNlLWNhc2VzIHdoZXJlIGxvY2Fs
IG1pcnJvcnMgc2hhbGwgYmUgdXNlZCwgYXMgdGhlc2UNCj4gPiBkbw0KPiA+IG5vdCBzdXBwb3J0
IHNuYXBzaG90cy4gQWxzbywgdGhpcyAiaW5mZWN0cyIgb3RoZXIgbGF5ZXJzIHRoYXQNCj4gPiBh
Y3R1YWxseQ0KPiA+IHdhbnQgdG8gdXNlIHNpZCAiYXMtaXMiLg0KPiA+IA0KPiA+IFBsZWFzZSBj
b25zaWRlciByZW5hbWluZyB0aGlzIGRpc3RybyB0byAiY2lwLTxkaXN0cm8+IiB0byBnZXQgcmlk
DQo+ID4gb2YNCj4gPiB0aGlzIGFtYmlndWl0eS4NCj4gPiANCj4gPiBCZXN0IHJlZ2FyZHMsDQo+
ID4gRmVsaXggTW9lc3NiYXVlcg0KPiA+IFNpZW1lbnMgQUcNCj4gQmVzdCByZWdhcmRzDQo+IA0K
PiBRdWlyaW4NCg0K

