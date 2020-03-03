Return-Path: <SRS0=W4f2=4U=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32193C3F2C6
	for <cip-dev@archiver.kernel.org>; Tue,  3 Mar 2020 08:54:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DAE20842
	for <cip-dev@archiver.kernel.org>; Tue,  3 Mar 2020 08:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="GHGe8RmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DAE20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5C2AB8704A;
	Tue,  3 Mar 2020 08:54:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fJ6BrJiPKz7B; Tue,  3 Mar 2020 08:54:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E2E6986EC8;
	Tue,  3 Mar 2020 08:54:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0C0DC013E;
	Tue,  3 Mar 2020 08:54:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA8E5C013E
 for <cip-dev@lists.cip-project.org>; Tue,  3 Mar 2020 08:54:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C101D86ECC
 for <cip-dev@lists.cip-project.org>; Tue,  3 Mar 2020 08:54:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uu2XJxuHrmQS for <cip-dev@lists.cip-project.org>;
 Tue,  3 Mar 2020 08:54:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400109.outbound.protection.outlook.com [40.107.140.109])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 644D486CD7
 for <cip-dev@lists.cip-project.org>; Tue,  3 Mar 2020 08:54:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQE+pWPWrooP7syqcw0Dr9IvJn3uS0AtwXymGeQCGyC7vhYvjdmLDbONktxEQquWC38/RfRXc3zSilph79YvQf1ki7XRjmINPMlao0SOPwmjsOVh3QWmj0C2levSWY0ht4/PJmmflh/2U6TfS8/RjwtJspbmxp2UpWf8HB+oOg6YPhxzjjk3MrMufioKAVmsLO2D1zYp4i2IRjxbbWZbnRvL2Zvcz+L/pnJnJTZiFbBXHu2bfuVG8pUAuysi8X77IcIEIOXArXMQiUpBosgOJ3YfBBk9pPDHRsFqf0KPRQGnMdrcqokY+s+Rv3eluVdiOh8vPc7LdQi/v/IedYKqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rZzwAmnxQcqO8DbkCo8onLrjkJZIX1M7rJnQJXQvug=;
 b=caN66IWjHEB40Ertw9zoigRu08kDsEsEZj8R2M0ipAjs8KxJ7vMvIPhwFNM+KeCCboYq6P0p8PJ7Srhdlvsmir9qxHEgpJGmhqmm1G1RI8IfRMGhgfUbpl8WdzpFY0+7RNyGE7wf8x1CNfmI1RGfSMXpeDc0KQHpzGNn0THHwZPCjTQNTzhCuEaVAUWRlVo8a+ot3d3ChcdUvPduuN2QtzPHmzRnvo5apDiKZ7KyS9vL6JOH2HVE1+8RRYAgvywd8t84Maf1Jf9Hjsw7UmAi791QfjPray4PCm50InnDzEyaE2N9/5lsN7BH2DBsVwuk59H1jvD6C5zR8/J5vdpaJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rZzwAmnxQcqO8DbkCo8onLrjkJZIX1M7rJnQJXQvug=;
 b=GHGe8RmVeM/bKJnAY4BEMMasmYVUrX9MKejG+RssuX6yaqfZzYerlClK6C64ekEipRnvU0RSKNlYyM6UC5E/CMywHKfv5n9TMVrSHQL5yrUQdtCkTUlfGNCUUPa9QK5YiovRqXz0wWeO7ImYL2ceiKLVzoifa/X3BTTgzrpRiOA=
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com (52.133.177.145) by
 TYAPR01MB3982.jpnprd01.prod.outlook.com (20.178.139.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Tue, 3 Mar 2020 08:54:44 +0000
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::1045:4879:77ed:8a70]) by TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::1045:4879:77ed:8a70%7]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 08:54:44 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Thread-Topic: lab-cip-cybertrust online
Thread-Index: AdXxOOoHiaJjfkejSbefSiMWIdBTkA==
Date: Tue, 3 Mar 2020 08:54:43 +0000
Message-ID: <TYAPR01MB22858ECB4F2CB1275372BB77B7E40@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Paterson2@renesas.com; 
x-originating-ip: [176.27.142.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f8140a8f-1363-4123-d003-08d7bf5084d4
x-ms-traffictypediagnostic: TYAPR01MB3982:
x-microsoft-antispam-prvs: <TYAPR01MB398227995FCF42BE592EF630B7E40@TYAPR01MB3982.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(189003)(199004)(64756008)(3480700007)(86362001)(186003)(6506007)(9686003)(66556008)(81156014)(81166006)(66946007)(66476007)(478600001)(66446008)(76116006)(55016002)(558084003)(966005)(52536014)(71200400001)(33656002)(5660300002)(2906002)(7696005)(8936002)(6916009)(316002)(26005)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TYAPR01MB3982;
 H:TYAPR01MB2285.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3nK2VWoIMbQ5yoLxI9sy62i95sSvrQyXwOTcvnQqyX2RZo2JruXgb/dHEnvGWiKF0hoDLZuC3zNuBnO6v+UM3swND2TkWhnxubszoqZlB9VslEuIUm2KrlFR6rWAuC+LkIRyPu1Za8jFSY3f2VR8lFJZyefPGBVTY8kp1tUNYmmncZF0fEpVVNJUZvMDraGu0jYkjWJvFfUcJE4xw8UGDKaisZ8Il+wHUfTRPLooXuC+Vaz2QPp/r2Ze7c3gP63J+kPa6FXSzZxO/8UeTWq7VcyojNk3yIu9ieSwvXzvv0Z5TOBXPafk1U2JQkw1kQzCqJobcIGhoxLYigu+LEHJky4s77RJzQj6z00ZL33avaAydWsbFnyIJU4jPzNKrG57rnivKKy9qIWqb/mjQ94L29jkah03oOPo01xrWJcJM9FtipDtuQdsD4Dz+BmkksU1j6UwTylpNYqp0GZpiFF02usOfrDmqma+BlIRAUhgJdRc3dDnWQAVZ63tkgJyxARPF57G6Bm++JPooBXvyyuu1w==
x-ms-exchange-antispam-messagedata: NbT5l/DTicS8obOodYbNrv0IgM1PmzzeyPr1HS+Sr7vjeor8/A8RQW2UGyAWB8yLT50RrRoC0BA/EZn79+3xiWrx4b9ruBX95NjwnFvNFICH8pb07YUB9ALL1oGTpSycl7x3Y2du3nF74qw26Q7PwQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8140a8f-1363-4123-d003-08d7bf5084d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 08:54:44.1823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yyZ7R0EM0D1QraTT49qkhJjgymHgo0UGopVkKrPygN4uWtW+aaNTzgDmo9h8jLeLVX2uIm46vAby8z/Hj+0HakhrV7PVCC0Gz3jmjuL18z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3982
Subject: [cip-dev] lab-cip-cybertrust online
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

Hello all,

Just a quick note to say that a new LAVA worker hosted at Cybertrust is now online.
https://lava.ciplatform.org/scheduler/worker/lab-cip-cybertrust

Currently it supports a qemu VM and a Xilinx zynqmp-zcu102 platform.

Kind regards, Chris

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
