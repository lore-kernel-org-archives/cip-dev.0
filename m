Return-Path: <SRS0=iOpx=CF=lists.cip-project.org=bounce+64572+5280+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D57C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 08:21:43 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3EE22B47
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 08:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bLis8ZXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3EE22B47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5280+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id r8gCYY4521723xwVxKwFxNZX; Thu, 27 Aug 2020 01:21:42 -0700
X-Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.41])
 by mx.groups.io with SMTP id smtpd.web12.14426.1598516500690451253
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Aug 2020 01:21:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrsuBABC28yUPnwZ33W6tswZP8IKqgit9vEkyu1D1iW6oupjic3yD/URvJyMt4/QigtGf/pW/1NskMj4ptwLTyn1qOlI/E6hdWKQz2+yonT6NxkFlgOuiakeLPYjwJhb3XpPSxrzgOJVKXw/81zhutRDMqUmD8g0JmxP8c6gC9x4HJwa5XS3Zc5nSncfW7YlqrnK+pGuKXp1hiyK4/xAy3LY0zyXWRqJSxDqXc0l7HxXG+4jtXX9G66OrbobjFJKZYo1JZzkxH8BKH0piYWCZTFVFs6w/qDwe0gg2Szl+01NDCmv/vRmGc7GP1821kEzz5r5VUyt2n5Z6ASYKd1yfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGTBShiNH5E/QqMi+wSjKDHvJdHPdNwfQIFa9ImNLRM=;
 b=YbQmzfNGOqjmPwLdqXU5FKJ+ImzI1zNUwz//0DelhjoRu/X7R2jPWiGwC3cC7mp1Xgi4MF5FldapPhimCxrxNujoSNorjWHbfB+U++V3YHbRGBPvBPtxnP3wVIE5o7sGRuM487C7vUhEAphIyvjaqwyBV++wYpGWEub/tnOEyHRW/1SYpX6BO8Vgkbmuxfs5C2r4jDCOaHrFSx0EyJIEwUf+nzmCfAvhYITqxLIOImkM5HwUhV1zxEZHInPyj/etF8I7YwyKo6SH/GxQs7/ejaA1dSm5TZV8XXjNT4ZOY7FQWpgI2nfER/4Kcp9gZ1XrpjQH7n9MtqCcA6QPPgYlPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
X-Received: from HE1PR10MB1563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:7:57::24) by
 HE1PR1001MB1371.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f5::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Thu, 27 Aug 2020 08:21:34 +0000
