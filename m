Return-Path: <SRS0=6jSD=4I=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF5CC11D04
	for <cip-dev@archiver.kernel.org>; Thu, 20 Feb 2020 11:06:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D1D24654
	for <cip-dev@archiver.kernel.org>; Thu, 20 Feb 2020 11:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="F0t/D67P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D1D24654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2684D86D39;
	Thu, 20 Feb 2020 11:06:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VTnRO37Yp6Hq; Thu, 20 Feb 2020 11:06:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E5A3986CE1;
	Thu, 20 Feb 2020 11:06:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8EE9C013E;
	Thu, 20 Feb 2020 11:06:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80872C013E
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 11:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7693586D03
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 11:06:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F7ap-r1dofW3 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Feb 2020 11:06:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410097.outbound.protection.outlook.com [40.107.141.97])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E609686CE1
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 11:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3pBX7JaUuxOEaLmbAxtsqib5g9idf/avn5YMdDzALta8RV+ex9YYAswtXYnq8LbHL/Yj4tPUe+D6QgLGNqznc0llKpB35gR8uFgxbdZTAUmo1c3og1fcGYmwGvbnrXKgYhYt27ilTE3lFMk+JrVvzHT2q0c06ZtUwhtYdWnX9MmSMKUyvwhBWHrL1On4TUkyam06ccPI2X5xuo4Oj939Dp/b9Lp8jk61Ci4pKM1adD9SkPZgFWxsb55s16IOvYRPo5pnbsbP+2abz7vaQmf71hR3sQbub5IUJ54g+fOg6AY1xB/Fq2ED85nk4BfQjLammaEiz53cxM+lcxMae6v4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6UcWYXATwRPD38FMdn5SQ/EE9jNOTYFNcQjkMcm/D4=;
 b=NGHppSBL9rpARW4N08pvp19ajJa27zFpHjMbbr/EuKVaX3GA5EUJ8jO2JBKfNmxzAj2TY/fzH2xcJz6qvg8NOmn/A0Ll2uccLxtOA4UzewWOHGzebqZelmh3oWfXsmYOo0vNQfQsXdKVYsD//B90gKLwfSCI23Wg8+3XCXdYZFuP/kegcVd2WiIpQPaw9nStOy8TDbNjOuEcWTA7TC4eUjQRkIpz2ddsGJTWsVjHUdBnHijAXdIPtlMjYLv5iZwiOZmIn7vdPS7IWdf4yIyR4YtVqOO7FmaipOwfEv05fz7sBVTz51C7eqaBx9g9QurPHKXin7V0bp4cvcMTaHt+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6UcWYXATwRPD38FMdn5SQ/EE9jNOTYFNcQjkMcm/D4=;
 b=F0t/D67P5sus1A3b4PLOL6akzzgXNhI2QEwV5BsXtN61uSXqaSkB/VATI6/p3895YYA7JYejeKBpmD7lTwp7PgTKInQTbqlNA6SRNUczJOWVjT36z9bpyvsKC4nznYba3I4k2+hd/ZnY/gACMF2OL28fUrArHCrPBGRUjU6PM2E=
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com (52.133.177.145) by
 TYAPR01MB3502.jpnprd01.prod.outlook.com (20.178.137.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Thu, 20 Feb 2020 11:06:49 +0000
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::1045:4879:77ed:8a70]) by TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::1045:4879:77ed:8a70%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 11:06:48 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka, Jan
 (CT RDA IOT SES-DE)" <jan.kiszka@siemens.com>
