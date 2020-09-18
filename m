Return-Path: <SRS0=LANN=C3=lists.cip-project.org=bounce+64572+5464+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ECDC43464
	for <cip-dev@archiver.kernel.org>; Fri, 18 Sep 2020 13:58:14 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A9E23119
	for <cip-dev@archiver.kernel.org>; Fri, 18 Sep 2020 13:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="USRkoBFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A9E23119
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5464+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id R6uXYY4521723xkEkPxWnLrT; Fri, 18 Sep 2020 06:58:13 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.123])
 by mx.groups.io with SMTP id smtpd.web12.13400.1600437491198525108
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Sep 2020 06:58:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KepzQtd1gZtQz4oirArxpHpHdtJdIMfg02t44Btfyx+AGnfjETDAGmkP7/BVbm2fWVeRd1HjR19Onr5Ud+eiOL8yy68fCLaWlBBs8q6/DBjNZ1613iQAIVdL/n6EMd32fulxTJLpf7+gnw4DTzse/ZR8HAABrVBItTVdtnYMhz1M6DsqvG11oym0NHqHsse//QWxBaR6yO8j+rqSyq0+4nqMJ/fnW9Orj4Uq1W7BwAl3fdE9HS0UpFIDy6fZZjcknLQSvz+OvcZkPmP3kKsROF+nccedgeKM1SDtboAujZlNBtsxj52bKZCcizFwJLIxKxnhSc8KncDu65EieuxQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yk3caIo7hbh4CNeTs9alMEum2USZLBsz0YeA9d/SaA=;
 b=XrFLv27RYJXZrliyrZXMr01eS4bqILGzmMrIp2oyo1s25o7zlyUMz9PXYWeRuem3GIZGqa6Zf32TJKafLl5GyESPDOZoU/h/mzaNoXVwqfEQ2wTWU89PR5CQwQx05xvnWoExk7BI+67CP2TZGZSUMBOn139Okvj/flTaPkMXgY4bWwLdtJ0zI9MEFhjJIb2QkPH5fAlg1XO1ru1q4KG+BW7QOuGdPc8DF03AJOfYrDU7nh7zmaCnkV5o7R1NQ4t8Fvn0Iax3auBHweV4jM0jpLumRc9wGw9XWUJt7a7a2Q6gI7HM5xheFah0Vhly7YGFbL2t172kwKB57XOWB1fDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY1PR01MB1659.jpnprd01.prod.outlook.com (2603:1096:403:6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Fri, 18 Sep
 2020 13:58:01 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::141:efe3:1485:80fa]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::141:efe3:1485:80fa%7]) with mapi id 15.20.3391.014; Fri, 18 Sep 2020
 13:58:00 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: [cip-dev] Is CVE-2020-25284 backporting needed for 4.4-rt x86?
Thread-Topic: Is CVE-2020-25284 backporting needed for 4.4-rt x86?
Thread-Index: AdaNw7es631AlWmyTOq25QxHZpRfCw==
Date: Fri, 18 Sep 2020 13:58:00 +0000
Message-ID: 
 <TY2PR01MB49720A7CA0EC8E349A473CFFA03F0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 102ce91e-a1e7-4e14-4570-08d85bdadb19
x-ms-traffictypediagnostic: TY1PR01MB1659:
x-microsoft-antispam-prvs: 
 <TY1PR01MB1659AEB6C686A925998AEC42A03F0@TY1PR01MB1659.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 LEg6yUsKgAPn6d+XGeaTBJ/fA84pp+JKzahovrPgQGws5fJNxa2QRwe/5y1GqBFC9kfdd2e7lg4mPV1uxLjWi1E23xjjU/82ug09ENwM5dG7J6xtLbsj9B532sYtqJrSaWpETtWX8vJDA7HqBQ9sy8rHhkUD1bnuV6AvIaaBGaZ5DqjN7yfjJ48St7b4TW4OGvSSKZ74nFU9VD/xBc9KpMmhFm58iq5DiQDuxu/J7r9hay0+jXdY5f226iL8b5niLzJbiP4bLC/GXKx7sFDjdZbPs4Zy1rVOOLIVBSE6xxAW1EbZkriFZNHSIudL9wrqY7z9iTtGObJUHbX5QRppFXpg9e/2fbNe7y5colGOkLw3k5bww/Ck78Qs1aSfWEFabrTpOARHQHFEp1q0k7sI5Q==
