Return-Path: <SRS0=oxwG=AG=lists.cip-project.org=bounce+64572+4812+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8216C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 07:03:37 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CACB206FA
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 07:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="nxTrJY4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CACB206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4812+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NdcVYY4521723x0CGYg98xG4; Thu, 25 Jun 2020 00:03:37 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.112])
 by mx.groups.io with SMTP id smtpd.web12.5220.1593068614981774402
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 00:03:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fepTw3JuThnTFegbUWHD/7ukggfcnlt6XOTDC+W8Fj8jIR0wrrAWa0jUUfMvkVkksn5/9dH7UJcf8L2cV0RzHuAcSw0nnnOZkIoBg8A7qNGWVrSKkSPu40B4gjcyMmbnTqYGhlxOjmOb4fV+xr6OUwRU4NqzCdVfofrlTNWX4Pz4ayGZw3+1th7TWpqGQpKZZXB7j2s6Xx0TEX6C9Ct2vqRUtjgV5aWj5mCMIHdUJjyYfXOoNh66+gAQGUyoB0ttGojWvrYoaYwGXfgcP5l/6VmdZ0jcafJGdbA0yWdmXSMmZ8nxC2beRGVSpVwHtNnNl+oPFgi/1WIsGQPwO2//9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nh2ER/oZXnREXhDtjPr93H7KXs9/YIngNdrOTezihEc=;
 b=fxQNIG+cUVkBim/3y4/voG8kGyfEuh9UXyNO6jXSTtpKpq6jkdGW2jj0/VxcBFKTQkShHOMJAItBiL/DstBIdkwIklCfq6k4G2iwqhlYUUAy9QjseS8ZfSSgPW5eJmXE5R79B6+eOWGEQqUCWioVRiZX06UblwN2Ll/3opykjKctTNNY2y6YGgkJ6m/KCtvT+LvuvikjgJSKWhqGRebQiT3mukZHWEsVH1TS164HAxrVFdwlG1VFH7yA3fgZpEWHFUuE0LonSLdTSd/ckfysDyNATlkjmYpS1V8NiScatNUh8eJws38vm9arS5SpcQVDza2MP7TSOIsz6PL2ZuvX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB2266.jpnprd01.prod.outlook.com (2603:1096:404:12::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 25 Jun
 2020 07:03:31 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.3109.027; Thu, 25 Jun 2020
 07:03:30 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: [cip-dev] CIP IRC weekly meeting today
Thread-Index: AdZKk31OU14dTGSGRCWdR+Bw6Hct+AAKtzOAAAAKBgA=
Date: Thu, 25 Jun 2020 07:03:30 +0000
Message-ID: 
 <TY2PR01MB4972A225242DCD4D0219F3B2A0920@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB49729620B56F4A404F4E709AA0920@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <20200625070047.GA30576@duo.ucw.cz>
In-Reply-To: <20200625070047.GA30576@duo.ucw.cz>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b90c20b-1933-48aa-fcdb-08d818d5de46
x-ms-traffictypediagnostic: TY2PR01MB2266:
x-microsoft-antispam-prvs: 
 <TY2PR01MB2266C48D6400BEA7F31CB7DEA0920@TY2PR01MB2266.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 aB2ykIKZlzTYy9HvjLb8yQeOrgD/cruTJGLSGoemyzEa3cBcL939yVU/pXhx9grOTNSDdMey08e5rpSjOxnutiqidPhMBV6ILu+iYhumzYx+mpjTkKGLyE6QE1ljcyWGCV6zAcW+ubuMzwhTnAvswNM1evZ+ZacQfc9ocKeJTV8TdGuWNkk5/oy7rHA6jLwt+foE05yH0eYisVh6DrxyPt0So5Jl2wNVoa+kXv6uR45l2DWVgjaRIByat0iP3EsZBkZWS9TkWfBTYZjlrhj9V6JWJXEJTXWZOo7q+GXaOoI8edyZOuXq7MXRAJBzxh9t4hp62330XcsTHrxqAI9LQQ==
x-ms-exchange-antispam-messagedata: 
 0zXaPku0EahxfCJJ335a80S4DtnbfP1YrVZivsdUuC7/BR5279zGVxHq03EpfnNszlMFJYUiVZ762hXppPqFcMhTQzgSgxHUJ19ngVtDKCLG7nxsUacS7BW2BrenPfZzSmTqkPQyz4xZ0+iKvQS0R0oxk2Gtvd9IbEiQMf9MH2we4+AWhXFfemlzIoOSJlA+XHl62wbSibFDP2E6DRMdHiPIwR94WiEd95M5k2+eObTavYNG129unLpxrR/6ocMVDQUlCZIb9ahA5mZiRDdTHAJPyX4D/E6oRVEPZ6HD9d5pX7FLkSG5awlOV9qjsQ3uMVWgMtgcdSxodYQhizd96nMGz5HJJEGLvTy+ai2br3C9xKwjHYWQSnKzRsSuE5pKmDfMvwaomDBQ9yXQ2bOXQnDfHZVto+Fr370Zqnfenoikp/u5YU/Qb9AJ8b82XbxprcQLD0gnKjujxoOUga60Nnn/EDGRWi2CfJMHnXEVBva82ZvQarOAs3Txkuk+xEUY
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b90c20b-1933-48aa-fcdb-08d818d5de46
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2020 07:03:30.6341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tyl53URAIebsahORFVMg+o+QQrckOexEVCh+9xcMbKnH1DwARMp5kMkmBJeooQMfHhC7fC/MIHc+Rg6Jur0SKsy3nz8uo/wSsGP24kbc3rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2266
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 93QFBw46hJbzyjVp5Az17vsax4520388AA=
Content-Type: multipart/mixed; boundary="JCqf6IycFuMUFJinHyJc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593068617;
 bh=PD+BzH6gDPEpJko8/GMr+7nHipwGPqnIK4hKh1/ZHGQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=nxTrJY4+BicswC+tqFoGIbWJrC3RKOL+3fOt2CzTwOG0P5AL0f81/cE7XxSmPBJ6jHo
 d3mubrZ2IF06I7kDrm4mcVz5OyP3BJD1SWjM3sB3zT417KyMc/+7BYXaoC/M0/pW6atII
 /77+lXh6izkfOy/Eo7RlSSz5nGgeIHQnod4=

--JCqf6IycFuMUFJinHyJc
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Pavel-san,

> Not sure if I'll be able to make it today.
> From last meeting, I have been reviewing patches for 4.19.129 and 4.19.13=
0.

Thanks for your update.

Best regards,
--
M. Kudo

--JCqf6IycFuMUFJinHyJc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4812): https://lists.cip-project.org/g/cip-dev/message=
/4812
Mute This Topic: https://lists.cip-project.org/mt/75095440/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--JCqf6IycFuMUFJinHyJc--
