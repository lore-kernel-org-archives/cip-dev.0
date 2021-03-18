Return-Path: <SRS0=zIIZ=IQ=lists.cip-project.org=bounce+64572+6292+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EE9C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 18 Mar 2021 08:15:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E14664F2A
	for <cip-dev@archiver.kernel.org>; Thu, 18 Mar 2021 08:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E14664F2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6292+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yo3xYY4521723xHjLdMnfkGR; Thu, 18 Mar 2021 01:15:10 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.101])
 by mx.groups.io with SMTP id smtpd.web10.6004.1616055308666504955
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Mar 2021 01:15:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m86FKZVkTL8HOxY6XdI+B9LKXf4uzsAZItN1dxLKH2wHLYdLSSITKszg0nHY09KsRPiVD5VozZZJjFAompUh3BOtdqehuxxFSQSCxa6FN5GuPOpksDSZIa1GQwm3gs9pWYcGn5lfH8S8ptKWpWzU48nmc5FN9JMGC72Qtqn+G9zz/XzNVcQphwg8kjrP5sBaLTwN0l7eSfDnL+b4C+YRvvDNzAFZL7SpepmFNINOUw3B1wPw6TMbTMj9qAYHMTPducpv8yL4SJaVC0HJJoZce1hTPbzEyvYILQhPoKmw506UORZsYn8rfi1FvF9pPQId6xG84Dehk33XYumNpg8iEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtbjNDZT7z20cq/dRtfIYADC7AZo8PAzKGSUzb8nOKw=;
 b=RBVqrIvDJEy6eSjdE1OCw2RlyEhvS3BiJznRrCEUncY132L59ozf8B+OpwC41VhRmCPb+BgozjWvyBYajt4wTV6BE4lEIyA1PlxZrrJiU0QqoyJ4Fm+lmzSFUb7e0RJaPwQmQg+nAg/TYbyYcJCmXuMHwHZ9JIEjAgd0epOa0l80tcxKk4ZpSuelancQq1X6BGg29j/TCdsfXq324bWj0/XlNyMdmN8w7Bo3JftATO/V37ZDKmVwbnFAJ3PZGv2BgyKsEdZfikDZHOxOlBqqGpWwO8MGdQob5Y5MMOP52ynXloSICSS4yg21e+etdMxgNfa78ZvdCxpc1LH8EzZGvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSBPR01MB4471.jpnprd01.prod.outlook.com (2603:1096:604:3a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 08:15:04 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::6064:8513:28e:374e]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::6064:8513:28e:374e%7]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 08:15:04 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"cip-members@lists.cip-project.org" <cip-members@lists.cip-project.org>
Subject: [cip-dev] CIP LAVA maintenance
Thread-Topic: CIP LAVA maintenance
Thread-Index: AdcbzkOQKf6QAN7RRByXfiJr+ZwsYQ==
Date: Thu, 18 Mar 2021 08:15:03 +0000
Message-ID: 
 <OSAPR01MB238522C00004CCA9A600F559B7699@OSAPR01MB2385.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.129.175.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e7c1add2-dc9c-4f1b-9816-08d8e9e5ef33
x-ms-traffictypediagnostic: OSBPR01MB4471:
x-microsoft-antispam-prvs: 
 <OSBPR01MB44719B77202A752632A7EE1DB7699@OSBPR01MB4471.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 22Y8uTh8N41MNXVZWYM6oaitvJIRFHOsbB2Ch5l0YzIIWiDlXP3I8VY5IMktzbfwSV7Myo8igSkACDnzi2ACDZjli+HY5xOJteu4fYtmfbyqYcI7ApBQurtEabTN3Exe/ivFMaRhOPLHgefKBOKAtI1anXZ+DezujOChG4V89CVd+8TY1fU1PEkeINnmg1drIZW84nK5OX3axNan3RPC9ip4Ro55EsfJCj68Ls1Ez+VsPPWQkWRjb9tHhMysFu1En+KYCtfe8g3C8QMClGsI6bnjaYtv7Y1oYpKe3xqRGDXVJSfztkXE3fOs7HQ3LxrIxZaWNtr9oM+C162UGHjWcn8INZMT3ivUD5BR+mUP6djrOdyNksFSclxKF7otXcFroOAIFE5hzqFqK9dqLZ+UuOTdCFifHC+zWtEyGVPPQap11MNP+yweVtnBML+pQ//7QvuxKLaIp6DkSKOgrIE7axwU60VGeB3nQ0SrJel34MVeXao2ioPtvscqF044E6Ds4FyIRyuI4i0pg67/MWMRGJ2RujsKC2SDYUviVjcFTTZ2PPShJi8GViZ+/Ya3/s+08LYJb4l9Bl1dTf0bDKXwGT9W2/OsG411yyW0U9sAY8QCjTYzyxlA2ni9fOhRIEIy
