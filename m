Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7407BC433EF
	for <webhook@archiver.kernel.org>; Fri, 13 May 2022 14:54:02 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.131])
 by mx.groups.io with SMTP id smtpd.web09.9296.1652453637253085716
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 May 2022 07:53:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=k6qNrZRX;
 spf=pass (domain: renesas.com, ip: 40.107.114.131,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctkogynlAhj+SX357hYUh3wQ20sq5k7o+EbiemsnIZEbzlqvV04p7xwFhUghF7LA0Y0ltU+VonDyYQV+Spya4tHNzovVB0wR+yLuylJGdjqQ79+reVnQa5tymLZ6b0ZuuDnsXeAD9AkWdOpvuxGI+rjsrwopVWbSyU1pyd3T+66uYJ7gjgl3QHoF+2YwRrQqLXRgkdYHPRD/+GQ2YSMhvIWP+o9zW3XAtIKIzuAl2x7d1/+LPZOEl4KSIBuDDLFuGTrLSLt3mazj28qY4P1yvpVgUhfRbSwblHP0UzDwOXcZdaHiSs+BeAV1YVXdl6opFyfDc5mthpwl6DZi/hNgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhrIVY+wyWzju15XzekyZrz7WeDReMITVuGBdZqIcFA=;
 b=UIwhQBzYIw2tsybygo5xADVRryszKtUN/4X4fiwZjp4caWl7ltlRrVCIzQCzC6IcVoNeeT8/KFuiygOgp571gaTdraUJF8TJkNn4OKW6dRmCD+cTql9O7XSD0/VnQiF7ys36Xv4rk8BUFhhzP24R/g8JsgYZlA/iFeK/+jrah2g6QOAmNW3ZiccIk9YRaDPEO8crKp4/qb3NIvl0HPo48xSQILOzuxyQtRzCdekrmOg3WQ3m3Xy+B1/ptZ1Cdm6BfN5dy5G/SRadURF5e+TMts7+dBZUqTyRMjeFhx2TH/8Rzx0MhBqN7bDV4sPHjSRgdcgr6qIb48SDGv7vhGXe9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhrIVY+wyWzju15XzekyZrz7WeDReMITVuGBdZqIcFA=;
 b=k6qNrZRXsMjC4QBC7o+DeMFiSUDkhdCwXJ4/cTplhhd84+PfFwR8nmoJjEL5PWBBxt1bgYfGm7v7HYo3a9R/7R5OzHV7q+UBPtx2u5GmfhsY1S1i7yq370pTjatnMIKsTNzrpPC8ictqCpjKnQn+90ss5O98lj7cCCRwKX6xlhg=
Received: from OSZPR01MB8124.jpnprd01.prod.outlook.com (2603:1096:604:164::6)
 by OS3PR01MB7384.jpnprd01.prod.outlook.com (2603:1096:604:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 14:53:55 +0000
Received: from OSZPR01MB8124.jpnprd01.prod.outlook.com
 ([fe80::9198:5a5e:9c13:9227]) by OSZPR01MB8124.jpnprd01.prod.outlook.com
 ([fe80::9198:5a5e:9c13:9227%5]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 14:53:55 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Reported 4.4.y-st issue from Flamefire #cip
Thread-Topic: Reported 4.4.y-st issue from Flamefire #cip
Thread-Index: Adhm2OLT+Fs885vkQvOuM9KPONRFSQ==
Date: Fri, 13 May 2022 14:53:55 +0000
Message-ID: 
 <OSZPR01MB8124B28C7339EF7B39CA6F87B7CA9@OSZPR01MB8124.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c82202a-ab6e-4a6d-21af-08da34f0671a
x-ms-traffictypediagnostic: OS3PR01MB7384:EE_
x-microsoft-antispam-prvs: 
 <OS3PR01MB738412CE323609525982D344B7CA9@OS3PR01MB7384.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 3jwhJ7eIQ8JLrJXsN1VfK1Jv+MZPD1ZwBT26xnbsiEW6DBNxBmOWqIRl3jZn5QFcr0B/6NQi9jKKQtegASGN/3gRgwY9JfrSDOYMlLn3GEIlhGl48ZU2MAMBcHI3D/CPGDt2h3R4hGRUvdVGGDnNVQegOOwH296qGJn1qHimjGPKqKzBTea5Hyj/ceW8kTGXGOZmErWJV6nQoFGZscdDc6LO6uZfZ1SCHoHznq5JviVC1HQJBnPAulUaxwJhk0Pxq62kxAaJV1yVnq/k6k0ejym449wOUHQ8HIFal2HsKAEU+cp5kt6fwmEo91H3c4BXq1v7tl8kgQ+NmvmZ6BQecRELtXdK1lRIIDgNiQlgAhEDr8dUddKm4VbenSZZWOFPAAxkDHc5raWwbdtFeoe9tv3kO5SiUASGHbnuDPkK5xqcEEYCFr8wJrvc9cqVBGqwhtFPiV2D9io+SbPUnskjKOBUaSoYltPynvD+Mc7n+PRAIxbNghBQ08TL00xsYioNAIn9NDRloqouvi9XRoiB4NOVto4oWlrRMAyDaUP3W6pZVmBGM4Q9sbxFwYmADccaQb7/67kh8hzfgfcm4K68brsXu9dol4Bi7R8DXKc4YRw2WyaOh26jwQhDbTM6Uk5O7ySeghTNsXOlbm17SKrPZTrwsX2K6q9GU9FZH0wujvmwIBa3U0lEwuugtjNp7fnUQyMkw2AkidAwd4EtBEDL2JBknAtNskKwlLcV5aGNGDKGGuteS6JQEJdBXW1vMG6cUtZs5uxZ4vOPp0D9wxGExv0b30kjyJLWiGblJw6Xekk9xeLPo8lCj0OlCRMMZhILVVWm/6RySyDyfv2TedoBkg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8124.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(38100700002)(8936002)(38070700005)(66556008)(8676002)(66946007)(66476007)(66446008)(64756008)(76116006)(5660300002)(52536014)(122000001)(26005)(9686003)(7696005)(71200400001)(6506007)(186003)(2906002)(55016003)(508600001)(966005)(316002)(6916009)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?UA5zZ4OPTMjRQkwuOUxbQZE1XT8ncIjrFD1YYw9qLiv4sGu/VG1zXwBNZP?=
 =?iso-8859-1?Q?0hAHwWxIv44VWy8K/vcW7N5svx7zTZCvRX9gRLkNY5Wz6CnF07Q9FfwB1A?=
 =?iso-8859-1?Q?ZYuuO9Yu0ec3QbON9LANV5lftgP8STR5nVuBuoD15N4/Swp7NKUFK4NPH4?=
 =?iso-8859-1?Q?LOG7S7onWBdfIeUVIgx0TEyO6cv44XdlGsmn79wZIFDV4Z/h3dWt9u5PhO?=
 =?iso-8859-1?Q?V0hPtUJ5t9DzD8rJRvSM/KcRsLPiZIBZ+L4RS+Ns4tSfpdMci/Cww0ngtG?=
 =?iso-8859-1?Q?KY79IB6hVBA9WcnQklxk1p6swQjAiU1ODyzzhD6RF6Rdze5uP5N4Xx9au4?=
 =?iso-8859-1?Q?kqKDZWMNXtv7EE9y6xX0tbjGY2i9NYIFre3jkf2CaW+ZvHK5jf3SZbUjkr?=
 =?iso-8859-1?Q?CtQw1MD3E4arEosnj8doAEbPOwGGSwGvMeNRk+XdUmq+VN/zxWZwBAEr+i?=
 =?iso-8859-1?Q?Kj73fzUpSfAWMKCspCchNVDdGthrKwDfhrEo5+yFxvEplXEQFBL1LS9vNV?=
 =?iso-8859-1?Q?mQwmAzDgZUuqd7+jCTnz0L6n2XjcVVPGGf1VOKmk0CpoqcgSjdEIFD2Br7?=
 =?iso-8859-1?Q?cZa7M5p11l0ejJQ5ZG28/VjgkiXmTKqoiOws2S6fOZXhu3LI2QVOeCFLs+?=
 =?iso-8859-1?Q?o5ImDFhd5m9bQMLDL49KePXorjQpbdSRzupAOOntFVYM1weejfghncRUif?=
 =?iso-8859-1?Q?gBXc1rRSGaRnxfkYmZFUFDOYWr5EE+6mVwBy4yBpchigzyjzsUnzAWm5wo?=
 =?iso-8859-1?Q?RKVZAe+vHabAHYSifpswW8BhRDZdUoq4xuAhinHyoVtfIEhrMSMsTs9ygx?=
 =?iso-8859-1?Q?7WnCPraaD0/T7lDYgOj4SWtY3xe3An+egnlTbboxse32gOKYEhgBY3P9qi?=
 =?iso-8859-1?Q?dJZiSVyE83Aul0ckEfXjPGG4bJaAZXUHRvgoekBdb/WqBZvKfiZAEtrts2?=
 =?iso-8859-1?Q?9lTFz1eAsewTCpHMl6PH6jkq4nVBd+TY1/69MMdTo9UgUHwMqHG4677CjM?=
 =?iso-8859-1?Q?TwEy3hL28rq99uOGl18/OnyzyAD7Xq2WB0nBZl01/d2gON7NGe/9kAC00j?=
 =?iso-8859-1?Q?fMZH08hcJgjiXEGHjGy4zbAScBMkIwnTdiueUGYr+gIVB1+ExV/ipJY4/P?=
 =?iso-8859-1?Q?5Uz1OnBdT3lWssFf4fCxB8rBm12tz4tKhG/NAQPs8vFw5Lf0ePdA2dFEAt?=
 =?iso-8859-1?Q?nRIQh81uya4UdllKYm0znrl/XGTob94N5UjHJgcUg39UJpCmbY8/Eo+rsc?=
 =?iso-8859-1?Q?Dn6LfH99yl0m2Z2NLWSXJ3PZtnPy3/WSfz026I39O84171Q2VkMdo6GglV?=
 =?iso-8859-1?Q?cFhC3suptzFDCWLiH5tPY0IozpP9S3gweYqMNkxpNuHmushmcu5FEsx1gX?=
 =?iso-8859-1?Q?r1IJiZdQ5vcJwEZ31nXKD49gd8x3DZssfa5kNJIvUBTNjgWZ+lWOiEGSAb?=
 =?iso-8859-1?Q?42bErnr1wP1a8FSOlpUS/WbMC5YBwkg/9E87/3cOj0+KuGu02eOt4qB08D?=
 =?iso-8859-1?Q?H2S9Wtch37gD3ji8TKVy/taRCmFMHGfhCmmQcSBvOGbTZtw3slUQ7ZJYr9?=
 =?iso-8859-1?Q?hfoLYfSAe3GmCBsP0X9V0PBAvR0A3ljYHgSf3IXlHvt1xLNOxFFdHIaIxZ?=
 =?iso-8859-1?Q?+i6PrXYFgrFbK5kHbUx2HQOeIubWbIP0trrhSWo2IydSRLg7c9CCuICYi/?=
 =?iso-8859-1?Q?Jy5ohc6GQ+nOk5WVpGCWFRdOL/FD6FgaDkRzVcEVdMlHz694OpLgrEfQBt?=
 =?iso-8859-1?Q?iDNPUhYt2hf+2Go3F4j2jC6mmI0xtMDQDH8H4XkTfndOYaKfcjmQzuB6ne?=
 =?iso-8859-1?Q?7EI5Nr4dNwfo1F4S7uHpCa8auFBXfJ8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8124.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6c82202a-ab6e-4a6d-21af-08da34f0671a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 14:53:55.2282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 kCV01MWxqU9C8nUJpougTEY1LTBsrOtdLh4hu4t4bdTyaR+fW0PYk2z/wY0F7JO0bAS3g1QFVOjkfq9HAvQbzD2n6x9AtkdjoZRM8P2pAAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7384
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 May 2022 14:54:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8345

Hello kernel team,

An has been reported an issue with 4.4.y-st on IRC.
Forwarding it here so all can see.

<quote>
Hi guys. I can't make it to the meeting(s) but wanted to let you know that =
a recent commit to the 4.4.y-st branch (and potentially others) introduced =
an annoying bug. Commit link: https://git.kernel.org/pub/scm/linux/kernel/g=
it/cip/linux-cip.git/commit/sound/soc/soc-ops.c?h=3Dlinux-4.4.y-st&id=3D7a7=
8bde1faa42e0057350378baf518a04b3bae58

The issue is that "val > mc->platform_max" check which would need to be adj=
usted by "min" as done for a similar function in https://git.kernel.org/pub=
/scm/linux/kernel/git/cip/linux-cip.git/commit/sound/soc/soc-ops.c?h=3Dlinu=
x-4.4.y-st&id=3De41846dbe6f49d305c1a8fc229c5deabd66e3e24

Others already did that (e.g. https://github.com/baunilla/android_kernel_xi=
aomi_rosy/commit/969b9d366c1e9564e173aea325ec544dcd7804ff) but I've only fo=
und a mention in the kernel ML but seemingly it wasn't resolved

This bug (in short) e.g. leads to wired headsets being unusable on phones u=
sing this kernel. Due to the to-eager check the mic volume isn't changed le=
ading to a feedback loop.
Hope that helps.
</quote>

Thank you Flamefire for reporting!

Kind regards, Chris


