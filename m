Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25173C54E49
	for <webhook@archiver.kernel.org>; Thu,  7 Mar 2024 09:41:59 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.73])
 by mx.groups.io with SMTP id smtpd.web10.19609.1709804515231852474
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Mar 2024 01:41:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=iWqM8OCD;
 spf=pass (domain: renesas.com, ip: 40.107.114.73, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsGKXZm3pOfkUm8njFv8XuoEEAb4r1IJqUic9jQY9t4SjYR/A19A3PseFOabsGrY+og3vom0ggbA048MrIaDQrUq0uZrkWqkB+u9OnrIKVujevHaaW2W9xagU3Rr8zbzpSYWY5M3nUQX3hNTmnOFb7O9p6UKXxlod2rfx+P+pwG/Q3uNnawqOpiHHI47N8byE6yYt/EqVE+QVmRqg7YjPh3FzdcnFYB/MNnaryUxKou0p74eNi4dvWFtSN+mX3IRjFhDNlU64rtOYyXxkSwNJ4ETw6Dj9FkP6lZ87jiYC5gWCXQekip7S+98tMG8OF0M91m5HaKviH7X4abzRfHFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWc4XsQSG/Hlfiz36tM2+ZT/6fekYUpNaAYPGN7c6JU=;
 b=ex+ZmvYHg1zAIbjiXvlrHI3U8gC+FcUKDMMkf2H9/LZS6V8TWDk4qy1lsqxrfTKPptxm054mu6b32oiLvnRLuU/b3C2a9zmU8k2tYGB0heR6sJ+HpyTLc456N2WKTb7Lcl9iWlNfFXzJONLlZBOnBUuDaR9rzDZVjgmPQWU31lT6FFUqHnpQm02jNQTyw1zK6eGfUFQ9WLupSzaw1sA0ikvzXXo3P2h8BasJy1Yq6v8NuXWvKLaCWsDiftHZgwwzX5SoiDO44qfq4uS/QEDi6CrrsQ3+LQvetO4LrnGv/f9CEXidZJo+oklw9l3fTmfRqHQi+2GjnRrEVWzHYIPHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWc4XsQSG/Hlfiz36tM2+ZT/6fekYUpNaAYPGN7c6JU=;
 b=iWqM8OCDWmeWwGaAOxij5qA9YQWtU+Yh41Md9GLdqXADm2Tus4QUahOLH2BSTvq1WnHJzm23Urw37Ye5LT2hzgpI3IJPCTVyucKOoXxwseTiS3RoCJYCzNLtmdS8XKMx8Y3n/sgQ05Bx6dU9xJCLqu6SLiD1j8O5bociIY3Q8GI=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYYPR01MB6841.jpnprd01.prod.outlook.com (2603:1096:400:d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 09:41:51 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::ec68:1357:d0c9:ad1a]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::ec68:1357:d0c9:ad1a%3]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 09:41:51 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [ANNOUNCE] 6.1.80-cip16-rt9 (rt26)
Thread-Topic: [ANNOUNCE] 6.1.80-cip16-rt9 (rt26)
Thread-Index: AQHabZ460MDXeuRbBEenStzNrlJyjrEsCOww
Date: Thu, 7 Mar 2024 09:41:50 +0000
Message-ID: 
 <TYWPR01MB118622D55E6FDB034EFF8C661B7202@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: <ZeTKvaCqyhOOkjWg@duo.ucw.cz>