x-ms-exchange-antispam-messagedata: 
 =?iso-8859-1?Q?hVCU0fhpo0obUn02lmt8IqTXTAfgHJbDdaUVHvw48yN3HNVKGjLUrd7JY5?=
 =?iso-8859-1?Q?E+OsBtqh+w9AloX1ncIMlmbuuX4Jsi+Qh7GqLHffRcHnQm0qyuwrQty0/J?=
 =?iso-8859-1?Q?wO7E/JagbomvjLEyfYnevFYGCLi0jbw/cA8v7RmRVH1QawPH4KK5KQmwGV?=
 =?iso-8859-1?Q?hzaqNqwBbpsd3ucATL+SM251cJMQXjTbn2D0xC6mMeXLP/d9BjPXMe+qb4?=
 =?iso-8859-1?Q?yqxKKS6/ic5PUGkIIT78BC7WwQIqv1rb5kzM973vSeJjZX6R0Dexk8WDmf?=
 =?iso-8859-1?Q?40RERMGJcye3vg84b7GXWisTgPS5jqXBUWhhSyHET6dPH2xZsJ8LpJVEec?=
 =?iso-8859-1?Q?AhNDRRtJInnuJxQ/P/96FlmU9A//NM8OqklYxtXpMRciWAhpWnokiDWbAc?=
 =?iso-8859-1?Q?419vvCDDsGHRwQRv8aqkaWl8XIeY/WavurwowIBXIPWG+emr/YEPOdLp71?=
 =?iso-8859-1?Q?YlUxwv4jXedLHpVaYb0Oz8nXszPE1pn7ymJMUiwfXmueBh6CDjS7zB554J?=
 =?iso-8859-1?Q?O5g4f+yBOvQMBgLNz153m7Q8PoGYb5Nq1KZFm93QLXjouf2PkXCNV1FZHl?=
 =?iso-8859-1?Q?T9/F9SRt+lPSJ+nLgcH1VaGa5XQfxbRnZ+3xr4ByScKJo8patPhEwtBUjn?=
 =?iso-8859-1?Q?h12TfnQFO/SJ341rABlbFB72bwgfylU5dcJ3t5MPSP4vFFwa/uOgne/UEC?=
 =?iso-8859-1?Q?XHkntGf3OAF/xtT2miIwYsVhzPLsZdCPHHBCa2yVpHBiz4nYH1LcA1Nn14?=
 =?iso-8859-1?Q?bLA9XLOJ1lHG9oTbLp5L3HfC5LIwPZew1wfse0l9yCIopzi4vRhqj47swo?=
 =?iso-8859-1?Q?AawawyFj3wKciXLM0jr6C71n7N9v8gFfUdlMpI8pDA2GfP0y5QtqUEcE6J?=
 =?iso-8859-1?Q?d+QTOU5Fhb4Q6JNzOfeR6x6o2FCnp7gMp1AYUdhQgdYU0TAzWKpJw4a2MT?=
 =?iso-8859-1?Q?Z53sazVChrB3v49yLumsMZCAPVDbn8UA+qjAzcNW6QmHvPWXJktUjek010?=
 =?iso-8859-1?Q?4wP0DPQCduI1rSb8sic9O0I38aykUeYr5Ml+PSjQYKxzstdIlAgp+ULKjo?=
 =?iso-8859-1?Q?KLzlKyRTsswKwuKyFQez5TiXksebH5moIt8g0n2EgR6p47ZFnYpBEE9bzU?=
 =?iso-8859-1?Q?cYc5XpHSO3Vb8+qeK3AM/jgLQp26oYeua8dg7PjfbkLHbh+uMYvbbwCizW?=
 =?iso-8859-1?Q?vBLME1hbq9CQUbDmH3uARzIQjfgQh5m5fQqCLTYOIel/JBdK287+ZtUVpx?=
 =?iso-8859-1?Q?a3pAQAHtIMx0U2/l522WRB33Lb4D2zheITOxOx2qayQJ9Opf/Z5S2skHgE?=
 =?iso-8859-1?Q?dbgo3S2BFDMwUQYpH6LikrfCXkTyAXYK/gsjR1eZneHDXVICuNe2EnK3gD?=
 =?iso-8859-1?Q?j5XiNuxYgm?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c1add2-dc9c-4f1b-9816-08d8e9e5ef33
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 08:15:03.9955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fvOnma/sgbM8nhv791yr5WnJ/nNbRHVR6vjnC8tO/WV95okQ0AuBrqBepOtG9tVg0Gir+neIlmBiRBJUi7vGZnTMzXvPUbrBYRsvTf2oD0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4471
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4cZv2rO8onsHjZ9sXxB01I5kx4520388AA=
Content-Type: multipart/mixed; boundary="AsVN9amHdZCoj0WmLUP3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616055310;
 bh=QCEl6B9hjGn7RNINhFivi1eivaAYiBqid6BdEfIEJDU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=rHS4Ek6n+rlUU8WMZZoreTUp41LVYwQnvixDJSzYWZhVutMxQ4gz523pB09BuRzVQZ8
 lvRMeilwfV6GiWwIL/cKXshV7zMvlJl/A8nlVs9f8soljJCTJ9358+vhB8R8jifiQPGmp
 +HT/eFa3mYztjZ0aDk7dyDfSDG/hdmHHwQA=

--AsVN9amHdZCoj0WmLUP3
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello all,

The CIP LAVA infrastructure will be going down for maintenance very soon.
Upgrade Gods permitting, it will all be back online later today.

I'll keep you updated.

Kind regards, Chris

--AsVN9amHdZCoj0WmLUP3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6292): https://lists.cip-project.org/g/cip-dev/message=
/6292
Mute This Topic: https://lists.cip-project.org/mt/81424532/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--AsVN9amHdZCoj0WmLUP3--
