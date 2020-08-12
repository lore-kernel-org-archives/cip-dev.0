Return-Path: <SRS0=RGaL=BW=lists.cip-project.org=bounce+64572+5113+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD807C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 12 Aug 2020 22:37:27 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F3B120781
	for <cip-dev@archiver.kernel.org>; Wed, 12 Aug 2020 22:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="AOJD2z/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3B120781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5113+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LEsJYY4521723xfu3TQXw0xj; Wed, 12 Aug 2020 15:37:27 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.105])
 by mx.groups.io with SMTP id smtpd.web11.1261.1597271844898077495
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Aug 2020 15:37:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJAOsGNolwsMM0iN5fHf0Ddu9eEviscI1xlt53z4UrNPkr/tpLxk3gTwRYclpaEHIk28QLSm/EtN0fa0TIYx2OnXX+15cRpV9Su7lC0tKxd7lSo4DUUfj8BdmcD5VQ37bWkrCbIRXuc+kLJ+alnKwasGIbkO2zMGzDDvetilt5qDMPV31BFS2ornOD2Koa5pu3dbB/DJ9pq+0/g64ycw0aopDxXmtSlVJ1bxKYl5dJSFW7oSa+5geTyI65t278X1CzrQyUeW8EYXIXsVIF8iYVM4RQkLEy1dLLi49CB0pmjvX/Zy/c8s+FVu+m21QWe9gjnoSlf3dKQZACmT50KVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJRd0iijqUFXLNwddNP5UOkds3BbLA3eMsC3Q9ZJ6dU=;
 b=B4EKUzRdVv88Gq+y/0NqWtEkcm1vWuqw+u1y5uUMsPlDyHN6p35N33fUTXELFhUehj1hR+pnE3POPodorCiVk2eG0km6vPM46hu4neeARbEky0brNfaKKUnA6er45Mguw6BjBQmSTX0SUoE8wcCo7OzaZex3I7PcpiSlAVroW4/52cEjPR2yLx/ow5J/LcGRBKL71iyLiK5ZT1wFPOQ9rBY51Exbrl7wa4MGIsgyxckyRsykoILmL2AB0A+vIQ8xlCB5e2+J+PlExH/5NiTl8R1Q+ER1/EAIm34vpDFpk/0hRb3YwOb/lLQYtjzMq8bc0NtSJ7s060o48zNPSr99eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB5369.jpnprd01.prod.outlook.com (2603:1096:404:8034::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Wed, 12 Aug
 2020 22:37:18 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fdf6:bf77:e369:aa20%3]) with mapi id 15.20.3261.025; Wed, 12 Aug 2020
 22:37:18 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] There is no CIP IRC weekly meeting today
Thread-Topic: There is no CIP IRC weekly meeting today
Thread-Index: AdZw+QDsiW7Bd5kgT5e7PaumLRrrVw==
Date: Wed, 12 Aug 2020 22:37:18 +0000
Message-ID: 
 <TY2PR01MB497212D43D6F791B89DD6CFAA0420@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0406bd35-2eec-4b66-9dea-08d83f104565
x-ms-traffictypediagnostic: TYAPR01MB5369:
x-microsoft-antispam-prvs: 
 <TYAPR01MB5369D660990F7BEB5278981DA0420@TYAPR01MB5369.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0406bd35-2eec-4b66-9dea-08d83f104565
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2020 22:37:18.7850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fGXpf1c1pH0T1Jvy6AhhOTfiT6zaewpsq0fKN/IbP6eGmEf/ei6dSEpSvDesmDFbMvqSkaZ0/8OjcoiKgVCE4/BCy9rguBZAjVBM/RIcxSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5369
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cFVThRUcoVbxGRA1PWmu2ZkFx4520388AA=
Content-Type: multipart/mixed; boundary="1cZOR8foav54rJS1di3m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597271847;
 bh=UhgoYlZTZbNM7QQjzkdBQDslzeys0k4ZHM9to6EUPrA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=AOJD2z/VISS1YaLrgp/KHdmaFPr3tTOUDA82WBZ/HSHOKd6l3KZwy6IpF5MWnmNzLep
 jqisxZBsP32cIX+8WK+YPd5IYyKrzkeWdd1KSkGMfosggBn+aOXsxRi69zto1fPBbntiV
 jDxXv+vBiulGrn0rNjReC+lBJRyQ9hOx0gg=

--1cZOR8foav54rJS1di3m
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi,=20

As was discussed last week, there is no CIP IRC weekly meeting today.

Best regards,
--
M. Kudo

--1cZOR8foav54rJS1di3m
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5113): https://lists.cip-project.org/g/cip-dev/message=
/5113
Mute This Topic: https://lists.cip-project.org/mt/76157181/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--1cZOR8foav54rJS1di3m--
