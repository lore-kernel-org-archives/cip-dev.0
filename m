Return-Path: <SRS0=SnVL=BC=lists.cip-project.org=bounce+64572+4983+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822E3C433E3
	for <cip-dev@archiver.kernel.org>; Thu, 23 Jul 2020 09:37:13 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00BC02071A
	for <cip-dev@archiver.kernel.org>; Thu, 23 Jul 2020 09:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BmB5rFBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00BC02071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4983+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HdzrYY4521723x8zLTOx4V3G; Thu, 23 Jul 2020 02:37:12 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.103])
 by mx.groups.io with SMTP id smtpd.web11.8713.1595497031101655070
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jul 2020 02:37:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOlJkT7pmVc38v42iR0jAlDZbZ2mA7S0SXH4iyGyX2PwDTrw1a9PsajwHGawT4OLZ0eTB7xgdcemVdWDOaAsUEsATVqJrMn4oIIUJplCHsgoBj5+oyQiqcJRq8PDxVOF3horh0elCg9gDPUffjHNknBZEIVe3PAO+1oFZxppkO1G1PXeRvUhlQdM0lRiCiwJZjlHKNImiMuB8WRumu/854tgG10cwCqzd9/U498AIo35DpNs1GP2I29x2AhyPDiZKj+ACL0atgcYQJlPuPIfA7QYx7i9x4nG5Tc58O2KRjJSlS0fHa1DS36WPVHLawy2G4Jg8xYzYNkG4NhMAZ2l3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQFNfxA5bw5pz3OgwTuYNPBhplb6YA/xA/6gJFwKcqI=;
 b=CRmnLotAq1uaePtMvBDBK4w2/xVUesgJNFJzz8IQa3l8i5dHKbW6FIvN/5IPkC11wW6S4nG8JIhXBCPkRKGNdJTqjrNJt1VKpJSDthgnONPhcngYmNqkWeWfNq5S3GXjdoVrsDzb6hLC7nc24xX0T2zDyzs2stbPSAx1e3b5DyOwIUacqwbrDnJT/iFjm15FD9R4CA6zQavnrUPleJr/+VbCYRUMUjsWVrsrAGMMVVWkuVkUFl0H+JV8LUpTB9wTcgKmlCoTNaA3tagzoVDdKo7mtlwX5rdLDRtE+bwJFUeAbtfqQbLWcBQ6NFJQ0pBEH7gqYWbxNVnvFxEcBj3b9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSYPR01MB5336.jpnprd01.prod.outlook.com (2603:1096:604:8b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Thu, 23 Jul
 2020 09:37:08 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::9dba:6049:dd66:3c70]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::9dba:6049:dd66:3c70%7]) with mapi id 15.20.3216.023; Thu, 23 Jul 2020
 09:37:08 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>, "ben.hutchings@codethink.co.uk"
	<ben.hutchings@codethink.co.uk>, "SZ.Lin@moxa.com" <SZ.Lin@moxa.com>,
	"wens@csie.org" <wens@csie.org>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP Patchwork
