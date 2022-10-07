Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C846DC4332F
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 21:17:43 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.92])
 by mx.groups.io with SMTP id smtpd.web10.108.1665177459114718895
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Oct 2022 14:17:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=RroHgK9c;
 spf=pass (domain: renesas.com, ip: 40.107.114.92,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqyFNhLSqUqYGxjj2ul2abvRDyIx4Y4yLsB8ewbqgPC81h0IIKxQp0hRIVhdccdlfJ+Ac7m7gqA6anEkL031/EcHYwx5f8edfItuoamhWojNec0b5cjG8dncKWwe2foeC6FFRU3P553O7PfBqYZJr5cB/5W7NF/TrGrrVfYIFIU7PYPp+5wjNBqebIiUFkA+fC2D6WxrudRlDmpfXjjhoU+wHxoaxJqIMtiV23zMZu3Od/fYBynGDl3SeNTzyMdVy05viblCDNgVQk5ZnO04Hy6NtJne+xlTuXb7k/rYp0cJvijUj3xeR+WeBsMtdzYT0GJm9mOdq1rLyKnDvdwQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R79wNE5zzAE0St555Yg8pk+afN+KxWdXoBPPAN13C5E=;
 b=S4tGQ5mS/j7HuXSuH0rnFj/svJDiUjbW49yjn7bAI6/Q9J+SxjzC+5lK1wbnu3oWSffQx/Ubp39cXYG3zoo9vM6ivFBwhUX5yaC6gflV3wyGDHdWcEnH6mslXBiz0AjirZ4hpiY1IDjiAveILQSiuqJCWhnbCP4MK2v756xOVRFAzf99uh4lX6FUJ2cizj5tFQc4EL3KF0jZE1VXZAuBDVYcfsVt4vw2ZXhELfgHbXp3XPFEu4dsnnU2yMKhdljVm1w9VN2YaEYJP/xJQX0Hoc24aI5zq57GRtLI1eSKjCrkSlwEhF7Z0MotMTuvz2+7gsa32HlKFT7Kdkll2Pd/eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R79wNE5zzAE0St555Yg8pk+afN+KxWdXoBPPAN13C5E=;
 b=RroHgK9cJawkSBADuq7db0LEVK7Athv9wHOX52qYGLaG7KmuaAhGvYylUXncd8IXAdM7vkWT6dxiRADYC0I3XsndUhUV6OOd09EmO/chNZrTW9bYZEgOmTSbVIHsk+wJTfZKCeyr1efC4USmjMh1cGXy+RmDl/Ryt6K5NWvXVms=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by OS3PR01MB10201.jpnprd01.prod.outlook.com (2603:1096:604:1e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 7 Oct
 2022 21:17:34 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::f7f4:7059:2c92:75ab]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::f7f4:7059:2c92:75ab%7]) with mapi id 15.20.5709.015; Fri, 7 Oct 2022
 21:17:34 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "pavel@denx.de"
	<pavel@denx.de>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Ulrich Hecht <uli@fpond.eu>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: linux-cip-ci: risc-v build support
Thread-Topic: linux-cip-ci: risc-v build support
Thread-Index: AdjakZ25SCnHA75BRHaLkmlwBK2OLg==
Date: Fri, 7 Oct 2022 21:17:34 +0000
Message-ID: 
 <TYCPR01MB1058868A328ACC0B62A05E2AFB75F9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|OS3PR01MB10201:EE_
