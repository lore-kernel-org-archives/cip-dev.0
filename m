Return-Path: <SRS0=49Rk=ES=lists.cip-project.org=bounce+64572+5794+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208CCC2D0A3
	for <cip-dev@archiver.kernel.org>; Thu, 12 Nov 2020 05:18:40 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255952074B
	for <cip-dev@archiver.kernel.org>; Thu, 12 Nov 2020 05:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="VXeevugx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255952074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5794+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Hoe2YY4521723xC4cNzNNqFN; Wed, 11 Nov 2020 21:18:38 -0800
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.57])
 by mx.groups.io with SMTP id smtpd.web12.248.1605158316965970819
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2020 21:18:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuG9WqCHUQANtTYC8wUHRug5k0z57EgWW4x83scxP6oQpU5eJQc41EMdOYjasP7U013T4SmG1Fxz37DRo35Hfun7Pqr+MPZJJaahLOUe1MyN6qOASW7FgLLeQa03Ogs+ofrqygUUgdNi57Fukv8ugbWftwLfC/AbPnzpoYSuSsMF8iUrwZER7DjmcBvTadzwsTpTI/iYA60lk/m3UydT52VEJkpLQt3L5R0vFrIN4uRfV2S9Lt+4UrU2Z9Do+KNPLQs8hkmidLHSl5W9eaW79IjvEhiNES93YTgoUdAyAiKOtbTcMuT91TWWdv0o6gR1F4vQxjOB51YKhz/24sEruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI1YN5sEET1nxhiKCwfV02UqKLtjBAJ2738QDeFbi8k=;
 b=OFtIJyI2j3MhIgyZJMcn2YMxNcgQ407tgOsUIc/4EluElhYJRpHNISPqUEB8AxjbWU/Z3hqnNFPFDNRzJNiOCec/RBCqRB+HG/g/KlBPs32s0zN2nevFYfmz3a8w8jaimI9MybqpD8x4+KGY9ekVZRT/snq81mTKMJdU8cqzrLroCwK4eaENoBOjBhKqGuLIUP+kr2VOBSXKhzBt3cdcCu6VRgN+RKleOlhnau+aWMJI5FGjv++MGBK36SxvvWd1GiD3okreJxdA1wzfU88pAyHY7wMBbG4ol8o2n6MgeqW7P3OpjDmR05RkWOz9GH7WWMRHWH8b7dvaqPcyAm0gcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