X-Received: from HE1PR10MB1563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd91:f8c9:573a:6725]) by HE1PR10MB1563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd91:f8c9:573a:6725%4]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 08:21:34 +0000
Date: Thu, 27 Aug 2020 10:21:32 +0200
From: "Michael Adler" <michael.adler@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev] Everything failed in gitlab
Message-ID: <20200827082132.ca3vmztk43723bas@kratos.fritz.box>
In-Reply-To: <12b9b0c0-7117-81fc-8360-a0bd858715a8@siemens.com>
X-ClientProxiedBy: AM0PR03CA0081.eurprd03.prod.outlook.com
 (2603:10a6:208:69::22) To HE1PR10MB1563.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:7:57::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-Received: from localhost (93.104.90.55) by AM0PR03CA0081.eurprd03.prod.outlook.com (2603:10a6:208:69::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 08:21:33 +0000
X-Originating-IP: [93.104.90.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d6f5ceb-5d4c-4a07-e583-08d84a623585
X-MS-TrafficTypeDiagnostic: HE1PR1001MB1371:
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<HE1PR1001MB13715E927EF558C475B948B1E8550@HE1PR1001MB1371.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 
	KJF6fKjJoyeZGXEI/F02KKDO6+o0Vw3lAGO/JqOSyyMq1fmNvuaYNwfilBFfwqczFE6c7St+2oz0+tNuBbUX31pscnoF838MUnI/XvexnfUfQCHM9SLJP7Jj6CihYCLKo4igqXb49EDoYhzA/tldHmgT4EtzlI+3JsLwnDxd+xEq6xGEH/RPvKclkpkPyVg5msP1Ro6BrnSe60v/5ENZbkqA6Yu3GeILXTDuozjQeofEv1NR6MNi3ADpcnDug7UgVyNHx9qXZ471p+dYOXiQSPtjrK5l6UuD9AOkZPZPiPqoYov7RfrK2mYJWDdMfQ43NZhmCQ3RERizKNIFFR0lDCKKuP7ulpfx8JFXQr97siT1fcvgN8BU4yNEkErk1AUU5t+oYz9IWvJUKK4ntELktw==
X-MS-Exchange-AntiSpam-MessageData: 
	ldiR/Q+KG1FxOw9H0tCT6ySj9qmcacUjbm/7L0GLIYpPUSFUOVFA8aKl8I1lBT3q6Eld8c+ZMID0r8LckGy5p+r/4ioJHaZ9dnGpa5OjuIqMecqhrr3PhQhDe5gV/KzaSBtsw4WLjA02XR0ElUvGQFJ6i8oKMuURD2wkHRgRMAID1Q1i6MRxk3zlbS6NeE+Ng0h8KWjY1c4bgD7b+ir0d0+DtAcCrY4AOAD/HBDni9cw5jqiMkD8O5PjhsLZUQ/AXVfsCgpaFhmO2JL8pGCxLdwtAFWBMT/UdFyvw3s2loUupXRoPvLw4C8P75KNGsaNfKIqnv6JnVFFJ/42FX2GDylMfgrCPdW7yOiMGKh0JMtatoL4LZSgxQR96iteB9raYT413WbneLUSMFP2ObA8QSfjyawCQRNL12mv5tb+XuT3omRbRbRr9xDz9SShmzKr5h9nDntARP6rOokizXcWv0+2eBufS2mPACh2Bq7Rdgfrn641nxlsu3cJz1wsYwYEAL9xAv4jjFxeykhB4MBWfurl9ElVwXtx2b5TP8VgQAp8Ye1IhBKNvjsqJJOadd4zeLMkdzbHqhKzeOZKj1uOtn7zhg1FuT8RSxvAfURFKZXf83E6VQKRr4M12nDpFxqKC4RGH1uc1gNXqTAAS1YAJA==
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6f5ceb-5d4c-4a07-e583-08d84a623585
X-MS-Exchange-CrossTenant-AuthSource: HE1PR10MB1563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 08:21:34.0351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdBXo7nL25lp3g3uNkODb9cBtXfnlqkhTLJP0VW/f5Tlkf/hQFZDv+eyYYr28h7+C7k+Eq5pMpL6dhXY7kog/+dIfX8eMtm3xe8ftzGEBfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB1371
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KimpB4E1MpKi8tci5LEjZp2zx4520388AA=
Content-Type: multipart/mixed; boundary="Q5fPhEmuaTAWjdDGmzvc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598516502;
 bh=Q1FnIjdRLif0MAmdWTR8AJuzRj1HQqtn6ymX0LNk0do=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=bLis8ZXkxtInAzn8A78Z1SFseNVH3cO+IsipS7Mt7hB2pCYUDX24sOOmw3Exn5QAGrP
 wYaflxHE7g5IJFRf6tyypffrvQJAqSdBVwr1C5Vv9P0cdbwGMgfoDoFxwxB9NUQqEV6tZ
 2qfJGCmUQ1J2ZYdIYAITy22LSZJJfX3k2VY=

--Q5fPhEmuaTAWjdDGmzvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> Michael, Quirin, any ideas?

yes. I took a brief look at the logs and found the problem:

===============================================================================
Aug 27 08:16:05 ip-172-20-42-140 kubelet[2152]: E0827 08:16:05.109337    2152 kuberuntime_manager.go:784] container start failed: ErrImagePull: rpc error: code = Unknown desc = Error response from daemon: Get https://registry.gitlab.com/v2/cip-project/cip-testing/linux-cip-ci/manifests/build-v3: unauthorized: HTTP Basic: Access denied
===============================================================================

=> HTTP Basic: Access denied

Please check your setup/permissions?

HTH,
Michael

-- 
Michael Adler
Siemens AG, Corporate Technology, CT RDA IOT SES-DE, Otto-Hahn-Ring 6, 81739 Munich, Germany

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim Hagemann Snabe; Managing Board: Joe Kaeser, Chairman, President and Chief Executive Officer; Roland Busch, Klaus Helmrich, Cedrik Neike, Ralf P. Thomas; Registered offices: Berlin and Munich, Germany; Commercial registries: Berlin Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322

--Q5fPhEmuaTAWjdDGmzvc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5280): https://lists.cip-project.org/g/cip-dev/message=
/5280
Mute This Topic: https://lists.cip-project.org/mt/76423839/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Q5fPhEmuaTAWjdDGmzvc--