Thread-Topic: [cip-dev]: isar-cip-core and cip-kernel-config
Thread-Index: AQHV5ndNUlKGEDWsrkO3+RD9IKnV26gj66kw
Date: Thu, 20 Feb 2020 11:06:48 +0000
Message-ID: <TYAPR01MB22857E4B676B416B215236D3B7130@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <ca39ce48-8602-0e79-99af-2f44200e2b12@siemens.com>
In-Reply-To: <ca39ce48-8602-0e79-99af-2f44200e2b12@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Paterson2@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df868548-a7fe-4156-672d-08d7b5f4fb59
x-ms-traffictypediagnostic: TYAPR01MB3502:
x-microsoft-antispam-prvs: <TYAPR01MB3502C9BB46510A1269775F7FB7130@TYAPR01MB3502.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(199004)(189003)(966005)(64756008)(66446008)(66946007)(316002)(6506007)(66556008)(110136005)(66476007)(86362001)(4326008)(54906003)(76116006)(2906002)(5660300002)(478600001)(33656002)(8676002)(81166006)(71200400001)(81156014)(186003)(7696005)(52536014)(26005)(55016002)(9686003)(15974865002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TYAPR01MB3502;
 H:TYAPR01MB2285.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a16R8PNQjgSLXOByAWWU/BiYkcnPoYlKiDKDMQoCCe9CEda9Y5aeNXzOv7njXvv1WvqPN4C9220zY+B7gUMeDIv3WpwacJixEPsYMgmnLtacJndYtTtfLhIAwKIjzKrRRqyoFGcB7A6t06rl58DSfDgxOJr2VYKVKtJx0uJ09gWFqUInEg55xa0vUPnpJssNqrZMgZKoV2LZ+dOxa7qO/yZjFWLCmY+GBuQcIgNXH1RlPWe3dQEFsnbDUOxEa0kBwl0gAZwBRwJQjP4kk2Zee8b3UaVE3im0mYwYJhPBxigld7zjIN8VWecgd33Q2x1i8THtlwHw7T9adSbjB8UgUGpOtfs5FCpuaz3cPT6yirBEAOfdgNJNUsAw+7VuEAeBIKkKj2OKyYVRkRJumaIYr4QGNr3SAnoNZrBEyNr+OpoJV9Hyf9p24r6EvrQnxpIJDLPxrEUrqXDOTEU8p9O/hmq9Ba3pk67vaJ1I3QcZyObH3LxybnEKYOsyAKDScCdWYajkHEHp/waiyo7qLZ5vLQ==
x-ms-exchange-antispam-messagedata: hGpDZawli4dPxGuiX7VqUd/CpkTR02cw3ISgi6+sYrL1PH0Vu4W3TAoRv7pEO/S7eQxGDnOclArdJ6aZIC0tTV3itHgVEhszNbFRP8HzGGIRVAli5Z6SoBxSxWv5KYWNBIjjPTXo1LqdlfAunQ4Spg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df868548-a7fe-4156-672d-08d7b5f4fb59
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 11:06:48.8823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ViXHKSwMyGhEbF/zrJqZicR5WxN0phP8jCsOAQm8l3Rgow7aShwHuqQsPnVRx43ineMBEu87vNkiuM5Ycyy/yfP/A485THQ4d8kfEZ30gGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3502
Subject: Re: [cip-dev] : isar-cip-core and cip-kernel-config
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

Hello Quirin,

> From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
> Sent: 18 February 2020 16:20
> 
> Hi all,
> 
> I am currently trying to have all targets in isar-cip-core running with
> the matching configuration from cip-kernel-config. For some targets
> there are missing config entries to boot Debian 10 e.g. [1].
> 
> Should I add these configuration directly to the matching defconfig in
> cip-kernel-config or add new defconfig/snippets for isar-cip-core?

Good question.

I think cip-kernel-config was created to help the CIP maintainers know what configurations etc. to support/maintain.
How will it affect the maintainers if we start adding config options that are only required for testing, rather then for SLTS support? (Or do we technically also need SLTS support for the 'test' config options?)

> 
> Currently I am adding them directly to the defconfigs as it is IHMO
> more manageable as it avoid snippets/configs all over the place.

Would another option be to have complete configurations for testing, rather than just the extra snippets?
It would mean we need to maintain two copies of mostly the same thing, but it'll make scripting easier and be clear what is for the Kernel maintainers and what is for testing.

Would it be possible to use the same 'testing' configurations/snippets for both deby and isar versions of cip-core?

Kind regards, Chris

> 
> [1]:
> https://gitlab.com/Quirin.Gy/cip-kernel-config/-
> /commit/92979dba2e3c03a422b5b9e8f9c592db9ff43f30
> 
> --
> Quirin Gylstorff
> 
> Siemens AG
> Corporate Technology
> Research in Digitalization and Automation
> Smart Embedded Systems
> CT RDA IOT SES-DE
> Otto-Hahn-Ring 6
> 81739 Muenchen, Germany
> Mobile: +49 173 3746683
> mailto:quirin.gylstorff@siemens.com
> www.siemens.com/ingenuityforlife
> 
> Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim
> Hagemann Snabe; Managing Board: Joe Kaeser, Chairman, President and
> Chief Executive Officer; Roland Busch, Lisa Davis, Klaus Helmrich,
> Cedrik Neike, Michael Sen, Ralf P. Thomas; Registered offices: Berlin
> and Munich, Germany; Commercial registries: Berlin Charlottenburg, HRB
> 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322
> 
> Important notice: This e-mail and any attachment thereof contain
> corporate proprietary information. If you have received it by mistake,
> please notify us immediately by reply e-mail and delete this e-mail and
> its attachments from your system. Thank you.
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