x-ms-office365-filtering-correlation-id: 5e323ae3-39f6-465b-0bdf-08daa8a95a28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 SD5F07rGTruAyeDOq1sJfd+jTnLVJtOQVPUXqPVBVW3r/y4JOE7Mg/+OtTHOhiYsF1Y03e757rzVxATo00dRp4Q0eMODdAA66btjaAliPlc2Wp2ke6rgxVxR5i9T+J3a+dNhrnfuhMSvn4TF267t+VOPd6BV1n+urohcKB+QnpQBKmfOCOc8vZ6Zyuvvxg50xsgJ/AD4T2nk7TVozwWL2M34Yr3KtWNC8wOj6p4WT8XB0KVRqj9LE2UfQT19MdLBdZtxY3aSk+U83MTofcb2nomS8l7Tfu2bRXD817deLwAPUg0Mye+42uGh0uZWudt+uAWRoh2ExmY/zBoze3xx9RQZNggPeFA6b1forKoG8vwDbqIbYHDjntMo4KoGfFgZ3FG78CL877x5MFtlQ/bGchJDL4v2+NQBkwbA5oIeO9qgvX47JBW+EUCoYLeeWU5eLbw1LT3vC5MveXKOOA0pMQXwoZhtaslimwGVRJxU6OwcM+Yj1EKibmsTfWVILJdZAgW0Vs4a8u6+J8kFzRUZxZ0cuCaNl43ZNxYNJkPn2Nz3QcNnHDjQ3AJb8jqPdEGtBdjitJtznejrbSyKWNii37soJa9RbcZoRUV2s2FT4fAYx0KNPJEE1SEVChpknmMn2dlHpnY03l1NrraSS733BHNBxmKgeHopj40TpV7sjZSkpeikTT9GHIDgX3ECrgI4PMhDMQ1XM4Mm9qgpVEsqfNvF0VQneDiVgNsI2PK2oDlcEUIVWTADDp7CbgZY3P329pBA1aB3a33aJE7AiYFfaUeigcQHj/dQr5CxZ3hSNYf9LV4SuXMQ3HM0vz7Cia6LrkU/bHxY2iQ0f+vhCoiRNA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199015)(66899015)(2906002)(316002)(33656002)(4744005)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(86362001)(478600001)(110136005)(5660300002)(41300700001)(52536014)(8936002)(71200400001)(966005)(6506007)(7696005)(186003)(83380400001)(38070700005)(122000001)(26005)(9686003)(38100700002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?mpUl9YWOoBXBA8rB3haTyMy1sY3it2IjR6wUUx8yTqo/LZ5/wYGYcPYgIN?=
 =?iso-8859-1?Q?k1mOFOv5YtqVDj5wPdIUfC1cQw/PF6nZF1S0CxX+5AmV8DSrxMjWM9Y3hL?=
 =?iso-8859-1?Q?m73mkxDNjwKi8ufG3Mly4A/OlhBkYAfJZJ1dgzsJA4Th7NH2zkMGXb5A3o?=
 =?iso-8859-1?Q?pqMXDBr9rU34+GZTGZvCgXV60EXrflZGD2CR9OBsqX2zVeNIkXXSnpgLPx?=
 =?iso-8859-1?Q?+VFwnQ2/5I4Il0MKIMwWGIlprHl1R5I1u7pCJrDBNN32FL9A8gYebHsOay?=
 =?iso-8859-1?Q?QJbheG1gKi+vE2jQgw8z7cDeeKc2JpA98rOcNa8ItE7DRuZfpojAz/RdXi?=
 =?iso-8859-1?Q?6lso95Q7Hn3ptpQfXPs8nyiGcsaHAfQMqW5BQp5ASHGWeJHQ2527bWebkD?=
 =?iso-8859-1?Q?wsDT9M/MM1zeEQeF0CixxQzhre01bS6NKk8GKUMXtuKystzAXZ0lmj8tfT?=
 =?iso-8859-1?Q?gnD6z9jCqL1y2NClJJ9ym4N4C+8D3iLLk1BGoGYlAVUVFR12As0WLVrJav?=
 =?iso-8859-1?Q?5u6ZkgqWCIN7DfeyJrnOzbCH+bXP+BLKehK/hE9GKNF8/rMRuuiR0GAX1Y?=
 =?iso-8859-1?Q?OL+jGOg8e3iPipXZBxCDUwYL4h/ZIPnq/wdI4L2LZcxmVWZ4JKPEEU/V6T?=
 =?iso-8859-1?Q?YXtxXCtq0DeoOYRT2tDaIoI2fddSoxyxsbk//WS0ySQtF0iAk9IxwtJEtM?=
 =?iso-8859-1?Q?33iv1v0vELwurkmWRpiED+3SHu7mmA8guIju9JSvl1Y9C3KQ9mq0XHIogU?=
 =?iso-8859-1?Q?8An+ENSiW2tV6KOMm+4oNawiy5yR7ucrDKOFOtEvlJXLfa+A6sNHD6rvxw?=
 =?iso-8859-1?Q?PR0SKWtQ36qQs/4uXgVbdDw6fmyzkbYVMblsfPz1zL16LtYxogFNhkvCZz?=
 =?iso-8859-1?Q?pl99dbWFUiZmoYfUZL/Snz40x1gP2na/Kp/gqCr41wlCASqet4eeRBMYOL?=
 =?iso-8859-1?Q?luSvbsCLFyUB5E8H6olCeFj5wy4vG3O4Ph9mgtz/ARMWZ4Vonp1jCvlKk0?=
 =?iso-8859-1?Q?n7QhpsufkrCIyQLCQ6s6hFGCIkFV8Jk7t5QIZXOJCXXWTIb6xkraa/iMXO?=
 =?iso-8859-1?Q?HQ3rIwgyykP6pi9GGkDCOqDMaGZ/JxgZAQBanuhnOXHKnItYsKwFkgaOo8?=
 =?iso-8859-1?Q?aJv1Far5prlJwUF03yhzqBNHWY/8pa+Ssd5dP8ijvP/pMbqHIWijCJuw8/?=
 =?iso-8859-1?Q?/U9fpDJkEfckpqi8n1qUQ/Qj1fyV0Sg45TQgAU0qa/2oOdNmTlGsd0sFQi?=
 =?iso-8859-1?Q?QKPY6zipB3eFoECU/etyWgU6pNZNkt2cw+BP8eKUicsFDw4f64hg7qMHLq?=
 =?iso-8859-1?Q?RO16LTxgqYl8O88K0lzqDkX2uzXzELekTLIQ0gd+TOAihGk3jg48qs6dz9?=
 =?iso-8859-1?Q?XoWQaLqhAewfAma7gA//V606RzPdaAYM7lh59Qtop7M8wEXfHfouxINsM7?=
 =?iso-8859-1?Q?rJblwZVFzUMq20uVRPNKBM1o0GVxlx2DLe9JnOqIjAAw3mKLQ7NYrJwljW?=
 =?iso-8859-1?Q?Rs8uBrW9NKwFEJcIMHmuJF6gMqw4pfb1dA6kOChFeuW8rfuiqkTfk/rSBk?=
 =?iso-8859-1?Q?HdaufnVpNATbyL303ofti5j3Mkd8z799r557CFCxASZgiDXcd7dfz3EsOM?=
 =?iso-8859-1?Q?nwrDOI4IoGGUNUPaKsZPw6hVRiEOPqXuIbd3mGS8OoU+EhJeRIQK1u2g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5e323ae3-39f6-465b-0bdf-08daa8a95a28
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 21:17:34.1547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 zxqjKKzEGfD4CH5ZfC9LEX8LBvIyPlFpCD2VDBv8RWnVNQYgfKugj5kEqh56zg6mgF3uCmIPGM0VH4Y2Zt7+FZDxLVP06bRtfoNQ5WoTfYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10201
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 21:17:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9696

Hello all,

I've fixed the CI issues we were having when building containers now.

So I could test my MR to add risc-v build support [0].
At the moment I've added a test job that builds the linux-5.10.y-cip kernel=
 with the risc-v defconfig, and it seems to be working fine [1].
Builds are using the Debian bullseye gcc-riscv64-linux-gnu toolchain.

Please let me know (ideally in the MR) if you have any feedback before I me=
rge.

[0] https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/merge_request=
s/58
[1] https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/jobs/31442973=
26

Thanks, Chris


