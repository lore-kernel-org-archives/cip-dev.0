Return-Path: <SRS0=5yvg=7O=lists.cip-project.org=bounce+64572+4656+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BCEC433DF
	for <cip-dev@archiver.kernel.org>; Mon,  1 Jun 2020 22:17:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078FB2073B
	for <cip-dev@archiver.kernel.org>; Mon,  1 Jun 2020 22:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PB/zkXmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078FB2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4656+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ReuEYY4521723xAEHzwOZU9H; Mon, 01 Jun 2020 15:17:41 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.95])
 by mx.groups.io with SMTP id smtpd.web11.49398.1591049860085298486
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Jun 2020 15:17:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOyyl6DGhZvJ4JGOvsdp6KSwLJ1pmFqjAW9wUYMjOjNvWe9XgSaaqM8blXeq6IsUVR7mpLk5lVVFKtQZb/EiaY2sDKp99Tw4TPden8CvTWn9yhjkYEdER0pFCtyihn9Ozq2XnPdYzP1EaC58pDR21oUKeX/cldfPqDCnPlHDR7ClYpXKyknpHZloKdtkWv7/VFhKumRLEGy7ypjNrm7MgSlmPe2Pfmx8Ma+hB9upSl0FAAXMzCAynMnuxOdZmZKGA7/jOpzjs7qtlljxVkNnDHoJFanSGI+M8JpJKFhRiDITChTCiKC2iEm1SmGtPV9f7dG/kVaoVt3r3eclacrkpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpYOj2aQeyfLkpcckujs0516uTsVmY70R5nBdN4KCg8=;
 b=I+FXpqtGB7yW4XJkBhddL5zWkfHTaQ83sHYt7ORrQuo2OT1DHY9SCMJ2cMyvXqq/5ISt8HLsgCSxAFo3bHMonICPwymA3Q9uwCt71vAutrBliMXE8Tu8n5BLGAildCDAvfeEwZolS+zV7W7JJkKIpoEJ3HeONfmo5rX8KpIc383675Wd0nXiubKHC648dsj7dJbkJFOLljsVSZ6qok3TF8nEMreeOLvAF5n8pMQ3DzsynIYnQrhRUw6v3mrTDY2HutGPll7CZi2lWj6tGFeJ2ZtfLmD0pyveZ6KEmDBSnb+AAmCQ7bZEHdBQ4ghTVETR6IU3q/IY9btPuPUzqQ3q0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSAPR01MB2178.jpnprd01.prod.outlook.com (2603:1096:603:1a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.25; Mon, 1 Jun
 2020 22:17:36 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::c44c:5473:6b95:d9fd]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::c44c:5473:6b95:d9fd%6]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 22:17:36 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "SZ.Lin@moxa.com" <SZ.Lin@moxa.com>
Subject: [cip-dev] Kernel config warning
Thread-Topic: Kernel config warning
Thread-Index: AdY4YgxrtHSDBaMZSpup0T/oNPPVRA==
Date: Mon, 1 Jun 2020 22:17:36 +0000
Message-ID: 
 <OSAPR01MB2385ECC888BFA203140CA3CEB78A0@OSAPR01MB2385.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 95a354be-d2a2-472a-79be-08d806799715
x-ms-traffictypediagnostic: OSAPR01MB2178:
x-microsoft-antispam-prvs: 
 <OSAPR01MB2178C59A9D7328CABF1DD62CB78A0@OSAPR01MB2178.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 sogDlPPrkMhr4tKAxpa3vVOD+fbJqbmvHxP1E2CNSwE2l0m85vtkBKCMr43LN0Yt+2EMEJ4C8HuHRjtO/21ncqD+CgYz21667TYiwNyUqXUAJflNPQD5rlLQwGIt2btRC14e+3r9ALoYBp+SjI9b16ou0tB2sSus+/WPL5vVjy1zg2v+l4yYYbzMiIflX1g7ctIUWkawsrxC9gqZM+t8Lol7+zkH5LjdSt8zIt67nFfK/y6i43c0izj8yvbwUpmXk0s0HlRPQ4bocizajszaPptsdDzTtM+vC8AqH11bi8BW8L0VLPbGmgO4PqzLZ87YWs6rl9l126uNjFkXwxwb/jvJzeODqVifzQ0Sf+qpjUY6/VOfy3/7ZvNAPZ3mRdld18vafRUyV59xa85L2aVcjw==
x-ms-exchange-antispam-messagedata: 
 xTQGKABg8Lap4AmI6GwHmO01aAsLHDNItp0vAXBR1WmPhwz1rmoLh4m+D9nLVMMhgOR3JPOwd4loTnwdFo4i9vyyE4Ja86R+QUfIP1KKXByknr++UWuO558C0kD6ugnzcfAvCCbnDcmYuWA/EJMJlGJfclWPqfepBF0TPdv9QE0zSNOeDm/nskdFjiRrMgj7IG/aF3CgXO+euldDGUIOee6FCQULFOzLZQcptZ6mtTX96CcXqYM4WgnXDpTKxFJBIjjs1GMSjkW2kpmMVvxdA9Ac1XCtHqsYgCsZL2eXYseNwqDHHVw/VGsZipmNgDYrnemrxkK605w8gG/Bwp8KiGdMcrCfxkjFGZLU5V+XVjbHunepBX89RwcvhVzgJ1PVuC2tuQbW6d56NBy28aqMLHpZjpotzaNZSsaiDv97bxI0Sk+m1Y3ZH8CQgYDwL9/W+oYp8hE7R4rk9MVoWazO8Rhf/b9AaE0sstzsZxOGIGvSXJGrxFCcaSZS90JcNcBr
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a354be-d2a2-472a-79be-08d806799715
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2020 22:17:36.7052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L3uFSdVHwmGx4bnIVW06qhZQnZiZtbc4rZi2wkETFSxwy86Jonx4iOlW5nijt9uJrX9rsFBime/rTTiQUS/aaCYft+LffGvHqaBNnF+THGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2178
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: MWoUUgA2EqalxwPF3AUaFsD6x4520388AA=
Content-Type: multipart/mixed; boundary="vpsVeaJOISorwlSqssGc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591049861;
 bh=MeYRQMu7iWeXvk7MzXO4cpB18jKQFjr+Aru404irvOc=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=PB/zkXmDIIueoo8vwC0T8TLkJcIWZeKTD6zAtkeFqBXAaiHw5CwuOVryTRc9OCzdet7
 41o9cgUvmcV8GAilToiwiOLJA+9ygd44WPP+JzWhrMqSl5Ao98OEEA9aDIbkHXJJ4a6G+
 tt0oQBHqD9BG+X8yoY+6hXzuRtlqhHtUD/8=

--vpsVeaJOISorwlSqssGc
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Kernel maintainers,

I saw this warning [0] by chance this evening when doing a build with the m=
oxa_mxc_defconfig [1] Kernel config.

Is this something we want to correct?

[0]
"arch/arm/configs/moxa_mxc_defconfig:745:warning: symbol value 'm' invalid =
for RTC_DRV_DS1374_WDT"
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/546065688#L129
[1] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/mast=
er/4.4.y-cip/arm/moxa_mxc_defconfig

Kind regards, Chris


--vpsVeaJOISorwlSqssGc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4656): https://lists.cip-project.org/g/cip-dev/message=
/4656
Mute This Topic: https://lists.cip-project.org/mt/74616319/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--vpsVeaJOISorwlSqssGc--