In-Reply-To: <ZeTKvaCqyhOOkjWg@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYYPR01MB6841:EE_
x-ms-office365-filtering-correlation-id: bd04d00c-c456-41e0-d60b-08dc3e8ad0e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 XInYVsMSZtdkVF562Q3gd9AXH1/2kwNFV+z7zcoPIzqOVjSfq1OGculZzKo0uLATryJ6URUoDXbd6RDDMqDcdS6yDCFsyeRE9wiEnmTHR7h5XHhrW6ijAP7dVFX/L/M2YMC4MmJL04vRlh52Mo0STZip92nLP38CXjqYri3Kw/Dw3jumBzVKxqoRAtMbA5XSClGPCjfIg5OS3tsJZc8u0N5e+c8SbxNhienEhXgwVSYL1vp1dIqMosspAUhxrC7sJYkPmqYujj/Ce6yWY3cvcFM21vTW4WQWtZWMmNSLy75vBz2m6qYtNVUti+4s2iXEyv++Dzsy0RZH714KoHmcRpJ6iIQEiTy+xTxOBPgLd7F3bTVnRf/mNW9rD00kSbnQPY13lFeKQAjpBEOQrwF6NLYRpMvJFjImMUXBXtXn+TRc2WjgVO5ydd1r/CtfS9kUGq3H480IJZfIPcgiTX4wsPHR7+LNGAm9FcN9Q0wECfiIQwANCEZUOU0obGwN4+M6lAjlIQt8B1znTbfBW5Zc7RlgVI97dRtelI02pt5v8TBIAxJ1EG+1orimHnF1YF7uvtneuDCW04wY1Lh+x8VKwNBhb0ZoGhcunJidF7+sLLdr46iATVVpS1Hq49O5+C5a++eKGUfIVZ88rGNElrSFrm0ddt2fPspQYc/pwPUSLo4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?NNZeCEwrMt+nIWlNtNfF1zHMsrQSBJ0EglhQn536ISrTY+gZPvsnK3iE?=
 =?Windows-1252?Q?LFqZRrnj+Hg4C6xu8Zd7w/6avmoawf+eKgTvJfXxsBXvUMdkniTUQJvD?=
 =?Windows-1252?Q?6myZ5deweLaSPOvh58Wf7TsfBNxKfu2moPCPYBQdnov0YEEOB+X5Ud/X?=
 =?Windows-1252?Q?ZGGTMVyaReCUR+St12AfhPUMTXHCEkbySdYYA/m4gaoKowz1MKLL04xX?=
 =?Windows-1252?Q?nfIpgZa+sCx1XQxmaHmE178XKeqXwiOjNGCLlmCm6XqtUX2JAyJ5+HcY?=
 =?Windows-1252?Q?bLAwGsd+haPtw61wJPrkfzDDrY4MP8uy0REbfvcz3BksnZa9ixffd0xp?=
 =?Windows-1252?Q?C6uZzxjJreW/UVeE5xoir/7wwDp3WEY42R5pcOVQnBEsbNERFyQlhxfX?=
 =?Windows-1252?Q?cjzczQQtX7QIQ7z6NLbjW5McqwSTeMCQabwBveTcRFRNN+UTCdxJ34Zc?=
 =?Windows-1252?Q?sR5N238bxyQPQ4kbT2hCiJ9MSiaZfNArrtNxpLzBoacuVqSTY7X/ipOU?=
 =?Windows-1252?Q?vEAOyLW9C0Cj/ImGU47f2uhLkkfkffJw83dutOp0b4AalnJogagzBbpG?=
 =?Windows-1252?Q?FvPGViopvsTRtto7MTiCiVzOmXEpaLEpfmTCki5N2Sm9UeMW7cXczUP7?=
 =?Windows-1252?Q?84eIBcVa2MJjVpccO/nhafEJJhGjxRNbEDsxoutZ7EH5G9BBukg44mox?=
 =?Windows-1252?Q?nBt8iI9tLqOwpmhvgxUjzrHpUdtr5FF6x7lBo/Egtg+WTJs3U2Y80CAj?=
 =?Windows-1252?Q?JqtxweBtaeZ302ns+BXqP3tdFYmOK80DfJKlAmqhXRvpQyfoqa4nkFDT?=
 =?Windows-1252?Q?oE4gRhLkr/u0Eh+VZJAY05jrh9kVlVt9F1K5TxFWcjKGSToX+lWvL9N5?=
 =?Windows-1252?Q?+j7XQNarDSrYCnIOMytgVnvyaCznalUgzjh+ZQm4DgXANmt1I84xzIeO?=
 =?Windows-1252?Q?I67XvTGssRkOMkSHuXLRyRVekeJzhPYLKCcXyaFAT2ZBltkMVSgeV/TW?=
 =?Windows-1252?Q?GsoEa05JMY7OV6O8UjNdRPOZNYHhOUPLFkrtCTwUgTGDf4UW7ZLWEU0Q?=
 =?Windows-1252?Q?JpaJsZFetuFH6aHVjAVH0ahrv3IRmc/4TaccDIwSdRQVJZs6KfwySg2x?=
 =?Windows-1252?Q?oP7UOXtEvDTIBytl932QB8QvJqDx7e9mlua76PfMfCElO/BcgG1q/JAW?=
 =?Windows-1252?Q?hanQssyIVWPkodYaQu3XNUD1Ep90sAiowoUZaIszPWtcmaB+z7sAFQbq?=
 =?Windows-1252?Q?VFmP6HEUkVmtJ5r9axjsla+3seKSh7nZoXGna7v3QRCQDyxMiBSXBvua?=
 =?Windows-1252?Q?j2b4936Mt2ZmjvhZ2M/7/QT+Rl5VR4nFLhvQ27HBCWuLxS3aQ/Uaq44V?=
 =?Windows-1252?Q?sKYAq2u538Z2Ld2MEFuSbCTuY+HngwttQU2KzBXfeVHJZXeJSepvdis+?=
 =?Windows-1252?Q?0FjLfrNi4azREAszccTVVdlF23KBJCT/SD9u7o54brRZeSQtkjgibJCb?=
 =?Windows-1252?Q?kfDUVUe6H2q36rJG7oEiiu8NTlpDLGZPB7C3jIZV3EPFZ4ANw8O8IHM7?=
 =?Windows-1252?Q?6UYKJHzMMI3az2pEGGmEfhh2xA2iVr1ctu6X0yd/bnDnWUVXKATlPRgn?=
 =?Windows-1252?Q?MM50HVbLA6NqRAi1I5xk7iQ0jMBwAsEYV8yEQ62EUqY/cdEhtr1rtYVC?=
 =?Windows-1252?Q?DABoC61GDa/BGNUpyyrUaOjIxdQDXmcmRuKGwmuPP5XCqBzCnAmmiQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd04d00c-c456-41e0-d60b-08dc3e8ad0e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 09:41:51.0623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ZIgFfYBVY6zJqjzJge3X4lkja6Wn855zr7KkZXd+khFR3MK8cqoaKEquLV9y9zThZX7pho3l/kP1YGsukvfl3UUNaea9hyxcKmUkIp7vDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6841
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Mar 2024 09:41:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15262

Hello,

> From: Pavel Machek <pavel@denx.de>
> Sent: Sunday, March 3, 2024 7:09 PM
>=20
> Hi!
>=20
> New realtime trees should be available at kernel.org.
>=20
> Trees are available at
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/log/?h=3Dlinux-6.1.y-cip-rt

Test results:=20
- Dashboard: https://squad.ciplatform.org/linux-cip/linux-6.1.y-cip-rt/buil=
d/6.1.80-cip16-rt9_b5450675e/
- Summary: No new regressions

Kind regards, Chris

> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/log/?h=3Dlinux-6.1.y-cip-rt-rebase
>=20
> And their content should be identical. There are also tar archives, at:
>=20
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
>=20
> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