Thread-Topic: CIP Patchwork
Thread-Index: AdZg1ErSblGkeTY5RLCzs1AcoDxFYw==
Date: Thu, 23 Jul 2020 09:37:08 +0000
Message-ID: 
 <OSAPR01MB238534DE1045DDA72E9C7548B7760@OSAPR01MB2385.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [176.27.142.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21bda594-a8db-4129-c632-08d82eebf7cf
x-ms-traffictypediagnostic: OSYPR01MB5336:
x-microsoft-antispam-prvs: 
 <OSYPR01MB533695CC6B5C544DF412D6E7B7760@OSYPR01MB5336.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 8mScWLSEehTvimPQz60Ja9CjpnjxTDjAXDTfiTb0xFADifV71VGQ5xy9QoA3zP+FC3gFnF7i+Jmj04Dh0ZArU+Zhh/RBMlfvtGpQrpBw/0e/kXnPbb0kBLngAG4+nsE1GtCkhfj2jypOuLcoDvBA7za47gmD4FG7OXnuoSS1q7n02TpamWj+kRLtTZ/fsGMi2zjHnZ933Qa8y6iP5O8LeMXdxSMz6d2YB88yaLwF0lfk5zKD3t/YYE81OLisQ/KjRnRYOpdP5T+ETG8eSnPT0X6scWjhIoKS/b2x0IhPdKBjaUyCOFIalwBoswLIZu6LA/Y6ns7AE8e6tA09dBSUcxd2A8ql4ywv5rSuGv6myHZZJbt01WEw0t4yfpN91PtiuqSX5YEYLiTWqlKk2Xv/PQ==
x-ms-exchange-antispam-messagedata: 
 0vgbbUEL+exNJryz8n0YmXaDb4Z+oQNyy6ixr5nrj3RbTSPsi12bJKNQ3BM86fc830TPZ6GoNhwhqDuEJGzNKTYQCdDCDuzIvatEEmTpyTH9g+TGlAhowuoApa9SZ7E/cn2r/raoU+E9+H1e5OkAkvMK17uRFhIodL6pwpG9PJ64IseR3M3PGyCUWE6fyj2nXXOVmx5fLhxnie7nO3rvpVFkNc+SlCor7Y8d5CStco46AiRDMPYcZ3dR0zGSv/zZOUg9CGOdqUKdEqA9DYJ8J41zklBxO15xStmCS9nPpJJRmP7e9OX8/V3EOh6oLFDnhQ5Q7c6f6wLlrq0wOP0uuQGaN/4JYyt4snKlpGKscaZlFU6y9scFA9/NENh4q+Y96Jct3CTpjT+h+dN112eA2VMRzLXc2WeKuTkVLlPbMK7qxIbSLJNqxnws0/mnWG5JLgUZhZgduqdvTkaGYeEtlfjATFs5bHncD3LzBlSaxYE=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bda594-a8db-4129-c632-08d82eebf7cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 09:37:08.1037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: loZRRdpBWOYApNDR//2ZUkFjcnVY294+zMN8KMgLBoyguP0OjbTEZh01eavgfDdYKFFL5Fkgb1LwqCZztxGdnteKY9tGnwAfTk9/46gEOUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5336
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XVXCIDvOm4k0wz3c1Y9QpQvDx4520388AA=
Content-Type: multipart/mixed; boundary="6CMG4bDe6HwGtWQbc3ub"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595497032;
 bh=CJ/Fcws3qOCsd7MlVcC4ErkPd3VYIreHiJijffyckbE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=BmB5rFBxdQafI7CYhKTA19mETudaygIyy+Tjr7l/hl78GPgs/t+f22qOlL/ldM3susx
 16LHMleyfzPhVP7yw1cogSzt18P/X+qJBBNompaEjLcX6iCc7fcGhYyizPf4LJKKa5J0o
 Qs5i/g1OMpCK1bNDsD5IDvACyAGhYhANILs=

--6CMG4bDe6HwGtWQbc3ub
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello all,

CIP has a Patchwork instance [0] that monitors the cip-dev mainline list fo=
r patches.

It doesn't look like it's particularly maintained, with most patches in the=
 "new" state.
As a project, do we want to start maintaining Patchwork? Should we kill it =
off? Or just stick with the status-quo?

We briefly discussed this in the IRC meeting today, but I thought we should=
 check with a wider audience before making a decision.

So, any thoughts?

[0] https://patchwork.kernel.org/project/cip-dev/list/

Kind regards, Chris


--6CMG4bDe6HwGtWQbc3ub
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4983): https://lists.cip-project.org/g/cip-dev/message=
/4983
Mute This Topic: https://lists.cip-project.org/mt/75742669/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--6CMG4bDe6HwGtWQbc3ub--