X-Received: from HK0PR01MB2450.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3c::12) by HK0PR01MB3427.apcprd01.prod.exchangelabs.com
 (2603:1096:203:ad::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Thu, 12 Nov
 2020 05:18:32 +0000
X-Received: from HK0PR01MB2450.apcprd01.prod.exchangelabs.com
 ([fe80::356c:79f8:86b0:6e42]) by HK0PR01MB2450.apcprd01.prod.exchangelabs.com
 ([fe80::356c:79f8:86b0:6e42%7]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 05:18:32 +0000
From: =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Leaving Codethink and CIP
Thread-Topic: [cip-dev] Leaving Codethink and CIP
Thread-Index: AQHWuHBKjFAoKTV2dUWXMTuIZ2/JH6nD88SQ
Date: Thu, 12 Nov 2020 05:18:32 +0000
Message-ID: 
 <HK0PR01MB24505FD73F0E3BC9222A1CEFE2E70@HK0PR01MB2450.apcprd01.prod.exchangelabs.com>
References: <35ba5a3c63dd41c15f1cf63e99ba01e99316bce4.camel@codethink.co.uk>
 <20201111211856.GB2792@duo.ucw.cz>
In-Reply-To: <20201111211856.GB2792@duo.ucw.cz>
Accept-Language: zh-TW, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:b400:e265:14c2:3c09:b05f:1742:204d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e39fbd93-41ff-4377-8e20-08d886ca65df
x-ms-traffictypediagnostic: HK0PR01MB3427:
x-microsoft-antispam-prvs: 
 <HK0PR01MB34270BD15B6EBA0F4E44F6F6E2E70@HK0PR01MB3427.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 wAYMundgMSUBrtkgQgL/D+AoPkwb7Apyg5S04rdM34b78Q7p3A16fssAF/vmUwgUJU1W9kD1LD+ae/S8nFCoyZ48Jx/aDmJPXvh9kMZavZzx+GLaRkL+F7BRakVoC3ZfiX3Twh3FiT2LvhPwrQ6GW/wWFdwyHmduNb+MJG5wmpWwSpT+CaS0vbUXcyHWhBcjKKohKuj0eP65WGxSe5IfYWV2Oj6RGr/OH2OXUjYARR+95FcPMCQ0+Oc2WIOt3CK/EibGwQV62elbgcZgeWUk8sJpQrQmACrcgNvJk0WvFHFkKz58DRLtDq98fEESbKo5SAJ/MTVJL9AWINQrIb+g5w==
x-ms-exchange-antispam-messagedata: 
 2WNpVuNeweBzlaWjF+eK17gatjV4aXBUkrV8Rox9eCr4Qo9yV0LKpovUvWFkUA74mwZ8VJxIN12jBDmLT5R3VpQQqO9RRGkfl80tWRequlMQn22UyT1W55speHNytUa/s3b/eQ+f+m3mY88AJYyAZqsbNkCu2RqPkdpdtyWKSXHEPsfrZpszSEX7DlufsFENScaTeh3y6CC4G4BX5+nGM0A30NpwSQ/vQZ1v+hflUAf2JxOVwIVOWsNjVUMLD1izKwY0DhmC6gHB3kPXrqzf7hsCsK8FEKAcd3y8xA72MaYKOCfTrKxfI+VpbIzDJxZiz1t1s/QHmUswYGGACkcRm5hGDd3VlZmFvTYB3Kjn903+nI/y0+w6QspfahnEkZOwtW4oKid0QGdJdwYyhzcKoiFlGo7jA0AiOaux8esFMuOkF08VD+GExDWddMkLiOIYj0QyzIpoKPt+F+aJFjvUdQTat2/7qYwseXoB4IcfyTJppD9J58nCsu4Jgkipg3fvGJH+TS667iqwW9Y4tNf5W7MTEPAUCHLI8IRt7jtnYmfhxyqQa/T3g2093gGMscLzEIN3oJSX36TJjjDKxodUJbYIzH4dHggPAq4ChHkJ/89e/rUdWOGZBPyTI+O11/irgFUQaAnsEh9+Eh5Fvc4ubEYrDLIlr0hlvXkyJO9EA94iqa80/+3j7e0TLf0zNYdqfije5avD/x6ptS7Vbne1ew==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2450.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39fbd93-41ff-4377-8e20-08d886ca65df
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 05:18:32.2601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJZ0lpz9EZTuXe6z372KSrKKUE/drVAuw7isl/TAnXRXzlIUuQ7MbpOVirX+4l72
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR01MB3427
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: OXsUTT5ZkFmwZOKI2nUxWGUFx4520388AA=
Content-Type: multipart/mixed; boundary="xmkGMJsuiikeIzCrnT3D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605158318;
 bh=CDpBKixLt1mUeqocUyii9ReI2L4XuO2OwljdSO92cf4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=VXeevugxTgiFCk6ZRk2o7cPLeexHr9BD9NrSI31vu81MJnJ42WrN/U0uaEf6PJKaUxc
 CQQMLNKtDbMiy12IjuAW4lm3UXnPxNKUWRKhQdscoU+OkiDNMrgzvxgJyCCBVYPAa6yve
 VpBnuqtn8qBGRdRCD0zX4S9M34MKHsuYz0Y=

--xmkGMJsuiikeIzCrnT3D
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of
> I will be leaving Codethink next month, and will no longer be working
> directly on CIP.  (With my Debian hat on, I may still submit merge
> requests to the cip-kernel-sec repository.)  My last working day here
> will be 11 November.
>
> I want to thank everyone who's worked to make super-long-term Linux
> kernel maintenance possible.  CIP has a great kernel team now and I'm
> confident that you'll carry on doing a fine job without me.

Thanks to your massive contribution in the past few years, I cherish the
memory of working with you and wish you all the best, enjoy your new job an=
d life.

I believe we will meet again at the conference soon.

SZ

--xmkGMJsuiikeIzCrnT3D
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5794): https://lists.cip-project.org/g/cip-dev/message=
/5794
Mute This Topic: https://lists.cip-project.org/mt/77850039/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--xmkGMJsuiikeIzCrnT3D--