x-ms-exchange-antispam-messagedata: 
 08YOuv1fTK51+0cp3TwlMxVcu1RuV8MwuqlO5tw6chtP4l4pMau97tsmXEiWIOtnMfDkQhVSVVsiYElQfVj2KSob3zDS4HM6m9rFxrxGZQHNpNHKHGana9GjQKbG+AErf6uH7fL5/3/7av6pjlkKMzuW+W7i5pLP7DEHTHjH6Zu6lSYtXEsecYFomhM0lPO7AEYbZ7QW60JBYloL+hor/8Wv7J5UJ9WDHIROrDJ09258vIaJrL36NrV3+Qa0BMqHF8A6H0w4SIKskwO/IUsW/bltkzx79qaTM9IMnR0xVD3kRT2GVZSEfny8x4gxz5QrCbCs/cvbZG+s8vl8HqZG8fiVa26/4HK8iUrQjuV1+2wDHqO8gdVbM7QdPduiO1KX0DGgFYUJwG82iwo9A1J7VaVrk5EWnlKSQNw20HyhIoexFI/6k0ESgk2bWxC967ySvjVlhtIPASe4a/w4ve1/50Ws38Vlfq2nFN6nK+ARAJESfWT+hlvGhBPFei1oxS8TceGW5xSldOZaCMiU/urXUfDG5bsyOXeuUUoQ/VZ8Nfie5M4wYdOvIGajAnFr3Z3UaES8Q7Y91/7daHqEpHRmRFEiE4tVfeiX9reUtU03oxg6J88mpgIYRUurStnyYaLEciKYzQ9i+MizVcYmaIowXQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102ce91e-a1e7-4e14-4570-08d85bdadb19
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 13:58:00.9180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i1OvtW4yCkSYbe3zbXC0PzDZ1s9qdpAdS9CIibAW//SFtVB83SZ8uYHENs7uVWA+0OBtK1swVsbyzEJuU5b2d2EvxRyKDdXsKbeWz4i3u7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1659
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: noL3JxRE7O09UBnU9jVl7VVKx4520388AA=
Content-Type: multipart/mixed; boundary="fzE2eQ32aiZpYdmY3qcQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600437493;
 bh=CJ3nqgs6lBc3eZtVP78Pi818Dc6r6daS8026GcwNoKU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=USRkoBFuDtG6ZlAyOUz8aVmMQJUfwyvGrDmDTXwamNIDCbJyqqF7E/0aPlPxbpJVkmm
 XQmxX2cMyxIa/PN3dxNiZt9J8grKxwDO4EOQBlWtlQRZPeRWY3gR6xI5niH8R+oc6XgBP
 WKj+wUWgRaO+w0BKe67JoktCVB9zDHWzsKs=

--fzE2eQ32aiZpYdmY3qcQ
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Jan-san, Siemens team,

There was some query to Siemens about the need of CVE-2020-25284 backportin=
g.

- CVE-2020-25284 is in rbd ( Ceph block device ).=20
- it is only fixed for v4.19 and later stable kernels
- Siemens has this built as a module in their 4.4-rt x86 config, but not th=
eir 4.19 one

So the question from the Kernel Team is whether Siemens needs its backporti=
ng to 4.4-rt or not.

Please take a look about the discussion at the IRC meeting yesterday.

https://irclogs.baserock.org/meetings/cip/2020/09/cip.2020-09-17-09.00.log.=
html

Best regards,
--
M. Kudo

--fzE2eQ32aiZpYdmY3qcQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5464): https://lists.cip-project.org/g/cip-dev/message=
/5464
Mute This Topic: https://lists.cip-project.org/mt/76930681/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--fzE2eQ32aiZpYdmY3qcQ--
